///////////////////////////////
public abstract class SecondaryAbility extends Updateable {
  String title, description;
  float lifeTime, startTime, curTime, staminaValue, damageValue;
  PImage symbol;
  public SecondaryAbility() {
    startTime = millis();
    curTime = 0;
  }
  public String getTitle() { return title; }
  public void use() {}
  public void update() {}
  public boolean getDead() {
    if (curTime >= lifeTime) {
      return true;
    }
    return false;
  }
  public void checkAugment() {
    switch(player.getAugment()) {
      case "Damage": damageValue = damageValue*2; break;
      case "Stamina": staminaValue = staminaValue*0.7; break;
      case "Duration": lifeTime = lifeTime*1.5; break;
    }
  }
}
//////////////////////////////

public class ShotgunAbility extends SecondaryAbility {
  ArrayList<Bullet> shells;
  public ShotgunAbility() {
    angle = player.getAngle();
    shells = new ArrayList<Bullet>();
    startTime = millis();
    staminaValue = 50;
    damageValue = 10;
    curTime = 0;
    lifeTime = 200;
    checkAugment();
    for (int i = 0; i < 10; i++) {
      shells.add(new FriendlyBullet(angle + (random(-1, 1)), damageValue));
    }
    player.depleteStamina(staminaValue);
  }
  public void update() {
    curTime = millis() - startTime;
    for (int i = 0; i < shells.size(); i++) {
      shells.get(i).update();
      shells.get(i).getDead();
      if (curTime > lifeTime) {
        shells.remove(i);
      }
    }
  }
  public void display() {
    for (int i = 0; i < shells.size(); i++) {
      shells.get(i).display();
    }
  }
  public boolean getDead() { if (shells.size() == 0) { return true; } return false; }
}

///////////////////////////

public class BombAbility extends SecondaryAbility {
  int expandRate, curSprite;
  public BombAbility() {
    x = mouseX;
    y = mouseY;
    expandRate = 3;
    diameter = 1;
    curTime = 0;
    staminaValue = 100;
    startTime = millis();
    damageValue = 15;
    lifeTime = 800;
    curSprite = 0;
    checkAugment();
    player.depleteStamina(staminaValue);
  }
  public void display() {
    imageMode(CENTER);
    image(explosionSpriteList[curSprite], x, y);
  }
  public void update() {
    curTime = millis() - startTime;
    for (int i = 0; i < enemyList.size(); i++) {
      Enemy curen = enemyList.get(i);
      float distance = pow(x - curen.getX(), 2) + pow(y - curen.getY(), 2);
      if (distance < pow(explosionSpriteList[curSprite].width + curen.getDiameter()/2, 2)) {
        curen.damage(damageValue);
      }
    }
    if (curSprite < 7) {
      if (curTime >= lifeTime/8) {
        curSprite++;
        startTime = millis();
      }
    }
    else {
      dead = true;
    }
  }
  public boolean getDead() { return dead; }
}

///////////////////////////

public class BoomerangAbility extends SecondaryAbility {
  float displayAngle, reverseTimer;
  int reverses, maxReverses;
  public BoomerangAbility() {
    speed = 5;
    int tx = mouseX;
    int ty = mouseY;
    x = player.getX();
    y = player.getY();
    angle = atan2(ty-y, tx-x);
    displayAngle = 0;
    dx = cos(angle)*speed;
    dy = sin(angle)*speed;
    staminaValue = 25;
    reverses = 0;
    damageValue = 10;
    lifeTime = 4;
    startTime = millis();
    curTime = 0;
    checkAugment();
    player.depleteStamina(staminaValue);
  }
  public void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    imageMode(CENTER);
    image(knife, 0, 0);
    popMatrix();
  }
  public void update() {
    curTime = millis() - startTime;
    angle += 2*PI/30;
    y += dy;
    x += dx;
    if (curTime > 500) {
      dx = -dx;
      dy = -dy;
      startTime = millis();
      reverses++;
    }
    for (int i = 0; i < enemyList.size(); i++) {
      Enemy curen = enemyList.get(i);
      float distance = pow(x - curen.getX(), 2) + pow(y - curen.getY(), 2);
      if (distance < pow(diameter/2 + curen.getDiameter()/2, 2)) {
        curen.damage(damageValue);
      }
    }  
  }
  public boolean getDead() {
    if (reverses >= lifeTime) {
      return true;
    }
  return false;
  }
} //<>//