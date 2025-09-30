Return-Path: <linux-kernel+bounces-837153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88FBAB8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE618995BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167492848B5;
	Tue, 30 Sep 2025 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gifKMrKc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814328469F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211451; cv=none; b=Dz9IzM2fVm+Iv/P7EVXoZlWV4qcNdhl2WhvkGKf5lr9FB0KI8cpRhxUEblwkkPYMNbyPspJJHHaYQ72yfJtJZjTns1qUW7SEOWpj5dsfEs7xu++QO2vKCc3Jl2+R/Jn+DCjqybmfNTq5nHk1A/JtIVkwvxeasN0f0B0rzMhTV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211451; c=relaxed/simple;
	bh=iTx0Dgw6/NGdDmnjDpXwtxM3ls+MrtO4sIvE3+opA2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ts+Ny5bn5Rqq4aEaGEjkcMarwZFREYwxJglSFQzOvRe58R2p5lMIPpFcjXySJ/2muftIP/ghcd+zyc2StgorWoH8rA/X3PFKIurl2bvnyTb+AbIj/Jmb3+2bmYldxq6I7Jo+4L73VqHgtHpfiAZedlBssQJZWXZHzgXhQIhIDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gifKMrKc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4IJr6018092
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hUYDtG14iwXt6CshtaDwxA9smtoMJnlMfawF2rRoaMg=; b=gifKMrKclxrtGxLk
	4rBp68Bl5B0XrOiBHgo+Ek0HHOeetPON/+M+lYt2jf4elx+NMkNH2DQcgy/w3qFp
	v7osQynKfDhFxD0Qx1W1tQgtLFxRDTe8pc2jdzRaMS39dfJcqu4NEqn/aYhq1tkd
	OtmsZrfIrMxPmtCG3Ym1+/oM8JcIds+wGGQHvdXcH0VX2l2QdWMZfTi1ZIz8ufnP
	C9A1zvQ8Wehp/JZxQN8PVbTOGIa/SErqVUcDj1UqjAWl7mGX319OwnLPCU6+nDUM
	75CKEeaPghDkO2EJ1e4TY64P9zsGqxdlnZDzFYiv8VO++0293ceG4lKOkG6uxeYh
	MHBNcA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hfhwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so4819736a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211448; x=1759816248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUYDtG14iwXt6CshtaDwxA9smtoMJnlMfawF2rRoaMg=;
        b=aS9ya+Ul6twuUSAZy3/bO8Y51iIIVOC9w/xNYP9kRkxnSz0oU6QetZeu+7xyW2u+s0
         BB608cIYuLb2x+E1ZMyXk38+JBnf8efnmDowPmh5fKccm1b04WPcM22O/4wxZ2ZijHxK
         3axstd9xUvZ+8YVms+mq5klS1+O1IhLQ0YgM4LLLQEpYplG9AGJ8/23kbOXwi5cZTO5P
         9Ik5y/S1IMVF+66+jfI+ynQuE5YeIjvVhlLW1gZpTmvzlidbLxvH3otKeitGVpTh9cPb
         W+dLUoq4e1/Bms5vIS2TbeL6NiupZ2W6p6npHXI2fYeBhISjX16vYb/4iJOAtU8yjlUY
         aJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7YD3glPtWW3FlaWU0o/e9StSdRmPW60wQ3ys/zrHxmSAS5G4GXGKxtMGq+k+ABLq/Rg6suAsiGYXSFWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuVgDQtAHscQstOoGsQLeq9UIS8VTQXZvCjdjYXCwaZjGuHnT
	lKF7SY3LuAl010cRcwstE/LxFYjYgOadL5WNf8CaYRh7DvJw1WA98ZhpC1gD+hUs3L31cIUK8oF
	/Vb/sgygoRfL25SgPKFVJ9gkS3b1022qM4e1wAkcFxR0GCXEAZq01NxN2IZ+KdJKhDRw=
X-Gm-Gg: ASbGncsmPMozFa6k44MiZAI8q+V7alegsgiykxkjAO/u0yYUyF6GXQa6EdGgZ/g9VGF
	FQPfMa7SO4kiDUA23UCai2oydxJTHiYos5EbfmtYW45ag+YbhYAEk0xneDrdsndIcfn9hl9NK5W
	asoHBo73JFJbddExm8HFfxn6mDuFK3xqrm2VQ8eNEJzMxLPl+bDuZsboZ5/B6SiwZWQ3iK8jKKD
	kbjsDKzpnhWEa0t6qZjl92gvJ7HnhY/Li9z6Q2lEoJz4qCOb/HJHt4Mc11/qE76CCLqjVG7fBXi
	qPdQ9hdqqlsp4+EWNVTnSwaVhNyzf5tocD4x8rPJJMmg0ZmWwvs6q+9RxiYz5JIozYjc5Q==
