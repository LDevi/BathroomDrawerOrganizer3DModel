// Définition des variables
frontZoneDepth = 260; // profondeur de la zone avant (mm)
backZoneDepth = 170; // profondeur de la zone arrière (mm)
totalDepth = frontZoneDepth + backZoneDepth; // profondeur totale (mm)
backZoneStart = totalDepth - 167; // position de la zone arrière (mm)
totalWidth = 285;        // largeur totale (mm)
totalHeight = 45; // hauteur totale (mm)
frontZoneWidth = 274; // largeur de la zone avant (mm)
// hauteur totale (mm)
hasBottom = true;        // avec un fond ou non
bottomThickness = 3;     // épaisseur du fond (mm)
borderThickness = 3;     // épaisseur des bords (mm)
//Variables pour les compartiments
headbandCompartimentSize = 150; // taille (diametre) du compartiment pour le bandeau (mm)
frontNotchWidth = (totalWidth - frontZoneWidth) / 2;//largeur des encoches de la zone reserré à l'avant
frontNotchHeight = 29; // hauteur des encoches de la zone reserré à l'avant
module drawQuadrilateralFrame(width, depth, height, useBottom) {difference() {cube([width, depth, height]);
    translate([borderThickness, borderThickness, useBottom ? bottomThickness : 0]) {cube([width - 2 * borderThickness,
            depth - 2 * borderThickness, height]);}}}


module drawCylindricFrame(diameter, borderThickness, borderHeight) {difference() {cylinder(h = borderHeight, d =
diameter);
    cylinder(h = borderHeight, d = diameter - borderThickness);}}

module drawHeadbandFrame(diameter, borderThickness, borderHeight) {difference() {cylinder(h = borderHeight, d = diameter
);
    cylinder(h = borderHeight, d = diameter - borderThickness);
    translate([- diameter / 2, - diameter / 2, 0]) {cube([diameter / 2, diameter / 2, borderHeight], center = false);}}

}

module horizontalSeparator(size) {cube([size, borderThickness, totalHeight]);}

module verticalSeparator(size) {cube([borderThickness, size, totalHeight]);}

module drawFrontFrame() {

    //Main front frame
    difference() {drawQuadrilateralFrame(totalWidth, frontZoneDepth, totalHeight, hasBottom);

        //Front notchs
        translate([totalWidth - frontNotchWidth, 0, 0]) {drawQuadrilateralFrame(frontNotchWidth, frontNotchHeight,
        totalHeight, hasBottom);}
        drawQuadrilateralFrame(frontNotchWidth, frontNotchHeight, totalHeight, hasBottom);}

    //Front notchs separators
    translate([frontNotchWidth, 0, 0]) {verticalSeparator(frontNotchHeight + borderThickness);}
    translate([totalWidth - frontNotchWidth - borderThickness, 0, 0]) {verticalSeparator(frontNotchHeight +
        borderThickness);}
    translate([0, frontNotchHeight, 0]) {horizontalSeparator(frontNotchWidth);}
    translate([totalWidth - frontNotchWidth - borderThickness, frontNotchHeight, 0]) {horizontalSeparator(
    frontNotchWidth);}


    // headband
    translate([totalWidth / 2, headbandCompartimentSize / 2, 0]) {drawHeadbandFrame(headbandCompartimentSize,
    borderThickness, totalHeight);}

    translate([0, 197, 0]) {horizontalSeparator(70);}
    translate([67, 180, 0]) {horizontalSeparator(216);}
    translate([215, 90, 0]) {horizontalSeparator(70);}
    translate([175, 140, 0]) {verticalSeparator(120);}
    translate([67, 0, 0]) {verticalSeparator(frontZoneDepth);}}

module drawBackFrame() {//main Back frame
    translate([0, backZoneStart, 0]) {drawQuadrilateralFrame(totalWidth, totalDepth - backZoneStart, totalHeight,
    hasBottom);
        translate([70, 0, 0]) {verticalSeparator(totalDepth - backZoneStart);}
        translate([140, 0, 0]) {verticalSeparator(totalDepth - backZoneStart);}}


}

drawFrontFrame();
drawBackFrame();
