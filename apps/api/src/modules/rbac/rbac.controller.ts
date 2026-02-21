import { Controller, Get } from '@nestjs/common';

@Controller('rbac')
export class RbacController {
  @Get('matrix')
  matrix() {
    return { module: 'rbac', roles: ['ADMIN', 'GESTOR', 'OPERADOR', 'APROVADOR'] };
  }
}
