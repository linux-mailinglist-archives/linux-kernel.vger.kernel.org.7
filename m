Return-Path: <linux-kernel+bounces-755351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF9B1A545
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4020188C6BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021CC1FE45A;
	Mon,  4 Aug 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYNUHHRI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0631F4612
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319099; cv=none; b=KBz5FbFhoi317OlR7WjejVCp0ZvssHnpX+HKRyi+ZkzUVXkXxXGwz71iNLWJc3A/FbLHmuKQGFQ3IqBlmAlqQQonWMUyIIh/RQ6ue35RzTAPnbNLB5o5ju55ZqMPE8xnTB+oXVPAVFwChdIcC5KH3/borKlmoNHzmnXNipKiaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319099; c=relaxed/simple;
	bh=qyhQcT1N7iutVu9yNBwXOVTCFQcxGs1+cBdoVoBdSzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Shfl26kCQsfEt7++5hAD35sEbWOlX/mGKKI8A7rt33mQyFgx4+fo6zcwsOyaYRXPRrbOKxS/DHA3Y1JRRsjS+9jAXCssU4wpHsy20gKng6iaZY/lHeP01t/MNvNP7tUtt2zjnh7aKJSo0JNyMNGUlehsXjiuS82sc1xUwpzencU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZYNUHHRI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6Wjm018172;
	Mon, 4 Aug 2025 14:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=17C7FOSF4nv5DZMX7LJVuuFlGZvxq
	CMZkETDXsXXfKQ=; b=ZYNUHHRINx01eTzaQ+TA2cGENV/DdCwCQjhmI8aNldiJr
	YF+KSCV9t5cFfZD2M+yViESw56wdHriJPfszwYjguol86CkDEGu+UmbI5jGydQ6K
	Bd15sepWcs3bzKWVhqy5t4BemB94Z8XIYJJtnhGwsdUJiAKXV0X4PPek35U2D1C+
	EQ3uztjIl7b/2c2ldhElAnkr2rN2q1sEjqubZUnIq6NpHVFPGGvYwJbQKKzr7n36
	zIjJZDp3fnTBIqrwLV5yirh8XhUodXr3BVETGQ4jHKbGNJSsC7qlwuv6+sdC0z4/
	32+rpbHwGCKgbJOmumQjrDL1Yoo040MVcI/TnXy9w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489aqfjs89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 14:51:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574EURXT028937;
	Mon, 4 Aug 2025 14:51:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7qcqhtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 14:51:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 574EpKi3018772;
	Mon, 4 Aug 2025 14:51:20 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48a7qcqhsx-1;
	Mon, 04 Aug 2025 14:51:20 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        vbabka@suse.cz, jannh@google.com, pfalcato@suse.de,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2] mm/nommu: convert kobjsize() to folios
Date: Mon,  4 Aug 2025 14:51:17 +0000
Message-ID: <20250804145117.3857308-1-sidhartha.kumar@oracle.com>
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
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040081
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=6890c8ea cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=C5nWjwYK2z89P-DFk5UA:9
X-Proofpoint-GUID: KnLydMSgKGKV-E2Ab43IUgMOPHA-Y8WY
X-Proofpoint-ORIG-GUID: KnLydMSgKGKV-E2Ab43IUgMOPHA-Y8WY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA4MSBTYWx0ZWRfXyGh9MOuz/m/7
 mJqqyTyxT3nXL1PGuqzqmSKyzxf826aHtu1xMNCRQJWXSS1PuwqlWoQaiHcsTsIAJ5dPJPvble6
 4/WfkZH2W72Afon+imOVVw545pQLpIAdOHH4rV0MG6UptHIUnZY89pBeAVWrgEVqynjInhIqee4
 64GIDyXkndZJ69KKmpsIvzkAj39wpSx+r+6u9VJP4lB1X//HUZW9RUxN1AB2GwI79YTC+b4nq6L
 AEqDEokiddajfndpUyVwUz3iaPiNUxAs+j8muORk6JjoDGlCtlDgQBHHYOZmSOVuIOD5p2V21GQ
 kSPf7hzJPDo2kPAntuvPsMk96oocojRXzBuVXHcORZFmUw9A8dxWUqFVb013qPoSvvB4AC2cejL
 tym7qmX+E0UKnV2RZND3dTB4tMoMB5VqmxpkF1khmdt1hlnyH2ER7D4EVztQy4oVPF2Pakju

Simple folio conversion to remove a user of PageSlab() and
PageCompound().

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
v1 -> v2:
	change "compound folio" to "large folio" in comment per SJ

 mm/nommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 07504d666d6a..75548fae28f7 100644
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
+	 * If it's not a large folio, see if we have a matching VMA
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


