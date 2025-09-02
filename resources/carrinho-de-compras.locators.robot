
*** Variables ***

# Configurações de navegador e página inicial
${BROWSER_NAME}            chrome
${URL_BASE}                https://www.saucedemo.com/v1/inventory.html
${URL_CART}                https://www.saucedemo.com/v1/cart.html
${URL_CHECKOUT}            https://www.saucedemo.com/v1/checkout-step-one.html
${URL_CHECKOUT_OVERVIEW}   https://www.saucedemo.com/v1/checkout-step-two.html

# Elementos da página da loja virtual
${INVENTORY_ITEMS}         css=.inventory_item
${ADD_TO_CART_BUTTONS}     css=.btn_inventory
${LINK_SHOPCART}           css=.shopping_cart_link
${LINK_CHECKOUT}           css=.checkout_button
${INPUT_FIRSTNAME}         id=first-name
${INPUT_LASTNAME}          id=last-name
${INPUT_ZIPCODE}           id=postal-code
${BUTTON_CONTINUE}         css=.cart_button[value="CONTINUE"]
${ITEM_PRICES}             css=.inventory_item_price
${TOTAL_LABEL}             css=.summary_total_label
${TAX_LABEL}               css=.summary_tax_label
${LINK_FINISH}             css=a.cart_button
${SUCCESS_DIV}             id=checkout_complete_container
${SUCCESS_MESSAGE}         css=h2.complete-header

