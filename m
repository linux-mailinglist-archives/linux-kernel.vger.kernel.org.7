Return-Path: <linux-kernel+bounces-854567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E55CFBDEBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2D38507266
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D291225487B;
	Wed, 15 Oct 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eaMNKWYk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A023957D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534300; cv=none; b=L+gDH0vkHzUCJu0B8BmlqdboALhGGeQAtGdrhIuuZV8FIdu1/lQTjNRED6JuFmz1DfMHZqW3eiSXoWMxY6qmkMPGgw5NjGxi1PqtBso0nGb46jSzf3+1CPkqndG+TwACrhT73TjRIn9SQE0A+oAToeFMw7yTpd0RNAB83AiVczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534300; c=relaxed/simple;
	bh=PF8KzK7QUo1Pnp8R3uu5jVDc2qztm42DD2eaGLKLB8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr82fCTf5Y+hkqUk59G6V0s2YyUMJCnCPF+bV3kZ/nkG3PXkDwuJS+X2fJzTUMhIw2NtGjLy+dofAgDi9qIIXcG3kVpH2dWbSJI7LyABZHhjnWL17P15ToyrLA+9VX1YL3SSpZEEFwSRGU2iBaZiCHJ5suVK3kqTE33o3Ay078M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eaMNKWYk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAjK83005021
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=siHiEg0ChON
	De0CD1JcwzaBFof10K1E7cJD3IESL4/Q=; b=eaMNKWYkF6I6aWt8cgRya5gIy2K
	dFimXc2SE5MVoyTR2l8BY38gxHp9zfJc+UiWumO4VAWx4CTfWP4ZFuj1vfzJSMro
	HddfFiZTaXjeMtF45/Wm9krg1/V7IN3soUhUxHA2WF/WXz0pjoZQ8dlTeQ1nzK+s
	fCSgxTucz32XqVrm+gNpNHgEBHQS/fZMSfwlxoqhEXZdzYjanMWhiu1RxdMC2MNr
	EoRBvatUFFxVRx+Q6/YdvE+prw5ps7N3Ngxb73TM3UWIJQ0W3b9P7CiLs8rvTP+r
	kWGAK0xxJBt2DZGJuTIA/dX/6/Gv9xkQ3Jose3l8vaJgy2KQVrQlbi23iJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg4c6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88ef355f7a3so65453885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534296; x=1761139096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siHiEg0ChONDe0CD1JcwzaBFof10K1E7cJD3IESL4/Q=;
        b=HckuMhdznYIn+t6h8SjgVSFZLKUE2Y+Eg7RfZOMeA4jJfT+oRdETAJDz0NgzIBaXkN
         CdBbjb6mGCZ+NtEB6QvUDeRWg8RCUmWcTCy3pZseC95op3hSlFTwkRFuJMY3l3QL3FpG
         QXlIuDhBzK5ztrWkL4CC0cqQ9QxrRJXMb3/ZhKrnOPsYIz4T3qh5hMYVKrPAHrRfnTTx
         zjivkWvV3yy6mJ1JTQN2qSMYs9QckFppx0mTaVpyKupVubNtuB8aRApXK3kgyRGIUajQ
         XoFM71ZIt9NI2zNbU8qHpHkbQFi92EuJcw87kyXSx+IAVSj3HkA0PvfOaZuS1d5RU1hA
         DJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxP0HZCeHfm7I6e17InxazV4I43StXwfD56dD0aQ9yHtoGis3d7RcXOIdO5crRNGWQWpe/wgCBjxAUsQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAMEhbrryAHvgO0oygDEPBzjbDVsYQ0VW8wcoIEM1aQgZfSlg
	ClOyEyUM1GHPTmPqPyw5ufjTGYLU/gaNujz+1CezOK08hkvkZ0gJhTq2UtAEV627tOshPDtRPyd
	sHzMiC1tJ8e+WosxPscQrUyBBkZRlt2AjjFQaqDO8i91AJwSd84EOkIUKr5ZOT0t2q4w=
X-Gm-Gg: ASbGncsxz7uAnN7C+DKioo+QHorA0tGUwfquCtuNQ2FLlWOQaL//tNcDwDXgBzmnx3c
	6KjcurI5d5y9+aYad/fVsZmrpCnJTG4tBOhCkI8S/hA5VgggEl3hBwqIBOZ77dwAsC4x+oOnjIC
	FONP/wLi35WUTH8xPxOsJSMonBGd0hI0p0GTovXhFGGIHRcOQv/qVWEA+FiPrwEB59IkUPUlC6N
	L8P2MudWwp63nW7LSSUmceKJLLLudOJK0eCTZ55xf4Upv2pQiFFhneqVUzAvSWlLpk1X/U98iVU
	DdStOPi7O+UQ5NMchcpi7uKskgBpLjD0wtC/5kv7ys3N7SXfztU1FA==
