{{- define "rabbitmq-single-node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "rabbitmq-single-node.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" (include "rabbitmq-single-node.name" .) .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}