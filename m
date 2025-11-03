Return-Path: <linux-kernel+bounces-883218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11537C2CCBD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A97189B8FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D31315772;
	Mon,  3 Nov 2025 15:16:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D5314D32
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183006; cv=none; b=Vm4LKDQ2couaDDRMrMy9FYlsEVGNZMlrjKzAmUK3nyLgTW5Xj1p3aQtAdvZdpnx5I++vehStjur2lzmhmf+jcOkczmUcj8SfTDknWpr7WuZYaxWmFZ06I6HAmDZT/ErvkT/78iXLZApX9fCEGPZFZrwFNbTX+BcUlPiKr6u/iDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183006; c=relaxed/simple;
	bh=AIf9MWZBjL1MrqcZ96U6JzTwKc9muNhN4FaoiQ3IdVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUGPcQ743zgiIKTv6OFAal9lu2nqRuJ3/Hl6OZ5MkFsN1IZLrrWJmLcxPq8nFPTOmfrIurqZJk0YIPGArUj9DjEf7mqk1cRzMWFrRGNDCz1wWOGRMU2HbYezmLjo8RtUT4c2Q2LDzVEY8Hm/9nFHgD4s97mpmImk8kFqdSs0DTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 155f44ceb8c811f0a38c85956e01ac42-20251103
X-CID-CACHE: Type:Local,Time:202511032251+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bdc83ded-1af2-4292-9933-bbc194ec4bc4,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:6dbaf3e990165deede37a2367159576d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|15|50,EDM:5,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 155f44ceb8c811f0a38c85956e01ac42-20251103
X-User: xialonglong@kylinos.cn
Received: from kylin-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 907537677; Mon, 03 Nov 2025 23:16:34 +0800
From: Longlong Xia <xialonglong@kylinos.cn>
To: david@redhat.com,
	linmiaohe@huawei.com
Cc: lance.yang@linux.dev,
	markus.elfring@web.de,
	nao.horiguchi@gmail.com,
	akpm@linux-foundation.org,
	wangkefeng.wang@huawei.com,
	qiuxu.zhuo@intel.com,
	xu.xin16@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH v3 1/2] mm/ksm: add helper to allocate and initialize stable node duplicates
Date: Mon,  3 Nov 2025 23:16:00 +0800
Message-ID: <20251103151601.3280700-2-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251103151601.3280700-1-xialonglong@kylinos.cn>
References: <a675d644-38d0-43d7-be42-8bc3753c74ee@redhat.com>
 <20251103151601.3280700-1-xialonglong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate the duplicated stable_node allocation and initialization
code in stable_tree_insert() into a new helper function
alloc_init_stable_node_dup().

Also refactor write_protect_page() and replace_page() to expose
address-based variants (_addr suffix). The wrappers maintain existing
behavior by calculating the address first.

This refactoring prepares for the upcoming memory error recovery
feature, which will need to:
1) Allocate and initialize stable_node duplicates
2) Operate on specific addresses without re-calculation

No functional changes.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 mm/ksm.c | 89 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 26 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 160787bb121c..13ec057667af 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1247,11 +1247,11 @@ static u32 calc_checksum(struct page *page)
 	return checksum;
 }
 
-static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
-			      pte_t *orig_pte)
+static int write_protect_page_addr(struct vm_area_struct *vma, struct folio *folio,
+				   unsigned long address, pte_t *orig_pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	int swapped;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
@@ -1261,10 +1261,10 @@ static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
 	if (WARN_ON_ONCE(folio_test_large(folio)))
 		return err;
 
-	pvmw.address = page_address_in_vma(folio, folio_page(folio, 0), vma);
-	if (pvmw.address == -EFAULT)
-		goto out;
+	if (address < vma->vm_start || address >= vma->vm_end)
+		return err;
 
+	pvmw.address = address;
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, pvmw.address,
 				pvmw.address + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1334,21 +1334,26 @@ static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
 	page_vma_mapped_walk_done(&pvmw);
 out_mn:
 	mmu_notifier_invalidate_range_end(&range);
-out:
 	return err;
 }
 
