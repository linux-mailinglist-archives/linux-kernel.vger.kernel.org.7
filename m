Return-Path: <linux-kernel+bounces-837162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F8BAB957
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275063C0A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF8481AA8;
	Tue, 30 Sep 2025 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHcgfdkj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD035295DB8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211505; cv=none; b=IybPXLX2KLSgvunXUWlcg4jc+MWIggAndc4jBinggggDSVYUh4pZoJydSctlrDn+xn9q+tvN7kHuwWourr1F5oD9J8ofNE+qPQ/WI+zK5LOInsS5mDTQc+ho1+yt8cC/S8oyReFueDj/Rzm91Ft9HyXmdproFMqhHAdHB0fehzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211505; c=relaxed/simple;
	bh=Ogi6WR+AUJ+HMPIbw08XT0QOUtgRv7szxAr4+cB63z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfoIDyrmy8BG46XwfXd0nabwcX3GCceRZ8oil/TOROUa53ZDuKPLi9sIGs2eGIHwbdg29nAz5JAkeHOa+q+J9JenZq4gcPPaXoR3M3ZNdN5qsL4/GKZ00VVj54pV1p2wYYGMGVf/IkGq9/tt2duqck7eZPlEFqqv75b3P38zbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHcgfdkj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4Hmct015254
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NpA7cRx2piPd6l00sCub/GWmDyOBb2LGz//j2JJNMWE=; b=ZHcgfdkjeL6SIOA8
	VtQprgQas6w87d+LZI+NwmLN4+ko9DyFL454A9TLtULd6JuD1hQYzuI3dopes/yH
	BiVr0SIVfAmr0/bbFw/Id3reRD7YZjzaAwYArgwdMZL0LwmsVJtBHgkTUp55ai7A
	ek5psMoXWzH99JziV6ae8fjTSFfGOJIyPXpC2Extb1nT9Yk8/SuEcqq0TryRxRuX
	4xTag166bVGrXyXl5vV4mf+SxqFfl/XHdFUHSmQ/1P4RWo7MN5QrIRKSmDc4XdiH
	9WIIMVIF9SW9OPxkYbJATtvQDHItHZh8XtJWFozxEHU40otERqoQO6w5E7oy+l1G
	ljCjnA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqyt2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so8480649a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211502; x=1759816302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpA7cRx2piPd6l00sCub/GWmDyOBb2LGz//j2JJNMWE=;
        b=jnp8NkgO3yc3quH7oelBOcg2afe7EoIr9QBQlxG1CIftPMs3yyLAPMdDlQTTtv6vDQ
         SIkN9DjglMDqpcQ47UTGJ8eOxfj7/nY00KSr+RVCB8tj+RXy+nZRr9RUza3uupzWz3rN
         80m9kq4ab+ukkbCrlasIQVUq3G0/03PJl71/S1f1PLAYLdmpOq+800t/QISE9+mZ/f8h
         9OMKxkWxXDEXpF6y03tQDmD71nR/7hgJO4Jaikx1XjwNl8OCCYwO9Cys4CUJbuCa+eXX
         KiZZiwJOOwqaYo11hAWUiK4cSb9+bqiOejV6giAhTdUae1HBYH7avAZMXhx/hxa65DHD
         kJxA==
X-Forwarded-Encrypted: i=1; AJvYcCWIZDIBoj8xF2UHerU08YnG22Su+FVJC7I1htgSV3Oa3TEBRaqQAy2e5TZJsFhnsZnqN+OTZryrirrz8fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9VWrNayLBuWZCbIHx37Pn40CGmzotdlCU8ZaZtGq86J7hruB
	mJpjZvvaHjOI4bFkT46Nq0lQhlwom9gePBEOvtUIguudF86Q/MdKtrO56JMSwkkYAk1yL0JQ3Fm
	ScUpjtjXxVLESObaV0zoo679yDc2YTMlq7CoY8Xh6/dSt6zCUFBd+OwKX/OKqu4FEz6Y=
