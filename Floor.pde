public class Floor {
  //private String currentMessage;
  private int bossRoomIndex, curNumRooms, maxFloorWidth, maxFloorHeight, numExits, index;
  public int[] currentRoom;
  private Room[][] roomList;
  public Floor(int floorIndex) {
    bossRoomIndex = floor(random(10, 18));
    curNumRooms = 1;
    numExits = 4;
    maxFloorWidth = 10;
    index = floorIndex;
    maxFloorHeight = 10;
    roomList = new Room[maxFloorWidth][maxFloorHeight];
    currentRoom = new int[] {4, 5};
    for (int i = 0; i < maxFloorWidth; i++) {
      for (int j = 0; j < maxFloorHeight; j++) {
        roomList[i][j] = null;
      }
    }
    roomList[currentRoom[0]][currentRoom[1]] = new Room(true, true, true, true, floorIndex);
  }
  public void changeRoomIndex(int i, int j) { currentRoom = new int[] {i, j}; }
  public void setRoom(int i, int j, Room r) { roomList[i][j] = r; } 
  public Room getCurrentRoom() { return roomList[currentRoom[0]][currentRoom[1]]; }
  public int[] getCurrentRoomIndex() { return currentRoom; }
  public int currentRoomX() { return getCurrentRoomIndex()[0]; }
  public int currentRoomY() { return getCurrentRoomIndex()[1]; }
  public boolean isFinalRoom() { if (getCurrentRoom() instanceof BossRoom) { return true; } return false; }
  public void makeFloor1() {
    //game.setCurrentMessage("Something....");
  }
  public void makeFloor2() {
    //
  }
  public void makeFloor3() {
    //
  }
  public void makeFloor4() {
    //
  }
  public boolean checkBossRoom() {
    if (getCurrentRoom() instanceof BossRoom) {
      return true;
    }
    return false;
  }
  public void displayMap(int xx, int yy) {
    int squareSize = 3;
    for (int i = 0; i < maxFloorWidth; i++) {
      for (int j = 0; j < maxFloorHeight; j++) {
        if (roomList[i][j] == null) {
          noFill();
          stroke(0);
        }
        else {
          fill(255, 0, 0);
        }
        if (i == getCurrentRoomIndex()[0] && j == getCurrentRoomIndex()[1]) {
          fill(0, 255, 0);
        }
        rect(xx + (i*squareSize + i), yy + (j*squareSize+j), squareSize, squareSize);
      }
    }
  }
  public void checkChangeRoom() { ///Changed this a lot
    int distance = 30;
    if (enemyList.size() == 0) {
      if (player.getX() >= width - distance) { //Right
        if (abs(player.getY() - height/2) <= distance) {
          if (getCurrentRoom().getRightExit()) {
            if (!(getCurrentRoom() instanceof BossRoom)) {
              changeRoom('r');
            }
            else {
              dialouge2 = true; /////
              game.nextFloor();
            }
          }
        }
      }
      else if (player.getX() <= distance) { //left
        if (abs(player.getY() - height/2) <= distance) {
          if (getCurrentRoom().getLeftExit()) {
            if (!(getCurrentRoom() instanceof BossRoom)) {
              changeRoom('l');
            }
            else {
              dialouge2 = true; ////
               dialouge = true;
              game.nextFloor();
            }
          }
        }
      }
      else if (player.getY() >= height - distance) { //down
        if (abs(player.getX() - width/2) <= distance) {
          if (getCurrentRoom().getDownExit()) {
            if (!(getCurrentRoom() instanceof BossRoom)) {
              changeRoom('d');
            }
            else {
              dialouge2 = true; ////
               dialouge = true;
              game.nextFloor();
            }
          }
        }
      }
      else if (player.getY() <= distance) { //up
        if (abs(player.getX() - width/2) <= distance) {
          if (getCurrentRoom().getUpExit()) {
            if (!(getCurrentRoom() instanceof BossRoom)) {
              changeRoom('u');
            }
            else {
              dialouge2 = true; ////
              dialouge = true;
              game.nextFloor();
            }
          }
        }
      }
    }
  }
  public void update() {
    getCurrentRoom().update();
    checkChangeRoom();
  }
  public void changeRoom(char d) { //This is the x and y of the room they are moving into, and the direction they entered from
    //Initialize conditions for a new room
    bulletList = new ArrayList<Bullet>();
    secondaryList = new ArrayList<SecondaryAbility>();
    enemyList = new ArrayList<Enemy>();
    
    //Get the index of the entered room
    int i = getCurrentRoomIndex()[0]; //Start x
    int j = getCurrentRoomIndex()[1]; //Start y
    switch (d) { case 'u': j--; break;
                 case 'd': j++; break;
                 case 'l': i--; break;
                 case 'r': i++; break; }

    //player.setXY(abs(player.getX()-width + 10), abs(player.getY()-height + 10));
    //Check if the room already exists
    if (roomList[i][j] != null) {
      if (roomList[i][j].getInverseExit(d)) {
        changeRoomIndex(i, j);
        player.setXY(abs(player.getX()-width), abs(player.getY()-height));
      }
    }
    
    //If there is no room, make a new one...
    else {
      Room newRoom;
      curNumRooms++; //////////////////added
      Boolean yesLeft = false, yesRight = false, yesUp = false, yesDown = false; //Represents a wall that should ALWAYS have an exit
      Boolean noLeft = false, noRight = false, noUp = false, noDown = false; //Represents a wall that can NEVER have an exit
      
      //Check for MUST make paths and, if <Index out oof bounds>, set the NEVER exit
      if (i+1 < maxFloorWidth) { //Right
        if (roomList[i+1][j] != null) {
          if (roomList[i+1][j].getInverseExit('r')) {
            numExits--;
            yesRight = true;
            noRight = !yesRight;
          }
        }
      }
      else {
        noRight = true;
      }
      if (i - 1 >= 0) { //Left
        if (roomList[i-1][j] != null) {
          if (roomList[i-1][j].getInverseExit('l')) {
            numExits--;
            yesLeft = true;
            noLeft = !yesLeft;
          }
        }
      }
      else {
        noLeft = true;
      }
      if (j + 1 < maxFloorHeight) { //Down
        if (roomList[i][j+1] != null) {
          if(roomList[i][j+1].getInverseExit('d')) {
            numExits--;
            yesDown = true;
            noDown = !yesDown;
          }
        }
      }
      else {
        noDown = true;
      }
      if (j - 1 > 0) { //Up
        if (roomList[i][j-1] != null) {
          yesUp = roomList[i][j-1].getInverseExit('u');
          noUp = !yesUp;
        }
      }
      else {
        noUp = true;
      }

      //Now that we have determined the exits of the room, which type of room do we make?
      //Make exits...
      int maxNumExits = 4 - ( int(yesRight) + int(yesLeft) +int(yesUp) +int(yesDown) ) - ( int(noRight) + int(noLeft) +int(noUp) +int(noDown) );
      //println("for exits: max exits we can make is: " + maxNumExits + " because it's \n" + "4 - " + ( int(yesRight) + int(yesLeft) +int(yesUp) +int(yesDown) ) + " - " +( int(noRight) + int(noLeft) +int(noUp) +int(noDown)));
      //println("yes: " + yesUp + yesDown + yesLeft + yesRight);
      //println("no: " + noUp + noDown + noLeft + noRight);
      Boolean setLeft = false, setRight = false, setUp = false, setDown = false;
      if (!noLeft) { setLeft = yesLeft; } 
      if (!noRight) { setRight = yesRight; } 
      if (!noUp) { setUp = yesUp; }
      if (!noDown) { setDown = yesDown; }
      //println("sets: " + setUp, setDown, setLeft, setRight);
      
      int numExitsToMake = floor(random(maxNumExits)) + 1;
      //println("we will make " + numExitsToMake + " extra exits. There were " + maxNumExits + " max exits");
      for (int k = 0; k < numExitsToMake; k++) {
        int exitNum = floor(random(6)); //I MADE THIS 6
        switch(exitNum) { case 0: if (!setLeft && !noLeft && !yesLeft) { setLeft = true; numExits++; } else { k--; }  break;
                          case 1: if (!setRight && !noRight && !yesRight) { setRight = true; numExits++; } else { k--; } break;
                          case 2: if (!setUp && !noUp && !yesUp) { setUp = true; numExits++; } else { k--; } break;
                          case 3: if (!setDown && !noDown && !yesDown) { setDown = true; numExits++; } else { k--; } break;
        }
      }
      //Check if this is the boss room
      //println("cur num exits = " + numExits);
      if (curNumRooms == bossRoomIndex || numExits == 1) { //If we need to make a boss room
        println (curNumRooms + " = " + bossRoomIndex + " || " + numExits + " == 0");
        newRoom = new BossRoom(game.getCurrentFloorIndex());
      }
      else { //Otherwise...
        newRoom = new Room(game.getCurrentFloorIndex());
        newRoom.setExits(setUp, setDown, setLeft, setRight);
      }
      changeRoomIndex(i, j);
      setRoom(i, j, newRoom);
      switch (d) { case 'u': player.setXY(width/2 - 50, height - 50); break;
                 case 'd': player.setXY(width/2 - 50, 50); break;
                 case 'l': player.setXY(width - 50, height/2 - 50); break;
                 case 'r': player.setXY(50, height/2 - 50); break; }
    }
  }
}