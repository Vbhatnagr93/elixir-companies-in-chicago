defmodule ReadmeGenerator do
  def generate_readme do
    template()
    |> EEx.eval_string(companies: company_list())
  end

  def save(contents, filename \\ "../README.md") do
    File.write!(filename, contents)
  end

  defp company_list do
    "../companies.json"
    |> File.read!()
    |> Jason.decode!()
    |> Map.get("companies")
    |> Enum.sort(&(&1["company_name"] <= &2["company_name"]))
  end

  defp template do
    "templates/README.md.eex"
    |> File.read!()
  end
end
