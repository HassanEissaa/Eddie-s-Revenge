public abstract class PassiveAbility extends Updateable {
  String title, description;
  float lifeTime;
  PImage symbol;
  public String getTitle() { return title; }
  public void use() {}
  public void update() {}
}

public class HealthRegen extends PassiveAbility {
  float healthRecover;
  boolean overHalf, lowerHalf;
  public HealthRegen() {
    healthRecover = player.maxHealth*0.0005;
  }
  public void update() {
    if (!player.getDead()) {
    if (player.currentHealth+healthRecover > player.maxHealth/2 && player.currentHealth <= player.maxHealth) {
      overHalf = true;
      lowerHalf = false;
   }
   else if (player.currentHealth-healthRecover < player.maxHealth/2 ){
     overHalf = false;
     lowerHalf = true;
   }
   if (overHalf && !lowerHalf && (player.currentHealth > player.maxHealth/2 && player.currentHealth <= player.maxHealth)) 
      player.currentHealth += healthRecover;
    else if (!overHalf && lowerHalf && player.currentHealth < player.maxHealth)
      player.currentHealth += healthRecover;
  }
  }
}

public class CriticalHit extends PassiveAbility {
  float critDmg;
  public CriticalHit() {
    critDmg = 2;
  }
  public void update() {
    for(int i = 0; i < bulletList.size(); i++) {
      if (bulletList.get(i) instanceof FriendlyBullet) {
        int rand = (int)random(3);
        if (rand == 2) 
          bulletList.get(i).damageVal *= critDmg;
      }
    }
  }
}

public class DamageReduction extends PassiveAbility {
  float reduction;
  public DamageReduction() {
    reduction = 0.25;
  }
  public void update() {
  for(int i = 0; i < bulletList.size(); i++) {
      if (bulletList.get(i) instanceof EnemyBullet) 
          bulletList.get(i).damageVal *= reduction;
      
    }
  }
}