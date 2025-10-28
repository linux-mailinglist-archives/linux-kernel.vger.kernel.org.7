Return-Path: <linux-kernel+bounces-873423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B98C13E69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358E3427B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F5176FB1;
	Tue, 28 Oct 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpPocVys"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D733221271
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644686; cv=none; b=Im5S/NY5o1tr44NTAXfUUChDkCE2JZtuz9a3m9GBCKpyOWcWy7EMtxF2d4yWKucwgF5cIdZLjQId/1pQdP48StPHBf3alOv+pU4J8czkTwEbVpiU2K4PPfMDpXAFAM70i3NreXh7nJLEwUmpw+2Gof/wYwN6VIW459vQGWyojNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644686; c=relaxed/simple;
	bh=RghSDheitize4H0A3IMvvWtvFfStvRPYUUBkFy5ZAgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GM5aZdi44AtUeQfZR8HKelbVVFF2X0gNwQaeBl419MU260f9yQ4ahFX5AqwdHyhC1+FkvC3jyZWX3wRvuRDOht0pdPWTLguFAm3PQZhAvYjT93SD2mp8nsnMrVq6Xh6Gn1TJBVvIvgyBw/hwHVZOc7LEyraCEPZXSqZHkAZtxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpPocVys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761644683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YxcMaptV7eoYdZlbqSoVlIYopnhiS0mwWTyE9BWm+8I=;
	b=IpPocVysy3Mg/kkxnC09ewGsnGfxIDGN3poPNriYHxuMxlAPqEbaEHQKH70Cib9aUJpX4R
	8IZUaqK/Je8ExTCDKsGDSp8NZKCuo9pWapYe7H7RYDnhQnBMr7MKnECcVmCWMeOPiAmcjD
	QNB+mcD7SxxYpEqeBNtjBg7oQrRAoJo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-knBtv7spNOe-det2nBva4A-1; Tue, 28 Oct 2025 05:44:41 -0400
X-MC-Unique: knBtv7spNOe-det2nBva4A-1
X-Mimecast-MFC-AGG-ID: knBtv7spNOe-det2nBva4A_1761644680
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47717c2737bso2410635e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644680; x=1762249480;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxcMaptV7eoYdZlbqSoVlIYopnhiS0mwWTyE9BWm+8I=;
        b=eOZXh5SrfAiAigumuWjZSUco+BP78LlavD/dNqfccWEpmZt5O8leKtiYPHoIVlpQfD
         amQ2mwKMkX9Ngblsns+pr/6OAX8iIBueet0RBvo2CtQ2CE1oYOZUkdXRkThkdhFNLukk
         a+7z6af4VYL/G3TqBhllvBfCKJ3xv3uTW4JR2QhPlnl8VHzd6W+YmjYr/8nHh7JYSd3W
         97sHkMvWwz2MQ1g6dYNOWtyKIVQZyYGhGkY2dr2jF5VvYaD4zW1+1enubnjRSLSTUaMn
         V/cR2k4srr7PtCRO+FNcUpwzkU7X3cScNdH08bpOKbyWC/XBzqMjkcGMy7vb+3lFhyfN
         henw==
X-Forwarded-Encrypted: i=1; AJvYcCVOARt/ifvLOmQTQP/20K7dd09k1/i6SYYZVlCjX6YgGXMGdgZEAPlVh6oYv0zxdlq2cpxd52JQVZzbm7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbfO1FpsuA7Qu+rz0zjRgHgTbdQggAzRoDkCMBqqot5DNDput
	GuInltCbcn1/mQo4raBM4x6LrmwAIsm5rgS5s6eU3EKJsBx8JHFLaKcZrp/yeDvnipLyAMNde9J
	/zr5rF2FRlZ5OPJd3Hu8BLFaXnEyeuQ517XQ7j1/q9puQWjCHj1AOnE9lT8jJvdUFhw==
X-Gm-Gg: ASbGncvYkkef022j0FabqgMB/HUgqAFUJeGkS4zE6omug1LSTxp4cIAaBZRFEpyQd9T
	9bAxoYaQiC4TlIQWLICuFNZxWB9jgiFrYFAo9mNUyxlaRtdzNNBiQrCNPASbbfa2R3gOfniUiv7
	xjk+E2xWk5Q0UCwVHdUMvbWge6z+ynWc4cMWQsYw2S6LLwbpwWC5L5lA/7ID2c4MJ0kLCoINh9Z
	ZWF1J1TXAI3kpwkHyy2H+PhetKDjQ5uoK5LjNiiWGw9AWGPdbVnrIa/EY3izJ5NxLgzI6dK3f8E
	xZSWoWhmbvpLWAywnnCOpGtLpj1S9vUAEPKTE85ys/QZ2pv0WAuh6tDlSLNAXMur7pMANN+RkbV
	dIz8wIbA60BQ54FXpwnDJqXcyzxneSXAX
