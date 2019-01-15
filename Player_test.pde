public class Player extends Alive {
  //Declare variables
  boolean movingUp, movingDown, movingLeft, movingRight, isRunning, canShoot, isShooting, overHalf, lowerHalf;
  float dir, currentStamina, maxStamina, minSpeed, maxSpeed, staminaRecover, bulletDamage, fireRate, shootingTimer;
  String secondary, augment, passive;
  //
  int numHealthPotions, numStaminaPotions;
  DisplayEquipment displayEquipment;
  
  //Setters and Getters
  public float getCurrentStamina() { return currentStamina; }
  public float getMaxStamina() { return maxStamina; }
  public String getAugment() { return augment; }
  public void depleteStamina(float i) { currentStamina -= i; }
  public void setCurrentStamina(float s) {currentStamina = s; }
  public void setMaxStamina(float s) { maxStamina = s; }
  public void setSecondary(String s) { secondary = s; }
  public void setAugment(String s) { augment = s; }
  public void setX(int xx) { x = xx; }
  public void setY(int yy) { y = yy; }
  public void setXY(float xx, float yy) { x = xx; y = yy; }
  public void reset() {
    x = width/2;
    y = height/2;
    targetAngle = 0;
    movingUp = false;
    movingDown = false;
    movingLeft = false;
    movingRight = false;
    dead = false;
    isRunning = false;
    shootingTimer = millis();
    canShoot = true;
    isShooting = false;
    setCurrentHealth(getMaxHealth());
    setCurrentStamina(getMaxStamina());
  }
  
  //Constructor
  Player() {
    //General stuff
    x = width/2;
    y = height/2;
    angle = 0;
    targetAngle = 0;
    movingUp = false;
    movingDown = false;
    movingLeft = false;
    movingRight = false;
    diameter = 20;
    
    //Stats and abilities
    speed = 0.25;
    maxHealth = 400;
    currentHealth = 400;
    secondary = ""; //PLAYER START SECONDARY
    passive = "";
    augment = ""; //PLAYER START AUGMENT
    maxStamina = 200;
    currentStamina = 200;
    isRunning = false;
    //Added//
    maxSpeed = speed*2; 
    minSpeed = speed; 
    bulletDamage = 10;
    fireRate = 500; 
    staminaRecover = 1; 
    shootingTimer = millis();
    canShoot = true;
    isShooting = false;
    displayEquipment = new DisplayEquipment();
 }
  public void setMove(int k, boolean b) {
    if (k == 'W') {
      movingUp = b;
    }
    else if (k == 'A') {
      movingLeft = b;
    }
    else if (k == 'S') {
      movingDown = b;
    }
    else if (k == 'D') {
      movingRight = b;
    }
    if (k == SHIFT) {
      isRunning = b;
    }
  }
  public void setMove2(int k) {
    //Inputs for picking up items and putting them into your inventory
    if (k == 'Q') 
      pickedUpItems();
    //Use current items on display
    else if (k == 'E') {
      useItems();
    }
    
    //Toggle between items
    if (k == '1') 
      game.inventorybar.displayItems = 0; //Equips health potions
    else if (k == '2')
      game.inventorybar.displayItems = 1; //Equips stamina potions
  }
  
  public void pickedUpItems() {
    for(int i = 0; i < game.getCurrentFloor().getCurrentRoom().getItemList().size(); i++) {
      Items item = game.getCurrentFloor().getCurrentRoom().getItemList().get(i);
      if(!item.pickedUp) {
        if (((player.x >= item.x - 25 && player.x <= item.x + 25) && (player.y >= item.y - 25 && player.y <= item.y + 25 ))) {
           item.pickedUp = true;
           if (item instanceof Equipment) {
             if (item instanceof RageDagger)  {
               ((RageDagger)item).equip();
               displayEquipment.rageDaggerNumb++;
             }
             else if (item instanceof JewelOfEnergy) {
               ((JewelOfEnergy)item).equip();
               displayEquipment.jewelOfEnergyNumb++;
             }
             else if (item instanceof HeartOfVitality) {
               ((HeartOfVitality)item).equip();
               displayEquipment.heartOfVitalityNumb++;
             }
             else if (item instanceof QuickSilver) {
               ((QuickSilver)item).equip();
               displayEquipment.quickSilverNumb++;
             }
             else if (item instanceof WeaponCraft) {
               ((WeaponCraft)item).equip();
               displayEquipment.weaponCraftNumb++;
             }
             else if (item instanceof GaleReburst) {
               ((GaleReburst)item).equip();
               displayEquipment.galeReburstNumb++;;
             }
           }
           else {
             if (item instanceof HealthPotion) {
               game.inventorybar.healthPotions.add((HealthPotion)item); //Add potion to health potions arraylist inside inventory
             }
             else if (item instanceof StaminaPotion) {
               game.inventorybar.staminaPotions.add((StaminaPotion)item); //Add potion to stamina potions arraylist inside inventory
             }
           break;
          }
        }
      }
    }
  }
  
  public void useItems() {
    if (game.inventorybar.displayItems == 0) { //If health potions is currently equipped
       if (game.inventorybar.healthPotions.size() > 0) { //If there is any health potions
         HealthPotion usedPotion = game.inventorybar.healthPotions.get(game.inventorybar.healthPotions.size()-1); 
         if (player.currentHealth < player.maxHealth) { //Only is able to use potion when health is under max health
         usedPotion.use(); //Uses it
         game.inventorybar.healthPotions.remove(usedPotion); //Removes the potion from it's list inside the inventory
        }
      }
    }
    else if (game.inventorybar.displayItems == 1) { //If stamina potions is currently equipped
      if (game.inventorybar.staminaPotions.size() > 0) { //If there is any stamina potions
        StaminaPotion usedPotion = game.inventorybar.staminaPotions.get(game.inventorybar.staminaPotions.size()-1);
        if (player.currentStamina < player.maxStamina) { // //Only is able to use potion when stamina is under max stamina
          usedPotion.use(); //Uses it
          game.inventorybar.staminaPotions.remove(usedPotion); //Removes the potion from it's list inside the inventory
        }
      }
    }   
  }
  
  public void useSecondary() {
    if (currentStamina > maxStamina/4) {
      if (secondary == "Shotgun") {
        shotgun.loop(0);
      secondaryList.add(new ShotgunAbility());
      }
      else if (secondary == "Bomb") {
        explosion.loop(0);
        secondaryList.add(new BombAbility());
      }
      else if (secondary == "Boomerang") {
        boomerang.loop(0);
        secondaryList.add(new BoomerangAbility());
      }
    }
  }
  public void checkStamina() {
   if (currentStamina+0.20*staminaRecover > maxStamina/2 && currentStamina <= maxStamina) {
      overHalf = true;
      lowerHalf = false;
   }
   else if (currentStamina-0.20*staminaRecover < maxStamina/2 ){
     overHalf = false;
     lowerHalf = true;
   }
  }
  public void update() {
    //General stuff
    if (!getDead()) {
      float radius = diameter/2;
      x = constrain(x + radius*(int(movingRight)*speed - int(movingLeft)*speed), radius, width  - radius);
      y = constrain(y + radius*(int(movingDown)*speed  - int(movingUp)*speed),   radius, height - radius);
      //Rotate
      angle = atan2(mouseY-y, mouseX-x);
      if (enemyList.size() == 0) {
        x = constrain(x + radius*(int(movingRight)*speed - int(movingLeft)*speed), radius, width  - radius);
        y = constrain(y + radius*(int(movingDown)*speed  - int(movingUp)*speed),   radius, height - radius);
      }
    }
    checkStamina();
    
    //Stamina functionality
    //Shift making you run at the expense of transferring stamina to increase speed
    if (isRunning && currentStamina >= 0) {
      if (isRunning && (movingRight || movingLeft || movingUp || movingDown)) {
        speed = maxSpeed;
        currentStamina-= 0.50;
        if (currentStamina < 0) {
          speed = minSpeed;
        }
      }
    }
    //When you stop running, you regain more stamina
    else if (!isRunning && currentStamina <= maxStamina) {
      speed = minSpeed;
      if (overHalf && !lowerHalf && (currentStamina > maxStamina/2 && currentStamina <= maxStamina)) {
          currentStamina += 0.15*staminaRecover;
      }
      else if (!overHalf && lowerHalf && currentStamina < maxStamina/2)
        currentStamina += 0.15*staminaRecover;
    }
    
    
    if (isShooting) {
      float curTime = millis() - shootingTimer;
      if (curTime < fireRate)
        canShoot = false;
      else {
        canShoot = true;
        shootingTimer = millis();
        isShooting = false;
      }
    }
    
    if (passive == "HealthRegen") {
      HealthRegen healthRegen = new HealthRegen();
        healthRegen.update();
    } 
  }
  public void display() {
    if (!getDead()) {
      pushMatrix();
      translate(x, y);
      rotate(angle);
      imageMode(CENTER);
      image(playerSprite, 0, 0);
      popMatrix();
    }
  }
}