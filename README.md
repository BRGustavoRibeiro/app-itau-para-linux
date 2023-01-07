# App Itaú no computador (para Linux)
Script de instalação do App Itaú no computador (para Linux)

## Informações sobre este script e declaração de ciência
- Este software e script foram criados para oferecer uma maneira de instalar o App Itaú no Computador dentro de ambientes Linux, facilitando a instalação de dependências necessárias para sua execução. Este script é oferecido de forma pública e gratuita, e o código é aberto e disponível para sugestões, melhorias e modificações.
- Este script não é criado, fornecido, patrocinado ou auditado pelo Banco Itaú ou qualquer uma de suas subsidiárias de nenhuma maneira.
- Este script é fornecido 'como é'/'como está', e não possui garantia de funcionamento pleno. Nenhuma pessoa envolvida com a criação deste script não é responsável por absolutamente nenhuma ocorrência ou dano causado no seu computador, nem é responsável por nenhum tipo de ocorrência ou problema na sua conta bancária.
- Este software não fornece o binário do App Itaú no Computador e apenas baixa automaticamente o executável disponível publicamente no site https://guardiao.itau.com.br/UpdateServer/aplicativoitau.msi e executa as operações técnicas necessárias para assegurar seu funcionamento fora do ambiente Windows, e quaisquer dúvidas sobre suas funcionalidades devem ser redirecionadas ao Itaú Unibanco.
- Este script, por si, não envia nenhum tipo de informação para seu criador nem para nenhum terceiro e não recolhe dados de nenhuma natureza.
- O criador deste script, o Banco Itaú e qualquer outro colaborador deste projeto não tem nenhuma responsabilidade por manter e assegurar o pleno funcionamento deste software ou do projeto. Este script também pode parar de funcionar a qualquer momento e poderá eventualmente ser removido sem aviso prévio da disponibilização pública.

*AO UTILIZAR ESTE SCRIPT, VOCÊ CONCORDA INTEGRALMENTE COM OS TERMOS ACIMA, E DECLARA TER TOTAL E PLENA CIÊNCIA DAS INFORMAÇÕES FORNECIDAS.*

## Como instalar
1. Abra o terminal do Linux;
2. Digite o comando `bash <(wget -qO- https://raw.githubusercontent.com/BRGustavoRibeiro/app-itau-para-linux/main/Install.sh)`
3. Aceite os termos de uso e declaração de ciência pressionando `[S]` + `[Enter]`;
4. Escolha se você deseja instalar a versão estável ou a versão beta do aplicativo do Itaú.

*É provável que seja necessário digitar a senha do administrador do computador, a menos que você esteja já logado como root.*

## Compatibilidade
Neste momento, o script apenas é compatível com sistemas que usam o gerenciador de pacotes DEB (Ubuntu, Linux Mint, etc).

## Funcionamento
Este script faz o download do binário do App Itaú no computador para Windows, instala e configura o Wine e as dependências necessárias para executar o app dentro do Linux.

## Segurança e Processamento de Dados
Este script não coleta dados de nenhuma forma ou natureza. Não há envio de quaisquer tipos de informação para os colaboradores deste repositório. A segurança padrão é fornecida pelo próprio App Itaú. Há planos para criar um modo ultraseguro, que desabilitaria funções de acesso remoto e adicionaria outras opções para garantir máxima segurança durante o uso do app.

## A fazer
- [ ] Suporte ao RPM (Fedora, RHEL, etc)
- [ ] Criar mecanismos de segurança e blindagem próprios para o Linux (Modo Ultraseguro)
