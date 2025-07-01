
# 📘 Sistema de Gerenciamento de Dívidas

Um sistema Laravel para gerenciamento de dívidas entre usuários credores e seus respectivos devedores. O projeto inclui controle financeiro de títulos, relatórios de recebimentos, e uma hierarquia clara entre tipos de usuário.

---

## 🚀 Instalação

1. Clone o repositório e acesse o diretório do projeto:

   ```bash
   git clone https://github.com/FerrLeonardo/T-NGC-1.git
   cd T-NGC-1
   ```

2. Instale as dependências:

   ```bash
   composer install
   ```

3. Copie o arquivo de ambiente e gere a chave da aplicação:

   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. Atualize as dependências no container Docker:

   ```bash
   docker-compose build
   docker-compose up -d
   docker exec -it test-ngc-app bash -c "composer update"
   ```

5. Acesse o sistema via navegador:

   ```
   http://localhost:8000
   ```

---

## 🧑‍💼 Tipos de Usuário

### 👑 Usuário Master

- Pode cadastrar, editar e visualizar **todos os credores**.
- Tem acesso total a:
  - Todos os **devedores**.
  - Todos os **títulos financeiros**.
  - Consultar as dívidas de um devedor pelo **documento**.

### 🧾 Usuário Credor

- Pode cadastrar:
  - **Títulos financeiros**
    - Valor (R$)
    - Data de vencimento
    - Taxa de juros ao dia (%)
    - Descrição
    - Devedor
    - Data e valor de pagamento (caso já tenha sido pago)
  - **Devedores**
    - Nome
    - E-mail
    - Documento (CPF ou CNPJ)
- Pode visualizar:
  - Todos os seus devedores
  - Suas dívidas (títulos)
  - Relatórios:
    - Valor recebido
    - Valor pendente
    - Valor atrasado

---

## 💡 Regras do Sistema

- Um título **pode estar vencido ou não**.
- Um título pode ser **marcado como pago** a qualquer momento.
  - O valor pago é calculado com:  
    `valor_original + (taxa_juros_dia × dias_de_atraso)`
- Um **devedor pode dever a vários credores**, mas **os credores não enxergam devedores uns dos outros**.
- Se o documento de um devedor já existir no sistema, ele **não será visível** para outros credores além do seu original.

---

## 🧩 Recursos Laravel

- 🔐 Autenticação com múltiplos tipos de usuário  
  → [Documentação Laravel Auth](https://laravel.com/docs/10.x/authentication)

- 🚦 Rotas nomeadas e protegidas  
  → [Documentação Laravel Routing](https://laravel.com/docs/10.x/routing)

- 🎨 Interface usando Blade  
  → [Documentação Blade](https://laravel.com/docs/10.x/blade)

---


## 📄 Licença

Este projeto é licenciado sob a licença MIT.
