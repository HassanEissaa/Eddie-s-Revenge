public class Healthbar extends Updateable {
  float ratio;
  public void display() {
    ratio = player.getCurrentHealth()/player.getMaxHealth();
    fill(0);
    textSize(15);
    text("Health:", 5, 15);
    fill(255);
    stroke(8);
    rect(5, 20, 140, 10);
    fill(255, 0, 0);
    noStroke();
    if (ratio > 0) { //When you die, the red bar completely goes away
      rect(5, 20, ratio*140, 10);
    }
  }
}

public class Staminabar extends Visible {
  float ratio = 0;
  public void display() {
    ratio = player.getCurrentStamina()/player.getMaxStamina();
    fill(0);
    text("Stamina:", 5, 45);
    fill(255);
    stroke(8);
    rect(5, 50, 140, 10);
    fill(255,247,0);
    noStroke();
    rect(5, 50, ratio*140, 10);
  }
}

public class Inventory extends Updateable {
 ArrayList <HealthPotion> healthPotions =  new ArrayList<HealthPotion>();
  ArrayList <StaminaPotion> staminaPotions =  new ArrayList<StaminaPotion>();
  int displayItems = 0; //Toggles which item on hold
  
  //Changed coordinates
  public void display() {
    if (displayItems == 0) {
      fill(#D31F0B);
      ellipse(width-90, height-80, 80, 80);
      if (healthPotions.size() > 0) {
        imageMode(CENTER);
        image(healthPotionSprite, width-90, height-80);
       
        fill(0);
        textSize(15);
        text(healthPotions.size(), width-80, height-100);
      }
      else {
        fill(0);
        textSize(15);
        text(0, width-100, height-75);
      }
    }
     
    else if (displayItems == 1) {
      fill(#34DE26);
      ellipse(width-90, height-80, 80, 80);
      if (staminaPotions.size() > 0) {
        imageMode(CENTER);
       image(staminaPotionSprite, width-90, height-80);
       
       fill(0);
       textSize(15);
       text(staminaPotions.size(), width-80, height-100);
       }
       else {
       fill(0);
       textSize(15);
       text(0, width-100, height-75);
      }
    }
  } 
}

public class DisplayEquipment extends Updateable {
  int rageDaggerNumb, jewelOfEnergyNumb, heartOfVitalityNumb,
  quickSilverNumb, weaponCraftNumb, galeReburstNumb;
  String rageDaggerDescrip, jewelOfEnergyDescrip, heartOfVitalityDescrip,
  quickSilverDescrip, weaponCraftDescrip, galeReburstDescrip;
  
  public DisplayEquipment() {
   rageDaggerNumb = 0;
   jewelOfEnergyNumb = 0;
   heartOfVitalityNumb = 0;
   quickSilverNumb = 0;
   weaponCraftNumb = 0;
   galeReburstNumb = 0;
   rageDaggerDescrip = "Within your grasp, you feel a surge of intense\n rage buring deep within. Let your bullets\n strike like the raging dagger.";
   jewelOfEnergyDescrip = "Be endowed by it's elagance, be\n reinbursed full of righteous energy\n  within you";
   heartOfVitalityDescrip = "When two hearts combine, it was then told\n at that very moment you have achieved\n a bigger lifespan.";
   quickSilverDescrip = "Become swift like Quicksilver that even the\n focused human eye can't keep up."; 
   weaponCraftDescrip = "Hellbent killer's craft: Shoot faster";
   galeReburstDescrip = "With this wand an amibigous magic\n surrounds you. You feel you can instantly\n do anything limitlessly without any fatigue.";
  }
  
     
}