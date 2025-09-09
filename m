Return-Path: <linux-kernel+bounces-808858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9108B50581
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8553AA1A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9965E301022;
	Tue,  9 Sep 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlJB3gnO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A422301011
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443470; cv=none; b=AemIhL0XQbVlSz7N53ov0ILfG4ER1oVhAgzcarOM8C/+gKaHzU3S/c1qwgOdPblZoupVgTZTdresXzCdnvK427GE+qLiSaz+X6wEk3kvqN14sh5E8mzGbfV+tU315HxWT49G0OqPbZJpoOEuEiVTfY2bcFBhOImSpa3WazXu2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443470; c=relaxed/simple;
	bh=X77ck/mpcS1PAaSmFhykBwNjo66AqN0J6jvfwxhu4AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPteXU33AHzTlCWYWn80wrABtpBcLjNzA6ddOoaU5vu6/r1ydxKM1t3FB/A+Ep25WzC6SVLns2ARKnGapYpd6jyiypIewUTd366xIAtvSfBxntyD+2ozLlBEUndEqOZCiTiK1zuJTqPtK1R3Xp/81laCDxzl35FJ2kR8nLMJ2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BlJB3gnO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589FtjZk014532;
	Tue, 9 Sep 2025 18:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=IWOZ/MveQGGxyYuOsjNd57QH01BWP
	X4a/YbbD/2Wk+w=; b=BlJB3gnOhm7zcxOUTuC3crwT7IbaExiui/D2JlzUPhk8m
	N+HzS/As/ZbNy0MU3kft6LekYuOo2zj8OiHonvRMKLalZlCBdhQHRQ0O4b8fKtuC
	HG6PKf7kJaWG23yydGWKV4cbxRg6lbi82pWm7+TyEDk3qtcFMvx8GDZAdD8bddc3
	51LdVXsWjJwiE1nq8jAMt90AgfiUaIJZ4eY1TYPw6ZiaVrDU/mEBqp99tA4+5Vrx
	xw2E9JUN24wh59ahKB4rUx8ihUNErlHTQYYEuwfg5wcJISpmBs0G0L18POAWISAY
	qZ2VtyH3ziZXfFPvaNV5KrtCJcDTLBnjWwfrxnOSg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1jse9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 18:44:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589H8kg0033216;
	Tue, 9 Sep 2025 18:44:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdb0db7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 18:44:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 589Ii43G004503;
	Tue, 9 Sep 2025 18:44:04 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdb0daf-1;
	Tue, 09 Sep 2025 18:44:04 +0000
From: Jane Chu <jane.chu@oracle.com>
To: harry.yoo@oracle.com, osalvador@suse.de, liushixin2@huawei.com,
        muchun.song@linux.dev, david@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: jane.chu@oracle.com
Subject: [PATCH] mm/hugetlb: fix copy_hugetlb_page_range() to use ->pt_share_count
Date: Tue,  9 Sep 2025 12:43:57 -0600
Message-ID: <20250909184357.569259-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090184
X-Proofpoint-ORIG-GUID: WRSfngHTR2VCUKNIEOx5Re1gBizfe0Mp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX7xwTxW1qSJZ0
 0IivqUUG1PWFnEgAEN0RWu1g8KqZhe2NiIx6rz4n7+JJ1aYaUfXuHrRsdAXYxUwp6PzkIv0Qjz0
 NJdsrWRlaEGBt1WhdBfuhYyExr0YuMhwpJFNWHJ3NB8YLfzYk54qsNW5gcEiT8bnxQpws5sQQh7
 ceh4VqxwTYFUa9sItnzOb3luiTwmz3LCABn1nLSgEdLfZYD3eb6WfY6wH0t7+lHb0igL0PluI90
 M0D/yKwUhj0sZ4v5iJ4vFTprw3v/zwA2h1pwq8+X8skhueE9h7AnfNWV0iztMQFS8gDyfYU5zdg
 N05Bk5xIFBtMc0gakmMNqEXYTVm5P1g1TwWDY9jQmhhz5iXEbo1dCNDPF2Dslo3CxS309vDDKsO
 1tE2oa8z
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c07575 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=mG3bTaASnfPRmh1c64YA:9
X-Proofpoint-GUID: WRSfngHTR2VCUKNIEOx5Re1gBizfe0Mp

commit 59d9094df3d79 introduced ->pt_share_count dedicated to
hugetlb PMD share count tracking, but omitted fixing
copy_hugetlb_page_range(), leaving the function relying on
page_count() for tracking that no longer works.

When lazy page table copy for hugetlb is disabled (commit bcd51a3c679d),
fork()'ing with hugetlb PMD sharing quickly lockup -

[  239.446559] watchdog: BUG: soft lockup - CPU#75 stuck for 27s!
[  239.446611] RIP: 0010:native_queued_spin_lock_slowpath+0x7e/0x2e0
[  239.446631] Call Trace:
[  239.446633]  <TASK>
[  239.446636]  _raw_spin_lock+0x3f/0x60
[  239.446639]  copy_hugetlb_page_range+0x258/0xb50
[  239.446645]  copy_page_range+0x22b/0x2c0
[  239.446651]  dup_mmap+0x3e2/0x770
[  239.446654]  dup_mm.constprop.0+0x5e/0x230
[  239.446657]  copy_process+0xd17/0x1760
[  239.446660]  kernel_clone+0xc0/0x3e0
[  239.446661]  __do_sys_clone+0x65/0xa0
[  239.446664]  do_syscall_64+0x82/0x930
[  239.446668]  ? count_memcg_events+0xd2/0x190
[  239.446671]  ? syscall_trace_enter+0x14e/0x1f0
[  239.446676]  ? syscall_exit_work+0x118/0x150
[  239.446677]  ? arch_exit_to_user_mode_prepare.constprop.0+0x9/0xb0
[  239.446681]  ? clear_bhb_loop+0x30/0x80
[  239.446684]  ? clear_bhb_loop+0x30/0x80
[  239.446686]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

There are two options to resolve the potential latent issue:
  1. remove the PMD sharing awareness from copy_hugetlb_page_range(),
  2. fix it.
This patch opts for the second option.

Fixes: 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared
count")

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/hugetlb.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b4c718..8ca5b4f7805f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5594,18 +5594,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			break;
 		}
 
-		/*
-		 * If the pagetables are shared don't copy or take references.
-		 *
-		 * dst_pte == src_pte is the common case of src/dest sharing.
-		 * However, src could have 'unshared' and dst shares with
-		 * another vma. So page_count of ptep page is checked instead
-		 * to reliably determine whether pte is shared.
-		 */
-		if (page_count(virt_to_page(dst_pte)) > 1) {
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
+		/* If the pagetables are shared don't copy or take references. */
+		if (ptdesc_pmd_pts_count(virt_to_ptdesc(dst_pte)) > 0) {
 			addr |= last_addr_mask;
 			continue;
 		}
+#endif
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
-- 
2.43.5


