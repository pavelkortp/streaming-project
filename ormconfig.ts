'use strict'

import 'reflect-metadata';
import { DataSource } from 'typeorm';
import { config } from 'dotenv';

config();

const AppDataSource = new DataSource({
  type: 'postgres',
  host: 'localhost',
  port: 52674,
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  synchronize: false,
  logging: true,
  entities: ['dist/src/**/*.entity{.ts,.js}'],
  migrations: ['migrations/**/*.{ts,js}'],
  subscribers: [],
});

export default AppDataSource
