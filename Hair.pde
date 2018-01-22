class Hair
{
  // ===========================================================

  // 髪の色
  color HairColor = color(219, 175, 52);

  // シュシュの色
  color ChouchouColor = color(242, 250, 49);

  // 頭頂部付近の塗りつぶし領域の頂点(X座標)
  float HeadVerticesX[] = {123, 127, 111, 102, 80, 0};

  // 頭頂部付近の塗りつぶし領域の頂点(Y座標)
  float HeadVerticesY[] = {-208, -163, -170, -140, -160, -120};

  // 前髪のカーブ設定情報
  PVector Bangs_BeginningControlPoint = new PVector(70, -180);
  PVector Bangs_EndingControlPoint = new PVector(-20, -140);


  // ===========================================================
  // Private Memvers

  // 位置
  PVector location;

  // サイズ
  PVector localScale;


  // ===========================================================
  // Functions

  // コンストラクタ
  Hair(PVector location_, PVector scale_)
  {
    location = location_.get();
    localScale = scale_.get();
  }


  // 表示
  void display()
  {
    pushMatrix();
    translate(location.x, location.y);
    scale(localScale.x, localScale.y);

    strokeWeight(StrokeWeight);

    for(int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;

      // おさげの描画
      PVector PigtailPos = new PVector(250 * sign, -145);
      float PigtailAngle = 123 * sign;  // 回転角度(deg)
      PVector PigtailSize = new PVector(1, 1);
      drawPigtail(PigtailPos, PigtailAngle, PigtailSize);
        
      // シュシュの描画
      PVector ChouchouPos = new PVector(135 * sign, -185);
      float ChouchouAngle = 45 * sign;  // 回転角度(deg)
      PVector ChouchouSize = new PVector(1, 1);
      drawKusoChouchou(ChouchouPos, ChouchouAngle, ChouchouSize);
    }
  
    // 頭頂部付近の塗りつぶし
    drawHeadFill();

    for(int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;

      // サイドへアー(外側)の描画
      drawSideHairOutside(sign);

      // サイドへアー(内側)の描画
      drawSideHairInside(sign);

      // 前髪の描画
      drawBangs(sign);
    }
    
    // 頭頂部付近の描画
    drawHead();

    popMatrix();
  }


  // ===========================================================
  // Private Functions
  
  // 髪のおさげ部分の描画(単体)
  void drawPigtail(PVector location_, float angle, PVector scale_)
  {
    float PigtailCutAngle = 10;  // 切り込みのアングル
    float PigtailCutLength = 20; // 切り込みの大きさ
    float PigtailSize = 140;     // 全体的なサイズ
    PVector PigtailControlPoint = new PVector(360, 0); // 始点、終点共通

    pushMatrix();

    translate(location_.x, location_.y);
    rotate(radians(angle));
    scale(scale_.x, scale_.y);

    // 塗りつぶし箇所
    noStroke();
    fill(HairColor);
    beginShape();
    vertex(PigtailCutAngle + 1, 0);
    vertex(0, PigtailSize + 5);
    vertex((PigtailCutAngle + 1) * -1, 0);
    vertex(0, PigtailCutLength);
    endShape();
    
    // アウトライン + 一部塗りつぶしの箇所
    stroke(0);
    // 左右描画するので2回ループ
    for(int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;
      line(PigtailCutAngle * sign, 0, 0, PigtailCutLength);
      curve(
        PigtailControlPoint.x * sign, PigtailControlPoint.y,
        PigtailCutAngle * sign * -1, 0,
        0, PigtailSize,
        PigtailControlPoint.x * sign, PigtailControlPoint.y);
    }

    popMatrix();
  }


  // シュシュの描画(単体)
  void drawKusoChouchou(PVector location_, float rotate_, PVector scale_)
  {
    fill(ChouchouColor);

    int ChouchouCount = 3;
    PVector ChouchouArcSize = new PVector(16.8, 45);  // 丸部分のサイズ
    float ChouchouArcOffsetY = -19.2; // 丸部分と胴部分のY座標オフセット
    float ChouchouArcStart = 180;  // 円の開始する角度(deg)
    float ChouchouArcEnd = 360; // 円の停止する角度(deg)
    PVector ChouchouRectSize = new PVector(ChouchouArcSize.x * (ChouchouCount * 2), 43);  // 胴部分のサイズ
    
    pushMatrix();    
    translate(location_.x, location_.y);
    rotate(radians(rotate_));
    scale(scale_.x, scale_.y);
    
    // 胴部分
    // ※左上→右上→右下→左下でRectを生成
    // ※※形状を調整しやすいように敢えて頂点打ってた
    beginShape();
    PVector halfSize = PVector.div(ChouchouRectSize, 2);
    vertex(halfSize.x * -1, halfSize.y * -1);
    vertex(halfSize.x, halfSize.y * -1);
    vertex(halfSize.x, halfSize.y);
    vertex(halfSize.x * -1, halfSize.y);
    vertex(halfSize.x * -1, halfSize.y * -1);    
    endShape();
    
    // 丸部分(3つ描画)
    int index = 1;
    for(int i = 0; i < ChouchouCount; ++i)
    {
      arc(
        (ChouchouArcSize.x * index) - (ChouchouArcSize.x * ChouchouCount), ChouchouArcOffsetY,
        ChouchouArcSize.x * 2, ChouchouArcSize.y,
        radians(ChouchouArcStart),
        radians(ChouchouArcEnd),
        OPEN);
      index += 2;
    }
    
    popMatrix();
  }


  // 頭頂部付近の塗りつぶし
  void drawHeadFill()
  { 
    noStroke();
    fill(HairColor);

    beginShape();
    int HeadVerticesLength = HeadVerticesX.length;
    for(int i = 0; i < HeadVerticesLength; ++i)
    {
      vertex(HeadVerticesX[i] * -1, HeadVerticesY[i]);
    }
    for(int i = (HeadVerticesLength - 2); i >= 0; --i)
    {
      vertex(HeadVerticesX[i], HeadVerticesY[i]);
    }
    endShape();
  }


  // 頭頂部付近の描画
  void drawHead()
  {
    PVector Head_BeginningControlPoint = new PVector(-200, 10);
    PVector Head_FirstPoint = new PVector(-123, -208);
    PVector Head_SecondPoint = new PVector(123, -208);
    PVector Head_EndingControlPoint = new PVector(150, 10);
    curve(
        Head_BeginningControlPoint.x, Head_BeginningControlPoint.y, 
        Head_FirstPoint.x, Head_FirstPoint.y,
        Head_SecondPoint.x, Head_SecondPoint.y,
        Head_EndingControlPoint.x, Head_EndingControlPoint.y);
  }


  // サイドへアー(外側)の描画
  void drawSideHairOutside(int sign)
  {
    fill(HairColor);
    stroke(0);

    PVector SideHairOutside_BeginningControlPoint = new PVector(-400 * sign, 322);
    PVector SideHairOutside_FirstPoint = new PVector(130 * sign, 40);
    PVector SideHairOutside_SecondPoint = new PVector(123 * sign, -208);
    PVector SideHairOutside_EndingControlPoint = new PVector(-140 * sign, -180);
    curve(
        SideHairOutside_BeginningControlPoint.x, SideHairOutside_BeginningControlPoint.y,
        SideHairOutside_FirstPoint.x, SideHairOutside_FirstPoint.y,
        SideHairOutside_SecondPoint.x, SideHairOutside_SecondPoint.y,
        SideHairOutside_EndingControlPoint.x, SideHairOutside_EndingControlPoint.y); 
  }


  // サイドへアー(内側)の描画
  void drawSideHairInside(int sign)
  {
    fill(SkinColor);
    stroke(0);
    PVector SideHairInside_BeginningControlPoint = new PVector(40 * sign, -369);
    PVector SideHairInside_FirstPoint = new PVector(123 * sign, -180);
    PVector SideHairInside_SecondPoint = new PVector(130 * sign, 40);
    PVector SideHairInside_EndingControlPoint = new PVector(66 * sign, 73);
    curve(
        SideHairInside_BeginningControlPoint.x, SideHairInside_BeginningControlPoint.y,
        SideHairInside_FirstPoint.x, SideHairInside_FirstPoint.y,
        SideHairInside_SecondPoint.x, SideHairInside_SecondPoint.y,
        SideHairInside_EndingControlPoint.x, SideHairInside_EndingControlPoint.y); 
  }

  
  // 前髪の描画
  void drawBangs(int sign)
  {        
    fill(HairColor);
    stroke(0);

    int HeadVerticesLength = HeadVerticesX.length;
    for(int i = 1; i < HeadVerticesLength; ++i)
    {
      float posX = HeadVerticesX[i] * sign;
      float nextX = HeadVerticesX[i + 1] * sign;
      float posY = HeadVerticesY[i];
      float nextY = HeadVerticesY[i + 1];
      // ※4番目からはlineでは無くcurveで1回描画を行う
      if(i >= 4)
      {
        curve(
            Bangs_BeginningControlPoint.x * sign, Bangs_BeginningControlPoint.y,
            posX, posY,
            nextX, nextY,
            Bangs_EndingControlPoint.x * sign, Bangs_EndingControlPoint.y);
        break;
      }
      else
      {
        line(posX, posY, nextX, nextY);
      }
    }
  }
}

