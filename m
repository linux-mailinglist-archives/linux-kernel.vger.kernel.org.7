Return-Path: <linux-kernel+bounces-798323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E185B41C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E6B1A87AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631752F83B9;
	Wed,  3 Sep 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4XdVORX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D82F5321
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896723; cv=none; b=OWS0Y7EHInYWGZP59GUPPu+B3cdsAZJmKnLcbrLrkr6E4H4wMjtngcKFtcgSBQuzjkCi38yPDwbGrp/9xaRXzXBc8ayKNg6ndYbDU+dgxN8V33DFUQPOEHDdQ8q0niZj1Dx9Lf2Ormtsc8/2etg0veS/+gciyBLhWKmD3GhcEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896723; c=relaxed/simple;
	bh=XgvG3m5kSIBDKvpU4SYyvFSPfDje3qBYowIpQvtgTjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBmaogPgwA+bzO3mpOC+VgjMeC5SAYgVY5dAdlIcf+F9j90vLAFa2q9P2VtfD87dmKv5C8BJ5AuoIOBC/cez4xQ8+xx6ICF7Zwk5VSwSBHeeTjOqnqfTYfXTpOxeJ9fPqgEGQvoQk8juVhdchbDCQI4uNFjtr0QKsBYaCRj4CB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4XdVORX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AXM89012933
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nz0DTYoq2i1CypDl+WSyYUknuifhStAAoZEZnTeJyVE=; b=g4XdVORXPXalDxYT
	xHKedkTlqNwsdYuYFkmVtOESx11F2WRIjdrPIYqsd9Cm2XE/WXdHs4L8PcfoDJm+
	iM32KMkh6FqEvaWr8ZdLwVdr05u82vzfKT7Og72cfBxpEHWCZKCw4nsF4onHnNJO
	fLsI5g3wU9LzDntvLmCIegVQGaAKXJxdBhEzNxKSkSeFHIe/7B27+0TGbnaBwX6i
	RBbOGEGg+8/9dj3/CEDbGkJ3FnXyujyuSr+yOL7LqRHetnYFHbV1J4ZOkyHAhfBg
	AFrGsKK7fR5/nLpSp0L6vpINOKHUj8QxraUixbWXSm6iBI1xuxw/5tDgS+NDk4gV
	jU1x3w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9350t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:52:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b325446155so69196701cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896720; x=1757501520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nz0DTYoq2i1CypDl+WSyYUknuifhStAAoZEZnTeJyVE=;
        b=edhmMhG6HWNSjnD/lrqPtLMqp6G7ZFuSCrTXnwMnnLuNmE+b5zVfzu8q77NoQk9YGm
         D5pvwx2rGsoTEAq0UHyzA9pyxoYFMqvGeS/uKx9CMt/a+OeTQjca+wIhcI9jZqEVzK7s
         cBgO3vbL+9y4BECd5FXCx+zRT8UfurV3rzbYKwgDl+bECyDS71cVX/moDUV725Kj1fpT
         GH5Nh99IbVDjfVc8J3O3FKFAklJ+a/I+UDc238U7D8W7Mzz/atsfxVj2UXtBUVIhiepv
         +2OfweAcghQotr4a+JoJ/pAhBM/SGeOye4KNNdTxm0BxcDcHxZPlqpxqb7hiG5jlonjT
         mjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0fgdyIG7mUDNINFp+Wu4RW0YyvWyWsjlzHhEQTWh7BRGFBscUux51lrZwAPoIgcZMxOMUuv/HZiR/F94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+fUSTKOAh/ZNkeywn8LAuv1QGxQb7dhnm1cdnnAGzPDr+CCQ
	b10/8zB8PFuwxhYns2CZAauvLEsWAoRKcy6Z3wdKaK2b7qTE2DtbJmaxLzQfDQXR9WnFLJ6TyoA
	9/1wtS72Hsr9AvMzW0VYkbvUfYiC+o5mgeEEc7BpOcymh+iFi9avwtBaXI/UoGnG71sM=
