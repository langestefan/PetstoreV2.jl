
# Store {#Store}

Access to Petstore orders

## Returns pet inventories by status {#Returns-pet-inventories-by-status}

`GET /store/inventory`
<OAOperation operationId="getInventory" />


## Place an order for a pet {#Place-an-order-for-a-pet}

`POST /store/order`
<OAOperation operationId="placeOrder" />


## Delete purchase order by ID {#Delete-purchase-order-by-ID}

`DELETE /store/order/{orderId}`
<OAOperation operationId="deleteOrder" />


## Find purchase order by ID {#Find-purchase-order-by-ID}

`GET /store/order/{orderId}`
<OAOperation operationId="getOrderById" />

