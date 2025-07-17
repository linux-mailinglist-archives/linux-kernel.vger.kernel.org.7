Return-Path: <linux-kernel+bounces-735519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6165B09072
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083245A1A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644342C15B2;
	Thu, 17 Jul 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3Qcr1D1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8A2D661D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765579; cv=none; b=HzZpwO3J0aW60HeyIgS+dJiH6eHpxk0fhpwLyPbFLdS1UqDI1+CTvH8o+2+VuPxkWMwJATLZm33wrMHTYSc0cnyJMnmR0fhdbYvA7kIgbyxvrueCMgPtk7krQO5yYOiO/Mu7sKoX2VGECvmSKlJtjm5M+jW8Fd6Fd7pA4ONpwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765579; c=relaxed/simple;
	bh=nIYxBNrh+IGmHzXHyYM5zL3J5yc7OmXVZMJo45Kt+0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urAJDfNY8YO/CbY/LO+p/ufPop5w+L9dMbgBGnRr0y7YPUoK1XaWNIrrYWk4rxFKMrAYiuINLZ+f8xTucXK6bVj0NstDGG+FnhvmQENTSzd74EjlWi1EomKUCpogD6oSOXjxkAzfJysJZu8PQwMkraPEugTlTxpvhvZusMDsXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3Qcr1D1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC3bMP008498
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wdkJ8bz+kx17ne/rgHDgW3wfkXF5IySByRD
	4qnNkc5o=; b=C3Qcr1D1NEUcWP6EY+2mlCyQQfNqpNFXdRT6CEeOShwlyLY6upG
	NvYLb8oYruljiKwllG+0oOpWRm6Ism6qOlxpuxMRtt3rT08fg7JMwOM21fy0t0u+
	n8nEuIS24IeIrah6IxzHQ7SIGbZwJjH+VgieZ8kamfe6db/JnNVH+cKMm/fjGxd+
	psGrYB00jA2ANjF48EhZIh7q/wW5I1fkpcEO+HCGF4kJKt1ff/CY1/kScqmkbZsQ
	sDaRcHIrFnC6DB2E/1XhysUcmcGPyd5QIH8fee7wewLZ3zD2pVFwtQTrJ7SPvkPW
	Ez2aNx0AhXPfvRejnGaUCKBYGyd5fDVAOSQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb86et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:19:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso1623591a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765575; x=1753370375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdkJ8bz+kx17ne/rgHDgW3wfkXF5IySByRD4qnNkc5o=;
        b=q0xW8s+MiRC/segZ3VmSPRDp/zhHTruTOrcZpRu7fho9n0dFEtsrLUIGYC206OP9xv
         Wx+bnQqoh00V86qK0tfV0gBpmmMhn1iZcIR3jbTO73xOcbOt5J1StW84oDHWO+smEm4v
         k1Ul8W4tbNVR9xjz2BLLIloj+cRhWCCR71BZcgKTSiC6gpP+Q989E6xIrB7sqZEzIb/J
         iPS6rZSLAyx0eZp5esXHRJjbyWNYWhCzHnvy+4VrEkk41SZJGJKoGwMrgKTrAVlYnxgN
         VmOaCeHJY2DgXo8giLSNuNm6uGsDxthDXmqU969iFTDjpOFXZE4uTjBJVj3ULptH/DF2
         bGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDtVH5f8RDhGoPsOzaC3KJ5FNSndyuco3n8Onxe2/qav7A0kM4UEzUw/9hEAtKy13EmshL5lROCS7vqog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhYhq2TJqVx2gIfkB0Jth/wbLzLN6dZEqvkVEXabb+nkVIY6j
	oEpqzOiClKMdzEBOk4oujPhdi4Aybp2aftseiF/GEvUjrR9LxcxTHtCiI9v0o4KHGD1M7K9wJ+4
	llFfvbvnsYOk0R7cAobEy/dGRNPY+8IFO3tYW0yxP6Mfa3U5jSU9LMc2CYIiiCM1JW9Q=
X-Gm-Gg: ASbGncveIlWCn+QonEr1eFRoMTyElfbEeKMJrNKBRBqEEIpIUSvRbnutFZPFHNV7dhW
	jlmCMJfQmhFf59raz3ZyTZ+9Y0GnyiSGvgikTvkLWwtrmuXiXOM3c3ee2zr8qM0ieVAfCQcH+fP
	4aOgEv46WTG+hco+JaGtEo+92P4dd2ec1KzEjbeOfdFyiBHAagG+Zk4grEJdF1vtTTEIiv8KoTV
	M7958PryG64sOonvxpkkd+CjT1Bc71SH8CME+PNMG/yRvyLPVKC7yejrkjDTmp3ZGO64tGUOUYp
	TcviWlCfGFqAP7kxts7dcBBEe/Oln295qJlLywcmi1pJuCJX+cU=
