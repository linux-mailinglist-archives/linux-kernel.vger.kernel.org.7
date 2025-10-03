Return-Path: <linux-kernel+bounces-841217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA041BB6869
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6752D19C0A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B202E9ED7;
	Fri,  3 Oct 2025 11:17:34 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B51DE3A4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759490253; cv=none; b=u1vJVtdu/Bd2sT4DhOlMUAjrtuSVSSl2xYbL+S/wXvdjBskGhETc5D0TclQYMBfw08P33TfWQ+jjRX2zXaHJOR+VRRDxi3lwxorguhVpoIkS/ltQVWLmGG6vz/T/EOaGMN1UYsupzAcF30KpmjmAAMaHmR8mX0w1hTowutF+nrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759490253; c=relaxed/simple;
	bh=/XzvN7/boXACsNJte88z9nldbbkjIa6USsH9Gb+tjVM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rl55+S640hk598L0KNjb2qQ4Zc1FcLUxzCU+EIg+B9rXex1U5hVMICK2P3EUsSf7ESw8jcxx4+CGZ6E+LxsomWGv9SX0H09I1OZS7dsj+1SSsfclf9jY5vJsCSpjJe92F4JOSenO6qzK4o8tN+U33OGyDjokTyy/EqOV12AXL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdR0D40Xtz6L4wn;
	Fri,  3 Oct 2025 19:15:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2747F14038F;
	Fri,  3 Oct 2025 19:17:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 12:17:25 +0100
Date: Fri, 3 Oct 2025 12:17:24 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <sj@kernel.org>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <byungchul@sk.com>, <kinseyho@google.com>,
	<joshua.hahnjy@gmail.com>, <yuanchu@google.com>, <balbirs@nvidia.com>,
	<alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 3/8] mm: Hot page tracking and promotion
Message-ID: <20251003121724.00002e6b@huawei.com>
In-Reply-To: <20250910144653.212066-4-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<20250910144653.212066-4-bharata@amd.com>
Reply-To: <mgorman@techsingularity.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 10 Sep 2025 20:16:48 +0530
Bharata B Rao <bharata@amd.com> wrote:

> This introduces a sub-system for collecting memory access
> information from different sources. It maintains the hotness
> information based on the access history and time of access.
> 
> Additionally, it provides per-lowertier-node kernel threads
> (named kpromoted) that periodically promote the pages that
> are eligible for promotion.
> 
> Sub-systems that generate hot page access info can report that
> using this API:
> 
> int pghot_record_access(u64 pfn, int nid, int src,
> 			unsigned long time)
> 
> @pfn: The PFN of the memory accessed
> @nid: The accessing NUMA node ID
> @src: The temperature source (sub-system) that generated the
>       access info
> @time: The access time in jiffies
> 
> Some temperature sources may not provide the nid from which
> the page was accessed. This is true for sources that use
> page table scanning for PTE Accessed bit. For such sources,
> the default toptier node to which such pages should be promoted
> is hard coded.
> 
> Also, the access time provided some sources may at best be
> considered approximate. This is especially true for hot pages
> detected by PTE A bit scanning.
> 
> The hot PFN records are stored in hash lists hashed by PFN value.
> The PFN records that are categorized as hot enough to be promoted
> are maintained in a per-lowertier-node max heap from which
> kpromoted extracts and promotes them.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

A fairly superficial review only of this. At some point I'll aim to take a closer
look at the heap bit.


> ---
>  include/linux/mmzone.h        |  11 +
>  include/linux/pghot.h         |  96 +++++++
>  include/linux/vm_event_item.h |   9 +
>  mm/Kconfig                    |  11 +
>  mm/Makefile                   |   1 +
>  mm/mm_init.c                  |  10 +
>  mm/pghot.c                    | 524 ++++++++++++++++++++++++++++++++++
>  mm/vmstat.c                   |   9 +
>  8 files changed, 671 insertions(+)
>  create mode 100644 include/linux/pghot.h
>  create mode 100644 mm/pghot.c
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0c5da9141983..f7094babed10 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h

