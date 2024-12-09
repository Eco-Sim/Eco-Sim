shader_type canvas_item;

// The parent's texture
uniform sampler2D parent_texture;

void fragment() {
    // Sample the parent's texture using the child's UVs
    vec4 parent_color = texture(parent_texture, UV);

    // Clip the pixel if the parent's alpha is transparent
    if (parent_color.a < 0.01) {
        discard;
    }

    // Render the child's texture
    vec4 child_color = texture(TEXTURE, UV);
    COLOR = child_color;
}