X-Received: by 2002:a17:90b:3a91:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-31caf85e029mr5009429a91.15.1752765575436;
        Thu, 17 Jul 2025 08:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJBlIDvX0IMhzg5s1vxarPavrcpaAW/SghWPjLESXyVamMIaNFxD+9sBYlLjBFgfg4OT5j9g==
X-Received: by 2002:a17:90b:3a91:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-31caf85e029mr5009375a91.15.1752765574859;
        Thu, 17 Jul 2025 08:19:34 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7c32f7sm1708090a91.16.2025.07.17.08.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:19:34 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix pagetables setup/teardown serialization
Date: Thu, 17 Jul 2025 08:19:30 -0700
Message-ID: <20250717151931.10228-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eysghoL74tZqxALnDm8OZ5Inr9njECJP
X-Proofpoint-ORIG-GUID: eysghoL74tZqxALnDm8OZ5Inr9njECJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzNCBTYWx0ZWRfXxWesFNW6uoaD
 IfvsFQBg0UJ01wTzkTXDiy8O0OVY1f4YMFVfhpLW9L8KdAq+gor7c5svGhkt+Ozn5EijODOnnhW
 2eeQznpWVFQQoi4oIZLNXWKewhd8/05VnGdsyc3v7GugvkF8oqWcZPckHbsyLJKGSWnqU8cqYl4
 w33n1Ehlu2s9yhZJhc3vOQwFsC+Glk78y3IrSBqC/DdfHnle1DcAkZsucwt5F+lpJJYxE7+j/K8
 MmExKjN4CoTOFfQ9mA0UJA3FxYyDKpQqw8NvlNI2uxaQp12nvVP0+7D+5/TNHpGpHSGmYIKn5gt
 BHDjVxBYgEGki/9KjK5V2R/dSSw0jPeKuzlZeMnDeRF4jW0v1L5/bLcq02lt9oo4tI8IytPsVr6
 IHW0tR0WC7J2prYWGz7CGiRgQ3xLe0PYNeLR4LaWkdiU5nm+MsffdYd32aiGkd6fslRhSogu
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68791488 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=ufhHnk6gINzqDhHgaV0A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170134

An atomic counter is not sufficient, as one task could still be in the
process of tearing things down while another task increments the counter
back up to one and begins setup again.  The race condition existed since
commit b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")
but got bigger in commit dbbde63c9e9d ("drm/msm: Add PRR support").

Fixes: dbbde63c9e9d ("drm/msm: Add PRR support")
Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index cefa50192391..89cdda73711a 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -14,7 +14,9 @@
 struct msm_iommu {
 	struct msm_mmu base;
 	struct iommu_domain *domain;
-	atomic_t pagetables;
+
+	struct mutex init_lock;  /* protects pagetables counter and prr_page */
+	int pagetables;
 	struct page *prr_page;
 
 	struct kmem_cache *pt_cache;
@@ -227,7 +229,8 @@ static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
 	 * If this is the last attached pagetable for the parent,
 	 * disable TTBR0 in the arm-smmu driver
 	 */
-	if (atomic_dec_return(&iommu->pagetables) == 0) {
+	mutex_lock(&iommu->init_lock);
+	if (--iommu->pagetables == 0) {
 		adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, NULL);
 
 		if (adreno_smmu->set_prr_bit) {
@@ -236,6 +239,7 @@ static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
 			iommu->prr_page = NULL;
 		}
 	}
+	mutex_unlock(&iommu->init_lock);
 
 	free_io_pgtable_ops(pagetable->pgtbl_ops);
 	kfree(pagetable);
@@ -568,9 +572,12 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent, bool kernel_m
 	 * If this is the first pagetable that we've allocated, send it back to
 	 * the arm-smmu driver as a trigger to set up TTBR0
 	 */
-	if (atomic_inc_return(&iommu->pagetables) == 1) {
+	mutex_lock(&iommu->init_lock);
+	if (iommu->pagetables++ == 0) {
 		ret = adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, &ttbr0_cfg);
 		if (ret) {
+			iommu->pagetables--;
+			mutex_unlock(&iommu->init_lock);
 			free_io_pgtable_ops(pagetable->pgtbl_ops);
 			kfree(pagetable);
 			return ERR_PTR(ret);
@@ -595,6 +602,7 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent, bool kernel_m
 			adreno_smmu->set_prr_bit(adreno_smmu->cookie, true);
 		}
 	}
+	mutex_unlock(&iommu->init_lock);
 
 	/* Needed later for TLB flush */
 	pagetable->parent = parent;
@@ -730,7 +738,7 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 	iommu->domain = domain;
 	msm_mmu_init(&iommu->base, dev, &funcs, MSM_MMU_IOMMU);
 
-	atomic_set(&iommu->pagetables, 0);
+	mutex_init(&iommu->init_lock);
 
 	ret = iommu_attach_device(iommu->domain, dev);
 	if (ret) {
-- 
2.50.1


