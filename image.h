// -*- C++ -*-

struct tile_t {

    // interface
public:
    constexpr int size() const {
        // compute the size of the tile
        return lines*samples*bands;
    };

    // implementation details
public:
    int bands, lines, samples;

};

struct image_t {

    // implementation details
public:
    // my shape
    tile_t shape;
    // my data
    double * data;

};

// end of file
