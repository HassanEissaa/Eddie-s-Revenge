public class Room {
  //Variables
  private PImage floorSprite;
  private Tile[][] tileList;
  private Tile[] motifTileList;
  private final int roomWidth = width/64;
  private final int roomHeight = height/64;
  private boolean rightExit, leftExit, upExit, downExit, arrowIn;
  private ArrayList<Items> itemList;
  float arrowCycle, startTime;
  
  //Constructor
  public Room(int floorIndex) {
    itemList = new ArrayList<Items>();
    upExit = false;
    downExit = false;
    leftExit = false;
    rightExit = false;
    startTime = millis();
    arrowCycle = 0;
    arrowIn = true;
    floorSprite = openTileList[floorIndex];
    
    //Equipment
    if (random(100) > 80) {
      dropEquipment();
    }
    
    //Enemies
    if (floorIndex == 0) { 
      if (random(10) > 9) {
        enemyList.add(new EnemyShotgun());
        for (int i = 0; i < floor(random(2)); i++) {
          enemyList.add(new Enemy());
        }
      }
      else {
        int numEnemies = floor(random(2)) + floor(random(2));
        for (int i = 0; i < numEnemies; i++) {
          enemyList.add(new Enemy());
        }
      }
    }
    else if (floorIndex == 1) {
      for (int i = 0; i < floor(random(4)); i++) {
        enemyList.add(new Enemy());
      }
      if (random(10) > 5) {
        enemyList.add(new EnemyShotgun());
      }
      else if (random(10) > 8) {
        enemyList.add(new EnemyMachineGun());
      }
      
      else {
        enemyList.add(new EnemyBomber());
      }
    }
    else if (floorIndex == 2) {
      enemyList.add(new Enemy()); enemyList.add(new EnemySniper()); enemyList.add(new EnemyShotgun());
    }
    else if (floorIndex == 3) {
      int picker = floor(random(4)) + 1;
      if (picker == 1) {
          enemyList.add(new EnemyShotgun()); 
         enemyList.add(new Enemy()); 
       enemyList.add(new EnemyBomber()); 
       enemyList.add(new EnemyMachineGun()); 
      }
      else if (picker == 2) {
        enemyList.add(new EnemySniper()); 
        enemyList.add(new EnemyMachineGun()); 
        enemyList.add(new Enemy()); 
      }
       else if (picker == 3) {
          enemyList.add(new EnemyBomber());
         enemyList.add(new EnemyMachineGun()); 
        enemyList.add(new Enemy()); 
       }
       else if (picker == 4) {
          enemyList.add(new EnemySniper()); 
          enemyList.add(new EnemyShotgun()); 
          enemyList.add(new EnemyMachineGun()); 
           enemyList.add(new Enemy()); 
       }
    }
    
    //Add tiles
    tileList = new Tile[roomWidth][roomHeight];
    for (int i = 0; i < roomWidth; i++) {
      for (int j = 0; j < roomHeight; j++) {
        if(i==0 || j==0 || i==(roomWidth-1) || j==(roomHeight-1)) {
          tileList[i][j] = new Tile('b');
        }
        else {
          tileList[i][j] = new Tile('o', floorSprite);
        }
      }
    }
    
    //Add motifs
    int tiles = floor(random(4));
    motifTileList = new Tile[tiles];
    for (int i = 0; i < motifTileList.length; i++) {
      motifTileList[i] = new Tile(motifList[floor(random(motifList.length))], roomWidth*64, roomHeight*64);
    }
  }
  public Room(boolean up, boolean down, boolean left, boolean right, int floorIndex) { //THIS IS THE CONSTRUCTOR FOR THE FIRST ROOM
    itemList = new ArrayList<Items>();
    upExit = up;
    downExit = down;
    leftExit = left;
    rightExit = right;
    floorSprite = openTileList[floorIndex];
    //Add tiles
    tileList = new Tile[roomWidth][roomHeight];
    for (int i = 0; i < roomWidth; i++) {
      for (int j = 0; j < roomHeight; j++) {
        if(i==0 || j==0 || i==(roomWidth-1) || j==(roomHeight-1)) {
          tileList[i][j] = new Tile('b');
        }
        else {
          tileList[i][j] = new Tile('o', floorSprite);
        }
      }
    }
    //Add motifs
    int tiles = floor(random(4));
    motifTileList = new Tile[tiles];
    for (int i = 0; i < motifTileList.length; i++) {
      motifTileList[i] = new Tile(motifList[floor(random(motifList.length))], roomWidth*64, roomHeight*64);
    }
  }
  public boolean getRightExit() { return rightExit; }
  public boolean getLeftExit() { return leftExit; }
  public boolean getUpExit() { return upExit; }
  public boolean getDownExit() { return downExit; }
  public void dropEquipment() {
    int picker = floor(random(6)) + 1;
    switch (picker) {
      case 1: itemList.add(new QuickSilver()); break;
      case 2: itemList.add(new WeaponCraft()); break;
      case 3: itemList.add(new GaleReburst()); break;
      case 4: itemList.add(new JewelOfEnergy()); break;
      case 5: itemList.add( new RageDagger()); break;
      case 6: itemList.add(new HeartOfVitality()); break;
    } 
  }
  public void dropItem(float xx, float yy) {
    float picker = random(100);
    if (picker > 50) { itemList.add(new HealthPotion(xx, yy)); }
    else if (picker <= 50) {itemList.add(new StaminaPotion(xx, yy)); }
  }
  public boolean getInverseExit(char c) { //c is the direction that the thing is entering from
    switch (c) { case 'u': return getDownExit();
                 case 'd': return getUpExit();
                 case 'l': return getRightExit();
                 case 'r': return getLeftExit(); }
                 return false;
  }
  public void setInverseExit(char c, boolean b) {
    switch (c) { case 'u': downExit = b; break;
                 case 'd': upExit = b; break;
                 case 'l': rightExit = b; break;
                 case 'r': leftExit = b;  break;}
  }
  public void setExits(boolean u, boolean d, boolean l, boolean r) {
    upExit = u;
    downExit = d;
    leftExit = l;
    rightExit = r;
  }
  public void setRightExit(boolean b) { rightExit = b; }
  public void setLeftExit(boolean b) { leftExit = b; }
  public void setUpExit(boolean b) { upExit = b; }
  public void setDownExit(boolean b) { downExit = b; }
  public int getRoomWidth() { return roomWidth; }
  public int getRoomHeight() { return roomHeight; }
  public void display() {
    for (int i = 0; i < roomWidth; i++) {
      for (int j = 0; j < roomHeight; j++) {
        tileList[i][j].display(i*64, j*64);
      }
    }
    for (int i = 0; i < motifTileList.length; i++) {
      motifTileList[i].display();
    }
    if (enemyList.size() == 0) {
      arrowCycle = millis() - startTime;
      float inoutdistance = 20;
      int duration = 1000;
      float correction = 30;
      float distancefromedge = 75;
      if (arrowCycle > duration) {
        arrowIn = !arrowIn;
        startTime = millis();
      }
      if (getUpExit()) { image(arrowu, width/2 - correction, distancefromedge + int(arrowIn)*inoutdistance - correction, 64, 64); 
                          /*image(door, 4, 4)*/}
      if (getDownExit()) { image(arrowd, width/2 - correction, (height - distancefromedge) - int(arrowIn)*inoutdistance - correction, 64, 64); }
      if (getLeftExit()) { image(arrowl, distancefromedge + int(arrowIn)*inoutdistance - correction, height/2 - correction, 64, 64); }
      if (getRightExit()) { image(arrowr, width-distancefromedge - int(arrowIn)*inoutdistance - correction, height/2 - correction, 64, 64); }
    }
  }
  public void update() {
     removePickedUpObjects();
    
  }
  public void removePickedUpObjects() { ///ADDDEDD//////
    for(int i = 0; i < itemList.size(); i++) {
      if (itemList.get(i).pickedUp) {
        itemList.remove(i);
        break;
      }
    }
  }
  
  public boolean blockingAt(int xx, int yy) {
    if (tileList[xx][yy].getType() == 'b') {
      return true;
    }
    return false;
  }
  public ArrayList<Items> getItemList() { return itemList; }
}

