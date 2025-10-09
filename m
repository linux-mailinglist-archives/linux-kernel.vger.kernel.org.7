Return-Path: <linux-kernel+bounces-846334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE126BC79A1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFE704F5B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C712C0F97;
	Thu,  9 Oct 2025 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B0BPfyJp"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6D1B423B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993306; cv=none; b=W6+ME+m8MY9NhmxuyE+aEBkaWcFb3HbX0TizXaZu8ixyd6x4hL6BrLgfHZDtgoL/YTunq1v+9FP6ybkwbGxYXcPIu1wiEBdp3ztHjPip43hnaghpKNd3Lltlj41OFUv9wrmNArK8kzsoI7OB92g7UDaZ4iBfOEU0Tlr8wYTxplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993306; c=relaxed/simple;
	bh=ZRXgy8VcP2tkHRBmkltnShygh9xtjfvnZeuIizh+lL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXu66EyGQijHU/tFT7pKFnBsI4ur2MVOUk7NJcN2WL1gQv5TF5HF5UpKUQY/x1AvzkOmD9+4fWBOBiw248RVHK4W585JujrueVmfXvK6hz7IAk8pR8wIjegfOeSaaBfOrQECig8azF6ZvpbFrEtr+h+/6i2IoV+9AjPQI3iZVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B0BPfyJp; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6N
	VwQNPurC1JbCrgHJgbE/7etOjmRopqYYw6BDynSEE=; b=B0BPfyJpezjQgAer1i
	O0ox7bG5oR4rW3jbigNoEIvY96rhXzDwn9koNCFd8ow8upXHyHDfRRbM+ulLOM4g
	XC7QmxtUugzLWfv1qxVTGi35A/ZnF67DP3hVOTBi8/2SJE0iygqW/aIo56xcI06Q
	R8KjFh9q7ebOCM3RRmVO08dt8=
Received: from XLL-9950X.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAnV+CjXedocoQYBg--.7355S3;
	Thu, 09 Oct 2025 15:00:53 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: linmiaohe@huawei.com,
	nao.horiguchi@gmail.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	xu.xin16@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory failures
Date: Thu,  9 Oct 2025 15:00:45 +0800
Message-ID: <20251009070045.2011920-2-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009070045.2011920-1-xialonglong2025@163.com>
References: <20251009070045.2011920-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAnV+CjXedocoQYBg--.7355S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4kuF4xZF1xCr48Cr48JFb_yoWxXryxpa
	y5K3s0krWkJryIgr1xtay0kryFg34kWw4UJFWfCanak3WYqrWvgFW8Xay7JFy5Jr48Ga9a
	gF4DKF1UWF4rtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07beOJ5UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbBgAjh+GjnWsxDdAAAs-

From: Longlong Xia <xialonglong@kylinos.cn>

When a hardware memory error occurs on a KSM page, the current
behavior is to kill all processes mapping that page. This can
be overly aggressive when KSM has multiple duplicate pages in
a chain where other duplicates are still healthy.

This patch introduces a recovery mechanism that attempts to migrate
mappings from the failing KSM page to another healthy KSM page within
the same chain before resorting to killing processes.

The recovery process works as follows:
1. When a memory failure is detected on a KSM page, identify if the
failing node is part of a chain (has duplicates)
2. Search for another healthy KSM page within the same chain
3. For each process mapping the failing page:
- Update the PTE to point to the healthy KSM page
- Migrate the rmap_item to the new stable node
4. If all migrations succeed, remove the failing node from the chain
5. Only kill processes if recovery is impossible or fails

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 mm/ksm.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 160787bb121c..590d30cfe800 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3084,6 +3084,183 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 }
 
 #ifdef CONFIG_MEMORY_FAILURE
