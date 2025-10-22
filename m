Return-Path: <linux-kernel+bounces-865246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ABEBFCAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C312F6E45E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619C3350A15;
	Wed, 22 Oct 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKXMumSK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DA34CFA0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143648; cv=none; b=I8JZMVv/NA1m7pKlHc0wBBdRzDDEsinz9y6Jp/9iuQb451Yv86s7IzJGUpexwShzpm3n01Rzhb4OWencBj+lpzKjxZG19No3bb5mHgB6Jt6lHPLPCiyyOOXHkeBQ+3DN8TWZN4QTNgyxyl80APiy5ZIA8L7cE3puE1feIxo0oXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143648; c=relaxed/simple;
	bh=N3ekUkk5r7V11hY0lO88UuCG6vkaZSYvwo4x85M1YwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4aYitcDn+5yiwPdLLeGgTaoZsSzbzIzbGr+M8f1OuXz4j1tuU7z/o7jqHojEPvYMIcUxrI+Qy6Ni8Q1Dg35sU90UlumAy1k5ZwCV3PbBCOyZAJx24ZWnhywllnbjfJlW7Gi5HklrKIzvjQzlBN18yZcpM6RJtGvvKUn5Fbq00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKXMumSK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MARjEJ001141
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LjQNhFIeUpf
	5JssPbJ0qx1B6gPLm2FuVhAcXynJbBBc=; b=kKXMumSKlLkFbJhuPzeLE77hSlU
	gHup/Ffj5oRKkz2thtdUJsOpZRM0mpkusgfA/TasdirrHyrXEV5VYQE7LbWqMnZk
	qEmZNloGrMMNiFUL5dEFp/H7iBuvamFSTsHCjgZaVjPkL+a/oVUFIqP33At0pYYo
	dvNsZZKn1QCT/QGFo3PAQk52nSVfos0BrcQox5lwyo0s/tnWKZYP1sktePS1Wkmt
	pF/ANwuHd5XKLVvDLDRTYfUn1m5gZ/7DQioA2/tF+OPKGvACsHsy1//WL5pQPHIW
	T0H35PCncs5r9yaLQi1zeaZjCCXtco7YZn6G8lB82V6a69jAaVgaeAkrg5w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wak7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e892f776d0so60535331cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143644; x=1761748444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjQNhFIeUpf5JssPbJ0qx1B6gPLm2FuVhAcXynJbBBc=;
        b=j9B4tEEZ1RttaUP0Mu/FzJ0g7+R9USHF9vfbpY2jH4gKCQYwggTGzFCkN1YkmlpHrK
         H9RhSx7t2siSgFn1zfuf+4LzUys1UZh7wqQjkJuyWdvNPCzSZcwGIeIG8VAleGbdsIlU
         6LQ02DMl/mhfedJHOUuhWuVBy6zqiG0TPcKIN7o8J7DPhT2CPtMaeLjkLOboUnbVdxzV
         E/jv4k4gwuOYdtqs/JgIhNQ3ekR7ly+XO0FyhdkFveVir7ZJzAhi0aEV6sETSIaCaEKI
         FAzZ6s8+EEg8wa/Gq6Make4XwgUCcN7NbNoEHKyij9fLKaodDTUE1QETvIbfQkByiIRV
         nzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp3kpRsAMg2qXwYN/Huy4FeIN2+g76Z7FPCct+DIeOFCQh2qldbrI8acJVgmThTGHF0aZiRjW1ddNemXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGifNLmmPtAGyogJXkcOcDGnCZ0Opbgi3/MlSGSserXuHyA9g
	Om4iDWgUHTRoI8SI6wwHMD0XxmE6uXugPyJch2iwoaPe5oD3BJfs8dmoRSySTvcpqmngCNIvuUz
	gkK+YzKZyPi3yHBMgPCduxwbUSMx8cjzZAMv3Yit4t7nI/uebD+OOfKk2wTTnvvC3fnQ=
X-Gm-Gg: ASbGncvYMlfnYYAB50ZtsqI/8li4Z0Y2Z/RYyJTN3WeKxZ4G2DpuauDcbb4aw9710xu
	udhKDJKl+fpLKkA6rnKpxqDEQp2x27ixYbV1udcc/Pstbst5ExVxUTxnYlalZetn0HpX3KbNLqx
	aXGqMeSV7JE4P00IyzKxEC4N19fbbvvTTx7iFsrmcL/pXHgoBegliDvyLbc0TofgbEMOOLG3FFC
	79hPx7WXGwmmMnTC4xWdM6My6toLwg3FnWgy2Hk4nEPd+utBzetLRlv8JrDFE2joNAEv++jblhL
	f9SCg48XYP6sij9t2+U2G8D+xJkMOfRsSe3KNEwutaI8WhV7zVlgnhnESTgrG3fjY7Fuu3+Bp2H
	lNvboIu+O2Qsl
