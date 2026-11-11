# GolpeZero

Aplicativo educativo e preventivo para ajudar pessoas no Brasil a reconhecer
sinais de golpes digitais. A interface e toda a lógica da aplicação são
implementadas em Dart com Flutter e Material Design 3.

## Recursos

- **Analisador local:** identifica indícios de urgência, pedidos de senhas e
  códigos, pagamentos, prêmios, personificação de empresas e links suspeitos.
  O texto analisado não é enviado nem salvo.
- **Quiz:** perguntas de múltipla escolha, explicações, progresso, pontuação e
  opção para jogar novamente.
- **Simulador:** exemplos fictícios de mensagens, compras e situações com Pix.
- **Biblioteca:** guias com funcionamento, sinais de alerta, prevenção e ações
  recomendadas após um golpe.
- **Prevenção:** orientações e links para recursos oficiais. O aplicativo não
  recebe nem envia denúncias.
- Layout responsivo para dispositivos móveis e navegadores.

## Requisitos

- Flutter 3.47.9 ou superior.
- Dart 3.13.7 ou superior, conforme a restrição em `pubspec.yaml`.

## Executar

Na raiz do projeto:

```bash
flutter pub get
flutter run
```

Para executar no navegador:

```bash
flutter run -d chrome
```

## Publicar no Vercel

O projeto inclui `vercel.json` e um script que instala o Flutter 3.47.9 e
compila a versão web. Para publicar:

1. Envie o projeto para um repositório Git seu (não use `flutter/flutter`).
2. No Vercel, selecione **Add New → Project** e importe esse repositório.
3. Configure a raiz do projeto como a pasta que contém este `README.md`.
4. Mantenha o comando de build e a pasta de saída detectados pelo `vercel.json`
   (`bash scripts/vercel-build.sh` e `build/web`) e clique em **Deploy**.

Os próximos envios para a branch conectada gerarão novos deploys.

## Verificação

```bash
dart format .
flutter analyze
flutter test
```

## Privacidade e limitações

A análise é feita por regras locais e serve apenas como apoio educativo. Um
resultado com poucos sinais **não confirma** que uma mensagem ou link é seguro.
Links devem ser verificados por canais oficiais. Não informe senhas, códigos de
autenticação ou dados bancários no aplicativo.

Os exemplos são demonstrativos e não substituem orientação de bancos,
autoridades ou profissionais. Em caso de suspeita ou prejuízo, entre em contato
com seu banco pelos canais oficiais e siga as orientações das autoridades da sua
região. A disponibilidade de delegacias virtuais varia por estado.

## Estrutura

```text
lib/
  app/         navegação e composição do aplicativo
  data/        conteúdo educativo estático
  models/      modelos de análise, quiz, simulações e guias
  screens/     telas e fluxos da aplicação
  services/    análise local e abertura de canais oficiais
  theme/       identidade visual Material 3
  widgets/     componentes reutilizáveis
test/          testes unitários e de widgets
```
