<template>
  <div class="bg-full p-6">
    <section>
      <br />
      <nav class="level">
        <div class="level-left">
          <div class="level-item">
            <p class="title is-3 has-text-weight-semibold">
              <b-icon icon="cash-register" size="is-large" type="is-success"> </b-icon>
              Reporte de ventas
            </p>

          </div>
        </div>

        <div class="level-right">
          <p class="level-item">
            <span class="has-background-danger  is-pulled-right has-text-white"
              style="font-size:1.5em; padding: 10px; border-radius: 15px;">
              Total ventas: ${{ totalVentas }}
            </span>
          </p>
        </div>
      </nav>
      <div class="box">
        <p class="title is-4 has-text-weight-light has-text-grey">
          Totales de ventas por usuario
        </p>
        <b-field grouped group-multiline>
          <div class="control" v-for="usuario in ventasPorUsuario" :key="usuario.nombre">
            <b-taglist attached>
              <b-tag size="is-large">{{ usuario.nombre }}</b-tag>
              <b-tag size="is-large" type="is-info">${{ usuario.total }}</b-tag>
            </b-taglist>
          </div>
        </b-field>
      </div>

      <b-table class="minimal-table mt-5 p-5" :data="ventas" :paginated="isPaginated" :per-page="perPage"
        :bordered="true" :narrowed="true" :current-page.sync="currentPage" :pagination-simple="isPaginationSimple"
        :pagination-position="paginationPosition" :default-sort-direction="defaultSortDirection"
        :pagination-rounded="isPaginationRounded" :sort-icon="sortIcon" :sort-icon-size="sortIconSize"
        aria-next-label="Next page" aria-previous-label="Previous page" aria-page-label="Page"
        aria-current-label="Current page">
        <b-table-column field="id" label="#" searchable sortable v-slot="props">
          {{ props.row.id }}
        </b-table-column>

        <b-table-column field="idMesa" label="Mesa" searchable sortable v-slot="props">
          Mesa # {{ props.row.idMesa }}
        </b-table-column>

        <b-table-column field="fecha" label="Fecha" searchable sortable v-slot="props">
          {{ props.row.fecha }}
        </b-table-column>

        <b-table-column field="atendio" label="Atendió" searchable sortable v-slot="props">
          {{ props.row.atendio }}
        </b-table-column>

        <b-table-column field="cliente" label="Cliente" searchable sortable v-slot="props">
          {{ props.row.cliente }}
        </b-table-column>

        <b-table-column field="pagado" label="Pago" v-slot="props">
          ${{ props.row.pagado }}
        </b-table-column>

        <b-table-column field="cambio" label="Cambio" sortable v-slot="props">
          ${{ props.row.pagado - props.row.total }}
        </b-table-column>

        <b-table-column field="total" label="Total" sortable v-slot="props">
          <strong>${{ props.row.total }}</strong>
        </b-table-column>

        <b-table-column field="insumos" label="Insumos" v-slot="props">
          <b-table :data="props.row.insumos" :narrowed="true" class="is-size-7">
            <b-table-column field="codigo" label="Código" v-slot="props">
              {{ props.row.codigo }}
            </b-table-column>
            <b-table-column field="nombre" label="Nombre" v-slot="props">
              {{ props.row.nombre }}
            </b-table-column>
            <b-table-column field="cantidad" label="Cantidad" v-slot="props">
              {{ props.row.cantidad }} X ${{ props.row.precio }}
            </b-table-column>
            <b-table-column field="subtotal" label="Subtotal" v-slot="props">
              ${{ props.row.cantidad * props.row.precio }}
            </b-table-column>
          </b-table>
        </b-table-column>

        <b-table-column field="acciones" label="" v-slot="props">
          <div class="field is-grouped">
            <b-button type="is-info" class="mb-1" @click="imprimirComprobante(props.row)">
              <b-icon icon="download"></b-icon>
            </b-button>
          </div>
        </b-table-column>
      </b-table>
      <ticket @impreso="onImpreso" :venta="this.ventaSeleccionada" :insumos="insumosSeleccionados" :datosLocal="datos"
        :logo="logo" v-if="mostrarTicket"></ticket>
      <b-loading :is-full-page="true" v-model="cargando" :can-cancel="false"></b-loading>
    </section>
    <div class="is-pulled-right">
      <p class="control">
        <b-select v-model="perPage">
          <option value="5">5 por página</option>
          <option value="10">10 por página</option>
          <option value="15">15 por página</option>
          <option value="20">20 por página</option>
        </b-select>
      </p>
    </div>
    <div class="field is-grouped">
      <p class="control">
        <b-button class="mb-1" @click="recargar">
          <b-icon icon="refresh"></b-icon>
        </b-button>
      </p>
      <p class="control">
        <b-button type="is-success" icon-left="filter-variant" @click="filtrar = !filtrar">Filtrar</b-button>
      </p>
    </div>
    <div class="box" v-if="filtrar">
      <b-field grouped group-multiline>
        <b-field label="Selecciona un periodo de tiempo" expanded>
          <b-datepicker placeholder="Click para seleccionar..." v-model="fechasSeleccionadas" @input="buscarEnFecha"
            icon="calendar-today" range>
          </b-datepicker>
        </b-field>

        <b-field label="Ventas por usuario" expanded>
          <b-select v-model="usuarioSeleccionado" @change.native="buscarEnFecha">
            <option value="" selected disabled>Selecciona</option>
            <option v-for="usuario in usuarios" :key="usuario.id" :value="usuario.id">
              {{ usuario.nombre }}
            </option>
          </b-select>
        </b-field>
      </b-field>
    </div>

  </div>
