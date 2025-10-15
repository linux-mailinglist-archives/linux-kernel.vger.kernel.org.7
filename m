Return-Path: <linux-kernel+bounces-854565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C53BDEBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB3904FC454
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5251F3B87;
	Wed, 15 Oct 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bm5IWV7r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E36222590
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534297; cv=none; b=Z4gPapRwjjve2SEnVxxF0JfX7xmQmosS+MFcNAz2P+xhM0HZcurb/K8RXlIuJDhxuyDp+iGFIsCkx7zjIR5qE07oLo5FlB40WeG4VPdFOqmF+XWqj152eTxmeoXeTfPPuT5TMsfj07hXlEKT7JT8MkQI+NaJ2ES6kcHvxZuSLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534297; c=relaxed/simple;
	bh=RaVk0a+RKh623rS5/Uu99Y1+eyNUkoTQ9NsmASmdwOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKfOCAsnBmgTQ9ESRIPaEeffuGUTkhg4BfkwqtooPqALXBQBm6Hyi4PibVcMvxVKJghdZKr+ZIKwjesSTL7+psnMQDZH9qB5HKHy2uRQC9P08Pxth6sFLDCD1gbULITJ5BYKXJu4SCiGXx/N720KRTTVDS2Xcs6NmqBxvlX8p+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bm5IWV7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FB0wFt004010
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+L0jJtoK/YM
	Dp/hnku7MkJnePyDIy9j+UHZwg2sZ714=; b=bm5IWV7rgHR33XD91P6tyFRTg1v
	NJlyYg/RGsTjFrmP0uQTA4B6+VWj4KORzSqnT2yl8tO91paVED6NUt+EDCjqZX9P
	Qpk+tKHRGZD/UraNctATuIGBj0JX/BSv8uT4Ov13iW+Wfi0M62Cl2IVZRCPf3JxI
	4vqpMA5Ern2sf0OIMwf748Jf1fBZ7iy78OMQVIS5hHEtmO391mk9tKaQovMFODnP
	hHgWMocnIV4HWx4LzP3uSsj/PTVf9s1VGwyQ7Ti9q+tKS8nlTfdl/fILIKIk3fso
	YBgqcmb39CTDdrJ9VZJxSStbg/1E+d/StLwHZmhMi/IY1xn+QRQgUMhLJ1w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg4c6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85dd8633b1bso359631085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534293; x=1761139093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+L0jJtoK/YMDp/hnku7MkJnePyDIy9j+UHZwg2sZ714=;
        b=vwtIOChzu1Pw6vpr+FegDPSj9xFeVbkkpdcprExAMq4akHQpi2NRVoBWD2xKf6zakx
         9rM6Ft7LisVU5jthjKOrtDHMV4KZD5IwafykH+ylxkHDJ6CPwIDAExmaBHCg6RAjK4K4
         HD3iAGaCGSsh3pBERFOyDtl4uB8rABRZ16UFjgvbMf1rL0elaTmdbur5HapPJeFjX/P5
         BOIsg1CQpc09CTViqPZNsMZCqvtWI1THRgObwzWhtIdahtyL86xyN/qF1iiRcyo7QRsf
         shAttsyQ7JDbTS9h06jrPWXuLCSLfnJ7bObUcZP6bLwvVJ2/MUNHPr4NvQg13A35dtNT
         ZNXA==
X-Forwarded-Encrypted: i=1; AJvYcCVRP1Bu7247jD3cXbWKPxtpbrJFlMxltToVVh5N00AO4Wf4z1NsOpaPqvfdTgg+LnbH+HBH6YyQ4CwkzUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4J2YoEY9BSFzRENR+e0CjcVQV5uxAZKVj0+4N2VZ2cG1C8FU
	38AZF8eaYNYPGHRQIxS2lT4iVC1s5kWKfHdTKVMRiaPj4fyArgctZfKaC5DVnfjslAidLV5UC5J
	OALfDocpsgFRDfIdBaeSCekWn4X9G0GY1gDkElZEACXpAH84ppqRQyqnTWC0hr/BnueY=
X-Gm-Gg: ASbGncs40HACBJaCHklS5ykPYjcPQZt6nRlM/H5ksiavgGqNjP1O+0JfMlrrmoP5YE9
	uFNSDyy38cfIxlfaA4R8pCjmFMI0VZdsyPS0tfzfKWEDSbQzkX5ByJpl5MgpK1nPmKop6ui4ONj
	SX956Lqp4kwB8RiGspeX5L1HFuhEVZZjLjXsb3XYcUKKRoL+0g9B+3cuofC2JDmVX4k8jAlSjhC
	R982pnb3bI5bN4OMIOgITOPVuXWK0DVOMBXr+7YrnMB0lSSzHSKyKdeh9R7aVWPrg3zsYWBW5J+
	jiGIjEUCcf3T7uC4PBZTsbI0GAKjFvO0wLzshkqKbwMlyKDbZBNALg==
X-Received: by 2002:a05:622a:1a8b:b0:4de:658d:fab7 with SMTP id d75a77b69052e-4e891017285mr311881cf.37.1760534293070;
        Wed, 15 Oct 2025 06:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXeHar+d1cgZyQoMv6oo1Pxrlg77uwmTnzfkBkItZ7BMtTpXrnLve600DqPbbmLhFLqpZxQw==
