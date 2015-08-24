class GameEngine.Game
  constructor: ->
    #Debe refactorizarse para pedir el canvas, el area y el chara como parámetros

    GameEngine.Display.initialize 'main-canvas' # debe ser inicializado antes que lo demás o causará errores. REFACTORIZAR!
    @area = GameEngine.AreaManager.load GameData.Areas['test-1']
    GameEngine.CharacterManager.setDataFor GameData.Characters['chara']
    @chara = GameEngine.CharacterManager.createAt 140, 90, 0
    @chara.setAsPov()

  gameLoop: =>
    requestAnimationFrame @gameLoop

    GameEngine.Display.refresh()

    @chara.handleInput();
    @chara.move();
    @chara.sketch()
    @area.sketch()

    GameEngine.Display.stroke()

  start: ->
    GameEngine.ImageManager.loadAll @gameLoop

