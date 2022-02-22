{{/*
Expand the name of the chart.
*/}}
{{- define "activemq.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "activemq.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "activemq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "activemq.labels" -}}
helm.sh/chart: {{ include "activemq.chart" . }}
{{ include "activemq.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "activemq.selectorLabels" -}}
app.kubernetes.io/name: {{ include "activemq.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "activemq.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "activemq.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create activemq path.
if .Values.active.path is empty, default value "/opt/activemq/data".
*/}}
{{- define "activemq.fullpath" -}}
{{- if .Values.activemq.path -}}
{{- .Values.activemq.path | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" "/opt/activemq/data" -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the persistentVolumeClaim.
*/}}
{{- define "activemq.pvcName" -}}
{{- default .Chart.Name .Values.persistentVolumeClaim.name | trunc 63 | trimSuffix "-" }}
{{- end }}
