defmodule Bus.NoItemError do
  defexception plug_status: 404,
               message: "Item not found",
               conn: nil,
               router: nil
end
