Return-Path: <linux-kernel+bounces-780008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA7B2FC63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0701BC7685
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74F1E5B7C;
	Thu, 21 Aug 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m95TlMiD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FC1E8338
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785798; cv=none; b=oE03EMYXfhkbBiIvXK9MX65Cdsg/FkxQkkPXUGc/3GLGG3/4ggpXeTAdKTDhJhd9JbM2QvMWdAOUP1ScsaEAqyPdSRtviltgEaLGh+TaZxliov++CUMKQWeEgYmRfu70vPOvf0lO76wAdBESjRZsngjgCoZbDSI55HZ5Ks6k9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785798; c=relaxed/simple;
	bh=HLDBdXiNq+P1RF8YKINPxUMTBWBPXzbBbSdu0bYjkO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRHVRhMsmh8zWsZjX4jKPEsGYLhOu83wGQc3C5tDJzUVxehRpydONQ09gwrhUF9yR3w5scK3Dgw8ITASKUsu73KQ6TlDK2whMNSYGqCqLXhwHceaOOfgxcfxGL2iQmpHbWSpMYiUBXzOLVIrSserA0as9cfZsAd/FxwzWalKExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m95TlMiD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb731ca55so13974566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755785795; x=1756390595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoN7OIGSwcaV1Dg62iwAEZ0nRj30RcWA9+4IXl2Jlmc=;
        b=m95TlMiDKXtHjT48X0MqThwCWCc6KlxNonhvTYBsssxbLB2brsHgrAJPrjdYhUR+Kq
         zTaCDIZVRcf+/DcG4xie0/55f7M26xOsZZ963RYLlcPxHg/e274OBXurlMPePkBVE2Fr
         09QMZexn6rNLBg14fgk0yZMANc5F6/nO3LDt6RKjh3aMXP1uzf0zjvFuJCIuzoroUyxm
         LR4tGV2UwZYTaBreHW6cSJNV0em3REV4kkeld1ctkRgRWkb2pPPm5bzXepjb5cpKI+kC
         d3AvB8etflZPql5+bp2fnp849Sy9KxV4jdaZlpIwMKxQ2QH24Sn+W+itO/ACdZO7VYKe
         FPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785795; x=1756390595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoN7OIGSwcaV1Dg62iwAEZ0nRj30RcWA9+4IXl2Jlmc=;
        b=wZaeA2STsiWVrCTA8ct30P7yIpHD4ZQUunosUjahwEIUMx6S63M1GnDIz8lqGIdX2P
         gU4EMyOune3ZWEbCMCmoR2QGEr3iwlf5HePxKG3x7uMIDNhiiN2tBW/HvldzXLl0NVqO
         NXSgRCiW2wgNqh/XqtI0noSOn/dsB+ALUk4bNDeFUxoOR92uCtlMrQRNmH9N6K5PN/Cy
         90hg+RN5fGBmffM2bniXMvLOYiu5ukrhRjZoZyePvvOfFvpHKnQf+ULlaZPkS0h9rtWv
         br30WdsNOQ+4zVrAzuJ/v17khGqEhrUKsWLITRyP9h3MjR7TihJq/ZL7YdoNepsJylHV
         X9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ktluwajasTdCirBj55ND2PshGk6VJ4s4Pe8tQ0EhMDGTupGc/LEmNYVltpyVlx+qqN5sDTFyweGbeS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LnLjhe3hOjDPDZdSVCBvUiSgucR0PVybc8wmD6wld5FVlzhS
	F4m+eQp3p2iIcsrOLBUt0TCBT9YudCOjMC5aokYSmaSxM0fECLRwOlaqteemoVC/UWs=
