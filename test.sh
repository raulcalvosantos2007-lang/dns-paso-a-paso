#!/usr/bin/env bash
set -euo pipefail

DOMINIO="raul.test"
IP="192.168.56.10"
INVERSA="56.168.192.in-addr.arpa"
USUARIO="raulcalvosantos2007-lang"
RUTA_ZONAS="/var/lib/bind"

comprobar() {
    local descripcion="$1"
    local esperado="$2"
    local obtenido="$3"
    if [[ "$obtenido" == "$esperado" ]]; then
        echo "[OK] $descripcion"
    else
        echo "[ERROR] $descripcion"
        printf 'Esperado: %s\nObtenido: %s\n' "$esperado" "$obtenido"
        exit 1
    fi
}

named-checkconf -z
named-checkzone "$DOMINIO" "$RUTA_ZONAS/$DOMINIO.dns"
named-checkzone "$INVERSA" "$RUTA_ZONAS/$DOMINIO.rev"
systemctl is-active --quiet named

comprobar "Registro A" "$IP" \
    "$(dig @127.0.0.1 "debian.$DOMINIO" A +short +time=2 +tries=1)"
comprobar "Registro CNAME" "debian.$DOMINIO." \
    "$(dig @127.0.0.1 "web.$DOMINIO" CNAME +short +time=2 +tries=1)"
comprobar "Registro TXT" "\"$USUARIO\"" \
    "$(dig @127.0.0.1 "$DOMINIO" TXT +short +time=2 +tries=1)"
comprobar "Registro PTR" "debian.$DOMINIO." \
    "$(dig @127.0.0.1 -x "$IP" +short +time=2 +tries=1)"

echo "Todas las comprobaciones han terminado correctamente."