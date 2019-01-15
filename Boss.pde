public abstract class Boss extends Enemy {
  float startTime, curTime, lifeTime, healthRegen;
  int cycle, phase;
  Boss() { 
  }
  Boss(float a, float b, PImage p) {
    super(a, b, p);
  }
}

public class BossPlain extends Boss {
  BossPlain() {
    diameter = 32;
    x = width-900;
    y = height/2;
    angle = 0;
    targetAngle = 0;
    diameter = 60;
    speed = 1;
    waitWalk = 0;
    waitShoot = 20;
   /// innacuracy = 0;
    float timer1 = waitWalk -1;
    float timer2 = waitShoot -1;
    closest = 100;
    currentHealth = 250;
    maxHealth = 250;
    dead = false;
  }
  public void  display(){
    angle = atan2(y-player.y, x-player.x);
    fill(#CE0606);
    pushMatrix();
    translate(x,y);
    rotate(angle+PI);
    imageMode(CENTER);
    image(boss,0,0);
    popMatrix();
    waitWalk=0;
  }
  public void update(){
   timer1++;
   timer2++;
   angle = atan2(player.getY() - y, player.getX() - x);
   shootAtPlayer();
   x += dx;
   y += dy;
   displayHealthBar();
  }
}

///////////////////////////////////////////////////////////////////////////
public class BossSniper extends Boss {
  private ArrayList<Laser> laserList;
  private float waitShoot, curTime, startTime;
  public BossSniper() {
    laserList = new ArrayList<Laser>();
    waitShoot = 300;
    curTime = 0;
    startTime = millis();
    maxHealth = 400;
    currentHealth = maxHealth;
  }
  public void update() {
    super.update();
    curTime = millis() - startTime;
    if (curTime > waitShoot) {
      laserList.add(new Laser());
      startTime = millis();
    }
    for (int i = 0; i < laserList.size(); i++) {
      laserList.get(i).update();
      if (laserList.get(i).getDead()) {
        laserList.remove(i);
      }
    }
  }
  public void display() {
    super.display();
    for (int i = 0; i < laserList.size(); i++) {
      laserList.get(i).display();
    }
  }
}

public class Laser extends Updateable {
  float lifeTime, curTime, startTime, damage;
  Bullet shot;
  public Laser(float xx, float yy, float life) {
    x = xx;
    y = yy;
    lifeTime = life;
    startTime = millis();
    damage = 12;
    shot = new GuidingEnemyBullet(x, y, player.getX(), player.getY(), life, damage);
  }
  public Laser() {
    damage = 12;
    int holder = floor(random(4));
    switch (holder) {
      case 0: x = random(width); y = -1; break; //top
      case 1: x = random(width); y = height+1; break; //bottom
      case 2: x = -1; y = random(height); break; //left
      case 3: x = width+1; y = random(height); break; //right
    }
    lifeTime = 5000;
    startTime = millis();
    curTime = 0;
    shot = new GuidingEnemyBullet(x, y, player.getX(), player.getY(), lifeTime, damage);
  }
  public void update() {
    shot.update();
    curTime = millis() - startTime;
    if (curTime > lifeTime || shot.getDead()) {
      dead = true;
    }
  }
  public void display() {
    shot.display();
    stroke(255, 0, 0);
    line(x, y, player.getX(), player.getY());
  }
}
///////////////////////////////////////////////////////////////////////////

public class BossBomb extends Boss {
  private ArrayList<Bomb> bombList;
  private float startTime, curTime, lifeTime;
  
  public BossBomb() {
    //
  }
}

public class Bomb extends Updateable {
  //
}



public class BossShane extends Boss {
  ArrayList<Updateable> shells;
  float startTime, curTime;
  public BossShane() {
    super(0, 3000, finalBoss); 
    shells = new ArrayList<Updateable>();
    waitShoot = 1000;
    startTime = millis();
    curTime = 0;
  }
  public void shootAtPlayer() {
    curTime = millis() - startTime;
    if (currentHealth >= maxHealth*0.75) {
      if (curTime >= waitShoot) {
        shells.add(new EnemyBullet(this));
        startTime = millis();
      }
    }
    else if (currentHealth >= maxHealth/2) {
      if (curTime >= waitShoot) {
        shells.add(new EnemyBomber(true, player.getX() + random(-20, 20), player.getY() + random(-20, 20)));
        startTime = millis();
      }
    }
    else if (currentHealth >= maxHealth*0.25) {
      if (curTime >= waitShoot) {
        shells.add(new Laser());
        startTime = millis();
      }
    }
  }
  public void update() {
    super.update();
    for (int i = 0; i < shells.size(); i++) {
      shells.get(i).update();
      if (shells.get(i).getDead()) {
        shells.remove(i);
      }
    }
  }
  public void display() {
    super.display();
    for (int i = 0; i < shells.size(); i++) {
      shells.get(i).display();
    }
  }
} 