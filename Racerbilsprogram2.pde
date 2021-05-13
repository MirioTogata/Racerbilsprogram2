import controlP5.*;
ControlP5 cp5;
PImage bane; 
boolean stagePicked = false;
int pickedStage = 0;
float neuralvarians = 2;
int antalbiler = 200;
int levetiden = 15;
int MutationsRate = 10;
float FriktionAddition = 0.4;
int SensorLength = 35;
int time = 0;
boolean pause = false;
int pausetime = 0;
int generationtal = 1;
int[] bilericheckpoint = new int[4];
Slider neuralslider, bilslider, levetid, Mutationslider, Friktionslider, SensorLengthslider;
Button resetButton, endButton;
Textarea Tooltips;
BilSystem bilSystemet;

void setup() {
  size(1600, 1000);
  cp5 = new ControlP5(this);
  neuralslider = cp5.addSlider("neuralvarians").setPosition(400, 170).setRange(0, 4).setSize(200, 30).setNumberOfTickMarks(41).setColorCaptionLabel(1);
  bilslider = cp5.addSlider("antalbiler").setPosition(700, 170).setRange(50, 350).setSize(200, 30).setColorCaptionLabel(1);
  levetid = cp5.addSlider("levetiden").setPosition(1000, 170).setRange(10, 30).setSize(200, 30).setColorCaptionLabel(1);
  Mutationslider = cp5.addSlider("MutationsRate").setPosition(400, 70).setRange(0, 50).setSize(200, 30).setColorCaptionLabel(1);
  Friktionslider = cp5.addSlider("FriktionAddition").setPosition(700, 70).setRange(0, 1).setSize(200, 30).setColorCaptionLabel(1);
  SensorLengthslider = cp5.addSlider("SensorLength").setPosition(1000, 70).setRange(10, 60).setSize(200, 30).setColorCaptionLabel(1);
  resetButton = cp5.addButton("Reset").setValue(0).setPosition(40, 165).setSize(100, 50);
  endButton = cp5.addButton("Pause/Play").setValue(0).setPosition(180, 165).setSize(100, 50);
  Tooltips = cp5.addTextarea("tooltips").setPosition(1250, 50).setSize(200, 700).setFont(createFont("arial", 18)).setLineHeight(30).setColor(color(0)).setColorBackground(color(250, 250, 50)).setColorForeground(color(255, 100));

  Mutationslider.setVisible(false);
  Friktionslider.setVisible(false);
  SensorLengthslider.setVisible(false);
  resetButton.setVisible(false);
  endButton.setVisible(false);
}

void draw() {
  if (pause == false) {
    background(0);
    textSize(35);
    fill(255);
    text("Hover teksten for", 30, 50);
    text("at se mere", 30, 100);
    if (stagePicked) {
      image(bane, 350, 100);
      checkpoints();
      textSize(25);
      text("Generation: " + generationtal, 30, 300);
      text("Antal biler: " + antalbiler, 30, 330);
      text("Crashed Biler: " + bilSystemet.crashedbiler, 30, 360);
      text("Biler i checkpoint 1: " + bilericheckpoint[0], 30, 390);
      text("Biler i checkpoint 2: " + bilericheckpoint[1], 30, 420);
      text("Biler i checkpoint 3: " + bilericheckpoint[2], 30, 450);
      text("Biler i checkpoint 4: " + bilericheckpoint[3], 30, 480);
      text("Totale point: " + (bilericheckpoint[0]+bilericheckpoint[1]+bilericheckpoint[2]+bilericheckpoint[3]), 30, 510);
      text("Mutationsprocent", 395, 50);
      text("Hastighed i rød og grøn", 660, 50);
      text("Sensor Længde", 1010, 50);
      bilSystemet.run();
      if ((millis()-time) > levetiden*1000) {
        if (second() % levetiden == 0) {
          time = millis();
          bilSystemet.nextgeneration();
        }
      }
    } else {
      SettingsScreen();
    }
    if (resetButton.isPressed()) {
      neuralslider.setVisible(true);
      bilslider.setVisible(true);
      levetid.setVisible(true);
      Mutationslider.setVisible(false);
      Friktionslider.setVisible(false);
      SensorLengthslider.setVisible(false);
      resetButton.setVisible(false);
      endButton.setVisible(false);
      generationtal = 1;
      stagePicked = false;
    }
  }
  Tooltips();
}
void SettingsScreen() {
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
          Mutationslider.setVisible(true);
          Friktionslider.setVisible(true);
          SensorLengthslider.setVisible(true);
          resetButton.setVisible(true);
          endButton.setVisible(true);
          stagePicked = true;
          time = millis();
          break;
        }
      }
    }
  }
  if (endButton.isPressed()) {
    if (pause == false) {
      pausetime = millis();
      pause = true;
    } else {
      pause = false;
      time += millis()-pausetime;
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
    line(920, 740, 1035, 600);
  } else {
    println("what da hec");
  }
  strokeWeight(1);
  stroke(0);
}

void Tooltips() {
  if (neuralslider.isMouseOver()) {
    Tooltips.setVisible(true);
    Tooltips.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
  } else if (bilslider.isMouseOver()) {
    Tooltips.setVisible(true);
    Tooltips.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
  } else if (levetid.isMouseOver()) {
    Tooltips.setVisible(true);
    Tooltips.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
  } else if (Mutationslider.isMouseOver()) {
    Tooltips.setVisible(true);
    Tooltips.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
  } else if (Friktionslider.isMouseOver()) {
    Tooltips.setVisible(true);
    Tooltips.setText("Denne parameter bestemmer i hvor stor en grad bilerne bliver påvirket af henholdsvis det det grønne, og det røde terrain. Begge terrain giver en hastighedsændrene effekt imens bilerne er inde i feltet, og 4 sekunder efter bilerne har forladt feltet. Grøn øger hastigheden, og rød mindsker hastigheden.");
  } else if (SensorLengthslider.isMouseOver()) {
    Tooltips.setVisible(true);
    Tooltips.setText("Denne parameter styrer længden af sensorene som sidder på hver bil. Hver bil har 6 sensorer som modtager et input, og fører dette input videre ind i det neurale netværk. Sensorlængden har en betydelse for hvilke neurale netværk der klarer sig godt. Lange sensorer kan give bilerene en bedre chance for at opfatte sine omgivelser, men vil muligvis også gøre at bilerne overeagere.");
  } else {
    Tooltips.setVisible(false);
  }
}
