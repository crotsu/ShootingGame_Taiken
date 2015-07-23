// 自機
PImage shipImg;
int shipX;
int shipY;

// 敵
PImage enemyImg;
int enemyX;
int enemyY;
int enemyAlive;

// レーザー
PImage laserImg;
int laserX;
int laserY;
int laserAlive;

//-------------------------------
// ゲーム起動時に１度だけ実行する
//-------------------------------
void setup() {
  size(480, 640);
  imageMode(CENTER); // 画像座標の指定を中心にする

  // 画像を読み込む
  shipImg = loadImage("ship.png");
  enemyImg = loadImage("enemy.png");
  laserImg = loadImage("laser.png");

  shipX = 240;
  shipY = 500;

  // enemyAlive, laserAliveが1のとき存在する．0のとき存在しない．
  enemyAlive = 0;  
  laserAlive = 0;
}

//-------------------------------------------
// ゲーム実行時に１秒間に60回画面が更新される
//-------------------------------------------
void draw() {
  background(0); // 画面クリアー（画面を黒を塗りつぶす）

  // 敵が画面内に存在するなら
  if (enemyAlive == 1) {
    image(enemyImg, enemyX, enemyY);
    enemyY += 1;
  }
  else {
    enemyX = (int)random(480);
    enemyY = 80;
    enemyAlive = 1;
  }
  
  // 自機をマウスで動かす
  shipX = mouseX;
  shipY = mouseY;
  image(shipImg, shipX, shipY);
  
  // レーザーの処理
  // 発射（ただし，画面内にレーザーが存在しないとき）
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
    laserX = laserX + (int)random(10)-5;
  }
  // レーザーが画面の外に出たら，レーザーを消す
  if (laserY<0) {
    laserAlive = 0;
  }

  // 当たり判定
  if (dist(laserX, laserY, enemyX, enemyY) < 30) { // レーザーと敵の中心座標の距離が30以内なら
    laserAlive = 0;
    enemyAlive = 0;
  }
  
}

