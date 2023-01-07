#!/bin/bash

header () {
clear
printf "\n$(tput setab 202)                                                           " 
printf "\n$(tput setab 202) $(tput setab 4)      $(tput setab 202)                                                    "
printf "\n$(tput setab 202) $(tput setab 4)      $(tput setaf 0)$(tput setab 202)   App Itaú no Computador para Linux [NÃO-OFICIAL]  "
printf "\n$(tput setab 202) $(tput setaf 7)$(tput setab 4) Itaú $(tput setab 202)                                                    "
printf "\n$(tput setab 202)                                                           "
printf "\n$(tput setab 7)$(tput setaf 0) Script de Instalação                         v2022.01.002 \n"
tput sgr0
}

header
printf "\n\n$(tput setaf 0)$(tput setab 11) Informações sobre este script e declaração de ciência $(tput sgr0)\n\n"
printf "\n1. Este software e script foram criados para oferecer uma maneira de instalar o App Itaú no Computador dentro de ambientes Linux, facilitando a instalação de dependências necessárias para sua execução. Este script é oferecido de forma pública e gratuita, e o código é aberto e disponível para sugestões, melhorias e modificações.\n"
printf "\n2. Este script não é criado, fornecido, patrocinado ou auditado pelo Banco Itaú ou qualquer uma de suas subsidiárias de nenhuma maneira.\n"
printf "\n3. Este script é fornecido 'como é'/'como está', e não possui garantia de funcionamento pleno. Nenhuma pessoa envolvida com a criação deste script não é responsável por absolutamente nenhuma ocorrência ou dano causado no seu computador, nem é responsável por nenhum tipo de ocorrência ou problema na sua conta bancária.\n"
printf "\n4. Este software não fornece o binário do App Itaú no Computador e apenas baixa automaticamente o executável disponível publicamente no site https://guardiao.itau.com.br/UpdateServer/aplicativoitau.msi e executa as operações técnicas necessárias para assegurar seu funcionamento fora do ambiente Windows, e quaisquer dúvidas sobre suas funcionalidades devem ser redirecionadas ao Itaú Unibanco.\n"
printf "\n5. Este script, por si, não envia nenhum tipo de informação para seu criador nem para nenhum terceiro e não recolhe dados de nenhuma natureza.\n"
printf "\n6. O criador deste script, o Banco Itaú e qualquer outro colaborador deste projeto não tem nenhuma responsabilidade por manter e assegurar o pleno funcionamento deste software ou do projeto. Este script também pode parar de funcionar a qualquer momento e poderá eventualmente ser removido sem aviso prévio da disponibilização pública.\n"

printf "\nEventuais dúvidas sobre o funcionamento deste script podem ser resolvidas com o encaminhamento de uma issue em https://github.com/BRGustavoRibeiro/app-itau-para-linux\n"
printf "\n$(tput setaf 11)AO UTILIZAR ESTE SCRIPT, VOCÊ CONCORDA INTEGRALMENTE COM OS TERMOS ACIMA, E DECLARA TER TOTAL E PLENA CIÊNCIA DAS INFORMAÇÕES FORNECIDAS.\n\n"
tput sgr0
read -r -p "DESEJA CONTINUAR? (S/N): " response
case "$response" in
    [sS][iI][mM]|[sS]) 
        ;;
    *)
        printf "\nO software não será instalado.\n"
        exit 0
        ;;
esac

header
printf "\n\n$(tput setaf 0)$(tput setab 11) Qual versão você deseja instalar? $(tput sgr0)\n\n"

PS3="
Digite o número da opção: "
select opt in "Versão estável" "Versão beta" "Cancelar e sair";
  do
    case $opt in
      "Versão estável")
        DOWNLOADLINK="https://guardiao.itau.com.br/UpdateServer/aplicativoitau.msi"
        break ;;
      "Versão beta")
        DOWNLOADLINK="https://guardiao.itau.com.br/UpdateServer/aplicativoitau_novobeta.msi"
        break ;;
      "Cancelar e sair")
        exit ;;
      *)
        printf "Opção inválida!\n\n" ;;
  esac
done

printf "\n\n$(tput setaf 0)$(tput setab 11) Instalação iniciada! $(tput sgr0)\nIsto pode levar alguns minutos.\n\n"

sudo add-apt-repository -y ppa:flatpak/stable
sudo apt-get update

if ! [ $(which flatpak) ]
then
  sudo apt install -y flatpak
fi

if ! [ $(which bottles) ]
then
  sudo apt install -y flatpak
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak install flathub com.usebottles.bottles -y
fi

wget -O winsetup.msi $DOWNLOADLINK

flatpak run --command=bottles-cli com.usebottles.bottles new --bottle-name ItauLinux --environment application --arch win64
mv winsetup.msi $(eval echo ~)/.var/app/com.usebottles.bottles/.local/winsetup.msi
flatpak run --command=bottles-cli com.usebottles.bottles run -b ItauLinux -e $(eval echo ~)/.var/app/com.usebottles.bottles/.local/winsetup.msi --args /quiet
flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications
wget -O $(eval echo ~)/.local/share/applications/appitaulinux.desktop https://raw.githubusercontent.com/BRGustavoRibeiro/app-itau-para-linux/main/resources/appitaulinux.desktop
wget -O $(eval echo ~)/.var/app/com.usebottles.bottles/.local/itau-icon.png https://github.com/BRGustavoRibeiro/app-itau-para-linux/raw/main/resources/icon.png
sed -i "s#DIRETORIO#$(eval echo ~)#" $(eval echo ~)/.local/share/applications/appitaulinux.desktop

printf "\n\n$(tput setaf 0)$(tput setab 11) Instalação concluída! $(tput sgr0)\n\n"
exit 0
