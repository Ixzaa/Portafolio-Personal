"""
===================================================================
PROYECTO: Análisis Comparativo de Modelos de Minería de Datos
ARCHIVO: analisis_modelos_ml.py
TECNOLOGÍAS: Python, Pandas, Scikit-Learn, Matplotlib, Seaborn
===================================================================
"""

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    roc_auc_score, confusion_matrix, classification_report
)

def main():
    print("=" * 60)
    print(" INICIANDO ANÁLISIS COMPARATIVO DE MINERÍA DE DATOS")
    print("=" * 60)

    # 1. Carga del conjunto de datos o generación sintética controlada
    np.random.seed(42)
    n_samples = 2500

    edad = np.random.randint(18, 75, n_samples)
    ingresos = np.random.normal(3500, 1200, n_samples)
    score_crediticio = np.random.randint(350, 850, n_samples)
    antiguedad_laboral = np.random.randint(0, 30, n_samples)

    # Variable objetivo (1: Aprobado / Bajo Riesgo, 0: Rechazado)
    log_odds = (
        (score_crediticio - 580) * 0.02 +
        (ingresos - 2500) * 0.001 +
        (antiguedad_laboral * 0.08) -
        (edad < 25) * 0.4
    )
    probabilidad = 1 / (1 + np.exp(-log_odds))
    target = (probabilidad > 0.5).astype(int)

    df = pd.DataFrame({
        'Edad': edad,
        'Ingresos': ingresos,
        'ScoreCrediticio': score_crediticio,
        'AntiguedadLaboral': antiguedad_laboral,
        'Aprobado': target
    })

    print(f"✓ Dataset cargado exitosamente: {df.shape[0]} registros, {df.shape[1]} columnas.")

    # 2. Partición Train / Test y Escalado
    X = df.drop('Aprobado', axis=1)
    y = df['Aprobado']

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )

    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # 3. Modelos a Comparar
    modelos = {
        "Random Forest": RandomForestClassifier(n_estimators=100, max_depth=8, random_state=42),
        "Support Vector Machine (SVM)": SVC(probability=True, kernel='rbf', random_state=42),
        "Regresión Logística": LogisticRegression(random_state=42),
        "Árbol de Decisión": DecisionTreeClassifier(max_depth=5, random_state=42)
    }

    resultados = []

    print("\n--- EVALUACIÓN DE DESEMPEÑO POR MODELO ---")
    for nombre, clf in modelos.items():
        # Entrenamiento
        clf.fit(X_train_scaled, y_train)
        
        # Predicción
        y_pred = clf.predict(X_test_scaled)
        y_proba = clf.predict_proba(X_test_scaled)[:, 1]

        acc = accuracy_score(y_test, y_pred)
        prec = precision_score(y_test, y_pred)
        rec = recall_score(y_test, y_pred)
        f1 = f1_score(y_test, y_pred)
        auc = roc_auc_score(y_test, y_proba)

        resultados.append({
            "Modelo": nombre,
            "Accuracy": f"{acc:.4f}",
            "Precision": f"{prec:.4f}",
            "Recall": f"{rec:.4f}",
            "F1-Score": f"{f1:.4f}",
            "ROC-AUC": f"{auc:.4f}"
        })

        print(f"\n[{nombre}]")
        print(f"Accuracy: {acc:.2%} | F1-Score: {f1:.4f} | ROC-AUC: {auc:.4f}")
        print("Matriz de Confusión:")
        print(confusion_matrix(y_test, y_pred))

    df_res = pd.DataFrame(resultados)
    print("\n" + "=" * 60)
    print(" TABLA COMPARATIVA FINAL")
    print("=" * 60)
    print(df_res.to_string(index=False))

if __name__ == "__main__":
    main()
