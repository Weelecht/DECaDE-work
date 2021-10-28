//The forms that the particles are made up are created here using several methods, mostly for loops to initalize the points into an ArrayList which then manipulates the dots using a particle system, I found these to be a much
//more efficent way of handling the particles so that there could be a animated element to the piece. The type of form is decided in the RarityHandler.


int pallete;

class Form {

  Flowfield backF;
  ArrayList<Dot> backD;
  ArrayList<PVector> cubes;
  int amplitude = ceil(random(100, 300));

  float theta;
  float vel;
  float acl;
  int boarderThickness;

  Form() {
    backF = new Flowfield(10, 0.001);
    backD = new ArrayList<Dot>();
    cubes = new ArrayList<PVector>();
    boarderThickness = ceil(random(50, 100));
    backF.init();
  }

  void createFlowBackground() {
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

  void createBoarder() {

    push();
    fill(color(random(255)));
    rect(0, 0, boarderThickness, height); //Left side
    rect(width -boarderThickness, 0, height, height); //Right side
    rect(0, 0, width, boarderThickness); //Top bar
    rect(0, height -boarderThickness, width, width);
    pop();
  }

  void createAltBackground() {
    int type = ceil(random(100));
    int skip = width/ceil(random(10, 25));
    for (int x = 0; x < width; x += skip) {
      for (int y = 0; y < height; y+= skip) {
        cubes.add(new PVector(x, y));
      }
    }
    println(type);

    for (int i = 0; i < cubes.size(); i++) {
      PVector c = cubes.get(i);
      push();
      fill(color(random(255)), random(30, 200));
      translate(c.x, c.y);
      if (type >= 33) { 
        circle(0, 0, ceil(random(skip/2,skip)));
      } else if (type >= 66) {
        square(0, 0, skip/2);
      } else {
        square(0, 0, skip);
      }
      pop();
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
    float radius = width * random(0.035, 0.20);
    int circleRartiy = int(random(100));
    println(circleRartiy);
    for (int i = 0; i < 300; i++) {

      float x = radius * cos(theta) + width/2;
      float y = radius * sin(theta) +height/2;
      d.add(new Dot(new PVector(x, y), pallete, 1));

      vel += acl;
      theta += acl;
    }
    if (circleRartiy > 90) {
      smallCircles(width/5, height/2);
      smallCircles(width-width/5, height/2);
    }
  }

  void smallCircles(float xOff, float yOff) {
    float radius = width*0.07;
    for (int i = 0; i < 300; i++) {

      float x = radius * cos(theta) + xOff;
      float y = radius * sin(theta) + yOff;
      d.add(new Dot(new PVector(x, y), pallete, 1));

      vel += acl;
      theta += acl;
    }
  }

  void createLemniscate() {
    float s = width/3;
    float x;
    float y;

    for (float i =  0; i < 6.5; i+= 0.01) {
      x = (s*cos(i))/(1+(sin(i))*(sin(i)))+ width/2;
      y = (s*sin(i)*cos(i))/(.75+(sin(i))/(sin(i)))+height/2;
      d.add(new Dot(new PVector(x, y), pallete, 1));
    }
  }
}
