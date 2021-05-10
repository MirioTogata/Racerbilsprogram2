class Sensorer {
  float sensorMag = 30; //hvor langt sensorene rækker ud
  float sensorAngle = PI/12; //hvor meget de drejer ud fra hvor bilen vender
  int yellowSensor, leftBlackSensor, rightBlackSensor, leftRedSensor, rightRedSensor, leftGreenSensor, rightGreenSensor; //int værdier til om der er i en væg eller ej
  PVector vectorBlackLeft = new PVector(0, sensorMag);
  PVector vectorBlackRight = new PVector(0, sensorMag);
  PVector vectorRedLeft = new PVector(0, sensorMag);
  PVector vectorRedRight = new PVector(0, sensorMag);
  PVector vectorGreenLeft = new PVector(0, sensorMag); //selve vectorene for sensorene. Går fra bilen ud til punktet hvor den checker
  PVector vectorGreenRight = new PVector(0, sensorMag);
  PVector[] vectorer = {vectorBlackLeft,vectorBlackRight,vectorRedLeft,vectorRedRight,vectorGreenLeft,vectorGreenRight};

  void update(PVector pos, PVector vel) { //updaterer positionen af vektorene
    vectorBlackLeft.set(vel); //sætter den foreste vektor op først, og så kopier bare de andre ud fra den.
    vectorBlackLeft.normalize(); //teknik er at sætte den lig med hastighed vektor. Gøre længden til 1, og så gange med hvor lang den faktisk skal være
    vectorBlackLeft.mult(sensorMag);
    vectorBlackLeft.rotate(-sensorAngle);
    vectorBlackRight.set(vectorBlackLeft);
    vectorBlackRight.rotate(sensorAngle*2);
    vectorRedLeft.set(vectorBlackLeft);
    vectorRedLeft.rotate(-sensorAngle);
    vectorRedRight.set(vectorBlackLeft);
    vectorRedRight.rotate(sensorAngle*3);
    vectorGreenLeft.set(vectorRedLeft);
    vectorGreenLeft.rotate(-sensorAngle);
    vectorGreenRight.set(vectorRedLeft);
    vectorGreenRight.rotate(sensorAngle*5);

    if (get((int)(pos.x+vectorBlackLeft.x), (int)(pos.y+vectorBlackLeft.y)) == color(0)) {
      leftBlackSensor = 1;
    } else {
      leftBlackSensor = 0;
    }

    if (get((int)(pos.x+vectorBlackRight.x), (int)(pos.y+vectorBlackRight.y)) == color(0)) {
      rightBlackSensor = 1;
    } else {
      rightBlackSensor = 0;
    }

    if (get((int)(pos.x+vectorRedLeft.x), (int)(pos.y+vectorRedLeft.y)) == color(237,28,36)) {
      leftRedSensor = 1;
    } else {
      leftRedSensor = 0;
    }

    if (get((int)(pos.x+vectorRedRight.x), (int)(pos.y+vectorRedRight.y)) == color(237,28,36)) {
      rightRedSensor = 1;
    } else {
      rightRedSensor = 0;
    }
    
     if (get((int)(pos.x+vectorGreenLeft.x), (int)(pos.y+vectorGreenLeft.y)) == color(34,177,76)) {
      leftGreenSensor = 1;
    } else {
      leftGreenSensor = 0;
    }

    if (get((int)(pos.x+vectorGreenRight.x), (int)(pos.y+vectorGreenRight.y)) == color(34,177,76)) {
      rightGreenSensor = 1;
    } else {
      rightGreenSensor = 0;
    }
    
    if (get((int)(pos.x+vel.x), (int)(pos.y+vel.y)) == color(255,242,0)) {
      yellowSensor = 1;
    } else {
      yellowSensor = 0;
    }
    
    
  }

  void display(PVector pos) { //tegner bare sensorene og deres vektore. Ændrer farve ift. om den er inde eller ude
    if (frontsensor == -1) {
      fill(10, 250, 10);
    } else {
      fill(250, 10, 10);
    }
    circle(pos.x+vectorFront.x, pos.y+vectorFront.y, 10);

    if (leftsensor == -1) {
      fill(10, 250, 10);
    } else {
      fill(250, 10, 10);
    }
    circle(pos.x+vectorLeft.x, pos.y+vectorLeft.y, 10);

    if (rightsensor == -1) {
      fill(10, 250, 10);
    } else {
      fill(250, 10, 10);
    }
    circle(pos.x+vectorRight.x, pos.y+vectorRight.y, 10);

    line(pos.x, pos.y, pos.x+vectorFront.x, pos.y+vectorFront.y);
    line(pos.x, pos.y, pos.x+vectorLeft.x, pos.y+vectorLeft.y);
    line(pos.x, pos.y, pos.x+vectorRight.x, pos.y+vectorRight.y);
  }
}
