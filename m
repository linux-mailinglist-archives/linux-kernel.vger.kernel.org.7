Return-Path: <linux-kernel+bounces-848970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE54BCEECA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E54034D36F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C371C5F13;
	Sat, 11 Oct 2025 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IHiwSM+r"
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600917597
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153123; cv=none; b=NC9LgjJAHLKNNGOp6DDdLnKAr5jRkBhR0NhLeL19ieEmR1hqyehb4tecQ0GNnovM/ku/deKEggZ8cj+Jd1D4+XdMg5O+MIXvmtK59Qr2ByiDz9Pd9HwuggfhM0v3YZI5VMG3YU+7QkETK7NYlMKmN93SBHKXsQshc3LwfQWtoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153123; c=relaxed/simple;
	bh=WfM2cQXofRjykYZiYmpGyBxuEiVb2OtSmZTjkYT5kgc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ouEQG6k73fnH+J9rel/KPskG3oCGrwOF+eM9Co/HZe6mAwV9/jVPH0GzeO02KSqvG/R+9nNMcKdKgyaF5m/S9eaTWtQwowR3EGUzq3mw6Mb3FZvqCEG80cuAoTWbsMnG3tRtFOc2CYWUmyck0INPVHvYpFBvPHYkjSbnEwpjc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IHiwSM+r; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1cgrLws/g/ZDDcluUo1suv7XC4LyyVazKzOg2Lmmaec=;
	b=IHiwSM+rfVffy/uqQarOd7ri7XZqbY0rLnx3v4fUehrUQYgNVqcSsEPVo7VoPmrFvvPLFLaZx
	Ku6Q5WivarotbzeMQF6McotHTUwGs1J4hJlXJtAcxchh1E7oa/DgobJPCaJ45q/kQ3LqZDYse27
	CvSx9MRX1HH/sJzzpzEB9d0=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ck89q1HxkzmV99;
	Sat, 11 Oct 2025 11:24:47 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D1CEC140338;
	Sat, 11 Oct 2025 11:25:04 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 11:25:04 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 11:25:03 +0800
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
To: Longlong Xia <xialonglong2025@163.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>,
	<wangkefeng.wang@huawei.com>, <xu.xin16@zte.com.cn>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Longlong Xia
	<xialonglong@kylinos.cn>, Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <29b87f61-7e10-449a-21fa-106b4ae3442b@huawei.com>
Date: Sat, 11 Oct 2025 11:25:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251009070045.2011920-2-xialonglong2025@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/9 15:00, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> When a hardware memory error occurs on a KSM page, the current
> behavior is to kill all processes mapping that page. This can
> be overly aggressive when KSM has multiple duplicate pages in
> a chain where other duplicates are still healthy.
> 
> This patch introduces a recovery mechanism that attempts to migrate
> mappings from the failing KSM page to another healthy KSM page within
> the same chain before resorting to killing processes.
> 
> The recovery process works as follows:
> 1. When a memory failure is detected on a KSM page, identify if the
> failing node is part of a chain (has duplicates)
> 2. Search for another healthy KSM page within the same chain
> 3. For each process mapping the failing page:
> - Update the PTE to point to the healthy KSM page
> - Migrate the rmap_item to the new stable node
> 4. If all migrations succeed, remove the failing node from the chain
> 5. Only kill processes if recovery is impossible or fails

Thanks for your patch. This looks really interesting to me and
I think this might be a significant improvement. :)