X-Gm-Gg: ASbGncuttsNRPVUTA40tzgEK7XNe7DWlPYKCQmFUg+L1MCRFKs6r/Ia4oxa77CyET5a
	PkNVlfLtzbU4aN4cQcqkh3JdxCNymPWwjF16IUvowjtcyca/ssCd7GGdHQkm6rmtmKVxkIHXerY
	iOmG2H+zBkkshRNFezXP4AIicVhXxBAs3cUEJJ28W3hYPmiYdbFdZEiaGE7lPu+dPh4TF9CkkOU
	5XOtfmMbRnOFqRbUDHPQnz9G9a3rty5q73f6gAqF4II0O4XJIC1Op+WU3CQ2OkXZu/jnpjVQ6zf
	61TogHTfQlqoBromkJuTWsxmx88LizHHt/FQlU3Pl5RIUn1cqE8VubtLKUO/rZUO200VAjQ8XQd
	J6tpqhDEWI8GMLONnDQeZnnS0h56zIrr6kQ==
X-Google-Smtp-Source: AGHT+IE58dc/aIqAL0a1sMzCLolMbX1X5JkoLN83gB/cKEIDCinhQWfqhHOUkozKe5jfLtPZw+53PA==
X-Received: by 2002:a17:907:96a2:b0:adb:2f16:7ba1 with SMTP id a640c23a62f3a-afe07dba271mr131904066b.6.1755785794930;
        Thu, 21 Aug 2025 07:16:34 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4cc3c0sm395325566b.96.2025.08.21.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:16:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: qcom: audioreach: Add support for VI Sense module
Date: Thu, 21 Aug 2025 16:16:27 +0200
Message-ID: <20250821141625.131990-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
References: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6801; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=HLDBdXiNq+P1RF8YKINPxUMTBWBPXzbBbSdu0bYjkO8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopyo90BhsTMDWaaCIrTdOYNoE+igRzEuBwb83f
 FG1GgFmq82JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKcqPQAKCRDBN2bmhouD
 13j8D/44jc3lYJkLXcHF225Q8IktIcBA3e8OTKtoktQaW+hjXxIYs2KaOOE6MA9Bjtxc5n6BR48
 rQY0T8WQcTTnSkQ/S4bRosiG1p1NXqOsv6v/2yTZhv8hXvZonbTCUXi5MALz8jLEMsPEMhP2utb
 /suuriSGvS4XlA7Pqei2GYbSbbQbbufmafYoV0OmR/bBFvm8oqTCMclMc0ZEtjFwAnoriH5ZPrl
 8Zb0ZdR65KpN5DNp6I4c4h+JKPnGpa9e7/jc/OPoHBJM8KJuqVq75j5eBipraN/iIFtKw728UAy
 CXVFenbLFzrAx4/yISgrXIJ2sg6wO6T5kJiA86BFJiwDqMtwXHID062Ki1A5c1fmXNHWcTiw+4d
 BpOSJj6aZ6ip/2nl2seEANZ4Cd4ERKR9/hfiKWMPTJMCFR+OjKTZOeJCNxxRVUEkn9OwjH4pa+1
 khRV/THl/Dv64pFP/BJoBumBHI8Day1cymqPEXcWGYe9XPfBKkpOs1Hq/3eRs6vYxJTbpHebmOj
 0o9+Fg8x9fjD1bFXYVCXtAeb0aK+g2HJOyjb/WRRSya1dh1ns5v3DKLrzmjjoFTCtICSv46C/a7
 CMzM8W+70BoWtTxUc7+PQ2qN9/y3OO5TohKcs0n4nES/nNE5Z6gAD7O2oe4riRQkLd6vofNHrY4 29AAp4MO7raUIhw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

VI Sense module in ADSP is responsible for feedback loop for measuring
current and voltage of amplifiers, necessary for proper calibration of
Speaker Protection algorightms.  Implement parsing
MODULE_ID_SPEAKER_PROTECTION_VI from Audioreach topology and sending it
as command to the ADSP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 112 ++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h |  27 +++++++
 2 files changed, 139 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index b7f1fc835dc2..f2b7f18e29ae 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -202,6 +202,31 @@ struct apm_display_port_module_intf_cfg {
 } __packed;
 #define APM_DP_INTF_CFG_PSIZE ALIGN(sizeof(struct apm_display_port_module_intf_cfg), 8)
 
