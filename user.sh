#!/usr/bin/env bash

echo "=== CADASTRO DE USUÁRIO ==="

# 1. Prompt simples
read -p "Digite o nome completo: " nome

# 2. Prompt com valor padrão (usa 'User' se der Enter)
read -p "Digite o nome de usuário [user]: " usuario
usuario=${usuario:-user}

# 3. Prompt secreto para senha
read -s -p "Digite a senha: " senha
echo "" # Quebra de linha necessária após o -s

# Resultado
echo "---"
echo "Usuário criado com sucesso!"
echo "Nome: $nome"
echo "Username: $usuario"
