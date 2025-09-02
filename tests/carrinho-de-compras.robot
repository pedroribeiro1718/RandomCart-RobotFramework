*** Comments ** 
Como um cliente da loja virtual
Eu quero adicionar produtos no meu carrinho de compras
Para que eu possa realizar uma compra

*** Settings ***
Library        SeleniumLibrary                                        # Biblioteca do Selenium
Resource      ../resources/carrinho-de-compras.locators.robot         # Locators
Resource      ../resources/carrinho-de-compras.resource               # Helper functions

*** Variables ***
${FIRSTNAME}    Pedro
${LASTNAME}     Ribeiro
${ZIPCODE}      01111000

*** Test Cases ***
Scenario: Adicionar produtos ao carrinho de compras e finalizar compra
    [Documentation]  Adiciona produtos e realiza compra com sucesso
    Given Eu estou na página inicial da loja virtual
    And Eu adiciono uma amostra aleatória de produtos ao meu carrinho
    When Eu confirmo meus dados e solicito a realização da compra
    Then Eu verifico se o valor total corresponde aos subtotais de cada produto, mais taxas
    Then Após a confirmação final, eu vejo uma mensagem de sucesso informando que a compra foi realizada

*** Keywords ***

Eu estou na página inicial da loja virtual
    Open Browser                    ${URL_BASE}                ${BROWSER_NAME}
    Maximize Browser Window
    Capture Page Screenshot         screenshots/01_pagina_inicial.png

Eu adiciono uma amostra aleatória de produtos ao meu carrinho
    @{sample}                       Obter Amostra Aleatória de Itens de Inventário
    @{BUTTONS}                      Get WebElements            ${ADD_TO_CART_BUTTONS}
    FOR    ${item_number}    IN     @{sample}
        Click Element               ${BUTTONS}[${item_number}]
    END
    Click Link                      ${LINK_SHOPCART}           # Acessando a página do carrinho
    Wait Until Location Contains    ${URL_CART}
    Capture Page Screenshot         screenshots/02_carrinho_de_compras.png

Eu confirmo meus dados e solicito a realização da compra
    Click Link                      ${LINK_CHECKOUT}           # Acessar a tela de checkout
    Wait Until Location Contains    ${URL_CHECKOUT}
    Input Text                      ${INPUT_FIRSTNAME}         ${FIRSTNAME}  
    Input Text                      ${INPUT_LASTNAME}          ${LASTNAME}  
    Input Text                      ${INPUT_ZIPCODE}           ${ZIPCODE}  
    Click Button                    ${BUTTON_CONTINUE}
    Wait Until Location Contains    ${URL_CHECKOUT_OVERVIEW}
    Wait Until Element Is Visible   ${TOTAL_LABEL}
    Scroll Element Into View        ${TOTAL_LABEL}
    Capture Page Screenshot         screenshots/03_resumo_de_compra.png

Eu verifico se o valor total corresponde aos subtotais de cada produto, mais taxas
    ${captured_total}               Obter Preço Via Elemento          ${TOTAL_LABEL}
    ${prices}                       Obter Todos Os Preços             ${ITEM_PRICES}         ${TAX_LABEL} 
    ${calculated_total}             Evaluate                          sum(${prices})            
                                    Should Be Equal As Numbers        ${calculated_total}    ${captured_total}

Após a confirmação final, eu vejo uma mensagem de sucesso informando que a compra foi realizada
    Click Link                      ${LINK_FINISH}
    Wait Until Element Is Visible   ${SUCCESS_DIV}
    ${success_text}                 Get Text                  ${SUCCESS_MESSAGE}
    Should Be Equal As Strings      ${success_text}           THANK YOU FOR YOUR ORDER
    Capture Page Screenshot         screenshots/04_compra_realizada_com_sucesso.png