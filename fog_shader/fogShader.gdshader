shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec4 color : source_color;
uniform float mix_amount : hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float speed : hint_range(0.0, 2.0, 0.1) = 0.3;
void fragment() {
	//warp = valeur aleatoires issues du bruit.
	vec2 warp = texture(noise, UV * 0.5 + TIME * 0.05).rg;
	// on requilibre car sinon warp > 0 et < 1 -> tjr dans le meme sens.
	warp -= 0.5;
	// on reduit lamplitude max a 0.15 (0.5 * 0.3) pr atténuer l'effet.
	warp *= 0.3;

	//on lit le noise avec decalage du wrap//vec4 texture_color = mix(texture(TEXTURE, UV), color, noise_color.b); + decalage temporaire + speed
	vec4 noise_color = texture(noise, UV + warp  + vec2(sin(TIME * 0.3), cos(TIME * 0.4)) * speed);
	vec4 texture_color = texture(TEXTURE, UV);

	COLOR = mix(noise_color, texture_color, mix_amount);
}

