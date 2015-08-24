class GameEngine.Element
  constructor: (config) ->
    @active = true
    @position =
      x: config.x || 0
      y: config.y || 0
      z: config.z || 0
    @height = config.height || 0
    @width = config.width || 0
    @image = config.image || undefined
    @animation = config.animation || undefined
    @colElem = config.colElem || undefined

  bottom: -> (GameEngine.AreaManager.activeArea.height * @position.z) + @position.y + @height

  collidesWith: (otherColElem) ->
    collisionType = 'NONE'
    if @active and @colElem
      collisionType = GameEngine.CollisionManager.collision otherColElem, @colElem
    collisionType

  sketch: ->
    if @active
      if @animation
        # actualmente las animaciones tiene precedencia sobre las imágenes. Si se define animación para el elemento,
        # se grafica solo la animación.
        GameEngine.Display.sketchAnim @animation, @position.x, @position.y, @bottom()
      else
        if @image
          GameEngine.Display.sketch @image, @position.x, @position.y, @bottom()


class ElementManagerClass extends GameEngine.Manager
  constructor: ->
    @managedObject = GameEngine.Element
    super

  createAt: (x, y, z) ->
    item = undefined
    if @itemData.collision_element
      colElem = GameEngine.CollisionManager.create @itemData.collision_element

    item = @createItem {
      width: @itemData.dimensions[0]
      height: @itemData.dimensions[1]
      image: GameEngine.ImageManager.create(@itemData.image)
      animation: if @itemData.animation then GameEngine.AnimationManager.create(@itemData.animation) else null
      x: x
      y: y
      z: z
      colElem: colElem
    }

    if colElem then colElem.parent = item
    return item

GameEngine.ElementManager = new ElementManagerClass()
