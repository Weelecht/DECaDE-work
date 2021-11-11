let dots = [];
const maxDots = 126;
let localCols = [];
let l;
let c;


function preload() {
    c = loadJSON("assets/colourjson.json");
}

function setup() {
    createCanvas(360,360);
    colorMode(RGB,255,255,255,255);
    l = new Latent();
    frameRate(60);

    for(let i = 0; i < c.data.length; i++) {
        localCols.push(c.data[i]);
    }
}

function draw() {
    background(20);

    let r = localCols[int(random(0,5))];

    if(dots.length < maxDots) {

        dots.push(new Dot(createVector(random(width),random(height)),r));
    }

    //l.display();
    l.update();
    l.edges();
  

    for(let i = 0; i < dots.length; i++) {

        let attraction = p5.Vector.sub(l.location,dots[i].location);
        dots[i].display();
        dots[i].update();
        dots[i].applyForce(attraction);
        dots[i].edges();

        if(dots[i].isDead()) {
            dots.splice(0,1);
        } 
    }
}

function mouseClicked() {
   let mouseV = createVector(mouseX,mouseY);

   l.location = mouseV;
}


class Dot {
    constructor(_location,_col) {
        this.history = [];
        this.location = createVector(_location.x,_location.y);
        this.velocity = createVector();
        this.acceleration = createVector();
        this.mass = random(3,23);
        this.size = 0;
        this.lifeTime = 255;
        this.col = _col;
        this.xOff = 0;
        
    }

    display() {

        if(this.size < this.mass) {
            this.size+= 0.1;
        }
        this.tipBrightness = this.size*TWO_PI;
        let aNoise = map(noise(this.xOff),0,1,0,this.tipBrightness); 
        this.col.push(this.lifeTime);
        this.tipCol = color(this.col[0] + aNoise,this.col[1] + aNoise,this.col[2] + aNoise,this.lifeTime);
      
        push();
        strokeWeight(this.size+aNoise/TWO_PI);
        stroke(this.tipCol);
        point(this.location.x,this.location.y);
        pop();

        for(let i = 0; i < this.history.length; i++) {
            push();
            strokeWeight(i);
            stroke(this.col);
            point(this.history[i].x,this.history[i].y);
            pop();

        }
        this.col.splice(3,1);
    
    }

    update() {

        this.velocity.add(this.acceleration);
        this.location.add(this.velocity);

        let trail = createVector(this.location.x,this.location.y);
        this.history.push(trail);
        if(this.history.length > this.size) {
            this.history.splice(0,1);
        }

        this.velocity.limit(3);
        this.acceleration.mult(0);
        this.lifeTime -= 0.5;
        this.xOff += 0.03;
        
    }

    applyForce(_force) {
        let f = p5.Vector.div(_force,this.mass);
        this.acceleration.add(f);
        this.acceleration.setMag(0.04);
    }

    edges() {

        if(this.location.x > width + 100 || this.location.x < 0 -100) {
            this.velocity.x *= -1;
        }
        if(this.location.y > height + 100 || this.location.y < 0 -100) {
            this.velocity.y *= -1;
        }
    }

    isDead() {

        if(this.lifeTime < 0) {
            return true;
        } else false;
    }
}

class Latent {
    constructor() {

        this.location = createVector(width/2,height);
        this.velocity = createVector();
        this.velocity = createVector();
    }

    update() {

        this.acceleration = p5.Vector.random2D();
        this.velocity.add(this.acceleration);
        this.location.add(this.velocity);

        this.velocity.limit(25);
    }

    edges() {

        if(this.location.x > width || this.location.x < 0) {
            this.velocity.x *= -1;
        }
        if(this.location.y > height || this.location.y < 0) {
            this.velocity.y *= -1;
        }

    }

    display() {
        push();
        fill(255);
        rect(this.location.x,this.location.y,20);
        pop();
    }

}