X-Received: by 2002:a05:622a:30f:b0:4e7:222e:6725 with SMTP id d75a77b69052e-4e7222e7357mr143718111cf.8.1760534295405;
        Wed, 15 Oct 2025 06:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0npG9+1zbTGtTaMbasPsz8fCXlWoscmPo0jpNvyvC4yD+pVmLW3dGwrcnf6T/u6dz3SeqvA==
X-Received: by 2002:a05:622a:30f:b0:4e7:222e:6725 with SMTP id d75a77b69052e-4e7222e7357mr143717161cf.8.1760534294610;
        Wed, 15 Oct 2025 06:18:14 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:14 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 8/9] ASoC: qcom: q6asm-dai: use q6asm_get_hw_pointer
Date: Wed, 15 Oct 2025 14:17:38 +0100
Message-ID: <20251015131740.340258-9-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXxm6XqwRaScMV
 e9PfEEnMPZBT6i/MsQEexr8WqnL84m9Nc2BCdcr/lmkooqfQWZHg54ILoVBzkHYN9fZndsYxo7a
 pdqCoG8UH/8kNyvxjlrRiwWbw4yfJVsH5ZO/wllOEjXey4Btj5mVVg2T9BGNP4466hTGx35GgwN
 s0/rEQVGovfPGBYTRA1xnmz8B/lcR+4zva0iT/jq0AD++tEdEBZtu0nfXOtQCwOzjaw8pymyRSq
 rTyl13NmjkG88hhVvsjwkEP//AVdBZ3nl5yIsMaq5LxUpeSaRzxMJdAnyl7t81sJB0fC3vpGNPX
 +yNoGCl+lGkDuAU0AePceL8IR/zlTHJiKuibypzH/Cp9E7M4BaHs3K+CDRwkTo4qy+Yn6nRgucD
 AbEHCI4iQxxLn3eur/kCjJcfe0JfkQ==
X-Proofpoint-GUID: Ov8y9rJ69gvIYnxA6jz_ZzXUX0y5od-h
X-Proofpoint-ORIG-GUID: Ov8y9rJ69gvIYnxA6jz_ZzXUX0y5od-h
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ef9f19 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ngjuI6RAwNlUvKc_ZX4A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

make use of q6asm_get_hw_pointer to get the current hardware read/write
pointer and remove any additional code that does calculate this manually.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index db2ea8973ac9..c2a33d6a0827 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -58,7 +58,6 @@ struct q6asm_dai_rtd {
 	phys_addr_t phys;
 	unsigned int pcm_size;
 	unsigned int pcm_count;
-	unsigned int pcm_irq_pos;       /* IRQ position */
 	unsigned int periods;
 	uint64_t bytes_sent;
 	uint64_t bytes_received;
@@ -190,12 +189,10 @@ static void event_handler(uint32_t opcode, uint32_t token,
 		prtd->state = Q6ASM_STREAM_STOPPED;
 		break;
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
-		prtd->pcm_irq_pos += prtd->pcm_count;
 		snd_pcm_period_elapsed(substream);
 		break;
 		}
 	case ASM_CLIENT_EVENT_DATA_READ_DONE:
-		prtd->pcm_irq_pos += prtd->pcm_count;
 		snd_pcm_period_elapsed(substream);
 		if (prtd->state == Q6ASM_STREAM_RUNNING)
 			q6asm_read(prtd->audio_client, prtd->stream_id);
@@ -227,7 +224,6 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	}
 
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
-	prtd->pcm_irq_pos = 0;
 	/* rate and channels are sent to audio driver */
 	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
@@ -479,11 +475,13 @@ static snd_pcm_uframes_t q6asm_dai_pointer(struct snd_soc_component *component,
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	snd_pcm_uframes_t ptr;
 
-	if (prtd->pcm_irq_pos >= prtd->pcm_size)
-		prtd->pcm_irq_pos = 0;
+	ptr = q6asm_get_hw_pointer(prtd->audio_client, substream->stream) * runtime->period_size;
+	if (ptr)
+		return ptr - 1;
 
-	return bytes_to_frames(runtime, (prtd->pcm_irq_pos));
+	return 0;
 }
 
 static int q6asm_dai_hw_params(struct snd_soc_component *component,
-- 
2.51.0


