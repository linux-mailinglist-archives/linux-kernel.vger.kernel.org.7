Return-Path: <linux-kernel+bounces-845008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5087BC3460
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BD4A349D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A42BE7C0;
	Wed,  8 Oct 2025 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="Q8bzn0rg"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC782BE646
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759896567; cv=none; b=AbOFmUTg5nkZTGoGDsuUSK3n6YrvOruwQ1WjkhjqhcwDFuhWekXi3m6AEM4y2lOsyB2RX40AlnOaJlVqNq+Xi1YTMWpHukVSKBAEYEU5YMZSIHjavBqZafw6Qay6F+kgSD28iuDlXwpSniAtQmkmvc+HjEqE1fuwwa722ANY644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759896567; c=relaxed/simple;
	bh=Sc7RyZvHVnsiWmJJsfqHgDMcvPy6kEMQ+FShuIOWcvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=n/kb3PGmXZexPZsXComyk0w19QPQDn7K0RtbjrEYbwxsRtLrKw7Cy0XRSg2iDDLy9t4dKSNNvpkIuhKZpY+Y7F6RlR6+s2b0s01OgeXdQ2yHYEA4g9TxpsClVlH1r/duuaeT1upMBPSSPLSQc8VuLQApiOFMjRoGRbOAiMqlYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=Q8bzn0rg; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 597IKvDX1854453
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 21:09:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=/DPR3MVV9m01+QHNDlVKZ/bjjUFkh+IA4QwkKhO8QSE=; b=Q8bzn0rgeH4O
	n55ohN99Df8Hk5AwINotNnYHCnOJu8v/J7QTglLi8KyvpQ7N2SsLVirQRoRvJQ0w
	KzCF8u2RnmY/yWAsXQiUHcDlrit3ooYs99t3etE4hm52yoOXl/zllThzk1npoNTz
	LFO51MzvMf8dIFRZ5f0d18oDjK17X/yKu8i/gfagEXwBbQW+Wy8DbnIe/I+ofFy1
	7y1qZ88ZFoobu0VU03d2mImtFL0VpWdWrGJPP5x1BREZC6aOD38AmCp9MSz2UPTL
	aukNecOBSOtf/VMfJJVG8NapCi8yH+qotRcMuo/uDoEpmUacQQRmFsVStqskzD+a
	9zWpLk5Ndw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49n82g394p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:09:25 -0700 (PDT)
Received: from twshared28243.32.prn2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 8 Oct 2025 04:09:23 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id B1A19D26CCF; Tue,  7 Oct 2025 21:09:19 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Tue, 7 Oct 2025 21:08:47 -0700
Subject: [PATCH v2 2/3] vfio/type1: move iova increment to unmap_unpin_*
 caller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251007-fix-unmap-v2-2-759bceb9792e@fb.com>
References: <20251007-fix-unmap-v2-0-759bceb9792e@fb.com>
In-Reply-To: <20251007-fix-unmap-v2-0-759bceb9792e@fb.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: qMj5S8sJD6nMwDErhG_HITDwSPYBA_vO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDAyNCBTYWx0ZWRfX9T84Qw3iQJVv
 TLTXRlb3K5QSNBNwIFejtngdH8NEUfApOOkfyGGE7XJhQDa+pp0JGnT4qAsVVIAUbuDaokNErT0
 GFVcDw4sdPymdFKtzDUdtBiHdmijbq5ikeN334t6rOJWd2xBa2ZINBBBUXGmB9UX7JNb77VUwo+
 2BwY2ZmNGxKg6M/KAuGkEo+A+3hqV2DLhNB3veCHBo9xmxpWxZx6XYda2XYDdA/j79LQcbGrucH
 gxZgKGuZwBPs+xg9qoO8u2INNjeYNDLiZ2z0lwXhU03ZEiCXMeRUce+r5HGkeHBu76pgCdA/Bo3
 96WXVw2sedKMnav9wckKjznxL8A6jCsN4uILvfzsl4KzqGdOCaILnMl0xzmzV+e6bAPkJvk1Kdq
 swgwFPShJWDDMscnKvTjj91014eZhw==
X-Proofpoint-GUID: qMj5S8sJD6nMwDErhG_HITDwSPYBA_vO
X-Authority-Analysis: v=2.4 cv=C5rkCAP+ c=1 sm=1 tr=0 ts=68e5e3f5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=FOH2dFAWAAAA:8 a=Bkl4-CcWoNymJLHaMFkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01

Move incrementing iova to the caller of these functions as part of
preparing to handle end of address space map/unmap.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 drivers/vfio/vfio_iommu_type1.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b510ef3f397b..f6ba2f8b1dd8 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1020,7 +1020,7 @@ static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
 #define VFIO_IOMMU_TLB_SYNC_MAX		512
 
 static size_t unmap_unpin_fast(struct vfio_domain *domain,
-			       struct vfio_dma *dma, dma_addr_t *iova,
+			       struct vfio_dma *dma, dma_addr_t iova,
 			       size_t len, phys_addr_t phys, long *unlocked,
 			       struct list_head *unmapped_list,
 			       int *unmapped_cnt,
@@ -1030,18 +1030,17 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
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
@@ -1060,18 +1059,17 @@ static size_t unmap_unpin_fast(struct vfio_domain *domain,
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
@@ -1134,16 +1132,18 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
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


