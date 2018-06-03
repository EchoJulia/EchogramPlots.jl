__precompile__()
module EchogramPlots

using Plots
using Measures

export EK500_COLOURS, echogram

const EK500_COLOURS = cgrad([RGB(1, 1, 1),
                             RGB(159/255, 159/255, 159/255),
                             RGB(95/255, 95/255, 95/255),
                             RGB(0, 0, 1),
                             RGB(0, 0, 127/255),
                             RGB(0, 191/255, 0),
                             RGB(0, 127/255, 0),
                             RGB(1, 1, 0),
                             RGB(1, 127/255, 0),
                             RGB(1, 0, 191/255),
                             RGB(1, 0, 0),
                             RGB(166/255, 83/255, 60/255),
                             RGB(120/255, 60/255, 40/255)])

"""
    echogram(a; xlabel="Time / samples", ylabel=nothing,
                  title="Echogram",
                  vmin = nothing,
                  vmax = nothing,
                  leg=true,
                  color=EK500_COLOURS,
                  size=(640,480),
                  colorbar_title = "",
                  range=nothing)

Uses Plots to plot an echogram of a.

range can be a `Number` n, in which case 0 to n is assumed, a `Tuple`
or a `Vector`.

"""
function echogram(a; xlabel="Time / samples", ylabel=nothing,
                  title="Echogram",
                  vmin = nothing,
                  vmax = nothing,
                  leg=true,
                  color=EK500_COLOURS,
                  size=(640,480),
                  colorbar_title = "",
                  range=nothing)

    if ylabel==nothing
        if range == nothing
            ylabel="Range / samples"
        else
            ylabel="Range / m"
        end
    end

    # TODO From Julia 0.7 consider using missing?

    if vmax != nothing
        a[a .> vmax] = vmax
    end

    if vmin != nothing
        a[a .< vmin] = vmin
    end

    y, x = Base.size(a)

    if isa(range, Number)
        top = 0.0
        bottom = range
    elseif isa(range, Tuple)
        top, bottom = range
    elseif isa(range, Vector)
        top = range[1]
        bottom = range[end]
    else
        top = 0.0
        bottom = y
    end

    stepr = 10^floor(log10(bottom-top))

    stepy = y * stepr / (bottom-top)

    yticks = 0:stepy:y
    yticklabels = top:stepr:bottom

    if length(yticks) < 3
        yticks = 0:stepy/5:y
        yticklabels = top:stepr/5:bottom
    end

    yticks = floor.(Int, yticks)
    yticklabels = floor.(Int, yticklabels)
    yt = (yticks, yticklabels)

    p = plot(layout=1, leg=leg, size=size,
             title=title, xaxis=xlabel, yaxis=ylabel,
             yticks=yt, left_margin=10mm,
             colorbar_title=colorbar_title)
    Plots.heatmap!(a, yflip=true, color=color)
    return p

end

end # module
