
//This is the class that handles the individual particles, the particles use a lookup to determine their accleration by looking at the direction of the vector (controlled by the flowfield class) below them, then moves in that direction.
class Dot {

  PVector location;
  PVector acceleration;
  PVector velocity;
  float mass;
  float xOff;
  float lifeTime;
  color col;
  float size;
  
  //The array below is an 2D array that stores colour palletes
  color[][] colPs = { {color(235,176,74), color(38,58,56), color(64,63,59)}, //0.new york underground
    {color(132,185,43), color(135,157,240), color(118,215,231)}, //1.film photo of the inside of a car, towards the steering wheel
    {color(255,168,187), color(196,39,48), color(0,33,60)}, //2.infared photograph /pink infared 
    {color(17,17,17),color(254,254,254),color(167,167,167)}, //3.black and white film pallete
    {color(147,158,150),color(218,196,173),color(190,217,231)}, //4.film photo of the sea
    {color(57,55,69),color(83,113,151),color(190,185,179)}, //5.Photo out of a plane onto mountains 
    {color(255,167,216),color(50,186,200),color(29,38,97)}, //6.neon signs at night
    {color(208,117,158),color(242,231,235),color(92,124,199)}, //7.Mount Fuji
    {color(random(255)),color(random(255)),color(random(255))},
  };
  int pallete;

  Dot(PVector origin,int tPalallete, float tSize) {
    
    location = new PVector(origin.x, origin.y);
    acceleration = new PVector();
    velocity = new PVector();
    mass = random(5, 60);
    xOff = 0;
    lifeTime = random(10, 30); 
    pallete = tPalallete;
    int palleteClock = int(random(0, 3));
    col = colPs[pallete][palleteClock];
    size = tSize;
  }

  void display() {

    //float noise = map(noise(xOff), 0, 1, 0, 255);
    float alphaNoise = map(lifeTime, 0, 255, 30, 200);

    push();
    lifeTime -= 0.1;
    fill(col, alphaNoise);
    stroke(alphaNoise*2,alphaNoise); 
    translate(location.x, location.y);
    //rotate(acceleration.heading());
    circle(0,0,lifeTime/size);

    pop();
    xOff += 0.01;
  }

  void update() {

    velocity.add(acceleration);
    location.add(velocity);

    velocity.limit(1);
  }

  void applyForce(PVector force) {

    PVector f = force.get();
    f.div(mass);

    acceleration = f;
    acceleration.setMag(0.1); 
  }

  boolean isDead() {

    if (lifeTime <= 0) {
      return true;
    } else {
      return false;
    }
  }

 
  void edges() {
    if (location.x >= width) {
      location.x = 0;
    } else if (location.x <= 0) {
      location.x = width;
    }   
    if (location.y >= height) {
      location.y = 0;
    } else if (location.y <= 0) {
      location.y = height;
    }
  }
}
