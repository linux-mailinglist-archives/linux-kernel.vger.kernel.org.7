Return-Path: <linux-kernel+bounces-782805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A45B32592
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA5AC5468
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986FA4C8F;
	Sat, 23 Aug 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvkAguRV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E41367
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907928; cv=none; b=R4/Xz0ewELRtLtSUDb8oPXxlpno0lepKPF8gsMjoqV1d+KS7vSfH05d54W6qABftm9VjwNBeORaKdFFVVc+sAvDhdPzXLwyI2rd95MGcRFOBf5PTtzucy8X9o9KkzxDckQfYVOQ4/UB9kOObZbrxm9WfShLCjjSbpSZ+IAgfWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907928; c=relaxed/simple;
	bh=izTeRDcb3LUu2+xcZ1pXgxZuqtAbJOSjKbwv77VWnSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QA95D892ks/TDOezrppYdnJMD4CrkpZXEuV+cHbBKusEQtnNisyJQ9RSz817h8tU9+CL04xbTBSgceBWqRgMd1wTn9uR5yi4t7VrvqRXOnpZCsw4O/koyXQibZjbXdC2y/VsPv36oBNJhFPKnRfDutYiI27tAB5EYbgUAolpaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvkAguRV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHV3g4019350
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LKH3UmwyCqZl4E/zd7SLx5
	cyJ5JW0DFn9aa/Um4dYq4=; b=XvkAguRVqkCgLToup5Ft4AYtG1pSR2nQsaPp9J
	24p6CUG2X8tVecbxiNnnba3XmgJLI5/nhj39UriZIo6f728hmSywHqcKnFPc+u2+
	rY674Ta6yoewXff4d2UhYXwc2kT1lxeT+1YZ5ttAnzqQ/GnBVAk4ST858c11S/G0
	UURk0q2sNTsL+bDWs+sIVPXQiucINHqEIBRa+tE5DHWfwtEffkyGg/lGItysAy4g
	y+dn7zjuHFUB4kPQFKU0FprwgiBgY7ei1kqzqc0+8fZAtuhLF9/QWrX3kmFdJmCv
	K6yjm8gAazAz/P78AIPYfBiSViUxF3bQosvUs5ZD0swvZ7Ww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw10ru78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:12:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109ab2cbaso60629611cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755907925; x=1756512725;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKH3UmwyCqZl4E/zd7SLx5cyJ5JW0DFn9aa/Um4dYq4=;
        b=uUxF2O2rqYZc3R1JP+KlKfywKJOlgh9nT7fYtor8RMobUJg7+tLoLvLz9al5gfHjbn
         9x28UuQuuHAskrFZT4Gr+9Fujjf0JPQbWwNjcCgr+8egiHENDb4GeQYvV6ezHD3crrRX
         6m7Warl9ZKWh8k0FflpjOxj2Euqbajn+Oq/YxpePvGpuMPwxFRptRZE1j9Us/cmaDG7B
         vaJrnQ6+azaOWlgdRKkjVw/ItqEdLlmtPDgBPqFuxHuhxYfaU33geS0yE8DIB80mWWhe
         MU//tNd18QWp7nqmm27iEHadOGTAwKPg+00kZYJaeLRANj8CjGgc1aLLsTj+rMrK+Gai
         V4xg==
X-Forwarded-Encrypted: i=1; AJvYcCUSYXMaJvdfUz3X5jikgt15E7CmjNun/QPbe5YHdj5SlPVjV3uxg5R6yC8ZjbnPzRxl7gQXuofxyluo2sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8bV3yt+wNgS1EGatwwLgcOewqtLGGN2wE2o+Zuxk4dTtlOL48
	6YBHliqebUjYBXiLXyw491xuXJM1/SRxd4UcwpOZCDJfdRn+y8CkMHaKcalvmEqhkLnlXsxRtPQ
	TslgeY7u0+1OrytB4pkmM3Eko2d66Rq9D1/hbaVqGbJZqTfdIGXaJN7SfBe6NGM3yTRw=
X-Gm-Gg: ASbGncutfkHw5Mz42VAn0SbkHYT4trgKMVadhjj5FKKrBvi3c1VjS7+Ti7+oMg+vjBF
	Mos5cBoj4iq6iXIwGpnywZZCVeyvsyRenKap5SP90adC3G3rKpoRw+wuXkZXNSwHNxJ7EjwjGqg
	9RUaL5Ymk/AR9qpHX9gA7/POoXB9ubsqd6ga+VuOkGxvkOQZFDGlgq7lZ+sFdKdaWz8V5IfDejy
	mD88EI25H6e5DlTLIk6HnQK9/RSk3TPbuCCpS6Z5KQNQuRMqBB8L/+98G2zJty8Wdf0HTlpWAVU
	bTZ3Gpza7bf0DfR1JHLnPPL27tAAT8JOEmQ3bQUS6VR3yAdCWefT9S++NtB5/2h0kRQmk4+sqNS
	YFDI2rIEtFDe3h8U5IyR1GvQsJrsflV8NS2XUSTH7UQuH60U30Row
X-Received: by 2002:a05:622a:248c:b0:4b0:eb79:931d with SMTP id d75a77b69052e-4b2aaa561b3mr63251911cf.2.1755907924814;
        Fri, 22 Aug 2025 17:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjRcYFg4ZlcT2OcnbWB43OpYbpLPRq63IBEUW/yX7KrugkfRBNsErbT8C9Dy4q63T/Oz64nQ==
