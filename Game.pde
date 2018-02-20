public class Game {
  private int maxFloors;
  private int currentFloor;
  private Floor[] floorList;
  Healthbar healthbar;
  Staminabar staminabar;
  Inventory inventorybar;
  String currentMessage;
  public Game() {
    maxFloors = 4;
    currentFloor = 0;
    floorList = new Floor[maxFloors];
    floorList[0] = new Floor(0); floorList[0].makeFloor1();
    floorList[1] = new Floor(1); floorList[0].makeFloor2();
    floorList[2] = new Floor(2); floorList[0].makeFloor3();
    floorList[3] = new Floor(3); floorList[0].makeFloor4();
    healthbar = new Healthbar();
    staminabar = new Staminabar();
    inventorybar = new Inventory();
  }
  public void setCurrentMessage(String s) { currentMessage = s; }
  public Floor getCurrentFloor() { return floorList[currentFloor]; }
  public int getCurrentFloorIndex() { return currentFloor; }
  public void display() {
    getCurrentFloor().getCurrentRoom().display();
    displayAllItems();
    displayUI();
  }
  public void restartFloor() {
    player.reset();
    floorList[currentFloor] = new Floor(currentFloor);
    bulletList = new ArrayList<Bullet>();
    enemyList = new ArrayList<Enemy>();
    secondaryList = new ArrayList<SecondaryAbility>();
    inventorybar.healthPotions.clear();
    inventorybar.staminaPotions.clear();
  }
  public void nextFloor() {
    if (currentFloor < floorList.length -1) {
      currentFloor++;
      player.setXY(width/2, height/2);
      pickedCard = false;
      backgroundsongs[currentSong].pause();
      currentSong++;
      backgroundsongs[currentSong].loop();  
      backgroundsongs[currentSong].setGain(-10);
    }
  }
  public void update() {
    getCurrentFloor().update();
    getCurrentFloor().displayMap(160, 18);
    if (player.getDead()) {
      restartFloor();
    }
  }
  //DISPLAY METHODS
  public void displayAllItems() {
    for (int i = 0; i < getCurrentFloor().getCurrentRoom().getItemList().size(); i++) {
      getCurrentFloor().getCurrentRoom().getItemList().get(i).display();
    }
  }
  public void displayUI() {
    healthbar.display(); inventorybar.display(); staminabar.display();
  }
  public void displayCurrentMessage() {
    fill(#F5F06A);
    rect(width- 900, height -150, 700, 100);
    fill(0);
    text(currentMessage, 80, 530);
  }
}