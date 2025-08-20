Return-Path: <linux-kernel+bounces-777268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4FCB2D789
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2637B409C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E612DCF58;
	Wed, 20 Aug 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xrpJYgPT"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E02DAFA5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680867; cv=none; b=fujpGvQn7EsNVW2W1hphM2ugp8rYYfMt2qBSS2+QJF2pPJsN3qI2PyxMB5wFeLKIQp3Z+7l9YE+wbKRBu37ihKdv3w6mdXrK804MiwGV0/mviPNlXtsvXGtfrx+5UoFaBhNsWRCMgDH5EcSkmaL2pSCBNtosr9b+4Yh2DFvsn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680867; c=relaxed/simple;
	bh=VxWP1RtZGBoLLD4W5dwxuUIsJuYfdEtY8FUDOFtmi4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HomEIhD8+nD2jK5Ps7s+D/WlZbkzGcTB23LUSTu+ZaC9OYmh7uDuUcjIdiKa6VEk6TKRdoiS6eORIFqO6dkcZdlF0Zo54EM5GOGTBPXBRXAgmL+Uv5vXH46mIy7/4qsJQfoTkfONB+Vhhhe8pJLmSt4gGpDQwaW/Cf23C41mdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xrpJYgPT; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755680856; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ei9u2YF++6MO0lYBeBOSJFHTc0M7jUeUTkqRnIOPTM8=;
	b=xrpJYgPTaQo7Q6rDSbM1KZX3XDCmznbywwzdc8gJemvJJieGYkBUWmtgKEagR/oJh0IDHQXvYNPS0olbDJ2Al17Q39RIYRQsth4Kkv3bpsdGoZw8I9JfF5fvFV4IkEZ6bb3LFhzhM/5Y9JLooiKBXz7yAsHlgdKBuiSh+bO+CVs=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBICrd_1755680855 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:07:35 +0800
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
Subject: [RFC PATCH 02/11] mm: khugepaged: generalize collapse_file for mTHP support
Date: Wed, 20 Aug 2025 17:07:13 +0800
Message-ID: <6a2f28b4541bbbc56ea9e07f24b67cef87899a50.1755677674.git.baolin.wang@linux.alibaba.com>
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

Generalize the order of the collapse_file() function to support future
file/shmem mTHP collapse.

No functional changes in this patch.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5d4493b77f3c..e64ed86d28ca 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2064,21 +2064,23 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
  */
 static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			 struct file *file, pgoff_t start,
-			 struct collapse_control *cc)
+			 struct collapse_control *cc,
+			 int order)
 {
 	struct address_space *mapping = file->f_mapping;
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
-	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
+	int nr_pages = 1 << order;
+	pgoff_t index = 0, end = start + nr_pages;
 	LIST_HEAD(pagelist);
-	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
+	XA_STATE_ORDER(xas, &mapping->i_pages, start, order);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
-	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
+	VM_BUG_ON(start & (nr_pages - 1));
 
-	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
+	result = alloc_charge_folio(&new_folio, mm, cc, order);
 	if (result != SCAN_SUCCEED)
 		goto out;
 
@@ -2426,14 +2428,14 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	 * unwritten page.
 	 */
 	folio_mark_uptodate(new_folio);
-	folio_ref_add(new_folio, HPAGE_PMD_NR - 1);
+	folio_ref_add(new_folio, nr_pages - 1);
 
 	if (is_shmem)
 		folio_mark_dirty(new_folio);
 	folio_add_lru(new_folio);
 
 	/* Join all the small entries into a single multi-index entry. */
-	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
+	xas_set_order(&xas, start, order);
 	xas_store(&xas, new_folio);
 	WARN_ON_ONCE(xas_error(&xas));
 	xas_unlock_irq(&xas);
@@ -2496,7 +2498,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
+	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, nr_pages, result);
 	return result;
 }
 
@@ -2599,7 +2601,7 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			result = SCAN_EXCEED_NONE_PTE;
 			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 		} else {
-			result = collapse_file(mm, addr, file, start, cc);
+			result = collapse_file(mm, addr, file, start, cc, HPAGE_PMD_ORDER);
 		}
 	}
 
-- 
2.43.5


