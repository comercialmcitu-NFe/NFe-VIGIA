import { Controller, Get } from '@nestjs/common';
import { supabase } from '../../supabase.client';

@Controller('api/condominiums')
export class CondominiumsController {
  @Get('health')
  health() {
    return { module: 'condominiums', ok: true };
  }

  @Get('db-test')
  async dbTest() {
    const { data, error } = await supabase
      .from('condominiums')
      .select('*')
      .limit(5);

    if (error) {
      return { ok: false, error: error.message };
    }

    return { ok: true, data };
  }
}