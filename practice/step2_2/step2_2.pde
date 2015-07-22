int ship_size;
int ship_x;
int ship_y;

//初期化
void setup() {
  size(480, 640);

  ship_size = 50;
  ship_x = 240;
  ship_y = 550;
  
  rect(ship_x, ship_y, ship_size, ship_size);

}

//繰り返し
void draw() {
  background(0);
  
  rect(ship_x, ship_y, ship_size, ship_size);
  ship_x = ship_x + 1; //戦闘機が右にゆっくり移動する．
}
