Return-Path: <linux-kernel+bounces-837159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5F0BAB937
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E093B3381
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A5228726B;
	Tue, 30 Sep 2025 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAV7uH23"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328FE27AC3D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211491; cv=none; b=fPIQXpTYmMAdrzERjCy/x9C2V51C9jO/FdMZzQ+q1LutiCTHZkEoN03JSZoTHQx3Q1rpwi3ZX8zQfvcbpADaxneqAmOTwTq3XRviwYdVlUglrDVR/1bg1SWBQvkmBLWZMp+qS4t6lhNPOCVc39ly1WEH/wIoQ7gkvh+7AAyBBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211491; c=relaxed/simple;
	bh=2+6nofdpE/MBQsML3yQ16kJSV6+5q7SScWtaiLoL5CQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWSCmf3YSGdMMiHkpfVOtRERZcTb2h5eAtS+JdX/CP5MppmtXOsOifP170bFrqO026moii9gp+jC4y5T3csau3pqqueQrDnxxbkp3K8laDofQN745U0WJXNmOauU1BOg/lGN8H9fKuQOdK8cljqoflrAWkn6TmlEU1BMZHp0CyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAV7uH23; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HNxZ023779
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yHVWQgivHCXrZ9M8uGFVIHrAnFmQ5qwiXm6mKkCDIMY=; b=TAV7uH23a0X9+pMm
	j522lDgUxUq7wJ/C/aCd3OCuChtVXY7ae93MKRrNQjPlCSaagAwM/qZMT7j3wGKt
	sYPNHHgaHXyXdUqlkrXN5u4R2BNYmrbFM2pKNIoLX0dnqJ8CXcRvde5ikG8Qo/OS
	m0MUXLrG7tybTptvGRdflycRESaEEXYlu6IMGLwxREa5929qUJAmccFdHwSDG2aR
	IwJGzZu6b+OWuRi4ZnsXTghLJsFIr1t+vFgQZS9wJDvSGg82uTKTGEGyafjlcGoA
	zy4YExbB2ZvHr/WPI69S/C9uNDi0F9je5U4YdkjKCe5VoNKjz7wi9kqF8XPyCOe1
	599AsA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n0534-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:51:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b646768eso3755407a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211487; x=1759816287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHVWQgivHCXrZ9M8uGFVIHrAnFmQ5qwiXm6mKkCDIMY=;
        b=jWB2d+0hFD4aMKQevl5xbWv6C+zycIZQX3VwAXYAmf3fPOqSsXW+88xwSz5hPIdv5r
         ZMcKy4hbKlLRcNYvYZMxOe0NqCCndplt1CIY5XQYY0bHCjA43GTXlop1KsIbGp3T34nZ
         Y6qM/Xnl14s30n89Apx53hvRNdHHSaDqUhWN7B05OnMAmAbtnSfN4wrlukwI6jZMEbYT
         CKbwDpVLr5EZLEdQ4IvU46US/QnrOsdyeYmBAaZ0uAYXTHFoKIvFNV353c00OFHVdqfC
         tebadkCH6jtfgOu1AsY7Ym2MQ5KUPpwcSdrh1tGM3mUYldE24XdIXhoskTZvBunrrD1r
         worg==
X-Forwarded-Encrypted: i=1; AJvYcCVd70KM0UIeJojRlWQBJuR2goIRBmUM9xh3rSQCfQqTDjb+nHF3s2bJr0GEK0vMF3UOCqxHxUJqrhGesYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRtCS0sFYe1z9MZxjrLW0V9E0hv+JZTqICVc8hhp1d5uLXzmq
	HQRrUfmikJAkkTGTsstsD3PRMc2wp98XiMq35BV2BxGQdpIov7ckWInLhHbSFHd+YA8L2hx2Mlu
	oXW2D68iMOg8bjABv+4qgso55hwPYsBtqd7Q/KlKQ8afU40v63kZa6+J0839hCDLVuIM=
X-Gm-Gg: ASbGnctxkf+diy7nRy/5D1UCnIxnBQOWUw1Y6UrTpOkwGKrixcFtCdhtdBpvpuqFaka
	tWWYXKsq/m49ZS2YrxJabS2YNn7BxGl8U9ZOqSbjTNk1snAfh3v8F8GFVhx0P9236WgUOaR5lH4
	olqMJYEVZVsVqAfp67JlBkKe5Bog4wxKsb4HCoooBQK6aMYcunmUU/PkhUC9BXpRsIkf9dhwzDf
	LojueMlVC5GXgGaiugMxKqSyL6McQLWhVJIz/WWO3RC9EAMrfKITFTm1IxYx5y2mCgPEMVWuzk1
	W7SJcMcK+9UAK3KBszJyEM5G8p6hOXxeGbIzEWsrB4di9XFLzK7Mw3OtSiiqEnewcZlD/A==
X-Received: by 2002:a17:90b:4b08:b0:335:2934:e217 with SMTP id 98e67ed59e1d1-3352934e299mr19079936a91.10.1759211487001;
        Mon, 29 Sep 2025 22:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE/k7f60BL5kPXWu/p+Kyf9X6B9zbpppZnzTZrTcqssp8ghvUmW2fbcKtNdBLk2/1QnDJsTg==
