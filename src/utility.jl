
first_3_of_6(v::SVector{6,T}) where {T} = SVector{3,T}(v[1], v[2], v[3])
last_3_of_6(v::SVector{6,T}) where {T} = SVector{3,T}(v[4], v[5], v[6])