> diff --git a/include/linux/pghot.h b/include/linux/pghot.h
> new file mode 100644
> index 000000000000..1443643aab13
> --- /dev/null
> +++ b/include/linux/pghot.h

> +
> +struct pghot_info {
> +	unsigned long pfn;
> +
> +	/*
> +	 * The following three fundamental parameters
> +	 * required to track the hotness of page/PFN are
> +	 * packed within a single u32.
> +	 */
> +	u32 frequency:PGHOT_FREQ_BITS; /* Number of accesses within current window */
> +	u32 nid:PGHOT_NID_BITS; /* Most recent access from this node */
> +	u32 last_update:PGHOT_TIME_BITS; /* Most recent access time */

Add spaces around : I think to help the eye parse those.

> +
> +	struct hlist_node hnode;
> +	size_t heap_idx; /* Position in max heap for quick retreival */
> +};
> +
> +struct max_heap {
> +	size_t nr;
> +	size_t size;
> +	struct pghot_info **data;
> +	DECLARE_FLEX_ARRAY(struct pghot_info *, preallocated);

That macro is all about use in unions rather than generally being needed.
Do you need that here rather than
	struct pg_hot_info *preallocated[];

Can you add a __counted_by() marking?


> +};


> diff --git a/mm/pghot.c b/mm/pghot.c
> new file mode 100644
> index 000000000000..9f7581818b8f
> --- /dev/null
> +++ b/mm/pghot.c
> @@ -0,0 +1,524 @@

> +
> +static struct folio *kpromoted_isolate_folio(struct pghot_info *phi)
> +{
> +	struct page *page = pfn_to_page(phi->pfn);
> +	struct folio *folio;
> +
> +	if (!page)
> +		return NULL;
> +
> +	folio = page_folio(page);
> +	if (migrate_misplaced_folio_prepare(folio, NULL, phi->nid))
> +		return NULL;
> +	else

else not needed.

> +		return folio;
> +}

