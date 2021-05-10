class NeuralNet {
  float[] vaegt = new float[21]; //starter med at definerer vægt og bias til vores neurale netværk
  float[] bias = new float[4];

  NeuralNet(float[] weights, float[] biass) { //konstruktør der sætter dem lig med det som bilsystem har sagt de skal være
    for (int i = 0; i < vaegt.length+bias.length-1; i++) { //forloop der kører igennem alle værdierne
      if (i < 8) {
        vaegt[i] = weights[i];
      } else {
        bias[i-vaegt.length] = biass[i-vaegt.length];
      }
    }
  }

  float output(float var1, float var2, float var3, float var4, float var5, float var6) { //en funktion der finder ud af hvor meget bilen skal dreje baseret på sensorene og værdierne i det neurale netværk.
    float out1 = vaegt[0]*var1+vaegt[1]*var2+vaegt[2]*var3+vaegt[3]*var4+vaegt[4]*var5+vaegt[5]*var6+bias[0]; //en vægt til hver sensor, og en bias det påvirker den alle flat
    float out2 = vaegt[6]*var1+vaegt[7]*var2+vaegt[8]*var3+vaegt[9]*var4+vaegt[10]*var5+vaegt[11]*var6+bias[1];
    float out3 = vaegt[12]*var1+vaegt[13]*var2+vaegt[14]*var3+vaegt[15]*var4+vaegt[16]*var5+vaegt[17]*var6+bias[2];
    return out1*vaegt[18]+out2*vaegt[19]+out3*vaegt[20]+bias[3];//returnere hvor meget den skal dreje
  }
}
