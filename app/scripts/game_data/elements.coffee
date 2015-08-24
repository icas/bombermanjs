GameData.Elements = GameData.Elements || {}

GameData.Elements["block-solid"] = {
  image: "block-solid.png"
  dimensions: [70, 80]
  collision_element:
    type: "square"
    dimensions: [70, 60]
    offset: [0, 20]
}

GameData.Elements["block-brick"] = {
  image: "block-brick.png"
  dimensions: [70, 80]
  collision_element:
    type: "square"
    dimensions: [70, 60]
    offset: [0, 20]
}

GameData.Elements["vertical-wall"] = {
  image: "wall1x12.png"
  dimensions: [70, 760]
  collision_element:
    type: "square"
    dimensions: [70, 760]
    offset: [0, 0]
}

GameData.Elements["horizontal-wall"] = {
  image: "wall15x1.png"
  dimensions: [1050, 100]
  collision_element:
    type: "square"
    dimensions: [1050, 60]
    offset: [0, 40]
}
