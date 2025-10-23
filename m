Return-Path: <linux-kernel+bounces-866914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ACBC01091
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53FA6561959
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742A30FC3A;
	Thu, 23 Oct 2025 12:11:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993830F947
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221485; cv=none; b=j3U0y6AOECwP8jWpSUdpHAq6hTWV/5XESFS6fPJUZzsz+OBmSdqjnO3f5oc9XHOm6tQ2zRqEGp6ZkAOwFJwXp835YR/6pus6cUGQnkEAdWIUmBNw+Iq9P+1JZgGrsRblmiiJS3qeatzDJ4cfwSKYBNRuPX7N2/Upmi3DsWMQtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221485; c=relaxed/simple;
	bh=XezOgbQ+srumUHA4kLIdNcspHnKjgxXWSYFMXq/DO3Y=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PPPIBQZmOY+CyQLZTMXviXxgsN9bafrt3YP0008YZbEoV4zYc1C7vW9FxMg5KLzqlBknA1/o9+czMhZPXm270iuLTWoPd8mdwLsXkYRN71hLHqdyRI5PRSngGbKD/iugPbuAwdXn/Hxw98bEv6CwPuG3j+ClP20RgE/3gWr/qUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cskq62wcKz2CgpS;
	Thu, 23 Oct 2025 19:49:54 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 31E2E14011B;
	Thu, 23 Oct 2025 19:54:46 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 19:54:45 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 19:54:45 +0800
Subject: Re: [PATCH v2 1/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Longlong Xia <xialonglong2025@163.com>
CC: <markus.elfring@web.de>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
	<qiuxu.zhuo@intel.com>, <xu.xin16@zte.com.cn>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Longlong Xia
	<xialonglong@kylinos.cn>, <david@redhat.com>, <lance.yang@linux.dev>
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <20251016101813.484565-2-xialonglong2025@163.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <af769443-e855-81d0-a44a-d5890f5d1d2f@huawei.com>
Date: Thu, 23 Oct 2025 19:54:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251016101813.484565-2-xialonglong2025@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/16 18:18, Longlong Xia wrote:
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
>    a. Attempt to allocate a new KSM page copy from healthy duplicate
>       KSM page. If successful, migrate the mapping to this new KSM page.
>    b. If allocation fails, migrate the mapping to the existing healthy
>       duplicate KSM page.
> 4. If all migrations succeed, remove the failing KSM page from the chain.
> 5. Only if recovery fails (e.g., no healthy duplicate found or migration
>    error) does the kernel fall back to killing the affected processes.
> 
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Thanks for your patch. Some comments below.

> ---
>  mm/ksm.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 246 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..9099bad1ab35 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3084,6 +3084,246 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
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
> +					struct ksm_stable_node,
> +					node);
> +
> +			if (!is_stable_node_chain(stable_node))
> +				continue;
> +
> +			hlist_for_each_entry(dup, &stable_node->hlist,
> +					hlist_dup) {
> +				if (dup == dup_node)
> +					return stable_node;
> +			}
> +		}
> +	}

Would above multiple loops take a long time in some corner cases?

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

Why __GFP_ZERO is needed?

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
> +
> +	return new_page;
> +}
> +

...

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

Should we try to get the folio refcnt first?

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

Should we folio_put(failing_folio) before return?

Thanks.
.

