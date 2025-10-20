Return-Path: <linux-kernel+bounces-860966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13529BF179C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD95C40567E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC13195FC;
	Mon, 20 Oct 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARg4/cqX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3662D2391
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965940; cv=none; b=eugO/21auoalBNDMS+fAdrUQ1Ciydf5dZb5zG0uRFrArRhaX/4JRIyeGXPo+P52YOQPT2tpx8RDjtg/QzlHdWiR5iL/OGNnNUO355FmZiIdV55NTB/1IEahCAtA9UOTX7r+EF93sVXZ0yjNLsPhWXctRKSVpvGiPfwzq79uPL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965940; c=relaxed/simple;
	bh=cL+lLsNeAu3504P42iTQdxbpOfjV6dphSblHCi2ejPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0RCaAZezWV5ztRM66k1yj9EeyhzBAD+6Y5U7nfdWAkMe2FnAz4Avxc0UdfOzuUdrwNEQE6Y7731F4lVlAkMjT0ZJ4icFRdiHhjgb+dqDaLkjyibDm8kAY1AEJBws/noaxtjHV+gUL3SlkFom8JHrO0XBBpxxfTqgQlyrZGu5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARg4/cqX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBU1Rs016508
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ANEMhb00kFj
	4Hah7g8KhQQL3c2pqAVVvhaWRb8YgqSI=; b=ARg4/cqXywJ/XqU/ow0xVGySGF5
	wvGZGYM6P7nVkVB05Rb7xpR+G0Xt0ooSx6VYNO1YSHIcLRV0vPnvB2pSXcTc0Vig
	P/Cr0WZ9KyRVhi1DZwhSvi9TslmydylVAQv2GaKmmHUVL0SN7XxiP2al+GKwFrXm
	tWioRzxjKNtKYQslbJD4kxAfZfjzNEdvSPslv99jM/wiF0hft6EuLMPdqvjq5wB0
	BgO99cxJDYuJvF4OJPCAbnoPnUBblTjONNYGVLzvo1O48HC316Wx16T+S4yp2cDB
	9lTREpMTVUXl0zryy/xxN4P2UlZKRVyewvGPey1IlYDPAdRpL7uzyzx75vA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv4rw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:12:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8906059f6b2so2698613485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965935; x=1761570735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANEMhb00kFj4Hah7g8KhQQL3c2pqAVVvhaWRb8YgqSI=;
        b=vaKtkb4M9GNVDUL1rsCgqvOLIG6+d8X2wwqMIxaKzClD3R0NVfrSnnOp8FpRplffbn
         Jp0MMEABw9cgpxC34e5K3fSFbc1FAOvv/IvkQX3CgsU+m3VBa1juEsMoLIlynmNdocnk
         QlCTxWsTecURfS4jMqf84Dcr3XV56XAN7PtJmeLfrtvdAvYgXe8Ykdy1wn2oqiXkPS3/
         UMKB91b52zy2MTLbzTmVW/auYlsedlT9N+FiQbAnN25TQ6NuYFpWF51peVovsZD1TZq5
         nPI/QuiiotF2omxQ8zE+Sdq7c2K9HyE3fF89G6COqoZ99H1XWpAX0LaDbXdPcybR2hzm
         46vw==
X-Forwarded-Encrypted: i=1; AJvYcCVUJFTFBPc5xexq3/2TM8Yvyne+2n0yVSDPvIgFtBTBumUBdKo8jKlIahueLFINzLu/bP+yQqnQBUffmxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHb3CELe/QArJVgJMd1Uc7pYOjfQPyZZoYqD77Kgtp+8VdqCR
	ZjUDb0sLSoZghjao8GvGHp980Yhq+kOaa+hg1PrwT0zAaPpISsX7KcBd7xnyIfUOmk57s2ym+88
	bjGfWXYMTOz3mj8MbnuwFEmHx5w6dQ2a6W+VEHKiznn/7GWBlRSwbXeNZ+h7+XMnULfo=
