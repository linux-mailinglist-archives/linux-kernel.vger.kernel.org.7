Return-Path: <linux-kernel+bounces-674918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9BAACF6FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607CC1883FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C927E7E6;
	Thu,  5 Jun 2025 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qb86/u9E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191627A135
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148351; cv=none; b=fDh8ZTkdkpjiPg9fgU1y5wB68LNqn9iBC9R+ypripjG++WD7YZodW9L5oZsh0EIn0j9CfsZQ/e4APytR+fn4GmMvJqzkITUnPr4+Hq8JouM4m8/fJ1/jg437+uEOAdJD2HxyhI9fgU7VQLGsZBlnBu5Gkrw/sWDiAbTCSGcqZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148351; c=relaxed/simple;
	bh=582gsS3SPyTENXAfRN07BZXSPUUl4eK209uRnsSMntk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gerDUeAu8OHku5gjbJdDe3JNt4h2JO8Cl8CPKbUsUOH0XZ4XNmVKXAj+TLJsBTpedM1G6XD7rWWyQdEBNseN+mIq2aWpvK16Oz6gPNRrpKVhsO2LXvQY9X7dEIPwgYd4SYYl2g/GToSUXyA6fYP6zEz/TG6+MkytCPC2jAPh1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qb86/u9E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555GVgxa019377
	for <linux-kernel@vger.kernel.org>; Thu, 5 Jun 2025 18:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Brhrophe0A7
	Gd1KgTCcLb6vKHfZb9nFr0On2wKb0sBY=; b=Qb86/u9EyG2SbaVD1gFrzhrOtvB
	y7/LXNzqOk8+BEsajTw+YDOuTdsZxgaVccRwr45EGEDuFZMEc+CB1VAsDTfmMJs7
	gDVrUlyUM0fPhuv0oMfqBZdNrhSyl8hOA2GQA9n5QjfmZgOYlyBPQNYWXpWGPxje
	b6jXEGG69lE14seWHTQq5Zf7WccQlFvdCU13l9HnW5429n7ICpkmUMSY1rOuxWhp
	3Y9ONVebgCBO48qc2Cw/l+XRlR7QGaHT6Sw3TgUJ4tZTDg20tN0s7ctKoaUsaYzg
	KiKtPiSVs3vQOsgxbS4pWXGRqpmxaap+GHsyuqQOBWflTRr3lurN6lpv+Wg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t2a8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 18:32:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2358430be61so11037855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 11:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749148347; x=1749753147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Brhrophe0A7Gd1KgTCcLb6vKHfZb9nFr0On2wKb0sBY=;
        b=cyz1uOeTZ7UjTpJoVtotCWJAoUIjWJF9/Ar7hcbODrznNNLPgwawnREbSHywstKkKF
         iha7CoYs/0FhnkAv9G8LMtEXIuDUBIEvX1NYxwJvhxOE70zyhDdmzKWPdQDi+ersqm6X
         uSI87n24sWOnkBnqndOobAkp72okbz30OA1EPS3BdolVAkpWL2IH5ogWvXX5PL1iExeQ
         OX5NjuGkfZcfty8uJ/spnjC5SjCsASOKSWcpLeHdcvqbX5DspCrLTjvyDClsGE0NXVaJ
         6/RA+AUvfFPfltnJJcTWMxeEeyAvbZpWQJgan+/RIVbyQRKV55eoc652NYydGqD3A0je
         XI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFHMjT5zVFQlTThUYEBGi/5WKghDXe66Rz8XoLINuVME0xX1qkRcyU0Fj9E9NMlWlUFShMuwQn0ZeItbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NiJiQdkI/9FbB0O6S77FmhwEQyoFnjz2OX/bm65pG5t+ENUT
	E81TAYrGcdP7cXfHZFQhlQJkDJWRLwAMIImxdJJ5m/Q24w8JecGE/agaui0+AKOra5BinLvX3cB
	Qr6RGX/32lRYOdwT07KP2e59EjJg0IBURK8eUpCHRAM2kDvt1I88tkXdtGekVHrGnQZY=
