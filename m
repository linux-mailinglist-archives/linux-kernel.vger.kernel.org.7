Return-Path: <linux-kernel+bounces-866697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B4EC00771
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39C0189BB76
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791730CD96;
	Thu, 23 Oct 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ifzfmThc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE330BF64
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215168; cv=none; b=WRDAOCjmGa9Rk1HXCliAs2LSJtASn4MoBfTO4ccz1bk4yT5dN95Bj2ZugK/Ns6Drcc1jfhVmu4mnzAIZ+zTIJ4B+4Z0McW9mUrlkmkIQXSgip3rAkTmZqV6/siGdKS8THEKwM7AOYC5Mu3dKZHJZ+nyiczsaR+Mm6OZhFbiXFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215168; c=relaxed/simple;
	bh=ieJ1PEQ6GbV1MRYhe9aHXa9mk9fDmXMMbeDZ+4DJtuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUuzQ6/2WRP6hNl6pzpBIDFePrXidA2zCLnibu7lt8QTxXlAfGO7eVaFKtk6kiHXe9KGrOeUqpFdWKHjgaje+n0vSz3WTUmYnTOpw76vHHO/UVGSzDrTnw/X0pipgy5h6q1VDDR04+i6v3a1kZCFGIUFS0/XZmz8B/y9Xte/4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ifzfmThc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8GQk5018500
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+DNR7aXOr6C
	c8NhWnDKFKEl9U/PHu41xc4EUdoSLJW8=; b=ifzfmThcG0p0X7YOEeUnP+XljfS
	WO2XQKlwqTnnXn1akur1Ic5qkCTs1RjnOJa3COpOuSgtppo6kSPxo8jWDpStYD8e
	AzJ2PAIpkTjRKTFivjHv43C15ycm6rN6X1c24J67Uj5cyJdP91n6Ytf12jJyZOny
	oByygkd4k9BdEzjvmufOBGBrQzyB2bZRAzDN49KVvBEuDIH8T6n9k0yH5w0Y4h9/
	I52MlJO9GBQknL+GNSFOa2DPB3qCa8b0DWuciMwTS1xCDyudKKnRAnXLFnoOJFrP
	Hof8GPy3F8hkSTMY2AXKK5ZpUhNrfd/Vq5k+wokt19w9sAzqF0s2kZ/ss5A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qhyws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e899262975so20123761cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215163; x=1761819963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DNR7aXOr6Cc8NhWnDKFKEl9U/PHu41xc4EUdoSLJW8=;
        b=RmMtljsR59qy7qDYCPYlf9eRSKkSHuU684P4KeFQoxTBpuVIBghMLI3sM/4s8DR2gJ
         QirYpxDKaLPEvr4+BE3pufCfhGVcBPbzb9mbEXgsUErqjfFyLPKrYW2SsjOsFPFX3HYF
         3tldrNY7UfTXOt2rhDNuMrGq8RHad88Zr0YMjy7EyA984ODZ0la0Z7+LQcjgm94w6nA3
         9/BFf0qUMc5V+HZZCITudStFwZbJgtt7xO1qhO9JGnF2SRf3uYIibvJC1PZjqeBRBNqf
         qbjh1DOmXzkn29I+NjcEnue0JlICB88Nv74fz4QBkpSE2mb1vMeLSdgNtwnlAB88xAX3
         gamg==
X-Forwarded-Encrypted: i=1; AJvYcCXTxn1tA1DrOtUC4HQ5B244yMi9J0nDmDr/MdMyWzfod4y/ZvW+aeyRu7+ZPz3zvpSAJgBTd0qCzzZ7ofA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPL4M+RH/ltWv0GKJ2Zl1BtiI+Aa2fbTx1F6BXTEKSC/gSC0Oa
	fNU1wPXSQkPpdDokZyhduRhhNa669znt/t6mv+AlKZhFwmre/y5Lx5S/4oMO7pND7bfjVkv14Kw
	jpfbsyH6hrOQ1re3Y9t0pw5FAosZjvCS4eAWa1yMWE9hoCFnatf8CfXezHHpmZtJwuUA=
X-Gm-Gg: ASbGnct3XDTJurfI+TXCKmh9S979rx1Liss++wSkZMYjXjd87j8ha1k04GU4SwIJr3j
	OOZRWmF3ubiMb0I2N9EW4G7YLXlw+x0V8b0VocU1vospwzVoLculLeT759inNKTlvtDURSIFt2i
	rszUNHIX8KUCc2Tx0Au7Rc3i1hI0NRBjjUdyT90AuIqXP3nm/t6dPtfKCjVgdV2BB/AlUMSKOSo
	5irUCkpPoJSW1akawNHwMUMQMqfpTkDJ4+JvXlAUrdeS3el6xeXnBjP/5dMTOz6cna5j6o/jt4s
	7yyeb7uk53GzQu94YQjm1Vct1UvXTpKeUspVDF8imrMfHhpekKPuxxa6V9GLxzKK1wzFjGjRmTq
	xYfVmzGlMK0jy
X-Received: by 2002:a05:622a:198a:b0:4cd:53ea:2346 with SMTP id d75a77b69052e-4eb81056553mr19376101cf.19.1761215163285;
        Thu, 23 Oct 2025 03:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGLrq11of8oaXYjc2gxcB149UaqLBVuJAPIgO2WDbhf9e7h/dtIgGOKVO0dmmn98IJDw5XQA==
X-Received: by 2002:a05:622a:198a:b0:4cd:53ea:2346 with SMTP id d75a77b69052e-4eb81056553mr19375951cf.19.1761215162837;
        Thu, 23 Oct 2025 03:26:02 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:02 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 06/20] ASoC: qcom: q6asm-dai: schedule all available frames to avoid dsp under-runs
Date: Thu, 23 Oct 2025 11:24:30 +0100
Message-ID: <20251023102444.88158-7-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX9bEiYg82iZsF
 LkYHEBG5iU/n7x7LQJqdCOZRsbgb48HWoFhQcXY73TfhqHSSfVopqd8ApAyorLz8klQVfUVStEk
 1WhD85wPRSo9t0/agL8QCp4qzatEpiWRK71OwRTSY7Wgb96GTioQMwxSr1Gg8eZdtpiyumG40ZK
 RDWvAo1JsHAhLPrMRM40Toa4m7GrjHSq0fA35Ow1j73NUq0OqL4QnHpfnMJm4WTht9kNinzDi6n
 pN9mhznJ+VdjarzccQ5EqktwIgq9ZgPWhKxr5iWwPsHtzxasUmWZk3xlA/ELhdpDFtcPQAlt558
 5pp3kdUp8O7XDDhVcK6KUjvJYl4Zn6Pt0ZlOlBaL8plVWS+y1miOoGwU/CYYHJWHSwPmM40oeGo
 Nn/lSU/kuOs7Nir1xs7VNppJBydtBA==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fa02bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Towqb0HgaKl9JIg5mcAA:9 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6MUZu2ez5gFCo6B3TVSB9QZkhq6NMUTC
X-Proofpoint-ORIG-GUID: 6MUZu2ez5gFCo6B3TVSB9QZkhq6NMUTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

With the existing code, we are only setting up one period at a time, in a
ping-pong buffer style. This triggers lot of underruns in the dsp
leading to jitter noise during audio playback.

Fix this by scheduling all available periods, this will ensure that the dsp
has enough buffer feed and ultimatley fixing the underruns and audio distortion.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
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


