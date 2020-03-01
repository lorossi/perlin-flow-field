ArrayList < Particle > particles;

float hue_offset; //Sets a different base color
boolean colored; //Colored or black and white
boolean inverted; //If not colored, black particles on white background
int max_particles; //Number of particles
float scl; //Noise scale
float t_scl; //Time scale
float variance; //Adds some random movements

boolean automate; //Set to true to automatically export frames
int max_frames, last_saved, save_counter, max_saves;

void setup() {
    frameRate(10000);
    colorMode(HSB, 255, 255, 255, 255);
    smooth(8); //Smoother but slower
    size(900, 900);

    automate = true;
    //The following variables are to be considered only if automate is set to true
    //----------------------------------------------------------------------------
    max_saves = 100;     //Max number of frames to be saved
    save_counter = 0;  //Current Number of saved frames
    last_saved = 0;    //frameCount at which last frame was saved
    //----------------------------------------------------------------------------
    reset();
}


void draw() {
    for (Particle p: particles) {
        p.show();
        p.move();
    }

    //Periodically gives updates
    if (frameCount % 500 == 0) {
      if (automate) {
        println("fps", (int) frameRate, "| Frame count", frameCount, "| Saved", save_counter, "| Next save", last_saved + max_frames, "| Current frames", frameCount - last_saved, "| Max frames", max_frames);
      } else {
        println("fps", (int) frameRate, "| Frame count", frameCount);
      }
    }

    //If automate is set to true, this takes care of saving and quitting
    if (frameCount - last_saved >= max_frames && automate) {
        String folder = "frames";
        long epochTime = System.currentTimeMillis();

        if (colored) {
          folder = "colored";
        } else if (inverted) {
          folder = "black_on_white";
        } else if (!inverted) {
          folder = "white_on_black";
        }

        saveFrame("frames" + "/" + folder + "/" + epochTime + "_" + save_counter + ".png");
        save_counter++;
        if (save_counter >= max_saves) {
            exit();
        }
        reset();
    }

}


//Resets all variables and background
void reset() {
    long epochTime = System.currentTimeMillis();

    noiseSeed(epochTime);
    randomSeed(epochTime);

    hue_offset = random(255);
    colored = random(1) > (float) 2/3;
    inverted = random(1) > (float) 1/2;
    //chanches: 1/3 colored, 1/3 black on white, 1/3 white on black

    //(if automated = true) We need less total frames if everything is black
    //and white
    if (!colored) {
        max_frames = (int) random(10000, 12000);
    } else {
        max_frames = (int) random(12000, 14000);
    }

    max_particles = (int) random(1300, 1800);
    max_particles *= (int) pow(width/900, 2); //size normalization

    scl = random(600, 1200);
    scl /= pow(width/900, 2); //size normalization;

    t_scl = random(1500, 1600);
    t_scl /= pow(width/900, 2); //size normalization;

    variance = random(0.02);

    //Initates particles list
    particles = new ArrayList < Particle > ();
    for (int i = 0; i < max_particles; i++) {
        Particle p = new Particle(scl, t_scl, hue_offset, colored, inverted, variance);
        particles.add(p);
    }

    if (!colored && inverted) {
        background(255);
    } else {
        background(0);
    }

    last_saved = frameCount; //used in automation
}

void save() {
    saveFrame("perlin-##########.png");
    println("Frame saved");
}

void keyPressed() {
    //Spacebar is pressed
    if (keyCode == 32) {
        save();
    }
}

void mousePressed() {
  //If you click on the screen, every+ gets reset
    reset();
}
