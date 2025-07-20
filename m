Return-Path: <linux-kernel+bounces-738224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E5B0B60F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC4F18948AE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D9218AC1;
	Sun, 20 Jul 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KHXxt7mU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB82192E1
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013875; cv=none; b=Xj2FN6ipNfdbYHt3QvrL6WIG3oCtP/wPB/6lu1DMtTQCplZ8FUdjzyeFNBnxWKiCn+iCSRupJDdAVuCUmHG4UZeu4GIuz8/LPad8fasO0fsVGADhJyZs6JsxfzhhxIqzoGVJGPhxE+vN8QD/RSEuuoN6HtaNG1aTizk17315vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013875; c=relaxed/simple;
	bh=OGBEtewb4kUxOHO/IHiUhci55B7Fyi2BTa9NjI4r3IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esfV6gPTb0cORrBjRCIQ6o9d2MBrXZbzTVBsqBfMUpTPRSVZNTF9J+kmiPV3PWjFFug6Qdaq3AGqGH64ABoD3QEDYd1LJXTIl16Btaar/fLQb1qOO0xdFsqcc/yLN0oWECNHm9L922RRsANUfr/Cma6IsODgHtZ6VNvaxrz62pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KHXxt7mU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K7XCGQ015215
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UWJQ+n1U99z6vg+LqzHFMyrXqH+jKrP8tFTOzOc5ViM=; b=KHXxt7mU8ZFSUy67
	Zf9R3V6PuDpkQno2PMttYPtJIvhDRNHvURViUaB33z0x52k9IhAE97SHseV/2nI1
	MNjq7gS8u+z+KaSw/hnqac0U+xptRLB/LlxPjpAO8aXA8eWdA2kM8XRzjXP7S8jd
	9PlpzPrZgbIhfkZTTctpX9x1FVy7k3B/QaeXLtKyPA+8sQTQcsJkG/lzsntoNn+J
	7oUsSb6Zssadq5MpDMF234z4vgSWsOR8lcjAgMAF3XPzHJz7q5tVIrRe95SMUfXd
	vYTECSIKEEH/S/THtTXoj7dkjrEVrtV6vNmuAFJ3OyQ6UbXfIYaSM7FqZP0G8p1t
	p67eBA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045ha5y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748fd21468cso3237215b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013871; x=1753618671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWJQ+n1U99z6vg+LqzHFMyrXqH+jKrP8tFTOzOc5ViM=;
        b=TveyeZoDd/n3+bCoXjZ5nAkRLkqfL3GOeZPXGHZAYFDgYG0FjqZUQZA2vz2NrHyP71
         dJatJcvdHoIIr67Lcp95Fh2pH6VW2/zX4lCRSps+Up3UISNv+TalOZW+GVDdtzmufyK1
         5ZEcT668KsA/PGut1rU0SYGHZWnuTcVFY6FjbHgg/8W1Y2imnfW5wTKQBYDyVFYBZ4z0
         c4U06zapjFlalS/zhozhJgaTUDYp0eYShrdAPk5vTEaR4tKM/9jEiMUq34D0EuM7J8mT
         9RvsTEG7QnNykuvRn576Rx8xv/WH9zYbudXXtlKFyyBlmGzYP3TdJTfNzTLrkyVxxmJR
         KU9w==
X-Forwarded-Encrypted: i=1; AJvYcCUh3coHHSRGN3lzRgRKXSFrc4Mqvd8RYu5NjuEE/PsNlSzAbYAFDQMGuFQDILVju8sn8Xa2WgALBQfbVaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycaQC9amrBDR217kxNPO97+jCEGVka+KuOTt1Z+hQfxcyehf0J
	5J6K3W34+Wm53LrHWhn7G7GSOviJBRQWFPSNv7BsM+DrgfsWSghOJ/mam5+KXqS7e4z3MPU3v8+
	FDeOUC95+Ko4dsW1SyJhLf2WuvfYSEIucmKZZb0l/BIkUuoLswuJ6mlFA272k0MxWneU=
