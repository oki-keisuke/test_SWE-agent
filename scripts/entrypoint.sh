#!/bin/bash

# keys.cfgファイルが存在する場合は削除
if [ -f keys.cfg ]; then
    rm -f keys.cfg
    # shellcheck disable=SC2181
    if [ $? -ne 0 ]; then
        echo "Failed to remove keys.cfg"
        exit 1
    fi
fi

# 環境変数が設定されている場合はkeys.cfgに書き込む
write_to_keys_cfg() {
    local key_name=$1
    local key_value=$2
    if [ -n "${key_value}" ]; then
        echo "${key_name}: '${key_value}'" >> keys.cfg
    fi
}

write_to_keys_cfg "GITHUB_TOKEN" "${GITHUB_TOKEN}"
write_to_keys_cfg "OPENAI_API_KEY" "${OPENAI_API_KEY}"
write_to_keys_cfg "ANTHROPIC_API_KEY" "${ANTHROPIC_API_KEY}"
write_to_keys_cfg "TOGETHER_API_KEY" "${TOGETHER_API_KEY}"
write_to_keys_cfg "AZURE_OPENAI_API_KEY" "${AZURE_OPENAI_API_KEY}"
write_to_keys_cfg "AZURE_OPENAI_ENDPOINT" "${AZURE_OPENAI_ENDPOINT}"
write_to_keys_cfg "AZURE_OPENAI_DEPLOYMENT" "${AZURE_OPENAI_DEPLOYMENT}"
write_to_keys_cfg "AZURE_OPENAI_API_VERSION" "${AZURE_OPENAI_API_VERSION}"
write_to_keys_cfg "OPENAI_API_BASE_URL" "${OPENAI_API_BASE_URL}"

if [ -n "${BASE_COMMIT}" ]; then
    python run.py \
        --image_name=sweagent/swe-agent:latest \
        --model_name "${MODEL_NAME}" \
        --data_path "${ISSUE_URL}" \
        --base_commit "${BASE_COMMIT}" \
        --config_file config/default_from_url.yaml \
        --skip_existing=False
else
    python run.py \
        --image_name=sweagent/swe-agent:latest \
        --model_name "${MODEL_NAME}" \
        --data_path "${ISSUE_URL}" \
        --config_file config/default_from_url.yaml \
        --skip_existing=False
fi
