Return-Path: <linux-kernel+bounces-773458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834DB2A05D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E004B7ADD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3351531A060;
	Mon, 18 Aug 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aye3wiGc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759931B11A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516507; cv=none; b=EaR3PL4FOIaiEwPW5NopldYC3WflO1HygNmHOa8AmaziacGA/ebv53vpjPhhx6Gtrm10a2JIeP0yRfVwCA9gMbFtY4v12mx+R3VnKBXc+oz4LJbM4re3FfUMZ64klc/Iye5noEwfHZejW0mtdHaipObWNQt1aHhowpD+vpcAxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516507; c=relaxed/simple;
	bh=MVknS7fZsBbltlMguf8cAS8VVN8wV1AijKC/soz1lsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGa6JcKDJuGaZZ2fFm16N/3PtgMI9WSCAw3xG+XOUktitDEklFTmmuEEmoanuxDErpWxjKT6xmsdYdiCXnbMqO1dV+X6WBfIX3uVuM2fUvKhZ4scA8MamoQpfHw1LLekzshVTStAliCwFT+pEgUze8fbsTlAGy+ilEGLKSLLt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aye3wiGc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8Uq00030081
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nGgpd8ySRMJ
	cXDU8t26AMIBMPUh533T65jXYhrJ/7+A=; b=aye3wiGcmc5q6fFsEO62PaZwnBj
	+jNxBTGVAWa7nD0inxIKSmCHDHHntpZ1+mZZ+0gqjsGBnulhXn2kx3haRe8tIl59
	dke1FZnjdynlxJQdirlrbw5/UbnjclKvj/4B7myMXbJyMz83dQ8JEEI2Y4vyR2OV
	JQgdAxoQiMrTSJ+COoDnH/yDvGxs4AlGf3HTR6i3IDChzMXkNy5nBSRk7GRVnazE
	70E5e+0hwcv6XZady1pnh07Pi4c+L42lJa/zLfOjdfFUDD2VbInrbUwEJCbVoKzs
	L4ySZy43quyOZVQRvjyZRqIkolXm3gA8P74ZURZgv+6X0fm6RHY7nlpf0NA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj744ekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a928282a3so146909796d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516504; x=1756121304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGgpd8ySRMJcXDU8t26AMIBMPUh533T65jXYhrJ/7+A=;
        b=mNkj5nBt1SFlkISZcMOm6GRPKbBtrstZX6nFnXbCB/craGuNIa5Vq+1KYi2OeS1D9z
         zIE1Uv9ztSgyl9zsKotSXtP48DfCMK4qxBQ6Zec7G/a4Wh8QPAKHlllDmw2FaRjjcZ1b
         gZLU+Q3HH1yliwzgmvPgOwLkPkCgIPjkHS0VRxAR0VPIrnlLBhgH6c5FcoQxbF+m+/Gr
         dXG7P0JFgdR1MkHvjImRFL2DzBB+yeWGHlSwIC7ZcTRybeFCithwdMpz1Ssxn8NDO754
         K/gJ4LSIqu6uVFtfkNmf5NtjPuXjL5eg8vRFB5jOWEp0JIwMFSwC8E5ckVkXa8+L5YqW
         Mnog==
X-Forwarded-Encrypted: i=1; AJvYcCVYy8lIhexJIs5cRtYcZFAG3iCirJx2NX0UujsNhdyzWGsl58rofeP860vLnqBrjcSfKR7OXjlaJlwLGB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbs4go8k45i1R30b4le22a6kpA6GgE6L/TZS/NH3ovoJmV3/98
	+wXVk4hLMIQbBOSxBq+BOfYoX4cSfBk7vjLNkHxDQBcuW+q9qMfJrX2xHtE7vTVfJhyHj+sBs0h
	LdDhA9POfMabRjdHl+W4Px+70hJstW9K4Y262PSeka8ffYV6DIk6B/iUIwQo8Moo6OOk=