X-Gm-Gg: ASbGncssK0u9sV8Ien1LlZ680wbloN9cesT1NQKxA7xImdI8eEKz7G7PB8aUWax1Nz4
	xDhbu+7cL+gkPtOKi309SiHTR4JgFxLFimHn0k9Ip4Nc3jQpTSl1KzaT1raiicXq2WIvQBtWjcv
	5cAk8MZZgKZG2lmEsOSJmlQYO84aCiRXpO1vj2ctD/ujLOKO/mfKiEly7V/afc8Bz1+FTkC65O1
	Y2dVWxQlIFtN1ZP188MdvdOt/feBCcdUotEKL7N56/KUpnwbUuSaL4RN64xYYOSwM6jgEDVZP3X
	o+xDQGco12xN0+33Vjdw9Afg/NSDBMrU
X-Received: by 2002:a17:902:e74b:b0:234:d292:be84 with SMTP id d9443c01a7336-23601d03d04mr5238115ad.10.1749148346974;
        Thu, 05 Jun 2025 11:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIpAaR9nJk0+C/rdnRHx8nDbyCbsUqHMUAYtyQHeF1cAWV1uU8sWLZbiJNIyhPn1qDZ2MQuQ==
X-Received: by 2002:a17:902:e74b:b0:234:d292:be84 with SMTP id d9443c01a7336-23601d03d04mr5237625ad.10.1749148346417;
        Thu, 05 Jun 2025 11:32:26 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:89fa:e299:1a34:c1f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14c84sm122209175ad.222.2025.06.05.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:32:26 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 05/40] drm/msm: Remove vram carveout support
Date: Thu,  5 Jun 2025 11:28:50 -0700
Message-ID: <20250605183111.163594-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605183111.163594-1-robin.clark@oss.qualcomm.com>
References: <20250605183111.163594-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O4HTZ69tbJqsdDg7gXWnrfmgbUkhApbB
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=6841e2bc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=2B-FfE5MDWLa5Dp4eRYA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: O4HTZ69tbJqsdDg7gXWnrfmgbUkhApbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE2NSBTYWx0ZWRfX9vZlA/3nzLDK
 5zOu4vxY3LUs3QeZk+V0AdZCtUsWl0qWIqkfEehRoJWhFBog07KYp9w9vV+sDmdsxSSU2E69dv5
 7IextAsYhp22mETt4NelyK2ddZrD7MWajXBnk0PlzAFsujjPbjErD7Qq+2BaATDF5ASSdW9LQ1A
 hex/AOCKSu2nLpBD7CwvlVv0pG5lPj02ET48Eak63munVDcmRoVZntl1shAz7vGZOdsf4YusHAJ
 cLgvfT0mxwjI++UmObZwiDLbM1Vo8pCI9jxYvSgmUuqzWTHPYtNfEEBqqDXO0dsNlutwAxGNDRT
 c2bG0J3Q5fo9Q75IgPVWUBTgiKFHORwKzd6KZoG5DTWY5ngeqqNOvlhP3FWUf6q9nXB/xMTBed5
 d7lykZWKbRvxXdZ4P1NaPrTNTRs+udeNa3O9x9XRisqPmPVf5hGpch1VTWBMUwMz97o6VXi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050165

From: Rob Clark <robdclark@chromium.org>

It is standing in the way of drm_gpuvm / VM_BIND support.  Not to
mention frequently broken and rarely tested.  And I think only needed
for a 10yr old not quite upstream SoC (msm8974).