X-Gm-Gg: ASbGncvFjphGSaDz/YKFYdg1kxBc5ltIAq2Ps8A5aGV6ZDNm1NQabZWxRyym8IP6svV
	Xzfx14dUEotBCCsk8WOwZcb1OiqVMPBF4GXLpuDZaHfHfotiro49/oqW5yD2SKPpNuXkBeAh7ep
	uTO6EA0p5mN9xpYbm4yGQ5MQQy3wXyAMGwXVfeg0kPbctkeDBdX3MRA72bzqyacmx2isXmSziLV
	Ne9eM/rHTooPeLp2qonc8oQGuZXYtw4W8JqU/MlNk9o1Osv6tBoxGPbYQlcGpsiRS7P10gtihtl
	MkFT2A3RTqzMoq6dBF0c7WoODRAFwxN9eoVkvpVX5VXD69CDSGmjZzmLcv8NXvhyGmiMSaCLdWj
	yjhBzzQxYh+RU
X-Received: by 2002:a05:622a:1827:b0:4e8:b8f7:299d with SMTP id d75a77b69052e-4e8b8f72eaamr57986421cf.68.1760965934986;
        Mon, 20 Oct 2025 06:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtkuBs+TSeiwHochXTFUuWHrbLzWe5wwhxMns/ksWwYn9knr90nH1+9yDnFJ67IaCIxKvDgQ==
X-Received: by 2002:a05:622a:1827:b0:4e8:b8f7:299d with SMTP id d75a77b69052e-4e8b8f72eaamr57985921cf.68.1760965934527;
        Mon, 20 Oct 2025 06:12:14 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm118165505e9.2.2025.10.20.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:12:14 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime
Date: Mon, 20 Oct 2025 14:12:07 +0100
Message-ID: <20251020131208.22734-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020131208.22734-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251020131208.22734-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aka2sifVbuicDLda3VgTjDSggLi0t7Ci
X-Proofpoint-GUID: aka2sifVbuicDLda3VgTjDSggLi0t7Ci
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f63530 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=N47DpUgmF8P8R7KZyx8A:9 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX+AOLX4iNtdqt
 AIEzPsALJn9xRp+ti2FDf3H9EQqOxcZ5FCG4hctlAhqMd2qYnIgnXuk9swy9TzuRZwK6Wy49yet
 yxerHGyBaoEs/h1UW0/ruble7n+crrt9Zn/CTlaKq73ybueoFB+T5ZFgkDIif3tsyxqxirO/5uc
 MxRUyB/vcC2DSM07QSEiqEsrewQvwI18EdC4CAI3cNf4xv+g/8EMwgm8lAgOUhBIxflU+W1FY4s
 HwpZm4jQGjP9T7b7BLubv/TfkojMX+GyInpMMsbg/y/ljGW27hOx/hsXW80oKkjEkAm9c4f9Alf
 K7PnGso/8dOW9Q9hDay6JaR/GXmGDm8hjmmuivUk6av2EMLFF8+3PPxsy2vq7HSFcUZjmZJru5m
 PzGKItbkTTxykeJY5576tmvinApz1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

For some reason we endedup allocating sdw_stream_runtime for every cpu dai,
this has two issues.
1. we never set snd_soc_dai_set_stream for non soundwire dai, which
   means there is no way that we can free this, resulting in memory leak
2. startup and shutdown callbacks can be called without
   hw_params callback called. This combination results in memory leak
because machine driver sruntime array pointer is only set in hw_params
callback.

Fix this by
 1. adding a helper function to get sdw_runtime for substream
which can be used by shutdown callback to get hold of sruntime to free.
 2. only allocate sdw_runtime for soundwire dais.

Fixes: d32bac9cb09c ("ASoC: qcom: Add helper for allocating Soundwire stream runtime")
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/sc7280.c   |   2 +-
 sound/soc/qcom/sc8280xp.c |   2 +-
 sound/soc/qcom/sdw.c      | 104 +++++++++++++++++++++-----------------
 sound/soc/qcom/sdw.h      |   1 +
 sound/soc/qcom/sm8250.c   |   2 +-
 sound/soc/qcom/x1e80100.c |   2 +-
 6 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index af412bd0c89f..c444dae563c7 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -317,7 +317,7 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 78e327bc2f07..9ba536dff667 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -73,7 +73,7 @@ static void sc8280xp_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime = pdata->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	pdata->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 7d7981d4295b..d866fad04131 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -7,6 +7,36 @@
 #include <sound/soc.h>
 #include "sdw.h"
 
