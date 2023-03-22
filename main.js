function getSectorNumber(centerX, centerY, mouseX, mouseY, sectorCount) {
    let sectorAngle = Math.round(360 / sectorCount)

    return Math.trunc(((360 - (Math.atan2(mouseX - centerX, mouseY - centerY) * (180 / Math.PI) + 180)) / sectorAngle))
}
