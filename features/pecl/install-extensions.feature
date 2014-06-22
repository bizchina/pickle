Feature: download and install PECL extensions
  In order to install PECL extensions
  As a pickle user
  I should be able to download and install PECL extensions

  Scenario Outline: Install extensions from PECL URLs
    Given I run "pickle install http://pecl.php.net/get/<extension>/<version> --dry-run"
    Then it should pass
    And the output should contain:
      """
      - Installing <extension> (<version>)
      """
    And the output should contain:
      """
      Downloading: 100%
      """

    Examples:
      | extension | version  |
      | xdebug    | 2.2.5    |
      | apc       | 3.1.13   |
      | apcu      | 4.0.6    |
      | mongo     | 1.5.4    |
      | memcache  | 3.0.8    |
      | amqp      | 1.4.0    |
      | redis     | 2.2.5    |
      | pthreads  | 2.0.7    |

  Scenario Outline: Install extensions from PECL names and stability flag
    Given I run "pickle install <extension>-<stability> --dry-run"
    Then it should pass
    And the output should contain:
      """
      - Installing <name> (latest-<stability>)
      """
    And the output should contain:
      """
      Downloading: 100%
      """
    And the output should contain:
      """
      Package name                      | <pretty>
      """
    And the output should contain:
      """
      Package status                    | <stability>
      """

    Examples:
      | extension     | name      | pretty   | stability |
      | xdebug        | xdebug    | xdebug   | stable    |
      | pecl/apc      | apc       | APC      | stable    |
      | apcu          | apcu      | apcu     | beta      |
      | pecl/memcache | memcache  | memcache | beta      |
