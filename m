Return-Path: <linux-kernel+bounces-620986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A9A9D24D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43561C0171D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D0225407;
	Fri, 25 Apr 2025 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X/IzE1Vg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53157224B0D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610561; cv=none; b=ImVSwBv6EK8NpUymFDvdP5Y7jaikRVH/T5i9FbmMwf7Tf9/9qLaTOtY483bjSQOD/d00Bv86zk4OtegPkPz+Rdp+9w4vnwYqNCgzVS0EtZP4c2f8vu/LNY2hxkLQG+tPwDBv33L9uMV+KaraQWX/8ICiV0XGiUzYbpHqc4xcg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610561; c=relaxed/simple;
	bh=zi6XU+PXzgyyO7zfBxiQGFtMjk5GDx/6hmtJu1GnLRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AqKtlwzglukNP17FvWqBLnkPP0FMGg43986r1lKgwyWVOshBNhiApgb/GJkNbmvyBeeX9kSyv83JQJo8uqGcinyI6JFscI5ePYE6pfj8r6mlViv4URsPXUZrfIHI6bKBUevahsL88VnluBvgyZd7WWXWb3G5iVZ56QeeP2/048g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X/IzE1Vg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGJqdX003980
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Op5Ucj3NsPaSHpQN3+W+ByQRkYYVKvbIsr+8S3UcS4U=; b=X/IzE1VgEx1CPVgX
	KlsmlWkRPhKb+bF4Mqo2rzaHWy+4ZTzJzSpGGj9sm2F4ESNqNTXBwBOavOJd6m8I
	qYlTdQIyvmBoYAyO9LM09CWzRN8k2MmhIXoyA5ukPSOdpRI90m0TaLDHk7RC/YVn
	BKWJ/4Ndg+ufu2lXe5LgAOhxWlo79ZEUB5GfszECAlmAUl/r8yRaGJidfxFElXyv
	Xs1tL+qGlnWd5lh+eGzMbFbZRKpMpHiSOOdo2l+mTIMvUjmjRLXowlVo95lNyVtL
	ZDyJOC8M7D3VqmxceSAEq4nLguqP3OC7/KyJvm7KNKRCMEa/56ps5/ql/WmN5jVM
	eKDRSg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2a798-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:49:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4768656f608so43926871cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 12:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745610556; x=1746215356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op5Ucj3NsPaSHpQN3+W+ByQRkYYVKvbIsr+8S3UcS4U=;
        b=sjnXx8LKbPeIsw5MI92aX4fyb/w6n2eduCSe5xv2K3mUKRv8VaUthLnK+TBDq7Lutt
         62W5qvrLpV1sbKUFHolCrbC7+KmrINYwiJ2JprOkopfOXggDxMV+qPwczt1nYaA79TGg
         eKZZiu6HLDh7nt6OcL0mwEe5fugkJ+fhkghy0Ho09MNyhQsD0esh8Og6IDFB8/b+sHzL
         TNEnoQLQ2RGXSMNXoIZXN+uuLoBG4DzJHv4/U5KinMYzMf43oYPxUE9W9tGIh4ibs6iz
         jOtdu7L3AYwozr3agscSWJ5fPa47pV/ViyWZYf463jyn6t5xukWqgwX5SeDtRuGCCgbq
         63NA==
X-Forwarded-Encrypted: i=1; AJvYcCV8c8pzQ/qPG5CUzbVFz+n2G6kyuINTrVHCepE24kpmvbYAYCsm1HYytbw5aOT/jJEqW3gHasFGKMy8G2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6aQGqDflPhck+EMs+CqDPMUDOVGZ0UbYW2V6J5V5CkueXCA5b
	1E+vmxthKpNytgkbb1CjQ7mbsR+dRvunI6Kqnxl+5Klf1qHZ7bnvGIuFfR1hs+eOnNB8wxtSa9J
	MsiWdwBbQpx9JehDIPRDBcSsXW4Qe/2vZYm499gcCP9SCkwCuEgQdgJDp/6arMGg=
X-Gm-Gg: ASbGncvWU2DSm6TqQUoc0T6VIg2ypQbzPGad9vRb+e5v4jcGkxxLuRunlqIQdwYOG+F
	drFllwOB3/dmASIDYifiQsSF+Z9TrEsetrnkoMqEk+1r6iR4iJAId7+9yMhWT9tc/ww1MKkFUPQ
	0TryHK7UomrTpJYQZ/cZaTu5nXl65urTSy72kyWy4ql/5Moj6ifGc79z/sqv31EkZUy3M2yUjUh
	m6AJmsHAxxoUmeptZKCkn7gdgtnmsi+yWhYC4hdx+wcSFGwmCQFQRMEFFqJugKyvSsLaz/XqPU7
	XBIRRiDLyp9w6Fk/yzLFjSMYjzjpBU3IZ4kzySLfvN4/a0wdiIpHRvE1q1SHSE7ZjgS+Yd5sRVS
	VF4++yjopO5A5nSZXIeWmkePH
X-Received: by 2002:ac8:5f8c:0:b0:476:9483:feaf with SMTP id d75a77b69052e-4801ca7cd8bmr58651891cf.19.1745610556107;
        Fri, 25 Apr 2025 12:49:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvsYm+y4nGXf58l7owYH/EptT90yacYmOjG5Q/lvtKP+/y6qqRd2lf6/BRdOEXF6bTAvHKow==
X-Received: by 2002:ac8:5f8c:0:b0:476:9483:feaf with SMTP id d75a77b69052e-4801ca7cd8bmr58651561cf.19.1745610555757;
        Fri, 25 Apr 2025 12:49:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb258b7sm725313e87.22.2025.04.25.12.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:49:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 25 Apr 2025 22:49:09 +0300
