Return-Path: <linux-kernel+bounces-805325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30964B4872A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7C6189D18E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A22EB868;
	Mon,  8 Sep 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iX3t+CH3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAF2F7AAD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320080; cv=none; b=r1XhBsJF/hUs+cu0AbZzZ0OfYD66RWSSY4NHFu/+SRbDHNY8xY1brFTSZwU9+d8R3v0vq79Z2il+22JP7pFOX6j73YLQhuerutIGs25H6sEqKbXEFbHcgX+pQ0IL9EwfxPOM9uWVHeqixC0zAahNHGj7TkAlq4PHm3Q2mqrWrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320080; c=relaxed/simple;
	bh=IMBo6N4wzsS8MDmukZdsfvnrZM7EWF31g5XLtxm04N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIiEH3f1wRXLKWrBOH8tCTfaDlEcRHIbTxjulqZuKKk1vqM6kIinSj0QXXsONHbFCS9KolLRg5MBTqf2wmkTVYP3j7BGMEEWF8e1oR+QlGgO3gl0vs2HGAIPzcx5Rf601N5myLpzztZWAU/FTWxctpjygMGG1BPRGupAeTdjJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iX3t+CH3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587JjFVT026682
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7S/gh1bczo3bWqSmVPBhR4GIaagB0w6uTNlcN/zUrto=; b=iX3t+CH30bsAcldE
	TcZmu7UIZKINgPzcGdV/H07bTHImQbuX2wKBAA2v6+Siu4wGk7aK8p82r8zbKOPQ
	AlfLIw34/7Zt/Y01LJd9WTGwEV3PNbzL0j5L3s1rHPRl+tO08EGeWI9/8mPjQQE3
	692jN4xXziXPvAjkqMhIbZSr55xlQtvLCTATdHQRKpBerPZxYyb4Ep/BjZL2wd8p
	sr1FTUGfuS3Z+AS3+7rSd8OOG4FIIwLUdPHbxXkzKRjHNskoUR8VYvHIn+ioyKiT
	9Unpv7Q2YT++okC7Z95gElY7rQ57h/oId68NvNOjME0buQuV9Zpj7od0pL2OEUQe
	tRNsyQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws3v9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:27:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so3361387a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320077; x=1757924877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7S/gh1bczo3bWqSmVPBhR4GIaagB0w6uTNlcN/zUrto=;
        b=c+k1GazjpOxhFx2UDd1UW7Kfu+xDc+ikz1GhgmUryR4TP1cbxDBNPebLVOmry/gGfW
         rQ8gEw0E22Q6RXEZWvCJveSYxQi2tXYk3yYSzZS+ZA00CblSHojxYPDiy1pMC5MrlqJi
         AOEu6OP4YudEy/9mXBH+CIQFHubcuUEKJeGavLSIQ+ycgzY2kMdVQGhDcDEaVhPmrjqV
         789GpfYO+gFGxeHMjihUkO3z+aKggEGPjKmAtStS2r6ckCg71hy19mc6Q3/z+ls4hTmU
         VeK11Gn1bmWa9OjY27wOzkkUd3DEr6Fr0fNkfQrrLPAYVcwUCQEXIXDnOWUFZdNWzaus
         SuSA==
X-Forwarded-Encrypted: i=1; AJvYcCX7sL+b3dOsk7gkapunXSs7fu2tblx8OoRGS4wI5S4gaBApekugRsr5wL/Sg2DkF/a6EqhnCfY1X/1yEc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHWIbO8ma6pVIVH5k44HKcsgrHrqT1o4SwuXuYQ73PtRLXfKh
	E/Od41Aq8HnOYSg8f/VHYjDxhe2yFsx4cTEdfhPFqS3m7qJ5FSuGvkggBly04pDoDq/eQrijGyW
	Y3YoQmh8qYytxeSgU65FYKbmr0mDEf3uRHUa4CzbT9jk0bh2JlbD5uyTx+sVLB3ml5cQ=
X-Gm-Gg: ASbGnctGxr8hN8zDy46W1nsaAJ9wv/XdNqseQELp9ygVEJSjTkLeaj8lfLLBiOThk9a
	2yefTniVr/mOUO8RjJ6Um/bVIzS3nnQCPTY5gTOTY6aRM24qj+Pc4nt1KvJGGzqOQZrlv7BwigQ
	UgWC/KXMe1xFvDefmEnTr2j/q+Ipt7XWDOg27G7WgKJrBWRF0J7xu1wZ2EWCWw64VErgBsZa418
	MASkC+69kVV9+CCtbGji/epLMpPz21r969wVaD1C+GG8+/H+8BFsfZDl7Z3Xr4M1bQzKl0wDI3h
	CPkoi2b+TGQnm/A/uo1hp1Z/H7ehYap5b0KOVnZee1ELRWphSyIhhM4mE1qStIPM
X-Received: by 2002:a05:6a20:748a:b0:243:b190:d132 with SMTP id adf61e73a8af0-253444159eemr11053968637.59.1757320077057;
        Mon, 08 Sep 2025 01:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZlFnS+EY2NJveViSCLM4wHil2v4/UFqOr6ytHlfYM/kiyIpu9c26cPUorjQ/8HOTDxcG2ag==
