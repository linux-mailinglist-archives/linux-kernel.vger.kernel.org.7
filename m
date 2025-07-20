Return-Path: <linux-kernel+bounces-738214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC358B0B5F0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454581896ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA721A43B;
	Sun, 20 Jul 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2nGre/c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98606219E93
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013834; cv=none; b=Iili0VYmFe0xzy37KCmcrpmOG/YY8SA69F4D+b9CfxsBrX2dWSPp2xj0nwVwctWiY8teTKE9J/e60ug4Uo7jQ4F+tDhTG0FXEDnHIUabp3c2iWC1EiwvHB9ttFefX5U8Qp21T2r0XcqJEvy0NN1Tq1XzmgSlHlWhmMg6uXmceQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013834; c=relaxed/simple;
	bh=z+NQFcUOlBBJ4DQEQXpJKA9QI7YpwGdG8wbRFqQ/bb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsVAvsFORE//eYX3AeSwWgB3c7kE57VF7MLl2Ey9u2eSK/vXLVwsNgHEiZlFo6s8pdqMCUiSQ1nNv2VsI6Z5NAlPsBuPX/TY8EXkA48v+iv+XO7gu4xKHLM7TVzNxOAl8kWNJ8q4ADC4XQBQofZ5ONSyozypSA9WBZ98ht1kl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2nGre/c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAsn3K022160
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iodIgk/L8QB4ge9Y+/jSW8XFUE8s1k9FL5byuKE4NvM=; b=S2nGre/cXuPhUyvS
	OHjhKyqQkk8+CikNXs2Dn2+cnxDmzDg3GyqgNYFTeH0c1NPu6fso6/9R+fLt6o+2
	f5jJRUgmwqDK4UmrAbuV49BYmBP97ruJsXnd+JCH9lKXgj43WagjC9cf0a2+uIi/
	cNfg1pAzN594hCrHdCIV48za/EEVxLyTs0g4ASB0eHJ+nwCtRcVXMOQvwDRBMmov
	vTQYrFLP0MOinP3o58/aJ7vjJQY4WjfndDY3zez0FIdfJmfZmmwt+GMe8Zh8G1tc
	lIt0eNuJdnL+RQa7M963ySea9dWXi4X8qX9Ond161rwaVkk9H0mzBAd5Pa+wiMRd
	P7JziA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v25j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7494999de28so4728024b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013831; x=1753618631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iodIgk/L8QB4ge9Y+/jSW8XFUE8s1k9FL5byuKE4NvM=;
        b=hXyT4ZODtSrbV9HEa0u8ZzBWWh/P7d/iUAwRMYBggU6V36bxIUpqSIwYXrRH1Ye0+x
         H1W3JPm/b8inVlBF4zxh4xicACGf6cIaQefYk0MYHW7f/DWVb2GYdGq5qm3923zGeoN9
         6EgsJd++IyNSkCb4U4uap4F1TPiYFoDGq5Z53AyTI+g3sPTiEi1d5Eocj3OxoC8se1cK
         IdO6+udZWVK11MDZpwnbmkVUse53urzTZrColBggnt3TPn3so+Mim17GvCsaI9vIEN7R
         dp9EgMo/9+EXcf5msZzj8Uq62qpJSusvYYhlUc79REyXrjvnBx+XeazmELIo+fOaJrmw
         1vcw==
X-Forwarded-Encrypted: i=1; AJvYcCW2O9bLEQc+5qPtAe7o0A2g0NgsWlJX6blcZsvOBNuwq769K6yPlYG18ygMmwYb29auy8lw3LCCVw4CzXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+93eFrhnK1tO/ili1Va5GXE3Sm0CgKPKtu7oHv98IkEHMMLkX
	JKbxT04Mqq6kZJ9JzayaU1n7Cr7ZeZ02yLFEeyICy+ZV+JJO9+S6PAAbkJgSEmhEUGL5Cmei2Kt
	R7hRetjGjb6TbPCxuSHu/vMRw7oa68GUDbTx1Fs4miEp2wOjNYS2DyEcnnFD6U4VmVU4=
X-Gm-Gg: ASbGncuqLDmJZ6oyblPrwURrRC4uH0edNjp1cCXEZRJSAstuWlkCvUwbFUJJnlsoTmH
	eYuVRcfWFz7Dfxqi2cDJu30hCk1dsFA5FfaTyh/uJl1tBZ5d2S4yZ8UL5OPiwu+x9b+9pSK+KMN
	VNBCYNwhNY4oay61JsU/lX8hJ+SbzKZTlrJO6SdiK52xbZe11tXXERg/cmTxm1TAkvdRQd4ckPv
	yqjcVdZ8Axha+iLlr0r36L/cJapXb928H3rvAnCU7rFi+aMPX3mzm9n6kCWtxqbr0wb7+mtWePz
	eNQC4vmBZjqBo1QLk0XKulmjfyxjgOtK/t83+xJmMP9giH1H2ATUbNAnbd5QyxNS
X-Received: by 2002:a05:6a00:bd93:b0:751:6ff5:df35 with SMTP id d2e1a72fcca58-758492e7360mr21100150b3a.8.1753013830610;
        Sun, 20 Jul 2025 05:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/CXB44kkPPPn7fl486Zg4Gshdd/qJ9odt44ajNXKqNQtvHzEfy+qVaVf9sbWGquP8YOhZkg==
