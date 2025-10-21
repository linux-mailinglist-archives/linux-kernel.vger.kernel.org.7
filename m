Return-Path: <linux-kernel+bounces-862653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C9BF5DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B123A2551
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542632C93C;
	Tue, 21 Oct 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tmxvpvew"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFF2EA17D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043218; cv=none; b=k9bgc1TdoQ5mXSCkPjcj8qSJKb0aUV6L/MmNi3uHrxy0/Iqtfawr2HvQ6WQNzWDjnriwy1SmUHn+QrVq7wFbID7jlY2QkkT57PXe4HvR2HpqIBH//YQIju+MG+zXAOeab819YET2iWCehJqPKvBZsJgm7joT3RqU8V/P7qZ/OBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043218; c=relaxed/simple;
	bh=UYyYRnQbXnCvAIlE1ZdNvY1IRbRxEMbOF2tV79AsSe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TY5v3cexiJEM54NRXGrSojCjEsv7G40UbPO9zZ5bioIyD2tyNiNezlVc55hOmK599wH32hhXbQJAqoe+bDuSgnNB87tEfjeRHNrA5Qi9z/lLoGvHcbzC6wxX8xK+CEL/HuGz9bOIBwOQEWGRiIc1Un+hHnUdybnFj3jzH46F86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tmxvpvew; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8OOIn012691
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jNy+kcNV6c4
	PBhObCb2utKXHWJKznzQtqH7XbZIO9js=; b=Tmxvpvewo8LvbZOVtTldkjiOM67
	bzWL/BC0F9VycNUffsUgy3R5nbf05R/nN0yAiVA5o6mzid83Mw9s+zwpvpGEI3Ev
	ptON+BDbgCXZJ8XQsBtLgZzEFmmIBF4GINZ810qG6hEyTnyPHg2nPHl70ZWdge2W
	iIILGHaEHQHqjLTYE0T1ZVE97TGeBca9Xc9aFtPyZGIPx128VebLDDhWf7ryTWuC
	faJXufmOxrbETKLaevgxtWypJHnF+xtxXtVHQLA4rQ/dUnlCq+98/YfEbYJkvDwG
	hg1aKUGpPNEgnG4RhZT1aaQ9FV05G80IVKXg2KwaKYlwoNtqlpav6WKLE5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtgetme0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:40:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88fec61f826so1917996885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043212; x=1761648012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNy+kcNV6c4PBhObCb2utKXHWJKznzQtqH7XbZIO9js=;
        b=EEP+Onw0dS5JUhkVqEd+rjcqvqA/iBhgEZQm74WlPtl/LL3lirV35t6xmWDCthWtuT
         qYElztGjHbh9PPpXlWIMDe+WR+tK8PGNCBWn/nG3wXXYm22a+ftQ2zf9vU/DUQMI0GIS
         5f4u2pL2+n+ha+TclBZ2lGWv7WMFLLMcZiF5zw7mSuz1BdrRPPQYUoPPO4eDTmNoSNjl
         yfMl78dtZ8Fm2x4+epZ9jrDBvLFIspMOpy3nAV9zOzsSZxhr39UMJ1fujz6BYkh3H3r5
         z+4nwgfw296RXcFcKAYKYzUXNI7d4JEWcw2EtuVolVAnOPZ6NMvLlRo1FshWfDKlEmqA
         Msqg==
X-Forwarded-Encrypted: i=1; AJvYcCXXIo2DX6WaM+w6iWAq9d7aE0NGgya8HwsgFAnYw81pC0+Recuxp8SU+bJToV5lKFrgLwXTHzw3g9GSnV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJOckY9iquqGWQkAIdEwqBUV1R4iqlDAiI7j8Iuvlaj0w6A65
	kT7zjwNXGgu2K+yCUxoowVdC4oS3zXKxbM31BB8IsnONw7wVaRTq8XHT2YJ+pvdFzN8vY7rnn6y
	k/IHqGe4DP6KQec5vzu78fdtNrTgxaIwbUA33RKYqSV2xrEijbR4IUczTGytuLDLOREI=
