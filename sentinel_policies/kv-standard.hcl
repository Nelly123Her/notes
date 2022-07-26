path "kv/data/*" {
  capabilities = ["create", "update", "list", "read"]
}

path "auth/userpass/*" {
  capabilities = ["create", "update", "list", "read","sudo","patch"]
}