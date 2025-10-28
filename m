Return-Path: <linux-kernel+bounces-873219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91EFC1365B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09101A27968
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4982C3244;
	Tue, 28 Oct 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FG4TqO9O"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BA2C11CB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638155; cv=none; b=hY7pbPlcEtdmAjqkhwB54qfDi3j6crv56QbWSsKo4dApijdqVJ2jGVpUKKIuNAp++Am233LXsVuajjnITS5rTVTcndfyF2jxe/Wd/eMaHTifq3pE5gmMO0MH4sUpcPV3X/zTsjgW0whVkG9k058Oy9y3lvaLc4Ygzzdtlm/wiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638155; c=relaxed/simple;
	bh=sN+OBxlyKMvmshtN6p6R5xi/r2TrBemC2o1UvnEAMzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tglT5tzM7Q+qKZAGmn1BPr1NKpVMmsTfmIChpc8hTOW2Q/jE6IfJMVinUdBjptQUaQBXgviRZOn7kNFHPEuyxJK1copjLHDByXLnqWIbSgZK9zhQdiswuz92wLzbNnXCWuStec5MqDjs/d7LgJhUUsVGf8JEIGf+IOUM80HK5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FG4TqO9O; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=RvDfdfVwPI3rmFbI6RAyNTD6PKhxg4VhIHjaKX4vR7o=;
	b=FG4TqO9Oza6WsPF/ug+8/UY2MoPvbGBiHUI0uyaYLAI7wscqwecL153tU0uiI/
	Qsd+6oOjZLuyN/vI6T9/2zcEXP3mZY667kvlPgDhajq7ya2vEGVYbWW7TjCUHwso
	3vqF//xiTYzgGDUv2Im0SogKIcKZg8toLJ5Ml0SIk40/c=
Received: from [IPV6:240e:46d:1600:3a33:4534:428:f0d0:76ae] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXHfXGdgBpUeIwDQ--.19073S2;
	Tue, 28 Oct 2025 15:54:48 +0800 (CST)
Message-ID: <7c069611-21e1-40df-bdb1-a3144c54507e@163.com>
Date: Tue, 28 Oct 2025 15:54:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: markus.elfring@web.de, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, qiuxu.zhuo@intel.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, david@redhat.com, lance.yang@linux.dev
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <20251016101813.484565-2-xialonglong2025@163.com>
 <af769443-e855-81d0-a44a-d5890f5d1d2f@huawei.com>
From: Long long Xia <xialonglong2025@163.com>
In-Reply-To: <af769443-e855-81d0-a44a-d5890f5d1d2f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXHfXGdgBpUeIwDQ--.19073S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFy8uw1kXF4ftry3uF47CFg_yoW3KF45pF
	y0krZ0krW8Jry8Wr1Iqw409rySqw4ktr4UtFyfCa1Ik3Z0vrZ2gFW8W3y7GFyrAF4UGa1F
	vF4jqrnxGws5trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxl1kUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbBgBn0+GkAdUIh0gAAs4

Thanks for the reply.

