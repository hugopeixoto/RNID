#!/bin/bash

source "scripts/functions.sh"

# Visto que para um destes casos podem os ficheiros continuar disponíveis e o
# incumprimento ser à mesma resolvido atravás da disponibilização, em paralelo,
# dos documentos em formatos abertos, este teste vai "jogar pelo seguro" e
# dizer que o incumprimento pode já estar resolvido (obrigando a uma revisão
# manual) caso a página tenha mudado

financas_tabelas_retencao_xlsx() {
  curl "https://info.portaldasfinancas.gov.pt/pt/apoio_contribuinte/tabela_ret_doclib/_vti_bin/portalat/docs.svc/groupeddocs?fields=DocIcon,Title,FileSizeDisplay&groups=Year:DESC&selectedvalues=2020&filter=%3CIsNotNull%3E%3CFieldRef%20Name%3D%22ID%22%3E%3C%2FFieldRef%3E%3C%2FIsNotNull%3E&sort=Year:DESC,Title:ASC&id=27&_=1596569078032" |
    jq '.data[0].data|map(.url)'
}

financas_contactos_xlsx() {
  curl "https://info.portaldasfinancas.gov.pt/pt/dgci/contactos_servicos/enderecos_contactos/_vti_bin/portalat/docs.svc/listdocs?fields=DocIcon,Title&sort=Name:DESC;&filter=%3CIsNotNull%3E%3CFieldRef%20Name%3D%22ID%22%3E%3C%2FFieldRef%3E%3C%2FIsNotNull%3E&id=20&_=1596569501257" |
    jq -r '.data[][]' |
    hxselect -s '\n' 'a::attr(href)'
}

financas_formularios() {
  curl "https://info-aduaneiro.portaldasfinancas.gov.pt/pt/publicacoes_formularios/formularios/_vti_bin/portalat/docs.svc/listdocs?fields=DocIcon,Modelo,Title&sort=Seq:ASC,Seq_2:ASC,Title:ASC&filter=<IsNotNull><FieldRef Name="ID"></FieldRef></IsNotNull>&id=35"
}

financas_efatura_export() {
  echo "- aceder a https://faturas.portaldasfinancas.gov.pt/consultarDocumentosAdquirente.action"
  echo "- fazer login, se necessário"
  echo "- tentar utilizar a opção 'Obter dados para Excel' num browser sem flash"
}

financas_efatura_saft() {
  echo "- aceder a https://faturas.portaldasfinancas.gov.pt/enviarSaftAppletForm.action"
  echo "- fazer login, se necessário"
  echo "- ver se aparece a mensagem 'O Browser utilizado não permite a execução de aplicações Java'"
}

incumprimento "Portal das Finanças" "https://portaldasfinancas.gov.pt" \
  "XLS, XLSX e DOC" "https://info.portaldasfinancas.gov.pt/pt/apoio_contribuinte/tabela_ret_doclib/Pages/default.aspx" \
  diff financas_tabelas_retencao_xlsx

incumprimento "Portal das Finanças" "https://portaldasfinancas.gov.pt" \
  "Endereços e contactos em XLSX" "https://www.portaldasfinancas.gov.pt/pt/contactosEbalcao.action" \
  diff financas_contactos_xlsx

incumprimento "Portal das Finanças" "https://portaldasfinancas.gov.pt" \
  "Formulários em formatos proprietários" "https://info-aduaneiro.portaldasfinancas.gov.pt/pt/publicacoes_formularios/formularios/Pages/formularios.aspx" \
  diff financas_formularios

incumprimento "Portal das Finanças" "https://portaldasfinancas.gov.pt" \
  "Exportação de faturas precisa de Flash" "https://faturas.portaldasfinancas.gov.pt/consultarDocumentosAdquirente.action" \
  manual financas_efatura_export

incumprimento "Portal das Finanças" "https://portaldasfinancas.gov.pt" \
  "Enviar ficheiro SAF-T exige Java" "https://faturas.portaldasfinancas.gov.pt/enviarSaftAppletForm.action" \
  manual financas_efatura_saft
