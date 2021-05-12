class SelveBil { 
  int points = 0;
  boolean[] checkpoints = new boolean[4];
  Bil bil = new Bil();
  Sensorer sensor = new Sensorer(); 
  NeuralNet neuralNet; 

  SelveBil(float[] weights, float[] biass) { 
    neuralNet = new NeuralNet(weights, biass); 
  }


  void update() {
    bil.update(); 
    sensor.update(bil.pos, bil.vel);
    bil.turn(neuralNet.output(sensor.sensors)); 

    for (int i = 0; i < checkpoints.length; i++) {
      if (get((int)(bil.pos.x+sensor.vectors[6].x), (int)(bil.pos.y+sensor.vectors[6].y)) == color(225+i*10, 242, 0)) {
        if (checkpoints[i] == false) {
          points += 1+i;
          checkpoints[i] = true;
        }
      }
    }
  }
  void display() {
    bil.display(); 
    sensor.display(bil.pos); 
  }
}
