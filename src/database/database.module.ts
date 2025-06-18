import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { config } from 'dotenv';

config();

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => ({
        type: 'postgres',
        ssl: true,
        url: config.get<string>('DATABASE_URL'),
        entities: ['../**/*.entity.js'],
      }),
    }),
  ],
})
export class DatabaseModule {}
