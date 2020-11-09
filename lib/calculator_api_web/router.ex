defmodule CalculatorApiWeb.Router do
  @moduledoc false

  use CalculatorApiWeb, :router

  pipeline :api_public do
    plug :accepts, ["json"]
    
    # plug CalculatorApiWeb.Plugs.RequestLog
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug CalculatorApiWeb.Plugs.RequestLog
    plug CalculatorApiWeb.Plugs.Auth
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/api", CalculatorApiWeb do
    pipe_through :api_public

    resources "/login", LoginController, except: [:index, :edit, :new, :show, :update, :delete]
  end

  scope "/api", CalculatorApiWeb do
    pipe_through :api

    resources "/calcular", CalculateController, [:edit, :new, :show, :update, :delete]
    resources "/usuarios", UserController, except: [:new, :edit]
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :calculator_api,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      schemes: ["http", "https", "ws", "wss"],
      info: %{
        version: "0.1",
        title: "ExCalculator"
      }
    }
  end

  # # Enables LiveDashboard only for development
  # #
  # # If you want to use the LiveDashboard in production, you should put
  # # it behind authentication and allow only admins to access it.
  # # If your application does not have an admins-only section yet,
  # # you can use Plug.BasicAuth to set up some basic authentication
  # # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through [:fetch_session, :protect_from_forgery]
  #     live_dashboard "/dashboard", metrics: CalculatorApiWeb.Telemetry
  #   end
  # end
end