-/**
- * replace_page - replace page in vma by new ksm page
- * @vma:      vma that holds the pte pointing to page
- * @page:     the page we are replacing by kpage
- * @kpage:    the ksm page we replace page by
- * @orig_pte: the original value of the pte
- *
- * Returns 0 on success, -EFAULT on failure.
- */
-static int replace_page(struct vm_area_struct *vma, struct page *page,
-			struct page *kpage, pte_t orig_pte)
+static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
+			      pte_t *orig_pte)
+{
+	unsigned long address;
+
+	if (WARN_ON_ONCE(folio_test_large(folio)))
+		return -EFAULT;
+
+	address = page_address_in_vma(folio, folio_page(folio, 0), vma);
+	if (address == -EFAULT)
+		return -EFAULT;
+
+	return write_protect_page_addr(vma, folio, address, orig_pte);
+}
+
+static int replace_page_addr(struct vm_area_struct *vma, struct page *page,
+			     struct page *kpage, unsigned long addr, pte_t orig_pte)
 {
 	struct folio *kfolio = page_folio(kpage);
 	struct mm_struct *mm = vma->vm_mm;
@@ -1358,17 +1363,16 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	pte_t *ptep;
 	pte_t newpte;
 	spinlock_t *ptl;
-	unsigned long addr;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
 
-	addr = page_address_in_vma(folio, page, vma);
-	if (addr == -EFAULT)
+	if (addr < vma->vm_start || addr >= vma->vm_end)
 		goto out;
 
 	pmd = mm_find_pmd(mm, addr);
 	if (!pmd)
 		goto out;
+
 	/*
 	 * Some THP functions use the sequence pmdp_huge_clear_flush(), set_pmd_at()
 	 * without holding anon_vma lock for write.  So when looking for a
@@ -1441,6 +1445,29 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	return err;
 }
 
+
+/**
+ * replace_page - replace page in vma by new ksm page
+ * @vma:      vma that holds the pte pointing to page
+ * @page:     the page we are replacing by kpage
+ * @kpage:    the ksm page we replace page by
+ * @orig_pte: the original value of the pte
+ *
+ * Returns 0 on success, -EFAULT on failure.
+ */
+static int replace_page(struct vm_area_struct *vma, struct page *page,
+			struct page *kpage, pte_t orig_pte)
+{
+	unsigned long addr;
+	struct folio *folio = page_folio(page);
+
+	addr = page_address_in_vma(folio, page, vma);
+	if (addr == -EFAULT)
+		return -EFAULT;
+
+	return replace_page_addr(vma, page, kpage, addr, orig_pte);
+}
+
 /*
  * try_to_merge_one_page - take two pages and merge them into one
  * @vma: the vma that holds the pte pointing to page
@@ -2007,6 +2034,20 @@ static struct folio *stable_tree_search(struct page *page)
 	goto out;
 }
 
+static struct ksm_stable_node *alloc_init_stable_node_dup(unsigned long kpfn,
+							  int nid __maybe_unused)
+{
+	struct ksm_stable_node *stable_node = alloc_stable_node();
+
+	if (stable_node) {
+		INIT_HLIST_HEAD(&stable_node->hlist);
+		stable_node->kpfn = kpfn;
+		stable_node->rmap_hlist_len = 0;
+		DO_NUMA(stable_node->nid = nid);
+	}
+	return stable_node;
+}
+
 /*
  * stable_tree_insert - insert stable tree node pointing to new ksm page
  * into the stable tree.
@@ -2065,14 +2106,10 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 		}
 	}
 
-	stable_node_dup = alloc_stable_node();
+	stable_node_dup = alloc_init_stable_node_dup(kpfn, nid);
 	if (!stable_node_dup)
 		return NULL;
 
-	INIT_HLIST_HEAD(&stable_node_dup->hlist);
-	stable_node_dup->kpfn = kpfn;
-	stable_node_dup->rmap_hlist_len = 0;
-	DO_NUMA(stable_node_dup->nid = nid);
 	if (!need_chain) {
 		rb_link_node(&stable_node_dup->node, parent, new);
 		rb_insert_color(&stable_node_dup->node, root);
-- 
2.43.0


