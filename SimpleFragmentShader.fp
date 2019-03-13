#version 330 core

// Interpolated values from the vertex shaders
in vec2 fragmentUV;

// Values that stay constant
uniform sampler2D myTextureSamplerVolume;

//Rotation Angle
uniform float alpha;
//iso value
uniform float iVal;

uniform sampler2D texISN;

// Ouput data
out vec3 color;

// Input: z coordinate of the point in the volume, between 0 and 1
// Output: grid coordinates (i,j) of the slice where the point lies, between (0,0) and (9,9)
// Warning: use the fonction "floor" to make sure that the coordinates of the slice are integer. 
// For instance, for z = 0.823, the function should return (i=2,j=8) because the closest slice is the 82nd one.
vec2 slice_coordinate(float z)
{
      //rescale z
      float z2 = z*100.;

      //coordinate of the slice
      float j = floor(z2/10.);
      float i = floor(z2 - 10.*j);

      return vec2(i,j);
}

// Input: (x,y,z) coordinates of the point in the volume, between (0,0,0) and (1,1,1)
// Output: (u,v) coordinates of the pixel in the texture
vec2 pixel_coordinate(float x, float y, float z)
{
      vec2 sliceCoord = slice_coordinate(z);

      //coordinate of the pixel in the slice
      float u = x/10.;
      float v = y/10.;

      return vec2(u,v)+slice_coordinate(z)/10.;
}

void main()
{ 
      vec2 pixCoord;
      float x,y,z;

      //extract one horizontal slice (x and y vary with fragment coordinates, z is fixed)
      x = fragmentUV.x;
      y = fragmentUV.y;
      z = 82./100.; //extract 82nd slice

//      pixCoord = pixel_coordinate(x,y,z);
//      color = texture(myTextureSamplerVolume, pixCoord).rgb;


/*     
      //Accumulate all horizontal slices 
      //...
*/

/*	vec3 newC = vec3(0.0, 0.0, 0.0);
	for(float i = 0.0; i < 1.0; i += 1./100.){
		pixCoord = pixel_coordinate(x,y,i);
		newC += texture(myTextureSamplerVolume, pixCoord).rgb;
	}
	newC = newC / 100.;
	color = newC;

*/
/*
      //extract one vertical slice (x and z vary with fragment coordinates, y is fixed)
      //...
*/
/*
		pixCoord = pixel_coordinate(x,50./100.,fragmentUV.y); //extract 50th slide
		color = texture(myTextureSamplerVolume, pixCoord).rgb;
*/
/*
      //Accumulate all vertical slices 
      //...
*/
/*
    z = fragmentUV.y;
	vec3 newC = vec3(0.0, 0.0, 0.0);
	for(float i = 0.0; i < 1.0; i += 1./256.){
		pixCoord = pixel_coordinate(x,i,z);
		newC += texture(myTextureSamplerVolume, pixCoord).rgb;
	}
	newC = newC / 256.;
	color = newC;
*/
/*
      //Accumulate all vertical slices after rotation by rotationAngle around the z axis
      //...
*/
/*
	vec3 newC = vec3(0.0, 0.0, 0.0);
	vec2 rc = fragmentUV;
	float sin_f = sin(alpha);
	float cos_f = cos(alpha);
	for(float i = 0.0; i < 1.0; i += 1./256.){
		rc = vec2(fragmentUV.x,i);
		rc -= 0.5;
		rc *= mat2(cos_f, sin_f, -sin_f, cos_f);
		rc += 0.5;
		pixCoord = pixel_coordinate( rc.x,rc.y, fragmentUV.y);
		newC += texture(myTextureSamplerVolume, pixCoord).rgb;
	}
	color = newC / 256.;
*/
/*
     //Ray marching until density above a threshold (i.e., extract an iso-surface)
     //...
*/
/*
vec3 c;
color=vec3(0,0,0);
for(float f = 0.0; f < 1.0; f += 1./256.){
  pixCoord = pixel_coordinate(x,f,y);
  c = texture(myTextureSamplerVolume, pixCoord).rgb;
  if(c.r > iVal){
	color = vec3(1,1,1);
	break;
  }
}
*/
/*
     //Ray marching until density above a threshold, display iso-surface normals
     //...
*/

/*color = vec3(0,0,0);
vec3 c;
for(float f = 0.0; f < 1.0; f += 1./256.){
	pixCoord = pixel_coordinate(x,f,y);
	c = texture(myTextureSamplerVolume, pixCoord).rgb;
	if(c.r > iVal){
		color = texture(texISN, pixCoord).rgb;
		break;
	}    
}	
*/
/* 
    //Ray marching until density above a threshold, display shaded iso-surface
    //...
*/

vec3 normTxt = vec3(0,0,0);
vec3 c,cc;
vec2 rc = fragmentUV;
float sin_f = sin(alpha);
float cos_f = cos(alpha);

for(float f = 0.0; f < 1.0; f += 1./256.){
	rc = vec2(fragmentUV.x,f);
	rc -= 0.5;
	rc *= mat2(cos_f, sin_f, -sin_f, cos_f);
	rc += 0.5;
	pixCoord = pixel_coordinate(rc.x,rc.y,y);
	c = texture(myTextureSamplerVolume, pixCoord).rgb;
	if(c.r > iVal){
		normTxt = texture(texISN, pixCoord).rgb;
		cc = texture(myTextureSamplerVolume, pixCoord).rgb;
		cc = vec3(0.93,0.92,0.84);
		if(c.r < 0.35){
			cc = vec3(1,0.8,0.58);
		}
		break;
	}
}

vec3 L = normalize(vec3(-0.5,1.0,1.0));
L *= mat3(cos_f, sin_f, 0, -sin_f, cos_f,0,0,0,1);

vec3 N = normalize(normTxt*2.0-1.0);
vec3 R = normalize(reflect(-L,N));
float diffuse = max(dot(N,-L),0.);
vec3 V = normalize(vec3(0.5,0.5,1.0));
float spec = pow(max(dot(R,V),0),64.0);

color = diffuse * cc + spec * cc;

}