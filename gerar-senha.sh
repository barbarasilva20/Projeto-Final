#!/bin/bash

# Definir conjuntos de caracteres
CARACTERES="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:,.<>?/~"

# Essa linha gera uma senha quando o script é executado
senha=$(cat /dev/urandom | tr -dc "$CARACTERES" | fold -w 10 | head -n 1)

if [ "$1" = "-p" ] ; then
  echo "Senhas geradas:"
  cd senhas
  cat senhasgeradas.txt
  cd ..    
elif [ "$1" = "-h" ] ; then
  echo -e "Bem vindo ao password-generator! Versão 1.0, (c) 2025, Fulano de Tal,DIMAp, UFRN
Uso: ./password-generator.sh [OPÇÕES]:
Opções:

-p : Listar as senhas geradas
-c : Limpar as senhas do arquivo passwords.txt
-h : Exibir esse menu
-t : Criptografa o arquivo onde está as senhas geradas
-d : Descriptografa o arquivo onde está as senhas geradas
O comportamento padrão do script é gerar uma senha de 10 caracteres minúsculos."

elif [ "$1" = "-c" ]; then
  cd senhas
  >senhasgeradas.txt
  cd ..
elif [ "$1" = "-t" ] ; then
  cd senhas
  openssl enc -aes-256-cbc -pbkdf2 -in senhasgeradas.txt -out senhasgeradas.txt.enc
  rm senhasgeradas.txt
  cd ..
elif [ "$1" = "-d" ] ; then
  cd senhas
  openssl enc -aes-256-cbc -d -pbkdf2 -in senhasgeradas.txt.enc -out senhasgeradas.txt
  rm senhasgeradas.txt.enc
  cd ..
else
  cd senhas
  if [ ! -e senhasgeradas.txt ] ; then
    touch senhasgeradas.txt
  fi 
  echo "$senha" >> senhasgeradas.txt
  cd ..
  echo "Senha gerada: $senha"
fi