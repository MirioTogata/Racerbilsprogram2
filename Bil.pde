class Bil {
  PVector pos = new PVector(450, 200);
  PVector vel = new PVector(5, 0);
  float acclkinda = 1;

  void update() {
    if (acclkinda > 1) {
      acclkinda -= 0.01;
    } else if (acclkinda < 1) {
      acclkinda += 0.01;
    }
    if (get((int)pos.x, (int)pos.y) == color(34, 177, 76)) {
      acclkinda = FriktionAddition+1;
    }
    if (get((int)pos.x, (int)pos.y) == color(237, 28, 36)) {
      acclkinda = 1-FriktionAddition;
    }
    pos.add(vel.copy().mult(acclkinda));
  }
  void turn(float angle) {
    vel.rotate(angle);
  }
  void display() {
    fill(250, 10, 10);
    circle(pos.x, pos.y, 14);
  }
}
