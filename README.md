# Steganography with Bit-Level Embedding and BCD Encoding

This project demonstrates a steganography technique for hiding an entire image inside another image using bit-level manipulation and a clever encoding method to manage size detection.

##  Project Overview

The main idea is to hide a secret image (`IUT.jpg`) inside a cover image (`Cover_Image.png`) by replacing the least significant bits (LSBs) of the cover image with the bits of the secret image. Then, the PSNR (Peak Signal-to-Noise Ratio) between the original and stego images is calculated to evaluate the visual distortion.

## Idea & Implementation

### ➤ Hiding Phase:
- The secret image is read as binary data.
- Its bits are distributed and embedded into the **first bit plane** of the cover image.
- A nested loop is used:
  - Outer loop over pixels of the secret image.
  - Inner loop over bits of each pixel.
- These bits are written into the LSBs of the cover image.

### ➤ Size Handling Problem:
- The challenge was detecting **how many bits to read back** during extraction.

### Our Solution (BCD-based):
- We encoded the file size in Binary-Coded Decimal (BCD).
- First 4 bits: Number of digits in the size (e.g., `32198` → 5 digits → `0101`).
- Next 4×n bits: Each digit of the size encoded in 4 bits (e.g., `3 → 0011`, `2 → 0010`, ...).
- This allows accurate reconstruction of file size during decoding, making the method **adaptable to different image sizes**.

##  Evaluation

- PSNR between `Cover_Image.png` and `Stego_Image.png`: **59.4512**  
- PSNR between original and extracted hidden image: **Inf**

![Cover_Image](https://github.com/user-attachments/assets/58147dbe-b582-4626-a5c5-e6879018143f)
- Original cover image
![stego_image](https://github.com/user-attachments/assets/2e02ddcf-015e-48c2-a3e2-60d45ead9d01)
- Stego image
![extracted_image](https://github.com/user-attachments/assets/a62a9481-a0cf-4a9b-8729-4be42acc76cb)
- Extracted hidden image
