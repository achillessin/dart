
//implement iterable interface
//add bytearray as base data holder

class vector<T extends num> 
{
  
  //data:
  num size;
  List<T> _data;
   
  //functions:
  vector(num size):size=size
      {
          if(this.size<=0)
            throw new IllegalArgumentException("Vector size must be greater than zero");
          _data=new List<T>(this.size);
          
      }
  vector.copy(vector v)
      {
        this.size=v.size;      
        this._data=new List<T>(this.size);
        for(int i=0;i<v.size;i++)
          this._data[i]=v[i];
    
      }
  vector.zero(num size)
  {
    if(this.size<=0)
      throw new IllegalArgumentException("Vector size must be greater than zero");
    _data=new List<T>(this.size);
    for(int i=0;i<this.size;i++)
      this._data[i]=0;
  }
  vector.list(List<T> l)
  {
    this.size=l.length;
    this._data=new List<T>.from(l);
  }
/// Returns a printable string
  String toString()
  {
    return this._data.toString();
  }
  /// Returns a component from vec2. This is indexed as an array with [i]
  T operator[](int i) {
    assert(i >= 0 && i < this.size);
    
    return this._data[i];
  }
  /// Assigns a component in vec2 the value in [v]. This is indexed as an array with [i]
  void operator[]=(int i, T v) {
    assert(i >= 0 && i < this.size);
    //if(v is T)
    this._data[i]=v;
    //else
    //  throw new IllegalArgumentException("Right hand side value is not of type T in vector<T>");
  }
  /// Returns a new vec2 from -this
  vector<num> operator negate()
  {
    if( this is num)
    {
      vector<T> v=new vector.copy(this);
      for(int i=0;i<v.size;i++)
        v[i]=-1*v[i];
      return v;
    }
  }
  /// Returns a new vec2 from this - [other]
  vector<T> operator-(vector other)
  {
    vector<T> v=new vector<T>.list(this._data);
    for(int i=0;i<v.size;i++)
      v[i]=v[i]-other[i];
    return v;
  }
  /// Returns a new vec2 from this + [other]
  vector operator+(vector other) 
  {
    vector<T> v=new vector<T>.list(this._data);
    for(int i=0;i<v.size;i++)
      v[i]=v[i]+other[i];
    return v;
    
  }
  /// Returns a new vec2 scaled by [other]
  vector<T> operator*(Dynamic other) {
    if (other is num) {
      vector<T> v = new vector<T>.copy(this);
      for(int i=0;i<v.size;i++)
        v[i]=v[i]*other;
      return v;
    }
    if (other is vector) {
      vector v=new vector<T>.copy(this);
      for(int i=0;i<v.size;i++)
        v[i]=v[i]*other[i];
      return v;
    }
  }
  /// Returns a new vec2 divided by [other]
  vector<T> operator/(Dynamic other) {
    if (other is num) {
      return (this*(1/other));
    }
    if (other is vector) {
      vector<T> v= new vector<T>.list(this._data);
      for(int i=0;i<v.size;i++)
        v[i]=v[i]/other[i];
      return v;
    }
  }
 

  /// Returns length of this
  num get length() {
    num sum = 0.0;
    for(int i=0;i<this.size;i++)
      sum+=this._data[i];
    return Math.sqrt(sum);
  }
  /// Returns squared length of this
  num get length2() {
    num sum = 0.0;
    for(int i=0;i<this.size;i++)
      sum+=this._data[i];
    return sum;
  }
  /// Normalizes this
  void normalize() {
    num l = this.length;
    if (l == 0.0) {
      return;
    }
    for(int i=0;i<this.size;i++)
    {
      this._data[i]=this._data[i]/l;
   
    }
  }
  /// Returns the dot product of [this] and [other]
  num dot(vector<T> other) {
    num sum = 0.0;
    for(int i=0;i<this.size;i++)
    {
      sum+=other[i]*this._data[i];
    }
    return sum;
  }
  /// Returns the relative error between [this] and [correct]
  num relativeError(vector<T> correct) {
    num this_norm = length;
    num correct_norm = correct.length;
    num diff_norm = (this_norm - correct_norm).abs();
    return diff_norm/correct_norm;
  }
  /// Returns the absolute error between [this] and [correct]
  num absoluteError(vector<T> correct) {
    num this_norm = length;
    num correct_norm = correct.length;
    num diff_norm = (this_norm - correct_norm).abs();
    return diff_norm;
  } 
  vector<T> copy() {
    vector<T> c = new vector<T>.copy(this);
    return c;
  }
  void copyIntoVector(vector<T> arg) {
    for(int i=0;i<this.size;i++)
    {
      arg[i]=this._data[i];
    }
  }
  void copyFromVector(vector<T> arg) {
    for(int i=0;i<this.size;i++)
    {
      this._data[i]=arg[i];
    }
  }
 
  
  
}