X-Gm-Gg: ASbGncvHD5aSNdu8d3mYMnM6gpZ8voCnxCya3vgz9Tb8r7R4Mek0qr7L1it5v9Ol4MT
	97jyktiRVYfBS9kn4RZZz0E6hitRYka4ZtjzeNtr9BkcytRYVx7jb6Y3kKwfSd2MAiOYkA0tM1p
	ZdRpTg73mlewVAc/y3dzzz3DAmfxT3ssVhaE4DXbRztp0BIOwmravdJ7AXgplUt1QGgj0h8S9bW
	bYo59MG5gJxhjD6FIhwapFaNQgsO/l72NCWtF9jhbUYSJ/gzyaTcQP9NCxofveTX1sIY7Cln3ac
	GZ4JaEuSMesMNw8Jkd5I5dCDSFuqAWsJrtYetfoizrrZ3hTse6wpmLfSCw10FCNW9yzqus5mxsu
	KYFIIHLhUJSB4ywT3g8NDci/oSCPztAahLT/zpbE+npw214Mng3Zz
X-Received: by 2002:a05:6214:27c1:b0:70d:fa79:badd with SMTP id 6a1803df08f44-70fac700e4dmr162312986d6.1.1756896719410;
        Wed, 03 Sep 2025 03:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERcNbMyHymKYRYhD2rXGN/580BVDxHjeOBLjwZjYoJp/uEY6W4pidzM5XwJifmWBn/ESGhkw==
X-Received: by 2002:a05:6214:27c1:b0:70d:fa79:badd with SMTP id 6a1803df08f44-70fac700e4dmr162312756d6.1.1756896718906;
        Wed, 03 Sep 2025 03:51:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032df6sm9373431fa.39.2025.09.03.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:51:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 13:51:51 +0300
Subject: [PATCH v2 3/4] drm/msm: don't return NULL from msm_iommu_new()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-msm-no-iommu-v2-3-993016250104@oss.qualcomm.com>
References: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
In-Reply-To: <20250903-msm-no-iommu-v2-0-993016250104@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4554;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XgvG3m5kSIBDKvpU4SYyvFSPfDje3qBYowIpQvtgTjo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouB3HK7G1Yelqfd4C1ZDrJRWMaMOxFqX5XwrED
 QRcuPRwkSKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgdxwAKCRCLPIo+Aiko
 1a8CB/0Uqt4GrHsw8xZtlnCX9pyJGsEBV8fKm0L56473WWEkh714PrHlEu3qR6UJ3HBqcPeobKN
 W5pI/lyTMICWIaBakSGJzQ94qY69IH2XeyK3QeM/SR9Kd15yOMg66JzarcObQH0kD3X/4k0nfVL
 8HfK2gfSo7MXnNq5RQkWjtbTAvaM+sU8OIqNYNMu4zza/n1SodXUFt+dGkiPos+XIdBmbXBph7S
 LSmLsxTlZlpV4yYmC2JMR8S/0dpdZuiZT5RjeZcjX95xVPYUqUACts87Ujih4VQeV8K6+xnm/aE
 EL/m/Z+POW2Ry0x6IXPwgP9s6+4Hw2gC9dA4Zc5X5ogkxQT7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 3n-4N4sv9BP3_bnIGVY5MaU4WbmSthnh
X-Proofpoint-ORIG-GUID: 3n-4N4sv9BP3_bnIGVY5MaU4WbmSthnh
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b81dd1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jfHkAfN2M7vHvxOhuUUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX2x4YurLWb1yb
 m7C7WuQ0mkWQNwiPuMnldCWdQP5u2yU31o82/ihARMkjEJqDjfVa9N+xFTY6NNEMbcyJLWOIoys
 y8NDlpLKh0BfbROAWetw4eQ3tBNHvqmU5YErLc7gvcwzFqh7XKDIzUMKJ531hQR6pm/tB0I+jBV
 i+u7fzWUS8oCs11ahI63eHobqh6f2d1tddGcmB5HU8XZh5ESfilj1rXxRi/R9LHJsmfTEd3OGI5
 AD/IB0Fq5sjqj8AVDJe3MQykFRycj6a1H4rfUuz7dnALpudtwACyoeUGLehPkD/As9D6Z/ryYrv
 xpyLiut7ZTZb2JfpnFjPZVdISCo65zmRCdTDv238ngwgFxuqQ4isEbv5ZHLrn97vrfVimfz8Nj8
 WigygC9/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

