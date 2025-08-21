Return-Path: <linux-kernel+bounces-780007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD6B2FC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537835C1382
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7E23B607;
	Thu, 21 Aug 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yb3WFA/4"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CD2367D1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785796; cv=none; b=qS4SwEIU2r1HeP9OoLle3o+AADgFGcTi43KG0y0C4JCj5i6zoo98p5GCsJ456t72kaXa7C0pYBve9Uvo5UA7vge9whSebYpauzlWa6zOu5ieMzk0T6JvuZWPjKID5b4jFIWgikJu8ccLg4Ug8eP7NPDphbtxHQ8Nqqw5ACZhjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785796; c=relaxed/simple;
	bh=u1EiMmNicg99wl+W+lAeeTFivMOYtOn+iSGBN8oKESA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baL2BI5THsDVhRwtOOSb3BL2GksCx8YSUQInFG8E1fhL/eP0JoHrXshpyJbkfo53meODHlJXLbCGQLnkC0UyWk8LU1Ak66KNnfulA+9fSgcOlJo8wbPrQegj7nPfBkMqos8aknJNX1fbEctdivYJA5bwG4e8MrzinaT4JpEF7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yb3WFA/4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb74bef86so16836166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755785794; x=1756390594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ0k2vcyc2tLT7HH0rxJhVxlznqPDfjw9yG0PRazUvc=;
        b=yb3WFA/4c54/hA2M9uX0H+hfil1+XLhSqJsnwTB+JI0M1llPuKTUQNRfKnlgbr5cw3
         deSFlhBFEv5kCLzvhsWuKljkwJRulqLl3XAqbfV+LPnML6MSgR2m7Pt9xOpZTzOev3jP
         7QPGF3EqAIoUFwZk+38pUwIC/0jkvOAEmr9oYCDuqNt7TvXK5PMVOsR/Bnry+8jdrb+4
         X9uIHHFy/ZjPGQuXmfubP2OwAlGaSE8ndMabRfCLqkmWJBruvLb/cUdy5Axy2aM9jobf
         z+bYnP2p2ulcedgHXlytp3S+xV1zID4ldNvT/BkWCXIFTE/buqMkw+TjwESal/CrdfsY
         PvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785794; x=1756390594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ0k2vcyc2tLT7HH0rxJhVxlznqPDfjw9yG0PRazUvc=;
        b=hbpOnpuPlrWJDzn74FcZuqH6i2+5bpffhAh0UExmcQuaiAF1AKA+jKh/YNDuuBHlVk
         0x7r7Obb2kIWFZFF+CKCYgQemIHtVj/RBDlCOlD4GCw4QfQundJW06LJm2up0mZobiAB
         5w/1MX7kKcdeO0nzVJ/Ka1W34DC9mMvVeimiNyTwukh/aYi/AFD0N5FlS2kzuvRyBu7p
         c+4thydPehFzQ4czck8RfPEbY80BgP2gHLOt3tUPZR5fS8yzUmL9llqJKUn3t7KCCVgj
         THnakD2Z/PGejxsn69vIiBZq3YS6lz6LlNmNsVzbza9X2N3lRHNqilBsuXPIV55gYUYv
         hQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCVB5Zykflc4FEjVu8F1c79nMjS69Gc52aNnIJta0RbvWS1pHvkdPXaFEnj8YVBCBmwinZxQCId3Ta/Z+U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSSE0dz21jV6fB1pP8300QEuauP5CRfK3b4lDuynfyeKHS9Cq
	IFvd5wfPJXD5xL+THpn0QkCjsvz5/QRa4imw4ZQus6rrNtsdddXcX0sIQNLdms1DCNo=
X-Gm-Gg: ASbGncvU1L0LNZXJkdWNEGpp7lcRQGWvx2GYVipAb3mQIy8KXNPov75LhwGbukBZnJn
	VnT/rL51CgXOmgonXhnDT+whBR13XlpTgsRWoN79p4XqVaNnWb6WFZv1YXlau0nXKedNsy9vOnY
	+2vWNM7dzuORJUxhIJIruUPFVSjXndz0VS4NegkZyN/gYIVVAJMS2M0c4IfLMfuhW56OhL+Rhmm
	2OOvQdk8L9Nyi0vuUo6tzaeCdmkfeqFiBBzZyrUXN3uzp7TLGJEN7h6bn6AV1jLsY3e37Y0v6nW
	Aniz5aNeOa14MwYBU6u+c2iygeIhf45yAb6t/JLOjaO4JpTsWrI0vmZxVPNngUWxN1bipJ+TGrN
	7m/y+WPodQ2xV4WMXTV73EkIUcVpL9LTayg==
