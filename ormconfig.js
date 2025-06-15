import 'reflect-metadata';
import { DataSource } from 'typeorm';
import { config } from 'dotenv';

// Load environment variables from .env file at the project root
config(); // Ensure correct path to .env

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: 'localhost',
  port: 52674,
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  synchronize: false,
  logging: true,
  entities: ['src/**/*.entity{.ts,.js}'],
  migrations: ['migrations/**/*.{ts,js}'],
  subscribers: [],
});

// Initialize the data source for the CLI.
AppDataSource.initialize()
  .then(() => {
    console.log('TypeORM Data Source has been initialized for CLI.');
  })
  .catch((err) => {
    console.error(
      'Error during TypeORM Data Source initialization for CLI',
      err,
    );
  });
