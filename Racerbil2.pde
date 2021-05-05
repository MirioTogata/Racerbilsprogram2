PImage bane; 
boolean stagePicked = false;
int antalbiler = 200;
BilSystem bilSystemet = new BilSystem(antalbiler); //Laver mit hovedbilsystem som styrer "alt"
ArrayList<SelveBil> contenders = new ArrayList<SelveBil>(); //Laver en liste med dem som vinder, altså bliver listen langsomt større

void setup() {
  size(1000, 1000);
  pickStagedraw();
}

void draw() {
  if (stagePicked) {
    image(bane, 0, 0);
    bilSystemet.run(); //kører alting for bilerne der skal køres
  }
}


void pickStagedraw() {
  background(50);
  fill(255);
  textSize(50);
  text("Venstre-klik på banen du vil bruge:", 70, 200);
  for (int i = 0; i <= 5; i++) {
    bane = loadImage("Bane" + (i+1) +".png");
    bane.resize(250, 0);
    if (i < 3) {
      image(bane, 75+(i)*300, 350);
    } else {
      image(bane, 75+(i-3)*300, 650);
    }
  }
}

void mousePressed() {
  if (stagePicked == false) {
    for (int i = 1; i <= 3; i++) {
      if (mouseX > 75+(i-1)*300 && mouseX < (325+(i-1)*300)) {
        if (mouseY > 650) {
          i+= 3;
        }
        bane = loadImage("Bane" + i +".png");
        stagePicked = true;
        break;
      }
    }
  }
}
