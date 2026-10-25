<?php

namespace App\Controllers\Api;

use App\Models\PlatDuJourModel;
use App\Models\PlatModel;

use function PHPUnit\Framework\containsEqual;
use function PHPUnit\Framework\containsIdentical;

class PlatDuJour extends ApiController
{
    private PlatDuJourModel $plats;

    public function __construct()
    {
        $this->plats = model(PlatDuJourModel::class);
    }

    public function show()
    {
        $res = $this->plats->platDuJour();

        if (!$res->disponible || $res->disponible == "f") {
            return $this->erreur("Le plat : " . $res->nom . " est epuise et ne peut pas etre un plat du jour", 409);
        }

        return $res ? $this->respond($res) : $this->erreur("null", 404);
    }

    public function historique()
    {
        $res = $this->plats->history();
        return $res ? $this->respond($res) : $this->erreur("null", 404);
    }

    public function putPlatDuJour($idplat)
    {
        
        $plat = model(PlatModel::class)->find($idplat);
        if ($plat == null) {
            return $this->response->setStatusCode(404)->setJSON([
                "erreur" => "Le plat n'existe pas"
            ]);
        }

        $this->plats->updatePlatDuJour($idplat);
        return $this->show();
    }
}
