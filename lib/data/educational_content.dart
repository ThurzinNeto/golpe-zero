import 'package:flutter/material.dart';

import '../models/quiz_question.dart';
import '../models/scam_guide.dart';
import '../models/simulation_scenario.dart';

const quizQuestions = <QuizQuestion>[
  QuizQuestion(
    topic: 'Senhas e códigos',
    prompt:
        'Uma pessoa que diz ser do banco pediu o código que chegou por SMS. O que fazer?',
    options: [
      'Enviar o código para confirmar minha identidade',
      'Não compartilhar e confirmar pelo aplicativo ou telefone oficial do banco',
      'Enviar apenas se a pessoa souber meu nome',
      'Responder pedindo outro código',
    ],
    correctIndex: 1,
    explanation:
        'Bancos não precisam que você informe senhas ou códigos de autenticação. Encerre o contato e procure o banco pelos canais oficiais.',
  ),
  QuizQuestion(
    topic: 'Links recebidos',
    prompt:
        'Você recebe um link dizendo que sua conta será bloqueada em minutos. Qual é a atitude mais segura?',
    options: [
      'Abrir o link para evitar o bloqueio',
      'Encaminhar para familiares verificarem',
      'Não abrir; acessar o serviço pelo aplicativo ou endereço oficial digitado por você',
      'Informar seus dados para descobrir se a mensagem é verdadeira',
    ],
    correctIndex: 2,
    explanation:
        'A urgência é usada para reduzir seu tempo de decisão. Acesse o serviço por um canal que você já conhece, sem usar o link recebido.',
  ),
  QuizQuestion(
    topic: 'Pix',
    prompt:
        'Alguém diz que enviou um Pix por engano e pede que você devolva para outra chave. O que fazer?',
    options: [
      'Devolver imediatamente para a chave indicada',
      'Fazer um novo Pix para resolver rápido',
      'Verificar a transação no extrato e usar a função de devolução da transação original, se aplicável',
      'Compartilhar uma captura de tela do seu banco',
    ],
    correctIndex: 2,
    explanation:
        'Não faça uma nova transferência para uma chave enviada por mensagem. Confira o extrato e fale com seu banco para usar os meios adequados.',
  ),
  QuizQuestion(
    topic: 'Compras online',
    prompt:
        'Uma loja desconhecida oferece um celular muito abaixo do preço e aceita apenas Pix. Como avaliar?',
    options: [
      'Comprar logo, porque a oferta pode acabar',
      'Pesquisar a empresa em fontes independentes e conferir os canais de atendimento antes de pagar',
      'Confiar se o site tiver um cadeado no navegador',
      'Pagar e pedir confirmação depois',
    ],
    correctIndex: 1,
    explanation:
        'Preço irreal e pressão para pagar são alertas. O cadeado indica conexão criptografada, não que a loja seja legítima.',
  ),
  QuizQuestion(
    topic: 'Falsas promoções',
    prompt:
        'Uma mensagem promete um prêmio, mas pede uma taxa para liberar o recebimento. O que isso indica?',
    options: [
      'Um procedimento normal para receber prêmios',
      'Um possível golpe; não pague nem informe dados',
      'Uma confirmação de que o prêmio é legítimo',
      'Uma taxa que pode ser paga depois',
    ],
    correctIndex: 1,
    explanation:
        'Prêmios inesperados com cobrança antecipada ou pedido de dados são sinais comuns de fraude. Verifique a promoção nos canais oficiais da empresa.',
  ),
  QuizQuestion(
    topic: 'Se você foi vítima',
    prompt:
        'Você percebeu uma transferência que não reconhece. Qual deve ser o próximo passo?',
    options: [
      'Esperar alguns dias para ver se o valor volta',
      'Apagar as conversas para proteger sua privacidade',
      'Contatar imediatamente o banco por um canal oficial e guardar as evidências',
      'Publicar seus dados bancários para pedir ajuda',
    ],
    correctIndex: 2,
    explanation:
        'Avise seu banco rapidamente, peça orientação para contestar a operação e preserve comprovantes e conversas. Nunca publique dados bancários.',
  ),
];

