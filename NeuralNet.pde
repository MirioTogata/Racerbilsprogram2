class NeuralNet {
  float[] vaegt = new float[8]; //starter med at definerer vægt og bias til vores neurale netværk
  float[] bias = new float[3];

  NeuralNet(float[] weights, float[] biass) { //konstruktør der sætter dem lig med det som bilsystem har sagt de skal være
    for (int i = 0; i < vaegt.length+bias.length-1; i++) { //forloop der kører igennem alle værdierne
      if (i < 8) {
        vaegt[i] = weights[i];
      } else {
        bias[i-8] = biass[i-8];
      }
    }
  }

  float output(float var1, float var2, float var3) { //en funktion der finder ud af hvor meget bilen skal dreje baseret på sensorene og værdierne i det neurale netværk.
    float out1 = vaegt[0]*var1+vaegt[1]*var2+vaegt[2]*var3+bias[0]; //en vægt til hver sensor, og en bias det påvirker den alle flat
    float out2 = vaegt[3]*var1+vaegt[4]*var2+vaegt[5]*var3+bias[1];
    return out1*vaegt[6]+out2*vaegt[7]+bias[2]; //returnere hvor meget den skal dreje
  }
}
