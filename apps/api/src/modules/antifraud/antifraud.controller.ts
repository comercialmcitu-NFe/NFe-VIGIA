import { Controller, Get } from '@nestjs/common';

@Controller('antifraud')
export class AntifraudController {
  @Get('workflow')
  workflow() {
    return { steps: ['CHAMADO', 'OS', 'APROVACAO'] };
  }
}