X-Received: by 2002:a05:600c:548a:b0:46f:b43a:aef2 with SMTP id 5b1f17b1804b1-47717e7f4cfmr19256685e9.38.1761644680096;
        Tue, 28 Oct 2025 02:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA0vSYLtxoOKqxkOZY7xYgAXRBusIt+EB6OwH5I1UUbtzv3C7HHhyCrwUYbutjJaFFl6AwZw==
X-Received: by 2002:a05:600c:548a:b0:46f:b43a:aef2 with SMTP id 5b1f17b1804b1-47717e7f4cfmr19256445e9.38.1761644679593;
        Tue, 28 Oct 2025 02:44:39 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca979sm19799481f8f.14.2025.10.28.02.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:44:38 -0700 (PDT)
Message-ID: <a675d644-38d0-43d7-be42-8bc3753c74ee@redhat.com>
Date: Tue, 28 Oct 2025 10:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Longlong Xia <xialonglong2025@163.com>, linmiaohe@huawei.com,
 lance.yang@linux.dev
Cc: markus.elfring@web.de, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, qiuxu.zhuo@intel.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <20251016101813.484565-2-xialonglong2025@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251016101813.484565-2-xialonglong2025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.25 12:18, Longlong Xia wrote:
> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> When a hardware memory error occurs on a KSM page, the current
> behavior is to kill all processes mapping that page. This can
> be overly aggressive when KSM has multiple duplicate pages in
> a chain where other duplicates are still healthy.
> 
> This patch introduces a recovery mechanism that attempts to
> migrate mappings from the failing KSM page to a newly
> allocated KSM page or another healthy duplicate already
> present in the same chain, before falling back to the
> process-killing procedure.
> 
> The recovery process works as follows:
> 1. Identify if the failing KSM page belongs to a stable node chain.
> 2. Locate a healthy duplicate KSM page within the same chain.
> 3. For each process mapping the failing page:
>     a. Attempt to allocate a new KSM page copy from healthy duplicate
>        KSM page. If successful, migrate the mapping to this new KSM page.
>     b. If allocation fails, migrate the mapping to the existing healthy
>        duplicate KSM page.
> 4. If all migrations succeed, remove the failing KSM page from the chain.
> 5. Only if recovery fails (e.g., no healthy duplicate found or migration
>     error) does the kernel fall back to killing the affected processes.
> 
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
>   mm/ksm.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 246 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..9099bad1ab35 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3084,6 +3084,246 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
>   }
>   
>   #ifdef CONFIG_MEMORY_FAILURE
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
> +					struct ksm_stable_node,
> +					node);

Put that into a single line for readability, please.

You can also consider factoring out this inner loop in a helper function.

