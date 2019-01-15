public class Bullet extends Updateable {
  float damageVal;
  public float getDamageVal() { return damageVal; }
  Bullet() {}
  Bullet(Alive a){
    angle = a.getAngle();
    x = a.getX() + cos(angle + 0.384)*27;
    y = a.getY() + sin(angle + 0.384)*27;
    speed = 12;
    dx = cos(angle)*speed;
    dy = sin(angle)*speed;
    diameter = 4;
    damageVal = 10;
  }
  public Bullet(float px, float py, float mx, float my) {
    x = px;
    y = py;
    diameter = 4;
    speed = 12;
    float angle = atan2(my - py, mx - px);
    damageVal = 10;
    dx = cos(angle)*speed;
    dy = sin(angle)*speed;
    dead = false;
  }
  
  public void update() {
    x += dx;
    y += dy;
  }
  public void display() {
    fill(0);
    ellipse(x, y, diameter, diameter);
  }
}

public class FriendlyBullet extends Bullet {
  public FriendlyBullet(Alive a){
    angle = a.getAngle();
    speed = 12;
    x = a.getX() + cos(angle + 0.384)*27;
    y = a.getY() + sin(angle + 0.384)*27;
    angle = atan2(mouseY - y, mouseX - x);
    dx = cos(angle)*speed;
    dy = sin(angle)*speed;
    diameter = 4;
    damageVal = ((Player)a).bulletDamage;
  }
  public FriendlyBullet(float anglein) {
    angle = anglein;
    x = player.getX() + cos(angle + 0.384)*27;
    y = player.getY() + sin(angle + 0.384)*27;
    speed = 12;
    dx = cos(angle)*speed;
    dy = sin(angle)*speed;
    diameter = 4;
    damageVal = player.bulletDamage;
  }
  public FriendlyBullet(float angleIn, float damageValIn) {
    this(angleIn);
    damageVal = damageValIn;
  }
  public FriendlyBullet(float px, float py, float mx, float my) {
    super(px, py, mx, my);
  }
  public boolean getDead() {
    if (x > width+diameter || x < 0-diameter || y > height+diameter || y < 0-diameter) {
      return true;
    }
    for (int i = 0; i < enemyList.size(); i++) {
      Enemy curEn = enemyList.get(i);
      float squaredDistance = (pow(x-curEn.getX(), 2)+pow(y-curEn.getY(), 2));
      if (squaredDistance < pow((diameter+curEn.getDiameter()), 2)) {
        curEn.damage(this.getDamageVal());
        return true;
      }
    }
    return false;
  }
}

public class EnemyBullet extends Bullet {
  public EnemyBullet(Alive a) {
    super(a);
  }
  public EnemyBullet(float px, float py, float mx, float my){
    super(px, py, mx, my);
  }
  public EnemyBullet(Alive a, float anglein) {
    angle = anglein;
    x = a.getX() + cos(angle + 0.384)*27;
    y = a.getY() + sin(angle + 0.384)*27;
    speed = 12;
    dx = cos(angle)*speed;
    dy = sin(angle)*speed;
    diameter = 4;
    damageVal = 10;
  }
  public boolean getDead() {
    if (x > width+diameter || x < 0-diameter || y > height+diameter || y < 0-diameter) {
      return true;
    }
    float squaredDistance = (pow(x-player.getX(), 2)+pow(y-player.getY(), 2));
    if (squaredDistance < pow((diameter+player.getDiameter()), 2)) {
      if (player.passive == "ReduceDamage") {//If player has reduce damage ability
        int rand = (int)random(4);
        if (rand == 2) {
          DamageReduction damageReduction = new DamageReduction();
          damageReduction.update();
          player.damage(this.getDamageVal());
        return true;
        }
        else {
          player.damage(this.getDamageVal());
          return true;
        }
          
      }
      else { 
         player.damage(this.getDamageVal());
         return true;
      }
    }
  return false;
  }
}

public class GuidingEnemyBullet extends EnemyBullet {
  float lifeTime, startTime, curTime;
  GuidingEnemyBullet(Alive a, float life) {
    super(a);
    lifeTime = life;
    startTime = millis();
    curTime = 0;
    speed = 5;
  }
  GuidingEnemyBullet(float x1, float y1, float x2, float y2, float life, float damage) {
    super(x1, y1, x2, y2);
    lifeTime = life;
    startTime = millis();
    curTime = 0;
    speed = 5;
    damageVal = damage;
  }
  public void update() {
    curTime = millis() - startTime;
    angle = atan2(y - player.getY(), x - player.getX());
    dx = -cos(angle)*speed;
    dy = -sin(angle)*speed;
    x += dx;
    y += dy;
  }
  public boolean getDead() {
    if (super.getDead()) { return true; }
    else if (curTime > lifeTime) { return true; }
    return false;
  }
}