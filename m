Return-Path: <linux-kernel+bounces-757893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A755B1C805
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C505217F82E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93D220F25;
	Wed,  6 Aug 2025 14:56:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE183AC1C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492208; cv=none; b=QqwM9Xkch4yniK8aSLPcOKKuBHVNJnSTXERlMNBXIWAPHrEtiLSgaSjSmB5GHFyq6OesFN42cGkV0nHCPEQXpIuj66SuF5Jcj3rf4yB0Hc9rys6rOIBt+tfyYn0zC4JiJauKa3MPa2Mj8Bso05DgSwNxjpOdbW9Lj6MHcY8scns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492208; c=relaxed/simple;
	bh=z9N0pdW5aUSaW+CCYFmrf3qMex3EgippXieTrTkuJCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNAuYAds6ZbFt064zC0yMrrj9kAaFJkhSnwT2/GhjHXyeHV3PNRkqVmalV+ZykcniieZ8XIdC1mF//YicFVCl//36bp2q+ojmmAHdL6OnVuWS0OeNUSqG8eMaxKSyT5qwBRH8QZVBc9vEg0g48XXyyBj1oN859A6fR/rqItrve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBC72176C;
	Wed,  6 Aug 2025 07:56:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.64.125])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 532773F5A1;
	Wed,  6 Aug 2025 07:56:34 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	anshuman.khandual@arm.com,
	peterx@redhat.com,
	joey.gouly@arm.com,
	ioworker0@gmail.com,
	baohua@kernel.org,
	kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com,
	christophe.leroy@csgroup.eu,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	hughd@google.com,
	yang@os.amperecomputing.com,
	ziy@nvidia.com,
	Dev Jain <dev.jain@arm.com>,
	syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
Subject: [PATCH mm-hotfixes-unstable] mm: Pass page directly instead of using folio_page
Date: Wed,  6 Aug 2025 20:26:11 +0530
Message-Id: <20250806145611.3962-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit_anon_folio_batch(), we iterate over all pages pointed to by the
PTE batch. Therefore we need to know the first page of the batch;
currently we derive that via folio_page(folio, 0), but, that takes us
to the first (head) page of the folio instead - our PTE batch may lie
in the middle of the folio, leading to incorrectness.

Bite the bullet and throw away the micro-optimization of reusing the
folio in favour of code simplicity. Derive the page and the folio in
change_pte_range, and pass the page too to commit_anon_folio_batch to
fix the aforementioned issue.

Reported-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
Fixes: cac1db8c3aad ("mm: optimize mprotect() by PTE batching")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/mprotect.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 78bded7acf79..113b48985834 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -120,9 +120,8 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
 
 static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
 			   pte_t oldpte, pte_t *pte, int target_node,
-			   struct folio **foliop)
+			   struct folio *folio)
 {
-	struct folio *folio = NULL;
 	bool ret = true;
 	bool toptier;
 	int nid;
@@ -131,7 +130,6 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
 	if (pte_protnone(oldpte))
 		goto skip;
 
-	folio = vm_normal_folio(vma, addr, oldpte);
 	if (!folio)
 		goto skip;
 
@@ -173,7 +171,6 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
 		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
 
 skip:
-	*foliop = folio;
 	return ret;
 }
 
@@ -231,10 +228,9 @@ static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
  * retrieve sub-batches.
  */
 static void commit_anon_folio_batch(struct vm_area_struct *vma,
-		struct folio *folio, unsigned long addr, pte_t *ptep,
+		struct folio *folio, struct page *first_page, unsigned long addr, pte_t *ptep,
 		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
 {
-	struct page *first_page = folio_page(folio, 0);
 	bool expected_anon_exclusive;
 	int sub_batch_idx = 0;
 	int len;
@@ -251,7 +247,7 @@ static void commit_anon_folio_batch(struct vm_area_struct *vma,
 }
 
 static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
-		struct folio *folio, unsigned long addr, pte_t *ptep,
+		struct folio *folio, struct page *page, unsigned long addr, pte_t *ptep,
 		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
 {
 	bool set_write;
@@ -270,7 +266,7 @@ static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
 				       /* idx = */ 0, set_write, tlb);
 		return;
 	}
-	commit_anon_folio_batch(vma, folio, addr, ptep, oldpte, ptent, nr_ptes, tlb);
+	commit_anon_folio_batch(vma, folio, page, addr, ptep, oldpte, ptent, nr_ptes, tlb);
 }
 
 static long change_pte_range(struct mmu_gather *tlb,
@@ -305,15 +301,19 @@ static long change_pte_range(struct mmu_gather *tlb,
 			const fpb_t flags = FPB_RESPECT_SOFT_DIRTY | FPB_RESPECT_WRITE;
 			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
 			struct folio *folio = NULL;
+			struct page *page;
 			pte_t ptent;
 
+			page = vm_normal_page(vma, addr, oldpte);
+			if (page)
+				folio = page_folio(page);
 			/*
 			 * Avoid trapping faults against the zero or KSM
 			 * pages. See similar comment in change_huge_pmd.
 			 */
 			if (prot_numa) {
 				int ret = prot_numa_skip(vma, addr, oldpte, pte,
-							 target_node, &folio);
+							 target_node, folio);
 				if (ret) {
 
 					/* determine batch to skip */
@@ -323,9 +323,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				}
 			}
 
-			if (!folio)
-				folio = vm_normal_folio(vma, addr, oldpte);
-
 			nr_ptes = mprotect_folio_pte_batch(folio, pte, oldpte, max_nr_ptes, flags);
 
 			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
@@ -351,7 +348,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 			 */
 			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
 			     !pte_write(ptent))
-				set_write_prot_commit_flush_ptes(vma, folio,
+				set_write_prot_commit_flush_ptes(vma, folio, page,
 				addr, pte, oldpte, ptent, nr_ptes, tlb);
 			else
 				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
-- 
2.30.2


