/**
 * Provides default sources, sinks, and sanitizers for reasoning about
 * log injection vulnerabilities, as well as extension points for adding your own.
 */

import go

/**
 * Provides extension points for customizing the data-flow tracking configuration for reasoning
 * about log injection.
 */
module LogInjection {
  /**
   * A data flow source for log injection vulnerabilities.
   */
  abstract class Source extends DataFlow::Node { }

  /**
   * A data flow sink for log injection vulnerabilities.
   */
  abstract class Sink extends DataFlow::Node { }

  /**
   * A sanitizer for log injection vulnerabilities.
   */
  abstract class Sanitizer extends DataFlow::Node { }

  /**
   * A sanitizer guard for log injection vulnerabilities.
   */
  abstract class SanitizerGuard extends DataFlow::BarrierGuard { }

  /** A source of untrusted data, considered as a taint source for log injection. */
  class UntrustedFlowAsSource extends Source {
    UntrustedFlowAsSource() { this instanceof UntrustedFlowSource }
  }

  /** An argument to a logging mechanism. */
  class LoggerSink extends Sink {
    LoggerSink() { this = any(LoggerCall log).getAMessageComponent() }
  }

  /**
   * A call to `strings.Replace` or `strings.ReplaceAll`, considered as a sanitizer
   * for log injection.
   */
  class ReplaceSanitizer extends Sanitizer {
    ReplaceSanitizer() {
      exists(string name, DataFlow::CallNode call |
        this = call and
        call.getTarget().hasQualifiedName("strings", name) and
        call.getArgument(1).getStringValue().matches("%" + ["\r", "\n"] + "%")
      |
        name = "Replace" and
        call.getArgument(3).getNumericValue() < 0
        or
        name = "ReplaceAll"
      )
    }
  }
}
