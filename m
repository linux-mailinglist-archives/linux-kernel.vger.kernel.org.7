Return-Path: <linux-kernel+bounces-849966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C4BD1783
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4B944EB190
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8132DE718;
	Mon, 13 Oct 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="sgaXgrnB"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89C2DCF44
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333571; cv=none; b=UC2o5M91ZTfOlFWLfzupAt4FssTgw46gPAJHcCb5CrXVvryzJVepucJYBBG+uSHX9vZTNy/F6RQ9KFICBO0SsJdPEjO3A8j1bhLZaW9eehQ5OIsd8G+S5TPXmstAZadBYZg5sG4RndwQCq7cvkcnD/CbOhlfMl9VEtzLz41Xr3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333571; c=relaxed/simple;
	bh=bL2Lm2n4e9930GjnhR9kYIAZMluDFF1rbD3fEq8ntKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PXb40g3ltyoYYmR0nwee2xtyu9Vx0wodJ2iVsYHcE8cUlm90rF2IA8xfJJ0TfS0lwRen+jZA0yFj9VeZq0bWAQFvZX4BtoGLnHO07EmhX1JonQeKIyYk8kuy3Nbk071ErSJ1A+AiaJk18a+oe7G3TdQP3gNtXQIZgVtEkF+fses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=sgaXgrnB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59D3DWht536898
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:32:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9P0Pku55fBiFAorYlOSjBsBGriWgJG02HANwpST4hjY=; b=sgaXgrnBRCJI
	yNXHOkA9WIDcYkpxODIHQAAEyZsxODY65tUKsGSpE3SAJF3QqAA7skBhzdL6FX+E
	e2awIN1Hu3iBOe7y8zNjyPMHWOoysCh9B2AX+JXqI5YVSuJ7veg/8xbgMwb1QuGf
	xUi5PC5DQO1taLPDY4XZZzsDgCo0Vf2dxP6442FO0BwiEQKTc6uw3M/4hSukE+bU
	c2FonPCywb9nh6VkSxLrSUSlkm0XYmcOj0r981vU3es/dw4KUO2ZGNNgxzG/1lR4
	/FfkXhDnyf2rEMeXiujYZ5XDsO4eNXHMSrIcNpkOkEwY52+yrHBDAZLfQQ/bSW6n
	D3+oN5S4iQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49rsb6gdyw-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:32:48 -0700 (PDT)
Received: from twshared38445.28.prn2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 13 Oct 2025 05:32:44 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id 9E4A4102FE48; Sun, 12 Oct 2025 22:32:30 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Sun, 12 Oct 2025 22:32:25 -0700
Subject: [PATCH v4 2/3] vfio/type1: move iova increment to unmap_unpin_*
 caller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251012-fix-unmap-v4-2-9eefc90ed14c@fb.com>
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
In-Reply-To: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyNiBTYWx0ZWRfX/68TFfxS9wKo
 U5D7OAo4dnBkryzl4LKxpYYsnfuIitO6tQsmq6bx7sQI6soiD3nuxJ3Yq0nSaIkKi4rQpqhAhvC
 fKKcTdULfQIEr8sxoJQ6XtSyMJcmVIfERjk+Is77Vnt7deS5Kdj4CVC+ypCFYWAmrYm++8fnNlY
 gfqNllojb6H8HL1zTyQUvDy3tI1Ju1Bm95jCq5vfvgMSAts0McW85XA/QNTxlTTmMuw/ODsI0VS
 meJM6aFhdoSbXi7DPha2kSgtCwxuY8I6zsLVPtYV+AROE5tItOqvHLx6SPlHZyKJmC7wQJDM+P5
 VixXoycbtETXIxXOElpTt4Kb4hQFihI5EFeWB0flqQ9+pBqmmhjuyc9Jj9wkLDHSdPuX4XhgnDW
 DJLurvWsyiROqbQUkbzUeDiODPm4qg==
X-Proofpoint-ORIG-GUID: ANX-ujIdqNxi6tuZf2PZSJxnihRRVEuv
X-Authority-Analysis: v=2.4 cv=BarVE7t2 c=1 sm=1 tr=0 ts=68ec8f00 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=FOH2dFAWAAAA:8 a=Bkl4-CcWoNymJLHaMFkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ANX-ujIdqNxi6tuZf2PZSJxnihRRVEuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01

Move incrementing iova to the caller of these functions as part of
preparing to handle end of address space map/unmap.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 drivers/vfio/vfio_iommu_type1.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1ac056b27f27..48b84a7af2e1 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1013,7 +1013,7 @@ static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
 #define VFIO_IOMMU_TLB_SYNC_MAX		512
 
 static size_t unmap_unpin_fast(struct vfio_domain *domain,
-			       struct vfio_dma *dma, dma_addr_t *iova,
+			       struct vfio_dma *dma, dma_addr_t iova,
 			       size_t len, phys_addr_t phys, long *unlocked,
 			       struct list_head *unmapped_list,
 			       int *unmapped_cnt,
@@ -1023,18 +1023,17 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
 	struct vfio_regions *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 
 	if (entry) {
-		unmapped = iommu_unmap_fast(domain->domain, *iova, len,
+		unmapped = iommu_unmap_fast(domain->domain, iova, len,
 					    iotlb_gather);
 
 		if (!unmapped) {
 			kfree(entry);
 		} else {
-			entry->iova = *iova;
+			entry->iova = iova;
 			entry->phys = phys;
 			entry->len  = unmapped;
 			list_add_tail(&entry->list, unmapped_list);
 
-			*iova += unmapped;
 			(*unmapped_cnt)++;
 		}
 	}
@@ -1053,18 +1052,17 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
 }
 
 static size_t unmap_unpin_slow(struct vfio_domain *domain,
-			       struct vfio_dma *dma, dma_addr_t *iova,
+			       struct vfio_dma *dma, dma_addr_t iova,
 			       size_t len, phys_addr_t phys,
 			       long *unlocked)
 {
-	size_t unmapped = iommu_unmap(domain->domain, *iova, len);
+	size_t unmapped = iommu_unmap(domain->domain, iova, len);
 
 	if (unmapped) {
-		*unlocked += vfio_unpin_pages_remote(dma, *iova,
+		*unlocked += vfio_unpin_pages_remote(dma, iova,
 						     phys >> PAGE_SHIFT,
 						     unmapped >> PAGE_SHIFT,
 						     false);
-		*iova += unmapped;
 		cond_resched();
 	}
 	return unmapped;
@@ -1127,16 +1125,18 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 		 * First, try to use fast unmap/unpin. In case of failure,
 		 * switch to slow unmap/unpin path.
 		 */
-		unmapped = unmap_unpin_fast(domain, dma, &iova, len, phys,
+		unmapped = unmap_unpin_fast(domain, dma, iova, len, phys,
 					    &unlocked, &unmapped_region_list,
 					    &unmapped_region_cnt,
 					    &iotlb_gather);
 		if (!unmapped) {
-			unmapped = unmap_unpin_slow(domain, dma, &iova, len,
+			unmapped = unmap_unpin_slow(domain, dma, iova, len,
 						    phys, &unlocked);
 			if (WARN_ON(!unmapped))
 				break;
 		}
+
+		iova += unmapped;
 	}
 
 	dma->iommu_mapped = false;

-- 
2.47.3