X-Gm-Gg: ASbGncvdjpTmAGGBp4NhWv6tUCzefaD8M3rHD2E+TSGbA1AOT2qkh+ifWsigraK82lI
	EioG4JEN9pBlsNvTII7CCPON805kASASxXT4uITa+SFhplEWAX5ygNE9UCMkiE0M4GY2tqBIKJ2
	pGApUhW20gsJ5M+HtKetwWHsrplBQze3sfAXDf3oA6xVuVqtJSFjPdS3uavmC+GtB5P3hbE05Rs
	qzDoNcnLs3Cvd8Lrou3hRZeXku4oNM9Q+E7VZV3D2pCZYmujREVw/UVoQHrktPs8lOezmiLW3yI
	PTr6AQl5KLVlBPDEg9WrlSqNQ+WzU/Hg7X0Mo4WauennnDtBaZJ0Uw==
X-Received: by 2002:ad4:5946:0:b0:70b:9f86:5fbd with SMTP id 6a1803df08f44-70ba7caa8c0mr143184146d6.46.1755516503579;
        Mon, 18 Aug 2025 04:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN4KALdHu1FLJQrv5AAJZwm4Wvz/EYRkjjHtCXUzU5NOxtj3D/IbKu1Mfi5H6ZZfGwGqtzew==
X-Received: by 2002:ad4:5946:0:b0:70b:9f86:5fbd with SMTP id 6a1803df08f44-70ba7caa8c0mr143183766d6.46.1755516503003;
        Mon, 18 Aug 2025 04:28:23 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22321985sm127555275e9.17.2025.08.18.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:28:22 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/4] ASoC: qcom: audioreach: add documentation for i2s interface type
Date: Mon, 18 Aug 2025 12:28:08 +0100
Message-ID: <20250818112810.1207033-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lDMHu6RTn2X_2Q9MU8IHmNLhSMNSjkTY
X-Proofpoint-ORIG-GUID: lDMHu6RTn2X_2Q9MU8IHmNLhSMNSjkTY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX6D8p0LW5PQG3
 Njhz5opWmLmkeFKXap7FOWyCsFOjy88UDJ3rSR3/RQAE89FVHHL0wvO8IWzEmhihg+Jy3ELlr7O
 se1k2X9T2bBNTi0Fgn4i6ha4NZW70X/ANBpU2GU9+aNP7jWK1VvTG2em69C7Ox0b4HsnJwS0UXb
 anS2V+WylsjbdZMivroObdVekI0bbLxCC4H9lxRc4wSl1Qu39xgGHIU/+eJ3VsST/zBpFRkK81s
 5ehxMMDMdCuVnhRk2OWhIqd4kFjzMinobKWFZRUYql6e63zePUfCa74o3Loai3Srm9WolVVIDI3
 QLr9LAxZt9+92xxuVHK7Sht3unlM0XOq5+X3xfoTZtphffjmubGxn0EabKHlYRiqznmntf7C5Kh
 nBQEZPCn
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a30e59 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8DVPAwtwuvfE0Os7CJ0A:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Add documentation of possible values for I2S interface types,
currently this is only documented for DMA module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 include/uapi/sound/snd_ar_tokens.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
index bc0b1bede00c..3aa5f4928a2b 100644
--- a/include/uapi/sound/snd_ar_tokens.h
+++ b/include/uapi/sound/snd_ar_tokens.h
@@ -118,6 +118,12 @@ enum ar_event_types {
  *						LPAIF_WSA = 2,
  *						LPAIF_VA = 3,
  *						LPAIF_AXI = 4
+ * Possible values for MI2S
+ *						I2S_INTF_TYPE_PRIMARY = 0,
+ *						I2S_INTF_TYPE_SECOINDARY = 1,
+ *						I2S_INTF_TYPE_TERTINARY = 2,
+ *						I2S_INTF_TYPE_QUATERNARY = 3,
+ *						I2S_INTF_TYPE_QUINARY = 4,
  *
  * %AR_TKN_U32_MODULE_FMT_INTERLEAVE:		PCM Interleaving
  *						PCM_INTERLEAVED = 1,
-- 
2.50.0


