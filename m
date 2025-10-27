Return-Path: <linux-kernel+bounces-872238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDCC0FAED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE5224E8B39
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC073191C2;
	Mon, 27 Oct 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="0OO3IY7p"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA183164C5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586445; cv=none; b=tRGdUDPizOtgBhxFE3kMYx33bfF+S4uMqe9kpV4vH/IP04ljZNx1TxdbkfJ374m5dnSIc9y5vvfrFnMb69xDboy0L+qeaxIkbC5Og6FfpJsx1qsArzMjIVQhA3NnCdWm+zhNumJLnM+XQs2ojad+lRMM1nUgqXb6gKcZqJSdvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586445; c=relaxed/simple;
	bh=vmF6nvWxqNbXFzu69/Gksni33FeNVvm0wJ/1HODXH5M=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bNM3AZ4OQdCeyGMPp0ih1kottnKu+YnYPJYSgs2ro12Y9/CGzG6ruWV7S/qmddJg4wWC/0HzhCj4B8M4DlkS2QDNct4p6ycvMHRETGr4sgu4uCmz08zMHPjh2kjj0zEe7ZqCCRJ834SuF/ZuLwuLaGPYGk/LXDjS2E1AD+sYN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=0OO3IY7p; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RF6vYo975897
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=3EdQbghvl5q4gACZWD
	GwMFiEEzphPFRQ0iXTsVAXJ60=; b=0OO3IY7puz+NlSbyT4XpMgSskhafpsl44U
	5aGSO0xQPUQIq2eki1tO88OsF9igvGzYaq5rUCHNVWmf22UrIEJy1k7BDYkblYdO
	YrKvqcyuJljkrAYqXLuS7/mtJugcfb0FAtJBoixgwWIkCSdplC8jhCwgDCcEzUGu
	ZXG9qCTqDebz7eYPhV2RqvahxbnYLxllshUhov8YHGp692WMxmH5DC6p3vm6lWKP
	9TXzSqGSDvOiri3+zGs+oKyVJrMTavEo1vF5pLyaQKIeQoItYc48A/AUYCa+xnXP
	KS7uzmi8SlZ/cEOgRN0wlS+vqI8LCjWz+5a92/1HcMgQU53qrSoA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a2b3j9dfc-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:02 -0700 (PDT)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 27 Oct 2025 17:33:59 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 28580)
	id 7915243E092; Mon, 27 Oct 2025 10:33:57 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v5 0/5] vfio: handle DMA map/unmap up to the addressable
 limit
Date: Mon, 27 Oct 2025 10:33:40 -0700
Message-ID: <20251027-fix-unmap-v5-0-4f0fcf8ffb7d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSs/2gC/23MSw6CMBSF4a2Qjr2mLyh15D6MA2hvpQMeaZVoC
 Hu3MDAlcXja+/0LiRg8RnIpFhJw9tGPQxrlqSCma4YHgrdpE055ySgtwfk3vIa+mcAIJ7BWtml
 dQ9L9FDB97q3bPe3Ox+cYPnt6Ztvrv8rMgEFV1UoJjlZKvLr2bMaebImZ50zljAMFVerWYKuV5
 kcmMsZozkRiglZGcWkrresDkznjOZOJaURnNEXLpPmxdV2/1cG8bEQBAAA=
To: Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        David Matlack <dmatlack@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro
	<amastro@fb.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE2MyBTYWx0ZWRfX68zzrK3mun12
 f/MraISYrEka6x/pQBT5z6QHL6t8NsXLOluIPxvwIUf16Hu8BXVCXcd0t/HZvxpYnKzfqDK0Ghv
 9G4nMeNnwzeVqLRzTm/yw0qt54iavqg+4oa3zAGKgfIljnrlpw6Q2RdnijXduyZ9YOsYHq3O47p
 y+fdBXr7KpD3tIJZHsPh+cnCYHXZYkX67axj/0jv70DuJ7IC8bB2MKQ3NIE8AtSN9HKkRGOwQPO
 sglvqoszlU04BXkUYBTxCmHvp4OjYD58TGmmF3EgXKV+FZpSIlccTzPKDVo4Z/4pM1Ez76EnTpw
 cEBe7gFI1w+5WX0TeZAfo+2GkpRh/OXCgwo7ATNyujgjm9i8UOAVZeoSn44XYSV4q/zpsq1V3b0
 JTVt/1CGIBA9iH2f+S4tkpZOsQadNQ==
X-Authority-Analysis: v=2.4 cv=H87WAuYi c=1 sm=1 tr=0 ts=68ffad0a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=FOH2dFAWAAAA:8 a=p-BkhTxdxz5vkaSxPgcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RDoEC-SHMO88CypXTQo06GnxaKLqT_dW
X-Proofpoint-GUID: RDoEC-SHMO88CypXTQo06GnxaKLqT_dW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01

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
before the fix lands in the third commit. Selftests are added in the last
two commits.

[1] https://lore.kernel.org/qemu-devel/20250919213515.917111-1-alejandro.j.jimenez@oracle.com/
[2] https://lore.kernel.org/all/68e18f2c-79ad-45ec-99b9-99ff68ba5438@oracle.com/

Signed-off-by: Alex Mastro <amastro@fb.com>

---
Changes in v5:
- Add vfio selftests
- Clarify commit message
- Link to v4: https://lore.kernel.org/r/20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com

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
Alex Mastro (5):
      vfio/type1: sanitize for overflow using check_*_overflow
      vfio/type1: move iova increment to unmap_unpin_* caller
      vfio/type1: handle DMA map/unmap up to the addressable limit
      vfio: selftests: update DMA map/unmap helpers to support more test kinds
      vfio: selftests: add end of address space DMA map/unmap tests

 drivers/vfio/vfio_iommu_type1.c                    | 173 +++++++++++++--------
 .../testing/selftests/vfio/lib/include/vfio_util.h |  27 +++-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 105 ++++++++++---
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |  94 ++++++++++-
 4 files changed, 308 insertions(+), 91 deletions(-)
---
base-commit: 451bb96328981808463405d436bd58de16dd967d
change-id: 20251005-fix-unmap-c3f3e87dabfa

Best regards,
-- 
Alex Mastro <amastro@fb.com>


