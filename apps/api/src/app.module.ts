import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { CondominiumsModule } from './modules/condominiums/condominiums.module';
import { RbacModule } from './modules/rbac/rbac.module';
import { AntifraudModule } from './modules/antifraud/antifraud.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    CondominiumsModule,
    RbacModule,
    AntifraudModule,
  ],
})
export class AppModule {}