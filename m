Return-Path: <linux-kernel+bounces-821946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E04B82AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBBF1C05646
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F8223DC0;
	Thu, 18 Sep 2025 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oAc84+HF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3821C9ED
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163322; cv=none; b=Ey+RpYDniujvfiGuG96PR88zNUaLMEBG4ecXY84VYRDX8BUM7IiQwiFQhPqYDmHGZIOqXv2aK+eK/N6yOlsP1nCetSITUOfJ6IcD8vnLaIlnzPdZPrhN6AINYs8baxNPJFqkYKf2pNSWSx6oFQZ7bdvwc8CvUJVrSGdfgQprqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163322; c=relaxed/simple;
	bh=vcPhLAlZIjQ8nYPWFC0ERVGh3IRmBm+uheguvXogRZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qH18NFEnd/cTaMIWzzDCly5eN35xRPB9VIcWR3BueLbKOm1HLNg8NiYwynjjL+92kvY9UqEgSrTHe7VTU4niDo3I9xXTn9LGyvR9L7s+3ev/QlK5CGoE8D0Jga2/plDKu6lq6REwweCfFeWSkZ0gpFd0YsBepl118L7ZLUrKsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oAc84+HF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I0F4lJ004305
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NlR/R4t6BjnegHrv08pGhH
	YCzQ6yM1Tm6ZRvAHgdasU=; b=oAc84+HFBrHJHffOIKpcEEkplnTXbCf9TPviB4
	pLcST5xnQh2VPXwlzQdY3jM2j3pPhR6t6N+0vFoaaB8h9Tfjun+x0fULU6oUmyUs
	dOhYIsOr3TAzG+I9UN/fooM3EC2gyQnTMX9aOyAUrjElCrlpYXpM98E8Da/Q+Vfn
	b++XMtjN8e5rY4xp4vBtU8x65eeHO4eqlIKIaCDVfexL/2xPMvHASt5WBvWtOXDw
	RIRGAkEl5H28yd0Qe8s4+rqptEY2pf+SxhTl8r4xi4fvi7Kd07K22/lq6lt6w/bQ
	G1MrDRR5PoFm4LNnUORCC1Hp6UXtpD3p3sxyyi9PWMImaFIw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgt6nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:41:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b60d5eca3aso12004571cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758163317; x=1758768117;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlR/R4t6BjnegHrv08pGhHYCzQ6yM1Tm6ZRvAHgdasU=;
        b=DYP1iG4cOCg1H+peC92Qt4a4jO95/NMDGds9FG0IKO6PZBCPoXET9Xs3J6PNUyBfWo
         8w/BYQocZc/ZBCo+t6BXInMz38+u7TDC4JAErDo/W+wMpWIxPuFaynCDlc6DnkXGBd5u
         OcRqSEcbCGjkxUpvLrTEBxby2B/X+kxJigIx3F+wF78su0Olm8RtcO6zy2AVpc0TQw1l
         Yax0cSKoT7Ai3f5KXTx0dbUGsTGuJT1UvaXUupldsMbf04E+piM3pid/ecNA3QpSTKo3
         LZdv75TMWTAMo61EqOAN6pkvj75FVIgjbOGnivXS0WWSCAEKQq1sS2itQF2KYFtFZu2E
         6Fwg==
X-Forwarded-Encrypted: i=1; AJvYcCVyvBqW6ZxvLxYwdd3hypGHW2wMfqE8BYwTtM9qV2aQ5sI09KsFLnjTxvxjwLWfW4KDFdVSBbmhKbYIM78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjBNxJoLCH477RpzLf2Sb2qsxGQkWIFLq0NDI8/09PROO33ZM
	4+QV781Z683tAUZ4n8IvcITeqMs3XxN3vMyi+5ZS2OezeDNt8GHuB+bElTKSSwJJ2Ze9kkRwIos
	HRBsp2zyg1D8Vc8k36J31Om1yazX8RDvGJpoeNZsGw2hD5UMuv9cGvIYpjq7YafXAY4k=
X-Gm-Gg: ASbGncvKpwOeGUwqKETxAzH358HSCSsfTmTsat2nAjhbepQ6DehpHJLLncpkaORn8+j
	GJhUf9tkjoez6pFeY4u3yaf/NDzWK4EATEuP9mVqt43l5B6QuCVH9Y3PZGO6KbuWs9EFe/sGpV3
	M3eHa3E2gGiowikgpuUoBJT8AYWxsbYGBQ5GOEVkkKLeXv7jY0db9eE44dirQ47kYjEnPd44K6a
	/gJvpsK5seVlaokFqgrWvrfppUxFX3MBRTzGpBXbJds+kRM9R+liIlebiqxBAPycFlihaQ5eLhu
	kn2phfQPD6QHMVK0WysNC5fQe+czbKfRfaEua9UisXC0oOBdBgGAAqI8ADCDqxPYHRx1le1l/e5
	CL8a2N4O0E4kojoj9/l+GTsOTv0xJvbxRIkxuB7YWkVzyzUa24OQV
