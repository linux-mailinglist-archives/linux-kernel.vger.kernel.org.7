Return-Path: <linux-kernel+bounces-866693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D278C00747
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A57F4F1753
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFB30594E;
	Thu, 23 Oct 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4Ujkerf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652C304BBD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215159; cv=none; b=o4qCfgBJe1C6/1dAVonIfydSrICn40Cx4elfIFWua2AyIy8uRhfiGVvyjrnj4aVRj4+eUJFtWYzrAUno4Mefz757e76e+Nh59wLEBHQoIg75RBPiryfir6AXZwv21oGZ9H4CaRFB45IOqvtG0xXOsNwzUUgEZlzKw+d/iltJdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215159; c=relaxed/simple;
	bh=fKU+7psoGKhGov9+abzdK9VeiEyjPMI2pGqzhT736sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qx7ILr1YZV+3y9zRV9wAvB2At5l/UrdhpB2RDdUfnUkTcjZ0uqMWSwDsz3j7F0NewRbKWIH7vghwchpPApnU0w1IQX3gyXKzNxwV7CwqlCkFco9wlkC2tfJXFRAq00URWV+ofbyBKo15S622x2kuQRggi9OhNnrbnaS/1hwpxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4Ujkerf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6MC8U007454
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HoHmVwgfwgY
	ctL/x1k53Df3AjUPsgAlOxk1+AKZybp0=; b=b4Ujkerf3On4nYtoUk7dWUASpse
	yPsTwgbNGnrJnQ02X9yZicsJahmXpEmnZ92+btcP+7Q1xU0MnviixhFsttF1M9wU
	TS8O2UMWtZLOPdD0qXAfTOL8URC+oijTNvwUU132PDIXHH7VRxuauYNJF2/ezJ2N
	FBoSta3SRwhqaM8PuDT2nM3ND1QNnys/Q9J416yu5TITF7bONhsl6P1RFjAFtkqr
	CMwLOMWf5kLdhnG2IByI77GmffT3aY4v1Z9rdfRfp5bjpKWDLc0AR7M1SIvz0p5n
	Q1kFRoA1B6V3We8OMuNAP4PL6SUtxV2BOVm9rSd5tomTmMFv34usgQbciGQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3448395-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e899262975so20121201cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215156; x=1761819956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoHmVwgfwgYctL/x1k53Df3AjUPsgAlOxk1+AKZybp0=;
        b=Mu273C7k/deNXV/iWx3jjPEa5IoI3tsnwHX/rzva4Oy+o3lHoclTbrnbmJJY7PC1ci
         6a6O9eO0qIapkKOZqI67fpkAkiCdJf1Z72EyXWETpn/va813B9ab8vX9EvFHXEPJfwzI
         EWAxuXJWrC9hS9xgoKLkIzZ+3VS4xGf6OCcYKqCH4jWnlBvF/2MZrXg+pTSA1RHUTVN9
         IK3nAK2MWPTkyQYIiLc9dXjx5Dv483rhjQNOELkcDUZJ6kVLQzpaTQ8N548nn0SZkSaW
         zYl/MFavKvn/3TLm4W1QAqHsqF5zLCEEyGmpe+6SDgT7AKnheM2HknnELQovHnKoO9pc
         iVBA==
X-Forwarded-Encrypted: i=1; AJvYcCUMuwPwRu2n3aTs3tbYu2CLppLbaGO/ZWyssTF859Wr/Z6U+Tp+9j2mTRaW8cZQh3LGYyMpzGCZaBEZARw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiMimku9vOHm+qqTSOWQlPjJ+tWXysP1SIa+zVUZP5RPv7RO5
	s8KuoVUF4JhTZV5O5io9k0TDmwHzOCO9s+NKkU6Qxp6YN81cLYjjOYmRY5NUQT1lpvQI1tCrV/x
	3DrmJqsNClHqvOQh+uiCTSBC8Htpt/H30dbHl0yj66bUV9kn7dPCHaUxIrAxUcul01yM=
