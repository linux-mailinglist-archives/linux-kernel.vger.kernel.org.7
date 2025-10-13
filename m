Return-Path: <linux-kernel+bounces-849965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6CBBD177D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A92F4E78E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952E72DC768;
	Mon, 13 Oct 2025 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="pmL3teoT"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4282DA768
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333567; cv=none; b=jOAvrvC8tTyJBEhAYuvviUEfG8s3dgRyqtBZJVugNpzJL8XHpyFZTk1ewuwGvVnYWbHkOIQVFIyOTCdg054aBTLsufKYWfIyvmsfroFuWLKVh5LvsoShU/PAVw4EiBX9gMFT99a8R4uqmjNZXDZrP/fYl9e0ujZmipHurwpKXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333567; c=relaxed/simple;
	bh=JTNhu/382e4Fm08mYKQv1wixPN/gikMoRMPBc7fyVZg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=E+bMrdYru+QtFUwrXHImbtmGalPaAgEmTb6vaRyWHeAINy/ArpuYL9NzmlBT+qzbWP0eh3v93fDtcIFvn4EGTWZstkVQhHyE00eUPtdJMMZxQnsDMPFi6ghAUaWpt3PEzJW7vkdcS+ZbWUK8qkaDQVVktlVVKCdm0/zqigdd8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=pmL3teoT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59D3DWhn536898
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:32:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=xL6Ske1sMSqh8onRsi
	PctKwfCuLmMf34qkpKo1FjMFg=; b=pmL3teoTQIcRkE410EWfsa4N9b0DrZGyRR
	LEsRD/9gFg1kfXnjGHB+Z3n2xh4FGVqAGrirh4khCCVy9VQRWYJoSs2/6QQBe2oL
	7mX22JmROHh37YCdIi6iE6B6BHKcKNJ7FYtbXojVLKfJRfJ9flnG2q8yj5a9ti8v
	ewGRyhQZH4AgYqi7qQH3pbB1rh0D353Swl/b/55yp5Liz9FBTm/7KG5fuE8mcVfI
	+V91LzjbidOsOsUPm7a65vNANDKql98joLEo7ddWiYQFmtB17qRYl/zPC6e6Bd5c
	AEe7MLZ7N/jvfqKgHLAzp3Y7YI6WWwxfy/e1UwGJUkEWeje/L5bw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49rsb6gdyw-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:32:45 -0700 (PDT)
Received: from twshared30833.05.prn5.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 13 Oct 2025 05:32:43 +0000
Received: by devgpu015.cco6.facebook.com (Postfix, from userid 199522)
	id 9CECB102FE45; Sun, 12 Oct 2025 22:32:30 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable
 limit
Date: Sun, 12 Oct 2025 22:32:23 -0700
Message-ID: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOeO7GgC/23MvQ7CIBSG4VtpmMXwVyhO3odxoHCwDLYNKNE0v
 XdpB4OJ4wfneReUIAZI6NQsKEIOKUxjGeLQIDuY8QY4uLIRI6ylhLTYhxd+jnczY8s9h04503u
 Dyv0coXzurcu17CGkxxTfezrT7fVfJVNMsZSdUpyBEwLOvj/a6Y62RGY1UzVjmGDV6t5Cr5Vmv
 4xXjJKa8cI4kVYx4aTW3Zet6/oB4dbi5Q0BAAA=
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyNiBTYWx0ZWRfX3z272fsNA5mj
 a5hUOmVdw3zf/hYdBAFcU4QZW782dUjQ3OkrpHPY7sEjgdWCVoHflN/Er+Uqp5F3zDbQrDFw0Bd
 bXZHqGDEgsKqPldmQQ/hDNUXZIYTxcM8/6aKNY4xqtY3BZFm2FjpXly4TEDewLc7gzn5TaJPBTh
 bhBNSgvLNeC2pSAMxT8P+hEcCjH9zznj+F/FTPW7BQ3YqyncjU/NjJ0YhxueLI5N1/G3BEBzHbC
 dOmMXuV9srcqcB/k+k/xPKcI1Fypw29+6GfE2Q9+5bEmT2icOqATh9qKYssJZ1KcPynGKTEu2tu
 9RrmFhd0mj7VIq297acaYhsKrjsdvlLN5VATL8XSfFvOKFmlUuykbjmG4XFHmyYAe8Mb7VvF67B
 cm5uItrBjHRI33EmyFGM0De4lrfgKQ==
