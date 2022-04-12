# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `faraday` gem.
# Please instead update this file by running `bin/tapioca gem faraday`.

module Faraday
  class << self
    def default_adapter; end
    def default_adapter=(adapter); end
    def default_adapter_options; end
    def default_adapter_options=(_arg0); end
    def default_connection; end
    def default_connection=(_arg0); end
    def default_connection_options; end
    def default_connection_options=(options); end
    def ignore_env_proxy; end
    def ignore_env_proxy=(_arg0); end
    def lib_path; end
    def lib_path=(_arg0); end
    def new(url = T.unsafe(nil), options = T.unsafe(nil), &block); end
    def respond_to_missing?(symbol, include_private = T.unsafe(nil)); end
    def root_path; end
    def root_path=(_arg0); end

    private

    def method_missing(name, *args, &block); end
  end
end

class Faraday::Adapter
  extend ::Faraday::MiddlewareRegistry
  extend ::Faraday::Adapter::Parallelism

  def initialize(_app = T.unsafe(nil), opts = T.unsafe(nil), &block); end

  def call(env); end
  def close; end
  def connection(env); end

  private

  def request_timeout(type, options); end
  def save_response(env, status, body, headers = T.unsafe(nil), reason_phrase = T.unsafe(nil)); end
end

Faraday::Adapter::CONTENT_LENGTH = T.let(T.unsafe(nil), String)

module Faraday::Adapter::Parallelism
  def inherited(subclass); end
  def supports_parallel=(_arg0); end
  def supports_parallel?; end
end

Faraday::Adapter::TIMEOUT_KEYS = T.let(T.unsafe(nil), Hash)

class Faraday::Adapter::Test < ::Faraday::Adapter
  def initialize(app, stubs = T.unsafe(nil), &block); end

  def call(env); end
  def configure; end
  def stubs; end
  def stubs=(_arg0); end
end

class Faraday::Adapter::Test::Stub < ::Struct
  def headers_match?(request_headers); end
  def matches?(env); end
  def params_match?(env); end
  def path_match?(request_path, meta); end
  def to_s; end
end

class Faraday::Adapter::Test::Stubs
  def initialize(strict_mode: T.unsafe(nil)); end

  def delete(path, headers = T.unsafe(nil), &block); end
  def empty?; end
  def get(path, headers = T.unsafe(nil), &block); end
  def head(path, headers = T.unsafe(nil), &block); end
  def match(env); end
  def options(path, headers = T.unsafe(nil), &block); end
  def patch(path, body = T.unsafe(nil), headers = T.unsafe(nil), &block); end
  def post(path, body = T.unsafe(nil), headers = T.unsafe(nil), &block); end
  def put(path, body = T.unsafe(nil), headers = T.unsafe(nil), &block); end
  def strict_mode=(value); end
  def verify_stubbed_calls; end

  protected

  def matches?(stack, env); end
  def new_stub(request_method, path, headers = T.unsafe(nil), body = T.unsafe(nil), &block); end
end

class Faraday::Adapter::Test::Stubs::NotFound < ::StandardError; end

class Faraday::AdapterRegistry
  def initialize; end

  def get(name); end
  def set(klass, name = T.unsafe(nil)); end
end

class Faraday::BadRequestError < ::Faraday::ClientError; end
Faraday::CONTENT_TYPE = T.let(T.unsafe(nil), String)
class Faraday::ClientError < ::Faraday::Error; end
class Faraday::ConflictError < ::Faraday::ClientError; end

