if Code.ensure_loaded?(Ecto) do

  defmodule ExfileImagemagick.Ecto.CastMetadata do
    alias Ecto.Changeset
    alias ExfileImagemagick.Metadata, as: MetadataProcessor

    def cast_metadata(changeset, field, metadata_field_name) when is_atom(field) and is_binary(metadata_field_name) do
      cast_metadata(changeset, field, metadata_field_name, [{String.to_atom("#{field}_#{Macro.underscore(metadata_field_name)}"), :string}])
    end

    def cast_metadata(changeset, field, metadata_field_name, params) when is_atom(field) and is_binary(metadata_field_name) and is_atom(params) do
      cast_metadata(changeset, field, metadata_field_name, [{params, :string}])
    end

    def cast_metadata(changeset, field, metadata_field_name, params) when is_atom(field) and is_binary(metadata_field_name) and is_list(params) do
      case Changeset.get_change(changeset, field) do
        %Exfile.File{} -> perform_cast(changeset, field, metadata_field_name, params)
        _              -> changeset
      end
    end

    defp perform_cast(changeset, field, metadata_field_name, [{ecto_field, ecto_type}]) do
      changeset
      |> Changeset.get_change(field)
      |> MetadataProcessor.call([],[])
      |> put_metadata(changeset, metadata_field_name, ecto_field, ecto_type)
    end


    defp put_metadata({:ok, processed_file}, changeset, metadata_field_name, ecto_field, :naive_datetime) do
      raw_value = processed_file.meta[metadata_field_name]
      if raw_value != nil do
        Changeset.put_change(changeset, ecto_field, from_exif_datetime(raw_value))
      else
        changeset
      end
    end

    defp put_metadata({:ok, processed_file}, changeset, metadata_field_name, ecto_field, :integer) do
      raw_value = processed_file.meta[metadata_field_name]
      if raw_value != nil do
        Changeset.put_change(changeset, ecto_field, String.to_integer(raw_value))
      else
        changeset
      end
    end

    defp put_metadata({:ok, processed_file}, changeset, metadata_field_name, ecto_field, _) do
      raw_value = processed_file.meta[metadata_field_name]
      if raw_value != nil do
        Changeset.put_change(changeset, ecto_field, raw_value)
      else
        changeset
      end
    end

    defp put_metadata(_,changeset, _, _, _), do: changeset


    defp from_exif_datetime(<<year::4-bytes, ?:, month::2-bytes, ?:, day::2-bytes, sep,
                     hour::2-bytes, ?:, min::2-bytes, ?:, sec::2-bytes, _::binary>>) when sep in [?\s, ?T] do
        with {year, ""} <- Integer.parse(year),
             {month, ""} <- Integer.parse(month),
             {day, ""} <- Integer.parse(day),
             {hour, ""} <- Integer.parse(hour),
             {minute, ""} <- Integer.parse(min),
             {second, ""} <- Integer.parse(sec) do
          {:ok, value} = NaiveDateTime.new(year, month, day, hour, minute, second)
          value
        else
          {:error, reason} -> {:error, reason}
          _ -> {:error, :invalid_format}
        end
    end
  end

end
