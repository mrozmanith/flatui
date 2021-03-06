// Copyright 2015 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

varying mediump vec4 vTexCoord;
uniform mediump vec4 clipping;
uniform sampler2D texture_unit_0;
uniform lowp vec4 color;
void main()
{
  lowp vec4 texture_color = texture2D(texture_unit_0, vTexCoord.xy);

  // Discard the fragment if it's out of a clipping rect.
  mediump vec2 pos = vTexCoord.zw;
  if (any(lessThan(pos.xy, clipping.xy)) ||
      any(greaterThan(pos.xy, clipping.zw))) {
    discard;
  }

  // Font texture is a 1 channel luminance texture.
  // Copying luminance value to alphachannel for blending.
  texture_color = vec4(color.rgb, color.a * texture_color.r);
  gl_FragColor = texture_color;
}
