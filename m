Return-Path: <linux-kernel+bounces-805327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA86B48729
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70741604EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAAF2F8BE8;
	Mon,  8 Sep 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L++RGMzf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EE2EB84A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320090; cv=none; b=JNxN/rK6+aUSksrIBqxDzk+vNSX+TKUcFvxuYgvDKzkLT7q/vip1QoMW8G6Wdv305UWY/cx8BvlJUvDev1GNibCJA9C3kXLMqEfDGCZuIGYv77GqjXw9PKAJgblvFqyrX9iIsklLrqfXP8IVzqFaA9mKFhKU41xpkwaBe9pSdfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320090; c=relaxed/simple;
	bh=JP84fQZ5StXytXsVMM5Llki3XcWXp1F96tEU7pXVga0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hf5k1SEUKNK5hU7oL1nIZfTW/SEz5kMo1QtVRYfuJ4PRyMWvcekUVb+8PnWNaaEupVocYtC00cy4mxj2gD7BajoBqn9uh/sUXrGPh4JdQfZZiUoxKizlk0UEm9/2V5+GlFHSneEeE9n1fojz6ifP6RESMurcYm9GNUKdeHRKUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L++RGMzf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LsCl9013497
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y9+0w6aj+VovrkvZGEnCwhaFMPQwBRAyOTuHjX1iCig=; b=L++RGMzf4+i5QMbk
	HVQTrDGcieweY9nc7/oe3xuD4kyBVRiQkjB7X7NfM6AxF4Ae3NcTj18o2x0nrTJA
	YuYbr+BsNUqXhcOH+LVhfyE0ruUeFNLPwa/b9OoLCYpt61nl+j+xS8KLj0ffu+RJ
	QVjpvPtuCrf9mhw9yM1z/B6MoHyk+/eejBszs1kG9jvjK7gWmBEaO/85StJBQK0D
	ZpO9equwUTDmGOcTaJzshcz8GD1TmGMR/HJcBvhtqRymKc/rBz/+2cWXr3Y2GTB6
	DZPO+eDw8/5IHo6R3xkQzzXJGLChzxe1XGALuTBB5pCd2kdQnVRuigKvNGmRmbSH
	OR0Dlw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0ku61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:28:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32811874948so3626023a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320086; x=1757924886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9+0w6aj+VovrkvZGEnCwhaFMPQwBRAyOTuHjX1iCig=;
        b=FxxbycVHJ82RS2loImwqgCq8R/FbFiRcFtObLP5bQSSz3KZWpxXvk+UlP3PiWBIFVs
         JiubcAanekfJadFKcijLPEVIX8CWQr8NRXpqmq/FuwoSHfB58UPw2u8FpCA2Cw5hl7Lr
         nTvkf7WK+pgl+9p+QFOfjPhuvhnUybo3pNIUY6aOymF//6v9M1ha6x8W8lKxvyjDn+OS
         CMGjOWqg+73ufwINh7lNI0zZ1enjncMTCGTgjPt4FpHPuKg1GQPQf6sukn4hGGyNJly1
         IrZBLY2X3n3Obo+zPDAdofx4M7RkqF9hRdZok/qRQHgNnLSMAJlwGYmMnf8j6YwnXHrE
         qcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3fFFGlwuEwEBWuv5822ldpps+CZJv/QW60X+Qj5efTi8+osgUsugM/zpjcYP4FDZAq9M+H3vXic1QN+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VUdLywdvO3rC51Vu7389uGdrVBJsUilwnpqE2+/QmPA3Qwg2
	+mIwi22BizaPmqwGbj81ATw+nNHa4/RO3ZMbNmnOGAoa0Kk6G4HOdk/d6/0+M671g0Qn4tAlWye
	QumogIuW+S1w3cmIbWUnrqGUco3tERIrIuKHCjmN+VINkL9zJrIZk0RfaoL8MH7nPLjI=
X-Gm-Gg: ASbGncs13O06E1viH8y24d5JtIKhMjX9ahNA67fDZRqHA6rH8+E4sHVkrrdz0Qneecr
	Z4DbrAdNP1ET3upuhkIU0+X+YRKctD3Dxz7xaQJIKhM8/MsGd+YwMSeBmReEHrTNiz7sLD1nKuZ
	vJ+vI4zFGrqUbIR5zVo5Erv4peEdhAKOygHnIbQjn70KEJxGXOltlzgYbN+kovkmnAKx7Zo1Lth
	mSgTML3O0kyz8Ot+6/d+PV/GpEiO4F01RlUQPYqG3gekl6VupVUhzBH5CVeULdBThEJ3Cl7maWN
	HvCDMlHIT4Zkhe9OBuhQLlRbRQ6sDNUeTFXVvwI0gAYsxsz0hT8E+jooPApI/UH+
X-Received: by 2002:a17:90b:1343:b0:32b:58d4:e9d0 with SMTP id 98e67ed59e1d1-32d43f98ca9mr9661454a91.23.1757320085850;
        Mon, 08 Sep 2025 01:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG48xqx8usx8On3LNc8R0d6aOc3he+bmmqnXldSJTuYe4L9QKMkwfBMWCQU7leDED5ti62huQ==
