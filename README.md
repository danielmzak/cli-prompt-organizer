**Personal CLI Tool for Prompt Saving/Retreving**
=====================================================

I needed a simple yet handy tool to save and retrieve prompts, and since I love `fzf`, I decided to use it for this purpose.

**Usage**
-----

1. Clone the repo or get the scripts and install them somewhere in your path.
2. Create a folder for your prompts (e.g., `~/ai/prompts`).
3. Create a subfolder called "inbox" (e.g., `~/ai/prompts/_inbox`).
4. Set the following environment variables:
	* `PROMPT_INBOX_PATH`: e.g., `export PROMPT_INBOX_PATH=~/ai/prompts/_inbox`
	* `PROMPT_PATH`: e.g., `export PROMPT_PATH=~/ai/prompts`

**Workflow**
---------

1. Write a new prompt and copy it to the clipboard.
2. Run the `pinbox.sh` script.
	* The script will take the clipboard content, create a YAML file in the `PROMPT_INBOX_PATH` folder, and save it with a filename like `prompt-inbox-YYYY-MM-DD-HH-MM-SS.yaml`.

**Example**
--------

1. Copy the prompt "Magic mirror on the wall, who is the most beautiful of all?" to the clipboard.
2. Run `pinbox.sh`.
3. The script will create a YAML file like `prompt-inbox-2024-05-10-06-21-31.yaml` in the `_inbox` folder with the following content:
```yaml
---
prompt:
  uuid: 862be853-8f45-4f9d-91fa-ffd6f3db1634
  text: |-
    Magic mirror on the wall, who is the most beautiful of all?
  search_by:
  description:
  tags:
  created_by: me
  created_at: 2024-05-10-06-21-49
```
4. You can now edit, rename, move, or organize the prompt file within the `PROMPT_PATH` folder.
5. Don't forget to fill in the `search_by` field (e.g., "Snow White mirror") and keep the `.yaml` extension.

**Retrieving Prompts**
---------------------

1. Run the `pget.sh` script, which finds all YAML files inside `PROMPT_PATH` and displays them in `fzf` with the content of `search_by` and the filename.
2. Select a prompt, and its text will be copied to the clipboard.

**Tips**
----

* Create a keyboard shortcut for the scripts, such as in Wezterm:
```lua
{
  -- Get prompt
  key = "p",
  mods = "ALT",
  action = wezterm.action {
    SpawnCommandInNewTab = {
      args = { "zsh", "pget.sh" },  -- Replace with your script's path
    }
  }
}
```
**Notes**
----
- Scripts use `xclip`, `yq`, `fzf`, so install them first.

---
`prompt organizer`, `organizing AI prompts`, `cli tool`
