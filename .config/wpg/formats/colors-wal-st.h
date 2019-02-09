const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0e0f10", /* black   */
  [1] = "#374753", /* red     */
  [2] = "#827CA7", /* green   */
  [3] = "#75889C", /* yellow  */
  [4] = "#4C5D6D", /* blue    */
  [5] = "#9EACC0", /* magenta */
  [6] = "#63748A", /* cyan    */
  [7] = "#e4e9ef", /* white   */

  /* 8 bright colors */
  [8]  = "#202325",  /* black   */
  [9]  = "#3e5d74",  /* red     */
  [10] = "#9b8eeb", /* green   */
  [11] = "#86b0dc", /* yellow  */
  [12] = "#567999", /* blue    */
  [13] = "#b6dbff", /* magenta */
  [14] = "#7194c2", /* cyan    */
  [15] = "#f8feff", /* white   */

  /* special colors */
  [256] = "#0e0f10", /* background */
  [257] = "#f8feff", /* foreground */
  [258] = "#f8feff",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
