class SelveBil { //klasse der styrer alting for den ene bil. Dette er HELE bilen
  int points = 0;
  boolean[] checkpoints = new boolean[4];
  Bil bil = new Bil(); //der laves motorer og krop
  Sensorer sensor = new Sensorer(); //der laves sensorer til bilen som kan mærke om den er ved at støde ind i en væg
  NeuralNet neuralNet; //En hjerne til bilen, som vælger hvormeget de skal reagere på sensorene

  SelveBil(float[] weights, float[] biass) { //vægtene og biasene fås når bilen bliver lavet
    neuralNet = new NeuralNet(weights, biass); //hjernen laves med de vægte og bias den har fået.
  }


  void update() { //main updatering
    bil.update(); //updater bilens location
    sensor.update(bil.pos, bil.vel); //updater så sensorene om de ser noget
    bil.turn(neuralNet.output(sensor.sensors)); //drej ift. hvad sensorene ser

    for (int i = 0; i < checkpoints.length; i++) {
      if (get((int)(bil.pos.x+sensor.vectors[6].x), (int)(bil.pos.y+sensor.vectors[6].y)) == color(225+i*10, 242, 0)) {
        if (checkpoints[i] == false) {
          points += 1+i;
          checkpoints[i] = true;
        }
      }
    }
  }
  void display() { //main billede-visning
    bil.display(); //viser bilen..
    sensor.display(bil.pos); //viser sensorene..
  }
}
