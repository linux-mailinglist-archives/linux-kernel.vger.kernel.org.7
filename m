Return-Path: <linux-kernel+bounces-841178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72EBB66B9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A04C3C8175
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54629BDB3;
	Fri,  3 Oct 2025 10:05:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53992628D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485902; cv=none; b=nwVbte7bZNuYONn0S8zw8XcQNMbaqWJYSpwUxdIfEsZ4cD0sxmyv7RyLpm/pWX6V9os4MYku7RsxfCOLeMjlahqy0cuA8Uoycd0pceDlexXJCRJdjU029eC6MnNtuFkj65IAYBjOU4RkWK1UXxuBrUHuHhZ3UHMge4gsrJ6Ei9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485902; c=relaxed/simple;
	bh=iugr4vUF3+1Hi4EiXlmMxCbg/EFeyyTicO2T2mnuM08=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpSx4BE+pg7cbfYOJFUFR6Hb7wqf5rg2NLyU12zkhBj4ST3u9fjR+wU0m5ynzlAW24ZyFe/JwudUJaaEDVokCAsJD2vKUMZAv8s3rMreyw0/wlbNIoF4swCxwyO//az2lK2T8ilghReFNRmXdIUqA6LV1rJedLi9pffp3Mw6yXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdPNZ4Ryqz6L4vM;
	Fri,  3 Oct 2025 18:02:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 14E821402F6;
	Fri,  3 Oct 2025 18:04:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 11:04:54 +0100
Date: Fri, 3 Oct 2025 11:04:53 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <bharata@amd.com>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <honggyu.kim@sk.com>,
	<hughd@google.com>, <jhubbard@nvidia.com>, <jon.grimm@amd.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <yuanchu@google.com>,
	<kinseyho@google.com>, <hdanton@sina.com>, <harry.yoo@oracle.com>
Subject: Re: [RFC PATCH V3 10/17] mm: Add a heuristic to calculate target
 node
Message-ID: <20251003110453.00007ca6@huawei.com>
In-Reply-To: <20250814153307.1553061-11-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-11-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 14 Aug 2025 15:33:00 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> One of the key challenges in PTE A bit based scanning is to find right
> target node to promote to.
> 
> Here is a simple heuristic based approach:
>  1. While scanning pages of any mm, also scan toptier pages that belong
> to that mm.
>  2. Accumulate the insight on the distribution of active pages on
> toptier nodes.
>  3. Walk all the top-tier nodes and pick the one with highest accesses.
> 
>  This method tries to consolidate application to a single node.
Nothing new in the following comment as we've discussed it before, but just
to keep everything together:

So for the pathological case of task that has moved after initial allocations
are done, this is effectively relying on conventional numa balancing ensuring
we don't keep promoting to the wrong node?

That makes me a little nervous.   I guess the proof of this will be
in mass testing though.  Maybe it works well enough - I have no idea yet!

A few comments inline

Jonathan


> 
> TBD: Create a list of preferred nodes for fallback when highest access
>  node is nearly full.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

> +/* Per memory node information used to caclulate target_node for migration */

calculate

> +struct kscand_nodeinfo {
> +	unsigned long nr_scanned;
> +	unsigned long nr_accessed;
> +	int node;
> +	bool is_toptier;
> +};
> +
>  /*
>   * Data structure passed to control scanning and also collect
I'd drop "also". The and implies that already.
>   * per memory node information

Wrap closer to 80 chars.  Also missing full stop.

>   */
>  struct kscand_scanctrl {
>  	struct list_head scan_list;
> +	struct kscand_nodeinfo *nodeinfo[MAX_NUMNODES];
>  	unsigned long address;
> +	unsigned long nr_to_scan;
>  };
>  
>  struct kscand_scanctrl kscand_scanctrl;
> @@ -218,15 +229,129 @@ static void kmigrated_wait_work(void)
>  			migrate_sleep_jiffies);
>  }
>  
> -/*
> - * Do not know what info to pass in the future to make
> - * decision on taget node. Keep it void * now.

Wrong patch review for this comment but "target"

> - */
> +static unsigned long get_slowtier_accesed(struct kscand_scanctrl *scanctrl)

accessed

