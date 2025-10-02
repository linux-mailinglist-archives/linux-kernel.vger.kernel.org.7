Return-Path: <linux-kernel+bounces-840483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB873BB4861
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4069E19E1A52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5F252292;
	Thu,  2 Oct 2025 16:24:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C211922FB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422264; cv=none; b=OUtN/iDEl/rYMPvIgc02Lw7Q+QqZtMljn2fJsnQJllwBnD3v9ShI2MaEuwr9XoqYitEu9Nav/YbDsPY5Vw/HEFRFExVbbLVsaSOMThaE4uVTSJ5qRIZj0n7Xu7BpuBZ+NPrFN2YPxJClHEHaghmnWUqVrq0C0cHI/dR2UObCKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422264; c=relaxed/simple;
	bh=01pEibkfcOZbELVbTmkEB60bQvbpEiOAuGOZctfVi4M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Krsz+K4XEZzVAkn3AMP32DdAvV8y2NtcGx/NLmtASMUGjQXbMDDAHUFCPmZIDfGCQEy2V7/AOAB3FesI3s8cKY3X6bI4PXqoeH2mrosexNhpUxCgtH22WI1G/JYdnAUdHH/IQMt3joarQXNNk1U+dpkOwhl27xAtDslUR23MA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccxrp3rrFz6L50J;
	Fri,  3 Oct 2025 00:22:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E0E4C1400D9;
	Fri,  3 Oct 2025 00:24:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 17:24:17 +0100
Date: Thu, 2 Oct 2025 17:24:15 +0100
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
Subject: Re: [RFC PATCH V3 07/17] mm: Add throttling of mm scanning using
 scan_period
Message-ID: <20251002172415.00003140@huawei.com>
In-Reply-To: <20250814153307.1553061-8-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-8-raghavendra.kt@amd.com>
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

On Thu, 14 Aug 2025 15:32:57 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Before this patch, scanning of tasks' mm is done continuously and also
> at the same rate.
> 
> Improve that by adding a throttling logic:
> 1) If there were useful pages found during last scan and current scan,
> decrease the scan_period (to increase scan rate) by TUNE_PERCENT (15%).
> 
> 2) If there were no useful pages found in last scan, and there are
> candidate migration pages in the current scan decrease the scan_period
> aggressively by 2 power SCAN_CHANGE_SCALE (2^3 = 8 now).

Explain why those values were chosen.

> 
> Vice versa is done for the reverse case.
> Scan period is clamped between MIN (600ms) and MAX (5sec).
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

Various minor comments inline.

Thanks,

Jonathan

> ---
>  mm/kscand.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kscand.c b/mm/kscand.c
> index 5cd2764114df..843069048c61 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c
> @@ -20,6 +20,7 @@
>  #include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/cleanup.h>
> +#include <linux/minmax.h>
>  
>  #include <asm/pgalloc.h>
>  #include "internal.h"
> @@ -33,6 +34,16 @@ static DEFINE_MUTEX(kscand_mutex);
>  #define KSCAND_SCAN_SIZE	(1 * 1024 * 1024 * 1024UL)
>  static unsigned long kscand_scan_size __read_mostly = KSCAND_SCAN_SIZE;
>  
> +/*
> + * Scan period for each mm.
> + * Min: 600ms default: 2sec Max: 5sec
> + */
> +#define KSCAND_SCAN_PERIOD_MAX	5000U
> +#define KSCAND_SCAN_PERIOD_MIN	600U
> +#define KSCAND_SCAN_PERIOD		2000U
> +
> +static unsigned int kscand_mm_scan_period_ms __read_mostly = KSCAND_SCAN_PERIOD;
> +
>  /* How long to pause between two scan cycles */
>  static unsigned int kscand_scan_sleep_ms __read_mostly = 20;
>  
> @@ -78,6 +89,11 @@ static struct kmem_cache *kmigrated_slot_cache __read_mostly;
>  /* Per mm information collected to control VMA scanning */
>  struct kscand_mm_slot {
>  	struct mm_slot slot;
> +	/* Unit: ms. Determines how aften mm scan should happen. */

Name it scan_period_ms and you can drop the unit comment + that info is
conveyed everywhere it is used.  You do that for the global so why not here as well.

> +	unsigned int scan_period;
> +	unsigned long next_scan;
> +	/* Tracks how many useful pages obtained for migration in the last scan */
> +	unsigned long scan_delta;
>  	long address;
>  	bool is_scanned;
>  };
> @@ -715,13 +731,92 @@ static void kmigrated_migrate_folio(void)
>  	}
>  }

