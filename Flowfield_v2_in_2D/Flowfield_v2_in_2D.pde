Flowfield f;
Form form;
RarityHandler rHandler;
//This is the main file

//This is not finished but a decent halfway point to show what I've been doing

ArrayList<Dot> d;

int activeW;
int activeH;

int resolution = 20;

void setup() {
  fullScreen();
  //size(800, 800);
  colorMode(RGB);
  frameRate(60);
  noStroke();

  activeW = width/4;
  activeH = height/4;

  d = new ArrayList<Dot>();
  rHandler = new RarityHandler();
  form = new Form();
  f = new Flowfield(20, 0.1);

  rHandler.colSel();
  rHandler.distSel();

  background(50);
  
  //turning off the background flowfield will make the whole sketch run a lot faster, it's supposed
  //to be a rare trait anyway, but its just on right now because it looks nice.
  form.createBackground();
}

void draw() {
  //this is the core of the particle system
  f.init();

  for (int i = 0; i < d.size(); i++) {
    Dot dots = d.get(i);

    dots.display();
    //dots.edges();
    dots.applyForce(f.follow(dots.location));
    dots.update();

    if (dots.isDead()) {
      d.remove(i);
    }
  }
}
