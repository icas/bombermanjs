class GameEngine.Area
  constructor: ->
    @height = 0
    @width = 0
    @images = []
    @elements = []
    @collsionElements = []
    @data = undefined

  loadImages: ->
    for img in @data.images
      for coord in img.at
        @images.push {
          image: GameEngine.ImageManager.create(img.id)
          x: coord[0]
          y: coord[1]
          z: img.layer || 0
        }

  loadElements: ->
    for elem in @data.elements
      GameEngine.ElementManager.setDataFor GameData.Elements[elem.id]
      for coord in elem.at
        @elements.push GameEngine.ElementManager.createAt(coord[0], coord[1], elem.layer || 0)

  loadCollisionElements: ->
    for colElemData in @data.collision_elements
      @collsionElements.push GameEngine.CollisionManager.create(colElemData)

  elementsCollideWith: (colElem) ->
    collisionType = 'NONE'
    if @elements
      inx = 0
      while inx < @elements.length and collisionType is 'NONE'
        collisionType = @elements[inx].collidesWith colElem
        inx++
    if @collsionElements
      inx = 0
      while inx < @collsionElements.length and collisionType is 'NONE'
        collisionType = GameEngine.CollisionManager.collision colElem, @collsionElements[inx]
        inx++
    return collisionType

  load: (data) ->
    @data = data
    @width = @data.width
    @height = @data.height
    if @data.images then @loadImages()
    if @data.elements then @loadElements()
    if @data.collision_elements then @loadCollisionElements()

  sketch: ->
    for img in @images
      GameEngine.Display.sketch img.image, img.x, img.y, (img.z * @height)
    for elem in @elements
      elem.sketch()

class AreaManagerClass
  constructor: ->
    @activeArea = null

  load: (data) ->
    @activeArea = new GameEngine.Area()
    @activeArea.load data

    GameEngine.Display.updateCameraSettings {
      areaSize:
        width: @activeArea.width
        height: @activeArea.height
    }
    return @activeArea

GameEngine.AreaManager = new AreaManagerClass()











