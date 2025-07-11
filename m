Return-Path: <linux-kernel+bounces-727807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE50B02006
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1A7163452
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3362EA14A;
	Fri, 11 Jul 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WcwNocXK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7315A87C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246033; cv=none; b=VNgl5cQJ3GsrJHwx/vHfTFeStsdH0Re2PCwfV5BGSJFXeeQFW9BIHzo7FlsumJQYhzHeisIoovtAEwRI1evrCz8dAgv9IxwvS60wxDttdG3EtylDCjnbPClIy5xQNp6hAuGCsSHUZnsTR5MXiodTJhCiL+ZSlHWO1qHV526nZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246033; c=relaxed/simple;
	bh=nZM+q9BkVWLbX/PWq7+dzyAt5apo4kilw7WFvM2Tvzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTsC41ZsLmZjO+pwrzzPiAvWQ4imUjKmIvQCIvyzyZB/ZqKWSVQ8Yhkegz8ezBKASd5wL2oQweIyWDwaCXzC9NlfolFhfijcbLHXjpZ9R3eujPOLQCpUwaecEnLZWCKyLGmOd9mVzurgzM2Rnu0g31CzRhTrtriK1LsajAzL8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WcwNocXK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BElLoc019810;
	Fri, 11 Jul 2025 14:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=OC8jRvneJ6/43biZvYI7yILAKug/U
	NKBxDHEJaVGoO8=; b=WcwNocXKgXuY7SPo/WGli/8pBU4XMbbmLSL2Zbnf17Mk/
	XQ+Yco26f8D2OT2OK8SZLiG4TF+wAb57A+9DmE7bnjg39z4blfXi3oUJmGR45kmo
	JoALSsB490sIa3cmatVuiP6Jx7vIvMCbsgw1sATwD70brGC5K7JV3xLDV3xhdTGY
	civfwOis9Z3YSu5dA2T8jbij8+Iw4/nbaSKn8mEP2ClYCjopgqvcxVO5D7oVozmw
	sXaEtMtAPKusqqjF9/d71rTK6RX4L1qY2NAwFhHoFToYBUlpfiXtEUHvL7STx0ax
	6/HDrWzzSDJq20aApSgtUmVa2hDuc693ngEtOn0Fw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u4nyr0wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 14:59:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BEaXbJ013546;
	Fri, 11 Jul 2025 14:59:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgeenfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 14:59:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56BExCbR009344;
	Fri, 11 Jul 2025 14:59:12 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-43-115-219.usdhcp.oraclecorp.com [10.43.115.219])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptgeenf1-1;
	Fri, 11 Jul 2025 14:59:12 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        muchun.song@linux.dev, osalvador@suse.de, ziy@nvidia.com,
        vbabka@suse.cz, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/page_owner: convert set_page_owner_migrate_reason() to folios
Date: Fri, 11 Jul 2025 10:59:10 -0400
Message-ID: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwNyBTYWx0ZWRfX3g5hrdRzupDX UN0/bOoRWhh7VkxdRB1rLLlNwydeaqH9zQr9RRq3juy9ESiAlFuEJoT6TkhsFThH2dv+BNdwb+7 1LlhvHRCgWCvlszCLUz6TzJcnuo/FqWTC8vqfslULU2rh0voZQe1upJntvBnE3tjEuaaBOAuUpw
 mpEDPFuRyw9t48/LVXj+yKWndQ9fwFdeWXiR7mdvlL7pJfwVR5xat/wRNVMTbZk9up4PbiHzJ7o 2wpamWogriCAU20IoE8lcsD/xnSSeB0LUlqFYc7cZyeeJMPUGhELMKhkz1sngpDdyTbMhG0jJBJ HivqKA1oi9qeJcwKmmqw3WGeY3g37ys185dhG4bxilI0+RU6CfF04kkKWz0ZIiMhGT4FRwhFqd+
 vYuUE293u65++MFXXbWTiehGcYvXydwpceE7vJYOj0VB9vNVFP5DhWZSh051y6YzXX9RjAZi
X-Authority-Analysis: v=2.4 cv=PJYP+eqC c=1 sm=1 tr=0 ts=687126c2 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=lhtuWcDGdh8_Uon09ZIA:9 cc=ntf awl=host:13600
X-Proofpoint-GUID: oQ0pdj0eRRum9yPlth_Og9cocbsjsnNZ
X-Proofpoint-ORIG-GUID: oQ0pdj0eRRum9yPlth_Og9cocbsjsnNZ

Both callers of set_page_owner_migrate_reason() use folios. Convert the
function to take a folio directly and move the &folio->page conversion
inside __set_page_owner_migrate_reason().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/page_owner.h | 8 ++++----
 mm/hugetlb.c               | 2 +-
 mm/migrate.c               | 2 +-
 mm/page_owner.c            | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index debdc25f08b9..3328357f6dba 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -14,7 +14,7 @@ extern void __set_page_owner(struct page *page,
 extern void __split_page_owner(struct page *page, int old_order,
 			int new_order);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
-extern void __set_page_owner_migrate_reason(struct page *page, int reason);
+extern void __folio_set_owner_migrate_reason(struct folio *folio, int reason);
 extern void __dump_page_owner(const struct page *page);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone);
@@ -43,10 +43,10 @@ static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
 	if (static_branch_unlikely(&page_owner_inited))
 		__folio_copy_owner(newfolio, old);
 }
-static inline void set_page_owner_migrate_reason(struct page *page, int reason)
+static inline void folio_set_owner_migrate_reason(struct folio *folio, int reason)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__set_page_owner_migrate_reason(page, reason);
+		__folio_set_owner_migrate_reason(folio, reason);
 }
 static inline void dump_page_owner(const struct page *page)
 {
@@ -68,7 +68,7 @@ static inline void split_page_owner(struct page *page, int old_order,
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
 {
 }
-static inline void set_page_owner_migrate_reason(struct page *page, int reason)
+static inline void folio_set_owner_migrate_reason(struct folio *folio, int reason)
 {
 }
 static inline void dump_page_owner(const struct page *page)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f13fa5aa6624..753f99b4c718 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7835,7 +7835,7 @@ void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int re
 	struct hstate *h = folio_hstate(old_folio);
 
 	hugetlb_cgroup_migrate(old_folio, new_folio);
-	set_page_owner_migrate_reason(&new_folio->page, reason);
+	folio_set_owner_migrate_reason(new_folio, reason);
 
 	/*
 	 * transfer temporary state of the new hugetlb folio. This is
diff --git a/mm/migrate.c b/mm/migrate.c
index 36b2764204b6..425401b2d4e1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1367,7 +1367,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 
 out_unlock_both:
 	folio_unlock(dst);
-	set_page_owner_migrate_reason(&dst->page, reason);
+	folio_set_owner_migrate_reason(dst, reason);
 	/*
 	 * If migration is successful, decrease refcount of dst,
 	 * which will not free the page because new page owner increased
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 9928c9ac8c31..c3ca21132c2c 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -333,9 +333,9 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	inc_stack_record_count(handle, gfp_mask, 1 << order);
 }
 
-void __set_page_owner_migrate_reason(struct page *page, int reason)
+void __folio_set_owner_migrate_reason(struct folio *folio, int reason)
 {
-	struct page_ext *page_ext = page_ext_get(page);
+	struct page_ext *page_ext = page_ext_get(&folio->page);
 	struct page_owner *page_owner;
 
 	if (unlikely(!page_ext))
-- 
2.43.0