在 2025/10/23 19:54, Miaohe Lin 写道:
> On 2025/10/16 18:18, Longlong Xia wrote:
>> From: Longlong Xia <xialonglong@kylinos.cn>
>>
>> When a hardware memory error occurs on a KSM page, the current
>> behavior is to kill all processes mapping that page. This can
>> be overly aggressive when KSM has multiple duplicate pages in
>> a chain where other duplicates are still healthy.
>>
>> This patch introduces a recovery mechanism that attempts to
>> migrate mappings from the failing KSM page to a newly
>> allocated KSM page or another healthy duplicate already
>> present in the same chain, before falling back to the
>> process-killing procedure.
>>
>> The recovery process works as follows:
>> 1. Identify if the failing KSM page belongs to a stable node chain.
>> 2. Locate a healthy duplicate KSM page within the same chain.
>> 3. For each process mapping the failing page:
>>     a. Attempt to allocate a new KSM page copy from healthy duplicate
>>        KSM page. If successful, migrate the mapping to this new KSM page.
>>     b. If allocation fails, migrate the mapping to the existing healthy
>>        duplicate KSM page.
>> 4. If all migrations succeed, remove the failing KSM page from the chain.
>> 5. Only if recovery fails (e.g., no healthy duplicate found or migration
>>     error) does the kernel fall back to killing the affected processes.
>>
>> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> Thanks for your patch. Some comments below.
>
>> ---
>>   mm/ksm.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 246 insertions(+)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 160787bb121c..9099bad1ab35 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -3084,6 +3084,246 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
>>   }
>>   
>>   #ifdef CONFIG_MEMORY_FAILURE
>> +static struct ksm_stable_node *find_chain_head(struct ksm_stable_node *dup_node)
>> +{
>> +	struct ksm_stable_node *stable_node, *dup;
>> +	struct rb_node *node;
>> +	int nid;
>> +
>> +	if (!is_stable_node_dup(dup_node))
>> +		return NULL;
>> +
>> +	for (nid = 0; nid < ksm_nr_node_ids; nid++) {
>> +		node = rb_first(root_stable_tree + nid);
>> +		for (; node; node = rb_next(node)) {
>> +			stable_node = rb_entry(node,
>> +					struct ksm_stable_node,
>> +					node);
>> +
>> +			if (!is_stable_node_chain(stable_node))
>> +				continue;
>> +
>> +			hlist_for_each_entry(dup, &stable_node->hlist,
>> +					hlist_dup) {
>> +				if (dup == dup_node)
>> +					return stable_node;
>> +			}
>> +		}
>> +	}
> Would above multiple loops take a long time in some corner cases?

Thanks for the concern.

I do some simple test。

Test 1: 10 Virtual Machines (Real-world Scenario)
Environment: 10 VMs (256MB each) with KSM enabled

KSM State:
pages_sharing: 262,802 (≈1GB)
pages_shared: 17,374 （≈68MB）
pages_unshared = 124,057 (≈485MB)
total ≈1.5GB
chain_count = 9, not_chain_count = 17152
Red-black tree nodes to traverse:
17,161 (9 chains + 17,152 non-chains)

Performance:
find_chain: 898 μs (0.9 ms)
collect_procs_ksm: 4,409 μs (4.4 ms)
Total memory failure handling: 6,135 μs (6.1 ms)


Test 2: 10GB Single Process (Extreme Case)
Environment: Single process with 10GB memory,
1,310,720 page pairs (each pair identical, different from others)

KSM State:
pages_sharing: 1,311,740 （≈5GB)
pages_shared: 1,310,724 （≈5GB)
pages_unshared = 0
total ≈10GB
Red-black tree nodes to traverse:
1,310,721 (1 chain + 1,310,720 non-chains)

Performance:
find_chain: 28,822 μs (28.8 ms)
collect_procs_ksm: 45,944 μs (45.9 ms)
Total memory failure handling: 46,594 μs (46.6 ms)

Summary:
The find_chain function shows approximately linear scaling with the 
number of red-black tree nodes.
With a 76x increase in nodes (17,161 → 1,310,721), latency increased by 
32x (898 μs → 28,822 μs).
representing 62% of total memory failure handling time (46.6ms).
However, since memory failures are rare events, this latency may be 
acceptable
as it does not impact normal system performance and only affects error 
recovery paths.