X-Gm-Gg: ASbGncsuc2pLzsxQxpz6h8gYJBxGC3T6tLXRSY01iLe2PSqIpXZRnlhzPFgx5edNIfR
	e68nSrz/hPLtLjzM2jOucfpOz2zEe3coK8UgoWldcPC9nIdPk2vK3AmZSfqkOuf8rpm8xFCNAD9
	gzTps5rHj7TVUALHJdsBAeuguvL1dAD8lE8uU2hnUZg1oBjAIwR0wqJI4aby0nCQJ7L+/FqA2q9
	mf3DIGsAfZS/wO2AS+Wb4sWn4BZQscahxgCThpR398JQDeoOiN4hoe700nnfLBoBoiKqvLs73pU
	sp3NlAcjr2WWjpaCN6Cghc//4QAINexMXM/3dy+sC+aPGbSYi82Xyj714vcQgxxl6SVpeQ==
X-Received: by 2002:a17:90b:4c86:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-3342a79339cmr20563780a91.27.1759211501909;
        Mon, 29 Sep 2025 22:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk+a6mDl8c2+qL3qeaLAv52uqJNABRBj7IAceU6HekQdYrgLtRlf003i7wMY4GUWbM+uBw7A==
X-Received: by 2002:a17:90b:4c86:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-3342a79339cmr20563742a91.27.1759211501416;
        Mon, 29 Sep 2025 22:51:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:51:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:20 +0530
Subject: [PATCH 15/17] drm/msm/adreno: Do CX GBIF config before GMU start
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-15-73530b0700ed@oss.qualcomm.com>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=8532;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Ogi6WR+AUJ+HMPIbw08XT0QOUtgRv7szxAr4+cB63z8=;
 b=aU6ou0n3j1WE8uEgt6sbBfH2XVEzomkhB+50ezu00MWrg1u4DendU6H2/IFwMjJ3AqbO1/+Tk
 4O3wG4PUNXLA5tAveUm/OwwWZmwL8hNp+F+ifJwo8s9TZDD9flYqGuu
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 3ufRhnmZ9k6a1nKU9IGts22eTkbDnJ42
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX+N7nspTBLaYn
 wvT3QNSr68gMNmlnsmlMKoiAIZ1XBppRjxvLAx4aeiN0E7JRjo+k6nPP2Ssg6UavFgURNCs/3Q5
 O/os0KnGotSVnBboJNhB4ElSw9Ms2T21wW+4pgpKoYPqZZR8tNEXDsVMAcHuwkKV6sdk9fpzFaQ
 jizOZ+YH5+pVVYpb3Cu5qbIWpoo+uZSH8NQuEOugHoUGRKxSGzsnud4yQSccY4mX591r7KUuszk
 9+wk9GTTfzLEOUkh5gFmlyjQLIfs1bNHI2iibiuDsoHCssD0uBkSbaoBW3t3WwRC+xkI87PhNBT
 dMXmM8AWJ2ws9OoYLbdNqTYf6xRrySYpMJfl7MRV+V2DSluL+C1nkvKFMpXzrWAdoUD4UlXseSb
 YUgvMYsQa327TI8IHIrbbuEhFYiNtg==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db6fee cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YA97rT-oG-3-htpHkkkA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 3ufRhnmZ9k6a1nKU9IGts22eTkbDnJ42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
configurations before GMU wakes up. Also, move these registers to
the catalog.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 12 ++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 17 ++++++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 10 +++-------
 5 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index acd0ff2efde5ee9f1ccef7cf9f4d2793179a8b3b..b61354cb1eb87cbaafce92c50a4de740f3006633 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1336,6 +1336,14 @@ static const u32 a730_protect_regs[] = {
 };
 DECLARE_ADRENO_PROTECT(a730_protect, 48);
 
+static const struct adreno_reglist a730_gbif[] = {
+	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071620 },
+	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071620 },
+	{ },
+};
+
 static const uint32_t a7xx_pwrup_reglist_regs[] = {
 	REG_A6XX_UCHE_TRAP_BASE,
 	REG_A6XX_UCHE_TRAP_BASE + 1,
@@ -1463,6 +1471,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a730_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_cgc_mode = 0x00020000,
 		},
 		.preempt_record_size = 2860 * SZ_1K,
