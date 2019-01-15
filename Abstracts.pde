///////////////////////////////////////////////////// Visible
public class Visible {
  protected float x, y;
  protected float timer;
  protected PImage sprite;
  protected boolean onScreen, dead;
  public float getX() { return x; }
  public float getY() { return y; }
  public boolean getDead() { return dead; }
  Visible() {}
  Visible(PImage ssprite, float xx, float yy) {
    sprite = ssprite;
    x = xx;
    y = yy;
  }
  public void display() {}
  public void update() {}
}
///////////////////////////////////////////////////// Moveable
public abstract class Updateable extends Visible {
  protected float dx, dy, diameter, angle, speed, targetAngle;
  protected int gridX, gridY;
  public float getDx() { return dx; }
  public float getDy() { return dy; }
  public int getGridX() { return floor(x/64); }
  public int getGridY() { return floor(y/64); }
  public float getAngle() { return angle; }
  public float getDiameter() { return diameter; }
  Updateable() {}
  public void Update() {
    x += dx;
    y += dy;
  }
  public void display() {}
  public boolean canGoLeft() {
    return game.getCurrentFloor().getCurrentRoom().blockingAt(getGridX()-1, getGridY());
  }
  public boolean canGoRight() {
    return game.getCurrentFloor().getCurrentRoom().blockingAt(getGridX()+1, getGridY());
  }
  public boolean canGoUp() {
    return game.getCurrentFloor().getCurrentRoom().blockingAt(getGridX(), getGridY()-1);
  }
  public boolean canGoDown() {
    return game.getCurrentFloor().getCurrentRoom().blockingAt(getGridX(), getGridY()+1);
  }
}
///////////////////////////////////////////////////// Alive
public class Alive extends Updateable {
  float maxHealth, currentHealth;
  boolean dead;
  public void damage(float dmg) {
    if (currentHealth > 0) {
      currentHealth -= dmg;
    }
    if (currentHealth <= 0) {
      dead = true;
    }
  }
  public void setCurrentHealth(float a) { currentHealth = a; }
  public float getCurrentHealth() { return currentHealth; }
  public float getMaxHealth() { return maxHealth; }
  public boolean getDead() { return dead; }
}