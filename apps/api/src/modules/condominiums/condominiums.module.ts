import { Module } from '@nestjs/common';
import { CondominiumsController } from './condominiums.controller';

@Module({
  controllers: [CondominiumsController]
})
export class CondominiumsModule {}