const simulationScenarios = <SimulationScenario>[
  SimulationScenario(
    title: 'Parente com número novo',
    channel: 'Conversa de mensagem',
    icon: 'chat',
    message:
        '“Oi, mãe! Troquei de número. Meu aplicativo do banco está com problema e preciso pagar uma conta agora. Faz um Pix para esta chave? Depois te explico.”',
    warningSigns: [
      'Pedido urgente de dinheiro',
      'Número novo sem confirmação por outro canal',
      'Chave Pix enviada em conversa',
    ],
    safeAnswer: 1,
    explanation:
        'Golpistas podem se passar por familiares usando outro número. Ligue para o número antigo ou confirme pessoalmente antes de qualquer transferência.',
  ),
  SimulationScenario(
    title: 'Alerta de segurança do banco',
    channel: 'SMS',
    icon: 'sms',
    message:
        '“BANCO: compra suspeita detectada. Sua conta será bloqueada em 10 minutos. Acesse banco-seguro.exemplo para cancelar e informe o código recebido.”',
    warningSigns: [
      'Ameaça de bloqueio com prazo curto',
      'Endereço de site que não foi confirmado',
      'Pedido de código de autenticação',
    ],
    safeAnswer: 1,
    explanation:
        'Bancos não pedem senhas ou códigos por links de SMS. Não abra o endereço; use o aplicativo ou o telefone oficial impresso no cartão.',
  ),
  SimulationScenario(
    title: 'Prêmio compartilhável',
    channel: 'Rede social',
    icon: 'celebration',
    message:
        '“Você foi selecionado para ganhar um celular! Para confirmar, pague uma pequena taxa de entrega e compartilhe esta promoção com 10 amigos.”',
    warningSigns: [
      'Prêmio inesperado',
      'Cobrança para liberar o prêmio',
      'Pressão para compartilhar a mensagem',
    ],
    safeAnswer: 1,
    explanation:
        'Não pague taxas para receber prêmios inesperados. Confira a campanha diretamente nos canais oficiais da marca, acessados por você.',
  ),
  SimulationScenario(
    title: 'Loja com preço irresistível',
    channel: 'Loja virtual',
    icon: 'store',
    message:
        '“Últimas unidades: notebook novo por 70% menos que em outras lojas. Pagamento somente via Pix para pessoa física. Oferta encerra em 5 minutos!”',
    warningSigns: [
      'Preço muito abaixo do mercado',
      'Pagamento para pessoa física',
      'Contagem regressiva para apressar a compra',
    ],
    safeAnswer: 1,
    explanation:
        'Preço muito baixo, urgência e pagamento para pessoa física são alertas. Pesquise a empresa de forma independente e prefira meios de pagamento que ofereçam proteção.',
  ),
  SimulationScenario(
    title: 'Comprovante de Pix falso',
    channel: 'Venda entre pessoas',
    icon: 'payments',
    message:
        '“Já fiz o Pix! O comprovante está aqui, mas o banco está demorando. Pode liberar o produto? Se precisar, devolva quando cair.”',
    warningSigns: [
      'Pedido para entregar antes de confirmar o recebimento',
      'Comprovante que pode ser manipulado',
      'Pressão para confiar em uma promessa',
    ],
    safeAnswer: 1,
    explanation:
        'Comprovantes podem ser falsificados. Confira o saldo e o extrato diretamente no seu aplicativo antes de entregar qualquer produto.',
  ),
];