X-Proofpoint-ORIG-GUID: fvtHFCarfVDL0Ycaesb8dMTsERVqQSXM
X-Authority-Analysis: v=2.4 cv=BarVE7t2 c=1 sm=1 tr=0 ts=68ec8efd cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=FOH2dFAWAAAA:8 a=LN3npHLcb8nXURrLiNkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fvtHFCarfVDL0Ycaesb8dMTsERVqQSXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01

This patch series aims to fix vfio_iommu_type.c to support 
VFIO_IOMMU_MAP_DMA and VFIO_IOMMU_UNMAP_DMA operations targeting IOVA
ranges which lie against the addressable limit. i.e. ranges where
iova_start + iova_size would overflow to exactly zero.

Today, the VFIO UAPI has an inconsistency: The
VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE capability of VFIO_IOMMU_GET_INFO
reports that ranges up to the end of the address space are available
for use, but are not really due to bugs in handling boundary conditions.

For example:

vfio_find_dma_first_node is called to find the first dma node to unmap
given an unmap range of [iova..iova+size). The check at the end of the
function intends to test if the dma result lies beyond the end of the
unmap range. The condition is incorrectly satisfied when iova+size
overflows to zero, causing the function to return NULL.

The same issue happens inside vfio_dma_do_unmap's while loop.

This bug was also reported by Alejandro Jimenez in [1][2].

Of primary concern are locations in the current code which perform
comparisons against (iova + size) expressions, where overflow to zero
is possible.

The initial list of candidate locations to audit was taken from the
following:

$ rg 'iova.*\+.*size' -n drivers/vfio/vfio_iommu_type1.c | rg -v '\- 1'
173:            else if (start >= dma->iova + dma->size)
192:            if (start < dma->iova + dma->size) {
216:            if (new->iova + new->size <= dma->iova)
1060:   dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
1233:   if (dma && dma->iova + dma->size != iova + size)
1380:           if (dma && dma->iova + dma->size != iova + size)
1501:           ret = vfio_iommu_map(iommu, iova + dma->size, pfn, npage,
1504:                   vfio_unpin_pages_remote(dma, iova + dma->size, pfn,
1721:           while (iova < dma->iova + dma->size) {
1743:                           i = iova + size;
1744:                           while (i < dma->iova + dma->size &&
1754:                           size_t n = dma->iova + dma->size - iova;
1785:                   iova += size;
1810:           while (iova < dma->iova + dma->size) {
1823:                   i = iova + size;
1824:                   while (i < dma->iova + dma->size &&
2919:           if (range.iova + range.size < range.iova)

This series spend the first couple commits making mechanical preparations
before the fix lands in the last commit.

[1] https://lore.kernel.org/qemu-devel/20250919213515.917111-1-alejandro.j.jimenez@oracle.com/
[2] https://lore.kernel.org/all/68e18f2c-79ad-45ec-99b9-99ff68ba5438@oracle.com/

Signed-off-by: Alex Mastro <amastro@fb.com>
---
Changes in v4:
- Fix type assigned to iova_end
- Clarify overflow checking, add checks to vfio_iommu_type1_dirty_pages
- Consider npage==0 an error for vfio_iommu_type1_pin_pages
- Link to v3: https://lore.kernel.org/r/20251010-fix-unmap-v3-0-306c724d6998@fb.com

Changes in v3:
- Fix handling of unmap_all in vfio_dma_do_unmap
- Fix !range.size to return -EINVAL for VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP
  - Dedup !range.size checking
- Return -EOVERFLOW on check_*_overflow
- Link to v2: https://lore.kernel.org/r/20251007-fix-unmap-v2-0-759bceb9792e@fb.com

Changes in v2:
- Change to patch series rather than single commit
- Expand scope to fix more than just the unmap discovery path
- Link to v1: https://lore.kernel.org/r/20251005-fix-unmap-v1-1-6687732ed44e@fb.com

---
Alex Mastro (3):
      vfio/type1: sanitize for overflow using check_*_overflow
      vfio/type1: move iova increment to unmap_unpin_* caller
      vfio/type1: handle DMA map/unmap up to the addressable limit

 drivers/vfio/vfio_iommu_type1.c | 173 +++++++++++++++++++++++++---------------
 1 file changed, 110 insertions(+), 63 deletions(-)
---
base-commit: 407aa63018d15c35a34938633868e61174d2ef6e
change-id: 20251005-fix-unmap-c3f3e87dabfa

Best regards,
-- 
Alex Mastro <amastro@fb.com>