class Faraday::Connection
  extend ::Forwardable

  def initialize(url = T.unsafe(nil), options = T.unsafe(nil)); end

  def adapter(*args, &block); end
  def app(*args, &block); end
  def build_exclusive_url(url = T.unsafe(nil), params = T.unsafe(nil), params_encoder = T.unsafe(nil)); end
  def build_request(method); end
  def build_url(url = T.unsafe(nil), extra_params = T.unsafe(nil)); end
  def builder; end
  def close; end
  def default_parallel_manager; end
  def default_parallel_manager=(_arg0); end
  def delete(url = T.unsafe(nil), params = T.unsafe(nil), headers = T.unsafe(nil)); end
  def dup; end
  def find_default_proxy; end
  def get(url = T.unsafe(nil), params = T.unsafe(nil), headers = T.unsafe(nil)); end
  def head(url = T.unsafe(nil), params = T.unsafe(nil), headers = T.unsafe(nil)); end
  def headers; end
  def headers=(hash); end
  def host(*args, &block); end
  def host=(*args, &block); end
  def in_parallel(manager = T.unsafe(nil)); end
  def in_parallel?; end
  def initialize_proxy(url, options); end
  def options(*args); end
  def parallel_manager; end
  def params; end
  def params=(hash); end
  def patch(url = T.unsafe(nil), body = T.unsafe(nil), headers = T.unsafe(nil), &block); end
  def path_prefix(*args, &block); end
  def path_prefix=(value); end
  def port(*args, &block); end
  def port=(*args, &block); end
  def post(url = T.unsafe(nil), body = T.unsafe(nil), headers = T.unsafe(nil), &block); end
  def proxy; end
  def proxy=(new_value); end
  def proxy_for_request(url); end
  def proxy_from_env(url); end
  def put(url = T.unsafe(nil), body = T.unsafe(nil), headers = T.unsafe(nil), &block); end
  def request(*args, &block); end
  def response(*args, &block); end
  def run_request(method, url, body, headers); end
  def scheme(*args, &block); end
  def scheme=(*args, &block); end
  def set_basic_auth(user, password); end
  def ssl; end
  def support_parallel?(adapter); end
  def trace(url = T.unsafe(nil), params = T.unsafe(nil), headers = T.unsafe(nil)); end
  def url_prefix; end
  def url_prefix=(url, encoder = T.unsafe(nil)); end
  def use(*args, &block); end
  def with_uri_credentials(uri); end
end

Faraday::Connection::METHODS = T.let(T.unsafe(nil), Set)
Faraday::Connection::USER_AGENT = T.let(T.unsafe(nil), String)
class Faraday::ConnectionFailed < ::Faraday::Error; end

class Faraday::ConnectionOptions < ::Faraday::Options
  def builder_class; end
  def new_builder(block); end
  def request; end
  def ssl; end
end

module Faraday::DecodeMethods
  def decode(query); end

  protected

  def add_to_context(is_array, context, value, subkey); end
  def decode_pair(key, value, context); end
  def dehash(hash, depth); end
  def match_context(context, subkey); end
  def new_context(subkey, is_array, context); end
  def prepare_context(context, subkey, is_array, last_subkey); end
end

Faraday::DecodeMethods::SUBKEYS_REGEX = T.let(T.unsafe(nil), Regexp)

module Faraday::EncodeMethods
  def encode(params); end

  protected

  def encode_array(parent, value); end
  def encode_hash(parent, value); end
  def encode_pair(parent, value); end
end

class Faraday::Env < ::Faraday::Options
  extend ::Forwardable

  def [](key); end
  def []=(key, value); end
  def body; end
  def body=(value); end
  def clear_body; end
  def current_body; end
  def custom_members; end
  def in_member_set?(key); end
  def inspect; end
  def needs_body?; end
  def parallel?; end
  def params_encoder(*args, &block); end
  def parse_body?; end
  def success?; end

  class << self
    def from(value); end
    def member_set; end
  end
end

Faraday::Env::ContentLength = T.let(T.unsafe(nil), String)
Faraday::Env::MethodsWithBodies = T.let(T.unsafe(nil), Set)
Faraday::Env::StatusesWithoutBody = T.let(T.unsafe(nil), Set)
Faraday::Env::SuccessfulStatuses = T.let(T.unsafe(nil), Range)

