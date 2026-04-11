# 📦 AdianteDoe+

> **Doe o que não usa. Receba o que precisa.**  
> App mobile de doação de itens entre comunidades — simples, rápido e sem cadastro.

---

## 🎓 Contexto Acadêmico

| Campo | Informação |
|---|---|
| Instituição | Centro Universitário Internacional UNINTER |
| Escola | Escola Superior Politécnica – ESP |
| Curso | CST em Análise e Desenvolvimento de Sistemas |
| Disciplina | Atividade Extensionista I – Tecnologia Aplicada à Inclusão Digital |
| Aluno | Angelo de Souza Treptow |
| RU | 5154447 |

---

## 📱 Sobre o Projeto

O **AdianteDoe+** é um aplicativo mobile desenvolvido em **Flutter** com backend em **Firebase**, criado como projeto de extensão universitária com impacto social real na comunidade do **Bairro Morada do Sol, Ivoti – RS**.

A proposta é simples: qualquer pessoa pode **publicar um item para doação** ou **entrar em contato com um doador** diretamente pelo WhatsApp — sem precisar criar conta, sem chat interno, sem complicação.

---

## 🌱 Objetivos de Desenvolvimento Sustentável (ODS)

- ✅ **ODS 11** — Cidades e comunidades sustentáveis
- ✅ **ODS 12** — Consumo e produção responsáveis

---

## 🎯 Objetivos do Projeto

- Conectar pessoas que desejam doar com aquelas que necessitam, de forma simples e segura
- Conscientizar a comunidade sobre o impacto das doações na sustentabilidade
- Promover o consumo consciente, evitando o descarte de itens em bom estado

---

## 📊 Pesquisa com a Comunidade

Antes do desenvolvimento, foi realizada uma pesquisa via **Google Forms** com moradores do Bairro Morada do Sol para validar a proposta.

| Pergunta | Resultado |
|---|---|
| Faixa etária predominante | 18 a 24 anos (32 pessoas) |
| Usaria o aplicativo? | **67 disseram Sim** — 34 Talvez — 16 Não |
| Nível de conforto digital (1–10) | Maioria entre 7 e 10 |
| Impacto social percebido (1–10) | Maioria entre 7 e 9 |

> 📌 A pesquisa validou a proposta e embasou as decisões de design — especialmente a escolha por uma interface sem login e com contato direto via WhatsApp.

---

## ✨ Funcionalidades Implementadas

| Funcionalidade | Descrição |
|---|---|
| 📋 Listagem de itens | Veja todos os itens disponíveis para doação em tempo real |
| ➕ Cadastro de item | Publique nome, foto e WhatsApp do doador |
| 📸 Upload de foto | Selecione uma imagem da galeria (opcional, até 5MB) |
| 💬 Contato via WhatsApp | Abre direto o WhatsApp com mensagem padrão e DDI brasileiro |
| ⏳ Expiração automática | Itens somem automaticamente após 14 dias |
| ✅ Validação de DDD | Aceita apenas DDDs brasileiros válidos |
| 🚫 Sem login | Nenhum cadastro necessário para usar o app |

---

## 🏗️ Arquitetura

```
lib/
├── main.dart                  # Entrada do app + inicialização Firebase
├── models/
│   └── item_model.dart        # Modelo de dados do item
├── services/
│   ├── firebase_service.dart  # CRUD no Firestore + limpeza de itens expirados
│   ├── storage_service.dart   # Upload de imagens no Firebase Storage
│   └── whatsapp_service.dart  # Abertura do WhatsApp com DDI brasileiro (55)
├── screens/
│   ├── home_screen.dart       # Tela principal com lista de itens em tempo real
│   └── add_item_screen.dart   # Tela de cadastro de novo item
└── widgets/
    └── item_card.dart         # Card reutilizável de cada item
```

---

## 🛠️ Stack Tecnológica

| Camada | Tecnologia |
|---|---|
| Frontend | Flutter (Dart) |
| Banco de dados | Firebase Firestore |
| Armazenamento de imagens | Firebase Storage |
| Backend | Firebase (sem servidor próprio) |

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- [Android Studio](https://developer.android.com/studio) com emulador configurado
- Projeto Firebase criado com Firestore e Storage ativados
- Arquivo `google-services.json` na pasta `android/app/`

### Passo a passo

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/adiantedoe.git
cd adiantedoe

# 2. Instale as dependências
flutter pub get

# 3. Inicie o emulador Android
flutter emulators --launch <nome-do-emulador>

# 4. Rode o app
flutter run
```

---

## 📁 Estrutura de Dados (Firestore)

```
items/
└── {id}
    ├── name       : String     — Nome do item
    ├── phone      : String     — WhatsApp do doador (com DDI 55)
    ├── imageUrl   : String?    — URL da foto no Storage (opcional)
    └── createdAt  : Timestamp  — Data de criação (item expira em 14 dias)
```

---

## 🔐 Segurança

### Firestore Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /items/{itemId} {
      allow read: if true;
      allow create: if true;
      // Só permite deletar após 14 dias — impede deleção maliciosa
      allow delete: if request.time >
        resource.data.createdAt + duration.value(14, 'd');
    }
  }
}
```

### Firebase Storage Rules

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /items/{fileName} {
      allow read: if true;
      // Só aceita imagens de até 5MB
      allow create: if request.resource.contentType.matches('image/.*')
                    && request.resource.size < 5 * 1024 * 1024;
      allow delete: if false;
    }
  }
}
```

---

## ⚖️ Conformidade Legal

| Lei | Status |
|---|---|
| LGPD (Lei 13.709/2018) | ✅ Coleta mínima, consentimento explícito, expiração automática em 14 dias |
| Marco Civil da Internet (Lei 12.965/2014) | ✅ Aviso de responsabilidade exibido na tela de cadastro |

> ⚠️ *O conteúdo publicado é de responsabilidade do usuário.*

---

## 🔮 Roadmap — Próximas Funcionalidades

- Login e autenticação de usuários
- Chat interno entre doador e interessado
- Notificações push
- Sistema de avaliação de doadores
- Edição ou exclusão manual de itens pelo usuário
- Política de privacidade completa
- Cloud Function para limpeza automática no servidor

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos como parte da Atividade Extensionista I do curso de CST em Análise e Desenvolvimento de Sistemas — UNINTER (2025).