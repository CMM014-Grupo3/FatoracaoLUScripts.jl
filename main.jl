using FatoracaoLU

# Tamanho das matrizes de teste
n = 20

# Roda 100 testes, para verificarmos a consistência do nosso código
for t = 1:100
    println("t:",t) # Só para mostrar o progresso

    # Gerando matriz esparsa (inteiros, só que em representação float)
    A = zeros(Float64,n,n)
    for i in 1:n*n
        if (rand() > 0.5)
            A[i] = round(rand()*100)
        end
    end
    for i = 1:n
        if(A[i,i] == 0 )
            A[i,i] = round(rand()*100)
        end
    end

    # Fatorando
    L,U,p,q = lu_mark(A)
    LU = L*U
    Apq = A[p,q]

    # Desiste no primeiro erro
    desiste = false
    for i = 1:n*n
        # Aqui é que testamos quando dá erro
        if( abs(LU[i] - Apq[i]) > 0.1)
            # Agora refaz a fatoração, só que exibindo etapas
            L,U,p,q = lu_mark(A,true)

            # Também mostra todas as matrizes para a gente dar uma olhada
            println("A")
            display(A)
            println("L")
            display(L)
            println("U")
            display(U)
            println("p")
            println(p)
            println("q")
            println(q)
            println("i:",i,"; LU[i]:",LU[i], "; Apq[i]:",Apq[i])
            println("Z:")
            display(L*U)
            println("A[p,q]:")
            display(A[p,q])
            
            desiste = true
            break
        end
    end
    if desiste
        break
    end
end