Return-Path: <linux-kernel+bounces-840316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E17BB4182
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E4421D94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6F310620;
	Thu,  2 Oct 2025 13:53:43 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B513128CD
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413223; cv=none; b=GHNIc+2GGp2nrPTHI2E2PlyGH72CiB9Dw6WcmrvR6/RVjy8nSlOdFrdmRzp4f48kCpGIHT7ijQmnWbYGgu8TruVqF6mAZ1V1ydkjSok9DnHPW9igaAVQUFV2CynuXL97QSwnz1PQ6BsO6PX4ia38ipw/dGM4adFlV0il3197PdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413223; c=relaxed/simple;
	bh=ZlaiESmNAoEop07w2xeWkUHQXpfh/zq9w9+2meGyzUg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiD2j/Cpg2MZW+CNSONdGNiFmpKm/sPCO4oakJ0oZst1v8uOh5jLKakwNsyU0R5Zx+Z/dtn7X78PndrKyu/WZvJSF30KcA5yvyQfHHG4yXhea51el5oeheQ/7JODkhJwP6z6Tjv3NJkWr2trxgJAlCvyfE8Kgs5MYcfKNG8bNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cctVx1648z6L50l;
	Thu,  2 Oct 2025 21:51:21 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3ADF11402EB;
	Thu,  2 Oct 2025 21:53:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 14:53:34 +0100
Date: Thu, 2 Oct 2025 14:53:32 +0100
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
Subject: Re: [RFC PATCH V3 03/17] mm: Scan the mm and create a migration
 list
Message-ID: <20251002145332.00003f63@huawei.com>
In-Reply-To: <20250814153307.1553061-4-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-4-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 14 Aug 2025 15:32:53 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Since we already have the list of mm_struct in the system, add a module to
> scan each mm that walks VMAs of each mm_struct and scan all the pages
> associated with that.
> 
>  In the scan path: Check for the recently acccessed pages (PFNs) belonging

Bonus space at start of line.

> to slowtier nodes. Add all those to a list.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

A few superficial comments. I'm out of time today to take a closer read
though but thought I'd send these as might not get back to this for a while.

> ---
>  mm/kscand.c | 321 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 320 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kscand.c b/mm/kscand.c
> index d5b0d3041b0f..1d883d411664 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c