X-Received: by 2002:a05:6a00:bd93:b0:751:6ff5:df35 with SMTP id d2e1a72fcca58-758492e7360mr21100112b3a.8.1753013830078;
        Sun, 20 Jul 2025 05:17:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:06 +0530
Subject: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=4069;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=z+NQFcUOlBBJ4DQEQXpJKA9QI7YpwGdG8wbRFqQ/bb8=;
 b=rsUSAlAzVOIW2BjmLa8jLaadNUl1ZlR3UfgTXqzEB13F1QSizKzMr6SvFnED++obtYCLs2gGR
 6UyinetYUluB6JRGy8COHDciHcr/XUsoptGlZPtedaYUva0OMFFcvlg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: ZhgVeVf496iwDJBc4Jg9GplOxIdrlxQJ
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687cde47 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=R1CZgRJynTePKTnkIkwA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExNyBTYWx0ZWRfX24X11aa+gLko
 jgvBNyQjFxkvYwglAzvS1o0kBgikdallmA5ahyRnSpW2N/47d9OjOgGiavnfE5CXxEd34elSo3D
 3U4u/fSpmjqLDLEsuBmZMYw0FLiLGx5Nvbu9FXJ4DIzTL3hSh4BPdTcbWf0S8S2VFcmdFym1e9S
 r0/w0LvtY5RdQZcnS2yrQQhXpggArNvmvLAX/WoEhDzOSWHbCQ8u7OQlrBhMo/a/bd1zPRbFqxR
 zvnLz+uPVt1kU3pesAwfb+chg9s5MAr6xlew2aoYNKtMsbh2VYoQb2N4GiMMOowrFPLYdvYT7Pu
 GhX7BPDX6TTw6isekrOGyZWwAciK2hnRwYWxV8mUYZbTvF/Qf5n2hHMstX1/it46ANeyD59P5ML
 OT7qrdLvAq5adh6TEE1cIJobrxYCXKJbU615AkwF+XX9VWp1PwBCdZZobBihOj02myUy7FDQ
X-Proofpoint-ORIG-GUID: ZhgVeVf496iwDJBc4Jg9GplOxIdrlxQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200117

Since the PDC resides out of the GPU subsystem and cannot be reset in
case it enters bad state, utmost care must be taken to trigger the PDC
wake/sleep routines in the correct order.

The PDC wake sequence can be exercised only after a PDC sleep sequence.
Additionally, GMU firmware should initialize a few registers before the
KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
GMU firmware has not initialized. Track these dependencies using a new
status variable and trigger PDC sleep/wake sequences appropriately.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 30 +++++++++++++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  6 ++++++
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 3bebb6dd7059782ceca29f2efd2acee24d3fc930..4d6c70735e0892ed87d6a68d64f24bda844e5e16 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -279,6 +279,8 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
 	if (ret)
 		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
 
+	set_bit(GMU_STATUS_FW_START, &gmu->status);
+
 	return ret;
 }
 
@@ -528,6 +530,9 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
+	if (!test_and_clear_bit(GMU_STATUS_PDC_SLEEP, &gmu->status))
+		return 0;
+
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
@@ -555,6 +560,11 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
+	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
+		return;
+
+	/* TODO: should we skip if IFPC is not enabled */
+
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1);
 
 	ret = gmu_poll_timeout_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0,
@@ -563,6 +573,8 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 		DRM_DEV_ERROR(gmu->dev, "Unable to power off the GPU RSC\n");
 
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 0);
+
+	set_bit(GMU_STATUS_PDC_SLEEP, &gmu->status);
 }
 
 static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
@@ -691,8 +703,6 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	/* ensure no writes happen before the uCode is fully written */
 	wmb();
 
-	a6xx_rpmh_stop(gmu);
-
 err:
 	if (!IS_ERR_OR_NULL(pdcptr))
 		iounmap(pdcptr);
@@ -852,19 +862,15 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	else
 		gmu_write(gmu, REG_A6XX_GMU_GENERAL_7, 1);
 
-	if (state == GMU_WARM_BOOT) {
-		ret = a6xx_rpmh_start(gmu);
-		if (ret)
-			return ret;
-	} else {
+	ret = a6xx_rpmh_start(gmu);
+	if (ret)
+		return ret;
+
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
@@ -1046,6 +1052,8 @@ static void a6xx_gmu_force_off(struct a6xx_gmu *gmu)
 
 	/* Reset GPU core blocks */
 	a6xx_gpu_sw_reset(gpu, true);
+
+	a6xx_rpmh_stop(gmu);
 }
 
 static void a6xx_gmu_set_initial_freq(struct msm_gpu *gpu, struct a6xx_gmu *gmu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index b2d4489b40249b1916ab4a42c89e3f4bdc5c4af9..034f1b4e5a3fb9cd601bfbe6d06d64e5ace3b6e7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -117,6 +117,12 @@ struct a6xx_gmu {
 
 	struct qmp *qmp;
 	struct a6xx_hfi_msg_bw_table *bw_table;
+
+/* To check if we can trigger sleep seq at PDC. Cleared in a6xx_rpmh_stop() */
+#define GMU_STATUS_FW_START	0
+/* To track if PDC sleep seq was done */
+#define GMU_STATUS_PDC_SLEEP	1
+	unsigned long status;
 };
 
 static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)

-- 
2.50.1


