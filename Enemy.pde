public class Enemy extends Alive {
  float waitWalk, waitShoot, timer1, timer2, closest;
  Enemy() {
    diameter = 32;
    x = random(diameter, width-diameter);
    y = random(diameter, height-diameter);
    angle = 0;
    targetAngle = 0;
    diameter = 30;
    speed = 1;
    waitWalk = 60;
    waitShoot = 80;
    timer1 = waitWalk -1;
    timer2 = waitShoot -1;
    closest = 100;
    currentHealth = 30;
    maxHealth = 30;
    dead = false;
    sprite = enemy1;
  }
  Enemy(float sspeed, float hhealth, PImage ssprite) {
    this();
    speed = sspeed;
    maxHealth = hhealth;
    currentHealth = hhealth;
    sprite = ssprite;
    diameter = sprite.width/2;
  }
  public void update() {
    timer1++;
    timer2++;
    angle = atan2(player.getY() - y, player.getX() - x);
    runToPlayer();
    shootAtPlayer();
    x += dx;
    y += dy;
    if (dead) {
      if (random (10) > 3) {
        game.getCurrentFloor().getCurrentRoom().dropItem(x, y);
      }
    }
  }
  public void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    imageMode(CENTER);
    image(sprite, 0, 0);
    popMatrix();
    displayHealthBar();
  }
  public void runToPlayer() {
    float toPlayer = (pow(x - player.getX(), 2)+pow(y - player.getY(), 2));
    if (toPlayer < pow(closest, 2)) {
      dx = 0;
      dy = 0;
    }
    else {
      if (timer1 >= waitWalk) {
        float angle = atan2(player.getY() - y, player.getX() - x);
        dx = cos(angle)*speed;
        dy = sin(angle)*speed;
        timer1 = (random(waitWalk-1));
      }
    }
  }
  public void shootAtPlayer() {
    if (timer2 > waitShoot) {
      bulletList.add(new EnemyBullet(this, this.getAngle() + random(-2, 2)/10));
      timer2 = (random(0, waitShoot-1));
    }
  }
  public void displayHealthBar() {
    rectMode(CORNER);
    fill(255);
    stroke(0);
    rect(x, y-10, 15, 5);
    noStroke();
    fill(255, 0, 0);
    rect(x, y-10, getCurrentHealth()*15/getMaxHealth(), 5);
  }
}


/////////////////////////////////////////////
public class EnemyBomber extends Enemy {
  boolean exploding;
  int explodeSprite, range;
  float curTime2, startTime, lifeTime, damageValue;
  EnemyBomber() {
    super((float)4, (float)150, enemyBomb);
    exploding = false;
    explodeSprite = 0;
    curTime2 = 0;
    lifeTime = 800;
    closest = 0;
    startTime = millis();
    damageValue = 2;
    range = sprite.width +5;
  }
  
  EnemyBomber(boolean e, float x, float y) {
    this();
    exploding = e;
    this.x = x;
    this.y = y;
  }
  
  public void shootAtPlayer() {}
  public void display() {
    if (exploding) {
      pushMatrix();
      translate(x, y);
      rotate(angle);
      imageMode(CENTER);
      image(sprite, 0, 0);
      popMatrix();
    }
    else {
      super.display();
    }
  }
  public void update() {
    curTime2 = millis() - startTime;
    if (!exploding) {
      super.update();
      if (pow(x - player.getX(), 2) + pow(y - player.getY(), 2) <= pow(range, 2)){
        exploding = true;
        speed = 0;
      }
    }
    else {
      if (explodeSprite <= 6) {
        if (curTime2 >= lifeTime/8) {
            explodeSprite++;
            startTime = millis();
        }
      }
      else {
        dead = true;
      }
      sprite = explosionSpriteList[explodeSprite];
      if (pow(x - player.getX(), 2) + pow(y - player.getY(), 2) <= pow(sprite.width, 2)) {
        player.damage(damageValue);
      }
    }
  }
}
/////////////////////////////////////////////
public class EnemyMachineGun extends Enemy {
  EnemyMachineGun() {
    super(0, 50, enemyMachineGun);
    waitShoot = 30;
    timer2 = waitShoot/2;
    int location = floor(random(4));
    switch (location) {
      case 0: x = 0 + floor(random(50, 150)); y = 0 + floor(random(50, 150)); break;
      case 1: x = 0 + floor(random(50, 150)); y = height - floor(random(50, 150)); break;
      case 2: x = width - floor(random(50, 150)); y = 0 + floor(random(50, 150)); break;
      case 3: x = width - floor(random(50, 150)); y = height - floor(random(50, 150)); break;
    }
  }
  
  public void shootAtPlayer() {
    super.shootAtPlayer();
  }
  
  public void display() {
    super.display();
  }
}
///////////////////////////////////////////
public class EnemyShotgun extends Enemy {
  ArrayList<Bullet> shells;
  float startTime, curTime, lifeTime;
  int innacuracy, numShots, damageValue;
  EnemyShotgun() {
    super(3, 50, enemyShotgun);
    shells = new ArrayList<Bullet>();
    innacuracy = 20;
    startTime = millis();
    curTime = 0;
    lifeTime = 200;
    numShots = 10;
    waitShoot = 200;
    timer2 = waitShoot/2;
    damageValue = 2;
  }
  public void shootAtPlayer() {
    if (timer2 > waitShoot) {
      for (int i = 0; i < numShots; i++) {
        shells.add(new EnemyBullet(this, getAngle() + (random(-0.5, 0.5))));
      }
      timer2 = (random(0, waitShoot-1));
    }
  }
  public void update() {
    super.update();
    for (int i = 0; i < shells.size(); i++) {
      shells.get(i).update();
      if (shells.get(i).getDead()){
        shells.remove(i);
      }
      else if (curTime > lifeTime) {
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
//////////////////////////////////////////
public class EnemySniper extends Enemy {
  float bulletLifeTime;
  ArrayList<Bullet> shells;
  public EnemySniper() {
    super(0, 20, enemySniper);
    waitShoot = 100;
    int location = floor(random(4));
    switch (location) {
      case 0: x = 0 + floor(random(50, 150)); y = 0 + floor(random(50, 150)); break;
      case 1: x = 0 + floor(random(50, 150)); y = height - floor(random(50, 150)); break;
      case 2: x = width - floor(random(50, 150)); y = 0 + floor(random(50, 150)); break;
      case 3: x = width - floor(random(50, 150)); y = height - floor(random(50, 150)); break;
    }
    shells = new ArrayList<Bullet>();
    bulletLifeTime = 3000;
  }
  public void shootAtPlayer() {
    if (timer2 > waitShoot) {
      shells.add(new GuidingEnemyBullet(this, bulletLifeTime));
      timer2 = (random(0, waitShoot-1));
    }
  }
  public void display() {
     super.display();
    for (int i = 0; i < shells.size(); i++) {
      shells.get(i).display();
    }
    stroke(255, 0, 0);
    line(x, y, player.getX(), player.getY());
  }
  public void update() {
    super.update();
    for (int i = 0; i < shells.size(); i++) {
      shells.get(i).update();
      if (shells.get(i).getDead()){
        shells.remove(i);
      }
    }
  }
}
//////////////////////////////////////////
public class EnemyGrenade extends Enemy {
  EnemyGrenade() {
    super(1, 100, enemyGrenade);
    //increase health
    //increase speed
    //Increase accuracy
  }
}

public class Grenade extends Updateable {
  Grenade(Alive a) {
    //
  }
  public void update() {
    //
  }
  public void display() {
    //
  }
}