class Faraday::Error < ::StandardError
  def initialize(exc = T.unsafe(nil), response = T.unsafe(nil)); end

  def backtrace; end
  def inspect; end
  def response; end
  def response_body; end
  def response_headers; end
  def response_status; end
  def wrapped_exception; end

  protected

  def exc_msg_and_response(exc, response = T.unsafe(nil)); end
  def exc_msg_and_response!(exc, response = T.unsafe(nil)); end
end

module Faraday::FlatParamsEncoder
  class << self
    def decode(query); end
    def encode(params); end
    def escape(*args, &block); end
    def sort_params; end
    def sort_params=(_arg0); end
    def unescape(*args, &block); end
  end
end

class Faraday::ForbiddenError < ::Faraday::ClientError; end
module Faraday::Logging; end

class Faraday::Logging::Formatter
  extend ::Forwardable

  def initialize(logger:, options:); end

  def debug(*args, &block); end
  def error(*args, &block); end
  def fatal(*args, &block); end
  def filter(filter_word, filter_replacement); end
  def info(*args, &block); end
  def request(env); end
  def response(env); end
  def warn(*args, &block); end

  private

  def apply_filters(output); end
  def dump_body(body); end
  def dump_headers(headers); end
  def log_body(type, body); end
  def log_body?(type); end
  def log_headers(type, headers); end
  def log_headers?(type); end
  def log_level; end
  def pretty_inspect(body); end
end

Faraday::Logging::Formatter::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
Faraday::METHODS_WITH_BODY = T.let(T.unsafe(nil), Array)
Faraday::METHODS_WITH_QUERY = T.let(T.unsafe(nil), Array)

class Faraday::Middleware
  extend ::Faraday::MiddlewareRegistry

  def initialize(app = T.unsafe(nil), options = T.unsafe(nil)); end

  def app; end
  def call(env); end
  def close; end
  def options; end
end

module Faraday::MiddlewareRegistry
  def lookup_middleware(key); end
  def register_middleware(**mappings); end
  def registered_middleware; end
  def unregister_middleware(key); end

  private

  def load_middleware(key); end
  def middleware_mutex(&block); end
end

module Faraday::NestedParamsEncoder
  extend ::Faraday::EncodeMethods
  extend ::Faraday::DecodeMethods

  class << self
    def escape(*args, &block); end
    def sort_params; end
    def sort_params=(_arg0); end
    def unescape(*args, &block); end
  end
end

class Faraday::NilStatusError < ::Faraday::ServerError
  def initialize(exc, response = T.unsafe(nil)); end
end

class Faraday::Options < ::Struct
  def [](key); end
  def clear; end
  def deep_dup; end
  def delete(key); end
  def each; end
  def each_key(&block); end
  def each_value(&block); end
  def empty?; end
  def fetch(key, *args); end
  def has_key?(key); end
  def has_value?(value); end
  def inspect; end
  def key?(key); end
  def keys; end
  def merge(other); end
  def merge!(other); end
  def symbolized_key_set; end
  def to_hash; end
  def update(obj); end
  def value?(value); end
  def values_at(*keys); end

  class << self
    def attribute_options; end
    def fetch_error_class; end
    def from(value); end
    def inherited(subclass); end
    def memoized(key, &block); end
    def memoized_attributes; end
    def options(mapping); end
    def options_for(key); end
  end
end

class Faraday::ParsingError < ::Faraday::Error; end
class Faraday::ProxyAuthError < ::Faraday::ClientError; end

class Faraday::ProxyOptions < ::Faraday::Options
  extend ::Forwardable

  def host(*args, &block); end
  def host=(*args, &block); end
  def password; end
  def path(*args, &block); end
  def path=(*args, &block); end
  def port(*args, &block); end
  def port=(*args, &block); end
  def scheme(*args, &block); end
  def scheme=(*args, &block); end
  def user; end

  class << self
    def from(value); end
  end
end

