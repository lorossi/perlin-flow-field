class Particle {
  PVector pos, vel, acc;
  float r, scl, t_scl, max_vel, seed;
  float variance, alpha, hue, hue_offset;
  boolean colored, inverted;

  Particle(float _scl, float _t_scl, float _hue_offset, boolean _colored, boolean _inverted, float _variance) {
    //particle position, velocity and acceleration
    pos = new PVector(random(width), random(height));
    vel = new PVector();
    acc = new PVector();

    r = .5; //particle radius
    scl = _scl;
    t_scl = _t_scl;
    max_vel = 1; //max speed
    seed = random(255); //some random seed
    alpha = 0;
    hue_offset = _hue_offset;
    colored = _colored;
    inverted = _inverted;
    variance = _variance;
  }

  void show() {
    push();

    if (colored) { //colored
      fill(hue, 255, 255, alpha);
    } else if (!colored && !inverted) { //white on black
      fill(255, alpha);
    } else if (!colored && inverted) { //black on white
      fill(0, alpha);
    }

    noStroke();
    translate(pos.x, pos.y);
    ellipse(0, 0, r * 2, r * 2);

    pop();
  }

  void move() {
    float n, a, mag, t;

    t = (float) frameCount / 60 / t_scl * map(seed, 0, 255, 1-variance, 1+variance);
    vel.mult(0); //resets speed at every iteration

    n = noise(pos.x / scl, pos.y / scl, t);
    a = map(n, 0, 1, 0, TWO_PI * 50);

    n = noise(pos.x / scl + 100, pos.y / scl + 100, t + 100);
    mag = map(n, 0, 1, 0, 4);

    n = noise(pos.x / scl + 200, pos.y / scl + 200, t / 2 + 200);
    if (!colored && inverted) { //if it's black and white, we need more alpha
      alpha = map(n, 0, 1, 3, 6);
    } else {
      alpha = map(n, 0, 1, 2, 5);
    }

    n  = noise(pos.x / scl / 1.5 + 300, pos.y / scl / 1.5 + 300, t + 300);
    hue = (map(n, 0, 1, 0, 255) + hue_offset) % 255;

    acc = PVector.fromAngle(a).setMag(mag);
    vel.add(acc);
    vel.limit(max_vel);
    pos.add(vel);

    //The following section checks if the particle is out of the screen and
    //resets it to a random location
    boolean reset = false;
    if (pos.x > width || pos.x < 0) {
      reset = true;
    }
    if (pos.y > height || pos.y < 0) {
      reset = true;
    }

    if (reset) {
      pos = new PVector(random(width), random(height));
      acc.mult(0);
    }
  }

}
