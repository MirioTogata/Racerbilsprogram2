class SelveBil { //klasse der styrer alting for den ene bil. Dette er HELE bilen
  boolean slut = false; //en boolean der er sandt eller falsk ift. om den har nået slutningen.
  Bil bil = new Bil(); //der laves motorer og krop
  Sensorer sensor = new Sensorer(); //der laves sensorer til bilen som kan mærke om den er ved at støde ind i en væg
  NeuralNet neuralNet; //En hjerne til bilen, som vælger hvormeget de skal reagere på sensorene

  SelveBil(float[] weights, float[] biass) { //vægtene og biasene fås når bilen bliver lavet
    neuralNet = new NeuralNet(weights, biass); //hjernen laves med de vægte og bias den har fået.
  }


  void update() { //main updatering
    bil.update(); //updater bilens location
    sensor.update(bil.pos, bil.vel); //updater så sensorene om de ser noget
    bil.turn(neuralNet.output(sensor.leftBlackSensor, sensor.rightBlackSensor, sensor.leftGreenSensor,sensor.rightGreenSensor,sensor.leftRedSensor,sensor.rightRedSensor)); //drej ift. hvad sensorene ser
    if (slut == true) { //hvis bilen har vundet
      contenders.add(new SelveBil(neuralNet.vaegt,neuralNet.bias)); //tilføj den til vinderene
      slut = true; //ændrer boolean til sandt, som senere sletter den fra hovedsystemet
    }
  }
  void display() { //main billede-visning
    bil.display(); //viser bilen..
    sensor.display(bil.pos); //viser sensorene..
  }
}
