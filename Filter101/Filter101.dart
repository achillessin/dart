#import('dart:html');

//classes: Image
class image
{
  //data:
  num _height;
  num _width;
  String _src;
  CanvasRenderingContext2D _context;  
  Uint8ClampedArray _data;
  
  /*functions:
  loadimage(canvasid)
  toMatrix()
  filter()
  */
  image(String src,[String canvasid=null])
  {
    this._src=src;
    if(canvasid != null)
    this._context=getImageContext(canvasid);
  }
  CanvasRenderingContext2D getImageContext(String canvasid)
  {
    Document doc = window.document;
    CanvasElement canvas= doc.$dom_getElementById('${canvasid}');
   canvas.$dom_setAttribute('width', '640');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    canvas.$dom_setAttribute('height', '480');
    return canvas.getContext("2d");
    
  }
  setImage()
  {
    ImageElement i= new Element.tag('img');
    i.src=this._src;
    //i = window.document.$dom_createElement('img');
    i.on.load.add((event){
      this._context.drawImage(i, 0, 0, 640, 480);
            
    });
  }
  void draw(var im)
  {
    
  }
}

void main() {
  image i=new image("http://www.dartlang.org/imgs/dart-logo.png",'myCanvas');
  i.setImage();
  

  
  
}
  