#!/bin/bash

echo -e "\n$(tput setab 11)                                                           " 
echo -e "$(tput setab 11) $(tput setab 4)      $(tput setab 11)                                                    "
echo -e "$(tput setab 11) $(tput setab 4)      $(tput setaf 0)$(tput setab 11)   App Itaú no Computador para Linux [NÃO-OFICIAL]  "
echo -e "$(tput setab 11) $(tput setaf 7)$(tput setab 4) Itaú $(tput setab 11)                                                    "
echo -e "$(tput setab 11)                                                           " 
tput sgr0
echo -e "\nVersão 2023.01.001\n"
echo -e "Informações sobre este script e declaração de ciência"
echo -e "-------------\n"
echo -e "1. Este software e script foram criados para oferecer uma maneira de instalar o App Itaú no Computador dentro de ambientes Linux, facilitando a instalação de dependências necessárias para sua execução. Este script é oferecido de forma pública e gratuita, e o código é aberto e disponível para sugestões, melhorias e modificações.\n"
echo -e "2. Este script não é criado, fornecido, patrocinado ou auditado pelo Banco Itaú ou qualquer uma de suas subsidiárias de nenhuma maneira.\n"
echo -e "3. Este script é fornecido 'como é'/'como está', e não possui garantia de funcionamento pleno. Nenhuma pessoa envolvida com a criação deste script não é responsável por absolutamente nenhuma ocorrência ou dano causado no seu computador, nem é responsável por nenhum tipo de ocorrência ou problema na sua conta bancária.\n"
echo -e "4. Este software não fornece o binário do App Itaú no Computador e apenas baixa automaticamente o executável disponível publicamente no site https://guardiao.itau.com.br/UpdateServer/aplicativoitau.msi e executa as operações técnicas necessárias para assegurar seu funcionamento fora do ambiente Windows, e quaisquer dúvidas sobre suas funcionalidades devem ser redirecionadas ao Itaú Unibanco.\n"
echo -e "5. Este script, por si, não envia nenhum tipo de informação para seu criador nem para nenhum terceiro e não recolhe dados de nenhuma natureza.\n"
echo -e "6. O criador deste script, o Banco Itaú e qualquer outro colaborador deste projeto não tem nenhuma responsabilidade por manter e assegurar o pleno funcionamento deste software ou do projeto. Este script também pode parar de funcionar a qualquer momento e poderá eventualmente ser removido sem aviso prévio da disponibilização pública.\n"

echo -e "- Eventuais dúvidas sobre o funcionamento deste script podem ser resolvidas com o encaminhamento de uma issue em https://github.com/BRGustavoRibeiro/app-itau-para-linux\n"
tput sgr0
echo -e "AO UTILIZAR ESTE SCRIPT, VOCÊ CONCORDA INTEGRALMENTE COM OS TERMOS ACIMA, E DECLARA TER TOTAL E PLENA CIÊNCIA DAS INFORMAÇÕES FORNECIDAS."
read -r -p "DESEJA CONTINUAR? (S/N): " response
case "$response" in
    [sS][iI][mM]|[sS]) 
        echo -e "\n\n$(tput setaf 0)$(tput setab 11) -- INICIANDO INSTALAÇÃO -- $(tput sgr0)\nIsto pode levar alguns minutos.\n\n"
        ;;
    *)
        echo -e "O software não será instalado."
        exit 0
        ;;
esac

echo -e "[LOG] Atualizando repositórios"
sudo add-apt-repository -y ppa:flatpak/stable
sudo apt-get update

if [ $(which flatpak) ]
then 
  echo -e "[LOG] Flatpak instalado!"
else
  echo -e "[LOG] Flatpak não detectado - instalando"
  sudo apt install -y flatpak
fi

if [ $(which bottles) ]
then 
  echo -e "[LOG] Flatpak instalado!"
else
  echo -e "[LOG] Flatpak não detectado - instalando"
  sudo apt install -y flatpak
  echo -e "[LOG] Instalando Bottles"
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak install flathub com.usebottles.bottles -y
fi

echo -e "[LOG] Baixando Aplicativo Itaú"
wget -O winsetup.msi https://guardiao.itau.com.br/UpdateServer/aplicativoitau.msi

echo -e "[LOG] Configurando ambiente"
flatpak run --command=bottles-cli com.usebottles.bottles new --bottle-name ItauLinux --environment application --arch win64
mv winsetup.msi $(eval echo ~)/.var/app/com.usebottles.bottles/.local/winsetup.msi
echo -e "[LOG] Instalando Aplicativo Itaú"
flatpak run --command=bottles-cli com.usebottles.bottles run -b ItauLinux -e $(eval echo ~)/.var/app/com.usebottles.bottles/.local/winsetup.msi --args /quiet
echo -e "[LOG] Criando permissão para criar atalho"
flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications
echo -e "[LOG] Criando atalho na Área de Trabalho e no menu"
wget -O $(eval echo ~)/.local/share/applications/appitaulinux.desktop https://raw.githubusercontent.com/BRGustavoRibeiro/app-itau-para-linux/main/resources/appitaulinux.desktop
sed -i "s#DIRETORIO#$(eval echo ~)" $(eval echo ~)/.local/share/applications/appitaulinux.desktop
echo "\n\n$(tput setaf 0)$(tput setab 11) Instalação concluída! $(tput sgr0)"
exit 0