X-Received: by 2002:a05:622a:4887:b0:4b7:98d9:60aa with SMTP id d75a77b69052e-4ba6bc225a5mr54329611cf.72.1758163316910;
        Wed, 17 Sep 2025 19:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr3s2G9NErkhIpml+NwAW6LKF5Msqi5VVo9rP8NPR7U0YesZ+V0R2KLsSk9CJbpd9SPl96UQ==
X-Received: by 2002:a05:622a:4887:b0:4b7:98d9:60aa with SMTP id d75a77b69052e-4ba6bc225a5mr54329391cf.72.1758163316437;
        Wed, 17 Sep 2025 19:41:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3624319eb49sm982201fa.50.2025.09.17.19.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 19:41:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 05:41:52 +0300
Subject: [PATCH] sound: soc: qcom: use sa8775p/ subdir for QCS9100 /
 QCS9075
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-lemans-evk-topo-v1-1-9680600e62d4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAG9xy2gC/x2MQQqAIBAAvyJ7bkGtKPtKdJDaaqk0NCSI/p40t
 znMPBApMEXoxAOBEkf2LosqBIyrdQshT9lBS11Lo1rc6bAuIqUNL396nDJNOWojdQW5OgPNfP/
 HfnjfD2bzIPVhAAAA
X-Change-ID: 20250918-lemans-evk-topo-dddd73c29024
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vcPhLAlZIjQ8nYPWFC0ERVGh3IRmBm+uheguvXogRZM=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGjLcXCiD5+oTP1Rpt1f992r+5520MEVrO32D27XR9hCNcC7Q
 okBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJoy3FwAAoJEIs8ij4CKSjV33UH/0Du
 iIWrEdfqU2r77SF6qSWMmz8eGRaO7RHHOMyxjGfrSGPFVIUEsBTFHkPhJVHIq6HYXUri6qIYzRl
 3HI6CyE98FwX9To5XEgycfitIwJF4OvMvehqRoQ8hGtqi7u/bWy6oTi7NrAH5MB5Z1suPXwYtbs
 A1ng3jFPEK9v45n7kMZyast8E1vGDOXXD1vQGuTZQORoAe8pQNP0FMI8iRSlRuS3sUoJY6zuej9
 TeTUv2ljHP6yY2TM+aOlYrRwbBu+dPbMoDw+ZeI3KwRXXVfe82oxYFZFUVZB3TINlxa9xRxUeHy
 JVlM3Yw7cyuC2rGuTsJiO6tB5/2E+iL2GZXUYtI=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 8SZs2Xj6pnfjZduPHcpTAqAicMZwLINr
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cb7175 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KGRU7LGiJR5Q1pf3Q6AA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 8SZs2Xj6pnfjZduPHcpTAqAicMZwLINr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfXw2eb7ReQL4jH
 FxJqMYQvDAF1pcEWbgFOl/q0vw5wnxnpa++MwtbOijifUMuxIaF7iSZLgSv5JnkvZL9Lf5TEbtU
 NYKWv2Wnsjkpm1LkJ/f4pVIGNhNIEmU2TrEUH/CLBjxhdf9+3pP1rHB5EbMZIdK2j9ISovL0HkI
 PkBMs0v8XtztA6g+dtG9vD/igJZesefBYvcdcYtnrvUARfhEqQbounVRL/Wyt2VG2y/utB4xjVw
 53MEaD4da4OxzfS6utz8bdR4wOtQQUU3mJR4GE+wsaHonV0K8mY9b9/3rbqjaIxXm3gZ47wIdDn
 LG8ISJjeaMsdK7HZgsYYenc5TlZpiwN35KF3FMkQnJrElfnHfdrGlWkRgwF0VDZL91AV6FVUAc4
 ewqImJYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128

All firmware for the Lemans platform aka QCS9100 aka QCS9075 is for
historical reasons located in the qcom/sa8775p/ subdir inside
linux-firmware. The only exceptions to this rule are audio topology
files. While it's not too late, change the subdir to point to the
sa8775p/ subdir, so that all firmware for that platform is present at
the same location.

Fixes: 5b5bf5922f4c ("ASoC: qcom: sc8280xp: Add sound card support for QCS9100 and QCS9075")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e2581c132e6f6468740a33a6f2ec0c8..0d482d8eb1dd41a3a93d8a6d5cc4b419b8c45dbd 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -187,8 +187,8 @@ static const struct of_device_id snd_sc8280xp_dt_match[] = {
 	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
 	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
 	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
-	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
-	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
+	{.compatible = "qcom,qcs9075-sndcard", "sa8775p"},
+	{.compatible = "qcom,qcs9100-sndcard", "sa8775p"},
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
 	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
 	{.compatible = "qcom,sm8550-sndcard", "sm8550"},

---
base-commit: 05af764719214d6568adb55c8749dec295228da8
change-id: 20250918-lemans-evk-topo-dddd73c29024

Best regards,
-- 
With best wishes
Dmitry


