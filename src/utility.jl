
first_3_of_6(v::SVector{6,T}) where {T} = SVector{3,T}(v[1], v[2], v[3])
last_3_of_6(v::SVector{6,T}) where {T} = SVector{3,T}(v[4], v[5], v[6])

function getTop(a::SMatrix{4,4,T,16}) where {T}
    A = @SMatrix [
    a[1]  a[5]  a[9]  a[13];
    a[2]  a[6]  a[10] a[14];
    a[3]  a[7]  a[11] a[15]
    ]
    return A
end

unPad(a::SVector{4,T}) where {T} = SVector{3,T}(a[1], a[2], a[3])
unPad(a::SMatrix{1,4,T,4}) where {T} = SVector{3,T}(a[1], a[2], a[3])
onePad(a::SVector{3,T}) where {T} = SVector{4,T}(a[1], a[2], a[3], one(T))
zeroPad(a::SVector{3,T}) where {T} = SVector{4,T}(a[1], a[2], a[3], zero(T))

@inline mul_then_un_pad(m::SMatrix{4,4,T1,16}, v::SVector{4,T2}) where {T1,T2} = unPad(m * v)
@inline one_pad_then_mul(m::SMatrix{4,4,T1,16}, v::SVector{3,T2}) where {T1,T2} = m * onePad(v)

function weightPoly(p1::SVector{N,T}, p2::SVector{N,T}, w1::T, w2::T) where {N,T}
  sum_weight = w1 - w2
  c1 = w1 / sum_weight
  c2 = w2 / sum_weight
  return c1 * p2 - c2 * p1
end

triangleCross(v1::SVector{3,T}, v2::SVector{3,T}, v3::SVector{3,T}) where {T} = cross(v2 - v1, v3 - v2)
triangleNormal(v1::SVector{3,T}, v2::SVector{3,T}, v3::SVector{3,T}) where {T} = normalize(triangleCross(v1, v2, v3))
for funName in (:triangleNormal, :triangleCross)
    @eval begin
        function $funName(sv::SVector{3,SVector{3,T}}) where {T}
            return $funName(sv[1], sv[2], sv[3])
        end
        function $funName(sv::NTuple{3,SVector{3,T}}) where {T}
            return $funName(sv[1], sv[2], sv[3])
        end
    end
end
