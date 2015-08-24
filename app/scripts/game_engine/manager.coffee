class GameEngine.Manager
  constructor: ->
    @collection = []
    @managedObject = @managedObject || undefined
    @itemData = null

  setDataFor: (itemData) ->
    @itemData = itemData

  createItem: (config) ->
    newItem = new @managedObject(config)
    @collection.push newItem
    return newItem






