class BilSystem {
  ArrayList<SelveBil> BilListe = new ArrayList<SelveBil>(); //En liste med alle bilerne i sig
  BilSystem(int antalbiler) { //constructør som kun bruges 1 gang, til at danne 200 helt tilfældige biler
    for (int i = 0; i < antalbiler; i++) { //kører igennem alle de biler der skal laves
      float[] weights = new float[21];
      float[] biass = new float[4];
      for (int j = 0; j < weights.length+biass.length-1; j++) { //et for loop der generer tilfælde værdier til det neurale netværk basseret på den neurale varians
        if (j < weights.length) {
          weights[j] = random(-neuralvarians, neuralvarians);
        } else {
          biass[j-weights.length] = random(-neuralvarians, neuralvarians);
        }
      }

      SelveBil bil = new SelveBil(weights, biass); //danner en ny bil med de værdier vi fandt før
      BilListe.add(bil); //adder det til listen af biler
    }
  }
  void run() { //Main kommando for alle billerne
    for (int i = BilListe.size()-1; i >= 0; i--) { //en liste der fjerne bilerne som er kørt galt
      if (get((int)BilListe.get(i).bil.pos.x, (int)BilListe.get(i).bil.pos.y) == color(0)) {
        BilListe.remove(i);
      }
    }
    for (SelveBil bil : BilListe) { //kører update for alle bilerne før display, så det er nemmere at bruge farvebaseret metoder.
      bil.update(); //main update for alle bilerne
    }
    for (SelveBil bil : BilListe) {
      bil.display(); //main display for alle bilerne
    }
  }

  void nextgeneration() { //funktion der sletter alle de gamle biler og laver 200 nye biler af vinderenes gener
    for (int i = bilSystemet.BilListe.size()-1; i >=0; i--) { //for loop der sletter alle de gamle
      bilSystemet.BilListe.remove(i);
    }
    for (int i = 0; i < antalbiler; i++) { //funktion der tæller igennem de 200 nye der skal laves
      int p1 = (int)random(0, contenders.size()-1); // 2 tilfælde forældre findes ud fra vinderene.
      int p2 = (int)random(0, contenders.size()-1);
      float[] weights = new float[8]; //der skal lave 8 weights til det neurale netværk, som vi definerer lige om lidt. Bias til det neurale netværk laves under.
      float[] biass = {contenders.get(p1).neuralNet.bias[0], contenders.get(p2).neuralNet.bias[1], contenders.get(p2).neuralNet.bias[2]}; //vi laver og definerer bias

      for (int j = 0; j < weights.length; j++) { //et forloop der laver vægten baseret på forældrene. En halv krop fra mor, og en halv krop fra far.
        if (j < 4) {
          weights[j] = contenders.get(p1).neuralNet.vaegt[j];
        } else {
          weights[j] = contenders.get(p2).neuralNet.vaegt[j];
        }
      }

      for (int j = 0; j < weights.length+biass.length-1; j++) { //forloop der laver mutationen for barnet. Den køres igennem for hvert eneste bias og vægt
        int mutation = (int)random(1, 20); //et tilfældigt tal fra 1-20, altså er mutationsprocent 5%
        if (mutation == 1) { //hvis tallet er 1, lav mutation på den ene bias eller vægt
          if (j < 8) {
            weights[j] = random(-neuralvarians, neuralvarians); //mutation i dette program betyder en tilfældig værdi baseret på den neurale varians istedet for det de fik fra forældrene.
          } else {
            biass[j-8] = random(-neuralvarians, neuralvarians); //gøres igen men for bias og ikke vægt.
          }
        }
      }

      SelveBil bil = new SelveBil(weights, biass); //der laves så en ny bil ud fra de tal
      bilSystemet.BilListe.add(bil); //bilen tilføjes til bilsystemet
    }
    for (int i = contenders.size()-1; i >= 0; i--) { //til sidst i funktionen bruger vi et forloop til at slette alle de gamle vinderene, for at gøre plads til nye
      contenders.remove(i);
    }
  }
}
