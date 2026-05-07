# Store

Access to Petstore orders

## Returns pet inventories by status

`GET /store/inventory`

```@raw html
<OAOperation operationId="getInventory" prefix-headings="true" />
```

## Place an order for a pet

`POST /store/order`

```@raw html
<OAOperation operationId="placeOrder" prefix-headings="true" />
```

## Delete purchase order by ID

`DELETE /store/order/{orderId}`

```@raw html
<OAOperation operationId="deleteOrder" prefix-headings="true" />
```

## Find purchase order by ID

`GET /store/order/{orderId}`

```@raw html
<OAOperation operationId="getOrderById" prefix-headings="true" />
```
