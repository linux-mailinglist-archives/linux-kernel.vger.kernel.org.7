Return-Path: <linux-kernel+bounces-865247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7DBFCA64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664E76E064A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92953502B4;
	Wed, 22 Oct 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="govKmZyy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4B3502BA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143650; cv=none; b=HFF3NNEoSqRpeOVn0KlfRjSGCQPkeCIRfjK8tuetZw/IFbAP4QkN9AFKF9y+c2fdzjoSBXyiZimQYr6F7mMrQ/ijoA7D/eu30zx4Kx4b7Uxf3nqXsU/oH5iK/LFZSKaLWvIuI7TNzBa+96f/6k6/A9JQhFtHYdzbnHuhxxrMh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143650; c=relaxed/simple;
	bh=Bz5dNjnWGJ72zU9lpe8lIcLxT6Mivkx50DoKVMYTicc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efkkq3jb1Ys1Nte/nLYku5PDPjHoufplMPSj7qFCMnBJ5HbA6jqOvM+khM7IvBR4Zj91GcJsxaNL8Gyr8YA2JvRMKVha1sRKXkJa5Rrcz7Y5q5UPolUZf7MSPvJj9hfPS4KBdr169NtLdgYmpNp1zFF7alwkRHL30FN8pb1t2KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=govKmZyy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9wEp3004550
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=faQIz8fSwdO
	oA7CWAkNGtjSmqzRzKQ9HbO9f6ZOpKX8=; b=govKmZyybdeQGQigfBY6KIPoEXT
	pvMs2zdjtmwwitWHXIWAlpJpgJ2zcn2u2lmB0cFVBE2B0a8m7l9GzB7eZmDgNQ/m
	NYr/2ZixueYVufsrA9V65Sgow5Nas/VZwky7SI6IFMQYlTReh1TXJ14eoziEeDrU
	ooG6FtSufXQC3rWcxguvhiyAcd0kp13InCN6N/Me+H5SDMpTDbAnhJSFhj2OhG71
	1Q4tSApkDvjavwti/vRaPsXQp40sLgdPjTcU6dA3r+UMt1wXByJEJHfx7qdkZz8D
	lqKXsu3pk6By/m/l5X54gQIY7zzR++Q5nlkTR7KZOe7R3Fybbtp7pUjXViQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfmwv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8b8db4a35so32082251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143646; x=1761748446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faQIz8fSwdOoA7CWAkNGtjSmqzRzKQ9HbO9f6ZOpKX8=;
        b=JjRrNmxU5NsFOLsaomWFqs2Yj0bmmn7WYzQ36D0FCf2VZ9ToBXPswDRnDymN3s2BsT
         C+uBJJsmShA3jJWa4aaiMLQT9I5eMmbUpW7RxF6y/q5u9Isdzw19yjgYZ03dOpjgY/3G
         gdGQ836sAYYM+M2TH7l2SmOnG2YmNczWoH9bWZzCysN2805ljSYaUzVRYjd9XqCiX5F6
         MpvYl7amEQ2aQhejqxGT4QbaSPg0JPqSAIeuJEG86JymwvwWcgTdHV//4P+ga68mCpZn
         rkwUYXqrHqf+20z/0UERL3VFAzs1D16rDGyKyFkNcd1xoE8CoE+4SCAEPVBt4NB3wKS3
         vEdw==
X-Forwarded-Encrypted: i=1; AJvYcCU3wVFomRXiLd1OUTaJ3/rLUCv2M/sbnj7aw8Shehj0HXqusiqTROmJX3+dXqmgXx5b3AJNNabxbyt43Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9A4G7RRQS9xeSEVCl40gPePl5X268wLyXSXL3NKEuT2nWviDk
	THXljRZDwaqMPv1Mh364YZZDa+ZyORQ4/EU/0cQPLtsHUdIBphm+qb6Ij5930AIFabE4P2zFiDM
	2aATM3SYBCQUbghGhBykJeHkxpS0tnNcWLIqTe+780H5V4mMy56dNczYqR/RHR30tGVQ=
