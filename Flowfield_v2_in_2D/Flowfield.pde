//This is "Vectorfield" class, currently it is set to be initialized by 2D perlin noise, although you could change its configuration by changing the theta value, this will give you a differing pattern. 
//The 2D perlin noise has drivers so it changes over time within the draw loop, this is something I worked on in another project and I brought it in here because I liked the affect.
//If you want to visualize the flowfield then you can uncomment the code within the nestedloop below and then turn on stroke and background clearing in the main file.
class Flowfield {
  int cols;
  int rows;
  int resolution;
  float speed = 0.005;
  float state = 0;
  float noiseLevel;

  //PVector[] field;
  PVector[][] f;

  Flowfield(int r, float noiseL) {

    resolution = r;
    noiseLevel = noiseL;
    cols = width/resolution;
    rows = height/resolution;
    f = new PVector[cols][rows];
  }

  void init() {
    state += speed;
    float xOff = state;
    for (int x = 0; x < cols; x++) {
      xOff += noiseLevel;
      float yOff = state;
      for (int y = 0; y < rows; y++) {
        yOff += noiseLevel;
    
        float theta = map(noise(xOff, yOff), 0, 1, 0, PI*4);
        

        PVector v = PVector.fromAngle(theta);

        f[x][y] = v;

        //push();
        //translate(x*resolution, y*resolution);
        //rotate(v.heading());
        //line(0, 0, resolution, 0);
        //pop();
      }
    }
  }

  PVector follow (PVector location) {
    int c = int(constrain(location.x/resolution, 0, cols-1));
    int r = int(constrain(location.y/resolution, 0, rows-1));
    return f[c][r].get();
  }
}