> 
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>  mm/ksm.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..590d30cfe800 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3084,6 +3084,183 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
>  }
>  
>  #ifdef CONFIG_MEMORY_FAILURE
> +static struct ksm_stable_node *find_chain_head(struct ksm_stable_node *dup_node)
> +{
> +	struct ksm_stable_node *stable_node, *dup;
> +	struct rb_node *node;
> +	int nid;
> +
> +	if (!is_stable_node_dup(dup_node))
> +		return NULL;
> +
> +	for (nid = 0; nid < ksm_nr_node_ids; nid++) {
> +		node = rb_first(root_stable_tree + nid);
> +		for (; node; node = rb_next(node)) {
> +			stable_node = rb_entry(node,
> +					       struct ksm_stable_node,
> +					       node);
> +
> +			if (!is_stable_node_chain(stable_node))
> +				continue;
> +
> +			hlist_for_each_entry(dup, &stable_node->hlist,
> +					     hlist_dup) {
> +				if (dup == dup_node)
> +					return stable_node;
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct folio *
> +find_target_folio(struct ksm_stable_node *failing_node, struct ksm_stable_node **target_dup)
> +{
> +	struct ksm_stable_node *chain_head, *dup;
> +	struct hlist_node *hlist_safe;
> +	struct folio *target_folio;
> +
> +	if (!is_stable_node_dup(failing_node))
> +		return NULL;
> +
> +	chain_head = find_chain_head(failing_node);
> +	if (!chain_head)
> +		return NULL;
> +
> +	hlist_for_each_entry_safe(dup, hlist_safe, &chain_head->hlist, hlist_dup) {
> +		if (dup == failing_node)
> +			continue;
> +
> +		target_folio = ksm_get_folio(dup, KSM_GET_FOLIO_TRYLOCK);
> +		if (target_folio) {
> +			*target_dup = dup;
> +			return target_folio;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int replace_failing_page(struct vm_area_struct *vma, struct page *page,
> +			struct page *kpage, unsigned long addr)
> +{
> +	struct folio *kfolio = page_folio(kpage);
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct folio *folio = page_folio(page);
> +	pmd_t *pmd;
> +	pte_t *ptep;
> +	pte_t newpte;
> +	spinlock_t *ptl;
> +	int err = -EFAULT;
> +	struct mmu_notifier_range range;
> +
> +	pmd = mm_find_pmd(mm, addr);
> +	if (!pmd)
> +		goto out;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
> +				addr + PAGE_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +
> +	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +	if (!ptep)
> +		goto out_mn;
> +
> +	if (!is_zero_pfn(page_to_pfn(kpage))) {
> +		folio_get(kfolio);
> +		folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE);
> +		newpte = mk_pte(kpage, vma->vm_page_prot);
> +	} else {
> +		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
> +		ksm_map_zero_page(mm);
> +		dec_mm_counter(mm, MM_ANONPAGES);
> +	}
> +
> +	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
> +	ptep_clear_flush(vma, addr, ptep);
> +	set_pte_at(mm, addr, ptep, newpte);
> +
> +	folio_remove_rmap_pte(folio, page, vma);
> +	if (!folio_mapped(folio))
> +		folio_free_swap(folio);
> +	folio_put(folio);
> +
> +	pte_unmap_unlock(ptep, ptl);
> +	err = 0;
> +out_mn:
> +	mmu_notifier_invalidate_range_end(&range);
> +out:
> +	return err;
> +}
> +
> +static bool ksm_recover_within_chain(struct ksm_stable_node *failing_node)
> +{
> +	struct ksm_rmap_item *rmap_item;
> +	struct hlist_node *hlist_safe;
> +	struct folio *failing_folio = NULL;
> +	struct folio *target_folio = NULL;
> +	struct ksm_stable_node *target_dup = NULL;
> +	int err;
> +
> +	if (!is_stable_node_dup(failing_node))
> +		return false;
> +
> +	failing_folio = ksm_get_folio(failing_node, KSM_GET_FOLIO_NOLOCK);
> +	if (!failing_folio)
> +		return false;
> +
> +	target_folio = find_target_folio(failing_node, &target_dup);
> +	if (!target_folio) {
> +		folio_put(failing_folio);
> +		return false;
> +	}
> +
> +	hlist_for_each_entry_safe(rmap_item, hlist_safe, &failing_node->hlist, hlist) {
> +		struct mm_struct *mm = rmap_item->mm;
> +		unsigned long addr = rmap_item->address & PAGE_MASK;
> +		struct vm_area_struct *vma;
> +
> +		mmap_read_lock(mm);

I briefly looked at the code and find lock order might be broken here.
mm/filemap.c documents the lock order as below:

 *  ->mmap_lock
 *    ->invalidate_lock		(filemap_fault)
 *      ->lock_page		(filemap_fault, access_process_vm)
 *

But mmap_lock is held after folio is locked here. Is this a problem?

Thanks.
.

