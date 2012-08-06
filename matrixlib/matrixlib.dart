#import('dart:html');
#source('vector.dart');

/// mat2x2 is a column major matrix where each column is represented by [vec2]. This matrix has 2 columns and 2 rows.
class mat {
  int rows,cols;
  List<num> _data;
  
  mat.fromList(List<num> data, int rows, int cols)
  {
    this._data= new List<num>.from(data);
    this.rows=rows;
    this.cols=cols;
  }
  mat.fromMat(mat m)
  {
    this.rows=m.rows;
    this.cols=m.cols;
    this._data = new List<num>.from(m._data);
  }
 /// Constructs a new [mat2x2] filled with zeros.
  mat.zero(int rows, int cols) {
 
    this._data = new List<num>(rows*cols);
    for(int i=0;i<rows*cols;i++)
      this._data[i]=0.0;
  }
  /// Constructs a new identity [mat2x2].
  mat.identity(int size) {
   
    this._data = new List<num>(size*size);
    for(int i=0;i<size;i++)
      for(int j=0;j<size;j++)
        if(i==j)
          this._data[i*this.cols+j]=1.0;
        else
          this._data[i*this.cols+j]=0.0;
    
  }
  
  /// Returns a printable string
  String toString() {
    var s = new StringBuffer();
    for(int i=0;i<this.rows;i++)
    {
      for(int j=0;j<this.cols;j++)
        {
            s.add(this._data[i*this.cols+j].toString());
            s.add(' ');
        }
      
      s.add('\n');
    }
    
   return s.toString();
  }


