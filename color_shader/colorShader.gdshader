shader_type canvas_item;

uniform  vec4 color : source_color;
uniform  float mix_amount : hint_range(0.0, 1.0, 0.1) = 0.5;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);

	float final_mix = mix_amount * sin(TIME);
	//security pr pas inverser les couleurs
	if (final_mix > 0.0)
		COLOR = mix(texture_color, color, final_mix);
	else
		COLOR = texture_color;


}

