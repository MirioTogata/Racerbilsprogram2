class Sensorer {
  float sensorMag = 20;
  float sensorAngle = PI/12; 
  float[] sensors = new float[6];
  PVector[] vectors = new PVector[6];

  Sensorer() {
    for (int i = 0; i < vectors.length; i++) {
      vectors[i] = new PVector(0, sensorMag);
    }
  }

  void update(PVector pos, PVector vel) {
    sensorMag = SensorLength;
    PVector last = new PVector(vel.x, vel.y);
    last.normalize();
    last.mult(sensorMag);
    for (int i = 0; i < vectors.length; i += 2) {
      vectors[i].set(last);
      vectors[i].rotate(-sensorAngle);
      vectors[i+1].set(last);
      vectors[i+1].rotate(sensorAngle*i);
      last = vectors[i].copy();
    }

    for (int i = 0; i < sensors.length; i++) {
      color c = color(0);
      if (i > 1) {
        c = color(237, 28, 36);
      } 
      if (i > 3) {
        c = color(34, 177, 76);
      } 

      if (get((int)(pos.x+vectors[i].x), (int)(pos.y+vectors[i].y)) == c) {
        sensors[i] = 1;
      } else {
        sensors[i] = 0;
      }
    }
  }

  void display(PVector pos) {
    for (int i = 0; i < vectors.length; i++) {
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
