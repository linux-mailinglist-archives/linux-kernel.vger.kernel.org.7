Return-Path: <linux-kernel+bounces-759160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7BAB1D95F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814C918C53B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E59257427;
	Thu,  7 Aug 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="At4XKK7p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BE204583
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574669; cv=none; b=TBe+BOve3kSEW758pdkCiiX7isZ9Jcq7yyK/1gDqWb1fhGinFjd0XdAUa5H7cypBjUMGifirCJaBpM1dLUpkU0p2rhzJ8mGTarGlLhSlzj6ygtWCXZgs9MlbbTV2xP3uPsaVeg/ip8w9GHLbL1yn83YGDYLnG415vKZ+5oLouO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574669; c=relaxed/simple;
	bh=lEjzv6Q2sce3TtT8oygCrHfS3QGBSOpkfnjE4V4tuZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMZJ1GisioMEVNKrAi/GV7CI8MAhTqS3zUTJXt5MuwalhP8W2iN2oItIsxUc41gj/LEOXDMDU5a+n9/AZme3AyhAuC7qmatVRve2sskttEyjdWkCd1FuZyBJKSGWBvftI54/uzsdTNBk0wDDj/5CnCvmagT9OM051JzrxmhD7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=At4XKK7p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779CuoK018681
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 13:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJaOnJPrQPzYB5QLyB82PbBYQ3YcFtLHpT0PXF3urfk=; b=At4XKK7p5ORvOQQc
	dzZBJJx1j7ulVqMKhjIUWMmK8HwTpD1MdfEME1TAvbfys5RL9pJXXseh9Bq4rm+F
	qXOkcwt4s78uQoGgVyCdtv6vsHLIDgI8s4WWdRC1vlHSpqtxNrIRZHCgarYmLQg3
	lDUUshPXfXg9m+2eQP6VWtoGJWGsHC74b1anYhoS4h7Sv9WiIJvMSjEgUd3YjH49
	ZRqAIL7IQYlMtJclt+OkcV6Meq4q3tntXFoe+ttkPiPe9FLrBpIo5B6O7A2k6VC2
	eOGqtG+SdYT0VCnqJbXdhhi59qIZ+7MYCD8TQgg3PcJSRf3c4Orfk4n3CedGfUrL
	q7TSOw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8eekc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:51:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7074b13178eso1559116d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574666; x=1755179466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJaOnJPrQPzYB5QLyB82PbBYQ3YcFtLHpT0PXF3urfk=;
        b=ONGSEsxiCT4r6f1fLl5Zd0CGyz40MjoRX9nwwE96S4iwhlh82tTuw3orjQ4f0ZDCME
         ZnLWgwEHnvhfO8MpaUt9H5irk/uVRL/PQw5WKw9NTlLQ33Fg/mbWQofnJMAn00C1gIo0
         7WNw3f//A+ydpV23tFNJm9KDNkQzzJ/yNzEh9KPZiO34inBgh1x7U24KQbXTsyJscSKG
         yA0KXrInuMVqnHAHR8sOAjfHs9K5JdmG2QBwsgDLyjiaf/w+28sGyvKXHwYvtVo8APDh
         ATAGGjihdFe0DtlL2xjgMNN4B5+umvsHxKk16nJVexkdY9O4xJYbMTbP8/cZ/xA23ZXg
         NQMA==
X-Forwarded-Encrypted: i=1; AJvYcCU6NR83F1yfPna6BTbx5CIsCWbvsIgeSWPQkmVT6HG+jJonkODGuRmuuv5r3aWSE4LVDBZ7/JS2KgadKGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRjaa2GsVeHkm+2v2EP93Arux/KN+S2NeJQb1IChdCGO5ZGTC
	9/Q7EYAPQO1YEe+op6WhPl5TWDfHdb0S1yq8rupnaGFjIoH7RM6+FW8Kz/PeFMhmBNbZGM49VWa
	2lL9pTqYP5RqKpLKgLzHFsBf5nE7vANnW84C//TIS+OyNu99E2uF/BN3mbxcI60CYh98=
X-Gm-Gg: ASbGncsKvmJ4gZHEIE3R0/IClnvRRK9De5155+KTqqEwo78Mpzm4GuEUhRP3oE76cwh
	S30AmcxzDwyX/jqXkcFJBZ3m5+1vT16N9inbE6WZ2+Ym2He1uO3TwyiYOH7lPR+JEFPhS7Cb5sh
	rupGDfVivJnYJLVh50nBrbEstqPXsoXmlekELjTchzDisbm8uLR65JbbHsZqIxq9eH6FI227HbS
	3ZlN/RtVDLLiWxtfLlnkkYlfLLmApYxHeoDGf1tRjPe+T3QtmRli7hj3X9cDH/ULcFKlnZxo/B8
	bdie4oTrz++djC1yVJSijT8ucbo1PHdQQwCp/iNiEl0cjQFt8uGOm4DhIUs2zTPQ+y1YC/iuG+G
	1R2suwuiQRU/z4LTgzQ==
