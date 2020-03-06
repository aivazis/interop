// -*- C++ -*-

#include "image.h"

extern "C" void show(image_t *);

int main() {
    // make
    tile_t tile {2, 3, 2};
    image_t image { tile, new double[tile.size()] };

    for (auto i = 0; i < tile.size(); ++i) {
        image.data[i] = 2*i;
    }

    // show me
    show(&image);

    // clean up
    delete [] image.data;

    return 0;
}

// end of file
