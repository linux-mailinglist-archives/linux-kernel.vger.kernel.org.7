Return-Path: <linux-kernel+bounces-866701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05769C0077D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDFF19C73F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354330DEA0;
	Thu, 23 Oct 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iomc0Os7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371630AD00
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215171; cv=none; b=oYs6yiY4Ont0smu2E2wY1TOyYBk4H3hVEcaOzdLRRXg/5KL1rKU0armwJb24UuWko8a+tqUEsDbKgPFRIICGHxOKzrtr0b9ZrR8Uxb3NqnIYFI1ZcgcVO7nyhaSOnz4B8L3YYODCix7fU/GirBl2bnHSKi6bZKZIQj/JdVMVkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215171; c=relaxed/simple;
	bh=Ho+pHLNPuBGTxEcdOpWIcJ1rAWSMMJmSaq1j+jlK1u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b88mtR4MA29m/cqfriJ2CUaZPA/NiqxZr1aAVCI1DE9riv33ESQXvR+OIzgSChFr6Oae29kIz+KXI6uNYvMocOfz//4zXRzN5JWmZClZvyaPywb4od6APJnw6QE8h8HE7X/OZCGSYGa2Nm5Fn/QE9r6vOPsnypsJy0hW8Urf5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iomc0Os7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6vxL7018580
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yorz58q4zez
	HFzpZuHNhxtsCwlML/Ho348mBn54m9pA=; b=Iomc0Os75q3z84ngyHy02jYDMWY
	J+etAGqAlzSByhiyUGtskPKC7LSpUAgf8jUppx1xARPj9QzjP9Y64XgF4rqpZMc0
	8Ha8OyePQrTX9xKK2Ynq3tHXP3UiRgz1LuTEa2tEV89XpehX1Ap3TZsLcmoH+fbG
	KWOWQihmH8moMr811ecq3R8bPOaitCjTZvF1pUFSwxc88SpOAKNk+9CpYU5AFIpr
	JdrGrGukEv8IiYEmBTF2LMcqDMkS2lStcT2zP33AeumjSHzlAJl5MRsXws3zGXuK
	6biDobV3xlaxcdskvV01qpk6YnRAg/TnL6cR1q0cJxJNB+Nfyk3V+Mxj7RA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pr8k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e894937010so18238471cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215167; x=1761819967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yorz58q4zezHFzpZuHNhxtsCwlML/Ho348mBn54m9pA=;
        b=VXZhK06wF1XrZhf7iPSCDk89XuuuLXcWEYHKpc6qbb+7asHFRFTwrGjvNU9tbT5yla
         D98+LzKFMjLQGlOvIX7lsLyhJKFm1gh18hEjrbunI8IENax1Tre7jX2CbDZVy42grDAY
         JxV1oFUmYPhb2WijtbYaVQF/rbY8oUtuWKv4GsMHh1hui314rGXdqojK/sem7WOs6Rsb
         +vhOZs3tsG4aXSRzhXcRlD1yAkVI6yUxbC0bToTCjPywmfDsnmFeh3DrAnPMPk/JzEda
         S7CtBqhuK9XzSIq9KFFfrszwBS4yZbCrSAu6JyLUV2HtFdy2Jm0oSnzuc2g1jeCN1/IS
         otmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIZecrPyEs8zScEthcfazvMxFHL3JICEatl+1G3BrdfmmmHfPFItL3dnmgT+ViVFmaeSro8n4QpL5FF8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDOrXityjF/yn++pDvYraSsZ9XXdWzUG1oTwVOH5XxmLBzVce
	EO8nlaLRvX4QE8zexRN9ObZsI8oDXVziXm/IqIF+Dkr6/FIB5s2lAryOfttEn2uNfjhJiMTDGT5
	jLziAZ2aUJqW28TXXayrScRlmCTmWV0Aao4YrVK0PaHWr748JVNvjxICNxCIZe/pWvhw=