const scamGuides = <ScamGuide>[
  ScamGuide(
    name: 'Falso atendimento bancário',
    category: 'Contas e bancos',
    icon: 'account_balance',
    summary:
        'Criminosos fingem ser funcionários do banco para obter dados ou acesso à conta.',
    howItWorks:
        'A pessoa pode ligar ou mandar mensagens sobre uma compra, bloqueio ou problema inventado. Em seguida pede senhas, códigos, instalação de aplicativo ou transferências para “proteger” o dinheiro.',
    warningSigns: [
      'Pedido de senha, token ou código recebido por SMS',
      'Solicitação para instalar aplicativo ou compartilhar a tela',
      'Transferência para uma conta “segura”',
      'Ameaças de bloqueio para apressar a decisão',
    ],
    protection: [
      'Encerre o contato e ligue para o banco usando o número do cartão ou do aplicativo oficial.',
      'Nunca compartilhe senhas ou códigos de autenticação.',
      'Não instale aplicativos por orientação de desconhecidos.',
    ],
    ifVictim: [
      'Contate imediatamente o banco por um canal oficial e peça o bloqueio necessário.',
      'Conteste movimentações desconhecidas e guarde protocolos, mensagens e comprovantes.',
      'Registre ocorrência na Polícia Civil ou delegacia virtual disponível na sua região.',
    ],
  ),
  ScamGuide(
    name: 'Golpe do familiar no Pix',
    category: 'Pix e pagamentos',
    icon: 'family_restroom',
    summary:
        'Uma pessoa se passa por familiar e pede uma transferência urgente para uma chave nova.',
    howItWorks:
        'O golpista usa um número desconhecido, foto copiada ou perfil falso e inventa uma emergência, uma troca de telefone ou um problema bancário.',
    warningSigns: [
      'Pedido de dinheiro com urgência',
      'Número novo ou chave Pix diferente',
      'Recusa em confirmar a identidade por ligação ou vídeo',
    ],
    protection: [
      'Ligue para o familiar no número que você já tem salvo.',
      'Confirme a história com outra pessoa próxima.',
      'Não faça transferência apenas com base em mensagens.',
    ],
    ifVictim: [
      'Avise o banco imediatamente e solicite orientação sobre a contestação.',
      'Guarde a conversa, o número usado e os dados da transação.',
      'Registre ocorrência pelos canais oficiais da sua região.',
    ],
  ),
  ScamGuide(
    name: 'Loja virtual falsa',
    category: 'Compras online',
    icon: 'storefront',
    summary:
        'Sites ou perfis falsos anunciam produtos que não serão entregues.',
    howItWorks:
        'A loja copia identidade de marcas conhecidas ou cria ofertas muito abaixo do mercado. Após o pagamento, o vendedor some ou envia um produto diferente.',
    warningSigns: [
      'Preço muito abaixo do praticado por outras lojas',
      'Pagamento somente por Pix ou transferência',
      'Endereço do site parecido, mas diferente do oficial',
      'Pouco histórico ou avaliações inconsistentes',
    ],
    protection: [
      'Pesquise o nome da loja em fontes independentes.',
      'Confira o endereço com atenção e acesse a loja digitando o endereço conhecido.',
      'Desconfie de pressão para comprar imediatamente.',
    ],
    ifVictim: [
      'Contate o banco ou a operadora do cartão para saber como contestar.',
      'Guarde anúncios, conversas, comprovantes e dados do pedido.',
      'Procure os canais oficiais de defesa do consumidor e a Polícia Civil.',
    ],
  ),
  ScamGuide(
    name: 'SMS com link falso',
    category: 'Links e mensagens',
    icon: 'sms',
    summary:
        'Mensagens falsas imitam bancos, serviços de entrega ou órgãos públicos para roubar dados.',
    howItWorks:
        'O texto fala em bloqueio, multa, pacote retido ou atualização cadastral. O link leva a uma página que imita um serviço conhecido e solicita informações ou pagamento.',
    warningSigns: [
      'Link encurtado ou endereço com erros e palavras extras',
      'Ameaça, prazo curto ou cobrança inesperada',
      'Pedido de dados pessoais, senha ou código',
    ],
    protection: [
      'Não abra links inesperados.',
      'Acesse o aplicativo oficial ou digite o endereço conhecido.',
      'Confirme a informação com a empresa por um contato oficial.',
    ],
    ifVictim: [
      'Se informou senha, altere-a pelo aplicativo oficial e avise a instituição.',
      'Se fez pagamento, contate imediatamente o banco ou emissor do cartão.',
      'Guarde a mensagem e registre a ocorrência.',
    ],
  ),
  ScamGuide(
    name: 'Falsa promoção ou prêmio',
    category: 'Ofertas e prêmios',
    icon: 'card_giftcard',
    summary:
        'Uma oferta ou premiação inventada busca obter dinheiro, dados ou compartilhamentos.',
    howItWorks:
        'A vítima recebe um aviso de que ganhou algo sem ter participado ou encontra uma promoção falsa. Para receber, pedem taxa, cadastro, código ou encaminhamento da mensagem.',
    warningSigns: [
      'Prêmio inesperado ou promessa de dinheiro fácil',
      'Cobrança antecipada para liberar o benefício',
      'Pedido de senha, código ou compartilhamento em massa',
    ],
    protection: [
      'Confira a promoção no site ou perfil oficial da empresa.',
      'Não pague para receber um prêmio inesperado.',
      'Evite informar dados em páginas recebidas por mensagem.',
    ],
    ifVictim: [
      'Avise o banco se fez um pagamento e pergunte sobre contestação.',
      'Troque senhas que possam ter sido expostas.',
      'Preserve mensagens e comprovantes para a ocorrência.',
    ],
  ),
  ScamGuide(
    name: 'Falso comprovante de Pix',
    category: 'Pix e pagamentos',
    icon: 'receipt_long',
    summary:
        'Um comprovante manipulado é usado para convencer alguém a liberar um produto ou serviço.',
    howItWorks:
        'O golpista envia uma imagem ou arquivo que parece confirmar um Pix, mas o dinheiro não aparece na conta ou a transação foi agendada e cancelada.',
    warningSigns: [
      'Pedido de liberação antes do valor aparecer no extrato',
      'Pressa para concluir a venda',
      'Comprovante recebido por imagem sem confirmação no banco',
    ],
    protection: [
      'Confira o saldo e o extrato no seu próprio aplicativo bancário.',
      'Não confie apenas em comprovantes enviados por outra pessoa.',
      'Aguarde a confirmação efetiva antes de entregar o produto.',
    ],
    ifVictim: [
      'Guarde o comprovante recebido, a conversa e os dados da pessoa.',
      'Avise o banco se houver movimentação suspeita.',
      'Registre a ocorrência pelos canais oficiais.',
    ],
  ),
];

const iconByName = <String, IconData>{
  'account_balance': Icons.account_balance_rounded,
  'family_restroom': Icons.family_restroom_rounded,
  'storefront': Icons.storefront_rounded,
  'sms': Icons.sms_rounded,
  'card_giftcard': Icons.card_giftcard_rounded,
  'receipt_long': Icons.receipt_long_rounded,
  'chat': Icons.chat_bubble_rounded,
  'celebration': Icons.celebration_rounded,
  'store': Icons.store_rounded,
  'payments': Icons.payments_rounded,
};

const officialResources = <({String title, String subtitle, String url})>[
  (
    title: 'Banco Central do Brasil',
    subtitle: 'Orientações oficiais sobre Pix e instituições financeiras',
    url: 'https://www.bcb.gov.br/meubc',
  ),
  (
    title: 'Delegacia Virtual',
    subtitle: 'Consulte a disponibilidade e registre uma ocorrência oficial',
    url: 'https://delegaciavirtual.sinesp.gov.br/portal/',
  ),
  (
    title: 'Consumidor.gov.br',
    subtitle: 'Canal público para tratar problemas com empresas participantes',
    url: 'https://www.consumidor.gov.br/',
  ),
];
