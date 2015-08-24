class GameEngine.CollisionElement
  constructor: (config) ->
    @parent = config.parent || {
      # Si no se define un parent para el CollisionElement, se crea un dummy parent
      # localizado en 0, 0, 0. Es decir, un parent relativo al display port.
      position: {
        x: 0, y: 0, z: 0
      }
    }
    @offset = {
      x: config.offsetX || 0
      y: config.offsetY || 0
    }
    @width = config.width || 0
    @height = config.height || 0
    @type = config.type || 'SQUARE'

  zIndex: -> @parent.position.z
  top: -> @parent.position.y + @offset.y
  bottom: -> @parent.position.y + @offset.y + @height
  left: -> @parent.position.x + @offset.x
  right: -> @parent.position.x + @offset.x + @width

class CollisionManagerClass extends GameEngine.Manager
  constructor: ->
    @managedObject = GameEngine.CollisionElement
    super

  create: (itemData) ->
    @itemData = itemData
    item = @createItem {
      offsetX: @itemData.offset[0]
      offsetY: @itemData.offset[1]
      width: @itemData.dimensions[0]
      height: @itemData.dimensions[1]
    }
    return item

  collision: (a, b) ->
    collisionType = 'NONE'
    if (a.zIndex() is b.zIndex()) and (a isnt b)
      if b.type is 'SQUARE'
        if a.bottom() > b.top() and a.top() < b.bottom()  # if a is within b's y boundaries
          if a.right() > b.left() and a.left() < b.right() # if a is within b's x boundaries
            collisionType = b.type
    return collisionType

  # collidesWith: (cElem) ->
  #   collisionType = 'NONE'
  #   inx = 0
  #   while inx < @collection.length and collisionType is 'NONE'
  #     if cElem isnt @collection[inx]
  #       collisionType = @collision cElem, @collection[inx]
  #     inx++
  #   return collisionType

GameEngine.CollisionManager = new CollisionManagerClass()
