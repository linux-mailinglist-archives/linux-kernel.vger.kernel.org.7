Return-Path: <linux-kernel+bounces-800516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE2B438AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB20F480967
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13212F83D8;
	Thu,  4 Sep 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtl/90RX"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443482D3A6F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981568; cv=none; b=I4U5dbXQXFyECN0PYx9DYb9p7RWskq+heNYBYGwhQohpH/itod0Yerc20Evo4eS8JPblAQZIIpJhXcQKAwtj7GqYiQejBqTSK7s34PD2HvWfsXOJslsnuXnA2+kFJMZ9SLb9VigZISFz0/mc/2dOhQpX9srieniEPZKBiqnemxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981568; c=relaxed/simple;
	bh=BI2ZP0T/2XRoH+M4+QI/c/CiOCDichYufqvrnpKIP2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbseMsFbX88nW1Ob4kolTp3Xp/Rtz83UY/Mw+xU+rkZNZQXMajR8a10qs9T5fgpyU4jywaHcY4wwMKFRjjWe0Ab9oh4seB3LH8bnROXLRRi/PL0aAg1s2on2mCR2l+FJ1e7dDQBiaSLSQu0oYuARQKgmG021L4ypAhnEQ8hD2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wtl/90RX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cafa0a38aso151893a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756981563; x=1757586363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UW3bkHx1vvQghfKXG7aIDgCaJXMu8LRQiFsEscet0eY=;
        b=wtl/90RXSI/+BG1hs+zM0iznhWQ05giQ7GvLqbNlMRPM3QJHKMeqUdsMB8PHJL3b/d
         DpmrG4JTClmdrc7zcPTIPU+htZ9hxYfLtWm78C8+HCd2kGgKTh4ILbFk+YSPXeLUKhKL
         IBmhRsNH2hp/yNVKgxhVmE3T04kQaI8VyVxUKgQu4tAKajAT0b4WaCtiaHLf1iGcaCdn
         4qOXrbgajl/XmmJesEf49yCLjvIqt0Mnnfa5QBr3vDboPVVp9O8AoRLrFZWGinzinTmb
         uje5W5OLT9xdmNZ+VgNtc7wB+HbT+E3ecDsTQ0PdaT29I3DimxRsqhkOv10vLBusuOS0
         jabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981563; x=1757586363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW3bkHx1vvQghfKXG7aIDgCaJXMu8LRQiFsEscet0eY=;
        b=AKKijbDCnhj2QptegRD90rn8JOyRyg6W5a5oMeChYqsJpe7pydSmWSP0gbsK+NbRCO
         9JXd1Z6+rHSZGlY6qraaBe+CbDTMeZyzWSwmG5Wh0gVwioqyea9kKQjOIFEQmESCM3+l
         Wfl72diiv2BW5Bl4sPtk9NSkqEOLtn3Kd4sGQT4HsZWTQq7nnrcWFYD+NVaggArFy4ah
         uW3LTQ01AfvsqBRObjDL0+D3yNJDjSGBDmKGXsd1rww0GqD5Re7N3pHKGdPEbBG5KhQC
         3uoIijSKVs8ZMx+++TMc7A/6RpxnFNnJHwaY53vfxQ6/eKY2bFWPlm+5GTfa7vKaXWnC
         qSjg==
X-Forwarded-Encrypted: i=1; AJvYcCWXG3zvaZzL3L9OJqUJyzbfQlYTIOJVwC+BXxcFihVFaZ0E2WSmwkqb0bNiOj5IgWOzpB0DeR8l5YRq07Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsQevLq2bXwAWYWE9sqS2vhSd3VtfBYd/evEDNjN+X1iFsFcP
	+EZ5mJhN5AUQrpq7madfmRqaCIwr9g0a9yozJ3KS8EB4/LUt1uw8RtPq7Fu2drtnzjQ=
X-Gm-Gg: ASbGncsMRwayxjqdNbm5+sTfmXLT83lJRjtIKUHtJF5j7M/a1Pji3tisKPzKNcmJ9d6
	QlFxB3AuUMYjK951Skvs4X3yn4MHcJ+YvU4M7LemU74zMaF7gtNyKyM7A6Bp3pHI+J5Bd/xxH1z
	yOY+y/LASN420sk+hEDDgMgXuC3De6FJrNzYZL2NBq8PkiA3PLcWgjUwmjxSiyxaBSR69c8j9y0
	LwEse/v4GssN94tqStEgtkbtbi1Zb2H7b6UV+154BC43msiPc8ZssiR+7kZlZYvSzof6sf3CgT1
	gigPADr9/BZ8/QxYM1noL1DXxEms4fDtLEwWDijQzCXoyJd+EYtpHCm77NurGRi+wZOYXvLC1sN
	EX8nI5wDC48cueZdtWmA/BYLs0s0SQ9FGqA==
