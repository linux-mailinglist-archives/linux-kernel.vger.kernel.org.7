Return-Path: <linux-kernel+bounces-840459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B2BB4787
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA7C4242EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D22248F6A;
	Thu,  2 Oct 2025 16:17:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90323F431
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421835; cv=none; b=ZIEzYxWPqSU2FtIPFaG+4xWOeTjM5HS8fzz9w7yOVYMtrg93aAxadXLUhx7lKY0W/bkFc+XE0EBAtyfWdGOTAvHc2LvVz081OWIF/a4nX0NmUzBVUkssrQxmNKnCkGLgUplw0fWfbSw9/ejtW815BqzVhhAUUDBAVsuwwrjXZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421835; c=relaxed/simple;
	bh=LuklbeG+sKIlTKV+I5ZPCaCYaX8HPYNi1BiJfkwBW8s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1q85eUlYMnWapEBf6TJng2f+BqClJs2O7EIqv3Afx3j8Ew17cb4FogVU6FAdBBydDwd2cILV/YsDnqvqFcOWpGkhv9s1CrMkS0HYyThnN7uIFrQZMTyqcMHiOmUsq5a+Y7Ctc37s5hnC0aoKQGbrmvH2CP9Pa79mtZeDOorVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccxgV6Hykz6M4d6;
	Fri,  3 Oct 2025 00:13:58 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E933A1400D9;
	Fri,  3 Oct 2025 00:17:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 17:17:06 +0100
Date: Thu, 2 Oct 2025 17:17:05 +0100
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
Subject: Re: [RFC PATCH V3 06/17] mm/migration: migrate accessed folios to
 toptier node
Message-ID: <20251002171705.00007740@huawei.com>
In-Reply-To: <20250814153307.1553061-7-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-7-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 14 Aug 2025 15:32:56 +0000
On Thu, 14 Aug 2025 15:32:56 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> A per mm migration list is added and a kernel thread iterates over
> each of them.
> 
> For each recently accessed slowtier folio in the migration list:
>  - Isolate LRU pages
>  - Migrate to a regular node.
> 
> The rationale behind whole migration is to speedup the access to
> recently accessed pages.
> 
> Currently, PTE A bit scanning approach lacks the information about
> exact destination node to migrate to.
> 
> Reason:
>  PROT_NONE hint fault based scanning is done in a process context. Here
> when the fault occurs, source CPU of the fault associated the task is
> known. Time of page access is also accurate.
> With the lack of above information, migration is done to node 0 by default.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

Some superficial stuff inline.  I'm still getting my head around the overall
approach.

> diff --git a/mm/kscand.c b/mm/kscand.c
> index 55efd0a6e5ba..5cd2764114df 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c

>  static inline bool is_valid_folio(struct folio *folio)
>  {
>  	if (!folio || !folio_mapped(folio) || !folio_raw_mapping(folio))
> @@ -145,18 +272,113 @@ static inline bool is_valid_folio(struct folio *folio)
>  	return true;
>  }
>  
> -static inline void kmigrated_wait_work(void)
> +enum kscand_migration_err {
> +	KSCAND_NULL_MM = 1,
> +	KSCAND_EXITING_MM,
> +	KSCAND_INVALID_FOLIO,
> +	KSCAND_NONLRU_FOLIO,
> +	KSCAND_INELIGIBLE_SRC_NODE,
> +	KSCAND_SAME_SRC_DEST_NODE,
> +	KSCAND_PTE_NOT_PRESENT,
> +	KSCAND_PMD_NOT_PRESENT,
> +	KSCAND_NO_PTE_OFFSET_MAP_LOCK,
> +	KSCAND_NOT_HOT_PAGE,
> +	KSCAND_LRU_ISOLATION_ERR,
> +};
> +
> +

One line probably appropriate here.