> +{
> +	int node;
> +	unsigned long accessed = 0;
> +
> +	for_each_node_state(node, N_MEMORY) {
> +		if (!node_is_toptier(node) && scanctrl->nodeinfo[node])
> +			accessed += scanctrl->nodeinfo[node]->nr_accessed;
> +	}
> +	return accessed;
> +}
> +
> +static inline unsigned long get_nodeinfo_nr_accessed(struct kscand_nodeinfo *ni)
> +{
> +	return ni->nr_accessed;
> +}
> +
> +static inline void set_nodeinfo_nr_accessed(struct kscand_nodeinfo *ni, unsigned long val)
> +{
> +	ni->nr_accessed = val;
> +}
> +
> +static inline unsigned long get_nodeinfo_nr_scanned(struct kscand_nodeinfo *ni)
> +{
> +	return ni->nr_scanned;
> +}
> +
> +static inline void set_nodeinfo_nr_scanned(struct kscand_nodeinfo *ni, unsigned long val)
> +{
> +	ni->nr_scanned = val;
> +}

These helpers seems unnecessary given they are static, so we have fully visibility of the
structure where they are called anyway.

Perhaps they get more complex in later patches though (in which case ignore this comment!)

> +
> +static inline void reset_nodeinfo_nr_scanned(struct kscand_nodeinfo *ni)
> +{
> +	set_nodeinfo_nr_scanned(ni, 0);
> +}
> +
> +static inline void reset_nodeinfo(struct kscand_nodeinfo *ni)
> +{
> +	set_nodeinfo_nr_scanned(ni, 0);
> +	set_nodeinfo_nr_accessed(ni, 0);
> +}
> +
> +static void init_one_nodeinfo(struct kscand_nodeinfo *ni, int node)
> +{
> +	ni->nr_scanned = 0;
> +	ni->nr_accessed = 0;
> +	ni->node = node;
> +	ni->is_toptier = node_is_toptier(node) ? true : false;
	ni->is_toptier = node_is_toptier(node);

> +}
> +
> +static struct kscand_nodeinfo *alloc_one_nodeinfo(int node)
> +{
> +	struct kscand_nodeinfo *ni;
> +
> +	ni = kzalloc(sizeof(*ni), GFP_KERNEL);
> +
> +	if (!ni)
> +		return NULL;
> +
> +	init_one_nodeinfo(ni, node);
As only done in one place, I'd just do an inline
	*ni = (struct kscand_node_info) {
		.node = node,
		.is_toptier = node_is_toptier(node),

Can set the zeros if you think that acts as useful documentation.


	};
> +
> +	return ni;
> +}
> +
> +/* TBD: Handle errors */
> +static void init_scanctrl(struct kscand_scanctrl *scanctrl)
> +{
> +	struct kscand_nodeinfo *ni;
Trivial: I'd move this into the for_each_node scope.


> +	int node;
> +
> +	for_each_node(node) {
i.e.
		struct kscand_nodeinfo *ni = alloc_one_nodeinfo(node);

> +		ni = alloc_one_nodeinfo(node);

If this isn't going to get a lot more complex, I'd squash the alloc_one_nodeinfo()
code in here and drop the helper. Up to you though as this is a trade off in
levels of modularity vs compact code.

> +		if (!ni)
> +			WARN_ON_ONCE(ni);
> +		scanctrl->nodeinfo[node] = ni;
> +	}
> +}
> +
> +static void reset_scanctrl(struct kscand_scanctrl *scanctrl)
> +{
> +	int node;
> +
> +	for_each_node_state(node, N_MEMORY)
> +		reset_nodeinfo(scanctrl->nodeinfo[node]);
> +
> +	/* XXX: Not rellay required? */
> +	scanctrl->nr_to_scan = kscand_scan_size;
> +}
> +
> +static void free_scanctrl(struct kscand_scanctrl *scanctrl)
> +{
> +	int node;
> +
> +	for_each_node(node)
> +		kfree(scanctrl->nodeinfo[node]);
> +}
> +
>  static int kscand_get_target_node(void *data)
>  {
>  	return kscand_target_node;
>  }
>  
> +static int get_target_node(struct kscand_scanctrl *scanctrl)
> +{
> +	int node, target_node = NUMA_NO_NODE;
> +	unsigned long prev = 0;
> +
> +	for_each_node(node) {
> +		if (node_is_toptier(node) && scanctrl->nodeinfo[node]) {

Probably flip sense of one or more of the if statements just to reduce indent.

		if (!node_is_toptier(node) || !scanctrl->nodeinfo[node])
			continue;

etc.


> +			/* This creates a fallback migration node list */
> +			if (get_nodeinfo_nr_accessed(scanctrl->nodeinfo[node]) > prev) {
> +				prev = get_nodeinfo_nr_accessed(scanctrl->nodeinfo[node]);

Maybe a local variable given use in check and here.

> +				target_node = node;
> +			}
> +		}
> +	}
> +	if (target_node == NUMA_NO_NODE)
> +		target_node = kscand_get_target_node(NULL);
> +
> +	return target_node;
> +}
> +
>  extern bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  					unsigned long nr_migrate_pages);
>  
> @@ -495,6 +620,14 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
>  	page_idle_clear_pte_refs(page, pte, walk);
>  	srcnid = folio_nid(folio);
>  
> +	scanctrl->nodeinfo[srcnid]->nr_scanned++;
> +	if (scanctrl->nr_to_scan)
> +		scanctrl->nr_to_scan--;
> +
> +	if (!scanctrl->nr_to_scan) {
> +		folio_put(folio);
> +		return 1;
> +	}
>  
>  	if (!folio_test_lru(folio)) {
>  		folio_put(folio);
> @@ -502,13 +635,17 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
>  	}
>  
>  	if (!kscand_eligible_srcnid(srcnid)) {
> +		if (folio_test_young(folio) || folio_test_referenced(folio)
> +				|| pte_young(pteval)) {
Unusual wrap position.  I'd move the || to line above and align pte_young() 
after the ( on the line above.
> +			scanctrl->nodeinfo[srcnid]->nr_accessed++;
> +		}
>  		folio_put(folio);

> +	/* Either Scan 25% of scan_size or cover vma size of scan_size */
> +	kscand_scanctrl.nr_to_scan =	mm_slot_scan_size >> PAGE_SHIFT;

Trivial but I'm not sure what you are forcing alignment for here.  I'd stick
to one space after =

> +	/* Reduce actual amount of pages scanned */
> +	kscand_scanctrl.nr_to_scan =	mm_slot_scan_size >> 1;

If my eyes aren't tricking me this sets the value then immediately replaces it with
something else. Is that intent?

> +
> +	/* XXX: skip scanning to avoid duplicates until all migrations done? */
>  	kmigrated_mm_slot = kmigrated_get_mm_slot(mm, false);
>  
>  	for_each_vma(vmi, vma) {
>  		kscand_walk_page_vma(vma, &kscand_scanctrl);
>  		vma_scanned_size += vma->vm_end - vma->vm_start;
>  
> -		if (vma_scanned_size >= kscand_scan_size) {
> +		if (vma_scanned_size >= mm_slot_scan_size ||
> +					!kscand_scanctrl.nr_to_scan) {
>  			next_mm = true;
>  
>  			if (!list_empty(&kscand_scanctrl.scan_list)) {
>  				if (!kmigrated_mm_slot)
>  					kmigrated_mm_slot = kmigrated_get_mm_slot(mm, true);
> +				/* Add scanned folios to migration list */
>  				spin_lock(&kmigrated_mm_slot->migrate_lock);
> +
>  				list_splice_tail_init(&kscand_scanctrl.scan_list,
>  						&kmigrated_mm_slot->migrate_head);
>  				spin_unlock(&kmigrated_mm_slot->migrate_lock);
> +				break;
>  			}
> -			break;
> +		}
> +		if (!list_empty(&kscand_scanctrl.scan_list)) {
> +			if (!kmigrated_mm_slot)
> +				kmigrated_mm_slot = kmigrated_get_mm_slot(mm, true);
> +			spin_lock(&kmigrated_mm_slot->migrate_lock);

Use of guard() in these might be a useful readability improvement.

> +			list_splice_tail_init(&kscand_scanctrl.scan_list,
> +					&kmigrated_mm_slot->migrate_head);
> +			spin_unlock(&kmigrated_mm_slot->migrate_lock);

This code block is identical to the one just above and that breaks out to run this.
Do we need them both?  Or is there some subtle difference my eyes are jumping over?


>  		}
>  	}
>  



