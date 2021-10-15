precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform float seed;

void main() {
    vec2 coord = gl_FragCoord.xy / resolution;

    // Output RGB color in range from 0.0 to 1.0
    vec3 color = vec3(coord.x, coord.y, 0.0);
    color.z += abs(sin(time));

    // 1. Uncomment these lines to draw triangles
    vec2 squareCoord = 20.0 * gl_FragCoord.xy / resolution.y + vec2(time);
    vec2 loc = fract(squareCoord);
    color = vec3(smoothstep(-0.05, 0.05, (5.0*(seed+0.2))*loc.y - (seed+1.0) * loc.x));

    // 2. Uncomment these lines to invert some of the triangles
    vec2 cell = squareCoord - loc;
    if (mod(2.0 * (cell.x + ceil(seed * 5.0)) + cell.y + ceil(seed * 5.0), 5.0) == 1.0) {
         color = 1.0 - color;
    }

    // 3. Uncomment these lines to produce interesting colors
    float c1 = mod(3.0 * cell.x + 2.0 * cell.y, 7.0) / 6.0;
    float c2 = mod(2.0 * cell.x + 3.0 * cell.y, 7.0) / 6.0;
    float c3 = mod(5.0 * cell.x + 7.0 * cell.y, 7.0) / 6.0;
    color = 1.0 - (1.0 - color) * vec3(c1, c2, c3);

    // 4. Uncomment to lighten the colors
    color = sqrt(color);

    gl_FragColor = vec4(color, 1.0);
}