X-Received: by 2002:a17:90b:1a86:b0:32e:e186:726d with SMTP id 98e67ed59e1d1-3342a2e08a1mr17586677a91.31.1759211448073;
        Mon, 29 Sep 2025 22:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBv29jZXzsR2GHyzv4/aiF55cKo23OPq++pHW+jUt6OPLZ0TQSWk4QbBrVwj5PowUQlBWBaw==
X-Received: by 2002:a17:90b:1a86:b0:32e:e186:726d with SMTP id 98e67ed59e1d1-3342a2e08a1mr17586627a91.31.1759211447597;
        Mon, 29 Sep 2025 22:50:47 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:50:47 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:13 +0530
Subject: [PATCH 08/17] drm/msm/adreno: Add MMU fault handler to
 adreno_gpu_func
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-8-73530b0700ed@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=2518;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=iTx0Dgw6/NGdDmnjDpXwtxM3ls+MrtO4sIvE3+opA2Q=;
 b=MrGaWbf42ncH24JynsUmGMasa2mINaJed6eMYoi/gzz6Y7t9s0yIQ5H8PlIqlwA9cPDCLVgVF
 vIbOkIclF6NBtnDJY0fAqoMVfUB0LG8GNmKX4udlGZcehELqKzVLBu/
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX9m0et5SpK/Lr
 48aNRPn9EXzmrqiwalVg4EV/0h8CzUmVhXdaDVWwKwq3BEZc8JaSKq8kWWyMsuFt42yPdvNOZQs
 8QD9JzV3/DJW1r885mvjdJN+4lqxZEUInTX0UpomIL9zCA5MW1ho5zzVbFXU5WkJk0VpPlhzT5p
 catN19DrbwFt+qJXkz0IeMazlfXXkAkICQVFnjP3pA/yB/Ay0JQDceM4BVhaujGz58Y1skkHKFS
 M/T0rWvFmGfOJDTFWv/OGm+W3JtEBoWdh4yKSvU4pvFVsdru/CteD5jhhFnTj74bcwh9TTHT6/2
 +cu6ujjgYqkazaRmNgt7ZSI5SU3UUjke0sYw/U/cDMorozvvCrfujjD6tUFHKWIklaQbCE7MgV+
 BbTxK/xT42NbOSX5Erfmr8z9uGBnKQ==
X-Proofpoint-GUID: Xx0MW5SGJPV_LnToABZq1PD90yanUsI6
X-Proofpoint-ORIG-GUID: Xx0MW5SGJPV_LnToABZq1PD90yanUsI6
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68db6fb8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=s_9S_yPA7-Eg1sbpcaoA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

Move MMU fault handler for each generation to adreno function list. This
will help to use common code for mmu pagefault handler registration between
a6x/a7x and a8x layer.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 5 ++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 02725d28c607e7815587e9589c8344da3341c78d..27168f3a7264f2651cb41c8d59e6dc80ddba4262 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2613,7 +2613,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu->uche_trap_base = 0x1fffffffff000ull;
 
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
-				  a6xx_fault_handler);
+				  adreno_gpu->funcs->mmu_fault_handler);
 
 	ret = a6xx_calc_ubwc_config(adreno_gpu);
 	if (ret) {
@@ -2659,6 +2659,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.submit_flush = a6xx_flush,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2691,6 +2692,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	.get_timestamp = a6xx_get_timestamp,
 	.submit_flush = a6xx_flush,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2726,4 +2728,5 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.submit_flush = a6xx_flush,
 	.feature_probe = a7xx_gpu_feature_probe,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
+	.mmu_fault_handler = a6xx_fault_handler,
 };
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 991481adf2261f09912786ada3574f9f144953c0..b27974d97c7512ecae326eb2d22238330d6c52f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -80,6 +80,7 @@ struct adreno_gpu_funcs {
 	void (*submit_flush)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 	int (*feature_probe)(struct msm_gpu *gpu);
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
+	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
 };
 
 struct adreno_reglist {

-- 
2.51.0