>> +
>> +	return NULL;
>> +}
>> +
>> +static struct folio *find_healthy_folio(struct ksm_stable_node *chain_head,
>> +		struct ksm_stable_node *failing_node,
>> +		struct ksm_stable_node **healthy_dupdup)
>> +{
>> +	struct ksm_stable_node *dup;
>> +	struct hlist_node *hlist_safe;
>> +	struct folio *healthy_folio;
>> +
>> +	if (!is_stable_node_chain(chain_head) || !is_stable_node_dup(failing_node))
>> +		return NULL;
>> +
>> +	hlist_for_each_entry_safe(dup, hlist_safe, &chain_head->hlist, hlist_dup) {
>> +		if (dup == failing_node)
>> +			continue;
>> +
>> +		healthy_folio = ksm_get_folio(dup, KSM_GET_FOLIO_TRYLOCK);
>> +		if (healthy_folio) {
>> +			*healthy_dupdup = dup;
>> +			return healthy_folio;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct page *create_new_stable_node_dup(struct ksm_stable_node *chain_head,
>> +		struct folio *healthy_folio,
>> +		struct ksm_stable_node **new_stable_node)
>> +{
>> +	int nid;
>> +	unsigned long kpfn;
>> +	struct page *new_page = NULL;
>> +
>> +	if (!is_stable_node_chain(chain_head))
>> +		return NULL;
>> +
>> +	new_page = alloc_page(GFP_HIGHUSER_MOVABLE | __GFP_ZERO);
> Why __GFP_ZERO is needed?
Thanks for pointing this out. I'll remove it.

>> +	if (!new_page)
>> +		return NULL;
>> +
>> +	copy_highpage(new_page, folio_page(healthy_folio, 0));
>> +
>> +	*new_stable_node = alloc_stable_node();
>> +	if (!*new_stable_node) {
>> +		__free_page(new_page);
>> +		return NULL;
>> +	}
>> +
>> +	INIT_HLIST_HEAD(&(*new_stable_node)->hlist);
>> +	kpfn = page_to_pfn(new_page);
>> +	(*new_stable_node)->kpfn = kpfn;
>> +	nid = get_kpfn_nid(kpfn);
>> +	DO_NUMA((*new_stable_node)->nid = nid);
>> +	(*new_stable_node)->rmap_hlist_len = 0;
>> +
>> +	(*new_stable_node)->head = STABLE_NODE_DUP_HEAD;
>> +	hlist_add_head(&(*new_stable_node)->hlist_dup, &chain_head->hlist);
>> +	ksm_stable_node_dups++;
>> +	folio_set_stable_node(page_folio(new_page), *new_stable_node);
>> +	folio_add_lru(page_folio(new_page));
>> +
>> +	return new_page;
>> +}
>> +
> ...
>
>> +
>> +static void migrate_to_target_dup(struct ksm_stable_node *failing_node,
>> +		struct folio *failing_folio,
>> +		struct folio *target_folio,
>> +		struct ksm_stable_node *target_dup)
>> +{
>> +	struct ksm_rmap_item *rmap_item;
>> +	struct hlist_node *hlist_safe;
>> +	int err;
>> +
>> +	hlist_for_each_entry_safe(rmap_item, hlist_safe, &failing_node->hlist, hlist) {
>> +		struct mm_struct *mm = rmap_item->mm;
>> +		unsigned long addr = rmap_item->address & PAGE_MASK;
>> +		struct vm_area_struct *vma;
>> +
>> +		if (!mmap_read_trylock(mm))
>> +			continue;
>> +
>> +		if (ksm_test_exit(mm)) {
>> +			mmap_read_unlock(mm);
>> +			continue;
>> +		}
>> +
>> +		vma = vma_lookup(mm, addr);
>> +		if (!vma) {
>> +			mmap_read_unlock(mm);
>> +			continue;
>> +		}
>> +
>> +		if (!folio_trylock(target_folio)) {
> Should we try to get the folio refcnt first?

Thanks for pointing this out. I'll fix it.

>> +			mmap_read_unlock(mm);
>> +			continue;
>> +		}
>> +
>> +		err = replace_failing_page(vma, &failing_folio->page,
>> +				folio_page(target_folio, 0), addr);
>> +		if (!err) {
>> +			hlist_del(&rmap_item->hlist);
>> +			rmap_item->head = target_dup;
>> +			hlist_add_head(&rmap_item->hlist, &target_dup->hlist);
>> +			target_dup->rmap_hlist_len++;
>> +			failing_node->rmap_hlist_len--;
>> +		}
>> +
>> +		folio_unlock(target_folio);
>> +		mmap_read_unlock(mm);
>> +	}
>> +
>> +}
>> +
>> +static bool ksm_recover_within_chain(struct ksm_stable_node *failing_node)
>> +{
>> +	struct folio *failing_folio = NULL;
>> +	struct ksm_stable_node *healthy_dupdup = NULL;
>> +	struct folio *healthy_folio = NULL;
>> +	struct ksm_stable_node *chain_head = NULL;
>> +	struct page *new_page = NULL;
>> +	struct ksm_stable_node *new_stable_node = NULL;
>> +
>> +	if (!is_stable_node_dup(failing_node))
>> +		return false;
>> +
>> +	guard(mutex)(&ksm_thread_mutex);
>> +	failing_folio = ksm_get_folio(failing_node, KSM_GET_FOLIO_NOLOCK);
>> +	if (!failing_folio)
>> +		return false;
>> +
>> +	chain_head = find_chain_head(failing_node);
>> +	if (!chain_head)
>> +		return NULL;
> Should we folio_put(failing_folio) before return?

Thanks for pointing this out. I'll fix it.

> Thanks.
> .
Best regards,
Longlong Xia