+static bool qcom_snd_is_sdw_dai(int id)
+{
+	switch (id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_TX_0:
+	case WSA_CODEC_DMA_RX_1:
+	case WSA_CODEC_DMA_TX_1:
+	case WSA_CODEC_DMA_TX_2:
+	case RX_CODEC_DMA_RX_0:
+	case TX_CODEC_DMA_TX_0:
+	case RX_CODEC_DMA_RX_1:
+	case TX_CODEC_DMA_TX_1:
+	case RX_CODEC_DMA_RX_2:
+	case TX_CODEC_DMA_TX_2:
+	case RX_CODEC_DMA_RX_3:
+	case TX_CODEC_DMA_TX_3:
+	case RX_CODEC_DMA_RX_4:
+	case TX_CODEC_DMA_TX_4:
+	case RX_CODEC_DMA_RX_5:
+	case TX_CODEC_DMA_TX_5:
+	case RX_CODEC_DMA_RX_6:
+	case RX_CODEC_DMA_RX_7:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /**
  * qcom_snd_sdw_startup() - Helper to start Soundwire stream for SoC audio card
  * @substream: The PCM substream from audio, as passed to snd_soc_ops->startup()
@@ -29,6 +59,9 @@ int qcom_snd_sdw_startup(struct snd_pcm_substream *substream)
 	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
 	int ret, i, j;
 
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
+		return 0;
+
 	sruntime = sdw_alloc_stream(cpu_dai->name, SDW_STREAM_PCM);
 	if (!sruntime)
 		return -ENOMEM;
@@ -89,19 +122,8 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 	if (!sruntime)
 		return 0;
 
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case WSA_CODEC_DMA_RX_1:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		break;
-	default:
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
 		return 0;
-	}
 
 	if (*stream_prepared)
 		return 0;
@@ -129,9 +151,7 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_prepare);
 
-int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *params,
-			   struct sdw_stream_runtime **psruntime)
+struct sdw_stream_runtime *qcom_snd_sdw_get_stream(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
@@ -139,21 +159,23 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_stream_runtime *sruntime;
 	int i;
 
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		for_each_rtd_codec_dais(rtd, i, codec_dai) {
-			sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
-			if (sruntime != ERR_PTR(-ENOTSUPP))
-				*psruntime = sruntime;
-		}
-		break;
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
+		return NULL;
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
+		if (sruntime != ERR_PTR(-ENOTSUPP))
+			return sruntime;
 	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_sdw_get_stream);
+
+int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct sdw_stream_runtime **psruntime)
+{
+	*psruntime = qcom_snd_sdw_get_stream(substream);
 
 	return 0;
 
@@ -166,23 +188,13 @@ int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 
-	switch (cpu_dai->id) {
-	case WSA_CODEC_DMA_RX_0:
-	case WSA_CODEC_DMA_RX_1:
-	case RX_CODEC_DMA_RX_0:
-	case RX_CODEC_DMA_RX_1:
-	case TX_CODEC_DMA_TX_0:
-	case TX_CODEC_DMA_TX_1:
-	case TX_CODEC_DMA_TX_2:
-	case TX_CODEC_DMA_TX_3:
-		if (sruntime && *stream_prepared) {
-			sdw_disable_stream(sruntime);
-			sdw_deprepare_stream(sruntime);
-			*stream_prepared = false;
-		}
-		break;
-	default:
-		break;
+	if (!qcom_snd_is_sdw_dai(cpu_dai->id))
+		return 0;
+
+	if (sruntime && *stream_prepared) {
+		sdw_disable_stream(sruntime);
+		sdw_deprepare_stream(sruntime);
+		*stream_prepared = false;
 	}
 
 	return 0;
diff --git a/sound/soc/qcom/sdw.h b/sound/soc/qcom/sdw.h
index 392e3455f1b1..b8bc5beb0522 100644
--- a/sound/soc/qcom/sdw.h
+++ b/sound/soc/qcom/sdw.h
@@ -10,6 +10,7 @@ int qcom_snd_sdw_startup(struct snd_pcm_substream *substream);
 int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *runtime,
 			 bool *stream_prepared);
+struct sdw_stream_runtime *qcom_snd_sdw_get_stream(struct snd_pcm_substream *stream);
 int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct sdw_stream_runtime **psruntime);
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index f5b75a06e5bd..ce5b0059207f 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -117,7 +117,7 @@ static void sm8250_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	data->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index 444f2162889f..2e3599516aa2 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -55,7 +55,7 @@ static void x1e80100_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	struct sdw_stream_runtime *sruntime = qcom_snd_sdw_get_stream(substream);
 
 	data->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
-- 
2.51.0


