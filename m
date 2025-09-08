Return-Path: <linux-kernel+bounces-805331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25882B48731
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0551516B7A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F22ECE98;
	Mon,  8 Sep 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hoVmBKWL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B42FB093
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320107; cv=none; b=fFG4gjPZBxSxKNRRa+i0qMHUKNON7gnhFVgnqNYmCfh0Pi6sJezFWevELGFIcR5EZ8WnfTs4sexMgY9r1f/DUjU9PumFR7gv16ULnTXWjYVrkHVtMZ58q9pl+Svov/v5ft2NWSYgUjKSD3L44l83nxl7dOMXh09o0iajzIszHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320107; c=relaxed/simple;
	bh=RujJUh0j4TEd2cIlAXEv6xdDosDvLPvDu1U8gcvWuDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GohcEuB/MOYMFxarA+jOTiFot4zg/oJ3WtxoOM4lzZjSGbIrGZ7qrzCKM7Fc/5Jc8NHNmZshwHTEinD2bS99HtfvMpRROkDnvrDr7ozhCCi6NZu4Whe/7FxRfhE8AhcsCxXCSOgkIBul0nCa5xvsWb1QkPNtPuKJfAhDapDP2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hoVmBKWL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NkEiv000692
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xqC7Zy6ivxrAZNOluQq2nuWFwYW/k4m65npdWDnVVQ8=; b=hoVmBKWLwzy1eYqU
	v0eb9D8MOdTyHaLmDMzqaIxahQ+ODRYx04pYNp+aB1tl21xhPOSUdVmFieXf9WEy
	r8w5lnPmbJ3+dW51NiavAI+5paOGVSVVfmGaIHX4zm3YXl3vKJhtlBFdZ8Yqs/b3
	KZDWFY2asSMQsT/+QvfcF4MsM4qIBEqA9yzDmZSiGQqx4xAIqQpWkhQl9x0kbcJm
	h1ty7WyiUxb82GdmddRrAF3X3hiO9LmELDLBT2mF9Y07Twkj+x0k/2znsho5KZXh
	Zh7RzQE5pXYn5NDr8gE7jT39DBpnjxaHC9Zm+Z3tBLwXrYOgwp34tEraMn6jZhY5
	GzGIfw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws3vc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:28:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7723aca1cbcso3931321b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320104; x=1757924904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqC7Zy6ivxrAZNOluQq2nuWFwYW/k4m65npdWDnVVQ8=;
        b=EGXrYWbi450t8EfocgAKiuVxZH0jawoWDabJxKYErYk6Q7/gaENemuxfgFx1RBWJtr
         PArtg25D5KT2bNVX1dwcPA8w/Gfuk/3zsWoQYzIVXRKoXEALILEz+xZpmyMWkw1+rcGG
         huwTvJ0ce8DUrs834VrcC4NvOHi/i59AZjNZJHpAVBM/V1w/xMEErohr5p9kMjFur/qB
         F0a6p8E1zqOImbGnPIxLHR3cpk4tCPGDGr2vvjvbzROYP95jfaabnZJoYXfLcW4Wy2t5
         vgKUolnNEkbKvgk/Eu1vYFb/bTznHI0qfAHB8eVlFfRkYUvQ5Z8ncel3v2dniGLRLSas
         JG3g==
X-Forwarded-Encrypted: i=1; AJvYcCWsczfvyEQ9hF/u2KsBcenQD1vFsBXDoSA/ZdUnQHqhHqGCaSLachmWokj/s0/BY05zDBekWx/3o/SMzwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXcwP48jjgNng8qCppYtgM9t5ONxG6VXLN+i3EvBT4K32l030
	eqfYgRl4754wlm/6qrnITj05DhCLHXcj9BdOmLuvYSvr93D9VcxeA0TZ6dvYdzeUkoyf3sHjeMA
	9j/JE0gQjOnIgdsypGOy7I0DheKie9i1z/I/zHnZMGqM4Y9Z1gV4JuyfIR3H2Ln2e/Ts=
X-Gm-Gg: ASbGncsSwpqa9jrJy5/CLW1T0biI8t+X3PNRFXQo0da/AiP0rPA8O9GS7X6dzkxnAlY
	HvibxnSgH6drQBU8LuSwmJEzY2JXDc3akXJvQpdTQucQXGxetcgFRfgk/fKP6Ijo/tE0QomNa4g
	jlclrGd0ZvT445pqWNkLSqO/nVZkswwmXKfbXNEIrXsfARoTaQvtwLKD/ifbWl0J2tv4togyi9d
	FgD/tWSQLwHOhGAU4TTYoTs3I01OyaXciamu0KC8Rqkb+uw9p3hPgpY7WWoWzu/cnjBvbB2w+U5
	j6tPMG0wEr7xDTq3gRNnU4nS75TJcguYYgqpRkeQBPffQNBypIeI17HXQbe2vzzc
X-Received: by 2002:a05:6a00:ccc:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7742dd10e6emr8094347b3a.7.1757320103575;
        Mon, 08 Sep 2025 01:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVxoyp2PRB+QVncUti3N2Wj7nrXH65ckYK0eniIMm9C8JT1Cyw/QQPJ8BNF4g/yzey4I9VCA==
X-Received: by 2002:a05:6a00:ccc:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7742dd10e6emr8094308b3a.7.1757320102764;
        Mon, 08 Sep 2025 01:28:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:28:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:57:07 +0530
