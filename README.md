<div align="center">

# 📦 AdianteDoe+

### *Doe em 30 segundos. Sem formulário. Sem login. Sem enrolação.*

> Um produto mobile que elimina a burocracia das doações e conecta pessoas da comunidade em tempo real — porque a solidariedade não deveria exigir senha.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Status](https://img.shields.io/badge/status-produção-brightgreen?style=for-the-badge)

[📲 Baixar APK](#-download) · [🏗️ Stack Técnica](#️-decisões-de-engenharia) · [🔒 Política de Privacidade](https://angelotreptow.github.io/AdianteDoe/)

</div>

---

## 📸 Interface do Aplicativo

<div align="center">

<table border="0">
<tr>
<td align="center" width="260" valign="middle">
<img src="https://github.com/user-attachments/assets/6a3c1892-2d1c-4f7e-bd93-da567509f36f" width="220" alt="Demonstração do Fluxo AdianteDoe+"/>
</td>
<td valign="middle" width="310">


<h3>✨ Doe em 3 passos:</h3>
<p>✅ <b>Sem Login:</b> Abra e use na hora.</p>
<p>📸 <b>Rápido:</b> Foto + Nome + WhatsApp.</p>
<p>🚀 <b>Instantâneo:</b> Postou, apareceu.</p>
<p>💬 <b>Direto:</b> Contato via WhatsApp.</p>
</td>
</tr>
</table>

<table>
<tr>
<td align="center"><img src="https://github.com/user-attachments/assets/cb1f6187-5d17-42a2-aa27-f04dc3bbdbfa" width="115"/>


<small>🏠 Inicial</small></td>
<td align="center"><img src="https://github.com/user-attachments/assets/bb224eb4-af1e-4c06-939f-36914addad54" width="115"/>


<small>📝 Cadastro</small></td>
<td align="center"><img src="https://github.com/user-attachments/assets/9e41b991-6afb-415a-92b2-24bb74c24d52" width="115"/>


<small>✅ Preenchido</small></td>
<td align="center"><img src="https://github.com/user-attachments/assets/464e9bf5-202e-479b-af5b-901916e58a66" width="115"/>


<small>📦 Vitrine</small></td>
</tr>
</table>

</div>


---

## 🧠 Por que este projeto existe?

Imagine que você tem uma bicicleta parada há dois anos. Você sabe que alguém na sua comunidade poderia usar. Mas quando você tenta doar por um app comum, o processo te pede: criar uma conta, confirmar e-mail, preencher um formulário extenso, aguardar moderação...

**Você desiste. A bicicleta vai para o lixo.**

Esse é o problema real dos apps de doação tradicionais: eles foram construídos para plataformas, não para pessoas. A burocracia digital mata a boa vontade antes dela acontecer.

O **AdianteDoe+** nasceu com uma única obsessão: **fazer a doação acontecer de verdade**. Sem atrito, sem barreiras, sem tecnologia que intimida. O usuário abre o app, fotografa o item, digita o WhatsApp e pronto — em menos de 30 segundos o item está visível para toda a comunidade.

O contato acontece pelo canal mais familiar do Brasil: o WhatsApp. Porque reduzir fricção é, também, uma decisão de produto. E mais do que conveniência: o WhatsApp é a interface que pessoas com baixa alfabetização digital já dominam — o que coloca o app em alinhamento direto com o tema da disciplina de extensão: *Tecnologia Aplicada à Inclusão Digital*.

---

## ✨ Soluções entregues

> Não é uma lista de features. É o que o produto **resolve** na vida real.

| Solução | Como funciona |
|---|---|
| 🖼️ **Vitrine de solidariedade em tempo real** | Todos os itens disponíveis ficam visíveis instantaneamente via Firestore Streams — sem precisar atualizar a tela |
| ⚡ **Cadastro sem fricção** | Nome do item + foto (opcional) + WhatsApp. Três campos. Nenhum login necessário |
| 📸 **Prova visual do item** | Upload de imagens via galeria com normalização automática para formato leve (.jpg) — reduz consumo de Storage e acelera o carregamento no feed |
| 💬 **Contato com um toque** | Botão que abre o WhatsApp direto, com DDI +55 e mensagem padrão pré-preenchida — zero esforço para o interessado |
| ⏳ **Curadoria automática** | Itens somem automaticamente após 14 dias, mantendo o feed limpo sem moderação manual |
| 🛡️ **Validação inteligente** | DDDs brasileiros validados no cliente e regras de segurança aplicadas no servidor (Firebase Security Rules) |
| 🚩 **Moderação comunitária** | Qualquer pessoa pode denunciar um item suspeito com um toque — sem criar conta. Uma denúncia por item por dispositivo, garantida no servidor |

---

## 🗺️ Histórico de Versões

> Este produto não foi construído de uma vez. Cada versão resolveu um problema real — e o changelog conta essa história.

### ✅ v1.0.0 — Lançamento: a base que sustenta tudo
*Objetivo: fazer a doação acontecer. Simples assim.*

- Estrutura completa do app com Flutter e integração Firebase
- Listagem de itens em tempo real via Firestore Streams
- Cadastro com nome do item + WhatsApp do doador
- Integração com WhatsApp via deep link (DDI +55 automático)
- Estrutura de dados no Firestore com timestamp para expiração

---

### ✅ v1.1.0 — Segurança e Otimização: produto enxuto e protegido
*Problema resolvido: APK pesado e ausência de validação no servidor abriam brechas.*

- **APK de 48MB → 16MB** com split por arquitetura (arm64 e armeabi) — redução de 67%
- Firebase Security Rules com validação de campos obrigatórios no servidor
- Regras de segurança preparadas para imagens (jpg, jpeg, png, webp)
- Validação de telefone no servidor: exatamente 13 dígitos com DDI
- Código obfuscado para maior segurança em produção
- Tree-shaking de ícones: redução de 99,9% nos assets de fontes

---

### ✅ v1.1.1 — Compatibilidade: WhatsApp funcionando em todos os Androids
*Problema resolvido: em Android 11+, o app não conseguia detectar o WhatsApp instalado.*

- Adicionada tag `<queries>` no `AndroidManifest.xml` (exigência do Android 11+)
- Suporte a WhatsApp e WhatsApp Business garantido em dispositivos modernos
- Correção silenciosa: sem impacto na interface, 100% de impacto na funcionalidade

---

### ✅ v1.2.0 — Performance: fotos rápidas e feed eficiente
*Problema resolvido: imagens recarregavam a cada abertura e o feed crescia sem controle.*

- **Cache de imagens em disco** com `CachedNetworkImage` — fotos carregam mais rápido e funcionam offline
- **Limite de 25 itens na listagem** — app mais eficiente e econômico no uso de dados móveis

---

### ✅ v2.0.0 — Identidade própria e blindagem do backend *(versão atual)*
*Problema resolvido: identidade de app provisória e brechas que permitiam escrita maliciosa no banco.*

- **Identidade definitiva**: `applicationId` próprio (`io.github.angelotreptow.adiantedoe`) e APK assinado com chave de release própria — pré-requisitos para a Play Store
- **Security Rules reforçadas**: lista fechada de campos, formato do telefone validado no servidor, `createdAt` gravado com horário do servidor, imagem restrita ao Firebase Storage e exclusão/edição bloqueadas para clientes
- **Expiração via TTL nativo do Firestore** (campo `expiresAt`) — a limpeza saiu do cliente e virou responsabilidade do servidor
- **Robustez**: falha ao publicar agora avisa o usuário e libera nova tentativa; falha no upload não publica mais item sem foto; aviso quando o WhatsApp não pode ser aberto; tratamento de erro no feed
- **Suíte de testes automatizados**: validador de telefone, modelo de dados e fluxo do formulário
- ⚠️ **Requer reinstalação**: por causa da troca de pacote, quem tem versão anterior precisa desinstalá-la e instalar esta

---

### 🚧 v2.1.0 — Moderação comunitária e proteção contra abuso *(em preparação)*
*Problema resolvido: nenhum canal para a comunidade sinalizar golpes, e nada impedia denúncias em massa ou clientes adulterados.*

- **Botão de denúncia** em cada item, com motivo opcional — a coleção `reports` é write-only para clientes (só o administrador lê)
- **Login anônimo invisível** (Firebase Authentication): dá identidade ao dispositivo sem pedir cadastro — a filosofia "sem login" segue intacta na experiência
- **Uma denúncia por item por dispositivo**, garantida no servidor: o documento usa ID determinístico `{uid}_{itemId}` e as regras bloqueiam duplicatas
- **Cooldown de 30s** entre denúncias no cliente, contra toques repetidos
- **App Check com Play Integrity**: atesta que as requisições vêm do app legítimo (em modo de monitoramento; bloqueio será ativado após validação das métricas)
- Política de Privacidade atualizada: identificador anônimo e verificação de integridade documentados

---

## 🏗️ Decisões de Engenharia

> Por que essas tecnologias? Não foi acaso — foi escolha consciente.

### Flutter (Dart) — Uma base, dois sistemas operacionais

Flutter foi escolhido pela capacidade de entregar um produto nativo de alta performance para Android (e futuramente iOS) a partir de um único codebase. Em um projeto com prazo acadêmico e escopo de MVP, isso representa uma vantagem competitiva real: velocidade de entrega sem sacrificar qualidade de experiência.

O sistema de widgets declarativos do Flutter facilita a criação de interfaces responsivas e consistentes, e o hot reload reduz o ciclo de feedback durante o desenvolvimento — o que acelera iterações e testes de interface.

### Firebase Firestore (NoSQL) — Por que não SQL?

O modelo de dados do AdianteDoe+ é simples e orientado a documentos: cada item é uma entidade independente, sem relacionamentos complexos entre tabelas. O Firestore resolve isso de forma natural, sem a necessidade de esquemas rígidos.

O diferencial decisivo foi o **suporte a streams em tempo real**: a vitrine de itens é atualizada automaticamente no cliente sem polling, sem requisições extras, sem estado inconsistente. Em SQL tradicional, isso exigiria WebSockets e infraestrutura adicional — no Firestore, é nativo. Além disso, a conexão por stream é otimizada pelo SDK: consome menos bateria e processamento do que um refresh manual periódico, o que importa especialmente para usuários com dispositivos mais simples.

### Firebase Storage — Simplicidade que escala

O armazenamento de imagens via Firebase Storage permite CDN global out-of-the-box, URLs públicas com controle de acesso via Security Rules e integração nativa com o Firestore. Para o volume atual do projeto, é zero-config. Para escala, é o mesmo serviço que sustenta produtos com milhões de usuários.

### Arquitetura em camadas

```
lib/
├── main.dart                  # Entrada + Firebase, App Check e login anônimo transparente
├── models/
│   ├── item_model.dart        # Contrato de dados: tipagem forte, serialização limpa
│   └── report_model.dart      # Denúncia write-only: sem fromMap, só o admin lê
├── services/
│   ├── firebase_service.dart  # Acesso ao Firestore (injetável nas telas para testes)
│   ├── storage_service.dart   # Upload isolado: fácil de trocar a implementação no futuro
│   └── whatsapp_service.dart  # Integração com deep link — testável de forma isolada
├── screens/
│   ├── home_screen.dart       # Stream do Firestore → UI reativa
│   └── add_item_screen.dart   # Validação no cliente antes de qualquer escrita
├── utils/
│   └── phone_validator.dart   # Validação de celular BR como função pura, coberta por testes
└── widgets/
    └── item_card.dart         # Card do item + fluxo de denúncia com cooldown

test/
├── phone_validator_test.dart  # DDDs, nono dígito e comprimento
├── item_model_test.dart       # Serialização e tolerância a dados incompletos
├── report_model_test.dart     # Campos aceitos pelas regras e motivo opcional
├── item_card_test.dart        # Denúncia: envio, cancelamento, cooldown e duplicata
└── add_item_screen_test.dart  # Fluxo do formulário com serviço fake
```

A separação entre `screens/`, `services/` e `models/` segue o princípio de responsabilidade única: cada módulo tem uma razão para existir e uma razão para mudar. Isso facilita testes, manutenção e onboarding de novos colaboradores.

### Estrutura de dados (Firestore)

```
items/
└── {id}
    ├── name       : String     — Nome do item
    ├── phone      : String     — WhatsApp com DDI +55
    ├── imageUrl   : String?    — URL pública no Storage (nullable)
    ├── createdAt  : Timestamp  — Horário do servidor (serverTimestamp)
    └── expiresAt  : Timestamp  — Consumido pela política de TTL do Firestore (14 dias)

reports/
└── {uid}_{itemId}              — ID determinístico: 1 denúncia por item por dispositivo
    ├── itemId     : String     — Item denunciado
    ├── reason     : String?    — Motivo opcional (até 200 caracteres)
    └── createdAt  : Timestamp  — Horário do servidor (serverTimestamp)
```

### Segurança por design

As Firebase Security Rules garantem que nenhum dado inválido chegue ao banco, mesmo que o cliente seja adulterado:

- Leitura pública — qualquer um pode ver os itens disponíveis
- Escrita validada — lista fechada de campos, formato do telefone, `createdAt` igual ao horário do servidor e imagem restrita ao Firebase Storage
- Edição e exclusão bloqueadas — nenhum cliente altera ou remove itens; a expiração é feita pela política de TTL do Firestore, no servidor
- Storage restrito — apenas imagens de até 5MB, sem sobrescrita nem exclusão pelo app
- Denúncias write-only — clientes só criam; leitura, edição e exclusão são exclusivas do administrador
- Denúncia exige sessão (login anônimo) e o ID `{uid}_{itemId}` é validado no servidor — duplicata é rejeitada mesmo com cliente adulterado
- App Check (Play Integrity) atesta a origem das requisições — hoje em modo de monitoramento, com bloqueio a ativar via console

---

## 📲 Download

👉 [Ver todas as releases](https://github.com/AngeloTreptow/AdianteDoe/releases)

**Versão atual: V2.0.0**

> ⚠️ **Atualizando da v1.x?** Desinstale a versão antiga antes: a v2.0.0 usa um novo identificador de pacote e é instalada como um app separado.

| Dispositivo | Arquitetura | Tamanho | Link |
|---|---|---|---|
| Android moderno (2018+) | arm64-v8a | 16.9 MB | [Baixar APK](https://github.com/AngeloTreptow/AdianteDoe/releases/download/V2.0.0/AdianteDoe-arm64-v8a-V2.0.0.apk) |
| Android antigo | armeabi-v7a | 14.2 MB | [Baixar APK](https://github.com/AngeloTreptow/AdianteDoe/releases/download/V2.0.0/AdianteDoe-armeabi-v7a-V2.0.0.apk) |

<details>
<summary>🔐 Verificar integridade dos arquivos (SHA-256)</summary>

```
arm64-v8a:   db244611e86023564377ab13fbf98db157100c902e7c9e08dedabb91d1e3e570
armeabi-v7a: 90c3b6ea75aa580a6afff30b599864558556531670b09e22d69d2b4c43170c87
```

</details>

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- [Android Studio](https://developer.android.com/studio) com emulador configurado
- Projeto Firebase criado com Firestore e Storage ativados

### ⚠️ Configuração do Firebase

Por motivos de segurança, arquivos sensíveis não estão no repositório. É necessário gerar e adicionar:

1. `android/app/google-services.json` → gerado no console do Firebase ao registrar o app Android (obrigatório)
2. As Security Rules do Firestore e do Storage também não são versionadas — configure-as no console do Firebase (validação de campos no `create`, exclusão bloqueada, TTL no campo `expiresAt` e regras da coleção `reports`)
3. **Authentication** → habilite o provedor **Anônimo** (Sign-in method), usado pelas denúncias
4. **App Check** → registre o app Android com o provider Play Integrity; para rodar em debug, cadastre o token de depuração que aparece no logcat

Para gerar o APK de release também é necessário um keystore próprio referenciado em `android/key.properties` (fora do git).

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

## 🌱 Impacto Social e Alinhamento ODS

O AdianteDoe+ foi construído com impacto mensurável em mente, alinhado aos Objetivos de Desenvolvimento Sustentável da ONU:

- **ODS 11 — Cidades e comunidades sustentáveis**: fortalece redes de apoio local e estimula o reaproveitamento dentro da própria comunidade
- **ODS 12 — Consumo e produção responsáveis**: cada item doado é um item a menos no aterro sanitário

---

## ⚖️ Diretrizes de Privacidade e Responsabilidade

| Lei | Abordagem |
|---|---|
| LGPD (Lei 13.709/2018) | Coleta mínima de dados, sem armazenamento de e-mail ou CPF, expiração automática em 14 dias e identificador anônimo sem vínculo com dados pessoais (prevenção de abuso) |
| Marco Civil da Internet (Lei 12.965/2014) | Aviso de responsabilidade sobre o conteúdo publicado exibido na tela de cadastro |

📜 A **[Política de Privacidade](https://angelotreptow.github.io/AdianteDoe/)** completa está publicada via GitHub Pages e detalha quais dados são coletados, como são usados e por quanto tempo permanecem armazenados.

---

## 🎓 Contexto Acadêmico

| Campo | Informação |
|---|---|
| Instituição | Centro Universitário Internacional UNINTER |
| Escola | Escola Superior Politécnica – ESP |
| Curso | CST em Análise e Desenvolvimento de Sistemas |
| Disciplina | Atividade Extensionista II – Tecnologia Aplicada à Inclusão Digital |
| Desenvolvedor | Angelo de Souza Treptow |
| ODS | 11 · 12 |

---

## 📄 Licença

Desenvolvido para fins acadêmicos como Atividade Extensionista II — UNINTER (2026).

---

<div align="center">

*Feito com Flutter, Firebase e a crença de que tecnologia deve remover barreiras — não criá-las.*

</div>