@@ -1484,6 +1493,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x7020100,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1518,6 +1528,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x7050001,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1559,6 +1570,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x7090100,
 			.gmu_cgc_mode = 0x00020202,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1591,6 +1603,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.gbif_cx = a730_gbif,
 			.gmu_chipid = 0x70f0000,
 			.gmu_cgc_mode = 0x00020222,
 			.bcms = (const struct a6xx_bcm[]) {
@@ -1789,6 +1802,15 @@ static const u32 a840_protect_regs[] = {
 };
 DECLARE_ADRENO_PROTECT(a840_protect, 64);
 
+static const struct adreno_reglist a840_gbif[] = {
+	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071e20 },
+	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071e20 },
+	{ REG_A8XX_GBIF_CX_CONFIG, 0x20023000 },
+	{ },
+};
+
 static const struct adreno_info a8xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x44050a31),
@@ -1807,6 +1829,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			.protect = &a840_protect,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.nonctxt_reglist = a840_nonctxt_regs,
+			.gbif_cx = a840_gbif,
 			.gmu_chipid = 0x8020100,
 			.bcms = (const struct a6xx_bcm[]) {
 				{ .name = "SH0", .buswidth = 16 },
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index f24b88fb8500a2ff2aef3afa9ecd5392c67e1bac..a176c0fd2e53e48b63b442455147425341309e2a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -872,7 +872,9 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	const struct a6xx_info *a6xx_info = adreno_gpu->info->a6xx;
+	const struct adreno_reglist *gbif_cx = a6xx_info->gbif_cx;
 	u32 fence_range_lower, fence_range_upper;
 	u32 chipid = 0;
 	int ret;
@@ -968,6 +970,16 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 			  gmu->log.iova | (gmu->log.size / SZ_4K - 1));
 	}
 
+	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
+	for (int i = 0; (gbif_cx && gbif_cx[i].offset); i++)
+		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);
+
+	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
+	if (adreno_is_a8xx(adreno_gpu)) {
+		gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
+		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
+	}
+
 	/* Set up the lowest idle level on the GMU */
 	a6xx_gmu_power_config(gmu);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 07ac5be9d0bccf4d2345eb76b08851a94187e861..e4e3e12fff952209aa831fb491bac42aa554b4a3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1261,17 +1261,20 @@ static int hw_init(struct msm_gpu *gpu)
 	/* enable hardware clockgating */
 	a6xx_set_hwcg(gpu, true);
 
-	/* VBIF/GBIF start*/
-	if (adreno_is_a610_family(adreno_gpu) ||
-	    adreno_is_a640_family(adreno_gpu) ||
-	    adreno_is_a650_family(adreno_gpu) ||
-	    adreno_is_a7xx(adreno_gpu)) {
+	/* For gmuwrapper implementations, do the VBIF/GBIF CX configuration here */
+	if (adreno_is_a610_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
 		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
-		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
-			  adreno_is_a7xx(adreno_gpu) ? 0x2120212 : 0x3);
+	}
+
+	if (adreno_is_a610_family(adreno_gpu) ||
+	    adreno_is_a640_family(adreno_gpu) ||
+	    adreno_is_a650_family(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
+	} else if (adreno_is_a7xx(adreno_gpu)) {
+		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x2120212);
 	} else {
 		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);
 	}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index a6ef8381abe5dd3eb202a645bb87a3bc352df047..e6c8b98ae16e998170d8f6eeabfe09b4af150946 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -46,6 +46,7 @@ struct a6xx_info {
 	const struct adreno_protect *protect;
 	const struct adreno_reglist_list *pwrup_reglist;
 	const struct adreno_reglist_list *ifpc_reglist;
+	const struct adreno_reglist *gbif_cx;
 	const struct adreno_reglist_pipe *nonctxt_reglist;
 	u32 gmu_chipid;
 	u32 gmu_cgc_mode;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 9a09ce37687aba2f720637ec3845a25d72d2fff7..9675769beccf6b6b22df2a688540fe826f9d2f8a 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -484,6 +484,9 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
+	/* Increase priority of GMU traffic over GPU traffic */
+	gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
+
 	/*
 	 * Disable the trusted memory range - we don't actually supported secure
 	 * memory rendering at this point in time and we don't want to block off
@@ -492,13 +495,6 @@ static int hw_init(struct msm_gpu *gpu)
 	gpu_write64(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_BASE, 0x00000000);
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000);
 
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
-	gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
-	gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
-	gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
-
 	/* Make all blocks contribute to the GPU BUSY perf counter */
 	gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_GPU_BUSY_MASKED, 0xffffffff);
 

-- 
2.51.0