X-Gm-Gg: ASbGncvqtdnNFFg4jblk2xbfbdlvHTwyUojB2ZUKdY9y6tktk6/vFXCnymYZMvhbYNK
	VZqjpJuiQnkDHMC18lqJlv2P2y0qbuCIxhixhClDHnV52VE1uKluMopFB1PeCKBV6PGH3TpsrKm
	rlfNcv73rzGBPm9GGJiGTd58tnRiSt285LW2xPKB2u1y8B0UXLdvoKkLNx9INV2V0PwIL8I2DnV
	Yl2RT9IZC+KSdWl8syqRcPso8smVQUb+yBgf/JnECr26nqfElqBrbCKwv4OVNd7xLu56bNpMfF2
	GqjVp/PN3rR4yGz+fDcOFD7jmxdlVyDAZEQWYMXHq8lE0Mm5fwzJw24UWVno2kFl
X-Received: by 2002:a05:6a00:399c:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-756e9fe7578mr26167307b3a.19.1753013871215;
        Sun, 20 Jul 2025 05:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+l4A7smw0c9HlD0mC00sBYcqAw4GpgryQHLdv3W8SOqKQPr2e1e00Rzpbvc6xSFgiHc+rnA==
X-Received: by 2002:a05:6a00:399c:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-756e9fe7578mr26167270b3a.19.1753013870665;
        Sun, 20 Jul 2025 05:17:50 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:50 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:16 +0530
Subject: [PATCH 15/17] drm/msm/a6xx: Make crashstate capture IFPC safe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-15-9347aa5bcbd6@oss.qualcomm.com>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=4450;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OGBEtewb4kUxOHO/IHiUhci55B7Fyi2BTa9NjI4r3IE=;
 b=FCzsm/8Z4F/+PEosVnKUdSuiz5TzZLlRTwsfFqXlgVT0cWp3Rv1ethlB50wzGiSI9PhhBzY0i
 Tfg+BbradJTCttB92Yctv15WzNZ4ZHg+fBlggRBXpscyTOAXJqM5yg7
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=ZtDtK87G c=1 sm=1 tr=0 ts=687cde70 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=yKEZsNg54XTt07RPwjwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExOCBTYWx0ZWRfX+DtcaPtTnVe+
 wEaINpSERTd7/HlHJz8FIsbL0UPQu+VdyM7p2BdheMHZHyJyUK2fNFHKJewp1iZB6gASS2vJX7S
 6IU8eUpBPMNF/GiMkaeNPKdUQdN/Nida8DwcuFZ4twcrmnXkEuRwTYlix5VmQo4uAcZ36tdDi/R
 S7WRptY0Y6Ww2b9YeJRL4h8mJyhinRWJRANuOYJZZ2LJOP3kqQ8I67vmEA3ubRoFbPJEYuJ9GQZ
 GDqVSJRJyMrTsw8qowkzQNVOdd1/8j92S9qQew4EJTT+G+g7Z3ONLzPihpN9+MSG8TDtWS7DIcv
 tIx75nkZQtP88CPxGKSn1OMSvy1kNnOQhR/q4gRDfnW6YZFr4OmHvsvYEp9SWI+MUvYXPixrIrU
 bPxrQhgHq9gaHSDXxMLbvWRP/viJaEVvHDZFObnKhF6ma8Q4e7akAh4ehxGS5GQUSbzWaSqd
X-Proofpoint-GUID: opon475eC8lmjUJenLfrwW6vGlk2liuB
X-Proofpoint-ORIG-GUID: opon475eC8lmjUJenLfrwW6vGlk2liuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=640
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200118

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
index ccdcf5fe4b4f3cd81d765754d00c132960a916a9..c17837013b613b53793db0e34bbc7e65f0eb06e7 100644
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
index b46fdd222913a46e01b984b90c4e63ae82f54e9f..54decb9908fe526ac7f150465034b03ba688aa6d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1518,21 +1518,25 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
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
 
@@ -2394,6 +2398,13 @@ static uint32_t a6xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
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
index 341a72a674018258597aadefc9a45269b977e00e..cb846c1548ba4ea31a0ff0f23e98820388cb5ce0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1569,8 +1569,7 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gpu_state *a6xx_state = kzalloc(sizeof(*a6xx_state),
 		GFP_KERNEL);
-	bool stalled = !!(gpu_read(gpu, REG_A6XX_RBBM_STATUS3) &
-			A6XX_RBBM_STATUS3_SMMU_STALLED_ON_FAULT);
+	bool stalled;
 
 	if (!a6xx_state)
 		return ERR_PTR(-ENOMEM);
@@ -1591,15 +1590,20 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
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


