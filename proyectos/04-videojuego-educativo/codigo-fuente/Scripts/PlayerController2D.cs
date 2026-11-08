using UnityEngine;

namespace EducationalGame.Player
{
    [RequireComponent(typeof(Rigidbody2D))]
    [RequireComponent(typeof(BoxCollider2D))]
    public class PlayerController2D : MonoBehaviour
    {
        [Header("Parámetros de Movimiento")]
        [SerializeField] private float moveSpeed = 8.0f;
        [SerializeField] private float jumpForce = 12.0f;

        [Header("Verificación de Suelo (Ground Check)")]
        [SerializeField] private Transform groundCheckPoint;
        [SerializeField] private float groundCheckRadius = 0.2f;
        [SerializeField] private LayerMask groundLayer;

        private Rigidbody2D rb;
        private float horizontalInput;
        private bool isGrounded;
        private bool canMove = true;

        private void Awake()
        {
            rb = GetComponent<Rigidbody2D>();
        }

        private void Update()
        {
            if (!canMove)
            {
                rb.velocity = new Vector2(0, rb.velocity.y);
                return;
            }

            // Captura de entradas estándar de Unity (Teclado / Gamepad)
            horizontalInput = Input.GetAxisRaw("Horizontal");

            // Comprobar si el personaje toca el suelo
            isGrounded = Physics2D.OverlapCircle(groundCheckPoint.position, groundCheckRadius, groundLayer);

            // Salto
            if (Input.GetButtonDown("Jump") && isGrounded)
            {
                Jump();
            }
        }

        private void FixedUpdate()
        {
            if (!canMove) return;

            // Movimiento físico lineal
            rb.velocity = new Vector2(horizontalInput * moveSpeed, rb.velocity.y);

            // Voltear sprite según la dirección
            if (horizontalInput > 0) transform.localScale = new Vector3(1, 1, 1);
            else if (horizontalInput < 0) transform.localScale = new Vector3(-1, 1, 1);
        }

        private void Jump()
        {
            rb.velocity = new Vector2(rb.velocity.x, jumpForce);
        }

        public void SetMovementEnabled(bool enabled)
        {
            canMove = enabled;
            if (!enabled) rb.velocity = Vector2.zero;
        }
    }
}
