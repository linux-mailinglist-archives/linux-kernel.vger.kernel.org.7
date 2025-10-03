Return-Path: <linux-kernel+bounces-841183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB92BB66E3
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38D384E41F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FB2E7BD9;
	Fri,  3 Oct 2025 10:10:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC21E9B1C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759486242; cv=none; b=jJft5jf2udgn5qGUtn8qdyIUITdMO1zjpt3P1hU5MZOojGQeEHRm2nhnDhMqvE1QGZbIQmhc+fVyfg8GCC9SIlzYS9HNvFCNcq6tzM9RYj7wXFxu9GDrNyylfbV4hIkCxw3i/hdu7dX6Y6hGBuvZFgMkllhXxhYk7Fwi9nomybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759486242; c=relaxed/simple;
	bh=3rkZMlqYnBFQ29rqy6sq9aT2bYuyz+AuiOovvYU1zWU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BORZG3FXsCFH9IYMjttvATqQ0PIYvhmOpa0otS7fLPTfzNCsQw0/S7xOB7u7p6oKNjiT/MwZdAYLBouLuhkruUWZQUovq6v3KiqoebMQ9xWdEXXQWFLRmAgg4AD5dqmpBsVPWiFrhPZMCmk74T5UpxUQWNMruP0RY9ZXxNSO7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdPYK6YGHz67bVD;
	Fri,  3 Oct 2025 18:10:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 256911400D9;
	Fri,  3 Oct 2025 18:10:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 11:10:34 +0100
Date: Fri, 3 Oct 2025 11:10:32 +0100
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
Subject: Re: [RFC PATCH V3 11/17] mm/kscand: Implement migration failure
 feedback
Message-ID: <20251003111032.00004688@huawei.com>
In-Reply-To: <20250814153307.1553061-12-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-12-raghavendra.kt@amd.com>
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

On Thu, 14 Aug 2025 15:33:01 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

>  Before this, scanning kthread continues to scan even after
> migration fails. To control migration, scanning is slowed down
> based on the failure/success ratio obtained from migration
> thread.
> 
>  Decaying failure ratio is maintained for 1024 migration window.
> The ratio further contributes to approximately 10% scaling of
> scan_period.
Perhaps it's worth adding a cover letter section describing all the
heuristics briefly so we have a central place to understand what
needs tuning against workloads before this merges?

J

> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  mm/kscand.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/mm/kscand.c b/mm/kscand.c
> index bf975e82357d..41321d373be7 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c
> @@ -146,6 +146,8 @@ struct kmigrated_mm_slot {
>  	spinlock_t migrate_lock;
>  	/* Head of per mm migration list */
>  	struct list_head migrate_head;
> +	/* Indicates weighted success, failure */
> +	int msuccess, mfailed, fratio;
>  };
>  
>  /* System wide list of mms that maintain migration list */
> @@ -812,13 +814,45 @@ static void kscand_collect_mm_slot(struct kscand_mm_slot *mm_slot)
>  	}
>  }
>  
> +static int kmigrated_get_mstat_fratio(struct mm_struct *mm)
> +{
> +	int fratio = 0;
> +	struct kmigrated_mm_slot *mm_slot = NULL;
> +	struct mm_slot *slot;
> +
> +	guard(spinlock)(&kscand_migrate_lock);
> +
> +	slot = mm_slot_lookup(kmigrated_slots_hash, mm);
> +	mm_slot = mm_slot_entry(slot, struct kmigrated_mm_slot, mm_slot);
> +
> +	if (mm_slot)
> +		fratio =  mm_slot->fratio;

Extra space after =

> +
> +	return fratio;
> +}
> +
> +static void update_mstat_ratio(struct kmigrated_mm_slot *mm_slot,
> +				int msuccess, int mfailed)
> +{
> +	mm_slot->msuccess = (mm_slot->msuccess >> 2) + msuccess;
> +	mm_slot->mfailed = (mm_slot->mfailed >> 2) + mfailed;
> +	mm_slot->fratio = mm_slot->mfailed * 100;
> +	mm_slot->fratio /=  (mm_slot->msuccess + mm_slot->mfailed);

extra space after =

> +}
> +
> +#define MSTAT_UPDATE_FREQ	1024
> +
>  static void kmigrated_migrate_mm(struct kmigrated_mm_slot *mm_slot)
>  {
> +	int mfailed = 0;
> +	int msuccess = 0;
> +	int mstat_counter;
>  	int ret = 0, dest = -1;
>  	struct mm_slot *slot;
>  	struct mm_struct *mm;
>  	struct kscand_migrate_info *info, *tmp;
>  
> +	mstat_counter = MSTAT_UPDATE_FREQ;

Might as well set at declaration above.

>  	spin_lock(&mm_slot->migrate_lock);
>  
>  	slot = &mm_slot->mm_slot;
> @@ -842,11 +876,23 @@ static void kmigrated_migrate_mm(struct kmigrated_mm_slot *mm_slot)
>  			}
>  
>  			ret = kmigrated_promote_folio(info, mm, dest);
> +			mstat_counter--;
> +
> +			/* TBD: encode migrated count here, currently assume folio_nr_pages */
> +			if (!ret)
> +				msuccess++;
> +			else
> +				mfailed++;
>  
>  			kfree(info);
>  
>  			cond_resched();
>  			spin_lock(&mm_slot->migrate_lock);
> +			if (!mstat_counter) {
> +				update_mstat_ratio(mm_slot, msuccess, mfailed);
> +				msuccess  = mfailed = 0;

extra space before =

> +				mstat_counter = MSTAT_UPDATE_FREQ;
> +			}
>  		}
>  	}

