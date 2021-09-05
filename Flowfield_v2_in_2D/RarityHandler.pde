//This is unfinished as ideally I need it to pull data from a smart contract but I cannot do that since there are no java libaries to do so, that can be done once the code is refactored to Js (However, this would take a long time and I'm
//more just getting ideas down to get a system which works and looks nice). So for now I have this system where the rarity rolls and then runs down an If/else block. This could be done with a switch function or something, other than that,
// I don't know how to make this more efficient. 

class RarityHandler {
  
  int colRarity = int(random(0, 100));
  int distRarity = int(random(0, 4));

  RarityHandler() {
    
  }

  void colSel() {

    //This where the colour pallete is selected
    println("Globally rarity = "+ colRarity);
    if (colRarity > 99) {
      pallete = 0;
      println("Pallete: 0, Rarity " + colRarity);
    } else if (colRarity > 96) {
      pallete = 1;
      println("Pallete: 1, Rarity " + colRarity);
    } else if (colRarity > 90) {
      pallete = 2;
      println("Pallete: 2, Rarity " + colRarity);
    } else if (colRarity > 83) {
      pallete = 3;
      println("Pallete: 3, Rarity " + colRarity);
    } else if (colRarity > 75) {
      pallete = 4;
      println("Pallete: 4, Rarity " + colRarity);
    } else if (colRarity > 65) {
      pallete = 5;
      println("Pallete: 5, Rarity " + colRarity);
    } else if (colRarity >52) {
      pallete = 6;
      println("Pallete: 6, Rarity " + colRarity);
    } else if (colRarity > 40) {
      pallete = 7;
      println("Pallete: 7, Rarity " + colRarity);
    }
  }

  void distSel() {

    println("Global distRarity = " + distRarity);
    if (distRarity == 0) {
      form.createThickRectangle();
    } else if (distRarity == 1) {
      form.createSinWave();
    } else if (distRarity == 2) {

      form.createThinRectangle();
    } else if (distRarity ==3) {
      int r = ceil(random(0, 4));
      println("Circles created: " + r);
      for (int i = 0; i < r; i++) {
        form.createCircle();
      }
    }
  }
}
