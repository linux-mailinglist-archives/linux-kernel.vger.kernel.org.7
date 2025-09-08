Return-Path: <linux-kernel+bounces-805068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76438B483A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01867AF9B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583F622D4DD;
	Mon,  8 Sep 2025 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpqscwuE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8D225762
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309840; cv=none; b=IuckihkKALn+j2nrx2VY7HxjezHaWFT3xS6PUAL0Pc7cNsSr+r2MKiTpQ+jRqZIpz17PNSLCyIdTYpgnXao7jHW89EUdGDbOGEXhCLWZ3Yx+Yv8oC77D9ulp7bMium5RJm5W4juXc1AXbvytqFjH4kklkuD2+w4zLt3rCcwi5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309840; c=relaxed/simple;
	bh=CaB1TNSUbDHyyFdrQnQBPgQfdsRu1OOu0HhAAigiGDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDtjzQPazy7KAWiXFwo6VbAXi5dD+Ap/jwOrjQvkzDLM70TlPRLmHiW3hUASwZRNbqlNGjuiIKA9O5h9y23ymAKhG8HX1Qv9lUAQcjr7WFP1f+fIph5uEU9fUuOAD+Nti+tARzBXFhYi80jQX8ohUZL005M7RKec2cfvj4e5MR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpqscwuE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587IA2l3018400
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 05:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lD8cwxf7MZ8m4wMdcW4NqOMxZLJgf7K+8dM
	uzZNQ9+E=; b=gpqscwuErW1BX2hi2kz8Nlw+r8zmPO2a2Hq/Ek4uAW9HqgnSiz7
	tzY39FjHxH2D2hL2m9mxYieGHRF4BjoWp6fF6OUvFskRWo5s/E3uJGelWSvdY9CB
	YI/U792TtBcHXRzOu6B/qXs61vRYRDKsnQuYCFWDQZaP0BQtuhT1ln+gd42WLFI0
	5FbiRPGjo4GmntP2ARDYvSE0vQ4XPAULVKfQAsYcnO/JI6ljKns8KTWOf4SkyZT8
	owJ4i2eVr5Rk3xdzttX30PQBALTcZ19efp/XJtWm/Z2n5zKqdncMOlva3iH0/ifb
	mRii0nxTCZR+8ymh6UsOPO3w4H1rZ85XvxQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8ue7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:37:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-252afdfafe1so14854405ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309837; x=1757914637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD8cwxf7MZ8m4wMdcW4NqOMxZLJgf7K+8dMuzZNQ9+E=;
        b=c4vMSnil916jDHin2rqWYLDONI7cGo3llJsmpVIUqWtH+FT1dlXkKOMdnncG6QOM1m
         VqBfmkpBKoAU0J1SY/CKDiiSZ4lZULLIlQ1sGK29HJYPv2RYHICK3KTgjc9z+Oh65cD8
         XFzc6drphMmPClfbu9+IBaBW38EAN0XaQJTZiZEEtAKAj+m59fO1yZUtAc0yhwCTmKA5
         7w2xoCCpEM3BnI7rP6gmZwDugDXRehjf/xFL3HmvJbg2SJsfT4ob0u/ys+kBDMOS4j4M
         n7P1HwAQt8GCRqSj7qUsQaMrCd6I2QxwACPX+vsp0N4RdQDcqvOLE3ksMLEg1KBpJ7Lk
         leEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMJOG1+THbfCGA6mlqKyMQvFd60w6DCn8Ybuud10AYnw2N+OtuZ2rMOWvAx0H1sa5LAHc1un7XvSN8P+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2Y6dgKjJ6QQOj/V4JnwHRhJddJ05jwnvsYOxSAOQHpYvsjBG
	hIDndOHeJ4hNtC5KaiF94G5ojw6jHwAYj8rVO6ORZ7/xAPzsFh49jN39ah1TmMVNWOx4imSGqSV
	lCDnL+3NNuOcZRy8/2ZoBSwP8955EzuaX7OSSgO6p2pU0ibzRUozRKpTR//FaMXmibkM=
