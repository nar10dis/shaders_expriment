shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec4 color_picked : source_color;
uniform float amount : hint_range(0.0, 0.5, 0.01);
uniform float melt_range : hint_range(0.0, 0.2, 0.001) = 0.1;
float melt_factor(vec4 color, float range, sampler2D text, vec2 coord)
{	
	float closest = range;
	vec4 nearest_color_x;
	vec4 nearest_color_y;
	for (float i = 0.0; i < range; i += 0.05)
	{
	    if (texture(text, coord + vec2(i, 0.0)) == color ||
	        texture(text, coord + vec2(-i, 0.0)) == color ||
	        texture(text, coord + vec2(0.0, i)) == color ||
	        texture(text, coord + vec2(0.0, -i)) == color)
	    {
	        closest = i;
	        break; // on arrête dès qu'on trouve, i = la distance
	    }
	}
	return 1.0 - (closest / range); // 1.0 = pile sur la couleur, 0.0 = hors zone
}

void fragment() {	vec2 noise_uv = UV + vec2(sin(TIME * 0.7), cos(TIME * 1.3));
	vec4 noise_color = texture(noise, noise_uv);
	
	vec4 texture_color = texture(TEXTURE, UV);
	
	float factor = melt_factor(color_picked, melt_range, TEXTURE, UV);
	texture_color = texture(TEXTURE, UV + vec2(noise_color.r - 0.5, noise_color.g - 0.5) * amount * factor);
	COLOR = texture_color;
}


