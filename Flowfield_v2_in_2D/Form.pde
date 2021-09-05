//The forms that the particles are made up are created here using several methods, mostly for loops to initalize the points into an ArrayList which then manipulates the dots using a particle system, I found these to be a much
//more efficent way of handling the particles so that there could be a animated element to the piece. The type of form is decided in the RarityHandler.

Flowfield backF;
ArrayList<Dot> backD;
int amplitude = ceil(random(100, 300));
int pallete;

class Form {

  float theta;
  float vel;
  float acl;
  float radius;

  Form() {
    backF = new Flowfield(10, 0.001);
    backD = new ArrayList<Dot>();
    backF.init();
  }

  void createBackground() {
    for (int i = 0; i < 4000; i++) {
      backD.add(new Dot(new PVector(random(-200, width + 200), random( -200, height + 200)), 8, 4));
      for (int j = 0; j < backD.size(); j++) {
        Dot bD = backD.get(j); 

        bD.display();
        bD.applyForce(backF.follow(bD.location));
        bD.update();
        if (bD.isDead()) {
          backD.remove(j);
        }
      }
    }
  }

  void createSinWave() {
    for (int i = 0; i < activeW*2; i++) {
      d.add(new Dot(new PVector(activeW + i, height/2 + map(sin(theta), -1, 1, -amplitude, amplitude)), pallete, 1));
      theta += 0.02;
    }
  }

  void createThickRectangle() {
    for (int x = activeW; x < width - activeW + resolution; x += resolution) {
      for (int y = activeH; y < height - activeH + resolution; y += resolution) {
        d.add(new Dot(new PVector(x, y), pallete, 1));
      }
    }
  }

  void createThinRectangle() {
    for (int x = activeW; x < width - activeW; x += resolution) {
      for (int y = activeW; y < height - activeW + resolution; y += resolution) {
        d.add(new Dot(new PVector(x, y), pallete, 1));
      }
    }
  }

  void createCircle() {
    acl = 0.1;
    radius = width * random(0.035, 0.20);
    for (int i = 0; i < 300; i++) {

      float x = radius * cos(theta) + width/2;
      float y = radius * sin(theta) +height/2;
      d.add(new Dot(new PVector(x, y), pallete, 1));

      vel += acl;
      theta += acl;
    }
  }
}
