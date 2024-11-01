## zcompress - a simple data compression library in Zig

### Project Overview

- **`src/rle.zig`**: Contains functions for RLE compression and decompression, along with some unit tests.
- **`src/main.zig`**: Entry point for the project.
- **`build.zig`**: Build configuration script for the main executable and test cases.

### Usage

1. **Clone the repository**:
    ```bash
    git clone git@github.com:jhenrique04/zcompress.git
    cd zcompress
    ```

2. **Run the main program**:
    ```bash
    zig build run
    ```

3. **Run the tests**:
    ```bash
    zig build test
    ```

### Code Details

#### Run-Length Encoding (RLE)

- **`runLengthEncode`**: Compresses a sequence by replacing repeated characters with the character followed by its count.
- **`runLengthDecode`**: Decompresses an RLE-compressed sequence back to the original form.

### Next Steps

Planned compression algorithms include:
- **Huffman**: Frequency-based encoding.
- **LZ77 and LZ78**: Dictionary-based compression algorithms for patterned data.

This README serves as the initial documentation and will be updated as more features are added.