> +static int phi_heap_extract(pg_data_t *pgdat, int batch_count, int freq_th,
> +			    struct list_head *migrate_list, int *count)
> +{
> +	spinlock_t *phi_heap_lock = &pgdat->heap_lock;
> +	struct max_heap *phi_heap = &pgdat->heap;
> +	int max_retries = 10;
> +	int bkt, i = 0;
> +
> +	if (batch_count < 0 || !migrate_list || !count || freq_th < 1 ||
> +	    freq_th > KPROMOTED_FREQ_THRESHOLD)
> +		return -EINVAL;
> +
> +	*count = 0;
> +	for (i = 0; i < batch_count; i++) {
> +		struct pghot_info *top = NULL;
> +		bool should_continue = false;
> +		struct folio *folio;
> +		int retries = 0;
> +
> +		while (retries < max_retries) {
> +			spin_lock(phi_heap_lock);
> +			if (phi_heap->nr > 0 && phi_heap->data[0]->frequency >= freq_th) {
> +				should_continue = true;
> +				bkt = hash_min(phi_heap->data[0]->pfn, phi_hash_order);
> +				top = phi_heap->data[0];
> +			}
> +			spin_unlock(phi_heap_lock);
> +
> +			if (!should_continue)
> +				goto done;
> +
> +			spin_lock(&phi_hash[bkt].lock);
> +			spin_lock(phi_heap_lock);
> +			if (phi_heap->nr == 0 || phi_heap->data[0] != top ||
> +			    phi_heap->data[0]->frequency < freq_th) {
> +				spin_unlock(phi_heap_lock);
> +				spin_unlock(&phi_hash[bkt].lock);
> +				retries++;
> +				continue;
> +			}
> +
> +			top = phi_heap->data[0];
> +			hlist_del_init(&top->hnode);
> +
> +			phi_heap->nr--;
> +			if (phi_heap->nr > 0) {
> +				phi_heap->data[0] = phi_heap->data[phi_heap->nr];
> +				phi_heap->data[0]->heap_idx = 0;
> +				min_heap_sift_down(phi_heap, 0, &phi_heap_cb,
> +						   phi_heap->data);
> +			}
> +
> +			spin_unlock(phi_heap_lock);
> +			spin_unlock(&phi_hash[bkt].lock);
> +
> +			if (!phi_is_pfn_hot(top)) {
> +				count_vm_event(KPROMOTED_DROPPED);
> +				goto skip;
> +			}
> +
> +			folio = kpromoted_isolate_folio(top);
> +			if (folio) {
> +				list_add(&folio->lru, migrate_list);
> +				(*count)++;
> +			}
> +skip:
> +			phi_free(top);
> +			break;
> +		}
> +		if (retries >= max_retries) {
> +			pr_warn("%s: Too many retries\n", __func__);
> +			break;
> +		}
> +
> +	}
> +done:
If that is all there is, I'd use an early return as tends to give
simpler code.

> +	return 0;
> +}
> +
> +static void phi_heap_add_or_adjust(struct pghot_info *phi)
> +{
> +	pg_data_t *pgdat = NODE_DATA(phi->nid);
> +	struct max_heap *phi_heap = &pgdat->heap;
> +
> +	spin_lock(&pgdat->heap_lock);

guard() perhaps.

> +	if (phi->heap_idx >= 0 && phi->heap_idx < phi_heap->nr &&
> +	    phi_heap->data[phi->heap_idx] == phi) {
> +		/* Entry exists in heap */
> +		if (phi->frequency < KPROMOTED_FREQ_THRESHOLD) {
> +			/* Below threshold, remove from the heap */
> +			phi_heap->nr--;
> +			if (phi->heap_idx < phi_heap->nr) {
> +				phi_heap->data[phi->heap_idx] =
> +					phi_heap->data[phi_heap->nr];
> +				phi_heap->data[phi->heap_idx]->heap_idx =
> +					phi->heap_idx;
> +				min_heap_sift_down(phi_heap, phi->heap_idx,
> +						   &phi_heap_cb, phi_heap->data);
> +			}
> +			phi->heap_idx = -1;
> +
> +		} else {
> +			/* Update position in heap */
> +			phi_heap_update_entry(phi_heap, phi);
> +		}
> +	} else if (phi->frequency >= KPROMOTED_FREQ_THRESHOLD) {
> +		/*
> +		 * Add to the heap. If heap is full we will have
> +		 * to wait for the next access reporting to elevate
> +		 * it to heap.
> +		 */
> +		if (phi_heap_insert(phi_heap, phi))
> +			count_vm_event(PGHOT_RECORDS_HEAP);
> +	}
> +	spin_unlock(&pgdat->heap_lock);
> +}