X-Received: by 2002:a17:90b:1343:b0:32b:58d4:e9d0 with SMTP id 98e67ed59e1d1-32d43f98ca9mr9661406a91.23.1757320085236;
        Mon, 08 Sep 2025 01:28:05 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:28:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:57:03 +0530
Subject: [PATCH v2 10/16] drm/msm/a6xx: Poll AHB fence status in GPU IRQ
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-10-631b1080bf91@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=3161;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JP84fQZ5StXytXsVMM5Llki3XcWXp1F96tEU7pXVga0=;
 b=LUsR+1o2QFjjj1wszOZBM2K/4buHS5h/22KptVTEaPnZgom85L4OkJTAc+9iGWqfJJZ9neMGZ
 1wvGFoFffvxDQH89Z9ppr4a3DtDHgPViBiVvhp22e8yXWmes4TkkLZe
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: mDY2MMmwwL617RoDNDhWg0FK24YTwxaS
X-Proofpoint-GUID: mDY2MMmwwL617RoDNDhWg0FK24YTwxaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX9fQ+75dH+B3J
 6P1mPUhzOBiC3+vOGBqOos+z2Zl3hlPBPsdXl0KetyMuXbISKo6FqJLxwh+V1aQVjRQXmH+g6yf
 VneDA5GJKo55kHoSE1s9VYJdIUAj1jX6BY7XFuqQmB+tewXjSzl+lblg48N6m3Qm8tZdyoTajc7
 amL7HskOB1Ij9AdedxDgaM1RwwEVVYiULMJmkRnVk+L4VfW5EkWez4ToiesQp7bh4yPtKocYmv7
 TeDKqSTvZ8Y002DZq3y+vA77YoON++wuLnxdZrzPFhF/dDuQQ7U7h9QZ/d5BdkYSrADo2dJ47Dl
 hxBsdg4ZukDWKzZR4ZMKtEkRsOgJKm4YzSTCPls8IzmjcVes4uD6E/gxkBl3eAbSNSiUlYvbz9x
 Ea5uWrcU
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68be9397 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tkQJxTYZj4y7NR_BhXkA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

Even though the GX power domain is kept ON when there is a pending GPU
interrupt, there is a small window of potential race with GMU where it
may move the AHB fence to 'Drop' mode. Once the GMU sees the pending IRQ,
it will move back the fence state to ALLOW mode. Close this race window
by polling for AHB fence to ensure that it is in 'Allow' mode.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  3 +++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 9494bbed9a1ff86b19acec139d7ab27697d7ec8a..40c4c0445b8e4349c9111850df9c0b1d355f0b73 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -167,6 +167,9 @@ static inline u64 gmu_read64(struct a6xx_gmu *gmu, u32 lo, u32 hi)
 #define gmu_poll_timeout(gmu, addr, val, cond, interval, timeout) \
 	readl_poll_timeout((gmu)->mmio + ((addr) << 2), val, cond, \
 		interval, timeout)
+#define gmu_poll_timeout_atomic(gmu, addr, val, cond, interval, timeout) \
+	readl_poll_timeout_atomic((gmu)->mmio + ((addr) << 2), val, cond, \
+		interval, timeout)
 
 static inline u32 gmu_read_rscc(struct a6xx_gmu *gmu, u32 offset)
 {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c64c84affa6821f79ea74b80b2f2014df38ec918..bba09c02f9809ed24b4a9c30b1eb993ce01c7ec0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1842,6 +1842,28 @@ static void a6xx_gpu_keepalive_vote(struct msm_gpu *gpu, bool on)
 	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, on);
 }
 
+static int irq_poll_fence(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 status;
+
+	if (adreno_has_gmu_wrapper(adreno_gpu))
+		return 0;
+
+	if (gmu_poll_timeout_atomic(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, status, !status, 1, 100)) {
+		u32 rbbm_unmasked = gmu_read(gmu, REG_A6XX_GMU_RBBM_INT_UNMASKED_STATUS);
+
+		dev_err_ratelimited(&gpu->pdev->dev,
+				"irq fence poll timeout, fence_ctrl=0x%x, unmasked_status=0x%x\n",
+				status, rbbm_unmasked);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 {
 	struct msm_drm_private *priv = gpu->dev->dev_private;
@@ -1849,6 +1871,9 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 	/* Set keepalive vote to avoid power collapse after RBBM_INT_0_STATUS is read */
 	a6xx_gpu_keepalive_vote(gpu, true);
 
+	if (irq_poll_fence(gpu))
+		goto done;
+
 	u32 status = gpu_read(gpu, REG_A6XX_RBBM_INT_0_STATUS);
 
 	gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
@@ -1885,6 +1910,7 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
 		a6xx_preempt_irq(gpu);
 
+done:
 	a6xx_gpu_keepalive_vote(gpu, false);
 
 	return IRQ_HANDLED;

-- 
2.50.1


