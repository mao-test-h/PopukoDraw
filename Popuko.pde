class Popuko
{
  // ===========================================================
  // Private Memvers

  // 位置
  PVector location;

  // 両目
  Eye eyes[] = new Eye[2];

  // 髪
  Hair hair;


  // ===========================================================
  // Functions

  // コンストラクタ
  Popuko(PVector location_)
  {
    location = location_.get();
  }


  // 表示
  void display()
  {
    // 目のインスタンス化
    for(int i = 0; i < eyes.length; ++i)
    {
      float ipd = 65 * ((i == 0) ? -1 : 1); // 瞳孔間距離
      PVector EyePos = new PVector(0 + ipd, -21);
      PVector EyeSize = new PVector(0.45, 0.4);
      eyes[i] = new Eye(EyePos, EyeSize, (i == 0));
    }

    // 髪のインスタンス化
    PVector HairPos = new PVector(0, 73);
    PVector HairSize = new PVector(0.95, 1.0);
    hair = new Hair(HairPos, HairSize);


    pushMatrix();
    translate(location.x, location.y);

    // 輪郭の描画
    drawContour();

    // 髪の描画
    hair.display();

    for(int i = 0; i < 2; ++i)
    {
      int sign = ((i == 0) ? -1 : 1);

      // 口の描画
      drawMouth(sign);

      // 眉の描画
      drawEyebrows(sign);

      // 目の描画
      eyes[i].display();
    }
    
    // 鼻の描画
    drawNose();

    popMatrix();
  }


  // ===========================================================
  // Private Functions
  
  // 鼻の描画
  void drawNose()
  {
    noStroke();
    fill(0);

    PVector NosePos = new PVector(0, 44);
    PVector NoseSize = new PVector(5, 5);
    ellipse(NosePos.x, NosePos.y, NoseSize.x, NoseSize.y);
  }


  // 眉の描画
  void drawEyebrows(int sign)
  {
    noFill();
    strokeWeight(StrokeWeight);
    stroke(0);
    strokeCap(SQUARE);

    PVector EyebrowsPos = new PVector(65, -76);
    pushMatrix();
    translate((EyebrowsPos.x * sign), EyebrowsPos.y);

    PVector EyebrowsPartsPos = new PVector(0, 0);
    PVector EyebrowsPartsSize = new PVector(72, 41);
    float arcStart = -160;  // 円の開始する角度(deg)
    float arcEnd = -20; // 円の停止する角度(deg)
    arc(EyebrowsPartsPos.x, EyebrowsPartsPos.y, EyebrowsPartsSize.x, EyebrowsPartsSize.y, radians(arcStart), radians(arcEnd));

    popMatrix();
  }


  // 口の描画
  void drawMouth(int sign)
  {
    noFill();
    strokeWeight(StrokeWeight);
    stroke(0);
    strokeCap(SQUARE);

    PVector MouthPos = new PVector(10 * sign, 52);
    float MouthAngle = -14 * sign;  // 回転角度(deg)
    pushMatrix();
    translate(MouthPos.x, MouthPos.y);
    rotate(radians(MouthAngle));

    PVector MouthPartsPos = new PVector(0, 0);
    PVector MouthPartsSize = new PVector(32, 46);
    float arcStart = 35;  // 円の開始する角度(deg)
    float arcEnd = 150; // 円の停止する角度(deg)
    arc(MouthPartsPos.x, MouthPartsPos.y, MouthPartsSize.x, MouthPartsSize.y, radians(arcStart), radians(arcEnd));

    popMatrix();
  }


  // 輪郭の描画
  void drawContour()
  {
    strokeWeight(StrokeWeight);
    stroke(0);
    fill(SkinColor);
    
    // 輪郭
    PVector ContourPos = new PVector(0, -9);
    PVector ContourSize = new PVector(333, 274);
    ellipse(ContourPos.x, ContourPos.y, ContourSize.x, ContourSize.y);
    
    // 両耳
    PVector EarPos = new PVector(165, 0);
    PVector EarSize = new PVector(35, 64);
    for(int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;
      ellipse(EarPos.x * sign, EarPos.y, EarSize.x, EarSize.y);
    }
  }
}

