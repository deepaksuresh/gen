import Flux: param, σ, back!, Tracker
x,y = rand(5), rand(2)
function linear(in,out)
    W1 = param(rand(out,in))
    W2 = param(rand(out,in))
    b = param(rand(out))
    #x-> (W1.*W2)*x .+ b
    result = function (x)
        return (W1.*W2)*x .+ b
    end
    return result
end

linear1 = linear(5, 3)
linear2 = linear(3, 2)

model(x) = linear2(σ.(linear1(x)))

loss(x, y) = sum((model(x) .- y).^2)

l= loss(x,y)

Wxh = randn(5, 10)
Whh = randn(5, 5)
b   = randn(5)

function rnn(h, x)
  h = tanh.(Wxh * x .+ Whh * h .+ b)
  return h, h
end

function inference()
end