X-Gm-Gg: ASbGncseKUnOqgYdq6gqaie5jBllLpqrtv3+D2+APclpgbG9c49B1HVjoI1JOz+sW/f
	GxylHIHk5x/i2s9LmKJmaDc71xCCqZLBbswyyiB+3GCfV84UM48Q2cmnYmtyq4qnOgry1iwwjz3
	kZaIHlXIfsnpQ+Cydr6MlzKjUcbMb22zvpFKZrh0lTxuSMBNgRuY7DAuWEeGgmEtw01UsLjBvQ2
	tkdcW2WRRRu81BBU6xyZhqpFhBsvPBXuSwIi5linSDCbGCn0uTDdpCQhqAo55ONR/f2V0aj7uCQ
	o1u/wE0UvRWIZ4sOIrq62ehgvQpi66WpWyTb58iJhnqVQ/Rf5WvixiI42x+KfXnLc+EaGzAAzZE
	g
X-Received: by 2002:a05:6a20:3d88:b0:246:9192:2779 with SMTP id adf61e73a8af0-2533d60850dmr10791547637.7.1757309836697;
        Sun, 07 Sep 2025 22:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH57rjgychLB7Qf8P+tE8Tlb0ThhlaBMZviRf1StqzDT6yykvqMOcWbNKfvbcwKGmoSP5L4Zg==
X-Received: by 2002:a05:6a20:3d88:b0:246:9192:2779 with SMTP id adf61e73a8af0-2533d60850dmr10791504637.7.1757309836229;
        Sun, 07 Sep 2025 22:37:16 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:15 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [PATCH v4 0/3] Fix lpaif_type and DAI configuration for I2S interface
Date: Mon,  8 Sep 2025 11:06:28 +0530
Message-Id: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68be6b8e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: H_5E2_PcsbSOQgC8QKsiUxfGqRFgfE02
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXy9nNNIrLCITo
 4XQh0uNL8cmjdzWqeQI//Cju9gTyqQz7wtigwxuwRxa505Kw3fOz4CLU0vvsj0p2kNJjENNrLVR
 JGgw/H3M4YTX/ZIj/TEd9WkCnVEag/Dtf1ynFnm8Jo1JGuKAX7T9NLusGQyNzAarrhULbXlgf2Z
 oibtmuNbmjXfhsIh06sNRD3PxHuqF+lsMuZWpaaASvcAcLA934KSI/ZuaJVNeX/H721r3aNxFBs
 Mzril6GnXTULIZt0fxk1JijYnvP4WJPKoamdsO08Pra9FI6cpb5FIJUELR3rpRYHmj7YBkkCFGM
 yb4CSWERE06IF6TnKRbIlqp6aPLXBSQgfe+qrrGIiUkN0gsgfjTB67dA61R8WGQbLeiypVkDoBA
 12as1tca
X-Proofpoint-ORIG-GUID: H_5E2_PcsbSOQgC8QKsiUxfGqRFgfE02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Fix the lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface and also Add support
for configuring the DAI format on MI2S interfaces to allow setting
the appropriate bit clock and frame clock polarity, ensuring correct
audio data transmissionover MI2S.

changes in [v4]:
	- Updated commit message in patch v4-0003, suggested by Srinivas Kandagatla.
	- Link to V3: https://lore.kernel.org/linux-sound/20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v3]:
	- Added Cc: <stable@vger.kernel.org>, suggested by Srinivas Kandagatla.
	- Added QUINARY MI2S case in patch 3, suggested by Konrad.
	- Link to V2: https://lore.kernel.org/lkml/20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v2]:
	- Used snd_soc_dai_set_fmt() API to set the current clock settings,
	  instead of the default WS source setting, as suggested by Srinivas Kandagatla.
	- Link to V1: https://lore.kernel.org/lkml/20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com/

Mohammad Rafi Shaik (3):
  ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S
    interface
  ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
  ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S
    interfaces

 sound/soc/qcom/qdsp6/audioreach.c       | 1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 sound/soc/qcom/sc8280xp.c               | 4 ++++
 3 files changed, 6 insertions(+)


base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
-- 
2.34.1


