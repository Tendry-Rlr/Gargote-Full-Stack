<?php

namespace App\Models;

use CodeIgniter\Model;

class PlatDuJourModel extends Model
{
    protected $table         = 'plat_du_jour';
    protected $primaryKey    = 'id_plat_du_jour ';
    protected $returnType    = 'array';
    protected $allowedFields = ['id_plat', 'date_jour'];
    protected array $casts   = ['id_plat_du_jour' => 'int'];


    public function platDuJour()
    {
        return $this->db->table('plat_du_jour pj')
            ->select('pj.id_plat_du_jour, pj.date_jour, p.nom, p.prix, p.disponible')
            ->join('plat p', 'p.id = pj.id_plat')
            ->where('pj.date_jour', 'CURRENT_DATE', false)
            ->get()->getRow();
    }

    public function history(): array
    {
        return $this->db->table('plat_du_jour pj')
            ->select('pj.id_plat_du_jour, pj.date_jour, p.nom, p.prix, p.disponible')
            ->join('plat p', 'p.id = pj.id_plat')
            ->where('pj.date_jour <', 'CURRENT_DATE', false)
            ->orderBy('pj.date_jour', 'desc')
            ->limit(7)
            ->get()
            ->getResultArray();
    }

    public function updatePlatDuJour($idplat)
    {
        $this->db->table('plat_du_jour')
            ->where('date_jour', 'CURRENT_DATE', false)
            ->update([
                'id_plat' => $idplat
            ]);
    }
}


// GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO gargote;
// GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO gargote;