+struct apm_module_sp_vi_op_mode_cfg {
+	struct apm_module_param_data param_data;
+	struct param_id_sp_vi_op_mode_cfg cfg;
+} __packed;
+
+#define APM_SP_VI_OP_MODE_CFG_PSIZE(ch) ALIGN( \
+				sizeof(struct apm_module_sp_vi_op_mode_cfg) + \
+				(ch) * sizeof(uint32_t), 8)
+
+struct apm_module_sp_vi_ex_mode_cfg {
+	struct apm_module_param_data param_data;
+	struct param_id_sp_vi_ex_mode_cfg cfg;
+} __packed;
+
+#define APM_SP_VI_EX_MODE_CFG_PSIZE ALIGN(sizeof(struct apm_module_sp_vi_ex_mode_cfg), 8)
+
+struct apm_module_sp_vi_channel_map_cfg {
+	struct apm_module_param_data param_data;
+	struct param_id_sp_vi_channel_map_cfg cfg;
+} __packed;
+
+#define APM_SP_VI_CH_MAP_CFG_PSIZE(ch) ALIGN( \
+				sizeof(struct apm_module_sp_vi_channel_map_cfg) + \
+				(ch) * sizeof(uint32_t), 8)
+
 static void *__audioreach_alloc_pkt(int payload_size, uint32_t opcode, uint32_t token,
 				    uint32_t src_port, uint32_t dest_port, bool has_cmd_hdr)
 {
@@ -1258,6 +1283,89 @@ static int audioreach_speaker_protection(struct q6apm_graph *graph,
 					 operation_mode);
 }
 
+static int audioreach_speaker_protection_vi(struct q6apm_graph *graph,
+					    struct audioreach_module *module,
+					    struct audioreach_module_config *mcfg)
+{
+	uint32_t num_channels = mcfg->num_channels;
+	struct apm_module_sp_vi_op_mode_cfg *op_cfg;
+	struct apm_module_sp_vi_channel_map_cfg *cm_cfg;
+	struct apm_module_sp_vi_ex_mode_cfg *ex_cfg;
+	int op_sz, cm_sz, ex_sz;
+	struct apm_module_param_data *param_data;
+	int rc, i, payload_size;
+	struct gpr_pkt *pkt;
+	void *p;
+
+	if (num_channels > 2) {
+		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
+		return -EINVAL;
+	}
+
+	op_sz = APM_SP_VI_OP_MODE_CFG_PSIZE(num_channels);
+	/* Channel mapping for Isense and Vsense, thus twice number of speakers. */
+	cm_sz = APM_SP_VI_CH_MAP_CFG_PSIZE(num_channels * 2);
+	ex_sz = APM_SP_VI_EX_MODE_CFG_PSIZE;
+
+	payload_size = op_sz + cm_sz + ex_sz;
+
+	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
+	if (IS_ERR(pkt))
+		return PTR_ERR(pkt);
+
+	p = (void *)pkt + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
+
+	op_cfg = p;
+	param_data = &op_cfg->param_data;
+	param_data->module_instance_id = module->instance_id;
+	param_data->error_code = 0;
+	param_data->param_id = PARAM_ID_SP_VI_OP_MODE_CFG;
+	param_data->param_size = op_sz - APM_MODULE_PARAM_DATA_SIZE;
+
+	op_cfg->cfg.num_channels = num_channels;
+	op_cfg->cfg.operation_mode = PARAM_ID_SP_VI_OP_MODE_CALIBRATION;
+	op_cfg->cfg.quick_calibration = 1;
+	/*
+	 * op_cfg->cfg.r0_t0_selection should be set only for normal mode, keep
+	 * as 0 for calibration
+	 */
+	p += op_sz;
+
+	cm_cfg = p;
+	param_data = &cm_cfg->param_data;
+	param_data->module_instance_id = module->instance_id;
+	param_data->error_code = 0;
+	param_data->param_id = PARAM_ID_SP_VI_CHANNEL_MAP_CFG;
+	param_data->param_size = cm_sz - APM_MODULE_PARAM_DATA_SIZE;
+
+	cm_cfg->cfg.num_channels = num_channels * 2;
+	for (i = 0; i < num_channels; i++) {
+		/*
+		 * Map speakers into Vsense and then Isense of each channel.
+		 * E.g. for PCM_CHANNEL_FL and PCM_CHANNEL_FR to:
+		 * [ 1, 2, 3, 4]
+		 */
+		cm_cfg->cfg.channel_mapping[2 * i] = (mcfg->channel_map[i] - 1) * 2 + 1;
+		cm_cfg->cfg.channel_mapping[2 * i + 1] = (mcfg->channel_map[i] - 1) * 2 + 2;
+	}
+
+	p += cm_sz;
+
+	ex_cfg = p;
+	param_data = &ex_cfg->param_data;
+	param_data->module_instance_id = module->instance_id;
+	param_data->error_code = 0;
+	param_data->param_id = PARAM_ID_SP_VI_EX_MODE_CFG;
+	param_data->param_size = ex_sz - APM_MODULE_PARAM_DATA_SIZE;
+
+	ex_cfg->cfg.factory_mode = 0;
+
+	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
 
 int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_module *module,
 				struct audioreach_module_config *cfg)
