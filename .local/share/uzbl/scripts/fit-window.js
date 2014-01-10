// Customize the maximum and minimum window sizes here. `wmctrl -lG` may be of help.
var max = {Width: 1024, Height: 740};
var min = {Width: 0,    Height: 0  };
 
['Width', 'Height'].map(function (property) {
  return Math.max(Math.min(document.documentElement['scroll' + property], max[property]), min[property]);
}).join('x');