X-Google-Smtp-Source: AGHT+IFVNQKIQVJcNOtV/gNXbGu9QGhl6vmLnMf5ayeRRrfxNKefdvubwF7W3Cj4qGwRr/iI9eO8KA==
X-Received: by 2002:a17:906:c149:b0:af9:3397:ee9d with SMTP id a640c23a62f3a-afe079d7a7cmr123591666b.3.1755785793589;
        Thu, 21 Aug 2025 07:16:33 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4cc3c0sm395325566b.96.2025.08.21.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:16:32 -0700 (PDT)
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
Subject: [PATCH 1/2] ASoC: qcom: audioreach: Add support for Speaker Protection module
Date: Thu, 21 Aug 2025 16:16:26 +0200
Message-ID: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=u1EiMmNicg99wl+W+lAeeTFivMOYtOn+iSGBN8oKESA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopyo64EfF+ULupRyQL9/Y3l809bzF1ZqNuDj1l
 UGrNR+laymJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKcqOgAKCRDBN2bmhouD
 113ID/0biIgGnS7NEqLj/msZFRLfs4blEUj2NDA3aWzfESG91irl1s4/sE4jigJXbrkib6TeJow
 n4i1O8nhStZvCA29j+zovGe0iIgwtZGUdS4tHjkFhczaJsKufJ3MYX0wk6XMauShk7oWAtL8Xd7
 L2K7W1jKzu9TId0zelbHvjYXIpwTPYhFkkayH1nu/Gaqv7yBRdfSJAQIsIVuTgZ+uXud78b1Ji0
 0sJtM/Lxvu8PQdEnRY1uTOKKQt0YWDWWs5qy2/FdKm56nmLcZOSBvxn3GDVWx9uZ0hdnW+vXCC7
 03j3C9cSZlpBmVq8dlw4n8LzNJ3tQfmCHUTU9Dkg/EOZwDa2tw6itaKTaTikHcijdQF+fjUwGFr
 QPe5VwPNMmRs2j3mlssi7d40BDBx+vO9ueKMTbM5yKBsxLbBAhEKNM9TKzVfl2O0lzcls7jbeRv
 KA2Na+BNheuylYAINvHItwGTkPjCB1Ekv2c+iyiTQLD+VoviOuxD+UjtJYOrIjHCu1YtOBFywpi
 elm2d3BRnbuPCXw1pig4II5ZjxvglPfIeQWll1XbB8x2TgbW7h9OAyed/EiF0+e5rOgNNVrYDSw
 DXir+iAfkHC6pHT6q21geHq2m8c+ZT6Bx/tJnB0mBtOG3Phu+3BkzZtn/ZZLsldHvTwJ5+57De1 IZU3v9R2tPxkr3g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Speaker Protection is capability of ADSP to adjust the gain during
playback to different speakers and their temperature.  This allows good
playback without blowing the speakers up.

Implement parsing MODULE_ID_SPEAKER_PROTECTION from Audioreach topology
and sending it as command to the ADSP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 13 +++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index f4c53e84b4dc..b7f1fc835dc2 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -1250,6 +1250,15 @@ static int audioreach_gain_set(struct q6apm_graph *graph, struct audioreach_modu
 	return rc;
 }
 
+static int audioreach_speaker_protection(struct q6apm_graph *graph,
+					 struct audioreach_module *module,
+					 uint32_t operation_mode)
+{
+	return audioreach_send_u32_param(graph, module, PARAM_ID_SP_OP_MODE,
+					 operation_mode);
+}
+
+
 int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_module *module,
 				struct audioreach_module_config *cfg)
 {
@@ -1299,6 +1308,10 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_GAPLESS:
 		rc = audioreach_gapless_set_media_format(graph, module, cfg);
 		break;
+	case MODULE_ID_SPEAKER_PROTECTION:
+		rc = audioreach_speaker_protection(graph, module,
+						   PARAM_ID_SP_OP_MODE_CALIBRATION);
+		break;
 	default:
 		rc = 0;
 	}
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 790fba96e34d..0ad566e45e09 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -31,6 +31,7 @@ struct q6apm_graph;
 #define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
+#define MODULE_ID_SPEAKER_PROTECTION	0x070010E2
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
 #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
@@ -542,6 +543,16 @@ struct data_logging_config {
 	uint32_t mode;
 } __packed;
 
+/* Speaker Protection */
+#define PARAM_ID_SP_OP_MODE			0x080011e9
+#define PARAM_ID_SP_OP_MODE_CALIBRATION		1
+#define PARAM_ID_SP_OP_MODE_FACTORY_TEST	2
+#define PARAM_ID_SP_OP_MODE_VALIDATION		3
+
+struct param_id_sp_op_mode {
+	uint32_t operation_mode;
+} __packed;
+
 #define PARAM_ID_SAL_OUTPUT_CFG			0x08001016
 struct param_id_sal_output_config {
 	uint32_t bits_per_sample;
-- 
2.48.1