Subject: [PATCH v2 14/16] drm/msm/a6xx: Make crashstate capture IFPC safe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-14-631b1080bf91@oss.qualcomm.com>
References: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
In-Reply-To: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=4450;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=RujJUh0j4TEd2cIlAXEv6xdDosDvLPvDu1U8gcvWuDk=;
 b=5wro+WXTeqUixun67HjZQHEfABVu5UwSfZexitnxpMZK1qDmqI4AcxqupwnbNFFAEV9nxDgAC
 ix3JnxBJNeeDvaqbrFlgfHPOoaTjF5SNLyOGy3hjlTLZwtzr6q1qA6P
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 3MLU-NOX21MNEcIubrLfyAn48zugfSrh
X-Proofpoint-GUID: 3MLU-NOX21MNEcIubrLfyAn48zugfSrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX1gwOWhhJNBiP
 8KUx1ynxG5zwBQ+qOpQ7tFIqNR+8GGozMf5fnqdNsYk4CC9z/hZ+ZJDJcyeuLLAf+49S1+Gy2dJ
 ymEIWd18cF/RFrGFNXLNKNxtGZNANX5iOQlU5/pKTODhMGY9LnXlurwzJLMOUqmC9i1q2tttwIY
 N2sLtpm4XXhkz87ee/auzdSB19jvybW3BlbDwWK3k6x4zLzeXXUXDCmhCnDqDkfcOQ63sak2Uey
 h9SFjUwHtLSOLzAhIGV6loyWqcWRC9iN+ZeF/DCSZHFYxnE1dYVUbKY/NCDCd6NzcWViHzzx785
 cyDJDZWHn+biL58Oc0bYLR6Gbpmfn0D8PootrH8DN31x+z9ctYy8sWOTu+vEFlDdEovPYSI2CtM
 KciaoDD6
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be93a9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yKEZsNg54XTt07RPwjwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Now with IFPC, GX domain can collapse as soon as GPU becomes IDLE. So
add gx_is_on check before accessing any GX registers during crashstate
capture and recovery.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       |  4 ++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 27 +++++++++++++++++++--------
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 10 +++++++---
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index d76b6b766d4a644d342f62435892d54ebd7192e5..81076349d69c8c13e6c6b4e1c336c2d990ebda6d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -101,6 +101,10 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 	if (!gmu->initialized)
 		return false;
 
+	/* If GMU is absent, then GX power domain is ON as long as GPU is in active state */
+	if (adreno_has_gmu_wrapper(adreno_gpu))
+		return true;
+
 	val = gmu_read(gmu, REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS);
 
 	if (adreno_is_a7xx(adreno_gpu))
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b54c88fb27d57f81306163e699961803ff765bdb..76dd78f5c48ea818a2aa209e0c0c88bc5e8f4e06 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1537,21 +1537,25 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	adreno_dump_info(gpu);
 
-	for (i = 0; i < 8; i++)
-		DRM_DEV_INFO(&gpu->pdev->dev, "CP_SCRATCH_REG%d: %u\n", i,
-			gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(i)));
+	if (a6xx_gmu_gx_is_on(&a6xx_gpu->gmu)) {
+		/* Sometimes crashstate capture is skipped, so SQE should be halted here again */
+		gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
 
-	if (hang_debug)
-		a6xx_dump(gpu);
+		for (i = 0; i < 8; i++)
+			DRM_DEV_INFO(&gpu->pdev->dev, "CP_SCRATCH_REG%d: %u\n", i,
+				gpu_read(gpu, REG_A6XX_CP_SCRATCH_REG(i)));
+
+		if (hang_debug)
+			a6xx_dump(gpu);
+
+	}
 
 	/*
 	 * To handle recovery specific sequences during the rpm suspend we are
 	 * about to trigger
 	 */
-	a6xx_gpu->hung = true;
 
-	/* Halt SQE first */
-	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
+	a6xx_gpu->hung = true;
 
 	pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
 
@@ -2412,6 +2416,13 @@ static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	if (adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami)
 		return a6xx_gpu->shadow[ring->id];
 
+	/*
+	 * This is true only on an A6XX_GEN1 with GMU, has IFPC enabled and a super old SQE firmware
+	 * without 'whereami' support
+	 */
+	WARN_ONCE((to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC),
+		"Can't read CP_RB_RPTR register reliably\n");
+
 	return ring->memptrs->rptr = gpu_read(gpu, REG_A6XX_CP_RB_RPTR);
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index d5d1271fce611b60121b36f4b772d6f5e0093d2b..4c7f3c642f6ac0a397ac3b282966d25cd4488d3e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1586,8 +1586,7 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gpu_state *a6xx_state = kzalloc(sizeof(*a6xx_state),
 		GFP_KERNEL);
-	bool stalled = !!(gpu_read(gpu, REG_A6XX_RBBM_STATUS3) &
-			A6XX_RBBM_STATUS3_SMMU_STALLED_ON_FAULT);
+	bool stalled;
 
 	if (!a6xx_state)
 		return ERR_PTR(-ENOMEM);
@@ -1608,15 +1607,20 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	}
 
 	/* If GX isn't on the rest of the data isn't going to be accessible */
-	if (!adreno_has_gmu_wrapper(adreno_gpu) && !a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
+	if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
 		return &a6xx_state->base;
 
+	/* Halt SQE first */
+	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
+
 	/* Get the banks of indexed registers */
 	if (adreno_is_a7xx(adreno_gpu))
 		a7xx_get_indexed_registers(gpu, a6xx_state);
 	else
 		a6xx_get_indexed_registers(gpu, a6xx_state);
 
+	stalled = !!(gpu_read(gpu, REG_A6XX_RBBM_STATUS3) &
+			A6XX_RBBM_STATUS3_SMMU_STALLED_ON_FAULT);
 	/*
 	 * Try to initialize the crashdumper, if we are not dumping state
 	 * with the SMMU stalled.  The crashdumper needs memory access to

-- 
2.50.1


