Return-Path: <linux-kernel+bounces-777265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9CB2D793
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72015583004
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B82DC346;
	Wed, 20 Aug 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Apb1wwnA"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760A2D375C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680865; cv=none; b=E4DSFBHnu4P2W1VvSwxZ8ieIgcHSKCWfhjtiwA5c3e3xrwx7SJFRrPiq1JKsOLrowG+owvOnjtjrTLc7G6e0swKdH2PqbD0ksND0JRcwobtgXzyyzoDNunvz9P+Muzv8ycp/LfbtVjgXM5RggukC9B0XZflZ5kmTwcnGqo4qkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680865; c=relaxed/simple;
	bh=j1Nq8oUzOAN3Apk8ICh8S20bLXT7/OScSiLjEPdd8rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub1U5KUqVFg+kJq0up7Th0As5H+caKDOUrj10l0tF0AMdM6MNnjZYaCb0A9FfNZ5c/TZdSp9ci/8ZG9PxtP2w6ikOGqqfls50Ug2MR6UMkouQ8Qv2RQk405ThYU6UDFYzgSo1gsXeW7fQAEEIeLDJO/Gr4xXEGedsHWxUOPyNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Apb1wwnA; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680861; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kaAWoBis1OZYy09ndtQ4e2rlen5KUPlGbetwvB7igCU=;
	b=Apb1wwnAdsehKaTR9oqucuHH23qetBF9iLSbrDG2wT6eKFde5/OxfMCvC1le/3eZL+Ff02tSpiAOok0FzjvjH1lruJ3ezm0buckZZ/1kvYI9nPRWGRpJJg8bebgaq2qhjYPHc5RUD9qRhri2/snPuG04C+TSDmsY2iV88fGdK/Y=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBY56L_1755680859 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:39 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/11] mm: shmem: kick khugepaged for enabling none-PMD-sized shmem mTHPs
Date: Wed, 20 Aug 2025 17:07:16 +0800
Message-ID: <7c8ee99eb146a9e8abd20d110cb591d33fa1ebae.1755677674.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
References: <cover.1755677674.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When only non-PMD-sized mTHP is enabled (such as only 64K mTHP enabled),
we should also allow kicking khugepaged to attempt scanning and collapsing
64K shmem mTHP. Modify shmem_hpage_pmd_enabled() to support shmem mTHP
collapse, and while we are at it, rename it to make the function name
more clear.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/shmem_fs.h |  4 ++--
 mm/khugepaged.c          |  2 +-
 mm/shmem.c               | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6d0f9c599ff7..cbe46e0c8bce 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -118,7 +118,7 @@ int shmem_unuse(unsigned int type);
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
 				loff_t write_end, bool shmem_huge_force);
-bool shmem_hpage_pmd_enabled(void);
+bool shmem_hpage_enabled(void);
 #else
 static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
@@ -127,7 +127,7 @@ static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	return 0;
 }
 
-static inline bool shmem_hpage_pmd_enabled(void)
+static inline bool shmem_hpage_enabled(void)
 {
 	return false;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 53ca7bb72fbc..eb0b433d6ccb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -453,7 +453,7 @@ static bool hugepage_enabled(void)
 	if (READ_ONCE(huge_anon_orders_inherit) &&
 	    hugepage_global_enabled())
 		return true;
-	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
+	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_enabled())
 		return true;
 	return false;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 13cc51df3893..a360738ab732 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1791,17 +1791,17 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-bool shmem_hpage_pmd_enabled(void)
+bool shmem_hpage_enabled(void)
 {
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
-	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_always))
+	if (READ_ONCE(huge_shmem_orders_always))
 		return true;
-	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_madvise))
+	if (READ_ONCE(huge_shmem_orders_madvise))
 		return true;
-	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_within_size))
+	if (READ_ONCE(huge_shmem_orders_within_size))
 		return true;
-	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_inherit) &&
+	if (READ_ONCE(huge_shmem_orders_inherit) &&
 	    shmem_huge != SHMEM_HUGE_NEVER)
 		return true;
 
-- 
2.43.5