</template>
<script>
import HttpService from "../../Servicios/HttpService";
import Utiles from "../../Servicios/Utiles";
import Ticket from "./Ticket.vue";

export default {
  name: "ReporteVentas",
  components: { Ticket },

  data: () => ({
    usuarios: [],
    filtrar: false,
    datos: {},
    ventaSeleccionada: {},
    insumosSeleccionados: [],
    fechasSeleccionadas: [],
    usuarioSeleccionado: "",
    filtros: {},
    cargando: false,
    ventas: [],
    ventasPorUsuario: [],
    totalVentas: 0,
    mostrarTicket: false,
    isPaginated: true,
    isPaginationSimple: false,
    isPaginationRounded: true,
    paginationPosition: "bottom",
    defaultSortDirection: "asc",
    sortIcon: "arrow-up",
    sortIconSize: "is-small",
    currentPage: 1,
    perPage: 20,
    logo: null,
  }),

  mounted() {
    this.obtenerVentas();
    this.obtenerDatos();
  },

  methods: {
    recargar() {
      (this.fechasSeleccionadas = []), (this.filtros = {});
      this.obtenerVentas();
    },

    onImpreso(resultado) {
      this.mostrarTicket = resultado;
    },

    imprimirComprobante(venta) {
      this.ventaSeleccionada = {
        atendio: venta.atendio,
        cliente: venta.cliente,
        fecha: venta.fecha,
        pagado: venta.pagado,
        total: venta.total,
      };

      this.insumosSeleccionados = venta.insumos;
      this.mostrarTicket = true;
    },

    buscarEnFecha() {
      this.filtros = {
        inicio: this.fechasSeleccionadas[0].toISOString().substring(0, 10),
        fin: this.fechasSeleccionadas[1].toISOString().substring(0, 10),
        idUsuario: this.usuarioSeleccionado,
      };
      this.obtenerVentas();
    },

    obtenerVentas() {
      this.cargando = true;
      HttpService.obtenerConDatos(this.filtros, "obtener_ventas.php").then(
        (resultado) => {
          this.ventas = resultado.ventas;
          this.ventasPorUsuario = resultado.ventasPorUsuario;
          this.usuarios = resultado.usuarios;

          let total = 0;
          this.ventas.forEach((venta) => {
            total = parseFloat(total) + parseFloat(venta.total);
          });

          this.totalVentas = total;
          this.cargando = false;
        }
      );
    },

    obtenerDatos() {
      HttpService.obtener("obtener_datos_local.php").then((resultado) => {
        this.datos = resultado;
        this.logo = Utiles.generarUrlImagen(this.datos.logo);
      });
    },
  },
};
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

.table td,
.table th {
  padding: 0.5rem 1rem;
  vertical-align: middle;
}

.minimal-table {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
  overflow: hidden;
  font-size: 14px;
}

.minimal-table th {
  background-color: #e6e6e6;
  font-weight: 600;
  color: #4a4a4a;
  border: none;
}

.minimal-table td {
  border: none;
  padding: 0.75rem 1rem;
}

.minimal-table .b-table .table.is-fullwidth {
  border-collapse: separate;
  border-spacing: 0;
}

.minimal-table .b-table .table.is-fullwidth tbody tr:hover {
  background-color: #f5f5f5;
  transition: background-color 0.3s;
}

.field.is-grouped .control {
  margin-right: 4px;
}
</style>