+static struct ksm_stable_node *find_chain_head(struct ksm_stable_node *dup_node)
+{
+	struct ksm_stable_node *stable_node, *dup;
+	struct rb_node *node;
+	int nid;
+
+	if (!is_stable_node_dup(dup_node))
+		return NULL;
+
+	for (nid = 0; nid < ksm_nr_node_ids; nid++) {
+		node = rb_first(root_stable_tree + nid);
+		for (; node; node = rb_next(node)) {
+			stable_node = rb_entry(node,
+					       struct ksm_stable_node,
+					       node);
+
+			if (!is_stable_node_chain(stable_node))
+				continue;
+
+			hlist_for_each_entry(dup, &stable_node->hlist,
+					     hlist_dup) {
+				if (dup == dup_node)
+					return stable_node;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static struct folio *
+find_target_folio(struct ksm_stable_node *failing_node, struct ksm_stable_node **target_dup)
+{
+	struct ksm_stable_node *chain_head, *dup;
+	struct hlist_node *hlist_safe;
+	struct folio *target_folio;
+
+	if (!is_stable_node_dup(failing_node))
+		return NULL;
+
+	chain_head = find_chain_head(failing_node);
+	if (!chain_head)
+		return NULL;
+
+	hlist_for_each_entry_safe(dup, hlist_safe, &chain_head->hlist, hlist_dup) {
+		if (dup == failing_node)
+			continue;
+
+		target_folio = ksm_get_folio(dup, KSM_GET_FOLIO_TRYLOCK);
+		if (target_folio) {
+			*target_dup = dup;
+			return target_folio;
+		}
+	}
+
+	return NULL;
+}
+
+static int replace_failing_page(struct vm_area_struct *vma, struct page *page,
+			struct page *kpage, unsigned long addr)
+{
+	struct folio *kfolio = page_folio(kpage);
+	struct mm_struct *mm = vma->vm_mm;
+	struct folio *folio = page_folio(page);
+	pmd_t *pmd;
+	pte_t *ptep;
+	pte_t newpte;
+	spinlock_t *ptl;
+	int err = -EFAULT;
+	struct mmu_notifier_range range;
+
+	pmd = mm_find_pmd(mm, addr);
+	if (!pmd)
+		goto out;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
+				addr + PAGE_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!ptep)
+		goto out_mn;
+
+	if (!is_zero_pfn(page_to_pfn(kpage))) {
+		folio_get(kfolio);
+		folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE);
+		newpte = mk_pte(kpage, vma->vm_page_prot);
+	} else {
+		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
+		ksm_map_zero_page(mm);
+		dec_mm_counter(mm, MM_ANONPAGES);
+	}
+
+	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
+	ptep_clear_flush(vma, addr, ptep);
+	set_pte_at(mm, addr, ptep, newpte);
+
+	folio_remove_rmap_pte(folio, page, vma);
+	if (!folio_mapped(folio))
+		folio_free_swap(folio);
+	folio_put(folio);
+
+	pte_unmap_unlock(ptep, ptl);
+	err = 0;
+out_mn:
+	mmu_notifier_invalidate_range_end(&range);
+out:
+	return err;
+}
+
+static bool ksm_recover_within_chain(struct ksm_stable_node *failing_node)
+{
+	struct ksm_rmap_item *rmap_item;
+	struct hlist_node *hlist_safe;
+	struct folio *failing_folio = NULL;
+	struct folio *target_folio = NULL;
+	struct ksm_stable_node *target_dup = NULL;
+	int err;
+
+	if (!is_stable_node_dup(failing_node))
+		return false;
+
+	failing_folio = ksm_get_folio(failing_node, KSM_GET_FOLIO_NOLOCK);
+	if (!failing_folio)
+		return false;
+
+	target_folio = find_target_folio(failing_node, &target_dup);
+	if (!target_folio) {
+		folio_put(failing_folio);
+		return false;
+	}
+
+	hlist_for_each_entry_safe(rmap_item, hlist_safe, &failing_node->hlist, hlist) {
+		struct mm_struct *mm = rmap_item->mm;
+		unsigned long addr = rmap_item->address & PAGE_MASK;
+		struct vm_area_struct *vma;
+
+		mmap_read_lock(mm);
+		if (ksm_test_exit(mm)) {
+			mmap_read_unlock(mm);
+			continue;
+		}
+
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
+			mmap_read_unlock(mm);
+			continue;
+		}
+
+		/* Update PTE to point to target_folio's page */
+		err = replace_failing_page(vma, &failing_folio->page,
+					     &target_folio->page, addr);
+		if (!err) {
+			hlist_del(&rmap_item->hlist);
+			rmap_item->head = target_dup;
+			hlist_add_head(&rmap_item->hlist, &target_dup->hlist);
+			target_dup->rmap_hlist_len++;
+			failing_node->rmap_hlist_len--;
+
+		}
+
+		mmap_read_unlock(mm);
+	}
+
+	folio_unlock(target_folio);
+	folio_put(target_folio);
+	folio_put(failing_folio);
+
+	if (failing_node->rmap_hlist_len == 0) {
+		__stable_node_dup_del(failing_node);
+		free_stable_node(failing_node);
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Collect processes when the error hit an ksm page.
  */
@@ -3098,6 +3275,12 @@ void collect_procs_ksm(const struct folio *folio, const struct page *page,
 	stable_node = folio_stable_node(folio);
 	if (!stable_node)
 		return;
+
+	if (ksm_recover_within_chain(stable_node)) {
+		pr_debug("recovery within chain successful, no need to kill processes\n");
+		return;
+	}
+
 	hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
 		struct anon_vma *av = rmap_item->anon_vma;
 
-- 
2.43.0