X-Received: by 2002:a17:90b:4b08:b0:335:2934:e217 with SMTP id 98e67ed59e1d1-3352934e299mr19079886a91.10.1759211486212;
        Mon, 29 Sep 2025 22:51:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:51:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:18 +0530
Subject: [PATCH 13/17] drm/msm/adreno: Support AQE engine
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-13-73530b0700ed@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=3332;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2+6nofdpE/MBQsML3yQ16kJSV6+5q7SScWtaiLoL5CQ=;
 b=yvifhwMKpq3SHxKoy307GwblADCBD4UTNB5ty1WYqwhm78213b4CoLaogpn+DCvjKDpO08v1v
 TgVQ8l2pN9TBTwc2SeVUQ3gCU9s/PByBmFvnhmgErqPxzWUB25NLqPP
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: gQzKj7ZwiilDoJ0eSS-g5rn0qyHiCq62
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68db6fe0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qCSIj6eo76QuOecuVwMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: gQzKj7ZwiilDoJ0eSS-g5rn0qyHiCq62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfXw4ySXnlyN8rs
 gP7KG7WdurrZC+LGCDsUuqh5w7wBfLgBP0umivPFRifKE2sbMBZhhiWXUSZZa9wiaAvDUwTCkJY
 t8ApEALzYXgBOMc97AdwhMzD0Ylxo2Q+ijlCglLblHH7qM6GmgeAe1Qbxfs5DziRkR5uD2UvY3j
 cg9Nk48wfE236NHXxaPaZ8bUMl52tW5GIfxTGD2Ow7P2kKZvPTq0Y9k4RvLZHG5w3r7p6UlhbEg
 0Bah8bL13dPdBqRgX1iOZW2sKQ7ss4tOOQxlH9p6Ov4f42M/BXHQQL7R2Zo6ylyahz09SX9J4lN
 1jKlLL5QflBkaNVtIpcQKqcV9WLF3TEbFv2xHIh1KVXhDtS4jmwADel50J1cz3s5o01I8pw+Ffq
 gvJzyh7JhxrqtbhwicqQ1vgndW453A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
in Raytracing related workloads. Add support for loading the AQE firmware
and initialize the necessary registers.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
 4 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4aeeaceb1fb30a9d68ac636c14249e3853ef73ac..07ac5be9d0bccf4d2345eb76b08851a94187e861 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1093,6 +1093,30 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		}
 	}
 
+	if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
+		a6xx_gpu->aqe_bo = adreno_fw_create_bo(gpu,
+			adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iova);
+
+		if (IS_ERR(a6xx_gpu->aqe_bo)) {
+			int ret = PTR_ERR(a6xx_gpu->aqe_bo);
+
+			a6xx_gpu->aqe_bo = NULL;
+			DRM_DEV_ERROR(&gpu->pdev->dev,
+				"Could not allocate AQE ucode: %d\n", ret);
+
+			return ret;
+		}
+
+		msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");
+		if (!a6xx_ucode_check_version(a6xx_gpu, a6xx_gpu->aqe_bo)) {
+			msm_gem_unpin_iova(a6xx_gpu->aqe_bo, gpu->vm);
+			drm_gem_object_put(a6xx_gpu->aqe_bo);
+
+			a6xx_gpu->aqe_bo = NULL;
+			return -EPERM;
+		}
+	}
+
 	/*
 	 * Expanded APRIV and targets that support WHERE_AM_I both need a
 	 * privileged buffer to store the RPTR shadow
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 18300b12bf2a8bcd5601797df0fcc7afa8943863..a6ef8381abe5dd3eb202a645bb87a3bc352df047 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -58,6 +58,8 @@ struct a6xx_gpu {
 
 	struct drm_gem_object *sqe_bo;
 	uint64_t sqe_iova;
+	struct drm_gem_object *aqe_bo;
+	uint64_t aqe_iova;
 
 	struct msm_ringbuffer *cur_ring;
 	struct msm_ringbuffer *next_ring;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 6a64b1f96d730a46301545c52a83d62dddc6c2ff..9a09ce37687aba2f720637ec3845a25d72d2fff7 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -599,6 +599,9 @@ static int hw_init(struct msm_gpu *gpu)
 		goto out;
 
 	gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
+	if (a6xx_gpu->aqe_iova)
+		gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);
+
 	/* Set the ringbuffer address */
 	gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
 	gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 6a2157f31122ba0c2f2a7005c98e3e4f1ada6acc..3de3a2cda7a1b9e6d4c32075afaadc6604e74b15 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -27,6 +27,7 @@ enum {
 	ADRENO_FW_PFP = 1,
 	ADRENO_FW_GMU = 1, /* a6xx */
 	ADRENO_FW_GPMU = 2,
+	ADRENO_FW_AQE = 3,
 	ADRENO_FW_MAX,
 };
 

-- 
2.51.0