@@ -1312,6 +1420,10 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 		rc = audioreach_speaker_protection(graph, module,
 						   PARAM_ID_SP_OP_MODE_CALIBRATION);
 		break;
+	case MODULE_ID_SPEAKER_PROTECTION_VI:
+		rc = audioreach_speaker_protection_vi(graph, module, cfg);
+		break;
+
 	default:
 		rc = 0;
 	}
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 0ad566e45e09..80dcedac3482 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -32,6 +32,7 @@ struct q6apm_graph;
 #define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
 #define MODULE_ID_SPEAKER_PROTECTION	0x070010E2
+#define MODULE_ID_SPEAKER_PROTECTION_VI	0x070010E3
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
 #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
@@ -553,6 +554,32 @@ struct param_id_sp_op_mode {
 	uint32_t operation_mode;
 } __packed;
 
+/* Speaker Protection VI */
+
+#define PARAM_ID_SP_VI_OP_MODE_CFG		0x080011f4
+#define PARAM_ID_SP_VI_OP_MODE_NORMAL		0
+#define PARAM_ID_SP_VI_OP_MODE_CALIBRATION	1
+#define PARAM_ID_SP_VI_OP_MODE_FACTORY_TEST	2
+#define PARAM_ID_SP_VI_OP_MODE_VALIDATION	3
+struct param_id_sp_vi_op_mode_cfg {
+	uint32_t num_channels;
+	uint32_t operation_mode;
+	uint32_t quick_calibration;
+	uint32_t r0_t0_selection[];
+} __packed;
+
+#define PARAM_ID_SP_VI_EX_MODE_CFG		0x080011ff
+struct param_id_sp_vi_ex_mode_cfg {
+	uint32_t factory_mode;
+} __packed;
+
+#define PARAM_ID_SP_VI_CHANNEL_MAP_CFG		0x08001203
+struct param_id_sp_vi_channel_map_cfg {
+	uint32_t num_channels;
+	/* [ Vsense of ch 1, Isense of ch 1, Vsense of ch 2, Isense of ch 2, ... ] */
+	uint32_t channel_mapping[];
+} __packed;
+
 #define PARAM_ID_SAL_OUTPUT_CFG			0x08001016
 struct param_id_sal_output_config {
 	uint32_t bits_per_sample;
-- 
2.48.1


