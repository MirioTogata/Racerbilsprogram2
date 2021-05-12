class Bil {
  PVector pos = new PVector(450, 200); //position og hastighed dannes først
  PVector vel = new PVector(5, 0);
  float acclkinda = 1;

  void update() { //positionene opdateres når denne funktion er kaldet
  acclkinda = 1;
  if (get((int)pos.x,(int)pos.y) == color(34,177,76)){
    acclkinda += FriktionAddition;
  }
    if (get((int)pos.x,(int)pos.y) == color(237,28,36)){
    acclkinda -= FriktionAddition;
  }
    pos.add(vel.copy().mult(acclkinda));
  }
  void turn(float angle) { //den drejer ift. hvad det neurale netværk siger
    vel.rotate(angle);
  }
  void display() { //en funktion der tegner bilen
    fill(250, 10, 10);
    circle(pos.x, pos.y, 14);
  }
}