X-Received: by 2002:ad4:596a:0:b0:707:1654:ced4 with SMTP id 6a1803df08f44-7097943f2d4mr53232786d6.0.1754574665956;
        Thu, 07 Aug 2025 06:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG05izQ2F1cJL0JtNMoakn9YJ17uRV6nsijU+bcL9wSJdmVXy+nD+ZxHapPlNUdAOzNVzIiHQ==
X-Received: by 2002:ad4:596a:0:b0:707:1654:ced4 with SMTP id 6a1803df08f44-7097943f2d4mr53232626d6.0.1754574665396;
        Thu, 07 Aug 2025 06:51:05 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15a66sm12009012a12.16.2025.08.07.06.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:51:04 -0700 (PDT)
Message-ID: <937197e9-09dd-4f3c-bdb4-4001f5217c07@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 15:51:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wwV8zTTj2Sp07B3WT689LkwZT0-ikv5h
X-Proofpoint-ORIG-GUID: wwV8zTTj2Sp07B3WT689LkwZT0-ikv5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX83Gg8yrWk2Zq
 uYGJhvbMqAL4SgHT6s3Zh9XLhCdvcE2zhzd0x8zdu9fqxNqjxfTnBwsdsFUfs34PHG87Q06whn1
 bEgbaO+k60Z4EHDgvzVOcMTHYjHavjMME3S/OsqMKLzlySIIe9jO7/zLkuZ54W1I4G2+rauDgMH
 ztWS6CQO1iDiTj1D1iWlMMI/9VN/m3XHa2VFhqrlZnNurOAp0yNSdk44vZOia2CNgc8RNEkiEY+
 SEOjUNYG/+V7puldvJLR78OImLCOgHkBR1kD2TH1eFeIpGv2WQPTavDg4CfgHXx2b10DuiJsIMN
 uZ5Hf+IyluXT8xivzxC4eC7jMpox4UZFgW8IszBUZ6mk4zHcqtgYLgtPX6JmHPcFuTjN7BBbLCw
 LyOQ3YZW
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=6894af4b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=f2c1g6THgo9BaYdya5UA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> Since the PDC resides out of the GPU subsystem and cannot be reset in
> case it enters bad state, utmost care must be taken to trigger the PDC
> wake/sleep routines in the correct order.
> 
> The PDC wake sequence can be exercised only after a PDC sleep sequence.
> Additionally, GMU firmware should initialize a few registers before the
> KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
> GMU firmware has not initialized. Track these dependencies using a new
> status variable and trigger PDC sleep/wake sequences appropriately.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

FWIW some time ago I made this patch, which tackles a similar issue,
perhaps it's a good idea to merge both:

From 7d6441fc6ec5ee7fe723e1ad86d11fdd17bee922 Mon Sep 17 00:00:00 2001
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 10:28:51 +0100
Subject: [PATCH] drm/msm/adreno: Delay the Adreno RPMh startup to HFI init

There's no use in trying to power up the GX logic before we're almost
ready to fire up the GPU. In fact, with A8xx the PDC and RSC uCode are
loaded by the GMU firmware, so we *must* wait for the GMU to fully
initialize before trying to do so.

Move it to right before HFI init.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 12 ++----------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 28e6705c6da6..3335583ada45 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -513,7 +513,7 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
 	return ret;
 }
 
-static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
+int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 {
 	int ret;
 	u32 val;
@@ -842,19 +842,11 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	else
 		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
 
-	if (state == GMU_WARM_BOOT) {
-		ret = a6xx_rpmh_start(gmu);
-		if (ret)
-			return ret;
-	} else {
+	if (state == GMU_COLD_BOOT) {
 		if (WARN(!adreno_gpu->fw[ADRENO_FW_GMU],
 			"GMU firmware is not loaded\n"))
 			return -ENOENT;
 
-		ret = a6xx_rpmh_start(gmu);
-		if (ret)
-			return ret;
-
 		ret = a6xx_gmu_fw_load(gmu);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index d1ce11131ba6..309305298a45 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -216,5 +216,6 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
 void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
 int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
+int a6xx_rpmh_start(struct a6xx_gmu *gmu);
 
 #endif
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 8e69b1e84657..9ea01daf2995 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -910,7 +910,7 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
 	if (ret)
 		return ret;
 
-	return 0;
+	return a6xx_rpmh_start(gmu);
 }
 
 void a6xx_hfi_stop(struct a6xx_gmu *gmu)
-- 
2.50.1



Konrad