> +static bool is_hot_page(struct folio *folio)
>  {
> -	const unsigned long migrate_sleep_jiffies =
> -		msecs_to_jiffies(kmigrate_sleep_ms);
> +	bool ret = false;
>  
> -	if (!migrate_sleep_jiffies)
> -		return;
> +	if (!folio_test_idle(folio))
> +		ret = folio_test_referenced(folio) || folio_test_young(folio);
>  
> -	kmigrated_sleep_expire = jiffies + migrate_sleep_jiffies;
> -	wait_event_timeout(kmigrated_wait,
> -			true,
> -			migrate_sleep_jiffies);
> +	return ret;
> +}
> +
> +static int kmigrated_promote_folio(struct kscand_migrate_info *info,
> +					struct mm_struct *mm,
> +					int destnid)
> +{
> +	unsigned long pfn;
> +	unsigned long address;
> +	struct page *page;
> +	struct folio *folio = NULL;
> +	int ret;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	spinlock_t *ptl;
> +	pmd_t pmde;
> +	int srcnid;
> +
> +	if (mm == NULL)
> +		return KSCAND_NULL_MM;
> +
> +	if (mm == READ_ONCE(kmigrated_cur_mm) &&
> +		READ_ONCE(kmigrated_clean_list)) {
> +		WARN_ON_ONCE(mm);
> +		return KSCAND_EXITING_MM;
> +	}
> +
> +	pfn = info->pfn;
> +	address = info->address;
> +	page = pfn_to_online_page(pfn);
> +
> +	if (page)
> +		folio = page_folio(page);
> +
> +	if (!page || PageTail(page) || !is_valid_folio(folio))
> +		return KSCAND_INVALID_FOLIO;
> +
> +	if (!folio_test_lru(folio))
> +		return KSCAND_NONLRU_FOLIO;
> +
> +	if (!is_hot_page(folio))
> +		return KSCAND_NOT_HOT_PAGE;
> +
> +	folio_get(folio);
> +
> +	srcnid = folio_nid(folio);
> +
> +	/* Do not try to promote pages from regular nodes */
> +	if (!kscand_eligible_srcnid(srcnid)) {
> +		folio_put(folio);
> +		return KSCAND_INELIGIBLE_SRC_NODE;
> +	}
> +
> +	/* Also happen when it is already migrated */
> +	if (srcnid == destnid) {
> +		folio_put(folio);
> +		return KSCAND_SAME_SRC_DEST_NODE;
> +	}
> +
> +	address = info->address;
> +	pmd = pmd_off(mm, address);
> +	pmde = pmdp_get(pmd);
> +
> +	if (!pmd_present(pmde)) {
> +		folio_put(folio);
> +		return KSCAND_PMD_NOT_PRESENT;
> +	}
> +
> +	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
> +	if (!pte) {
> +		folio_put(folio);
> +		WARN_ON_ONCE(!pte);
> +		return KSCAND_NO_PTE_OFFSET_MAP_LOCK;
> +	}
> +
> +	ret = kscand_migrate_misplaced_folio_prepare(folio, NULL, destnid);
> +
> +	folio_put(folio);
> +	pte_unmap_unlock(pte, ptl);
> +
> +	if (ret)
> +		return KSCAND_LRU_ISOLATION_ERR;
> +
One line enough.

> +
> +	return  migrate_misplaced_folio(folio, destnid);
extra space after return.
>  }
>  
>  static bool folio_idle_clear_pte_refs_one(struct folio *folio,
> @@ -302,6 +524,115 @@ static inline int kscand_test_exit(struct mm_struct *mm)
>  	return atomic_read(&mm->mm_users) == 0;
>  }
>  
> +struct destroy_list_work {
> +	struct list_head migrate_head;
> +	struct work_struct dwork;
> +};
> +
> +static void kmigrated_destroy_list_fn(struct work_struct *work)
> +{
> +	struct destroy_list_work *dlw;
> +	struct kscand_migrate_info *info, *tmp;
> +
> +	dlw = container_of(work, struct destroy_list_work, dwork);
> +
> +	if (!list_empty(&dlw->migrate_head)) {

Similar to below.  I'm not sure this check is worth having unless something else ends
up under it later.

> +		list_for_each_entry_safe(info, tmp, &dlw->migrate_head,	migrate_node) {
> +			list_del(&info->migrate_node);
> +			kfree(info);
> +		}
> +	}
> +
> +	kfree(dlw);
> +}
> +
> +static void kmigrated_destroy_list(struct list_head *list_head)
> +{
> +	struct destroy_list_work *destroy_list_work;
> +

One blank line

> +
> +	destroy_list_work = kmalloc(sizeof(*destroy_list_work), GFP_KERNEL);
> +	if (!destroy_list_work)
> +		return;
> +
> +	INIT_LIST_HEAD(&destroy_list_work->migrate_head);
> +	list_splice_tail_init(list_head, &destroy_list_work->migrate_head);
> +	INIT_WORK(&destroy_list_work->dwork, kmigrated_destroy_list_fn);
> +	schedule_work(&destroy_list_work->dwork);
> +}

