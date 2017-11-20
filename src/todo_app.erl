% %% file: src/todo_app.erl
% %% define entry point for application
% -module(todo_app).
% -behaviour(application).

% %%application callbacks
% -export([start/2, stop/1]).

% %%include todo record
% -include("todo_record.hrl").


% %%---
% %% application callbacks
% %%---

% start(_StartType, _StartArgs) ->
%   %% Start mnesia database in current mode
%   %% which is nonode@nohost
%   mnesia:create_schema([node()]),
%   mnesia:start(),

%   %% create mnesia table based on todo record
%   %% as defined in src/todo_record.hrl
%   mnesia:create_table(todo, [
%     {attributes, record_info(fields, todo)},
%     {disc_copies, [node()]} %%disc_copies means persistent
%   ]),

%   %%define static directory for application
%   Opts = [{static_dir, {'_', {priv_dir, ?MODULE, "templates"}}}],

%   %%Start Leptus listener and set it to route requests to src/todo_handler.erl
%   leptus:start_listener(http, [{'_', [{todo_hander, undef}]}], Opts).

% stop(_State) ->
%   ok.

%% file: src/todo_app.erl
%% ----------------------
-module(todo_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% Include todo record
-include("todo_record.hrl").

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->

   %% Start mnesia database in current node
   %% which is nonode@nohost
   mnesia:create_schema([node()]),
   mnesia:start(),

   %% Create mnesia table based on todo record
   %% which is defined in src/todo_records.hrl
   mnesia:create_table(todo, [
      {attributes, record_info(fields, todo)},
      {disc_copies, [node()]} %% disc_copies means persistent
   ]),

   %% Define static directory for application
   Opts = [{static_dir, {'_', {priv_dir, ?MODULE, "templates"}}}],

   %% Start Leptus listener and set it to route every requests
   %% to src/todo_handler.erl
   leptus:start_listener(http, [{'_', [{todo_handler, undef}]}], Opts).

stop(_State) ->
   ok.