X-Gm-Gg: ASbGnctkpm2O/qYhu0zPdJi42Hk4waAt7v+mVvK06FxzFtAFvJgfziTBeU5bThSIt6i
	/BnLz94qSE7lEOOij8bNWg5y2wnZBg2r1HX34Oqfm8/rcPfOI5t88lh3byijUzAYdjM22D35rWj
	NWedxFDl6C/5oNV+SW83nMBlgqG12yskJTrPpdjRww8Ou8D/RdUpAuIlkBRByCH/YOtnZDh9dvY
	ahc4O+4bCGhGCIn4LeQgO6yO5/mGGo1zjrpsGflEM62NAYLyxUGPmlbsOMdbfmQXmY3mVGjrzVD
	rVsh+Xi5Lv2wBH4nvc7fBYAtrB62TIB8JBwN1Qv72Z8IOKFrDWHmUIcahcfio1PHrCTBivLwIdI
	17NXm+re4Y/wC
X-Received: by 2002:ac8:7e88:0:b0:4eb:7669:6b91 with SMTP id d75a77b69052e-4eb76697856mr32466041cf.16.1761143645356;
        Wed, 22 Oct 2025 07:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDK7D29Zp1dC9C3t8n2L6JThatH0XLulfavnkHZNj4oocbfOoVQymObbxt5nwrjNWlrqFgpA==
X-Received: by 2002:ac8:7e88:0:b0:4eb:7669:6b91 with SMTP id d75a77b69052e-4eb76697856mr32465241cf.16.1761143644735;
        Wed, 22 Oct 2025 07:34:04 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm25544910f8f.24.2025.10.22.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:34:04 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Steev Klimaszewski <threeway@gmail.com>
Subject: [PATCH v3 4/4] ASoC: qcom: sc7280: make use of common helpers
Date: Wed, 22 Oct 2025 15:33:49 +0100
Message-ID: <20251022143349.1081513-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022143349.1081513-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251022143349.1081513-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mE1o59DiTa_zcHsppt1VqwW3hNArG_31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX71+ck9BDWVlW
 w5aQX+GV9Y4Up18s5HRM7nD0zrjHmC07lcUhn2fHbHYnD2smDQW+1971wHJWwzonwckSAF88uT0
 Ddh/v94w/2DwGNETAazdReZ6smniCeMvEgIC0dDhgBWkj6lFpITnVhLUapMPRtpIrt2WftVKTga
 km95SwS+vAa8OZ13yaV1Z1B8BTOxemZ7Jxdg3ncgxzXCrThI23OvN6CPegJExAdiH/hFrjL4MV1
 e5djfDlkqDiSx4e0WsBWHThU1MFdysJ2TihMyFEQQhVmbcX4CMgN+vFkuPuHTsEu3fPE3lALKpO
 vA0HFwXFrkYiBonUiQ1K1Q4BsNAjlYxJXGwVrCWEdL1fGX8U0EtEB7oZfk88SoJmMOwwKkrbXYZ
 7/3iD/ZOVzWqNvltRq17OtGYLCmmaA==
X-Proofpoint-GUID: mE1o59DiTa_zcHsppt1VqwW3hNArG_31
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f8eb5f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=xzVSZQTBi2W_vW4HIIQA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

sc7280 machine driver can make use of common sdw functions to do most of
the soundwire related operations. Remove such redundant code from sc7280
driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Steev Klimaszewski <threeway@gmail.com> # Thinkpad X13s
---
 sound/soc/qcom/sc7280.c | 67 ++---------------------------------------
 sound/soc/qcom/sdw.c    | 11 +++++++
 2 files changed, 14 insertions(+), 64 deletions(-)

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
index c44659deea01..6576b47a4c8c 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2018-2023, Linaro Limited.
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/soc.h>
@@ -35,6 +36,16 @@ static bool qcom_snd_is_sdw_dai(int id)
 		break;
 	}
 
+	/* DSP Bypass usecase, cpu dai index overlaps with DSP dai ids,
+	 * DO NOT MERGE into top switch case */
+	switch (id) {
+	case LPASS_CDC_DMA_TX3:
+	case LPASS_CDC_DMA_RX0:
+		return true;
+	default:
+		break;
+	}
+
 	return false;
 }
 
-- 
2.51.0


