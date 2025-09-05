Return-Path: <linux-kernel+bounces-802633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42BB454E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A798FA039E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6C2E2822;
	Fri,  5 Sep 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFE5YcdE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079ED2DF71F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068849; cv=none; b=IZLxU9jkX+EP+FgotDMjVMJXjQcrN2JnIZbcCHsqFhN8/VDhEJwxrZ/y1df5+60yYOekbAJ7HP5BxF3ca79WqUDdHpLWkmYupBgZtV8Ao5jmIics9WcAXC6OCNIUtmXY2ITAawCZrzaM763FcLyP+juSK+RWC3fNy3HydEifvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068849; c=relaxed/simple;
	bh=E1XNMHzT9B2C315s+ymn+DVFiMNCskeWF4Pe/x7nwY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCnAhe7IOa2CJ3pzmxIJ4hdY6XE1M3VhsJjdsADG/LJOZscZmqV2BFEt18TWRFt+0ZuoB4pouTzT9MGCC2n94j1LEJe7pLfEz2Hpoze9uxR6egw5YiuQP6TneL4mlPgP9a03ERpv5Scl4dqrsYpniaqcV/ea7Qp6JPYN005+5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NFE5YcdE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857Ddxs002728
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QSkUHu0gVYG
	UHPii9r46YVIB5E4jaF2svdTcxZ7SYvs=; b=NFE5YcdE8AtdARXEW7gSmhgkiuw
	lnTrZ/n5Yia6uCJO55PWRpSDvNAhhkN32mhVlEv18tmLiXm8OJsgBEvp1zQXu1QJ
	6w30MEwvJcutnqr/a4U0klxifDLDUt7Txnl8Q4jgOIr436wJjB3MWV7KDhnCM1hq
	oe714c77uMB2drZ5cggH5xDeXgTS08Ce7TZPFhG8JjcxAsKZ5Tt+SnS/a1KeXvO8
	mIGwRN1PohvsNKTCtmelh9mP40MeV/JH19kYwTxmZ5npmJgshFPzejLE2M8aHuvW
	5QDTJT/Rn1rVSueL4licfZmZ0rkzIGg9l/xpOS6MfOpCMKQiyM6hbxLpBww==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush3aq88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:40:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77260b29516so4117852b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068846; x=1757673646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSkUHu0gVYGUHPii9r46YVIB5E4jaF2svdTcxZ7SYvs=;
        b=QeMYt3JuiUgVv6fbn3hXISiOa3xSSIRBj9SCJtqS+r9nVfmTkvtsQLHnjwOZzVyp8k
         hSZiRdOd+Ictm6rMF61LF5WHmTKSmgOQIODdENtOaPiHOKeZhX3ZW3+kJXTxJfX4cjNb
         18sIE53dQxnIuTP7u4Yi8iPZqCpdEbb5rNdNs4LT+dvZuOdirJxdQkRi11OtqBZ67VKn
         LgkRr925phPDhFXS5ziNqnXwB9Cyrk+EkPgUgEffEFe6dfPZVwWqrqnZbgcMSWcMttBC
         FxlEvluvB9wq83m1afuQXR5IbHX0ohUtXoyGj3T1+PPYv17N5nvFcOtDCGcn8o9VUpOF
         WJAw==
X-Forwarded-Encrypted: i=1; AJvYcCVZDjOrt7oLtYZB6VrsB8+tY/YI/0B+rjJ/NnVX6rS8EOVA7SRUDJzFqzDBqsTZsH+zKXZL1i8zaFpffhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0jPMLUItp+GFMOaxcRKhHj5LOUvCkCIhTLGsiBFbKpu5Nj7N9
	bUSUP5zjGST+fEb5XmiJyMtwTapBQb/jWn/k+uB9ZSQI6UlvTYDkOHyqwcOghoBPRQJLd7YPPOR
	Ow3pWWVpYGVMiw4bKG0z0D92EGwZfT4qLHdGN2u7dGBDTW0KOw+kxglTmA9mEVZviBT8=
X-Gm-Gg: ASbGncu1PMKEScZYyRcXZoHYNR+I7wxjdO6WOrjcHR4bGm4KprdfTX5Qy503UT3A1L9
	hj4iSY/JhHtYhFXMrWfAGMDD0LobmuqlAaWaW9Y5f0LNzpZDzHlXCZsorG68cEylyACnfUBS9qW
	nmIdnKP7mytOFu/ND6sIcJxjPC1jGte72cSdY3eNOV6GzYHgcIyDwJOqXsbB87sZ93oN87I+6Fr
	51S7rfvlt7ulrYJeWoNmiFUMnYI1fCaEweO+10yIMh3DpmdY46gdBiFymGPefA51vVHeOimbaR6
	sTuWTFE8Ic4hahLJHakgG6atJvwGAomYEC40uSzXtZtrXRk/7jhkESfRPh6ZjG7HKesvagpqeZb
	3
X-Received: by 2002:a05:6a00:2381:b0:772:101f:5e46 with SMTP id d2e1a72fcca58-7723e276adamr25928868b3a.12.1757068846398;
        Fri, 05 Sep 2025 03:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHErCQvorWw+m/+4N3jUeHkcL9M/PRQHi0NUnu7aa10kmo+JoAOzfPC+ZqOLfQXDD0bME3usQ==
X-Received: by 2002:a05:6a00:2381:b0:772:101f:5e46 with SMTP id d2e1a72fcca58-7723e276adamr25928840b3a.12.1757068845900;
        Fri, 05 Sep 2025 03:40:45 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269e9csm21993859b3a.17.2025.09.05.03.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:40:45 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 1/3] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Fri,  5 Sep 2025 16:10:18 +0530
Message-Id: <20250905104020.2463473-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX3o0O4xo5J2yI
 lSy8gKjJOpkKcTosuKr/EbHufX7WC4EAxop1Dk81IScoSUeCvYKW+eNmS/wmGjSx2Jb8kIdIb4e
 XuSGY0H0M2PlOZNAJx2RLg8ousP9z4hxoaWNgzgf/1cbk9YqGRy+WzaUCHJdjXxvFP9uR8e3jHw
 1KyHHSr+76jifgalF9a9m6o4RJtBLyy9LAPwxlcIt4uFan0ibZ92EZwlV+vG0ak1R2bjRCJtbgC
 l/McPclnIIEO0XdSsNdTd4Z7VkpMovkQNRGqaWCxsCW6mD8Q62zcOfxvLNl91jNfA2zxKhv46Ng
 L5R9/5k1ToAm/BXiM0jZG2fUgn0sFoQge343J0yeNdypsa8QycGWrAv3lScCKGKp2+R0t3XCZY0
 pkO6F3eb
X-Proofpoint-ORIG-GUID: lTeMmB1GRu4IEGktsfLevHFwD93PzzEQ
X-Proofpoint-GUID: lTeMmB1GRu4IEGktsfLevHFwD93PzzEQ
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68babe2f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

Fix missing lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index bbfd51db8797..be21d5f6af8a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -995,6 +995,7 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 	param_data->param_id = PARAM_ID_I2S_INTF_CFG;
 	param_data->param_size = ic_sz - APM_MODULE_PARAM_DATA_SIZE;
 
+	intf_cfg->cfg.lpaif_type = module->hw_interface_type;
 	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
 	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
 
-- 
2.34.1