X-Gm-Gg: ASbGnctE4OnjS/F4zGrwUjxIRqg4uqE+5iuAAGObZMeg9vlNNbV/g0NBeyEbS1bmkIh
	lFXZ1dQvxg/ykEsvcrnH5OZRBmuwqo09/+BvjScyDDAPKclWQx4lIX3r2/wRYx8QUK1+cRYBg3C
	42FGkKX57YAXI+yJ2WKvX+kBi/KunkqMpI3ExK1lvfyFNxtx15A2ymFMMSdM5i/EnqzX2EiZSXZ
	4f6GdUr9EyamGjpnNSLODutOMJxDQbfmUR3bc9jmZJviPVR2XSGN+r0Hx+u12y49p8Rg1ONtnaf
	419M3FhY7tHF2beMUTfMJ0SVPjIf3wc2FaDC8H/X3Xnh27oK0Af8+6CM1hCoXi3kIosO7st2ZFO
	hP6+e311L6OdX
X-Received: by 2002:ac8:5a88:0:b0:4b7:9506:efd1 with SMTP id d75a77b69052e-4e89d1fa8f4mr160054631cf.15.1761043212081;
        Tue, 21 Oct 2025 03:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNwpGr5uC6St5tQQjzTYAMWepTpl6VdBTuEO/ILCKO7RvOLdLTGwCCKckadeZvFJxgQmGWJA==
X-Received: by 2002:ac8:5a88:0:b0:4b7:9506:efd1 with SMTP id d75a77b69052e-4e89d1fa8f4mr160054401cf.15.1761043211552;
        Tue, 21 Oct 2025 03:40:11 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm20087938f8f.32.2025.10.21.03.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:40:10 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 4/4] ASoC: qcom: sc7280: make use of common helpers
Date: Tue, 21 Oct 2025 11:40:02 +0100
Message-ID: <20251021104002.249745-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021104002.249745-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251021104002.249745-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MwYVO9y2uCnYLthxoLPdVbb9fjOFXZl1
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f7630c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=xzVSZQTBi2W_vW4HIIQA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: MwYVO9y2uCnYLthxoLPdVbb9fjOFXZl1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfX8BQHq/cP49OX
 +Jk5UMY80wpzs9NI0gcwod/hQf79d8XkDoBQKv7S6JFcUoGrBMIeLwQepC+pC1LrJhaa1dTywkk
 Dwvkom6/O4Py5C6xkd4ClPbsvBBWZxiKdOSfIKZ2rvfOerNKNtCt6sUFtOyT1LXAyjez1Hzq82H
 qzO+B09yrKE0rGZ86jfTSCu68d0reApndLTuFJnxgy9ny/i6FdSxUW0S//Y5HpwGlRlGSuDGgme
 fcIw41Z6nvLtvaAwcU/5S4ov5a3xU9m2+Xr9L9fWzl5axGzyJr9iZgdjhFJTXkjy1mbSzSq3AwA
 TfjUdCR7EXZ7CJtIO00rYZF+t+5wA2ymc5FX0TFSOeec2D2xZjGChqeOKXebduwSPo0rqQ6VgKC
 kcc2JLNmUgpAFO5k4dKU5V7TPU6gPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154

