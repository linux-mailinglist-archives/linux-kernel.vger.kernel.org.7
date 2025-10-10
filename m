Return-Path: <linux-kernel+bounces-847882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A0CBCBF26
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCEA7403B22
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08527A456;
	Fri, 10 Oct 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="vmYYsKHu"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873572765C0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081929; cv=none; b=f765m22dg8qQm/FpauiKFI04tf2tpUdA65eGqt6G1T8fAdGMkqrsSiElb2TxgDo4jMxwuZ031LHohHpfbR6KN2UoRmCz45hMpwPXaQyXaKOEUZLhDXSEXd6XllSK9lOcfmlTVpcd7s4cwY91cejCOD+geqWQxo/LunJ5J45ZWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081929; c=relaxed/simple;
	bh=+3khgy47WuUhEGenkXrffbJSfoB0VrdnDSiZ5+OTFtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Uv4tnQpDWtzPR53NdPQL5aceINbUfToEBTnRZyto0yC5ZK0CVrF4tha3bdzwchyV4eUyZx2xmZC1/tZf8/SjrZ7O2eg8nEQAsxhv9PICtkWEIFMGhwzBCXt48g079qtTK/Ap+l08f9EYvmftZeM+0J85VU2X7lNjGxy2vKsBCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=vmYYsKHu; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 599KUNps1851787
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:38:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jTGIVI9/tpsE8fVZ/3kjfgDpw8Qz4Nuu4HevZyU/HOI=; b=vmYYsKHurpd9
	L+Ivt9VEPsD8bpZON/CGwwCc68H4AzLBYIHZlne2RU6MY6BPM2v04YTYqxkW01io
	3AeTyyq4Krfs/GDOouTcAapiGfIdF9zQYLUOg3/4YRFiwt+6aZC1gGjfrY5yXPFg
	4tHn707abEHLiYZLW7GSGFTMNQqNuOcLhW7vN/Xyk0we4CNPAhNUes1Z3r8f4Sc+
	kKvozqubnHRCFdPaDiP093Muz2bzkIQlg+qm2V4oxzVlvpgEDhr0m3JKYNbnJdy6
	z0C+2ta71IrLFQ4Pj1hGxOBf/UtScbJkK9llkF2+j4j621CgAq/b4sdFYzZ6fsvu
	mIiscL2CMA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49pkcqwfnp-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:38:46 -0700 (PDT)
Received: from twshared30833.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 10 Oct 2025 07:38:43 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id 41F4BE937D4; Fri, 10 Oct 2025 00:38:40 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Fri, 10 Oct 2025 00:38:39 -0700
Subject: [PATCH v3 1/3] vfio/type1: sanitize for overflow using
 check_*_overflow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251010-fix-unmap-v3-1-306c724d6998@fb.com>
References: <20251010-fix-unmap-v3-0-306c724d6998@fb.com>
In-Reply-To: <20251010-fix-unmap-v3-0-306c724d6998@fb.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=KNBXzVFo c=1 sm=1 tr=0 ts=68e8b806 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=FOH2dFAWAAAA:8 a=1wVGssBgL94LrMzbKiIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Utdcb-qCldzRduFeYbrRqEjqqJBHfmLA
X-Proofpoint-ORIG-GUID: Utdcb-qCldzRduFeYbrRqEjqqJBHfmLA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA0MyBTYWx0ZWRfX7gfKDdzks8KM
 xS8qdwy3xfpyV+aD9WMbbfFUWSOHtU4fPoIRYyo59UdEhBgoCTQd+nYqj3D6dPDXdgzRVhPzJft
 ZzTk5ESWTJ6DpcmLvcjJvxZEZjZNwxBKJEubGfvvwLWATaccFhoPe8onrFzLKM2H0gbfKoOg5oX
 jpU9Z8rTEnXERUVtBM9UIdMMz0CZy3eHUAAm6+qy2Og+yhfoMyg2CrykuNDjd2P+VtLx5CqO9dO
 NeL3fHd7sojsTkx1gxOmJUmsP3RV46skk3Bk9rv9myxsKRGXSlmdwSx5FBF7nVAmIhIU/6u+GY9
 nYwjRIn5x6j5EilXVi1XU5X3onBG9uinoSFwLLynp4vpkUGmtAPpQ0B9I3iT1XLGSNnvxgBFcdC
 8fEZhIQGCSf9wRCDYXi20yvLBQz2sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01

Adopt check_*_overflow functions to clearly express overflow check
intent.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 drivers/vfio/vfio_iommu_type1.c | 69 ++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f8d68fe77b41..70f4aa9c9aa6 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -37,6 +37,7 @@
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
+#include <linux/overflow.h>
 #include "vfio.h"
 
 #define DRIVER_VERSION  "0.2"
@@ -825,14 +826,25 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 	unsigned long remote_vaddr;
 	struct vfio_dma *dma;
 	bool do_accounting;
+	dma_addr_t iova_end;
+	size_t iova_size;
 
-	if (!iommu || !pages)
+	if (!iommu || !pages || npage < 0)
 		return -EINVAL;
 
 	/* Supported for v2 version only */
 	if (!iommu->v2)
 		return -EACCES;
 