class Faraday::RackBuilder
  def initialize(&block); end

  def ==(other); end
  def [](idx); end
  def adapter(klass = T.unsafe(nil), *args, &block); end
  def app; end
  def build; end
  def build_env(connection, request); end
  def build_response(connection, request); end
  def delete(handler); end
  def handlers; end
  def handlers=(_arg0); end
  def insert(index, *args, &block); end
  def insert_after(index, *args, &block); end
  def insert_before(index, *args, &block); end
  def lock!; end
  def locked?; end
  def request(key, *args, &block); end
  def response(key, *args, &block); end
  def swap(index, *args, &block); end
  def to_app; end
  def use(klass, *args, &block); end

  private

  def adapter_set?; end
  def assert_index(index); end
  def ensure_adapter!; end
  def initialize_dup(original); end
  def is_adapter?(klass); end
  def raise_if_adapter(klass); end
  def raise_if_locked; end
  def use_symbol(mod, key, *args, &block); end
end

class Faraday::RackBuilder::Handler
  def initialize(klass, *args, &block); end

  def ==(other); end
  def build(app = T.unsafe(nil)); end
  def inspect; end
  def klass; end
  def name; end
end

Faraday::RackBuilder::Handler::REGISTRY = T.let(T.unsafe(nil), Faraday::AdapterRegistry)
Faraday::RackBuilder::LOCK_ERR = T.let(T.unsafe(nil), String)
Faraday::RackBuilder::MISSING_ADAPTER_ERROR = T.let(T.unsafe(nil), String)
Faraday::RackBuilder::NO_ARGUMENT = T.let(T.unsafe(nil), Object)
class Faraday::RackBuilder::StackLocked < ::RuntimeError; end

class Faraday::Request < ::Struct
  extend ::Faraday::MiddlewareRegistry

  def [](key); end
  def []=(key, value); end
  def headers=(hash); end
  def marshal_dump; end
  def marshal_load(serialised); end
  def params=(hash); end
  def to_env(connection); end
  def url(path, params = T.unsafe(nil)); end

  class << self
    def create(request_method); end
  end
end

class Faraday::Request::Authorization < ::Faraday::Middleware
  def initialize(app, type, *params); end

  def on_request(env); end

  private

  def header_from(type, *params); end
end

Faraday::Request::Authorization::KEY = T.let(T.unsafe(nil), String)

class Faraday::Request::Instrumentation < ::Faraday::Middleware
  def initialize(app, options = T.unsafe(nil)); end

  def call(env); end
end

class Faraday::Request::Instrumentation::Options < ::Faraday::Options
  def instrumenter; end
  def name; end
end

class Faraday::Request::Json < ::Faraday::Middleware
  def on_request(env); end

  private

  def body?(env); end
  def encode(data); end
  def match_content_type(env); end
  def process_request?(env); end
  def request_type(env); end
end

Faraday::Request::Json::MIME_TYPE = T.let(T.unsafe(nil), String)
Faraday::Request::Json::MIME_TYPE_REGEX = T.let(T.unsafe(nil), Regexp)

class Faraday::Request::UrlEncoded < ::Faraday::Middleware
  def call(env); end
  def match_content_type(env); end
  def process_request?(env); end
  def request_type(env); end

  class << self
    def mime_type; end
    def mime_type=(_arg0); end
  end
end

Faraday::Request::UrlEncoded::CONTENT_TYPE = T.let(T.unsafe(nil), String)

class Faraday::RequestOptions < ::Faraday::Options
  def []=(key, value); end
  def stream_response?; end
end

class Faraday::ResourceNotFound < ::Faraday::ClientError; end

class Faraday::Response
  extend ::Forwardable
  extend ::Faraday::MiddlewareRegistry

  def initialize(env = T.unsafe(nil)); end

  def [](*args, &block); end
  def apply_request(request_env); end
  def body; end
  def env; end
  def finish(env); end
  def finished?; end
  def headers; end
  def marshal_dump; end
  def marshal_load(env); end
  def on_complete(&block); end
  def reason_phrase; end
  def status; end
  def success?; end
  def to_hash; end
end