X-Received: by 2002:a05:622a:248c:b0:4b0:eb79:931d with SMTP id d75a77b69052e-4b2aaa561b3mr63251531cf.2.1755907924269;
        Fri, 22 Aug 2025 17:12:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8ba2dsm208929e87.77.2025.08.22.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:12:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 23 Aug 2025 03:12:00 +0300
Subject: [PATCH] drm/msm: fix msm_gem_vma_new() allocations for managed
 GPUVMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAE8HqWgC/x2MQQqAIBAAvxJ7bsE2Kukr0aFysz1oohVB9Pek4
 8DMPJA4CifoiwciX5Jk9xmqsoBlm7xlFJMZSFGjNNXoksNVbrThvByKlwMbUkZ3PC8rtZDDEDk
 b/3QY3/cDlPxl9GQAAAA=
X-Change-ID: 20250823-msm-fix-gpuvm-init-520d87ebcf26
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danct12 <danct12@disroot.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=izTeRDcb3LUu2+xcZ1pXgxZuqtAbJOSjKbwv77VWnSo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoqQdQnWFc2erhkmlZkodf2OTqrgXkxW7pdw437
 37G1d3E8l2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKkHUAAKCRCLPIo+Aiko
 1dAzB/4wwaKA7WZL9E0yYd1cJks/dBt54lwvKms5QB1urUJqn4s3R8HawZOj6/PHvvNfOSGQtWt
 HS6BJvmXj38WrfrHOJOGq/ndCib3iVdLmzHccrKenBuszzTmd9bKBbpLU0OmfXpMODSTFRe+lZV
 BdQoMbzHGZnMhNa+raq2b8L2GZQId0Ls6wIdV4eCzDD9FHhBJzEwubPWtbVcD5tVT1s0mSHgUVP
 k88E6Zm1yzUXdgQYYg+9rVLLREEZCdJae68Ai6a97cWNcGbdRD+c1qclyxYICn8dKcq/WKPwUW1
 To3j3KXRZe1APQYAm9z6u20OdAU/ovFhR9lWbeb422fc9KBp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX2ajMQjncXUlU
 kY9xWJ8kQUIz09ThAWE1szAUnERAj8qStRawh9WNZMCmEOkTB9jXzvLiQkdd+XTNALCQ4zGcvNt
 EY4uwEJ9UKullYWM4znKUWEOqyTZWeYUQN0A6voNbSOo2FJcGXe+/XVJSpoMJH8zKU9U87BJ1Eg
 L+1gSRYQe/YoFe2FGAiZvKRx+a/liiWw6wt75sniWRwb6UyL5a+CgI6scM4VojYjzLZ9VhceBpu
 nZ019z+7cRS6Yuw19RrCMIWbhA5/SsVDo3LHsUTa62bptmP1FR9TjYdotSkwW4tTDIWCu6ffPBV
 N3KKQ3uMzsHYA+OiYXGK/8/RUDU9XMFsBvEDh4T9wzEGSFXlxXV0mHhGTl/hX2RG9lHc2+/Hiwn
 Mcy2ry35
X-Authority-Analysis: v=2.4 cv=eaA9f6EH c=1 sm=1 tr=0 ts=68a90756 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=O0ltPWiidyXzGDMWRkgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-GUID: oe0r1Bs-QeD1-OAsVUHd7RPM1EvP8-Ey
X-Proofpoint-ORIG-GUID: oe0r1Bs-QeD1-OAsVUHd7RPM1EvP8-Ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220160

Since commit 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()") MSM
driver fails to init, failing with "[drm:msm_gpu_init] *ERROR* could not
allocate memptrs: -22" errors. The mentioned commit reworked the
function, but didn't take into account that op_map is initialized at the
top of the function, while ranges might change if GPUVM is managed by
the kernel.

Move op_mode initialization after finalizing all addresses and right
before the drm_gpuva_init_from_op() call.

Reported-by: Danct12 <danct12@disroot.org>
Fixes: 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()")
Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3f440bc1f7106f3b0091f037611d0b433e5e2c18..6df6b7c0984da57fe64de41fa54f7dea0a324c74 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -368,12 +368,6 @@ struct drm_gpuva *
 msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
 		u64 offset, u64 range_start, u64 range_end)
 {
-	struct drm_gpuva_op_map op_map = {
-		.va.addr = range_start,
-		.va.range = range_end - range_start,
-		.gem.obj = obj,
-		.gem.offset = offset,
-	};
 	struct msm_gem_vm *vm = to_msm_vm(gpuvm);
 	struct drm_gpuvm_bo *vm_bo;
 	struct msm_gem_vma *vma;
@@ -402,6 +396,13 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_gem_object *obj,
 	if (obj)
 		GEM_WARN_ON((range_end - range_start) > obj->size);
 
+	struct drm_gpuva_op_map op_map = {
+		.va.addr = range_start,
+		.va.range = range_end - range_start,
+		.gem.obj = obj,
+		.gem.offset = offset,
+	};
+
 	drm_gpuva_init_from_op(&vma->base, &op_map);
 	vma->mapped = false;
 

---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250823-msm-fix-gpuvm-init-520d87ebcf26

Best regards,
-- 
With best wishes
Dmitry


