import express from 'express';
import cors from 'cors';
import 'dotenv/config';

const app = express();

const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Check that the backend is running
app.get('/', (req, res) => {
  res.json({
    name: 'Aussie PartsFinder API',
    status: 'running',
  });
});

// Main parts search endpoint
app.get('/search', async (req, res) => {
  try {
    const query = String(req.query.q || '').trim();
    const vehicleType = String(
      req.query.vehicleType || 'car',
    ).trim();

    const includeNew =
      String(req.query.new || 'true') === 'true';

    const includeUsed =
      String(req.query.used || 'true') === 'true';

    if (!query) {
      return res.status(400).json({
        error: 'Search query is required',
        results: [],
      });
    }

    /*
      Marketplace APIs will be connected here.

      Every result sent to the Flutter app will use:

      {
        title: 'Part name',
        marketplace: 'Marketplace name',
        imageUrl: 'https://...',
        itemUrl: 'https://...',
        condition: 'New or Used',
        location: 'Australia',
        price: 99.95,
        priceText: '$99.95'
      }
    */

    const results = [];

    res.json({
      query,
      vehicleType,
      includeNew,
      includeUsed,
      country: 'AU',
      count: results.length,
      results,
    });
  } catch (error) {
    console.error('Search error:', error);

    res.status(500).json({
      error: 'Unable to search for parts',
      results: [],
    });
  }
});

app.listen(PORT, () => {
  console.log(
    `Aussie PartsFinder API running on port ${PORT}`,
  );
});
