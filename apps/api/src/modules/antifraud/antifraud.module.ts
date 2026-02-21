import { Module } from '@nestjs/common';
import { AntifraudController } from './antifraud.controller';

@Module({
  controllers: [AntifraudController]
})
export class AntifraudModule {}
