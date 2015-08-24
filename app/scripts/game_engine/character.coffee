class GameEngine.Character extends GameEngine.Element
  constructor: (config) ->
    @pov = false
    @velocity =
      x: 0
      y: 0
    @speed =
      x: config.speedX || 0
      y: config.speedY || 0
    @savedPosition = null
    @action = 'still'
    @direction = 'down'
    super config

  setAsPov: ->
    @pov = true
    GameEngine.Display.updateCameraSettings {
      povSize:
        width: @width
        height: @height
    }

  saveCurrentPosition: ->
    @savedPosition = {
      x: @position.x
      y: @position.y
      z: @position.z
    }

  updatePositionByVelocity: ->
    @position.x += @velocity.x
    @position.y += @velocity.y

  restorePreviousPosition: ->
    @position.x = @savedPosition.x
    @position.y = @savedPosition.y
    @position.z = @savedPosition.z

  handleInput: ->
    handleMovement = (axisNegative, axisPositive, axis) =>
      if (not axisNegative and not axisPositive) or (axisNegative and axisPositive)
        @velocity[axis] = 0
      else
        if axisPositive
          @velocity[axis] = @speed[axis]
          if axis is 'x'
            @direction = 'right'
          else
            @direction = 'down'
        else if axisNegative
          @velocity[axis] = -1 * @speed[axis]
          if axis is 'x'
            @direction = 'left'
          else
            @direction = 'up'

    handleMovement keydown.left, keydown.right, 'x'
    handleMovement keydown.up, keydown.down, 'y'

    if @velocity.x is 0 and @velocity.y is 0
      @action = 'still'
    else
      @action = 'moving'

  move: ->
    @animation.goToState(@action + '-' + @direction)
    @animation.move()

    @saveCurrentPosition()
    @updatePositionByVelocity()

    elemCollision = GameEngine.AreaManager.activeArea.elementsCollideWith @colElem

    if elemCollision is 'SQUARE'
      @restorePreviousPosition()
    else
      if @pov then GameEngine.Display.setCamera @position.x, @position.y


class CharacterManagerClass extends GameEngine.Manager
  constructor: ->
    @managedObject = GameEngine.Character
    super

  createAt: (x, y, z) ->
    item = undefined
    if @itemData.collision_element
      colElem = GameEngine.CollisionManager.create @itemData.collision_element

    item = @createItem {
      width: @itemData.dimensions[0]
      height: @itemData.dimensions[1]
      speedX: @itemData.speed[0]
      speedY: @itemData.speed[1]
      image: if @itemData.image then GameEngine.ImageManager.create(@itemData.image) else null
      animation: if @itemData.animation then GameEngine.AnimationManager.create(@itemData.animation) else null
      x: x
      y: y
      z: z
      colElem: colElem
    }

    if colElem then colElem.parent = item
    return item

GameEngine.CharacterManager = new CharacterManagerClass()
