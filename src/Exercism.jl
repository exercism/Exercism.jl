module Exercism

using JSON

function create_submission(slug)
    open("$slug.jl", "w") do f
        write(f, parse_notebook("$slug.ipynb"))
    end
end

function parse_notebook(path)
    nb = open(JSON.parse, path, "r")

    # check if notebook is in acceptable format
    nb["nbformat"] == 4 || error("unrecognized notebook format ", nb["nbformat"])
    lang = lowercase(nb["metadata"]["language_info"]["name"])
    lang == "julia" || error("unrecognized notebook language $lang")

    submission = ""

    # scan for cells that contain code marked for submission with `# submit`
    for cell in nb["cells"]
        if cell["cell_type"] == "code" && !isempty(cell["source"])
            s = join(cell["source"])
            if startswith(s, "# submit")
                submission *= s
            end
        end
    end

    replace(submission, "# submit\n" => "")
end

end # module
