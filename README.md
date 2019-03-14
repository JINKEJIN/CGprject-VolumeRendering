# CGprject-VolumeRendering
volumetric rendering for MRI scan of a human head
Implemented by OpenGL.

What this project implement:

1.Extract one horizontal slice (x and y vary with fragment coordinates, z is fixed)

2.Extract one vertical slice (x and z vary with fragment coordinates, y is fixed)

3.Accumulate the density by integrating all slices along the z axis

4.Accumulate along the y axis and rotate along the z axis

5.Perform ray-marching and display the iso-surface with a constant color.

6.Control the target density (also called the iso-value) with the keyboard

7.Shade an iso-surface. Display the normal as an RGB color.

8.Compute diffuse and specular shading with a Phong model.

9.Rotate the volume with the light direction attached to the camera

10.render the skull and skin with different colors