As we've dropped no-IOMMU support, there is no reason to specially
handle the no-IOMMU case inside msm_iommu_new(). Make it return -ENODEV
if there is no IOMMU (instead of returning NULL) and simplify all
calling sites accordingly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c    |  2 --
 drivers/gpu/drm/msm/adreno/adreno_gpu.c  |  4 +---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 10 ++++++----
 drivers/gpu/drm/msm/msm_iommu.c          |  6 +++---
 drivers/gpu/drm/msm/msm_kms.c            | 12 ++++++------
 5 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 28e6705c6da682c7b41c748e375dda59a6551898..92958c73a5ee605a45314ebbcf2136754fe2fae7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1318,8 +1318,6 @@ static int a6xx_gmu_memory_probe(struct drm_device *drm, struct a6xx_gmu *gmu)
 	struct msm_mmu *mmu;
 
 	mmu = msm_iommu_new(gmu->dev, 0);
-	if (!mmu)
-		return -ENODEV;
 	if (IS_ERR(mmu))
 		return PTR_ERR(mmu);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f1230465bf0d0840274a6eb03a10c4df3a7a68d3..21b4951b065ba51b2a4d1bcf63f912f220d3a1f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -209,9 +209,7 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
 	u64 start, size;
 
 	mmu = msm_iommu_gpu_new(&pdev->dev, gpu, quirks);
-	if (!mmu)
-		return ERR_PTR(-ENODEV);
-	else if (IS_ERR_OR_NULL(mmu))
+	if (IS_ERR(mmu))
 		return ERR_CAST(mmu);
 
 	geometry = msm_iommu_get_geometry(mmu);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 4d1ea9b2619170335ab4d2a2ee46f31e785b2c02..66bfa96965be275270751cba770521cfde2a7004 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -458,14 +458,16 @@ static int mdp4_kms_init(struct drm_device *dev)
 	mdp4_disable(mdp4_kms);
 	mdelay(16);
 
+	if (!device_iommu_mapped(&pdev->dev)) {
+		DRM_DEV_INFO(dev->dev, "no IOMMU, bailing out\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
 	mmu = msm_iommu_new(&pdev->dev, 0);
 	if (IS_ERR(mmu)) {
 		ret = PTR_ERR(mmu);
 		goto fail;
-	} else if (!mmu) {
-		DRM_DEV_INFO(dev->dev, "no IOMMU, bailing out\n");
-		ret = -ENODEV;
-		goto fail;
 	} else {
 		vm  = msm_gem_vm_create(dev, mmu, "mdp4",
 					0x1000, 0x100000000 - 0x1000,
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 76cdd5ea06a02eafa6f76e1c3fb03e0cdc7fd469..6b3d840d8d6786e60b0cb6670f62605969db6a9a 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -721,7 +721,7 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 	int ret;
 
 	if (!device_iommu_mapped(dev))
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	domain = iommu_paging_domain_alloc(dev);
 	if (IS_ERR(domain))
@@ -756,7 +756,7 @@ struct msm_mmu *msm_iommu_disp_new(struct device *dev, unsigned long quirks)
 	struct msm_mmu *mmu;
 
 	mmu = msm_iommu_new(dev, quirks);
-	if (IS_ERR_OR_NULL(mmu))
+	if (IS_ERR(mmu))
 		return mmu;
 
 	iommu = to_msm_iommu(mmu);
@@ -772,7 +772,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
 	struct msm_mmu *mmu;
 
 	mmu = msm_iommu_new(dev, quirks);
-	if (IS_ERR_OR_NULL(mmu))
+	if (IS_ERR(mmu))
 		return mmu;
 
 	iommu = to_msm_iommu(mmu);
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 4c4dcb095c4df97de42d0673aa2842010a249dca..725367157d90e45854cb8a22ea25a3fa3bb218be 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -193,17 +193,17 @@ struct drm_gpuvm *msm_kms_init_vm(struct drm_device *dev)
 	 */
 	if (device_iommu_mapped(mdp_dev))
 		iommu_dev = mdp_dev;
-	else
+	else if (device_iommu_mapped(mdss_dev))
 		iommu_dev = mdss_dev;
-	mmu = msm_iommu_disp_new(iommu_dev, 0);
-	if (IS_ERR(mmu))
-		return ERR_CAST(mmu);
-
-	if (!mmu) {
+	else {
 		drm_info(dev, "no IOMMU, bailing out\n");
 		return ERR_PTR(-ENODEV);
 	}
 
+	mmu = msm_iommu_disp_new(iommu_dev, 0);
+	if (IS_ERR(mmu))
+		return ERR_CAST(mmu);
+
 	vm = msm_gem_vm_create(dev, mmu, "mdp_kms",
 			       0x1000, 0x100000000 - 0x1000, true);
 	if (IS_ERR(vm)) {

-- 
2.47.2