+	if (!npage)
+		return 0;
+
+	if (check_mul_overflow(npage, PAGE_SIZE, &iova_size))
+		return -EOVERFLOW;
+
+	if (check_add_overflow(user_iova, iova_size - 1, &iova_end))
+		return -EOVERFLOW;
+
 	mutex_lock(&iommu->lock);
 
 	if (WARN_ONCE(iommu->vaddr_invalid_count,
@@ -938,12 +950,23 @@ static void vfio_iommu_type1_unpin_pages(void *iommu_data,
 {
 	struct vfio_iommu *iommu = iommu_data;
 	bool do_accounting;
+	dma_addr_t iova_end;
+	size_t iova_size;
 	int i;
 
 	/* Supported for v2 version only */
 	if (WARN_ON(!iommu->v2))
 		return;
 
+	if (WARN_ON(npage < 0) || !npage)
+		return;
+
+	if (WARN_ON(check_mul_overflow(npage, PAGE_SIZE, &iova_size)))
+		return;
+
+	if (WARN_ON(check_add_overflow(user_iova, iova_size - 1, &iova_end)))
+		return;
+
 	mutex_lock(&iommu->lock);
 
 	do_accounting = list_empty(&iommu->domain_list);
@@ -1304,6 +1327,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 	int ret = -EINVAL, retries = 0;
 	unsigned long pgshift;
 	dma_addr_t iova = unmap->iova;
+	dma_addr_t iova_end;
 	u64 size = unmap->size;
 	bool unmap_all = unmap->flags & VFIO_DMA_UNMAP_FLAG_ALL;
 	bool invalidate_vaddr = unmap->flags & VFIO_DMA_UNMAP_FLAG_VADDR;
@@ -1327,9 +1351,14 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 		if (iova || size)
 			goto unlock;
 		size = U64_MAX;
-	} else if (!size || size & (pgsize - 1) ||
-		   iova + size - 1 < iova || size > SIZE_MAX) {
-		goto unlock;
+	} else {
+		if (!size || size & (pgsize - 1) || size > SIZE_MAX)
+			goto unlock;
+
+		if (check_add_overflow(iova, size - 1, &iova_end)) {
+			ret = -EOVERFLOW;
+			goto unlock;
+		}
 	}
 
 	/* When dirty tracking is enabled, allow only min supported pgsize */
@@ -1376,7 +1405,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 		if (dma && dma->iova != iova)
 			goto unlock;
 
-		dma = vfio_find_dma(iommu, iova + size - 1, 0);
+		dma = vfio_find_dma(iommu, iova_end, 0);
 		if (dma && dma->iova + dma->size != iova + size)
 			goto unlock;
 	}
@@ -1578,7 +1607,9 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 {
 	bool set_vaddr = map->flags & VFIO_DMA_MAP_FLAG_VADDR;
 	dma_addr_t iova = map->iova;
+	dma_addr_t iova_end;
 	unsigned long vaddr = map->vaddr;
+	unsigned long vaddr_end;
 	size_t size = map->size;
 	int ret = 0, prot = 0;
 	size_t pgsize;
@@ -1588,6 +1619,15 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	if (map->size != size || map->vaddr != vaddr || map->iova != iova)
 		return -EINVAL;
 
+	if (!size)
+		return -EINVAL;
+
+	if (check_add_overflow(iova, size - 1, &iova_end))
+		return -EOVERFLOW;
+
+	if (check_add_overflow(vaddr, size - 1, &vaddr_end))
+		return -EOVERFLOW;
+
 	/* READ/WRITE from device perspective */
 	if (map->flags & VFIO_DMA_MAP_FLAG_WRITE)
 		prot |= IOMMU_WRITE;
@@ -1603,13 +1643,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 
 	WARN_ON((pgsize - 1) & PAGE_MASK);
 
-	if (!size || (size | iova | vaddr) & (pgsize - 1)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-
-	/* Don't allow IOVA or virtual address wrap */
-	if (iova + size - 1 < iova || vaddr + size - 1 < vaddr) {
+	if ((size | iova | vaddr) & (pgsize - 1)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -1640,7 +1674,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 		goto out_unlock;
 	}
 
-	if (!vfio_iommu_iova_dma_valid(iommu, iova, iova + size - 1)) {
+	if (!vfio_iommu_iova_dma_valid(iommu, iova, iova_end)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -2908,6 +2942,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 		unsigned long pgshift;
 		size_t data_size = dirty.argsz - minsz;
 		size_t iommu_pgsize;
+		dma_addr_t range_end;
 
 		if (!data_size || data_size < sizeof(range))
 			return -EINVAL;
@@ -2916,8 +2951,12 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 				   sizeof(range)))
 			return -EFAULT;
 
-		if (range.iova + range.size < range.iova)
+		if (!range.size)
 			return -EINVAL;
+
+		if (check_add_overflow(range.iova, range.size - 1, &range_end))
+			return -EOVERFLOW;
+
 		if (!access_ok((void __user *)range.bitmap.data,
 			       range.bitmap.size))
 			return -EINVAL;
@@ -2941,7 +2980,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 			ret = -EINVAL;
 			goto out_unlock;
 		}
-		if (!range.size || range.size & (iommu_pgsize - 1)) {
+		if (range.size & (iommu_pgsize - 1)) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}

-- 
2.47.3