> +
> +static void kscand_cleanup_migration_list(struct mm_struct *mm)
> +{
> +	struct kmigrated_mm_slot *mm_slot;
> +	struct mm_slot *slot;
> +
> +	mm_slot = kmigrated_get_mm_slot(mm, false);
> +
> +	slot = &mm_slot->mm_slot;
Maybe combine these with declrations.

	struct kmigrated_mm_slot *mm_slot = kmigrated_get_mm_slot(mm, false);
	struct mm_slot *slot = &mm_slot->mm_slot;

seems clear enough (assuming nothing else is added later).

> +
> +	if (mm_slot && slot && slot->mm == mm) {
> +		spin_lock(&mm_slot->migrate_lock);
> +
> +		if (!list_empty(&mm_slot->migrate_head)) {
> +			if (mm == READ_ONCE(kmigrated_cur_mm)) {
> +				/* A folio in this mm is being migrated. wait */
> +				WRITE_ONCE(kmigrated_clean_list, true);
> +			}
> +
> +			kmigrated_destroy_list(&mm_slot->migrate_head);
> +			spin_unlock(&mm_slot->migrate_lock);
> +retry:
> +			if (!spin_trylock(&mm_slot->migrate_lock)) {
> +				cpu_relax();
> +				goto retry;
> +			}
> +
> +			if (mm == READ_ONCE(kmigrated_cur_mm)) {
> +				spin_unlock(&mm_slot->migrate_lock);
> +				goto retry;
> +			}
> +		}
> +		/* Reset migrated mm_slot if it was pointing to us */
> +		if (kmigrated_daemon.mm_slot == mm_slot)
> +			kmigrated_daemon.mm_slot = NULL;
> +
> +		hash_del(&slot->hash);
> +		list_del(&slot->mm_node);
> +		mm_slot_free(kmigrated_slot_cache, mm_slot);
> +
> +		WRITE_ONCE(kmigrated_clean_list, false);
> +
> +		spin_unlock(&mm_slot->migrate_lock);
> +		}

Something odd with indent here.

> +}
> +
>  static void kscand_collect_mm_slot(struct kscand_mm_slot *mm_slot)
>  {
>  	struct mm_slot *slot = &mm_slot->slot;
> @@ -313,11 +644,77 @@ static void kscand_collect_mm_slot(struct kscand_mm_slot *mm_slot)
>  		hash_del(&slot->hash);
>  		list_del(&slot->mm_node);
>  
> +		kscand_cleanup_migration_list(mm);
> +
>  		mm_slot_free(kscand_slot_cache, mm_slot);
>  		mmdrop(mm);
>  	}
>  }
>  
> +static void kmigrated_migrate_mm(struct kmigrated_mm_slot *mm_slot)
> +{
> +	int ret = 0, dest = -1;
> +	struct mm_slot *slot;
> +	struct mm_struct *mm;
> +	struct kscand_migrate_info *info, *tmp;
> +
> +	spin_lock(&mm_slot->migrate_lock);
> +
> +	slot = &mm_slot->mm_slot;
> +	mm = slot->mm;
> +
> +	if (!list_empty(&mm_slot->migrate_head)) {

If it's empty the iterating the list will do nothing. So is this check
useful?  Maybe other code comes under this check later though.


> +		list_for_each_entry_safe(info, tmp, &mm_slot->migrate_head,
> +				migrate_node) {
> +			if (READ_ONCE(kmigrated_clean_list))
> +				goto clean_list_handled;

Currently same a break. I assume this will change later in patch, if so
ignore this comment.

> +
> +			list_del(&info->migrate_node);
> +
> +			spin_unlock(&mm_slot->migrate_lock);
> +
> +			dest = kscand_get_target_node(NULL);
> +			ret = kmigrated_promote_folio(info, mm, dest);
> +
> +			kfree(info);
> +
> +			cond_resched();
> +			spin_lock(&mm_slot->migrate_lock);
> +		}
> +	}
> +clean_list_handled:
> +	/* Reset  mm  of folio entry we are migrating */
> +	WRITE_ONCE(kmigrated_cur_mm, NULL);
> +	spin_unlock(&mm_slot->migrate_lock);
> +}


> @@ -621,6 +1040,13 @@ static int __init kscand_init(void)
>  		return -ENOMEM;
>  	}
>  
> +	kmigrated_slot_cache = KMEM_CACHE(kmigrated_mm_slot, 0);
> +

Drop this blank line to keep call + error check closely associated.

> +	if (!kmigrated_slot_cache) {
> +		pr_err("kmigrated: kmem_cache error");
> +		return -ENOMEM;
> +	}
> +
>  	init_list();
>  	err = start_kscand();
>  	if (err)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 2c88f3b33833..1f74dd5e6776 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2541,7 +2541,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
>   * Returns true if this is a safe migration target node for misplaced NUMA
>   * pages. Currently it only checks the watermarks which is crude.
>   */
> -static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
> +bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  				   unsigned long nr_migrate_pages)

Update parameter alignment as well.

>  {
>  	int z;

