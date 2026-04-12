# 📦 AdianteDoe+

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![License](https://img.shields.io/badge/licença-acadêmica-green?style=for-the-badge)

> **Doe o que não usa. Receba o que precisa.**

Um aplicativo mobile de **doação e reutilização de itens** desenvolvido em **Flutter** com backend em **Firebase**, criado como projeto de extensão universitária com impacto social real no **Bairro Morada do Sol, Ivoti – RS**.

O diferencial deste projeto é a simplicidade intencional — qualquer pessoa pode doar ou receber itens diretamente pelo **WhatsApp**, sem cadastro, sem login e sem complicação.

---

## 📸 Interface do Aplicativo

<div align="center">
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/1ca1d36d-a521-48d6-b060-3953ea46cf90" width="220px"/><br/>
      <sub><b>✨ Demonstração</b></sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/d84caa8f-fb2f-44b1-a4a0-11973d50103e" width="160px"/><br/>
      <sub><b>🏠 Inicial</b></sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/09d35c5c-ea39-4e6b-bb83-603940c73a7c" width="160px"/><br/>
      <sub><b>📝 Cadastro</b></sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/162683bd-273c-4580-ac6e-7b9a298bc8a5" width="160px"/><br/>
      <sub><b>✅ Preenchido</b></sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/cbe1b4f4-4e40-4115-afc3-48c5203f7c07" width="160px"/><br/>
      <sub><b>📦 Itens</b></sub>
    </td>
  </tr>
</table>
</div>

---

## ✨ Funcionalidades

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

## 📲 Download

| Versão | Data | Download |
|---|---|---|
| v1.0.0 — Lançamento Inicial | 11/04/2026 | [📥 AdianteDoe.apk](https://github.com/AngeloTreptow/AdianteDoe/releases/tag/V1.0.0) |

### Como instalar

1. Baixe o arquivo `AdianteDoe.apk` pelo link acima
2. No Android, acesse **Configurações → Segurança → Instalar apps desconhecidos** e permita a instalação
3. Abra o arquivo `.apk` e clique em **Instalar**
4. Pronto — sem necessidade de cadastro, é só usar!

> Compatível com Android 8.0 (API 26) ou superior.

---

## 🏗️ Arquitetura e Stack

| Camada | Tecnologia |
|---|---|
| Frontend | Flutter (Dart) |
| Banco de dados | Firebase Firestore |
| Armazenamento de imagens | Firebase Storage |
| Backend | Firebase (sem servidor próprio) |

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

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- [Android Studio](https://developer.android.com/studio) com emulador configurado
- Projeto Firebase criado com Firestore e Storage ativados
- Arquivo `google-services.json` na pasta `android/app/`

### Passo a passo

```bash
# 1. Clone o repositório
git clone https://github.com/AngeloTreptow/AdianteDoe.git
cd AdianteDoe

# 2. Instale as dependências
flutter pub get

# 3. Inicie o emulador Android
flutter emulators --launch <nome-do-emulador>

# 4. Rode o app
flutter run
```

---

## ⚖️ Conformidade Legal

| Lei | Status |
|---|---|
| LGPD (Lei 13.709/2018) | ✅ Coleta mínima, consentimento explícito, expiração automática em 14 dias |
| Marco Civil da Internet (Lei 12.965/2014) | ✅ Aviso de responsabilidade exibido na tela de cadastro |

> ⚠️ *O conteúdo publicado é de responsabilidade do usuário.*

---

## 🎓 Contexto Acadêmico

| Campo | Informação |
|---|---|
| Instituição | Centro Universitário Internacional UNINTER |
| Escola | Escola Superior Politécnica – ESP |
| Curso | CST em Análise e Desenvolvimento de Sistemas |
| Disciplina | Atividade Extensionista II – Tecnologia Aplicada à Inclusão Digital |
| Aluno | Angelo de Souza Treptow |
| RU | 5154447 |
| ODS | 11 — Cidades sustentáveis · 12 — Consumo responsável |

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos como parte da Atividade Extensionista II do curso de CST em Análise e Desenvolvimento de Sistemas — UNINTER (2026).