  /// Returns row 0
  vec2 get row0() => getRow(0);
  /// Returns row 1
  vec2 get row1() => getRow(1);
  /// Sets row 0 to [arg]
  set row0(vec2 arg) => setRow(0, arg);
  /// Sets row 1 to [arg]
  set row1(vec2 arg) => setRow(1, arg);
  /// Assigns the [column] of the matrix [arg]
  void setRow(int row, vec2 arg) {
    assert(row >= 0 && row < 2);
    col0[row] = arg.x;
    col1[row] = arg.y;
  }
  /// Gets the [row] of the matrix
  vec2 getRow(int row) {
    assert(row >= 0 && row < 2);
    vec2 r = new vec2();
    r.x = col0[row];
    r.y = col1[row];
    return r;
  }
  /// Assigns the [column] of the matrix [arg]
  void setColumn(int column, vec2 arg) {
    assert(column >= 0 && column < 2);
    this[column] = arg;
  }
  /// Gets the [column] of the matrix
  vec2 getColumn(int column) {
    assert(column >= 0 && column < 2);
    return new vec2(this[column]);
  }
  /// Returns a new vector or matrix by multiplying [this] with [arg].
  Dynamic operator*(Dynamic arg) {
    if (arg is num) {
      mat2x2 r = new mat2x2.zero();
      r.col0.x = col0.x * arg;
      r.col0.y = col0.y * arg;
      r.col1.x = col1.x * arg;
      r.col1.y = col1.y * arg;
      return r;
    }
    if (arg is vec2) {
      vec2 r = new vec2.zero();
      r.x =  (this.col0.x * arg.x) + (this.col1.x * arg.y);
      r.y =  (this.col0.y * arg.x) + (this.col1.y * arg.y);
      return r;
    }
    if (2 == arg.rows) {
      Dynamic r = null;
      if (arg.cols == 2) {
        r = new mat2x2.zero();
        r.col0.x =  (this.col0.x * arg.col0.x) + (this.col1.x * arg.col0.y);
        r.col1.x =  (this.col0.x * arg.col1.x) + (this.col1.x * arg.col1.y);
        r.col0.y =  (this.col0.y * arg.col0.x) + (this.col1.y * arg.col0.y);
        r.col1.y =  (this.col0.y * arg.col1.x) + (this.col1.y * arg.col1.y);
        return r;
      }
      return r;
    }
    throw new IllegalArgumentException(arg);
  }
  /// Returns new matrix after component wise [this] + [arg]
  mat2x2 operator+(mat2x2 arg) {
    mat2x2 r = new mat2x2();
    r.col0.x = col0.x + arg.col0.x;
    r.col0.y = col0.y + arg.col0.y;
    r.col1.x = col1.x + arg.col1.x;
    r.col1.y = col1.y + arg.col1.y;
    return r;
  }
  /// Returns new matrix after component wise [this] - [arg]
  mat2x2 operator-(mat2x2 arg) {
    mat2x2 r = new mat2x2();
    r.col0.x = col0.x - arg.col0.x;
    r.col0.y = col0.y - arg.col0.y;
    r.col1.x = col1.x - arg.col1.x;
    r.col1.y = col1.y - arg.col1.y;
    return r;
  }
  /// Returns new matrix -this
  mat2x2 operator negate() {
    mat2x2 r = new mat2x2();
    r[0] = -this[0];
    r[1] = -this[1];
    return r;
  }
  /// Returns the tranpose of this.
  mat2x2 transposed() {
    mat2x2 r = new mat2x2();
    r.col0.x = col0.x;
    r.col0.y = col1.x;
    r.col1.x = col0.y;
    r.col1.y = col1.y;
    return r;
  }
  /// Returns the component wise absolute value of this.
  mat2x2 absolute() {
    mat2x2 r = new mat2x2();
    r.col0.x = col0.x.abs();
    r.col0.y = col0.y.abs();
    r.col1.x = col1.x.abs();
    r.col1.y = col1.y.abs();
    return r;
  }
  /// Returns the determinant of this matrix.
  num determinant() {
    return (col0.x * col1.y) - (col0.y*col1.x);
  }
  /// Returns the trace of the matrix. The trace of a matrix is the sum of the diagonal entries
  num trace() {
    num t = 0.0;
    t += col0.x;
    t += col1.y;
    return t;
  }
  /// Returns infinity norm of the matrix. Used for numerical analysis.
  num infinityNorm() {
    num norm = 0.0;
    {
      num row_norm = 0.0;
      row_norm += this[0][0].abs();
      row_norm += this[0][1].abs();
      norm = row_norm > norm ? row_norm : norm;
    }
    {
      num row_norm = 0.0;
      row_norm += this[1][0].abs();
      row_norm += this[1][1].abs();
      norm = row_norm > norm ? row_norm : norm;
    }
    return norm;
  }
  /// Returns relative error between [this] and [correct]
  num relativeError(mat2x2 correct) {
    num this_norm = infinityNorm();
    num correct_norm = correct.infinityNorm();
    num diff_norm = (this_norm - correct_norm).abs();
    return diff_norm/correct_norm;
  }
  /// Returns absolute error between [this] and [correct]
  num absoluteError(mat2x2 correct) {
    num this_norm = infinityNorm();
    num correct_norm = correct.infinityNorm();
    num diff_norm = (this_norm - correct_norm).abs();
    return diff_norm;
  }
  /// Invert the matrix. Returns the determinant.
  num invert() {
    num det = determinant();
    if (det == 0.0) {
      return 0.0;
    }
    num invDet = 1.0 / det;
    num temp = col0.x;
    col0.x = col1.y * invDet;
    col0.y = - col0.y * invDet;
    col1.x = - col1.x * invDet;
    col1.y = temp * invDet;
    return det;
  }
  /// Turns the matrix into a rotation of [radians]
  void setRotation(num radians_) {
    num c = Math.cos(radians_);
    num s = Math.sin(radians_);
    col0.x = c;
    col0.y = s;
    col1.x = -s;
    col1.y = c;
  }
  /// Converts into Adjugate matrix and scales by [scale]
  void selfScaleAdjoint(num scale) {
    num temp = col0.x;
    col0.x = col1.y * scale;
    col1.x = - col1.x * scale;
    col0.y = - col0.y * scale;
    col1.y = temp * scale;
  }
  mat2x2 copy() {
    return new mat2x2.copy(this);
  }
  void copyIntoMatrix(mat2x2 arg) {
    arg.col0.x = col0.x;
    arg.col0.y = col0.y;
    arg.col1.x = col1.x;
    arg.col1.y = col1.y;
  }
  void copyFromMatrix(mat2x2 arg) {
    col0.x = arg.col0.x;
    col0.y = arg.col0.y;
    col1.x = arg.col1.x;
    col1.y = arg.col1.y;
  }
  mat2x2 selfAdd(mat2x2 o) {
    col0.x = col0.x + o.col0.x;
    col0.y = col0.y + o.col0.y;
    col1.x = col1.x + o.col1.x;
    col1.y = col1.y + o.col1.y;
    return this;
  }
  mat2x2 selfSub(mat2x2 o) {
    col0.x = col0.x - o.col0.x;
    col0.y = col0.y - o.col0.y;
    col1.x = col1.x - o.col1.x;
    col1.y = col1.y - o.col1.y;
    return this;
  }
  mat2x2 selfScale(num o) {
    col0.x = col0.x * o;
    col0.y = col0.y * o;
    col1.x = col1.x * o;
    col1.y = col1.y * o;
    return this;
  }
  mat2x2 selfNegate() {
    col0.x = -col0.x;
    col0.y = -col0.y;
    col1.x = -col1.x;
    col1.y = -col1.y;
    return this;
  }
  mat2x2 selfMultiply(mat2x2 arg) {
    final num m00 = col0.x;
    final num m01 = col1.x;
    final num m10 = col0.y;
    final num m11 = col1.y;
    final num n00 = arg.col0.x;
    final num n01 = arg.col1.x;
    final num n10 = arg.col0.y;
    final num n11 = arg.col1.y;
    col0.x =  (m00 * n00) + (m01 * n10);
    col1.x =  (m00 * n01) + (m01 * n11);
    col0.y =  (m10 * n00) + (m11 * n10);
    col1.y =  (m10 * n01) + (m11 * n11);
    return this;
  }
  mat2x2 selfTransposeMultiply(mat2x2 arg) {
    num m00 = col0.x;
    num m01 = col0.y;
    num m10 = col1.x;
    num m11 = col1.y;
    col0.x =  (m00 * arg.col0.x) + (m01 * arg.col0.y);
    col1.x =  (m00 * arg.col1.x) + (m01 * arg.col1.y);
    col0.y =  (m10 * arg.col0.x) + (m11 * arg.col0.y);
    col1.y =  (m10 * arg.col1.x) + (m11 * arg.col1.y);
    return this;
  }
  mat2x2 selfMultiplyTranpose(mat2x2 arg) {
    num m00 = col0.x;
    num m01 = col1.x;
    num m10 = col0.y;
    num m11 = col1.y;
    col0.x =  (m00 * arg.col0.x) + (m01 * arg.col1.x);
    col1.x =  (m00 * arg.col0.y) + (m01 * arg.col1.y);
    col0.y =  (m10 * arg.col0.x) + (m11 * arg.col1.x);
    col1.y =  (m10 * arg.col0.y) + (m11 * arg.col1.y);
    return this;
  }
  vec2 transformDirect(vec2 arg) {
    num x_ =  (this.col0.x * arg.x) + (this.col1.x * arg.y);
    num y_ =  (this.col0.y * arg.x) + (this.col1.y * arg.y);
    arg.x = x_;
    arg.y = y_;
    return arg;
  }
  vec2 transform(vec2 arg) {
    vec2 d = arg.copy();
    return transformDirect(d);
  }
  /// Copies [this] into [array] starting at [offset].
  void copyIntoArray(Float32Array array, [int offset=0]) {
    int i = offset;
    array[i] = col0.x;
    i++;
    array[i] = col0.y;
    i++;
    array[i] = col1.x;
    i++;
    array[i] = col1.y;
    i++;
  }
  /// Returns a copy of [this] as a [Float32Array].
  Float32Array copyAsArray() {
    Float32Array array = new Float32Array(4);
    int i = 0;
    array[i] = col0.x;
    i++;
    array[i] = col0.y;
    i++;
    array[i] = col1.x;
    i++;
    array[i] = col1.y;
    i++;
    return array;
  }
  /// Copies elements from [array] into [this] starting at [offset].
  void copyFromArray(Float32Array array, [int offset=0]) {
    int i = offset;
    col0.x = array[i];
    i++;
    col0.y = array[i];
    i++;
    col1.x = array[i];
    i++;
    col1.y = array[i];
    i++;
  }