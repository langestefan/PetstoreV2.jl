# Pet

Everything about your Pets

## Add a new pet to the store

`POST /pet`

```@raw html
<OAOperation operationId="addPet" prefix-headings="true" />
```

## Update an existing pet

`PUT /pet`

```@raw html
<OAOperation operationId="updatePet" prefix-headings="true" />
```

## Finds Pets by status

`GET /pet/findByStatus`

```@raw html
<OAOperation operationId="findPetsByStatus" prefix-headings="true" />
```

## Finds Pets by tags

`GET /pet/findByTags`

```@raw html
<OAOperation operationId="findPetsByTags" prefix-headings="true" />
```

## Deletes a pet

`DELETE /pet/{petId}`

```@raw html
<OAOperation operationId="deletePet" prefix-headings="true" />
```

## Find pet by ID

`GET /pet/{petId}`

```@raw html
<OAOperation operationId="getPetById" prefix-headings="true" />
```

## Updates a pet in the store with form data

`POST /pet/{petId}`

```@raw html
<OAOperation operationId="updatePetWithForm" prefix-headings="true" />
```

## uploads an image

`POST /pet/{petId}/uploadImage`

```@raw html
<OAOperation operationId="uploadFile" prefix-headings="true" />
```
