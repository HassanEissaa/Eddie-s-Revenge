public abstract class Equipment extends Items {
  public Equipment(float xx, float yy, PImage spr) {
    super(xx, yy, spr);
  }
  public void equip() {}
}

/////////////////
////////////////

public class RageDagger extends Equipment {
  float attackInc;
  
  public RageDagger(float xx, float yy, PImage spr) {
    super(xx,yy, spr);
    attackInc = 5;
  }
  public RageDagger(float xx, float yy) {
    this(xx, yy, rageDaggerSprite);
  }
  public RageDagger() {
    this(random(100, width-100), random(100, height-100));
  }
  
  public void display() {
    imageMode(CENTER);
   image(sprite, x, y);
  }
  
  public void equip() {
     player.bulletDamage += attackInc;
  }
}

public class JewelOfEnergy extends Equipment {
  float maxStaminaInc;
  
  public JewelOfEnergy(float xx, float yy, PImage spr) {
    super(xx, yy, spr);
    maxStaminaInc = 100;
  }
  public JewelOfEnergy() {
    this(random(100, width-100), random(100, height-100), jewelOfEnergySprite);
  }
  
  public void display() {
    imageMode(CENTER);
    image(sprite, x, y);
  }
  
  public void equip() {
    player.maxStamina += maxStaminaInc;
  }
}

public class HeartOfVitality extends Equipment {
  float maxHealthInc;
  
  public HeartOfVitality(float xx, float yy, PImage spr) {
    super(xx, yy, spr);
    maxHealthInc = 50;
  }
  public HeartOfVitality() {
    this(random(100, width-100), random(100, height-100), heartOfVitalitySprite);
  }
  
  public void display() {
    imageMode(CENTER);
    image(sprite, x, y);
  }
  
  public void equip() {
    player.maxHealth += maxHealthInc;
  }
}

public class QuickSilver extends Equipment {
  float speedInc;
   
   public QuickSilver(float xx, float yy, PImage spr) {
    super(xx,yy,spr);
    speedInc = 0.1;
   }
   public QuickSilver() {
    this(random(100, width-100), random(100, height-100), quickSilverSprite);
  }
   
   public void display() {
     imageMode(CENTER);
     image(sprite,x,y);
   }
   public void equip() {
     player.speed += speedInc;
     player.maxSpeed = 2*player.speed; //Added///
     player.minSpeed = player.speed; //Added///
   }
}

public class WeaponCraft extends Equipment {
  float betterFireRate;
  
  public WeaponCraft(float xx, float yy, PImage spr) {
    super(xx, yy, spr);
    betterFireRate = player.fireRate*0.9;
  }
  public WeaponCraft() {
    this(random(100, width-100), random(100, height-100), weaponCraftSprite);
  }
  
  public void display() {
    imageMode(CENTER);
    image(sprite, x, y);
  }
  
  public void equip() {
   player.fireRate -= betterFireRate; 
  }
  
}

public class GaleReburst extends Equipment {
  float add;
  
  public GaleReburst(float xx, float yy, PImage spr) {
   super(xx, yy, spr);
   add = 1;
  }
  public GaleReburst() {
    this(random(100, width-100), random(100, height-100), galeReburstSprite);
  }
  
  public void display() {
    imageMode(CENTER);
    image(sprite, x, y);
  }
  
  public void equip() {
    player.staminaRecover += add;
  }
}