X-Gm-Gg: ASbGncsCmJCt+1U2/Uu+LOO24Tu4dDp9NcjZXkQydUQqS0IJeIZ21cZigJVDR3ul1Yr
	JtTl4oH6YcO33WYwWRiqIpVI7xEtSjjOgMoCZPKkCeIDwiooWFMgU0iR8sJHgym79BCTyL4zUBg
	UpJOmgKm+XcvTX68CdR5iQnuOeiXHqC50xDBEJ5TNsqBfgyEqNQ/aNK0VcdLgXDdZF7mtbirYxs
	5EBF3xQGEUBBmCfqNH6tE1gN7DQ4+vZJ/vuvn6W/iYNEUxY+8Yy1EqNY770pw8jqpApqRkxvfRc
	+UcCILAmaDKtlzonTpgj/xsOtpeqB3Q6qkoDRLe/yGQr1xXKGeCKHqlrrHgQxvv5oPGgM0xXaj0
	pXx2wqQemhfOH
X-Received: by 2002:a05:622a:13d3:b0:4e8:a2aa:77c9 with SMTP id d75a77b69052e-4eb81020e0bmr20467381cf.1.1761215155873;
        Thu, 23 Oct 2025 03:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4pmDb7EjDueb6982IesIBCCpfc2JJhwDrIZYFugXpp3Mkd6MdhDM2CIiRAZN+L5enEZqEDw==
X-Received: by 2002:a05:622a:13d3:b0:4e8:a2aa:77c9 with SMTP id d75a77b69052e-4eb81020e0bmr20467131cf.1.1761215155423;
        Thu, 23 Oct 2025 03:25:55 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:55 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 01/20] ASoC: qcom: q6apm-dai: set flags to reflect correct operation of appl_ptr
Date: Thu, 23 Oct 2025 11:24:25 +0100
Message-ID: <20251023102444.88158-2-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: Lcm7mpYkFgDYqy1pFVm6Hv1ycGjMhQ8X
X-Proofpoint-ORIG-GUID: Lcm7mpYkFgDYqy1pFVm6Hv1ycGjMhQ8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX0sgMdM8dflbF
 +7lEchYJ1jTsQMk1O+0m9JNEvFgut7Zg4vr5h+QoXAMgevCXI1+ewIerL5XV5UNMnpjYLVAI2bJ
 6ri+GExRxIO0jqZs8dowt1YVfD9Ep6a8vXsdEof3GydxBEcr47NEyLi4iL+QEdVi8z3XvyUrAsk
 rUD1WS7WLnOWIRllkSkKG9q1FhqT/qdKX96LHUZ4ZmmksIznuoWQHJiFi9s3Gjyi6vHZe5yC44D
 VqHPlVwxzrYeUsNGNhWPHJV8GRYIaZb2mDTipp+G/buo9X1XbbIL7snEiAvZugBX+GBFaIzo6T6
 SB2AM3CRYRKFegKlNi3o7VbTVyv1PSy2ydwzNPlE0ijPRFsr7fl3vSbqVFhJ/HxDBhR+4fpVug+
 1JvhZEFzDpDThaABnar6adx4d0a6tw==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fa02b5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=-7q2M0jigxX2LbQM1jMA:9 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

Driver does not expect the appl_ptr to move backward and requires
explict sync. Make sure that the userspace does not do appl_ptr rewinds
by specifying the correct flags in pcm_info.

Without this patch, the result could be a forever loop as current logic assumes
that appl_ptr can only move forward.

Fixes: 3d4a4411aa8b ("ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 4ecaff45c518..786ab3222515 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -86,6 +86,7 @@ static const struct snd_pcm_hardware q6apm_dai_hardware_capture = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_48000,
@@ -105,6 +106,7 @@ static const struct snd_pcm_hardware q6apm_dai_hardware_playback = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_192000,
-- 
2.51.0


