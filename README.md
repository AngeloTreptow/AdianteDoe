# 📦 AdianteDoe+

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![License](https://img.shields.io/badge/licença-acadêmica-green?style=for-the-badge)

> **Doe o que não usa. Receba o que precisa.**

Um aplicativo mobile de **doação e reutilização de itens**, desenvolvido em **Flutter** com backend em **Firebase**.

Criado como projeto de extensão universitária com impacto social real, o objetivo é conectar pessoas da comunidade de forma simples e acessível.

---

## 📸 Interface do Aplicativo
<div align="center">
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/6a3c1892-2d1c-4f7e-bd93-da567509f36f" width="150"/><br/>
      <b>✨ Demonstração</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/cb1f6187-5d17-42a2-aa27-f04dc3bbdbfa" width="120" height="234"/><br/>
      <b>🏠 Inicial</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/bb224eb4-af1e-4c06-939f-36914addad54" width="120" height="234"/><br/>
      <b>📝 Cadastro</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/9e41b991-6afb-415a-92b2-24bb74c24d52" width="120" height="234"/><br/>
      <b>✅ Preenchido</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/464e9bf5-202e-479b-af5b-901916e58a66" width="120" height="234"/><br/>
      <b>📦 Itens</b>
    </td>
  </tr>
</table>
</div>

---

## 🧩 Problema
Muitas pessoas possuem itens em bom estado que não utilizam mais, mas acabam descartando por falta de uma forma simples de doar.

Ao mesmo tempo, outras pessoas precisam desses itens, mas não têm acesso a eles.

Além disso, soluções existentes costumam exigir cadastro, login ou processos complexos — o que dificulta o uso por pessoas com baixa familiaridade digital.

---

## 💡 Solução

O **AdianteDoe+** conecta pessoas da comunidade de forma simples, rápida e acessível.

A solução foca na **simplicidade extrema**, permitindo que qualquer pessoa publique ou encontre itens sem enfrentar barreiras tecnológicas.

O uso direto do WhatsApp torna o processo mais familiar, reduzindo fricções e aumentando a adesão da comunidade.

---

## ⚙️ Como funciona

1. 📦 O usuário cadastra um item (nome, foto e WhatsApp)  
2. 📡 O item aparece em uma lista pública em tempo real  
3. 🔎 Outro usuário encontra o item disponível  
4. 💬 Entra em contato direto e combina a retirada  

---

## 🌱 Impacto social 

* ♻️ Redução do desperdício de itens reutilizáveis
* 🤝 Fortalecimento da comunidade local
* 📱 Inclusão digital com uso de tecnologia acessível
* 🌍 Incentivo ao consumo consciente

**Alinhado aos Objetivos de Desenvolvimento Sustentável (ODS):**

* 11 — Cidades e comunidades sustentáveis
* 12 — Consumo e produção responsáveis

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

👉 [Baixar APK (versão mais recente)](https://github.com/AngeloTreptow/AdianteDoe/releases)

<details>
<summary>📱 Opções por tipo de celular</summary>

| Celular | Link |
|---|---|
| Moderno | [APK arm64](https://github.com/AngeloTreptow/AdianteDoe/releases/download/V1.2.0/AdianteDoe-arm64-v8a-V1.2.0.apk) |
| Antigo | [APK armeabi](https://github.com/AngeloTreptow/AdianteDoe/releases/download/V1.2.0/AdianteDoe-armeabi-v7a-V1.2.0.apk) |

</details>

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

## 🔐 Segurança

O app utiliza **Firebase Security Rules** para proteger o banco de dados e o storage:

- Leitura pública — qualquer um pode ver os itens disponíveis
- Escrita validada — campos obrigatórios verificados no servidor
- Delete protegido — itens só podem ser removidos após 14 dias
- Storage restrito — apenas imagens de até 5MB são aceitas

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- [Android Studio](https://developer.android.com/studio) com emulador configurado
- Projeto Firebase criado com Firestore e Storage ativados

---

### ⚠️ Configuração do Firebase

Por motivos de segurança, alguns arquivos sensíveis não estão incluídos no repositório.

Para executar o projeto corretamente, é necessário gerar e adicionar:

1. `android/app/google-services.json`  
   → Gerado no console do Firebase ao registrar o app Android  

2. `lib/firebase_options.dart`  
   → Gerado utilizando o FlutterFire CLI  
   👉 https://firebase.flutter.dev/docs/cli/

Após adicionar esses arquivos, o aplicativo estará pronto para conexão com o Firebase.

---

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
| ODS | 11 — Cidades sustentáveis · 12 — Consumo responsável |

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos como parte da Atividade Extensionista II do curso de CST em Análise e Desenvolvimento de Sistemas — UNINTER (2026).
