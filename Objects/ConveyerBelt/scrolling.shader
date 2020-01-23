shader_type canvas_item;

uniform float scroll_speed;

void fragment(){
    vec2 shifteduv = UV;
    shifteduv .x -= TIME * scroll_speed;
    vec4 color = texture(TEXTURE, shifteduv);
    COLOR = color;
}