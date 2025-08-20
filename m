Return-Path: <linux-kernel+bounces-777270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF0DB2D79A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF45188A09D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F42DE70A;
	Wed, 20 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eDWwwc0Y"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F32DCC11
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680869; cv=none; b=qQCg9Ej44PijhLEV7mqbxPCW4SpC96pTOVH8ZuSeLqRjW4STMLPYbBgcjLjfU2MDExY0LD8yFX2GlTs/d5mnceXmaAyJ10h2JvrGnyhHWIWhHAu3/wf7mQZJnbemHoI4gZQpwkIXofsNP/LAzLBBts/qZVue55r7RjomxUzOWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680869; c=relaxed/simple;
	bh=pYFuC7WrlZHb/j5yrIiyRfRzsKiq0PRGQ2hwTCLZtus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyru7nxs/6siITy8j/nfoqV3lhBe9ciW/1SHbk63lXohE4PCf9r9wFh7QG/QPGm1V/dO0jfQzWbEO2XQ5HJzWDAIgtAmLlh/b0o4WdU5+SyPWWOSTa++5Bb9Pb5Zh6GqirFHO5dzdrFZskdEm2XKS7FD0M17oMBwtjViYIU81zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eDWwwc0Y; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680863; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EjISQWqO9y1RYDSZTblYyeGwhEoGNvkdz3hoHgtvBm0=;
	b=eDWwwc0Y9ODZ1cQfgcKhueuOazvdOE7ix5maBqTHoNTfNKt8CXo/YBYNjnfPnEyttzrY/yNs3eOyi5idIH4cYLk+SiqqsdWULGOfA+KJQDet7UkRjXfccc+AdrlY0+qKfoKvQyoZFa1vHoCsA7lc2+x64fsdQ6QshFYooz5dTfE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBICuO_1755680862 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:42 +0800
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
Subject: [RFC PATCH 07/11] mm: khugepaged: skip large folios that don't need to be collapsed
Date: Wed, 20 Aug 2025 17:07:18 +0800
Message-ID: <27aa3e9657958cf17d0f42a725155c05b21806e5.1755677674.git.baolin.wang@linux.alibaba.com>
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

If a VMA has already created a mapping of large folios after a successful
mTHP collapse, we can skip those folios that exceed the 'highest_enabled_order'
when scanning the VMA range again, as they can no longer be collapsed further.
This helps prevent wasting CPU cycles.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d5ae2e6c4107..c25b68b13402 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2537,6 +2537,7 @@ static int collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct folio *folio = NULL;
 	struct address_space *mapping = file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, start);
+	unsigned int highest_enabled_order;
 	int present, swap, nr_pages;
 	unsigned long enabled_orders;
 	int node = NUMA_NO_NODE;
@@ -2556,6 +2557,7 @@ static int collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
 	else
 		enabled_orders = BIT(HPAGE_PMD_ORDER);
 	is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
+	highest_enabled_order = highest_order(enabled_orders);
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, start + HPAGE_PMD_NR - 1) {
@@ -2631,8 +2633,11 @@ static int collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
 		/*
 		 * If there are folios present, keep track of it in the bitmap
 		 * for file/shmem mTHP collapse.
+		 * Skip those folios whose order has already exceeded the
+		 * 'highest_enabled_order', meaning they cannot be collapsed
+		 * into larger order folios.
 		 */
-		if (!is_pmd_only) {
+		if (!is_pmd_only && folio_order(folio) < highest_enabled_order) {
 			pgoff_t pgoff = max_t(pgoff_t, start, folio->index) - start;
 
 			nr_pages = min_t(int, HPAGE_PMD_NR - pgoff, nr_pages);
-- 
2.43.5


