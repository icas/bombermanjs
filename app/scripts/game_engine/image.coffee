class GameEngine.GameImage
  constructor: (imgSrc) ->
    @htmlImage = new Image()
    @src = imgSrc
    @width = 0
    @height = 0
    @loaded = false

  load: (callback) ->
    if not @loaded
      @htmlImage.src = @src
      @htmlImage.onload = () =>
        @loaded = true
        @width = @htmlImage.width
        @height = @htmlImage.height
        callback()
    else
      callback()

class ImageManagerClass extends GameEngine.Manager
  constructor: ->
    @managedObject = GameEngine.GameImage
    @loadCallback = undefined
    @loading = false
    @leftToLoad = 0
    super

  loadAll: (callback) ->
    @loadCallback = callback
    @loading = true
    imageKeys = Object.keys(@collection)
    @leftToLoad = imageKeys.length
    for key in imageKeys
      @collection[key].load @imageLoaded

  imageLoaded: () =>
    @leftToLoad--
    if @leftToLoad <= 0
      @loading = false
      @loadCallback()
      @loadCallback = undefined

  create: (id) ->
    if not @collection[id]
      @collection[id] = new @managedObject(GameEngine.Config.imagePath + id)
    return @collection[id]

GameEngine.ImageManager = new ImageManagerClass()

