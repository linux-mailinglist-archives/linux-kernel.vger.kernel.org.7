Return-Path: <linux-kernel+bounces-752714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121CB17A13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28AA57AEE57
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD359288C9D;
	Thu, 31 Jul 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDZEfT6t"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76790288C22
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004768; cv=none; b=aPog+WPejFJVlV/VFH/U4p749FN6jtR6fabmHPgbcBlUpoh/wJ+SVjCyC2WLXmaKWG4CR1neYbTjozepYSC3U8Wia+/Pxwwfmq8Gfb/5d+/zE0wXq1VX7m7qpPh9JNd0hSRb3J2EgpwV4EoCXTTS9ZdwdUsZjpr4Wxt4HK+AFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004768; c=relaxed/simple;
	bh=UlMkAqT7/5V1XF1eLVr1URt8h3Aov0qLvLZ+WThGcRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gs7vGK1g1Yb6Xlzf84dHPtXY734FgFnZeLnjXollFATuSPPPfbP30Ls70QZqkQExkNuqeoY9m2HVVXeqNTC58Ns+WcRGwu6yQzZndBfXCqliq83bdAcLxIcWpE6x6wb1MmHl5ldtKCSpcM5LDfBoo1XrBO+kSNDmlIzjfHHGcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDZEfT6t; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VIXtDP014858;
	Thu, 31 Jul 2025 20:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2QWyqOhHxg7JbenWRXhBIzIH7+1hB
	rT59x3bYZFd4Do=; b=eDZEfT6tx541Eqw+re/pmVqKbWTr5SjDb0gU+1r9Z+uBl
	XVdYOYw0CXZl28YXccMOfK53L8U9LMivaTYy+uesnq4ieTV9qt0t+JUmw9kfQCiO
	i1voNJlDTh+SVE6emc6iMOHoMAolxXABIb2WVQxcAisUMmlrKHsOdvR2UGpZe2Dy
	vbat3arTKuBS4A1GcR96X7uJEhmzbLE2KTNyZDviboIgAc+n+i9/M09WBEKgrMpI
	av3TUeBLdqGkvD58RYGr+qnQur1CCEbxzyMs+rsgxuG32sM2Y2LKQc9w+jvarmwG
	CbM8aGq/UIf3XeplsFsifAhOxyIyFFLij9OwAYQLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q734yjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 20:26:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VIWeMu016723;
	Thu, 31 Jul 2025 20:26:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfka1ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 20:26:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56VKQXAF031838;
	Thu, 31 Jul 2025 20:26:33 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 484nfka1tv-1;
	Thu, 31 Jul 2025 20:26:33 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        vbabka@suse.cz, jannh@google.com, pfalcato@suse.de,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/nommu: convert kobjsize() to folios
Date: Thu, 31 Jul 2025 20:26:29 +0000
Message-ID: <20250731202629.3729139-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE0OCBTYWx0ZWRfX0E4moPh1P6rU
 1DL+7fLGMhM9r7inHWS65ub9Evp9dAnNcYAN2CGKWbpKzK5JsUYaMXbc2ryUw4Q7m4W3g3sg5WM
 Dv1biJIjZQvWKnFqDCyqNjU9bKr06Ia+zHXmtsnnfKLAjIkF//s9FHjfKOH1d8Qnsn8s/UPsrgO
 cxbXNsEm9BPSp+nCGswKTbai79qsNjmkzZof5G3BRoQsJWhUK8maCfO761VwWPO9WHpCkQaFAjP
 hm4gb0U5EB+Maw4+8Xm9nA1MyGD12+8X0gPSD37jU5RCv/vdZRfpcfPGvy4oIjkkWhkm4E/Wq3/
 Iay4qFkIQulazsemIg67CW80LwtOSY6t420SWtIyFLEgMOZFNV180hDFUMlqm4LbjCMYKmiapuD
 gnJRt3qGxTPAKhezhzMDv4u4xvEnhyPlW1jLN1Gm2zWmHpStqRy4w0/+9ghUyxJco+TTkxwB
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=688bd17a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=utxCX54T8dCYmmMssvoA:9 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: 3hmwJVy3hG4Kb9OM0nCFB0V7TNz6bREp
X-Proofpoint-ORIG-GUID: 3hmwJVy3hG4Kb9OM0nCFB0V7TNz6bREp

Simple folio conversion to remove a user of PageSlab() and
PageCompound().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/nommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 07504d666d6a..a00f8fc316c1 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -64,7 +64,7 @@ const struct vm_operations_struct generic_file_vm_ops = {
  */
 unsigned int kobjsize(const void *objp)
 {
-	struct page *page;
+	struct folio *folio;
 
 	/*
 	 * If the object we have should not have ksize performed on it,
@@ -73,22 +73,22 @@ unsigned int kobjsize(const void *objp)
 	if (!objp || !virt_addr_valid(objp))
 		return 0;
 
-	page = virt_to_head_page(objp);
+	folio = virt_to_folio(objp);
 
 	/*
 	 * If the allocator sets PageSlab, we know the pointer came from
 	 * kmalloc().
 	 */
-	if (PageSlab(page))
+	if (folio_test_slab(folio))
 		return ksize(objp);
 
 	/*
-	 * If it's not a compound page, see if we have a matching VMA
+	 * If it's not a compound folio, see if we have a matching VMA
 	 * region. This test is intentionally done in reverse order,
 	 * so if there's no VMA, we still fall through and hand back
-	 * PAGE_SIZE for 0-order pages.
+	 * PAGE_SIZE for 0-order folios.
 	 */
-	if (!PageCompound(page)) {
+	if (!folio_test_large(folio)) {
 		struct vm_area_struct *vma;
 
 		vma = find_vma(current->mm, (unsigned long)objp);
@@ -100,7 +100,7 @@ unsigned int kobjsize(const void *objp)
 	 * The ksize() function is only guaranteed to work for pointers
 	 * returned by kmalloc(). So handle arbitrary pointers here.
 	 */
-	return page_size(page);
+	return folio_size(folio);
 }
 
 void vfree(const void *addr)
-- 
2.43.0