class Faraday::Response::Json < ::Faraday::Middleware
  def initialize(app = T.unsafe(nil), parser_options: T.unsafe(nil), content_type: T.unsafe(nil), preserve_raw: T.unsafe(nil)); end

  def on_complete(env); end

  private

  def parse(body); end
  def parse_response?(env); end
  def process_response(env); end
  def process_response_type?(env); end
  def response_type(env); end
end

class Faraday::Response::Logger < ::Faraday::Middleware
  def initialize(app, logger = T.unsafe(nil), options = T.unsafe(nil)); end

  def call(env); end
  def on_complete(env); end
end

class Faraday::Response::RaiseError < ::Faraday::Middleware
  def on_complete(env); end
  def query_params(env); end
  def response_values(env); end
end

Faraday::Response::RaiseError::ClientErrorStatuses = T.let(T.unsafe(nil), Range)
Faraday::Response::RaiseError::ServerErrorStatuses = T.let(T.unsafe(nil), Range)
class Faraday::SSLError < ::Faraday::Error; end

class Faraday::SSLOptions < ::Faraday::Options
  def disable?; end
  def verify?; end
end

class Faraday::ServerError < ::Faraday::Error; end

class Faraday::TimeoutError < ::Faraday::ServerError
  def initialize(exc = T.unsafe(nil), response = T.unsafe(nil)); end
end

class Faraday::UnauthorizedError < ::Faraday::ClientError; end
class Faraday::UnprocessableEntityError < ::Faraday::ClientError; end

module Faraday::Utils
  private

  def URI(url); end
  def basic_header_from(login, pass); end
  def build_nested_query(params); end
  def build_query(params); end
  def deep_merge(source, hash); end
  def deep_merge!(target, hash); end
  def default_params_encoder; end
  def default_space_encoding; end
  def default_uri_parser; end
  def default_uri_parser=(parser); end
  def escape(str); end
  def normalize_path(url); end
  def parse_nested_query(query); end
  def parse_query(query); end
  def sort_query_params(query); end
  def unescape(str); end

  class << self
    def URI(url); end
    def basic_header_from(login, pass); end
    def build_nested_query(params); end
    def build_query(params); end
    def deep_merge(source, hash); end
    def deep_merge!(target, hash); end
    def default_params_encoder; end
    def default_params_encoder=(_arg0); end
    def default_space_encoding; end
    def default_space_encoding=(_arg0); end
    def default_uri_parser; end
    def default_uri_parser=(parser); end
    def escape(str); end
    def normalize_path(url); end
    def parse_nested_query(query); end
    def parse_query(query); end
    def sort_query_params(query); end
    def unescape(str); end
  end
end

Faraday::Utils::DEFAULT_SEP = T.let(T.unsafe(nil), Regexp)
Faraday::Utils::ESCAPE_RE = T.let(T.unsafe(nil), Regexp)

class Faraday::Utils::Headers < ::Hash
  def initialize(hash = T.unsafe(nil)); end

  def [](key); end
  def []=(key, val); end
  def delete(key); end
  def fetch(key, *args, &block); end
  def has_key?(key); end
  def include?(key); end
  def initialize_names; end
  def key?(key); end
  def member?(key); end
  def merge(other); end
  def merge!(other); end
  def parse(header_string); end
  def replace(other); end
  def to_hash; end
  def update(other); end

  protected

  def names; end

  private

  def add_parsed(key, value); end
  def initialize_copy(other); end

  class << self
    def allocate; end
    def from(value); end
  end
end

Faraday::Utils::Headers::KeyMap = T.let(T.unsafe(nil), Hash)

class Faraday::Utils::ParamsHash < ::Hash
  def [](key); end
  def []=(key, value); end
  def delete(key); end
  def has_key?(key); end
  def include?(key); end
  def key?(key); end
  def member?(key); end
  def merge(params); end
  def merge!(params); end
  def merge_query(query, encoder = T.unsafe(nil)); end
  def replace(other); end
  def to_query(encoder = T.unsafe(nil)); end
  def update(params); end

  private

  def convert_key(key); end
end

Faraday::VERSION = T.let(T.unsafe(nil), String)
