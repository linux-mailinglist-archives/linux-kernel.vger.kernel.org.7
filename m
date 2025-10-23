Return-Path: <linux-kernel+bounces-866700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4EC0077A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93D619C4D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF630DD20;
	Thu, 23 Oct 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lk7MBXq7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A751930CD80
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215170; cv=none; b=nOSbHxNDxyPJ++BiGph+ZAScOsPld4zDmC4re+XZZQzp+WsKgSvYo5NggfmPW8kmMUlTL4rL+cVBGqsB3F3V/U+IvmyGBM5HWKyNzusiXJMN0KLickoBSbOd/v6QklFNWzdPIatJORWo1pDbidbpNammwWKtD3qC7NwcPdY2KL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215170; c=relaxed/simple;
	bh=tFt+bVXUcHDK5C0sY2xTPU6k+atp8RIvt14CRRC4kxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zka1t7xP97EDW0l138KNHDXzkhJ/bVl+QoXT1MnbDzf51K92f5LM8Ws6roKsJu84MU4/E/6hfwvgnIx7P1mv6K1R1wwaV6yEKIY1dFg15ymK+BTmXnOsxiEv3G6c463kXg6VAYlF4TTq80kysOXrI6HjISu5CazLqAA1pdUMjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lk7MBXq7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6WcrR015966
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=icrZGM2TvKV
	a7LlZmhEJzlmHF8JdB/JFgQoOJEUzghM=; b=lk7MBXq73GZvUNxRKLjjurfPmGn
	yM0TOiSaEzGJmhX/N9ajr70dmXLhmWCNhe+1O7VQWLtx0l9gwAf8YyWUX+ONbMLK
	veudsgdCUl9OVzNoKc0SjejlZDxBvF9QC/NdsqCC1JGA5HCNtttSbRJArJNmYpLD
	x2SX2MA64K5TIjC94Xf1t6ai5LIfPZZPLXyzvyeFW/I5fEIT8v++Knr6WDEoEsOB
	aDASu6+OCdvfc0sayrIe8mPI+cl5RQqhOLkogIBzDJ3KIkhgOHr/OweHK6kr6ifp
	Z/berLnbEipWxGj9PwC/HO1VOEdQV5+4WRiSYS9hbjKHPOfsvgTJaoiH3yQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsdmux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a387d01bso26940361cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215166; x=1761819966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icrZGM2TvKVa7LlZmhEJzlmHF8JdB/JFgQoOJEUzghM=;
        b=KNPSwc8cj719FwdGOZ3qGHORU5j6DfRvZ5s+StpjNGC69Lq2K72FYTuEH/ZVuYZHNS
         Qs4GcPGZSYWHgfsr0+O9ZUR/+A3eoA4r6g0oNfDKq7hJv+7P3wtcCPJHoBhKSijamdYb
         oFqb2V5a2ZDaCAyD5InufpUUi42KBLZhVd7KZ4QYZwucr9MqAi1iDTw7uSNijF2Ue0lX
         Xp6Xee2H+dcO0tzGOVTJuT7TsiDTCJKU+s+hjzS1ScU9i9q5fH2gouND+g/57LrGqaCb
         cx+J96LF0XATQ5N4Py3qZhPRwEPWKtDp1EInyrQPjehF7iPtzB7tNSnTxxmd8y7DIAHL
         qdGw==
X-Forwarded-Encrypted: i=1; AJvYcCV+9l3gE/pPCmxbPueVjJrfiK7gDRnC/FlWZtrColO2FdDSWuURbdDzHNAdGDnXfu52pnxY/fJdg245pYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEIj3Xuh31ZDzpxv+0+Xk+ujG779l5M7BflorMOwMGlCwqSgN1
	TgNK5ZNB3CFrsiYIs1eBuhTDsfVatdiXdOwmJCi8ajXwy+bC0ruetVjp+Peil8/kPZFcFPiDsFA
	ScOe/+bD/gjWrHTQLzp1dIvLZra11STKwv6wHxKKWWb01FeDep9MaueXUFalMzlvQTxA=
X-Gm-Gg: ASbGncsTNakJlFlWhF99ENGY0ubBcuUgspno2dTTFJRhh/naXHl/Kcbmu/CKs1nS/Xs
	qWPj8j13f/yMGAIFJ+QULh+/HIjqrP3ul1Sun/RF4vjl0rmJB2nqVpKzAFqzjDXfb9rX9XdI4lu
	qHKAejlHoJlXDgmSHlx66MUd9CXzU5OBNrh3ucDY4s79Zf0zDL3UgLlDTCXQsvoA9opaL9NoDi6
	vCcRkkZc1kCnqtEMPZiTVENudqQvcaYo2N4NkRSmeJc6KNpKZaZ8+Of08OhtKS9Vf4ILbCbc+2L
	N6bVG7mnP+LmBxg7QWHgqX5PCRfQCT/+P3C6csxVDYGYO/xEYtno+PN64FJPdQ05bL13nJ3cDTC
	d8WFTHc8DCJyg
X-Received: by 2002:ac8:584d:0:b0:4e8:a7d6:bbfd with SMTP id d75a77b69052e-4e8a7d6c13cmr270609111cf.81.1761215166430;
        Thu, 23 Oct 2025 03:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE1nUb2mvyUJPcGAqiOlIO452HBSW46UgTgNvJ8RYJBBPoflO3K2RftR1udb7Nc7r+XaEXrw==
X-Received: by 2002:ac8:584d:0:b0:4e8:a7d6:bbfd with SMTP id d75a77b69052e-4e8a7d6c13cmr270608781cf.81.1761215165718;
        Thu, 23 Oct 2025 03:26:05 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:05 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 08/20] ASoC: qcom: q6asm-dai: use q6asm_get_hw_pointer
Date: Thu, 23 Oct 2025 11:24:32 +0100
Message-ID: <20251023102444.88158-9-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX16Qcy9EOOdQP
 Yoy8DzLSl2Jdfb/GjgIJeafaKjtZK6nBkZ/Z9qNneZ08Dhjgo/qKPHQY3CKXG8A3gLQqaw+M0x3
 bfUybF8n5X7kKJcvlDDSW/UGRsz8jNn4kwN2IfAG9XNtBYtjT2X3aBzJa3Pc3ZoEYKPgc0SliM1
 F3F0PVr7WFURTL/TgA1JqOqbzZWf6cy5GtHOVBD7StGTprv+pK2DKmqXuq1g6LebxjsqU0ZxjWy
 WAfWhMbWh5nJrIeM+Cz8+eCOIHO9cpY7z7SPlImHHKqtGIdeopevo1sfVNQCrrOXUOqoY0AiOZk
 vqd33YxM1oG5/ODDijAd4umyR1tvkRgG9o79SRFm5i6tNmIzil20pytCA+6lPowNS0fDRAyTk8y
 BdXE7eUm8rKwuxCywqLOdfnJhYLaKg==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fa02bf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=ngjuI6RAwNlUvKc_ZX4A:9 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mX8ZW5XvNa9jmKA7xE7XEyuiYHNrv4RH
X-Proofpoint-ORIG-GUID: mX8ZW5XvNa9jmKA7xE7XEyuiYHNrv4RH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

make use of q6asm_get_hw_pointer to get the current hardware read/write
pointer and remove any additional code that does calculate this manually.
As this is redundant and prone to errors.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
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


