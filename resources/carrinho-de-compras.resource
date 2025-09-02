*** Settings ***
Library        SeleniumLibrary                                        # Biblioteca do Selenium
Library        String                                                 # Manipulação de strings
Library        Collections                                            # Listas
Library        OperatingSystem                                        # For random sampling
Resource      ./carrinho-de-compras.locators.robot                    # Locators

# Helper functions

*** Keywords ***

Obter Todos Os Preços
    [Arguments]             ${locator_1}               ${locator_2}
    ${elements_1}           Get WebElements            ${locator_1}
    ${elements_2}           Get WebElements            ${locator_2}
    ${elements}             Combine Lists              ${elements_1}    ${elements_2}
    ${prices}               Create List
    FOR    ${el}    IN      @{elements}
        ${text}             Get Text                   ${el}
        ${matches}          Get Regexp Matches         ${text}      [0-9]+\.[0-9]+
        ${amount}           Set Variable               ${matches}[0]
        ${amount}           Convert To Number          ${amount}
                            Append To List             ${prices}    ${amount}
    END
    RETURN                  ${prices}
    
Obter Preço Via Elemento
    [Arguments]             ${locator}
    ${text}                 Get Text                   ${locator}
    ${matches}              Get Regexp Matches         ${text}    [0-9]+\.[0-9]+
    ${amount}               Set Variable               ${matches}[0]
    ${amount}               Convert To Number          ${amount}
    RETURN                  ${amount}

Contar Itens de Inventário
    ${items}                Get WebElements            ${INVENTORY_ITEMS}
    ${count}                Get Length                 ${items}
    RETURN                  ${count}

Obter Amostra Aleatória de Itens de Inventário
    ${max}                  Contar Itens de Inventário
    ${sample_size}          Evaluate                   random.choice(range(1,${max}))                    random
    @{sample}               Evaluate                   random.sample(range(0,${max}), ${sample_size})    random
    RETURN                  @{sample}