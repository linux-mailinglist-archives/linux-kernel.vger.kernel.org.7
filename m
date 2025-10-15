Return-Path: <linux-kernel+bounces-854562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC25BDEB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29D0F505B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1036220694;
	Wed, 15 Oct 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lVA/PdEc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A781F418F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534294; cv=none; b=OSQMbMNk3P+5r3xyIIdMCa7PD4+x9qHhbRXmmJ04Bsi77HdWCzn+6lgPG5n39tDQSZKiTSvM/2HhwMGK3nXBzyPJmLYn8dqMCUjkJBEMndrL4NcemPbo+uSQ4yMinSCqx19OgONfTMSEBijipqeNWsiHXKQL19aSuhr8zRGATxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534294; c=relaxed/simple;
	bh=L098FDafS8pm9ObOLw9+1ZKs3tCLohX1/Ibu253xq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDv7vxoaJcDGd4S/ujt3CXouclFILWbF5Z7rKZzO858w27+jc17mzpALRx9/iqbsIEhkw2EaodIb3XC7FVNd8YMVkvgxAdS/aYzjIOU4RdrE7yNx9bYqgXTbX2jO6L53PBWtCz8cLwyetkiuMM6kcyFxA68c/SuXGgpFvU+gejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lVA/PdEc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAVLt5004003
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nnMgSGQvZWa
	892OSdBf3qcySVN9QLFS9/sViBiMJgyA=; b=lVA/PdEcyNkWadMnx9OhqO4b34k
	jBIKkQ0EmtxqrF02yhgh0lchJncIrev97kamcBArfQlzTTSTa7DyglY4McI+hL9r
	AHRBKdOTnIrGEdMB9q3vznQtJsH/NJmlx3bBfvyrsFu8RV3Wv/6dGZBnN2QbI6ql
	Fsmd6ZNaA3Rt2IRrJn3eqam5CZ/vaad/vQDlurKHBU7KzgYwl+M36qaq04Ek9ZQM
	742QX6cBjfAdtAmAYCDC2dTAr4zwH/Tl7bAk2/Q9ibmlBnTFNWO3GoRHIoIkdkmJ
	JUyCIt0VLDmvHkAkZzZmLogQyrJFt951G0r2KyvmmPtc+lYOvMcZt4vbMqA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwptcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-876ee102b44so32371566d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534290; x=1761139090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnMgSGQvZWa892OSdBf3qcySVN9QLFS9/sViBiMJgyA=;
        b=D0aqU8K/BKX5RX6BBV2WUrvv5O3A3SesfxXhxbJMptY/MXvcZJYIiOunlzksK1fGmi
         kEvq6SdDXdQPNL3OIpI8F+EIDNYhI+VIDJeRmf4adavqDMGXE/PSTo2E2VFCDrMWxTGH
         R13PIuqqZKQe1JBZZZDDoDxOF2SxMmi1qSFeiFj1yBuHTkd2phOgzs9Y5wr1JdtexMs/
         9rxtrydjW5jmCrRSHscFqPi5rS0rFarjFaFsQXEbZ/1jJzR8Q4HBdCVUOv6vOlaBYdji
         J8mf/FxQAd+hujiXVRDg31QNJOA+eL2MQL8E7XC6kV32Wl1JeKg3LoYiAhGu+4Q98ZYb
         Q7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMnOkG6QvddExQRuyZPRlfrhUKGLUs3tZamp4w8r2pxuLZTJk6tSb8FgyASwaBIrTA5+DLY4c7kI4yrQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjnL4sTWgPpFsmnypwWmKCBdbL5J8eWlXsI2NE4mWKuMTPJoP5
	3+JMvBvMAzrEfhky9qx/Z8Dr+kxaLaxnzuFR7lkWl0No7uVqvrgfGuKsK1izaRN2H8j3EpJ3x1w
	ybx85BF8WsJC0QFVJFccaUSxXOzz+p4PrwNQ5i6sN8SisQkCYEADJIypevF8pv0JFkDY=
X-Gm-Gg: ASbGncs7NiLZwv9UxqL1f2x5u2WvPgBav8EKkCQ4DtWVfp1K6s9ApRBWVYDR2a6l9yH
	6FRb1IuhJ4qxo5OSiU7xnVED4bs7qAYz6+VxWyTV/0z03TRv57UHVC2jzBU3fLBfBYj2w3i2ws5
	j9NazwH1zIdP78OEnmCIni+Y89JkwXb7F9CGeb+KTtzz/qYkmCYmFVFh8HSOYCiA+cutHm0hVTE
	VxZr6UQHAynABDLs0oZxrr7hlZQiFX9pIW9Syg3mpLp3RrtnnRIH5VEUOyOo1MVBRdngelB2dSw
	8teAhX0tk5xe6tf6GboktAi2ivDQc7MFldb4v2Rf4Bo4uAUcGyreHw==
X-Received: by 2002:ac8:7e89:0:b0:4d0:fbd5:4cd7 with SMTP id d75a77b69052e-4e890df9b42mr974761cf.16.1760534290529;
        Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQPK/8F9/L9WtmiMGFpf77cZuz+9kWatOyQjFPz0hd1jWTnhTVvG4UfIIpB1jflL+E3HXJNw==
X-Received: by 2002:ac8:7e89:0:b0:4d0:fbd5:4cd7 with SMTP id d75a77b69052e-4e890df9b42mr974021cf.16.1760534289820;
        Wed, 15 Oct 2025 06:18:09 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:09 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 3/9] ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
Date: Wed, 15 Oct 2025 14:17:33 +0100
Message-ID: <20251015131740.340258-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX602tnYQ/yJzk
 dix1ZvOJU5qvgEjIJaUSuHSGE1KH7qWSqT10YgLuB1NPUokqek01yfu5j8CRhab8njHsdYuqMSr
 q7hJF2JeWCOEh4vDIfk078yYXXdJxQytxXsruV1A3qPGforCzPYJo6EIM/fzSa7eMiR/LrLeyy0
 H+7mugmeMrjziJC8Rlk1JAszJ734nV0cs7MfdW88EhObysqfMhy862LEKk89xV5txqWVvNmIjbk
 jLy1xG+CNtL6vGDwFpmluy+4dwAwjxnVBoDailXm/ZwcgToyuAS+ylOkRVgOh3AzloV9b75aj4R
 PlioA24DTIS52vyQ+5/MHbCZlNb7/f420BDOFWp3Mq3ejVcgxfxH30vdsDm4c/a84UHogOawY2W
 ec8GEvz/6/sPqGSbPd1QiIZKac5e5A==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ef9f13 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Ubk33e6zxpvlPXQfVdEA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: a4UYvXDnuvV_U3rvioz5ewdEQNrvXuuR
X-Proofpoint-ORIG-GUID: a4UYvXDnuvV_U3rvioz5ewdEQNrvXuuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

DSP expects the periods to be aligned to fragment sizes, currently
setting up to hw constriants on periods bytes is not going to work
correctly as we can endup with periods sizes aligned to 32 bytes however
not aligned to fragment size.

Update the constriants to use fragment size, and also set at step of
10ms for period size to accommodate DSP requirements of 10ms latency.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index b616ce316d2f..e8129510a734 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -403,13 +403,13 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 	}
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+		SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for period bytes step ret = %d\n",
 								ret);
 	}
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+		SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for buffer bytes step ret = %d\n",
 								ret);
-- 
2.51.0


