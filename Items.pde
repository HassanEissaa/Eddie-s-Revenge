public abstract class Items extends Visible {
  boolean pickedUp;
  PImage sprite;
  public Items(float xx, float yy, PImage spr) {
     x =xx;
     y = yy;
     pickedUp = false;
     sprite = spr;
  }
  
  public void display() {}
  public void use() {}
}

//////////////////////////
/////////////////////////

//Made a potions sub class from Items
public abstract class Potions extends Items {
  public Potions(float xx, float yy, PImage spr) {
    super(xx, yy, spr);
  }
  
  public void use() {};
  
}

public class HealthPotion extends Potions {
  float healthRecover;
  
  public HealthPotion(float xx, float yy, PImage spr) {
    super(xx,yy, spr);
    healthRecover = player.getMaxHealth()/5;
  }
  public HealthPotion(float xx, float yy) {
    this(xx, yy, healthPotionSprite);
  }
  public HealthPotion() {
    this(random(100, width-100), random(100, height-100), healthPotionSprite);
  }
 public void display() {
   imageMode(CENTER);
   image(sprite, x, y);
 }
 
 public void use() {
     player.currentHealth += healthRecover;
  if (player.currentHealth > player.maxHealth)
     player.currentHealth = player.maxHealth;
 }
}

///////////////////////////
///////////////////////////

public class StaminaPotion extends Potions {
  float staminaRecover;
  
  public StaminaPotion(float xx, float yy, PImage spr) {
    super(xx, yy, spr);
    staminaRecover = 50;
  }
  public StaminaPotion(float xx, float yy) {
    this(xx, yy, staminaPotionSprite);
  }
  public StaminaPotion() {
    this(random(100, width-100), random(100, height-100), staminaPotionSprite);
  }
  public void display() {
    imageMode(CENTER);
    image(sprite, x, y);
  }
  
  public void use() {
   player.currentStamina += staminaRecover;
   if (player.currentStamina > player.maxStamina)
     player.currentStamina = player.maxStamina;
  }
}