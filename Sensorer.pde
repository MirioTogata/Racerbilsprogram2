class Sensorer {
  float sensorMag = 20; //hvor langt sensorene rækker ud
  float sensorAngle = PI/12; //hvor meget de drejer ud fra hvor bilen vender
  float[] sensors = new float[7];
  PVector[] vectors = new PVector[7];

  Sensorer() {
    for (int i = 0; i < vectors.length-1; i++) {
      vectors[i] = new PVector(0, sensorMag);
    }
  }

  void update(PVector pos, PVector vel) { //updaterer positionen af vektorene
    sensorMag = SensorLength;
      PVector last = new PVector(vel.x, vel.y);
    last.normalize();
    last.mult(sensorMag);
    for (int i = 0; i < vectors.length-1; i += 2) {
      vectors[i].set(last);
      vectors[i].rotate(-sensorAngle);
      vectors[i+1].set(last);
      vectors[i+1].rotate(sensorAngle*i);
      last = vectors[i].copy();
    }
    vectors[vectors.length-1] = vel.copy();

    for (int i = 0; i < sensors.length; i++) {
      color c = color(0);
      if (i > 1) {
        c = color(237, 28, 36);
      } 
      if (i > 3) {
        c = color(34, 177, 76);
      } 
      if (i > 5) {
        c = color(255, 242, 0);
      }

      if (get((int)(pos.x+vectors[i].x), (int)(pos.y+vectors[i].y)) == c) {
        sensors[i] = 1;
      } else {
        sensors[i] = 0;
      }
    }
  }

  void display(PVector pos) { //tegner bare sensorene og deres vektore. Ændrer farve ift. om den er inde eller ude
    for (int i = 0; i < vectors.length-1; i++) {
      color c = color(0);
      if (i > 1) {
        c = color(237, 28, 36);
      } 
      if (i > 3) {
        c = color(34, 177, 76);
      }

      fill(c);
      circle(pos.x+vectors[i].x, pos.y+vectors[i].y, 10);
      line(pos.x, pos.y, pos.x+vectors[i].x, pos.y+vectors[i].y);
    }
  }
}
