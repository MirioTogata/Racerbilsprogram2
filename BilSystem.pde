class BilSystem {
  ArrayList<SelveBil> BilListe = new ArrayList<SelveBil>();
  int crashedbiler = 0;
  BilSystem(int antalbiler) { 
    for (int i = 0; i < antalbiler; i++) { 
      float[] weights = new float[21];
      float[] biass = new float[4];
      for (int j = 0; j < weights.length+biass.length-1; j++) {
        if (j < weights.length) {
          weights[j] = random(-neuralvarians, neuralvarians);
        } else {
          biass[j-weights.length] = random(-neuralvarians, neuralvarians);
        }
      }

      SelveBil bil = new SelveBil(weights, biass);
      BilListe.add(bil);
    }
  }
  void run() { 
    for (int i = BilListe.size()-1; i >= 0; i--) { 
      if (get((int)BilListe.get(i).bil.pos.x, (int)BilListe.get(i).bil.pos.y) == color(0)) {
        if (BilListe.get(i).bil.vel.x != 0 || BilListe.get(i).bil.vel.y != 0) {
          BilListe.get(i).bil.vel.set(0, 0);
          crashedbiler += 1;
        }
      }
    }
    for (SelveBil bil : BilListe) { 
      bil.update();
    }
    for (SelveBil bil : BilListe) {
      bil.display();
    }

    for (int i = 1; i <= bilericheckpoint.length; i++) {
      bilericheckpoint[i-1] = 0;
      for (SelveBil bil : BilListe) {
        if (bil.points == i*(i+1)/2) { //its a feature
          bilericheckpoint[i-1] += 1;
        }
      }
    }
  }

  boolean anyPoints() {
    for (SelveBil bil : BilListe) {
      if (bil.points > 0) {
        return true;
      }
    }
    return false;
  }

  void nextgeneration() { 
    generationtal++;
    crashedbiler = 0;

    IntList allepoint = new IntList();
    int totalpoint = 0;
    for (SelveBil bil : BilListe) {
      allepoint.append(bil.points);
      totalpoint += bil.points;
    }

    ArrayList<SelveBil> foraeldre = new ArrayList<SelveBil>();
    for (int i = 0; i < 2*antalbiler; i++) {
      int cumuStyrke = 0;
      int randomnum = (int)random(0, totalpoint);
      for (int j = 0; j < allepoint.size(); j++) {
        cumuStyrke += allepoint.get(j);
        if (cumuStyrke > randomnum) {
          foraeldre.add(BilListe.get(j));
          break;
        }
      }
    }

    for (int i = bilSystemet.BilListe.size()-1; i >=0; i--) {
      bilSystemet.BilListe.remove(i);
    }

    for (int i = 0; i < foraeldre.size(); i += 2) { 
      float[] weights = new float[21]; 
      float[] biass = {foraeldre.get(i).neuralNet.bias[0], foraeldre.get(i+1).neuralNet.bias[1], foraeldre.get(i).neuralNet.bias[2], foraeldre.get(i+1).neuralNet.bias[3]};

      for (int j = 0; j < weights.length; j++) {
        if (j < 11) {
          weights[j] = foraeldre.get(i).neuralNet.vaegt[j];
        } else {
          weights[j] = foraeldre.get(i+1).neuralNet.vaegt[j];
        }
      }

      if ((int)random(1, 100) <= MutationsRate) {
        int j = (int)random(0, weights.length+biass.length-1);
        if (j < 21) {
          weights[j] = random(-neuralvarians, neuralvarians); 
        } else {
          biass[j-21] = random(-neuralvarians, neuralvarians);
        }
      }

      SelveBil bil = new SelveBil(weights, biass); 
      bilSystemet.BilListe.add(bil);
    }
  }
}