//////////////////////

public class BossRoom extends Room {
  BossRoom(Boolean a, Boolean b, Boolean c, Boolean d, int g) {
    super(a, b, c, d, g);
    if (g == 0) {
      enemyList.add(new BossPlain());
    }
    else if (g == 1) {
      enemyList.add(new EnemyMachineGun());
      for(int i = 0; i < 10; i++) {
        enemyList.add(new EnemyBomber());
      }
    }
    else if (g == 2) {
      enemyList.add(new BossSniper());
    }
    else if (g == 3) {
      enemyList.add(new BossShane());
    }
    else {
      println("error in boss room constructor");
    }
  }
  BossRoom(int index) {
    this(false, false, false, false, index);
  }
}

///////////////
public class Tile extends Visible {
  char type;
  public Tile(char c) {
    type = c;
    if (c=='b') { sprite = blocking; }
    else if (c=='o') { sprite = open1; }
  }
  public Tile(char c, PImage p) {
    type = c;
    sprite = p;
  }
  public Tile(PImage p, int i, int j) {
    sprite = p;
    type = 'o';
    x = random(i);
    y = random(j);
  }
  
  public char getType() { return type; }
  public void display(int xx, int yy) {
    imageMode(CORNER);
    image(sprite, xx, yy);
  }
  public void display() {
    imageMode(CORNER);
    image(sprite, x, y);
  }
}