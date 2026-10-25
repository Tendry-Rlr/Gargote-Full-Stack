<script setup>
import { ref } from 'vue'
import { ariary } from '../utils/format'

const props = defineProps({
    plat: { type: Object, required: false },
    platsDisponibles: { type: Array, default: () => [] },
    modifiable: { type: Boolean, default: false },
})

const emit = defineEmits(['choisir'])
const platSelectionne = ref('')

function choisir() {
    const plat = props.platsDisponibles.find(({ id }) => String(id) === platSelectionne.value)
    if (plat) emit('choisir', plat)
}
</script>

<template>
    <section class="plat-du-jour">
        <h3 class="ardoise-titre">Plat du jour</h3>

        <div v-if="props.plat">
            <span :class="[!plat.disponible ? 'plat-epuise' : 'plat-nom']">{{ plat.nom }}</span>
            <span class="plat-description">{{ plat.description }}</span>
            <span v-if="!plat.disponible" class="badge badge-epuise">Épuisé</span>
            <span class="plat-prix">{{ ariary(plat.prix) }}</span>
        </div>

        <p v-else class="vide">Aucun plat du jour.</p>

        <div v-if="props.modifiable" class="plat-du-jour-selection">
            <label for="plat-du-jour">
                Choisir un plat disponible
                <select id="plat-du-jour" v-model="platSelectionne">
                    <option value="">-- Sélectionner --</option>
                    <option v-for="platDisponible in props.platsDisponibles"
                        :key="platDisponible.id" :value="String(platDisponible.id)">
                        {{ platDisponible.nom }} — {{ ariary(platDisponible.prix) }}
                    </option>
                </select>
            </label>
            <button class="bouton" type="button" :disabled="!platSelectionne" @click="choisir">
                Choisir
            </button>
        </div>
        <p v-if="props.modifiable && props.platsDisponibles.length === 0" class="vide">
            Aucun plat disponible.
        </p>
    </section>
</template>