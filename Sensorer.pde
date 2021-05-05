class Sensorer {
  float sensorMag = 35; //hvor langt sensorene rækker ud
  float sensorAngle = PI/4; //hvor meget de drejer ud fra hvor bilen vender
  int leftsensor, rightsensor, frontsensor; //int værdier til om der er i en væg eller ej
  PVector vectorFront = new PVector(0, sensorMag); //selve vectorene for sensorene. Går fra bilen ud til punktet hvor den checker
  PVector vectorLeft = new PVector(0, sensorMag);
  PVector vectorRight = new PVector(0, sensorMag); //ville lægge dem i samme linje, men virker ikke med Java

  void update(PVector pos, PVector vel) { //updaterer positionen af vektorene
    vectorFront.set(vel); //sætter den foreste vektor op først, og så kopier bare de andre ud fra den.
    vectorFront.normalize(); //tenik er at sætte den lig med hastighed vektor. Gøre længden til 1, og så gange med hvor lang den faktisk skal være
    vectorFront.mult(sensorMag);
    vectorLeft.set(vectorFront); //kopier foreste vektor
    vectorLeft.rotate(-sensorAngle); //men drej
    vectorRight.set(vectorFront); //ditto det over
    vectorRight.rotate(sensorAngle);

    //her kommer tre if statements som bare fjerne en bug hvor der er gråt i banen, pga. png krav fra PImage
    frontsensor = get((int)(pos.x+vectorFront.x), (int)(pos.y+vectorFront.y));
    if (frontsensor == -16777216) {
      frontsensor = 0;
    }
    leftsensor = get((int)(pos.x+vectorLeft.x), (int)(pos.y+vectorLeft.y));
    if (leftsensor == -16777216) {
      leftsensor = 0;
    }
    rightsensor = get((int)(pos.x+vectorRight.x), (int)(pos.y+vectorRight.y));
    if (rightsensor == -16777216) {
      rightsensor = 0;
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
