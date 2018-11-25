
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
