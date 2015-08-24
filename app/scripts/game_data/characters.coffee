GameData.Characters = GameData.Characters || {}

GameData.Characters['chara'] = {
  id: "chara"
  xxdimensions: [49, 80]
  dimensions: [69, 90]
  speed: [4, 4]
  animation: {
    image: "bomberman.png"
    frame_dimensions: [69, 100]
    states: [
      { id: "still-down", default: true, steps: 4, step_length: 8 },
      { id: "still-right", steps: 4, step_length: 8 },
      { id: "still-up", steps: 4, step_length: 8 },
      { id: "still-left", steps: 4, step_length: 8 },
      { id: "moving-down", steps: 8, step_length: 5 },
      { id: "moving-right", steps: 8, step_length: 5 },
      { id: "moving-up", steps: 8, step_length: 5 },
      { id: "moving-left", steps: 8, step_length: 5 },
      { id: "death", steps: 2, step_length: 5 }
    ]
  }
  xxxanimation: {
    image: "chara.png"
    frame_dimensions: [74, 90]
    states: [
      { id: "still-down", default: true, steps: 1 },
      { id: "still-up", steps: 1 },
      { id: "still-right", steps: 1 },
      { id: "still-left", steps: 1 },
      { id: "moving-down", steps: 2, step_length: 10 },
      { id: "moving-up", steps: 2, step_length: 10 },
      { id: "moving-right", steps: 2, step_length: 10 },
      { id: "moving-left", steps: 2, step_length: 10 },
      { id: "death", steps: 2, step_length: 5 }
    ]
  }
  collision_element: {
    type: "square"
    dimensions: [44, 23]
    offset: [12, 72]
  }
  xxcollision_element: {
    type: "square"
    dimensions: [40, 30]
    offset: [17, 55]
  }
}