Maybe we can add support back in later, but I'm doubtful.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |   8 --
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c      |  15 ---
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c      |  15 ---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |   3 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |   3 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c |   4 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   1 -
 drivers/gpu/drm/msm/msm_drv.c              | 117 +-----------------
 drivers/gpu/drm/msm/msm_drv.h              |  11 --
 drivers/gpu/drm/msm/msm_gem.c              | 131 ++-------------------
 drivers/gpu/drm/msm/msm_gem.h              |   5 -
 drivers/gpu/drm/msm/msm_gem_submit.c       |   5 -
 drivers/gpu/drm/msm/msm_gpu.c              |   6 +-
 14 files changed, 19 insertions(+), 309 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index 5eb063ed0b46..095bae92e3e8 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -551,14 +551,6 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 	else
 		adreno_gpu->registers = a220_registers;
 
-	if (!gpu->vm) {
-		dev_err(dev->dev, "No memory protection without MMU\n");
-		if (!allow_vram_carveout) {
-			ret = -ENXIO;
-			goto fail;
-		}
-	}
-
 	return gpu;
 
 fail:
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 434e6ededf83..a956cd79195e 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -581,21 +581,6 @@ struct msm_gpu *a3xx_gpu_init(struct drm_device *dev)
 			goto fail;
 	}
 
