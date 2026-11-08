using UnityEngine;
using System;
using System.Collections.Generic;

namespace EducationalGame.Quiz
{
    [System.Serializable]
    public class PreguntaEducativa
    {
        public string enunciado;
        public List<string> opciones;
        public int indiceRespuestaCorrecta;
        public int puntosRecompensa = 100;
    }

    public class EducationalQuizManager : MonoBehaviour
    {
        public static EducationalQuizManager Instance { get; private set; }

        [SerializeField] private GameObject panelQuizUI;
        private Action<bool> onRespuestaFinalizada;

        private void Awake()
        {
            Instance = this;
            if (panelQuizUI != null) panelQuizUI.SetActive(false);
        }

        public void MostrarPregunta(PreguntaEducativa pregunta, Action<bool> callback)
        {
            onRespuestaFinalizada = callback;
            if (panelQuizUI != null) panelQuizUI.SetActive(true);
            
            // Aquí se enlaza con TextMeshPro en la UI de Unity
            Debug.Log($"Pregunta Activada: {pregunta.enunciado}");
        }

        public void Responder(int indiceOpcionSeleccionada, PreguntaEducativa pregunta)
        {
            bool esCorrecta = (indiceOpcionSeleccionada == pregunta.indiceRespuestaCorrecta);
            
            if (panelQuizUI != null) panelQuizUI.SetActive(false);
            onRespuestaFinalizada?.Invoke(esCorrecta);
        }
    }
}
