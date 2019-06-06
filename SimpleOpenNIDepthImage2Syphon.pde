
/* --------------------------------------------------------------------------
 * SimpleOpenNI DepthImage Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * Syphon support added 2019 jcurtis
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;
import codeanticode.syphon.*;


SimpleOpenNI  context;
SyphonServer server;
PGraphics canvas;


void setup()
{
  size(640, 480, P3D);
  context = new SimpleOpenNI(this);
  canvas = createGraphics(640, 480, P3D);
  
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // mirror is by default enabled
  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();

  // enable ir generation
  context.enableRGB();
}

void draw()
{
  // update the cam
  context.update();

  background(200, 0, 0);

  // draw depthImageMap
  image(context.depthImage(), 0, 0);

  // draw irImageMap
  image(context.rgbImage(), context.depthWidth() + 10, 0);
  
  canvas.beginDraw();
  canvas.background(0);
  canvas.image(context.depthImage(),0,0);
  canvas.endDraw();
  server.sendImage(canvas);
}
