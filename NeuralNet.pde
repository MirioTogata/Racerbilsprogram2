class NeuralNet {
  float[] vaegt = new float[21];
  float[] bias = new float[4];

  NeuralNet(float[] weights, float[] biass) {
    for (int i = 0; i < vaegt.length+bias.length-1; i++) { 
      if (i < vaegt.length) {
        vaegt[i] = weights[i];
      } else {
        bias[i-vaegt.length] = biass[i-vaegt.length];
      }
    }
  }

  float output(float[] var) {
    float out1 = vaegt[0]*var[0]+vaegt[1]*var[1]+vaegt[2]*var[2]+vaegt[3]*var[3]+vaegt[4]*var[4]+vaegt[5]*var[5]+bias[0];
    float out2 = vaegt[6]*var[0]+vaegt[7]*var[1]+vaegt[8]*var[2]+vaegt[9]*var[3]+vaegt[10]*var[4]+vaegt[11]*var[5]+bias[1];
    float out3 = vaegt[12]*var[0]+vaegt[13]*var[1]+vaegt[14]*var[2]+vaegt[15]*var[3]+vaegt[16]*var[4]+vaegt[17]*var[5]+bias[2];
    return out1*vaegt[18]+out2*vaegt[19]+out3*vaegt[20]+bias[3];
  }
}
