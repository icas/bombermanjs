GameEngine.Display = new (() ->
  canvas = null
  width = 0
  height = 0
  context = null
  sketchboard = []

  camera = {
    x: 0
    y: 0
    # w: 0
    # h: 0
    maxX: 0
    maxY: 0
    povHalfWidth: 0
    povHalfHeight: 0
    displayHalfWidth: 0
    displayHalfHeight: 0
  }

  @initialize = (canvasId) ->
    canvas = $('#' + canvasId)[0]
    width = canvas.width
    height = canvas.height
    context = canvas.getContext('2d')
    @updateCameraSettings {
      displaySize:
        width: width
        height: height
    }
    # camera.w = width
    # camera.h = height

  @updateCameraSettings = (params) ->
    if params.povSize
      camera.povHalfWidth = params.povSize.width / 2
      camera.povHalfHeight = params.povSize.height / 2

    if params.areaSize
      camera.maxX = params.areaSize.width - width
      camera.maxY = params.areaSize.height - height

    if params.displaySize
      camera.displayHalfWidth = params.displaySize.width / 2
      camera.displayHalfHeight = params.displaySize.height / 2

    return

  @setCamera = (x, y) ->
    newX = (x + camera.povHalfWidth) - camera.displayHalfWidth
    newY = (y + camera.povHalfHeight) - camera.displayHalfHeight

    if newX < 0 then newX = 0
    if newY < 0 then newY = 0
    if newX > camera.maxX then newX = camera.maxX
    if newY > camera.maxY then newY = camera.maxY

    camera.x = newX
    camera.y = newY

  @sketch = (img, x, y, bottom) ->
    if not sketchboard[bottom]
      sketchboard[bottom] = []
    sketchboard[bottom].push {
      type: 'img'
      img: img
      xCoord: 0
      yCoord: 0
      fWidth: img.width
      fHeight: img.height
      x: x
      y: y
    }

  @sketchAnim = (anim, x, y, bottom) ->
    if not sketchboard[bottom]
      sketchboard[bottom] = []
    sketchboard[bottom].push {
      type: 'anim'
      img: anim.image
      xCoord: anim.currentStepCoord()
      yCoord: anim.currentStateCoord()
      fWidth: anim.frameWidth
      fHeight: anim.frameHeight
      x: x
      y: y
    }

  @stroke = () ->
    for bottom in sketchboard
      if bottom
        for sketch in bottom
          if sketch
            @show sketch.img, sketch.xCoord, sketch.yCoord, sketch.fWidth, sketch.fHeight, sketch.x, sketch.y
    return

  @show = (img, xCoord, yCoord, fWidth, fHeight, x, y) ->
    context.drawImage img.htmlImage, xCoord, yCoord, fWidth, fHeight, Math.floor(x - camera.x), Math.floor(y - camera.y), fWidth, fHeight


  @refresh = () ->
    context.clearRect 0, 0, width, height
    sketchboard = []

  return
)()