> +
> +static bool kscand_eligible_srcnid(int nid)
> +{
> +	/* Only promotion case is considered */
> +	return  !node_is_toptier(nid);

one space before ! not 2.


> +}
> +
>  static inline int kscand_has_work(void)
>  {
>  	return !list_empty(&kscand_scan.mm_head);
> @@ -84,11 +122,277 @@ static void kscand_wait_work(void)
>  			scan_sleep_jiffies);
>  }
>  
> +static inline bool is_valid_folio(struct folio *folio)
> +{
> +	if (!folio || !folio_mapped(folio) || !folio_raw_mapping(folio))
> +		return false;
> +
> +	if (folio_test_unevictable(folio) || folio_is_zone_device(folio) ||
> +		folio_maybe_mapped_shared(folio))
> +		return false;
> +
> +	return true;
> +}
> +
One blank line only unless local convention matches this.
> +
> +static bool folio_idle_clear_pte_refs_one(struct folio *folio,

> +
> +static int hot_vma_idle_pte_entry(pte_t *pte,
> +				 unsigned long addr,
> +				 unsigned long next,
> +				 struct mm_walk *walk)
> +{
> +	struct page *page;
> +	struct folio *folio;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	struct kscand_migrate_info *info;
> +	struct kscand_scanctrl *scanctrl = walk->private;
> +	int srcnid;
> +
> +	scanctrl->address = addr;
> +	pte_t pteval = ptep_get(pte);

Mixing declarations and code is a bit messy.
I'd just declare pte_t pteval earlier.


> +
> +	if (!pte_present(pteval))
> +		return 0;
> +
> +	if (pte_none(pteval))
> +		return 0;
> +
> +	vma = walk->vma;
> +	mm = vma->vm_mm;
> +
> +	page = pte_page(*pte);
> +
One line only here.
> +
> +	folio = page_folio(page);
> +	folio_get(folio);
> +
> +	if (!is_valid_folio(folio)) {
> +		folio_put(folio);
> +		return 0;
> +	}
> +	folio_set_idle(folio);
> +	page_idle_clear_pte_refs(page, pte, walk);
> +	srcnid = folio_nid(folio);
> +
> +

one blank line.

> +	if (!folio_test_lru(folio)) {

Maybe a goto given common code in all exit paths around here.

> +		folio_put(folio);
> +		return 0;
> +	}
> +
> +	if (!kscand_eligible_srcnid(srcnid)) {
> +		folio_put(folio);
> +		return 0;
> +	}
> +	if (!folio_test_idle(folio) &&
> +		(folio_test_young(folio) || folio_test_referenced(folio))) {

Odd looking wrapping. I'd align after ( i.e.
	if (!folio_test_idle(folio) &&
	    (folio_test_young(folio) || folio_test_referenced(folio))) {

> +
> +		/* XXX: Leaking memory. TBD: consume info */
> +
> +		info = kzalloc(sizeof(struct kscand_migrate_info), GFP_NOWAIT);
> +		if (info && scanctrl) {
> +			info->pfn = folio_pfn(folio);
> +			info->address = addr;
> +			list_add_tail(&info->migrate_node, &scanctrl->scan_list);
> +		}
> +	}
> +
> +	folio_put(folio);
> +	return 0;
> +}

> +static unsigned long kscand_scan_mm_slot(void)
> +{
> +	bool next_mm = false;
> +	bool update_mmslot_info = false;
> +
> +	unsigned long vma_scanned_size = 0;
> +	unsigned long address;
> +
> +	struct mm_slot *slot;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma = NULL;
> +	struct kscand_mm_slot *mm_slot;

Confusing to have a variable called mm_slot which isn't a struct mm_slot *
and another variable that is.

> +

One line enough.

> +
> +	spin_lock(&kscand_mm_lock);
> +
> +	if (kscand_scan.mm_slot) {
> +		mm_slot = kscand_scan.mm_slot;
> +		slot = &mm_slot->slot;
> +		address = mm_slot->address;
> +	} else {
> +		slot = list_entry(kscand_scan.mm_head.next,
> +				     struct mm_slot, mm_node);

Isn't that
		slot = list_first_entry(&kscand_scan.mm_head,
					struct mm_slot, mm_node);

Makes little difference other than pointing out it is the first entry.

> +		mm_slot = mm_slot_entry(slot, struct kscand_mm_slot, slot);
> +		address = mm_slot->address;

Could drop setting address out of the if/else given it's the same in both legs.

Alternatively treat this as a 'get the missing mm_slot' and do

	if (!kscand_scan.mm_slot) {
		struct mm_slot *next_slot =
			list_first_entry(&kscand_scan.mm_head,
					 struct mm_slot, mm_node);
		struct kscand_mm_slot *next_mm_slot = 
			mm_slot_entry(slot, struct kscand_mm_slot, slot);
		kscand_scan.mm_slot = next_mm_slot;
	}

	mm_slot = kscand_scan.mm_slot;
	slot = &mm_slot->slot;
	address = mm_slot->address;





> +		kscand_scan.mm_slot = mm_slot;
> +	}
> +
> +	mm = slot->mm;
> +	mm_slot->is_scanned = true;
> +	spin_unlock(&kscand_mm_lock);
> +
> +	if (unlikely(!mmap_read_trylock(mm)))
> +		goto outerloop_mmap_lock;
> +
> +	if (unlikely(kscand_test_exit(mm))) {

Some of these unlikelys feel like things we should leave to the branch
predictors to figure out.

> +		next_mm = true;
> +		goto outerloop;
> +	}
> +
> +	VMA_ITERATOR(vmi, mm, address);
> +
> +	for_each_vma(vmi, vma) {
> +		kscand_walk_page_vma(vma, &kscand_scanctrl);
> +		vma_scanned_size += vma->vm_end - vma->vm_start;
> +
> +		if (vma_scanned_size >= kscand_scan_size) {
> +			next_mm = true;
> +			/* TBD: Add scanned folios to migration list */
> +			break;
> +		}
> +	}
> +
> +	if (!vma)
> +		address = 0;
> +	else
> +		address = kscand_scanctrl.address + PAGE_SIZE;
> +
> +	update_mmslot_info = true;
> +
> +	if (update_mmslot_info)
> +		mm_slot->address = address;
> +
> +outerloop:
> +	/* exit_mmap will destroy ptes after this */
> +	mmap_read_unlock(mm);
> +
> +outerloop_mmap_lock:

This flow is getting a bit too complex for my liking.  Maybe factor
everything above here out given we run this in all exit paths. Then
that factored out code can do early returns etc, without the goto
nest.  Might be able to use guard() for the spin_lock as well to
allow return instead of goto in next bit.

> +	spin_lock(&kscand_mm_lock);
> +	WARN_ON(kscand_scan.mm_slot != mm_slot);
> +
> +	/*
> +	 * Release the current mm_slot if this mm is about to die, or
> +	 * if we scanned all vmas of this mm.
> +	 */
> +	if (unlikely(kscand_test_exit(mm)) || !vma || next_mm) {
> +		/*
> +		 * Make sure that if mm_users is reaching zero while
> +		 * kscand runs here, kscand_exit will find
> +		 * mm_slot not pointing to the exiting mm.
> +		 */
> +		if (slot->mm_node.next != &kscand_scan.mm_head) {
> +			slot = list_entry(slot->mm_node.next,
> +					struct mm_slot, mm_node);
> +			kscand_scan.mm_slot =
> +				mm_slot_entry(slot, struct kscand_mm_slot, slot);
> +
> +		} else
> +			kscand_scan.mm_slot = NULL;
> +
> +		if (kscand_test_exit(mm)) {
> +			kscand_collect_mm_slot(mm_slot);
> +			goto end;
> +		}
> +	}
> +	mm_slot->is_scanned = false;
> +end:
 +	spin_unlock(&kscand_mm_lock);
> +	return 0;
> +}
> +
>  static void kscand_do_scan(void)
>  {
>  	unsigned long iter = 0, mms_to_scan;
> @@ -101,7 +405,7 @@ static void kscand_do_scan(void)
>  			break;
>  
>  		if (kscand_has_work())
> -			msleep(100);
> +			kscand_scan_mm_slot();
>  
>  		iter++;
>  
> @@ -148,6 +452,7 @@ void __kscand_enter(struct mm_struct *mm)
>  	if (!kscand_slot)
>  		return;
>  
> +	kscand_slot->address = 0;
>  	slot = &kscand_slot->slot;
>  
>  	spin_lock(&kscand_mm_lock);
> @@ -175,6 +480,12 @@ void __kscand_exit(struct mm_struct *mm)
>  		hash_del(&slot->hash);
>  		list_del(&slot->mm_node);
>  		free = 1;
> +	} else if (mm_slot && kscand_scan.mm_slot == mm_slot && !mm_slot->is_scanned) {
> +		hash_del(&slot->hash);
> +		list_del(&slot->mm_node);
> +		free = 1;
> +		/* TBD: Set the actual next slot */
> +		kscand_scan.mm_slot = NULL;
>  	}
>  
>  	spin_unlock(&kscand_mm_lock);
> @@ -224,6 +535,12 @@ static int stop_kscand(void)
>  	return 0;
>  }
>  
> +static inline void init_list(void)

That's a very generic name that is likely to clash with something in future.
kscand_init_list()  Or don't bother as not a lot in here so you could just
put them inline.

> +{
> +	INIT_LIST_HEAD(&kscand_scanctrl.scan_list);
> +	init_waitqueue_head(&kscand_wait);
> +}
> +
>  static int __init kscand_init(void)
>  {
>  	int err;
> @@ -234,6 +551,8 @@ static int __init kscand_init(void)
>  		pr_err("kscand: kmem_cache error");
>  		return -ENOMEM;
>  	}
> +
> +	init_list();
>  	err = start_kscand();
>  	if (err)
>  		goto err_kscand;