X-Received: by 2002:a05:622a:18a1:b0:4e8:ae23:588 with SMTP id d75a77b69052e-4e8ae230a33mr206904511cf.71.1761143644013;
        Wed, 22 Oct 2025 07:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUURiqf2ZbYCHQYkeUwniA0/msOMU8UfHS5MceRvgrYZgwzEArKHXJ3RTzXptD3Cba0FFXJg==
X-Received: by 2002:a05:622a:18a1:b0:4e8:ae23:588 with SMTP id d75a77b69052e-4e8ae230a33mr206903991cf.71.1761143643611;
        Wed, 22 Oct 2025 07:34:03 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm25544910f8f.24.2025.10.22.07.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:34:03 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Steev Klimaszewski <threeway@gmail.com>
Subject: [PATCH v3 3/4] ASoC: qcom: sdm845: make use of common helpers
Date: Wed, 22 Oct 2025 15:33:48 +0100
Message-ID: <20251022143349.1081513-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: LGBir4Np0EuuXFI4dnY_CTUwzK70Dbxu
X-Proofpoint-GUID: LGBir4Np0EuuXFI4dnY_CTUwzK70Dbxu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX6c60XJkKybiB
 3E+lLVyAOENIVaKAVMwtmCva732lFsTzzOV/u9RP24jwXD2OSE8BtZR3C7lUcUGh4JSWO7vovKO
 /xGcI7S3dtFOAFBR0b7ztcUcR4Makgkz/bTu7k/lJOB9WzDhJgG1jaMjsV0NpWg1/O5k7gwGK2W
 I2nj9SImJqslCg+gkmxcvLIw3kCQseVDPCZad5NbWrgK/KuFckrjsGmaLvfMAiknoyR67zbqLNH
 D4DJp7c1GLTbeGKx5nnrnGvolUF2jMRrw4cjJhj794Pf/PhSIJQZeAdjIUWFtMxad9U6qpoOxWJ
 vCBmNmyXYWD71gzzfmXdRGNRgTvrfvO+sqBTUyQtkugjNmHB9BP9dj7fxVj4PLeVCNJrIZR1VwS
 NtvmumbirJ3DvbhCtvh20mDlYGD8/g==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f8eb5d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=5b0IN9Hzzi15MECZVvAA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

sdm845 machine driver can make use of common sdw functions to do most of
the soundwire related operations. Remove such redundant code from sdm845
driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Steev Klimaszewski <threeway@gmail.com> # Thinkpad X13s
---
 sound/soc/qcom/sdm845.c | 53 +++--------------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index a233b80049ee..e18a8e44f2db 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -40,7 +40,6 @@ struct sdm845_snd_data {
 	uint32_t pri_mi2s_clk_count;
 	uint32_t sec_mi2s_clk_count;
 	uint32_t quat_tdm_clk_count;
-	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 };
 
 static struct snd_soc_jack_pin sdm845_jack_pins[] = {
@@ -62,18 +61,11 @@ static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai;
-	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
 	u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
-	struct sdw_stream_runtime *sruntime;
 	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
 	int ret = 0, i;
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
-		sruntime = snd_soc_dai_get_stream(codec_dai,
-						  substream->stream);
-		if (sruntime != ERR_PTR(-ENOTSUPP))
-			pdata->sruntime[cpu_dai->id] = sruntime;
-
 		ret = snd_soc_dai_get_channel_map(codec_dai,
 				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
 
@@ -430,7 +422,6 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
 
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
@@ -471,8 +462,7 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 		break;
 	}
 
-	data->sruntime[cpu_dai->id] = NULL;
-	sdw_release_stream(sruntime);
+	qcom_snd_sdw_shutdown(substream);
 }
 
 static int sdm845_snd_prepare(struct snd_pcm_substream *substream)
@@ -480,38 +470,8 @@ static int sdm845_snd_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
-	int ret;
-
-	if (!sruntime)
-		return 0;
-
-	if (data->stream_prepared[cpu_dai->id]) {
-		sdw_disable_stream(sruntime);
-		sdw_deprepare_stream(sruntime);
-		data->stream_prepared[cpu_dai->id] = false;
-	}
 
-	ret = sdw_prepare_stream(sruntime);
-	if (ret)
-		return ret;
-
-	/**
-	 * NOTE: there is a strict hw requirement about the ordering of port
-	 * enables and actual WSA881x PA enable. PA enable should only happen
-	 * after soundwire ports are enabled if not DC on the line is
-	 * accumulated resulting in Click/Pop Noise
-	 * PA enable/mute are handled as part of codec DAPM and digital mute.
-	 */
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
 
 static int sdm845_snd_hw_free(struct snd_pcm_substream *substream)
@@ -519,15 +479,8 @@ static int sdm845_snd_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
-	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
-
-	if (sruntime && data->stream_prepared[cpu_dai->id]) {
-		sdw_disable_stream(sruntime);
-		sdw_deprepare_stream(sruntime);
-		data->stream_prepared[cpu_dai->id] = false;
-	}
 
-	return 0;
+	return qcom_snd_sdw_hw_free(substream, &data->stream_prepared[cpu_dai->id]);
 }
 
 static const struct snd_soc_ops sdm845_be_ops = {
-- 
2.51.0