X-Received: by 2002:a05:622a:1a8b:b0:4de:658d:fab7 with SMTP id d75a77b69052e-4e891017285mr311431cf.37.1760534292641;
        Wed, 15 Oct 2025 06:18:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:12 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 6/9] ASoC: qcom: q6asm-dai: schedule all available frames to avoid dsp under-runs
Date: Wed, 15 Oct 2025 14:17:36 +0100
Message-ID: <20251015131740.340258-7-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX4VO0eQRzoPBT
 Ru5qjdPMAbWsslRQ1yEINpDW+AdqcAQbx1qk60LKZ6nIa/cDeM2t2dza9Qd+LU6VrT3ix16SzJK
 kLfFe9SVwhpDP27zpI79I91aY2gYfEgVQo9Q5pQIFM8la4yj6c2IMapp//qppCnHGBY+3AbEzJU
 5Pb0cjzHVjpW319hvlC29oyH0SMJhTNAPVuFR6YyPSvKXkj9Ny5NYgRlafMWl2qm/kgqCOURfoq
 LP6/v2J4fjG03eaxd9+J7a9GyJQV/kR2b9MckKyIAwI6UcUiCgD4KTJXCd5Sz6RFzHfw1ran76d
 P1AjH0nK8VeKCzqzEvVF25VEi+EcOMDzguHb0vwEKXta2tWevc5rMaGCrXufHYkvksCXvhusshQ
 BYjnr9ji7FnyKC3qL72D+19Vn9C+GQ==
X-Proofpoint-GUID: ltWayNmvHQlAT09Ki0fbi3FslC-7hZPg
X-Proofpoint-ORIG-GUID: ltWayNmvHQlAT09Ki0fbi3FslC-7hZPg
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ef9f16 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=mP2nE0ReLvtCR7eOSfoA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

With the existing code, we are only setting up one period at a time, in a
ping-pong buffer style. This triggers lot of underruns in the dsp
leading to jitter noise during audio playback.

Fix this by scheduling all available periods, this will ensure that the dsp
has enough buffer feed and ultimatley fixing the underruns and audio distortion.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 34 +++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 0eae8c6e42b8..db2ea8973ac9 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -64,6 +64,7 @@ struct q6asm_dai_rtd {
 	uint64_t bytes_received;
 	uint64_t copied_total;
 	uint16_t bits_per_sample;
+	snd_pcm_uframes_t queue_ptr;
 	uint16_t source; /* Encoding source bit mask */
 	struct audio_client *audio_client;
 	uint32_t next_track_stream_id;
@@ -85,6 +86,7 @@ struct q6asm_dai_data {
 static const struct snd_pcm_hardware q6asm_dai_hardware_capture = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BATCH |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				SNDRV_PCM_INFO_MMAP_VALID |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
@@ -108,6 +110,7 @@ static const struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BATCH |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				SNDRV_PCM_INFO_MMAP_VALID |
+				SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE |
@@ -182,9 +185,6 @@ static void event_handler(uint32_t opcode, uint32_t token,
 
 	switch (opcode) {
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			q6asm_write_async(prtd->audio_client, prtd->stream_id,
-				   prtd->pcm_count, 0, 0, 0);
 		break;
 	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
 		prtd->state = Q6ASM_STREAM_STOPPED;
@@ -192,10 +192,6 @@ static void event_handler(uint32_t opcode, uint32_t token,
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
 		prtd->pcm_irq_pos += prtd->pcm_count;
 		snd_pcm_period_elapsed(substream);
-		if (prtd->state == Q6ASM_STREAM_RUNNING)
-			q6asm_write_async(prtd->audio_client, prtd->stream_id,
-					   prtd->pcm_count, 0, 0, 0);
-
 		break;
 		}
 	case ASM_CLIENT_EVENT_DATA_READ_DONE:
@@ -311,6 +307,29 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	return ret;
 }
 
+static int q6asm_dai_ack(struct snd_soc_component *component, struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	int i, ret = 0, avail_periods;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && prtd->state == Q6ASM_STREAM_RUNNING) {
+		avail_periods = (runtime->control->appl_ptr - prtd->queue_ptr)/runtime->period_size;
+		for (i = 0; i < avail_periods; i++) {
+			ret = q6asm_write_async(prtd->audio_client, prtd->stream_id,
+					   prtd->pcm_count, 0, 0, 0);
+
+			if (ret < 0) {
+				dev_err(component->dev, "Error queuing playback buffer %d\n", ret);
+				return ret;
+			}
+			prtd->queue_ptr += runtime->period_size;
+		}
+	}
+
+	return ret;
+}
+
 static int q6asm_dai_trigger(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream, int cmd)
 {
@@ -1215,6 +1234,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.close			= q6asm_dai_close,
 	.prepare		= q6asm_dai_prepare,
 	.trigger		= q6asm_dai_trigger,
+	.ack			= q6asm_dai_ack,
 	.pointer		= q6asm_dai_pointer,
 	.pcm_construct		= q6asm_dai_pcm_new,
 	.compress_ops		= &q6asm_dai_compress_ops,
-- 
2.51.0


