<template>
    <div class="bg-full p-6">
        <section>
            <p class="title is-3 has-text-weight-semibold">
                <b-icon icon="application-cog-outline" size="is-large" type="is-success">
                </b-icon>
                Configurar
            </p>
            <datos-configuracion @registrado="onRegistrado" :datos="datosLocal"></datos-configuracion>
            <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>

        </section>
    </div>
</template>
<script>
import DatosConfiguracion from './DatosConfiguracion.vue'
import HttpService from '../../Servicios/HttpService'

export default ({
    name: "Configurar",
    components: { DatosConfiguracion },

    data: () => ({
        cargando: false,
        datosLocal: {
            nombre: "",
            telefono: "",
            numeroMesas: 1,
        },
    }),

    mounted() {
        this.obtenerInformacion()

    },

    methods: {
        onRegistrado(datos) {
            this.cargando = true
            this.datosLocal = datos

            HttpService.registrar(this.datosLocal, "registrar_datos_local.php")
                .then(registrado => {
                    if (registrado) {
                        this.$buefy.toast.open({
                            message: 'Información actualizada. Recarga la página para ver los cambios',
                            type: 'is-success'
                        })
                        this.obtenerInformacion()
                    }
                })
        },
        obtenerInformacion() {
            this.cargando = true
            HttpService.obtener("obtener_datos_local.php")
                .then(resultado => {
                    this.datosLocal = resultado
                    this.datosLocal.numeroMesas = parseInt(this.datosLocal.numeroMesas)
                    this.cargando = false

                })
        }
    }
})
</script>
<style>
.is-bold {
    font-weight: 700;
}

.bg-full {
    background-color: #f0efef;
    border-radius: 12px;
    min-height: 100dvh;
    padding: 20px;
    margin-top: 10px;
}
</style>