X-Gm-Gg: ASbGnctjq+k7WbBMQ5By4Fa8KPCAlU49PPfqe/DbuOFVQ886AybDxVmJc9kbvIe0X0L
	lJd6fSWqN88SXdK1Yt6bK5aneSCgLrK4CkGZWfWTygh6hfxdZtShhyCXBAVUuod9kKpZTleY+Tr
	8BXqzrJEot04NHvdgMGQ/mpnw83dczPsO7TeD7psEN7XgjX0TRQW1sPIF4vpyHwdrliYrBh00OD
	OBjiebxtrIrhgyHqORCBb6m7aWvW6JHmNWIUmpfMD+Q4XpJTwK46fHJTf6lKqOLLiPkQ5XvOcTo
	SONfMSpgStv+EINIqKcwGIJvbTBdHqkSQhSitHsOFkS265LemSJ2jWxVPjTzACnGeMSBw/vucQl
	s+PtO1ss/4q71
X-Received: by 2002:ac8:7f0b:0:b0:4e8:9126:31d0 with SMTP id d75a77b69052e-4e89d29843emr321791791cf.20.1761215167249;
        Thu, 23 Oct 2025 03:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv+JYE9Zd15gWAcYaYZ3ohREdQKKaD4jHY5oAkXcks5K8suMhMO92c4U7oNzROY7XUhKFiBw==
X-Received: by 2002:ac8:7f0b:0:b0:4e8:9126:31d0 with SMTP id d75a77b69052e-4e89d29843emr321791521cf.20.1761215166796;
        Thu, 23 Oct 2025 03:26:06 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 09/20] ASoC: qcom: q6asm: set runtime correctly for each stream
Date: Thu, 23 Oct 2025 11:24:33 +0100
Message-ID: <20251023102444.88158-10-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXwI0rEtdzo87j
 U1W471eWCHuvG+y4PQiq5EmGc7smv1A5FcValtKnHFpuYZnBBpnCwm+4rssBWduhjjDLi7ZQ2vc
 NPQVZ5a+yqQG24jHvUV76fqrtGxqQsYA1q8iq/wjtRWQsiG7RgvXe6uDfULoykbHfR28v4QxWBL
 eHNJj/CzkZs7iG8Jd0zAY3UVfLbIM754+8npbVllaziNEV2hJdVbMRWgzqPljpM4ml6HCgXQl9k
 w+ImyqErqXf5egssI2T5c2ST+iAZU9HS08spePmkvx5u6ogUF7NbkeTWD7vUbztXqCYsjbO43eP
 h/arUsecjAAUQcKJFOwG4JTmKKJesuBkkdY+7kG2ndH6Z69OTrnUD+GwEaoBlxsk2gTqH4p6Q7R
 BSg1V/RdkNy8zMXt0E06ajJezlaMBQ==
X-Proofpoint-GUID: 0Wc5k4uaSTw05eDQSF8IM50BxFnbQ4oU
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fa02c0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=KIUBPGGZ3vVIRF5Z0fMA:9 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0Wc5k4uaSTw05eDQSF8IM50BxFnbQ4oU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Both capture and playback can have different runtimes, so set them
accordingly.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c2a33d6a0827..97256313c01a 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -433,10 +433,13 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 
 	runtime->private_data = prtd;
 
-	snd_soc_set_runtime_hwparams(substream, &q6asm_dai_hardware_playback);
-
-	runtime->dma_bytes = q6asm_dai_hardware_playback.buffer_bytes_max;
-
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		snd_soc_set_runtime_hwparams(substream, &q6asm_dai_hardware_playback);
+		runtime->dma_bytes = q6asm_dai_hardware_playback.buffer_bytes_max;
+	} else {
+		snd_soc_set_runtime_hwparams(substream, &q6asm_dai_hardware_capture);
+		runtime->dma_bytes = q6asm_dai_hardware_capture.buffer_bytes_max;
+	}
 
 	if (pdata->sid < 0)
 		prtd->phys = substream->dma_buffer.addr;
-- 
2.51.0