X-Google-Smtp-Source: AGHT+IHeVQhoqHiq7M7DSuYNRekdsgwKuToJnU6OnuZ5WZbs+S98q8aT+92pCuXXZAfHE2RtjImacA==
X-Received: by 2002:a05:6402:5203:b0:61c:484c:a533 with SMTP id 4fb4d7f45d1cf-61d0d2a91ecmr8967545a12.1.1756981563564;
        Thu, 04 Sep 2025 03:26:03 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5306e6sm13887446a12.47.2025.09.04.03.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:26:02 -0700 (PDT)
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
Subject: [PATCH v2 1/2] ASoC: qcom: audioreach: Add support for Speaker Protection module
Date: Thu,  4 Sep 2025 12:25:59 +0200
Message-ID: <20250904102558.143745-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=BI2ZP0T/2XRoH+M4+QI/c/CiOCDichYufqvrnpKIP2A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouWk3+PRBfkwRoqp9LwmJsk3WZeR8OgXnneZHH
 9jz5o/j/D+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLlpNwAKCRDBN2bmhouD
 191XD/9gdZ7c9cSgx3T+L4BF1NnAK9sXKZbTdYH32Bv7mnxLjRg8Uf8+O7S1XCWf7xa2HE4EUxD
 0j6dyaRNb9YZp+X4C0+G1NWdMMjR3HBDPToI3j4eE8coWnXqml+hGZm2x6XKPSRVUJ5vmsEHXXy
 DGpHznm0gOQIoiv4KkF7rdH9ObEw5NicG/IlA78DLe5vgYVNfiIE+rHf9Nuel+28fGHXLfxojVS
 iz32ojyV6fKMIamiNMxx+gpQEXLaUWlF4JdOwpB2PGly/M2/nVpAQk30JAhE+uhQ7PBGoL5UjJH
 wKrEkqupzUGI/h5w7HtxnP0ZNIhB1Wyjkgkfc+B8vtfjvyk/kc/9NxfmjvlnNnmDehlwxHU/WWB
 YRSgNIjLKvMfGgi3Cm3UoIoOc5O15KJjjBOkVSCXmLxC/dmvZBb2FJgstsnLF4bM4kFTzO91sUI
 ms3ZPyUlplK5X1qsuUNALw6tv9fez0MFudS7W0nmuhJbRSvK6lr4D6Wn7ytxF1vQ2DI7kcJpjly
 giT+rfzDo1Fvo/bkSIHekPAxRU7+hLaPzfK3y/vZtUAhVDOWsA6qsZ4xJTzQyi3M1CDabgMPoGp
 tLjBTmO+pCzV+zbR095gqWXD19IRN199ERkQ0wRgXPizKZiQKlTw+0JCB469hTkI7k72L8C0exc ZCc9HmzsDQ1cI2w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Speaker Protection is capability of ADSP to adjust the gain during
playback to different speakers and their temperature.  This allows good
playback without blowing the speakers up.

Implement parsing MODULE_ID_SPEAKER_PROTECTION from Audioreach topology
and sending it as command to the ADSP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add and use PARAM_ID_SP_OP_MODE_NORMAL
---
 sound/soc/qcom/qdsp6/audioreach.c | 13 +++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index f4c53e84b4dc..3b7dffd696e7 100644
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
+						   PARAM_ID_SP_OP_MODE_NORMAL);
+		break;
 	default:
 		rc = 0;
 	}
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 790fba96e34d..9f6ddcf081ee 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -31,6 +31,7 @@ struct q6apm_graph;
 #define MODULE_ID_MP3_DECODE		0x0700103B
 #define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
+#define MODULE_ID_SPEAKER_PROTECTION	0x070010E2
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
 #define APM_CMD_RSP_GET_SPF_STATE	0x02001007
@@ -542,6 +543,17 @@ struct data_logging_config {
 	uint32_t mode;
 } __packed;
 
+/* Speaker Protection */
+#define PARAM_ID_SP_OP_MODE			0x080011e9
+#define PARAM_ID_SP_OP_MODE_NORMAL		0
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