> +/* Maintains stability of scan_period by decaying last time accessed pages */
> +#define SCAN_DECAY_SHIFT	4
> +/*
> + * X : Number of useful pages in the last scan.
> + * Y : Number of useful pages found in current scan.
> + * Tuning scan_period:
> + *	Initial scan_period is 2s.
> + *	case 1: (X = 0, Y = 0)
> + *		Increase scan_period by SCAN_PERIOD_TUNE_PERCENT.
> + *	case 2: (X = 0, Y > 0)
> + *		Decrease scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
> + *	case 3: (X > 0, Y = 0 )
> + *		Increase scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
> + *	case 4: (X > 0, Y > 0)
> + *		Decrease scan_period by SCAN_PERIOD_TUNE_PERCENT.
> + */
> +static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
> +				unsigned long total)

As below. I'd make total a local variable for now.

> +{
> +	unsigned int scan_period;
> +	unsigned long now;
> +	unsigned long old_scan_delta;

Might as well combine these two lines.

> +
> +	scan_period = mm_slot->scan_period;
> +	old_scan_delta = mm_slot->scan_delta;
> +
> +	/* decay old value */
> +	total = (old_scan_delta >> SCAN_DECAY_SHIFT) + total;
> +
> +	/* XXX: Hack to get rid of continuously failing/unmigrateable pages */
> +	if (total < KSCAND_IGNORE_SCAN_THR)
> +		total = 0;
> +
> +	/*
> +	 * case 1: old_scan_delta and new delta are similar, (slow) TUNE_PERCENT used.
> +	 * case 2: old_scan_delta and new delta are different. (fast) CHANGE_SCALE used.
> +	 * TBD:
> +	 * 1. Further tune scan_period based on delta between last and current scan delta.
> +	 * 2. Optimize calculation
> +	 */
> +	if (!old_scan_delta && !total) {
> +		scan_period = (100 + SCAN_PERIOD_TUNE_PERCENT) * scan_period;
> +		scan_period /= 100;
> +	} else if (old_scan_delta && total) {
> +		scan_period = (100 - SCAN_PERIOD_TUNE_PERCENT) * scan_period;
> +		scan_period /= 100;
> +	} else if (old_scan_delta && !total) {
> +		scan_period = scan_period << SCAN_PERIOD_CHANGE_SCALE;
> +	} else {
> +		scan_period = scan_period >> SCAN_PERIOD_CHANGE_SCALE;
> +	}
> +
> +	scan_period = clamp(scan_period, KSCAND_SCAN_PERIOD_MIN, KSCAND_SCAN_PERIOD_MAX);
> +
> +	now = jiffies;
> +	mm_slot->next_scan = now + msecs_to_jiffies(scan_period);
> +	mm_slot->scan_period = scan_period;
> +	mm_slot->scan_delta = total;
> +}
> +
>  static unsigned long kscand_scan_mm_slot(void)
>  {
>  	bool next_mm = false;
>  	bool update_mmslot_info = false;
>  
> +	unsigned int mm_slot_scan_period;
> +	unsigned long now;
> +	unsigned long mm_slot_next_scan;
>  	unsigned long vma_scanned_size = 0;
>  	unsigned long address;
> +	unsigned long total = 0;

Given this never changes in this patch I'd drop the parameter
from kscand_update_mmslot_info() and bring it back when you have code
that passes in non 0.

>  
>  	struct mm_slot *slot;
>  	struct mm_struct *mm;
> @@ -746,6 +841,8 @@ static unsigned long kscand_scan_mm_slot(void)
>  
>  	mm = slot->mm;
>  	mm_slot->is_scanned = true;
> +	mm_slot_next_scan = mm_slot->next_scan;
> +	mm_slot_scan_period = mm_slot->scan_period;
>  	spin_unlock(&kscand_mm_lock);
>  
>  	if (unlikely(!mmap_read_trylock(mm)))
> @@ -756,6 +853,11 @@ static unsigned long kscand_scan_mm_slot(void)
>  		goto outerloop;
>  	}
>  
> +	now = jiffies;
> +
> +	if (mm_slot_next_scan && time_before(now, mm_slot_next_scan))

If now is only used once, seems better just to put jiffies in the call
and drop local variable.


> +		goto outerloop;
> +
>  	VMA_ITERATOR(vmi, mm, address);
>  
>  	kmigrated_mm_slot = kmigrated_get_mm_slot(mm, false);
> @@ -786,8 +888,10 @@ static unsigned long kscand_scan_mm_slot(void)
>  
>  	update_mmslot_info = true;
>  
> -	if (update_mmslot_info)
> +	if (update_mmslot_info) {
>  		mm_slot->address = address;
> +		kscand_update_mmslot_info(mm_slot, total);
> +	}
>  
>  outerloop:
>  	/* exit_mmap will destroy ptes after this */
> @@ -889,6 +993,10 @@ void __kscand_enter(struct mm_struct *mm)
>  		return;
>  
>  	kscand_slot->address = 0;
> +	kscand_slot->scan_period = kscand_mm_scan_period_ms;
> +	kscand_slot->next_scan = 0;
> +	kscand_slot->scan_delta = 0;
> +
>  	slot = &kscand_slot->slot;
>  
>  	spin_lock(&kscand_mm_lock);


