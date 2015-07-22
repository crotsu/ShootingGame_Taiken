PImage shipImg;
int shipX;
int shipY;

PImage enemyImg;
int enemyX;
int enemyY;
int enemyAlive;

PImage laserImg;
int laserX;
int laserY;
int laserAlive;

void setup() {
  size(480, 640);
  imageMode(CENTER); // 画像座標の指定を中心にする

  shipImg = loadImage("ship.png");
  enemyImg = loadImage("enemy.png");
  laserImg = loadImage("laser.png");

  shipX = 240;
  shipY = 500;
  
  enemyX = (int)random(480);
  enemyY = 80;
  enemyAlive = 1;
  
  laserX = 0;
  laserY = 0;
  laserAlive = 0;
}

void draw() {
  background(0); // 画面クリアー

  if (enemyAlive == 1) {
    image(enemyImg, enemyX, enemyY);
    enemyY += 1;
  }
  else {
    enemyX = (int)random(480);
    enemyY = 80;
    enemyAlive = 1;
  }
  
  shipX = mouseX;
  shipY = mouseY;
  image(shipImg, shipX, shipY);
  
  // レーザーの処理
  // 発射（ただし，画面内にレーザーがないとき）
  if (mousePressed == true) {
    if (laserAlive == 0) {
      laserX = shipX;
      laserY = shipY;
      laserAlive = 1;
    }
  }
  // レーザーが画面にあるなら表示する
  if (laserAlive == 1) {
    image(laserImg, laserX, laserY);  
    laserY = laserY - 10;
  }
  // レーザーが画面の外に出たら，レーザーを消す
  if (laserY<0) {
    laserAlive = 0;
  }

  // 当たり判定
  if (dist(laserX, laserY, enemyX, enemyY) < 30) {
    laserAlive = 0;
    enemyAlive = 0;
  }
  
}