> +
> +/*
> + * Called by subsystems that generate page hotness/access information.
> + *
> + *  @pfn: The PFN of the memory accessed
> + *  @nid: The accessing NUMA node ID
> + *  @src: The temperature source (sub-system) that generated the
> + *        access info
> + *  @time: The access time in jiffies
> + *
> + * Maintains the access records per PFN, classifies them as
> + * hot based on subsequent accesses and finally hands over
> + * them to kpromoted for migration.
> + */
> +int pghot_record_access(u64 pfn, int nid, int src, unsigned long now)
> +{
> +	struct pghot_info *phi;
> +	struct page *page;
> +	struct folio *folio;
> +	int bkt;
> +	bool new_entry = false, new_window = false;
> +	u32 cur_time = now & PGHOT_TIME_MASK;
> +
> +	if (!kpromoted_started)
> +		return -EINVAL;
> +
> +	if (nid >= PGHOT_NID_MAX)
> +		return -EINVAL;
> +
> +	count_vm_event(PGHOT_RECORDED_ACCESSES);
> +
> +	switch (src) {
> +	case PGHOT_HW_HINTS:
> +		count_vm_event(PGHOT_RECORD_HWHINTS);
> +		break;
> +	case PGHOT_PGTABLE_SCAN:
> +		count_vm_event(PGHOT_RECORD_PGTSCANS);
> +		break;
> +	case PGHOT_HINT_FAULT:
> +		count_vm_event(PGHOT_RECORD_HINTFAULTS);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Record only accesses from lower tiers.
> +	 */
> +	if (node_is_toptier(pfn_to_nid(pfn)))
> +		return 0;
> +
> +	/*
> +	 * Reject the non-migratable pages right away.
> +	 */
> +	page = pfn_to_online_page(pfn);
> +	if (!page || is_zone_device_page(page))
> +		return 0;
> +
> +	folio = page_folio(page);
> +	if (!folio_test_lru(folio))
> +		return 0;
> +
> +	bkt = hash_min(pfn, phi_hash_order);
> +	spin_lock(&phi_hash[bkt].lock);

If this doesn't get more complex later, use guard() and early returns on error.

> +	phi = phi_lookup(pfn, bkt);
> +	if (!phi) {
> +		phi = phi_alloc(pfn);
> +		if (!phi)
> +			goto out;

Not an error?  Add a comment on why not perhaps.

> +		new_entry = true;
> +	}
> +
> +	/*
> +	 * If the previous access was beyond the threshold window
> +	 * start frequency tracking afresh.
> +	 */
> +	if (((cur_time - phi->last_update) > msecs_to_jiffies(sysctl_pghot_freq_window)) ||
> +	    (nid != NUMA_NO_NODE && phi->nid != nid))
> +		new_window = true;
> +
> +	if (new_entry || new_window) {
> +		/* New window */
> +		phi->frequency = 1; /* TODO: Factor in the history */
> +	} else if (phi->frequency < PGHOT_FREQ_MAX)
> +		phi->frequency++;
> +	phi->last_update = cur_time;
> +	phi->nid = (nid == NUMA_NO_NODE) ? KPROMOTED_DEFAULT_NODE : nid;
> +
> +	if (new_entry) {
> +		/* Insert the new entry into hash table */
> +		hlist_add_head(&phi->hnode, &phi_hash[bkt].hash);
> +		count_vm_event(PGHOT_RECORDS_HASH);
> +	} else {
> +		/* Add/update the position in heap */
> +		phi_heap_add_or_adjust(phi);
> +	}
> +out:
> +	spin_unlock(&phi_hash[bkt].lock);
> +	return 0;
> +}
> +
> +/*
> + * Extract the hot page records and batch-migrate the
> + * hot pages.

Wrap comments to 80 chars.

> + */
> +static void kpromoted_migrate(pg_data_t *pgdat)
> +{
> +	int count, ret;
> +	LIST_HEAD(migrate_list);
> +
> +	/*
> +	 * Extract the top N elements from the heap that match
> +	 * the requested hotness threshold.
> +	 *
> +	 * PFNs ineligible from migration standpoint are removed
> +	 * from the heap and hash.
> +	 *
> +	 * Folios eligible for migration are isolated and returned
> +	 * in @migrate_list.
> +	 */
> +	ret = phi_heap_extract(pgdat, KPROMOTED_MIGRATE_BATCH,
> +			       KPROMOTED_FREQ_THRESHOLD, &migrate_list, &count);
> +	if (ret)
> +		return;
> +
> +	if (!list_empty(&migrate_list))
> +		migrate_misplaced_folios_batch(&migrate_list, pgdat->node_id);
> +}
> +
> +static int kpromoted(void *p)
> +{
> +	pg_data_t *pgdat = (pg_data_t *)p;

Cast not needed.
	pg_data_t *pgdat = p;


> +
> +	while (!kthread_should_stop()) {
> +		wait_event_timeout(pgdat->kpromoted_wait, false,
> +				   msecs_to_jiffies(KPROMOTE_DELAY));
> +		kpromoted_migrate(pgdat);
> +	}
> +	return 0;
> +}
> +
> +static int kpromoted_run(int nid)
> +{
> +	pg_data_t *pgdat = NODE_DATA(nid);
> +	int ret = 0;
> +
> +	if (!node_is_toptier(nid))
> +		return 0;
> +
> +	if (!pgdat->phi_buf) {
> +		pgdat->phi_buf = vzalloc_node(phi_heap_entries * sizeof(struct pghot_info *),
> +					      nid);

I'd use sizeof(*pgdat->phi_buf) here to avoid need to check types match when reading the
code.  Sadly there isn't a vcalloc_node().

> +		if (!pgdat->phi_buf)
> +			return -ENOMEM;
> +
> +		min_heap_init(&pgdat->heap, pgdat->phi_buf, phi_heap_entries);
> +		spin_lock_init(&pgdat->heap_lock);
> +	}
> +
> +	if (!pgdat->kpromoted)
> +		pgdat->kpromoted = kthread_create_on_node(kpromoted, pgdat, nid,
> +							  "kpromoted%d", nid);
> +	if (IS_ERR(pgdat->kpromoted)) {
> +		ret = PTR_ERR(pgdat->kpromoted);
> +		pgdat->kpromoted = NULL;
> +		pr_info("Failed to start kpromoted%d, ret %d\n", nid, ret);

Unless there is going to be more in later patches that prevents it. Just
return here.

> +	} else {
> +		wake_up_process(pgdat->kpromoted);
> +	}
> +	return ret;

return 0; //after change suggested above.

> +}
> +
> +/*
> + * TODO: Handle cleanup during node offline.
> + */
> +static int __init pghot_init(void)
> +{
> +	unsigned int hash_size;
> +	size_t hash_entries;
> +	size_t nr_pages = 0;
> +	pg_data_t *pgdat;
> +	int i, nid, ret;
> +
> +	/*
> +	 * Arrive at the hash and heap sizes based on the
> +	 * number of pages present in the lower tier nodes.

Trivial: Wrap closer to 80 chars.

> +	 */
> +	for_each_node_state(nid, N_MEMORY) {
> +		if (!node_is_toptier(nid))
> +			nr_pages += NODE_DATA(nid)->node_present_pages;
> +	}
> +
> +	if (!nr_pages)
> +		return 0;
> +
> +	hash_entries = nr_pages * PGHOT_HASH_PCT / 100;
> +	hash_size = hash_entries / PGHOT_HASH_ENTRIES;
> +	phi_hash_order = ilog2(hash_size);
> +
> +	phi_hash = vmalloc(sizeof(struct pghot_hash) * hash_size);

Prefer sizeof(*phy_hash) so I don't need to check types match :)

vcalloc() probably appropriate here.



> +	if (!phi_hash) {
> +		ret = -ENOMEM;
> +		goto out;

Out label isn't clearly an 'error' which is a little confusing.

> +	}
> +
> +	for (i = 0; i < hash_size; i++) {
> +		INIT_HLIST_HEAD(&phi_hash[i].hash);
> +		spin_lock_init(&phi_hash[i].lock);
> +	}
> +
> +	phi_cache = KMEM_CACHE(pghot_info, 0);
> +	if (unlikely(!phi_cache)) {
> +		ret = -ENOMEM;
> +		goto out;
Whilst not strictly necessary I'd add multiple labels so only things
that have been allocated are free rather than relying on them being
NULL otherwise.  Whilst not a correctness thing it makes it slightly
easier to check tear down paths are correct.

> +	}
> +
> +	phi_heap_entries = hash_entries * PGHOT_HEAP_PCT / 100;
> +	for_each_node_state(nid, N_CPU) {
> +		ret = kpromoted_run(nid);
> +		if (ret)
> +			goto out_stop_kthread;
> +	}
> +
> +	register_sysctl_init("vm", pghot_sysctls);
> +	kpromoted_started = true;
> +	pr_info("pghot: Started page hotness monitoring and promotion thread\n");
> +	pr_info("pghot: nr_pages %ld hash_size %d hash_entries %ld hash_order %d heap_entries %d\n",
> +	       nr_pages, hash_size, hash_entries, phi_hash_order, phi_heap_entries);
> +	return 0;
> +
> +out_stop_kthread:
> +	for_each_node_state(nid, N_CPU) {
> +		pgdat = NODE_DATA(nid);
> +		if (pgdat->kpromoted) {
> +			kthread_stop(pgdat->kpromoted);
> +			pgdat->kpromoted = NULL;
> +			vfree(pgdat->phi_buf);
> +		}
> +	}
> +out:
> +	kmem_cache_destroy(phi_cache);
> +	vfree(phi_hash);
> +	return ret;
> +}
> +
> +late_initcall(pghot_init)