X-Received: by 2002:a05:6a20:748a:b0:243:b190:d132 with SMTP id adf61e73a8af0-253444159eemr11053946637.59.1757320076598;
        Mon, 08 Sep 2025 01:27:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:27:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:57:01 +0530
Subject: [PATCH v2 08/16] drm/msm/a6xx: Set Keep-alive votes to block IFPC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-ifpc-support-v2-8-631b1080bf91@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=4220;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=IMBo6N4wzsS8MDmukZdsfvnrZM7EWF31g5XLtxm04N4=;
 b=+VgSWY81nQLwZQD5J4hnvjnTyQ0hi5MRgtxHYndfiyxkmyBM47dDIsffcPx/aUo5/5YNVE8jL
 e0kAaPyzkRwBxp02eDBLkp+Ho+QDDfw6mTSvxLz87SMovajI8VRQ3LR
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: gYO3pN3xd1hfPp0Fsm8ySMbGHfyTBz2S
X-Proofpoint-GUID: gYO3pN3xd1hfPp0Fsm8ySMbGHfyTBz2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX0iyUq63Tm9LS
 9SdFA7IgHVbO6p846kAnWZjk4CQJxSl24Rsd65oMVVnJKrKgeXsBeLvnoN3OY/dPsofI8WrDXJc
 1rf+H/dxMoCJnjsGgwNHFYYHPbNkMBB4+B/rg3EqfKe8o2UbfCQB9IQOz/72ATqpLbg1tyGk9RU
 c+tti0ufUCD+PDG6ZYrRa873Bcv9MXgOMegswIvTH00tfz9W3pUudQMI1AQuuNwLmN/0U3eXanF
 gP+xrOUKAGYfhaiNnlUwT+dYOFJaeZK9HW0kfZy5FZfSagkKFEgejc2Ey4W9IYrCAHV5zSFB89f
 bj+U72vvab6n/9ijC/mTNr4xMKJR7Xc7q7EYdNh5lFMnZ29UfypLvDx8k38D4gt+slFNg6uYWvE
 w/aj8i7e
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be938e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nUj6x6g8p96gposalbYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Set Keepalive votes at appropriate places to block IFPC power collapse
until we access all the required registers. This is required during gpu
IRQ handling and also during preemption.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 26 +++++++++++++++++---------
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a63dad80ef461da45d5c41a042ed4f19d8282ef5..33a26bbd245ff49784bf1219a584936b4caa62b6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1771,8 +1771,6 @@ static void a6xx_cp_hw_err_irq(struct msm_gpu *gpu)
 
 static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
 {
-	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = gpu->funcs->active_ring(gpu);
 
 	/*
@@ -1784,13 +1782,6 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
 	if (gpu_read(gpu, REG_A6XX_RBBM_STATUS3) & A6XX_RBBM_STATUS3_SMMU_STALLED_ON_FAULT)
 		return;
 
-	/*
-	 * Force the GPU to stay on until after we finish
-	 * collecting information
-	 */
-	if (!adreno_has_gmu_wrapper(adreno_gpu))
-		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 1);
-
 	DRM_DEV_ERROR(&gpu->pdev->dev,
 		"gpu fault ring %d fence %x status %8.8X rb %4.4x/%4.4x ib1 %16.16llX/%4.4x ib2 %16.16llX/%4.4x\n",
 		ring ? ring->id : -1, ring ? ring->fctx->last_fence : 0,
@@ -1829,9 +1820,24 @@ static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
 	}
 }
 
+static void a6xx_gpu_keepalive_vote(struct msm_gpu *gpu, bool on)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+
+	if (adreno_has_gmu_wrapper(adreno_gpu))
+		return;
+
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, on);
+}
+
 static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 {
 	struct msm_drm_private *priv = gpu->dev->dev_private;
+
+	/* Set keepalive vote to avoid power collapse after RBBM_INT_0_STATUS is read */
+	a6xx_gpu_keepalive_vote(gpu, true);
+
 	u32 status = gpu_read(gpu, REG_A6XX_RBBM_INT_0_STATUS);
 
 	gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
@@ -1868,6 +1874,8 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
 		a6xx_preempt_irq(gpu);
 
+	a6xx_gpu_keepalive_vote(gpu, false);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 10625ffbc4cfc26edc36efcf11dbb4efd55ab3e0..2ce073d1cf8cfd7c774918851de03d6e367e5625 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -136,6 +136,21 @@ static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
 	a6xx_gpu->postamble_enabled = false;
 }
 
+/*
+ * Set preemption keepalive vote. Please note that this vote is different from the one used in
+ * a6xx_irq()
+ */
+static void a6xx_preempt_keepalive_vote(struct msm_gpu *gpu, bool on)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+
+	if (adreno_has_gmu_wrapper(adreno_gpu))
+		return;
+
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_PWR_COL_PREEMPT_KEEPALIVE, on);
+}
+
 void a6xx_preempt_irq(struct msm_gpu *gpu)
 {
 	uint32_t status;
@@ -176,6 +191,8 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
 
 	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
 
+	a6xx_preempt_keepalive_vote(gpu, false);
+
 	trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
 
 	/*
@@ -302,6 +319,9 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 
 	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 
+	/* Set the keepalive bit to keep the GPU ON until preemption is complete */
+	a6xx_preempt_keepalive_vote(gpu, true);
+
 	a6xx_fenced_write(a6xx_gpu,
 		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
 		BIT(1), true);

-- 
2.50.1


