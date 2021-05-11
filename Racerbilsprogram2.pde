import controlP5.*;
ControlP5 cp5;
PImage bane; 
boolean stagePicked = false;
int pickedStage = 0;
float neuralvarians = 2;
int antalbiler = 200;
int levetiden = 10;
float MutationsRate = 2;
float FriktionAddition = 0.4;
int SensorLength = 25;
Slider neuralslider, bilslider, levetid, Mutationslider, Friktionslider, SensorLengthslider;
BilSystem bilSystemet; //Laver mit hovedbilsystem som styrer "alt"
ArrayList<SelveBil> contenders = new ArrayList<SelveBil>(); //Laver en liste med dem som vinder, altså bliver listen langsomt større

void setup() {
  size(1000, 1000);
  cp5 = new ControlP5(this);
  neuralslider = cp5.addSlider("neuralvarians").setPosition(100, 170).setRange(0, 4).setSize(200, 30).setNumberOfTickMarks(41);
  bilslider = cp5.addSlider("antalbiler").setPosition(400, 170).setRange(50, 350).setSize(200, 30);
  levetid = cp5.addSlider("levetiden").setPosition(700, 170).setRange(5, 20).setSize(200, 30);
  SettingsScreen();
}

void draw() {
  if (stagePicked) {
    image(bane, 50, 100);
    checkpoints();
    bilSystemet.run(); //kører alting for bilerne der skal køres
    println(mouseX + " " + mouseY);
  }
}


void SettingsScreen() {
  background(50);
  fill(255);
  textSize(50);
  text("Venstre-klik på banen du vil bruge:", 70, 300);
  text("Vælg dine start-parametre:", 70, 100);
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
        if (mouseY > 350) {
          bane = loadImage("Bane" + i +".png");
          bane.resize(900, 0);
          pickedStage = i;
          bilSystemet = new BilSystem(antalbiler);
          background(0);
          neuralslider.setVisible(false);
          bilslider.setVisible(false);
          levetid.setVisible(false);
          Mutationslider = cp5.addSlider("MutationsRate").setPosition(100, 50).setRange(0, 10).setSize(200, 30);
          Friktionslider = cp5.addSlider("FriktionAddition").setPosition(400, 50).setRange(0, 1).setSize(200, 30);
          SensorLengthslider = cp5.addSlider("SensorLength").setPosition(700, 50).setRange(10, 40).setSize(200, 30);
          stagePicked = true;
          break;
        }
      }
    }
  }
}

void checkpoints() {
  if (pickedStage == 1) {
  } else if (pickedStage == 2) {
  } else if (pickedStage == 3) {
  } else if (pickedStage == 4) {
  } else if (pickedStage == 5) {
  } else if (pickedStage == 6) {
  } else {
    println("what da hec");
  }
}
