class GameEngine.Animation
  constructor: (data) ->
    @image = if data.image then GameEngine.ImageManager.create data.image else null
    @frameWidth = data.frame_dimensions[0] || 0
    @frameHeight = data.frame_dimensions[1] || 0
    @currentStep = 0
    @stepIter = 0
    @currentState = undefined

    @loadStates data

  currentStepCoord: () ->
    return @currentStep * @frameWidth

  currentStateCoord: () ->
    return @states[@currentState].index * @frameHeight

  goToState: (newState) ->
    if newState isnt @currentState
      @currentState = newState
      @currentStep = 0
      @stepIter = 0

  move: () ->
    if @states[@currentState].steps > 1
      @stepIter++
      if @stepIter >= @states[@currentState].stepLength
        @stepIter = 0
        @currentStep++
        if @currentStep >= @states[@currentState].steps
          @currentStep = 0

  loadStates: (data) ->
    @states = []
    index = 0
    for state in data.states
      if not @currentState or state.default
        @currentState = state.id

      @states[state.id] = {
        index: index
        steps: state.steps || 1
        stepLength: state.step_length || 0
        default: state.default || false
      }
      index++

class AnimationManagerClass extends GameEngine.Manager
  constructor: ->
    @managedObject = GameEngine.Animation
    super

  create: (data) ->
    item = @createItem data
    return item

GameEngine.AnimationManager = new AnimationManagerClass()





