# Auth Methods


For example, on developer machines, the GitHub auth method is easiest to use. But for servers the AppRole method is the recommended choice.

# Authentication
Authentication in Vault is the process by which user or machine supplied information is verified against an internal or external system. Vault supports multiple auth methods including GitHub, LDAP, AppRole, and more. Each auth method has a specific use case.
This token is conceptually similar to a session ID on a website. The token may have attached policy, which is mapped at authentication time. This process is described in detail in the policies concepts documentation.


AppRole is an authentication mechanism within Vault to allow machines or apps to acquire a token to interact with Vault. It uses RoleID and SecretID for login.

SecretID is a credential that is required by default for any login and is intended to always be secret. While RoleID is similar to a username, SecretID is equivalent to a password for its corresponding RoleID.

Policies
Everything in Vault is path based, and policies are no exception. Policies provide a declarative way to grant or forbid access to certain paths and operations in Vault. 

### Capabilities
create (POST/PUT) - Allows creating data at the given path. Very few parts of Vault distinguish between create and update, so most operations require both create and update capabilities. Parts of Vault that provide such a distinction are noted in documentation.

read (GET) - Allows reading the data at the given path.

update (POST/PUT) - Allows changing the data at the given path. In most parts of Vault, this implicitly includes the ability to create the initial value at the path.

patch (PATCH) - Allows partial updates to the data at a given path.

delete (DELETE) - Allows deleting the data at the given path.

list (LIST) - Allows listing values at the given path. Note that the keys returned by a list operation are not filtered by policies. Do not encode sensitive information in key names. Not all backends support listing.

In addition to the standard set, there are some capabilities that do not map to HTTP verbs.

sudo - Allows access to paths that are root-protected. Tokens are not permitted to interact with these paths unless they have the sudo capability (in addition to the other necessary capabilities for performing an operation against that path, such as read or delete).

For example, modifying the audit log backends requires a token with sudo privileges.

deny - Disallows access. This always takes precedence regardless of any other defined capabilities, including sudo.

