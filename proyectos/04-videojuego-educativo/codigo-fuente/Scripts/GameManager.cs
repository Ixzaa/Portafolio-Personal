using UnityEngine;
using UnityEngine.Events;

namespace EducationalGame.Core
{
    public class GameManager : MonoBehaviour
    {
        public static GameManager Instance { get; private set; }

        [Header("Estado de Juego")]
        [SerializeField] private int currentScore = 0;
        [SerializeField] private int playerLives = 3;
        [SerializeField] private int totalGemsRequired = 4;
        private int collectedGems = 0;

        [Header("Eventos Unity")]
        public UnityEvent<int> onScoreChanged;
        public UnityEvent<int> onLivesChanged;
        public UnityEvent onLevelCompleted;
        public UnityEvent onGameOver;

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }
            Instance = this;
        }

        public void AddScore(int points)
        {
            currentScore += points;
            onScoreChanged?.Invoke(currentScore);
        }

        public void TakeDamage(int damage = 1)
        {
            playerLives -= damage;
            onLivesChanged?.Invoke(playerLives);

            if (playerLives <= 0)
            {
                onGameOver?.Invoke();
                Debug.Log("Game Over: Se acabaron las vidas.");
            }
        }

        public void RegisterGemCollected()
        {
            collectedGems++;
            if (collectedGems >= totalGemsRequired)
            {
                onLevelCompleted?.Invoke();
                Debug.Log("¡Nivel superado! Portal activado.");
            }
        }

        public int Score => currentScore;
        public int Lives => playerLives;
    }
}
