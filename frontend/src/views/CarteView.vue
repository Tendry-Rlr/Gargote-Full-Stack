<script setup>
import { computed, onMounted, ref } from 'vue'
import { api } from '../api'
import PlatList from '../components/PlatList.vue'
import PlatForm from '../components/PlatForm.vue'
import PlatDuJour from '../components/PlatDuJour.vue'

const plats = ref([])
const categories = ref([])
const platSelectionne = ref(null) // plat en cours de modification
const message = ref(null)         // { type: 'succes' | 'erreur', texte }
const platDuJour = ref()
const platsDisponibles = computed(() => plats.value.filter(plat => plat.disponible))

async function charger() {
  try {
    ;[plats.value, categories.value] = await Promise.all([
      api.plats.lister(),
      api.categories.lister(),
    ])
    platDuJour.value = await api.platDuJour.lire()
  } catch (e) {
    message.value = { type: 'erreur', texte: 'Impossible de charger la carte : ' + e.message }
  }
}

async function choisirPlatDuJour(plat) {
  try {
    platDuJour.value = await api.platDuJour.definir(plat.id)
    message.value = {
      type: 'succes',
      texte: `« ${plat.nom} » est maintenant le plat du jour.`,
    }
  } catch (e) {
    message.value = { type: 'erreur', texte: e.message }
  }
}

async function surEnregistrement(plat) {
  message.value = { type: 'succes', texte: `« ${plat.nom} » est enregistré.` }
  platSelectionne.value = null
  await charger()
}

async function supprimer(plat) {
  if (!confirm(`Supprimer « ${plat.nom} » de la carte ?`)) return
  try {
    await api.plats.supprimer(plat.id)
    message.value = { type: 'succes', texte: `« ${plat.nom} » est supprimé.` }
    await charger()
  } catch (e) {
    message.value = { type: 'erreur', texte: e.message }
  }
}


async function basculerDisponibilite(plat) {
  try {
    if (plat.disponible) {
      await api.plats.modifier(plat.id, { "disponible": false });
      message.value = {
        type: 'succes', texte: `« ${plat.nom} » est epuise.`
      }
    }
    else {
      await api.plats.modifier(plat.id, { "disponible": true });
      message.value = {
        type: 'succes', texte: `« ${plat.nom} » est devenu disponible.`
      }
    }
    await charger();

  } catch (e) {
    message.value = { type: 'erreur', texte: e.message }
  }
}

onMounted(charger)
</script>

<template>
  <p v-if="message" class="alerte" :class="`alerte-${message.type}`">{{ message.texte }}</p>

  <div class="grille">
    <div class="colonne-carte">
      <PlatDuJour :plat="platDuJour" :plats-disponibles="platsDisponibles"
        :modifiable="true" @choisir="choisirPlatDuJour" />

      <PlatList :plats="plats" @modifier="platSelectionne = $event" @supprimer="supprimer"
        @basculer="basculerDisponibilite" />
    </div>

    <PlatForm :plat="platSelectionne" :categories="categories" @enregistre="surEnregistrement"
      @annule="platSelectionne = null" />
  </div>
</template>