Subject: [PATCH v2 2/5] drm/msm/dpu: enable SmartDMA on SC8180X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-dpu-rework-vig-masks-v2-2-c71900687d08@oss.qualcomm.com>
References: <20250425-dpu-rework-vig-masks-v2-0-c71900687d08@oss.qualcomm.com>
In-Reply-To: <20250425-dpu-rework-vig-masks-v2-0-c71900687d08@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fFGUiM7rgjkUGAW2oQNNZ8SSmLtzgOiuFiVQLK6bnQQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoC+c2OF+dpZ5x23AvPYZzM2MBCF3aqqk+qzvls
 wBX0P8XsxGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAvnNgAKCRCLPIo+Aiko
 1YxaB/wM8mKWJRIVva/SbIne6SnB6a09rDJUu2XRLkcr6IYyW0u5+lvBVXrZxK2q9+UhWyT+r/M
 LfutguivISiLA9iHcQUS1g84PJVmPhYHUty+PaTu/c1P/glxccHD1jebQF02tRNUxSe/S/tiuvN
 TKtVBCxBW6jyifRgIZ0XuIBbiUYyUV/QFYMOBK6LiJmbgTxnyMmvpjWN+OmyIyda+PPlvI5mVrh
 SrVyMm7oM1aP7tbcYoda1Vkb+BcATg9UVthsb2atzf5/rQTQCQNUU1ktYFArBe/Gti4+9Xi/ZW/
 d/YLQ29ohqgzdByB3l9CN6mYuvbgImjF6iDjfb3A2YpJl8/G
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=680be73d cx=c_pps a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=0qT3Y18QIILfcGn7-LoA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: k2yG642U2VnI6euN1H8kmOaK8G1zEXtP
X-Proofpoint-ORIG-GUID: k2yG642U2VnI6euN1H8kmOaK8G1zEXtP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDE0MSBTYWx0ZWRfX9U5mEN/1AzmK 3hHo3nUTnsijJ/I4ayAzX9nupB/QUuaUFAwNr9Zz9gSva8U4vE0JE4ONDbKdaJ1sEEccfzv+a8N K8qgWr3qdM6N+tCliVECQjUVbwPUDoRd5k6/eAWn06oEeLcwyL7+o2oPiUhP2HzfnY33q1kyj3U
 YH3fWM5GdW1ruZ9tPEBghzSE0DsFCwXPHm37x4wnKmIzEY4eDzBYsQ3zDRMRIln/VDvnklXbCIc V+7ZkKjUUZ7B1agR81v0xeBuYFSGpP+ig3APK+I9VAop7qgZdVjNSm0Le5W9Vldpnf5dvDobnnw is0jkaWq2YAJTWYZ94Km/3nFVDExEN3dJ4yDoFL9rzAcSqHmfSqpAc2HnIGQT1J749louaTO7CB
 7a7gxWZXmgFJH6lRGBvXRZRe0xa1zRV4A4Gvs5qQZrfdi/sH5llgktklJmovbQWpMzebrL4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=894
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250141

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reworking of the catalog dropped the SmartDMA feature bit on the SC8180X
platform. Renable SmartDMA support on this SoC.

Fixes: 460c410f02e4 ("drm/msm/dpu: duplicate sdm845 catalog entries")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index d76b8992a6c18c21a54eb2a373c789720b876c8b..e736eb73a7e61544e0940f1ac683ac0e4c5c79d6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -75,7 +75,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	{
 		.name = "sspp_0", .id = SSPP_VIG0,
 		.base = 0x4000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 0,
 		.type = SSPP_TYPE_VIG,
@@ -83,7 +83,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_1", .id = SSPP_VIG1,
 		.base = 0x6000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 4,
 		.type = SSPP_TYPE_VIG,
@@ -91,7 +91,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_2", .id = SSPP_VIG2,
 		.base = 0x8000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 8,
 		.type = SSPP_TYPE_VIG,
@@ -99,7 +99,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_3", .id = SSPP_VIG3,
 		.base = 0xa000, .len = 0x1f0,
-		.features = VIG_SDM845_MASK,
+		.features = VIG_SDM845_MASK_SDMA,
 		.sblk = &dpu_vig_sblk_qseed3_1_4,
 		.xin_id = 12,
 		.type = SSPP_TYPE_VIG,
@@ -107,7 +107,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_8", .id = SSPP_DMA0,
 		.base = 0x24000, .len = 0x1f0,
-		.features = DMA_SDM845_MASK,
+		.features = DMA_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 1,
 		.type = SSPP_TYPE_DMA,
@@ -115,7 +115,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_9", .id = SSPP_DMA1,
 		.base = 0x26000, .len = 0x1f0,
-		.features = DMA_SDM845_MASK,
+		.features = DMA_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 5,
 		.type = SSPP_TYPE_DMA,
@@ -123,7 +123,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_10", .id = SSPP_DMA2,
 		.base = 0x28000, .len = 0x1f0,
-		.features = DMA_CURSOR_SDM845_MASK,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 9,
 		.type = SSPP_TYPE_DMA,
@@ -131,7 +131,7 @@ static const struct dpu_sspp_cfg sc8180x_sspp[] = {
 	}, {
 		.name = "sspp_11", .id = SSPP_DMA3,
 		.base = 0x2a000, .len = 0x1f0,
-		.features = DMA_CURSOR_SDM845_MASK,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
 		.sblk = &dpu_dma_sblk,
 		.xin_id = 13,
 		.type = SSPP_TYPE_DMA,

-- 
2.39.5


