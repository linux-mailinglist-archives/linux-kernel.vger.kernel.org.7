Return-Path: <linux-kernel+bounces-811440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47DB52914
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAC058043F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AD284674;
	Thu, 11 Sep 2025 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcfhArRd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94285283FC4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572610; cv=none; b=Zx6Z4DIv5wEbR2hs3IR8xqp6YBTNtaBmHFruEGsBi5WN4WsOoAzr9YiDM5urTxuHv10WYGWdmfxZqfRlse0tsYQHtM+OEdyZtB/EJxb/ysoT9zHYwJFSLrXufGVgIjVyiKpAywAFb6hoDElQqkTNjqB9Rs2RpaG1+QzjPocY2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572610; c=relaxed/simple;
	bh=z+gGsuW1nP7yJtlnfXfDq453MF7xeDeN/7Bqp1rigus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYGxVdFHUs1d4mPC8A9f2tfbhcQvjyXG6DqDKKyvMkr38+k01/R1CHdyfN5/iwdavTYKq54nwHeOjDr4uUUNuREiA3n+BN56or4pralzM6rGgnEuoxiHEMPfYE08hQ3bONu/XqHsaXfAh+1clro1SRPu88izWAObLdb7gHsZ7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jcfhArRd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IvIj005760
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q4ORjV3h/Ug
	G8t1QXMHoEv//ijDc+HhKRFWyrdBcOJg=; b=jcfhArRd2NIdgBoVrwL3sdrqqwd
	kzJxqYYVERFKeWu67qfx5kMo3mSt9WrDYvk+vVF6xRInAHRg4/K4QRBqls4Nvqlz
	Hw6bRTCCcNdJsboF7CD0w6IjciyWs/Fu+pw0M9bl/ZkcPRC93sIRBAjirSWxEO4V
	JGHuqkbl6hHosgictnvkCVc7qbL6cRDeoZTeEsymUT0XM4vRX+x6YCkmXwBvI54M
	sJcuSUnmMg/mf0+on5+PBBcc3HgcDCLDCnXxMVySNtNXP9AY6TDRciTPQFVBFSrj
	eb5f3zs/+/olwwwQ2mTHyRpYSjXmkq6aVCwdbSwllEcWc1YAkokEE56beDQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2ak7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32b51b26802so432560a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572606; x=1758177406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4ORjV3h/UgG8t1QXMHoEv//ijDc+HhKRFWyrdBcOJg=;
        b=nJHeYG0/ZQJkjr47ox5hyp+UPEEisFNzEr2GkGhYzrDYjzm5wd33kBkGeR1eyKW1vS
         F4dvjt4pBeYJkEAAaVjdZoYe+8rZ03w88t97Vrg8XkvJnfyV/rjGVd5xjL+c/ivgPZCU
         d4wV1D2CZQ6bBgGOE5g2qQ2YgXpP1THIhMpxWJIRL5aqtLHv1Ggvnn5XU18sLEhfMziy
         0pAHdpAIrYmVBGIxrWe01xYdCKefgFdagjST/N3AM/Gt5PPwKCxVS8Wv8zxp5UFQt6iR
         NrMFpbBlMGPUMefN77KhjIYnSY2bRH9MLg0VHJ5eF9FPnkYDCnq4CWXlSYbgYGjPW83o
         KFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJpgcrV2jlP5/Cz7jG2LLHKNJd3g/ivBAiFpYZp5xbkQbFJ1nb5p6xPnC6Vy2d0UQqx+9cNnmcxU8FdH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9w2n73+xAriheGGMo/js9QuE1tHdrMf2pYrZUyphqzYoORgB
	ldhOlCsKwJp52lu/zt6c8BQL85Z9tXMDf9YBw37g9QHPOmNf2kZmlpj4bnL1h1rcvoyNnXrK62e
	aunSesZK3pAuksXJNsgJnBR4TRLWX6RPXePXWqFOHdsCv8VKrEV0d/KMfVIC68T/XTXo=
X-Gm-Gg: ASbGncuc2b2HbSuFPiixYsKCLmbJp/eS+knMEe1UjbVl1qZ9RE6mqMwrZVo6hdRLWHD
	ZUulpTsGyGwQ9xf7FY8vpuLChvDkabDJcTA13CaktBVkd78nr2T3lOWhgnLerbvnngwmEoM2ynP
	LjHBh5JPWFleZfkYP0KwOF5R20BOSlBg0VE4wAkakxHRu6iM2o4fPPxSlJRJJ1WRWja+RvWm+TT
	kKJw5THrsFE530SfaB4LyDJC1NuFVTT1/HXLzPFAq6K2jHUyZDZuY8SrMiG8W3FgkUvjNwVnqRF
	i4Pw6yVpB5wqrc2YkKcnqJ8KhJVB7aDek3j+PDoB/BAiHMhdi7BTdNaWRQEnepPYtBubGFb9esy
	V
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr225873675ad.29.1757572606004;
        Wed, 10 Sep 2025 23:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9eV4g/Bz1IC9gIK4+YyyAJHqfkhbwcypak7raP2+NFnageWgjl1k5GmykpU3x8QunX0CgBA==
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr225873325ad.29.1757572605304;
        Wed, 10 Sep 2025 23:36:45 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84f72fsm7739125ad.72.2025.09.10.23.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:36:45 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 3/3] ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S interfaces
Date: Thu, 11 Sep 2025 12:06:12 +0530
Message-Id: <20250911063612.2242184-4-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c26dff cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wtrncf1qwap5WzB382UA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: H4rz2TV4S5G8n10APx3Q-iqddHzAR_Hw
X-Proofpoint-GUID: H4rz2TV4S5G8n10APx3Q-iqddHzAR_Hw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX12m/eKO67tYY
 RU6xW4cAJ2yxTYB+O3kLu32v8SyOCdLB8t2hxpqv1WdZ2/jO7zrBeUwxNSNpUKuovS1q56XCqAz
 i54lVcFqLe3ToatqP5OXeKUmv1zZlzCUO5KgS1S2XPMz4W9Scc3GgsTuw0q5lrSz0YBuTD84dL1
 2jyH0Il6TMVpkzC/78rDIfIuHT+mESWOoCkIQ26Pe3v5hL/lc6a/g5M0TKkx8x48e0CKrnEinhd
 xmJQBnB71/Nmb2HCQGXiDyGzu5tQt87dZNy2Lwn7Ad9TKgmG4BLUFI7I4JYWmteFpWCQyN2Lk8i
 OOd6lZ6FmO535WCuvNLM/XFXXtDREGQ0JOdt125OZjCDTfa98QY/Sg21q4q4rUlDVliXybxeQaX
 whLMVGQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

Add support for configuring the DAI format on MI2S interfaces,
this enhancement allows setting the appropriate bit clock and
frame clock polarity, ensuring correct audio data transmission
over MI2S.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..3067b95bcdbb 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -32,6 +32,10 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	int dp_pcm_id = 0;
 
 	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
+		break;
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
 		/*
-- 
2.34.1


