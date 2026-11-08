using UnityEngine;
using EducationalGame.Core;
using EducationalGame.Quiz;
using EducationalGame.Player;

namespace EducationalGame.Gameplay
{
    [RequireComponent(typeof(CircleCollider2D))]
    public class CollectibleItem : MonoBehaviour
    {
        [SerializeField] private PreguntaEducativa retoEducativo;
        [SerializeField] private AudioClip sonidoRecoleccion;
        private bool recolectado = false;

        private void OnTriggerEnter2D(Collider2D collision)
        {
            if (recolectado) return;

            if (collision.TryGetComponent<PlayerController2D>(out var jugador))
            {
                recolectado = true;
                jugador.SetMovementEnabled(false);

                if (sonidoRecoleccion != null)
                {
                    AudioSource.PlayClipAtPoint(sonidoRecoleccion, transform.position);
                }

                EducationalQuizManager.Instance.MostrarPregunta(retoEducativo, (esCorrecto) =>
                {
                    jugador.SetMovementEnabled(true);

                    if (esCorrecto)
                    {
                        GameManager.Instance.AddScore(retoEducativo.puntosRecompensa);
                        GameManager.Instance.RegisterGemCollected();
                    }
                    else
                    {
                        GameManager.Instance.TakeDamage(1);
                    }

                    Destroy(gameObject);
                });
            }
        }
    }
}