sc7280 machine driver can make use of common sdw functions to do most of
the soundwire related operations. Remove such redundant code from sc7280
driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/sc7280.c | 67 ++---------------------------------------
 sound/soc/qcom/sdw.c    | 10 ++++++
 2 files changed, 13 insertions(+), 64 deletions(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index c444dae563c7..abdd58c1d0a4 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -31,7 +31,6 @@
 
 struct sc7280_snd_data {
 	struct snd_soc_card card;
-	struct sdw_stream_runtime *sruntime[LPASS_MAX_PORTS];
 	u32 pri_mi2s_clk_count;
 	struct snd_soc_jack hs_jack;
 	struct snd_soc_jack hdmi_jack;
@@ -207,32 +206,12 @@ static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_soc_dai *codec_dai;
-	const struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sc7280_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime;
-	int i;
 
 	if (!rtd->dai_link->no_pcm) {
 		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
 		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, 48000, 48000);
 	}
 
-	switch (cpu_dai->id) {
-	case LPASS_CDC_DMA_TX3:
-	case LPASS_CDC_DMA_RX0:
-	case RX_CODEC_DMA_RX_0:
-	case SECONDARY_MI2S_RX:
-	case TX_CODEC_DMA_TX_3:
-	case VA_CODEC_DMA_TX_0:
-		for_each_rtd_codec_dais(rtd, i, codec_dai) {
-			sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
-			if (sruntime != ERR_PTR(-ENOTSUPP))
-				pdata->sruntime[cpu_dai->id] = sruntime;
-		}
-		break;
-	}
-
 	return 0;
 }
 
@@ -241,30 +220,8 @@ static int sc7280_snd_swr_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	const struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
-	int ret;
 
-	if (!sruntime)
-		return 0;
-
-	if (data->stream_prepared[cpu_dai->id]) {
-		sdw_disable_stream(sruntime);
-		sdw_deprepare_stream(sruntime);
-		data->stream_prepared[cpu_dai->id] = false;
-	}
-
-	ret = sdw_prepare_stream(sruntime);
-	if (ret)
-		return ret;
-
-	ret = sdw_enable_stream(sruntime);
-	if (ret) {
-		sdw_deprepare_stream(sruntime);
-		return ret;
-	}
-	data->stream_prepared[cpu_dai->id] = true;
-
-	return ret;
+	return qcom_snd_sdw_prepare(substream, &data->stream_prepared[cpu_dai->id]);
 }
 
 static int sc7280_snd_prepare(struct snd_pcm_substream *substream)
@@ -291,24 +248,8 @@ static int sc7280_snd_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	const struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
 
-	switch (cpu_dai->id) {
-	case LPASS_CDC_DMA_RX0:
-	case LPASS_CDC_DMA_TX3:
-	case RX_CODEC_DMA_RX_0:
-	case TX_CODEC_DMA_TX_3:
-	case VA_CODEC_DMA_TX_0:
-		if (sruntime && data->stream_prepared[cpu_dai->id]) {
-			sdw_disable_stream(sruntime);
-			sdw_deprepare_stream(sruntime);
-			data->stream_prepared[cpu_dai->id] = false;
-		}
-		break;
-	default:
-		break;
-	}
-	return 0;
+	return qcom_snd_sdw_hw_free(substream, &data->stream_prepared[cpu_dai->id]);
 }
 
 static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
@@ -317,7 +258,6 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
@@ -336,8 +276,7 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 		break;
 	}
 
-	data->sruntime[cpu_dai->id] = NULL;
-	sdw_release_stream(sruntime);
+	qcom_snd_sdw_shutdown(substream);
 }
 
 static int sc7280_snd_startup(struct snd_pcm_substream *substream)
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index c44659deea01..16bf09db29f5 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2018-2023, Linaro Limited.
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/soc.h>
@@ -30,6 +31,15 @@ static bool qcom_snd_is_sdw_dai(int id)
 	case RX_CODEC_DMA_RX_6:
 	case RX_CODEC_DMA_RX_7:
 	case SLIMBUS_0_RX...SLIMBUS_6_TX:
+	default:
+		break;
+	}
+
+	/* DSP Bypass usecase, cpu dai index overlaps with DSP dai ids,
+	 * DO NOT MERGE into top switch case */
+	switch (id) {
+	case LPASS_CDC_DMA_TX3:
+	case LPASS_CDC_DMA_RX0:
 		return true;
 	default:
 		break;
-- 
2.51.0


