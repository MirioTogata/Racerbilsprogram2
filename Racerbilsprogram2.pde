import controlP5.*;
ControlP5 cp5;
PImage bane; 
boolean stagePicked = false;
int pickedStage = 0;
float neuralvarians = 2;
int antalbiler = 200;
int levetiden = 15;
int MutationsRate = 2;
float FriktionAddition = 0.4;
int SensorLength = 35;
int time = 0;
Slider neuralslider, bilslider, levetid, Mutationslider, Friktionslider, SensorLengthslider;
BilSystem bilSystemet; //Laver mit hovedbilsystem som styrer "alt"

void setup() {
  size(1600, 1000);
  cp5 = new ControlP5(this);
  neuralslider = cp5.addSlider("neuralvarians").setPosition(400, 170).setRange(0, 4).setSize(200, 30).setNumberOfTickMarks(41).setColorCaptionLabel(1);
  bilslider = cp5.addSlider("antalbiler").setPosition(700, 170).setRange(50, 350).setSize(200, 30).setColorCaptionLabel(1);
  levetid = cp5.addSlider("levetiden").setPosition(1000, 170).setRange(10, 30).setSize(200, 30).setColorCaptionLabel(1);
  SettingsScreen();
}

void draw() {
  if (stagePicked) {
    background(0);
    image(bane, 350, 100);
    checkpoints();
    fill(255);
    textSize(25);
    text("Mutationsprocent", 395, 50);
    text("Hastighed i rød og grøn", 660, 50);
    text("Sensor Længde", 1010, 50);
    bilSystemet.run(); //kører alting for bilerne der skal køres
    if ((millis()-time) > levetiden*1000) {
      if (second() % levetiden == 0) {
        time = millis();
        bilSystemet.nextgeneration();
      }
    }
  }
}

void SettingsScreen() {
  background(50);
  fill(0);
  rect(375, 120, 850, 100);
  fill(255);
  textSize(25);
  text("Neural Varians", 415, 155);
  text("Antal Biler", 735, 155);
  text("Levetiden", 1045, 155);
  textSize(50);
  text("Venstre-klik på banen du vil bruge", 370, 300);
  text("Vælg dine start-parametre", 370, 80);
  for (int i = 0; i <= 5; i++) {
    bane = loadImage("Bane" + (i+1) +".png");
    bane.resize(250, 0);
    if (i < 3) {
      image(bane, 375+(i)*300, 350);
    } else {
      image(bane, 375+(i-3)*300, 650);
    }
  }
}

void mousePressed() {
  if (stagePicked == false) {
    for (int i = 1; i <= 3; i++) {
      if (mouseX > 375+(i-1)*300 && mouseX < (625+(i-1)*300)) {
        if (mouseY > 650) {
          i+= 3;
        }
        if (mouseY > 350) {
          bane = loadImage("Bane" + i +".png");
          bane.resize(900, 0);
          pickedStage = i;
          bilSystemet = new BilSystem(antalbiler);
          neuralslider.setVisible(false);
          bilslider.setVisible(false);
          levetid.setVisible(false);
          Mutationslider = cp5.addSlider("MutationsRate").setPosition(400, 70).setRange(0, 50).setSize(200, 30).setColorCaptionLabel(1);
          Friktionslider = cp5.addSlider("FriktionAddition").setPosition(700, 70).setRange(0, 1).setSize(200, 30).setColorCaptionLabel(1);
          SensorLengthslider = cp5.addSlider("SensorLength").setPosition(1000, 70).setRange(10, 60).setSize(200, 30).setColorCaptionLabel(1);
          stagePicked = true;
          time = millis();
          break;
        }
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    if (bilSystemet.anyPoints() == true) {
      time = millis();
      bilSystemet.nextgeneration();
    }
  }
}

void checkpoints() {
  strokeWeight(8);
  if (pickedStage == 1) {
    stroke(225, 242, 0);
    line(750, 140, 750, 240);
    stroke(235, 242, 0);
    line(1015, 290, 1015, 380);
    stroke(245, 242, 0);
    line(580, 560, 580, 680);
    stroke(255, 242, 0);
    line(990, 740, 990, 835);
  } else if (pickedStage == 2) {
    stroke(225, 242, 0);
    line(550, 410, 650, 321);
    stroke(235, 242, 0);
    line(850, 440, 950, 440);
    stroke(245, 242, 0);
    line(1050, 535, 1180, 550);
    stroke(255, 242, 0);
    line(700, 660, 690, 835);
  } else if (pickedStage == 3) {
    stroke(225, 242, 0);
    line(785, 160, 785, 255);
    stroke(235, 242, 0);
    line(1077, 385, 1200, 385);
    stroke(245, 242, 0);
    line(985, 836, 985, 950);
    stroke(255, 242, 0);
    line(600, 370, 600, 485);
  } else if (pickedStage == 4) {
    stroke(225, 242, 0);
    line(500, 674, 622, 622);
    stroke(235, 242, 0);
    line(710, 432, 800, 333);
    stroke(245, 242, 0);
    line(775, 260, 802, 162);
  } else if (pickedStage == 5) {
    stroke(225, 242, 0);
    line(385, 375, 510, 375);
    stroke(235, 242, 0);
    line(715, 540, 893, 540);
    stroke(245, 242, 0);
    line(385, 580, 515, 580);
    stroke(255, 242, 0);
    line(1018, 570, 1145, 577);
  } else if (pickedStage == 6) {
    stroke(225, 242, 0);
    line(486, 323, 575, 226);
    stroke(235, 242, 0);
    line(641, 452, 700, 322);
    stroke(245, 242, 0);
    line(750, 566, 858, 458);
    stroke(255, 242, 0);
    line(720, 740, 1035, 600);
  } else {
    println("what da hec");
  }
  strokeWeight(1);
  stroke(0);
}
