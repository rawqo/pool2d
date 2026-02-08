shader_type canvas_item;

uniform sampler2D mask_texture;
uniform int numeroDeBola;
uniform float linear_velocity;
uniform vec4 quaternion = vec4(0.0, 0.0, 0.0, 1.0); // Default: identity quaternion


// uniform float shift_amount: hint_range(0.0, 360.0, 1.0) = 0.0;

// Convert RGB color to HSV color space
// Input: vec3 with components in range [0, 1]
// Output: vec3 with h in [0, 360], s and v in [0, 1]
vec3 rgb2hsv(vec3 rgb) {
	float r = rgb.r;
	float g = rgb.g;
	float b = rgb.b;
	
	float max_val = max(r, max(g, b));
	float min_val = min(r, min(g, b));
	float delta = max_val - min_val;
	
	float h = 0.0;
	float s = 0.0;
	float v = max_val;
	
	if (delta > 0.0001) {
		s = delta / max_val;
		
		if (abs(r - max_val) < 0.0001)      h = (g - b) / delta;
		else if (abs(g - max_val) < 0.0001) h = 2.0 + (b - r) / delta;
		else                                h = 4.0 + (r - g) / delta;
		
		h *= 60.0;
		if (h < 0.0) h += 360.0;
	}
	
	return vec3(h, s, v);
}

// Convert HSV color to RGB color space
// Input: vec3 with h in [0, 360], s and v in [0, 1]
// Output: vec3 with components in range [0, 1]
vec3 hsv2rgb(vec3 hsv) {
	float h = hsv.x;
	float s = hsv.y;
	float v = hsv.z;
	
	float c = v * s;
	float x = c * (1.0 - abs(mod(h / 60.0, 2.0) - 1.0));
	float m = v - c;
	
	vec3 rgb;
	
	if (h < 60.0)       rgb = vec3(c, x, 0.0);
	else if (h < 120.0) rgb = vec3(x, c, 0.0);
	else if (h < 180.0) rgb = vec3(0.0, c, x);
	else if (h < 240.0) rgb = vec3(0.0, x, c);
	else if (h < 300.0) rgb = vec3(x, 0.0, c);
	else                rgb = vec3(c, 0.0, x);
	
	rgb += m;
	return rgb;
}


// Function to rotate a vector using a quaternion
vec3 rotate_with_quaternion(vec3 v, vec4 q) {
    vec3 t = 2.0 * cross(q.xyz, v);
    return v + q.w * t + cross(q.xyz, t);
}


void fragment() {
    vec4 colour = texture(TEXTURE, UV);
    colour.a *= texture(mask_texture, UV).a;
    COLOR = colour;
	
	// Map UVs to normalized coordinates (-1, 1)
    float px = 2.0 * (UV.x - 0.5);
    float py = 2.0 * (UV.y - 0.5);

    if (px * px + py * py > 1.0) {
        COLOR.a = 0.0; // Outside of sphere
    } else {
        // Map to a 3D unit sphere
        float pz = sqrt(max(0.0, 1.0 - px * px - py * py));
        vec3 sphere_pos = vec3(px, py, pz);

        // Apply quaternion rotation
        sphere_pos = rotate_with_quaternion(sphere_pos, quaternion);

        // Convert rotated position to UV coordinates
        float theta = atan(sphere_pos.z, sphere_pos.x);
        float phi = acos(clamp(sphere_pos.y, -1.0, 1.0));

        // Map spherical coordinates to UV space
        vec2 spherical_uv = vec2(0.5 + theta / (2.0 * PI), phi / PI);

        // Sample texture using spherical coordinates
        COLOR = texture(TEXTURE, spherical_uv);
		
		
    }
	
	vec3 hsv_color = rgb2hsv(COLOR.rgb);
	hsv_color.x = mod(hsv_color.x + (float((numeroDeBola) * 45 % 360)), 360.0);
	COLOR.rgb = hsv2rgb(hsv_color);
}