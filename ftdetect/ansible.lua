vim.filetype.add({
  pattern = {
    ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/ansible/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/group_vars/.*'] = 'yaml.ansible',
    ['.*/host_vars/.*'] = 'yaml.ansible',
    ['.*playbook%.ya?ml'] = 'yaml.ansible',
    ['.*site%.ya?ml'] = 'yaml.ansible',
  },
})