-	if (!gpu->vm) {
-		/* TODO we think it is possible to configure the GPU to
-		 * restrict access to VRAM carveout.  But the required
-		 * registers are unknown.  For now just bail out and
-		 * limp along with just modesetting.  If it turns out
-		 * to not be possible to restrict access, then we must
-		 * implement a cmdstream validator.
-		 */
-		DRM_DEV_ERROR(dev->dev, "No memory protection without IOMMU\n");
-		if (!allow_vram_carveout) {
-			ret = -ENXIO;
-			goto fail;
-		}
-	}
-
 	icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
 	if (IS_ERR(icc_path)) {
 		ret = PTR_ERR(icc_path);
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 2c75debcfd84..83f6329accba 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -695,21 +695,6 @@ struct msm_gpu *a4xx_gpu_init(struct drm_device *dev)
 
 	adreno_gpu->uche_trap_base = 0xffff0000ffff0000ull;
 
-	if (!gpu->vm) {
-		/* TODO we think it is possible to configure the GPU to
-		 * restrict access to VRAM carveout.  But the required
-		 * registers are unknown.  For now just bail out and
-		 * limp along with just modesetting.  If it turns out
-		 * to not be possible to restrict access, then we must
-		 * implement a cmdstream validator.
-		 */
-		DRM_DEV_ERROR(dev->dev, "No memory protection without IOMMU\n");
-		if (!allow_vram_carveout) {
-			ret = -ENXIO;
-			goto fail;
-		}
-	}
-
 	icc_path = devm_of_icc_get(&pdev->dev, "gfx-mem");
 	if (IS_ERR(icc_path)) {
 		ret = PTR_ERR(icc_path);
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index dc31bc0afca4..04138a06724b 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1786,8 +1786,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
-	if (gpu->vm)
-		msm_mmu_set_fault_handler(gpu->vm->mmu, gpu, a5xx_fault_handler);
+	msm_mmu_set_fault_handler(gpu->vm->mmu, gpu, a5xx_fault_handler);
 
 	/* Set up the preemption specific bits and pieces for each ringbuffer */
 	a5xx_preempt_init(gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d05c00624f74..f4d9cdbc5602 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2547,8 +2547,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	adreno_gpu->uche_trap_base = 0x1fffffffff000ull;
 
-	if (gpu->vm)
-		msm_mmu_set_fault_handler(gpu->vm->mmu, gpu, a6xx_fault_handler);
+	msm_mmu_set_fault_handler(gpu->vm->mmu, gpu, a6xx_fault_handler);
 
 	a6xx_calc_ubwc_config(adreno_gpu);
 	/* Set up the preemption specific bits and pieces for each ringbuffer */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index f4552b8c6767..6b0390c38bff 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -16,10 +16,6 @@ bool snapshot_debugbus = false;
 MODULE_PARM_DESC(snapshot_debugbus, "Include debugbus sections in GPU devcoredump (if not fused off)");
 module_param_named(snapshot_debugbus, snapshot_debugbus, bool, 0600);
 
-bool allow_vram_carveout = false;
-MODULE_PARM_DESC(allow_vram_carveout, "Allow using VRAM Carveout, in place of IOMMU");
-module_param_named(allow_vram_carveout, allow_vram_carveout, bool, 0600);
-
 int enable_preemption = -1;
 MODULE_PARM_DESC(enable_preemption, "Enable preemption (A7xx only) (1=on , 0=disable, -1=auto (default))");
 module_param(enable_preemption, int, 0600);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index b01d9efb8663..35a99c81f7e0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -209,7 +209,9 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
 	u64 start, size;
 
 	mmu = msm_iommu_gpu_new(&pdev->dev, gpu, quirks);
-	if (IS_ERR_OR_NULL(mmu))
+	if (!mmu)
+		return ERR_PTR(-ENODEV);
+	else if (IS_ERR_OR_NULL(mmu))
 		return ERR_CAST(mmu);
 
 	geometry = msm_iommu_get_geometry(mmu);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 258c5c6dde2e..bbd7e664286e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -18,7 +18,6 @@
 #include "adreno_pm4.xml.h"
 
 extern bool snapshot_debugbus;
-extern bool allow_vram_carveout;
 
 enum {
 	ADRENO_FW_PM4 = 0,
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 903abf3532e0..978f1d355b42 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -46,12 +46,6 @@
 #define MSM_VERSION_MINOR	12
 #define MSM_VERSION_PATCHLEVEL	0
 
-static void msm_deinit_vram(struct drm_device *ddev);
-
-static char *vram = "16m";
-MODULE_PARM_DESC(vram, "Configure VRAM size (for devices without IOMMU/GPUMMU)");
-module_param(vram, charp, 0);
-
 bool dumpstate;
 MODULE_PARM_DESC(dumpstate, "Dump KMS state on errors");
 module_param(dumpstate, bool, 0600);
@@ -97,8 +91,6 @@ static int msm_drm_uninit(struct device *dev)
 	if (priv->kms)
 		msm_drm_kms_uninit(dev);
 
-	msm_deinit_vram(ddev);
-
 	component_unbind_all(dev, ddev);
 
 	ddev->dev_private = NULL;
@@ -109,107 +101,6 @@ static int msm_drm_uninit(struct device *dev)
 	return 0;
 }
 
-bool msm_use_mmu(struct drm_device *dev)
-{
-	struct msm_drm_private *priv = dev->dev_private;
-
-	/*
-	 * a2xx comes with its own MMU
-	 * On other platforms IOMMU can be declared specified either for the
-	 * MDP/DPU device or for its parent, MDSS device.
-	 */
-	return priv->is_a2xx ||
-		device_iommu_mapped(dev->dev) ||
-		device_iommu_mapped(dev->dev->parent);
-}
-
-static int msm_init_vram(struct drm_device *dev)
-{
-	struct msm_drm_private *priv = dev->dev_private;
-	struct device_node *node;
-	unsigned long size = 0;
-	int ret = 0;
-
-	/* In the device-tree world, we could have a 'memory-region'
-	 * phandle, which gives us a link to our "vram".  Allocating
-	 * is all nicely abstracted behind the dma api, but we need
-	 * to know the entire size to allocate it all in one go. There
-	 * are two cases:
-	 *  1) device with no IOMMU, in which case we need exclusive
-	 *     access to a VRAM carveout big enough for all gpu
-	 *     buffers
-	 *  2) device with IOMMU, but where the bootloader puts up
-	 *     a splash screen.  In this case, the VRAM carveout
-	 *     need only be large enough for fbdev fb.  But we need
-	 *     exclusive access to the buffer to avoid the kernel
-	 *     using those pages for other purposes (which appears
-	 *     as corruption on screen before we have a chance to
-	 *     load and do initial modeset)
-	 */
-
-	node = of_parse_phandle(dev->dev->of_node, "memory-region", 0);
-	if (node) {
-		struct resource r;
-		ret = of_address_to_resource(node, 0, &r);
-		of_node_put(node);
-		if (ret)
-			return ret;
-		size = r.end - r.start + 1;
-		DRM_INFO("using VRAM carveout: %lx@%pa\n", size, &r.start);
-
-		/* if we have no IOMMU, then we need to use carveout allocator.
-		 * Grab the entire DMA chunk carved out in early startup in
-		 * mach-msm:
-		 */
-	} else if (!msm_use_mmu(dev)) {
-		DRM_INFO("using %s VRAM carveout\n", vram);
-		size = memparse(vram, NULL);
-	}
-
-	if (size) {
-		unsigned long attrs = 0;
-		void *p;
-
-		priv->vram.size = size;
-
-		drm_mm_init(&priv->vram.mm, 0, (size >> PAGE_SHIFT) - 1);
-		spin_lock_init(&priv->vram.lock);
-
-		attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
-		attrs |= DMA_ATTR_WRITE_COMBINE;
-
-		/* note that for no-kernel-mapping, the vaddr returned
-		 * is bogus, but non-null if allocation succeeded:
-		 */
-		p = dma_alloc_attrs(dev->dev, size,
-				&priv->vram.paddr, GFP_KERNEL, attrs);
-		if (!p) {
-			DRM_DEV_ERROR(dev->dev, "failed to allocate VRAM\n");
-			priv->vram.paddr = 0;
-			return -ENOMEM;
-		}
-
-		DRM_DEV_INFO(dev->dev, "VRAM: %08x->%08x\n",
-				(uint32_t)priv->vram.paddr,
-				(uint32_t)(priv->vram.paddr + size));
-	}
-
-	return ret;
-}
-
-static void msm_deinit_vram(struct drm_device *ddev)
-{
-	struct msm_drm_private *priv = ddev->dev_private;
-	unsigned long attrs = DMA_ATTR_NO_KERNEL_MAPPING;
-
-	if (!priv->vram.paddr)
-		return;
-
-	drm_mm_takedown(&priv->vram.mm);
-	dma_free_attrs(ddev->dev, priv->vram.size, NULL, priv->vram.paddr,
-			attrs);
-}
-
 static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(dev);
@@ -256,16 +147,12 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 			goto err_destroy_wq;
 	}
 
-	ret = msm_init_vram(ddev);
-	if (ret)
-		goto err_destroy_wq;
-
 	dma_set_max_seg_size(dev, UINT_MAX);
 
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
-		goto err_deinit_vram;
+		goto err_destroy_wq;
 
 	ret = msm_gem_shrinker_init(ddev);
 	if (ret)
@@ -302,8 +189,6 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 
 	return ret;
 
-err_deinit_vram:
-	msm_deinit_vram(ddev);
 err_destroy_wq:
 	destroy_workqueue(priv->wq);
 err_put_dev:
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 0e675c9a7f83..ad509403f072 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -183,17 +183,6 @@ struct msm_drm_private {
 
 	struct msm_drm_thread event_thread[MAX_CRTCS];
 
-	/* VRAM carveout, used when no IOMMU: */
-	struct {
-		unsigned long size;
-		dma_addr_t paddr;
-		/* NOTE: mm managed at the page level, size is in # of pages
-		 * and position mm_node->start is in # of pages:
-		 */
-		struct drm_mm mm;
-		spinlock_t lock; /* Protects drm_mm node allocation/removal */
-	} vram;
-
 	struct notifier_block vmap_notifier;
 	struct shrinker *shrinker;
 
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 07a30d29248c..621fb4e17a2e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -17,24 +17,8 @@
 #include <trace/events/gpu_mem.h>
 
 #include "msm_drv.h"
-#include "msm_fence.h"
 #include "msm_gem.h"
 #include "msm_gpu.h"
-#include "msm_mmu.h"
-
-static dma_addr_t physaddr(struct drm_gem_object *obj)
-{
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct msm_drm_private *priv = obj->dev->dev_private;
-	return (((dma_addr_t)msm_obj->vram_node->start) << PAGE_SHIFT) +
-			priv->vram.paddr;
-}
-
-static bool use_pages(struct drm_gem_object *obj)
-{
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	return !msm_obj->vram_node;
-}
 
 static int pgprot = 0;
 module_param(pgprot, int, 0600);
@@ -139,36 +123,6 @@ static void update_lru(struct drm_gem_object *obj)
 	mutex_unlock(&priv->lru.lock);
 }
 
-/* allocate pages from VRAM carveout, used when no IOMMU: */
-static struct page **get_pages_vram(struct drm_gem_object *obj, int npages)
-{
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct msm_drm_private *priv = obj->dev->dev_private;
-	dma_addr_t paddr;
-	struct page **p;
-	int ret, i;
-
-	p = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
-	spin_lock(&priv->vram.lock);
-	ret = drm_mm_insert_node(&priv->vram.mm, msm_obj->vram_node, npages);
-	spin_unlock(&priv->vram.lock);
-	if (ret) {
-		kvfree(p);
-		return ERR_PTR(ret);
-	}
-
-	paddr = physaddr(obj);
-	for (i = 0; i < npages; i++) {
-		p[i] = pfn_to_page(__phys_to_pfn(paddr));
-		paddr += PAGE_SIZE;
-	}
-
-	return p;
-}
-
 static struct page **get_pages(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
@@ -180,10 +134,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
 		struct page **p;
 		int npages = obj->size >> PAGE_SHIFT;
 
-		if (use_pages(obj))
-			p = drm_gem_get_pages(obj);
-		else
-			p = get_pages_vram(obj, npages);
+		p = drm_gem_get_pages(obj);
 
 		if (IS_ERR(p)) {
 			DRM_DEV_ERROR(dev->dev, "could not get pages: %ld\n",
@@ -216,18 +167,6 @@ static struct page **get_pages(struct drm_gem_object *obj)
 	return msm_obj->pages;
 }
 
-static void put_pages_vram(struct drm_gem_object *obj)
-{
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct msm_drm_private *priv = obj->dev->dev_private;
-
-	spin_lock(&priv->vram.lock);
-	drm_mm_remove_node(msm_obj->vram_node);
-	spin_unlock(&priv->vram.lock);
-
-	kvfree(msm_obj->pages);
-}
-
 static void put_pages(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
@@ -248,10 +187,7 @@ static void put_pages(struct drm_gem_object *obj)
 
 		update_device_mem(obj->dev->dev_private, -obj->size);
 
-		if (use_pages(obj))
-			drm_gem_put_pages(obj, msm_obj->pages, true, false);
-		else
-			put_pages_vram(obj);
+		drm_gem_put_pages(obj, msm_obj->pages, true, false);
 
 		msm_obj->pages = NULL;
 		update_lru(obj);
@@ -1215,19 +1151,10 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, uint32_t size, uint32
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj = NULL;
-	bool use_vram = false;
 	int ret;
 
 	size = PAGE_ALIGN(size);
 
-	if (!msm_use_mmu(dev))
-		use_vram = true;
-	else if ((flags & (MSM_BO_STOLEN | MSM_BO_SCANOUT)) && priv->vram.size)
-		use_vram = true;
-
-	if (GEM_WARN_ON(use_vram && !priv->vram.size))
-		return ERR_PTR(-EINVAL);
-
 	/* Disallow zero sized objects as they make the underlying
 	 * infrastructure grumpy
 	 */
@@ -1240,44 +1167,16 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, uint32_t size, uint32
 
 	msm_obj = to_msm_bo(obj);
 
-	if (use_vram) {
-		struct msm_gem_vma *vma;
-		struct page **pages;
-
-		drm_gem_private_object_init(dev, obj, size);
-
-		msm_gem_lock(obj);
-
-		vma = add_vma(obj, NULL);
-		msm_gem_unlock(obj);
-		if (IS_ERR(vma)) {
-			ret = PTR_ERR(vma);
-			goto fail;
-		}
-
-		to_msm_bo(obj)->vram_node = &vma->node;
-
-		msm_gem_lock(obj);
-		pages = get_pages(obj);
-		msm_gem_unlock(obj);
-		if (IS_ERR(pages)) {
-			ret = PTR_ERR(pages);
-			goto fail;
-		}
-
-		vma->iova = physaddr(obj);
-	} else {
-		ret = drm_gem_object_init(dev, obj, size);
-		if (ret)
-			goto fail;
-		/*
-		 * Our buffers are kept pinned, so allocating them from the
-		 * MOVABLE zone is a really bad idea, and conflicts with CMA.
-		 * See comments above new_inode() why this is required _and_
-		 * expected if you're going to pin these pages.
-		 */
-		mapping_set_gfp_mask(obj->filp->f_mapping, GFP_HIGHUSER);
-	}
+	ret = drm_gem_object_init(dev, obj, size);
+	if (ret)
+		goto fail;
+	/*
+	 * Our buffers are kept pinned, so allocating them from the
+	 * MOVABLE zone is a really bad idea, and conflicts with CMA.
+	 * See comments above new_inode() why this is required _and_
+	 * expected if you're going to pin these pages.
+	 */
+	mapping_set_gfp_mask(obj->filp->f_mapping, GFP_HIGHUSER);
 
 	drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
 
@@ -1305,12 +1204,6 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	uint32_t size;
 	int ret, npages;
 
-	/* if we don't have IOMMU, don't bother pretending we can import: */
-	if (!msm_use_mmu(dev)) {
-		DRM_DEV_ERROR(dev->dev, "cannot import without IOMMU\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	size = PAGE_ALIGN(dmabuf->size);
 
 	ret = msm_gem_new_impl(dev, size, MSM_BO_WC, &obj);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index d2f39a371373..c16b11182831 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -102,11 +102,6 @@ struct msm_gem_object {
 
 	struct list_head vmas;    /* list of msm_gem_vma */
 
-	/* For physically contiguous buffers.  Used when we don't have
-	 * an IOMMU.  Also used for stolen/splashscreen buffer.
-	 */
-	struct drm_mm_node *vram_node;
-
 	char name[32]; /* Identifier to print for the debugfs files */
 
 	/* userspace metadata backchannel */
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index a59816b6b6de..c184b1a1f522 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -669,11 +669,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (args->pad)
 		return -EINVAL;
 
-	if (unlikely(!ctx->vm) && !capable(CAP_SYS_RAWIO)) {
-		DRM_ERROR_RATELIMITED("IOMMU support or CAP_SYS_RAWIO required!\n");
-		return -EPERM;
-	}
-
 	/* for now, we just have 3d pipe.. eventually this would need to
 	 * be more clever to dispatch to appropriate gpu module:
 	 */
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0d466a2e9b32..b30800f80120 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -944,12 +944,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	msm_devfreq_init(gpu);
 
-
 	gpu->vm = gpu->funcs->create_vm(gpu, pdev);
-
-	if (gpu->vm == NULL)
-		DRM_DEV_INFO(drm->dev, "%s: no IOMMU, fallback to VRAM carveout!\n", name);
-	else if (IS_ERR(gpu->vm)) {
+	if (IS_ERR(gpu->vm)) {
 		ret = PTR_ERR(gpu->vm);
 		goto fail;
 	}
-- 
2.49.0