> +
> +			if (!is_stable_node_chain(stable_node))
> +				continue;
> +
> +			hlist_for_each_entry(dup, &stable_node->hlist,
> +					hlist_dup) {

Single line, or properly indent.

> +				if (dup == dup_node)
> +					return stable_node;
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct folio *find_healthy_folio(struct ksm_stable_node *chain_head,
> +		struct ksm_stable_node *failing_node,
> +		struct ksm_stable_node **healthy_dupdup)
> +{
> +	struct ksm_stable_node *dup;
> +	struct hlist_node *hlist_safe;
> +	struct folio *healthy_folio;
> +
> +	if (!is_stable_node_chain(chain_head) || !is_stable_node_dup(failing_node))
> +		return NULL;
> +
> +	hlist_for_each_entry_safe(dup, hlist_safe, &chain_head->hlist, hlist_dup) {
> +		if (dup == failing_node)
> +			continue;
> +
> +		healthy_folio = ksm_get_folio(dup, KSM_GET_FOLIO_TRYLOCK);
> +		if (healthy_folio) {
> +			*healthy_dupdup = dup;
> +			return healthy_folio;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct page *create_new_stable_node_dup(struct ksm_stable_node *chain_head,
> +		struct folio *healthy_folio,
> +		struct ksm_stable_node **new_stable_node)
> +{
> +	int nid;
> +	unsigned long kpfn;
> +	struct page *new_page = NULL;
> +
> +	if (!is_stable_node_chain(chain_head))
> +		return NULL;
> +
> +	new_page = alloc_page(GFP_HIGHUSER_MOVABLE | __GFP_ZERO);
> +	if (!new_page)
> +		return NULL;
> +
> +	copy_highpage(new_page, folio_page(healthy_folio, 0));
> +
> +	*new_stable_node = alloc_stable_node();
> +	if (!*new_stable_node) {
> +		__free_page(new_page);
> +		return NULL;
> +	}
> +
> +	INIT_HLIST_HEAD(&(*new_stable_node)->hlist);
> +	kpfn = page_to_pfn(new_page);
> +	(*new_stable_node)->kpfn = kpfn;
> +	nid = get_kpfn_nid(kpfn);
> +	DO_NUMA((*new_stable_node)->nid = nid);
> +	(*new_stable_node)->rmap_hlist_len = 0;
> +
> +	(*new_stable_node)->head = STABLE_NODE_DUP_HEAD;
> +	hlist_add_head(&(*new_stable_node)->hlist_dup, &chain_head->hlist);
> +	ksm_stable_node_dups++;
> +	folio_set_stable_node(page_folio(new_page), *new_stable_node);
> +	folio_add_lru(page_folio(new_page));

There seems to be a lot of copy-paste. For example, why no reuse 
stable_node_chain_add_dup()?

Or why not try to reuse stable_tree_insert() in the first place?

Try to reuse or factor out instead of copy-pasting, please.

> +
> +	return new_page;
> +}
> +
> +static int replace_failing_page(struct vm_area_struct *vma, struct page *page,
> +		struct page *kpage, unsigned long addr)
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
> +			addr + PAGE_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +
> +	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +	if (!ptep)
> +		goto out_mn;
> +
> +	folio_get(kfolio);
> +	folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE);
> +	newpte = mk_pte(kpage, vma->vm_page_prot);
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

This is a lot of copy-paste from replace_page(). Isn't there a way to 
avoid this duplication by unifying both functions in some way?

> +
> +static void migrate_to_target_dup(struct ksm_stable_node *failing_node,
> +		struct folio *failing_folio,
> +		struct folio *target_folio,
> +		struct ksm_stable_node *target_dup)
> +{
> +	struct ksm_rmap_item *rmap_item;
> +	struct hlist_node *hlist_safe;
> +	int err;
> +
> +	hlist_for_each_entry_safe(rmap_item, hlist_safe, &failing_node->hlist, hlist) {
> +		struct mm_struct *mm = rmap_item->mm;
> +		unsigned long addr = rmap_item->address & PAGE_MASK;

Can be const.

> +		struct vm_area_struct *vma;
> +
> +		if (!mmap_read_trylock(mm))
> +			continue;
> +
> +		if (ksm_test_exit(mm)) {
> +			mmap_read_unlock(mm);
> +			continue;
> +		}
> +
> +		vma = vma_lookup(mm, addr);
> +		if (!vma) {
> +			mmap_read_unlock(mm);
> +			continue;
> +		}
> +
> +		if (!folio_trylock(target_folio)) {

Can't we leave the target folio locked the whole time? The caller 
already locked it, why not keep it locked until we're done?

> +			mmap_read_unlock(mm);
> +			continue;
> +		}
> +
> +		err = replace_failing_page(vma, &failing_folio->page,
> +				folio_page(target_folio, 0), addr);
> +		if (!err) {
> +			hlist_del(&rmap_item->hlist);
> +			rmap_item->head = target_dup;
> +			hlist_add_head(&rmap_item->hlist, &target_dup->hlist);
> +			target_dup->rmap_hlist_len++;
> +			failing_node->rmap_hlist_len--;
> +		}
> +
> +		folio_unlock(target_folio);
> +		mmap_read_unlock(mm);
> +	}
> +
> +}
> +
> +static bool ksm_recover_within_chain(struct ksm_stable_node *failing_node)
> +{
> +	struct folio *failing_folio = NULL;
> +	struct ksm_stable_node *healthy_dupdup = NULL;
> +	struct folio *healthy_folio = NULL;
> +	struct ksm_stable_node *chain_head = NULL;
> +	struct page *new_page = NULL;
> +	struct ksm_stable_node *new_stable_node = NULL;

Only initialize what needs initialization (nothing in here?) and combine 
where possible.

Like

	struct folio *failing_folio, *healthy_folio;


> +
> +	if (!is_stable_node_dup(failing_node))
> +		return false;
> +
> +	guard(mutex)(&ksm_thread_mutex);
> +	failing_folio = ksm_get_folio(failing_node, KSM_GET_FOLIO_NOLOCK);
> +	if (!failing_folio)
> +		return false;
> +
> +	chain_head = find_chain_head(failing_node);
> +	if (!chain_head)
> +		return NULL;
> +
> +	healthy_folio = find_healthy_folio(chain_head, failing_node, &healthy_dupdup);
> +	if (!healthy_folio) {
> +		folio_put(failing_folio);
> +		return false;
> +	}
> +
> +	new_page = create_new_stable_node_dup(chain_head, healthy_folio, &new_stable_node);

Why are you returning a page here and not a folio?


-- 
Cheers

David / dhildenb


