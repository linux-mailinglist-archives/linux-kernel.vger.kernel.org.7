Return-Path: <linux-kernel+bounces-841261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA17BB6A96
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01533AACC7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618F2EDD52;
	Fri,  3 Oct 2025 12:30:34 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60854652
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494633; cv=none; b=nD/Et1JGpH6MLkzzHjC8ZDjGaJ1u6KtNIz45MAdda4/gWgFgCUtN1v3iFPqeVXOTeY5JpXpAuO7QmXgn+MGv4aZp4uvMjeEfvMevZDYAJsKB0kWVZuJw697CXcrNm4qxal5UOuZZg8DSfuOEQA9ttH795bG4LPDraO4eRRRYxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494633; c=relaxed/simple;
	bh=gTlntt8Kgb2CuFsuHA3ILc+Z508afynI0MGXI59lG5g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWIGlYHCpPr3XKZXxW1KVMoSRRP1k0w6c4121DYTB5xmirVZIfRcHU2WC98LRuanWBWaUYUjgab1hb0nTmJZnBP8ubDZOnaD02eDFwzawANBy2/1n2nhDRIKTVyTNf88PfwopahByjPHVwoRNNFaZP1CLDoyV8GkenSfoqAFYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdScT5bC2z6L4th;
	Fri,  3 Oct 2025 20:28:09 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8315114038F;
	Fri,  3 Oct 2025 20:30:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 13:30:27 +0100
Date: Fri, 3 Oct 2025 13:30:25 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<sj@kernel.org>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>, <dave@stgolabs.net>,
	<nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>,
	<byungchul@sk.com>, <kinseyho@google.com>, <joshua.hahnjy@gmail.com>,
	<yuanchu@google.com>, <balbirs@nvidia.com>, <alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 7/8] mm: klruscand: use mglru scanning for page
 promotion
Message-ID: <20251003133025.00006f4b@huawei.com>
In-Reply-To: <20250910144653.212066-8-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<20250910144653.212066-8-bharata@amd.com>
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

On Wed, 10 Sep 2025 20:16:52 +0530
Bharata B Rao <bharata@amd.com> wrote:

> From: Kinsey Ho <kinseyho@google.com>
> 
> Introduce a new kernel daemon, klruscand, that periodically invokes the
> MGLRU page table walk. It leverages the new callbacks to gather access
> information and forwards it to the pghot hot page tracking sub-system
> for promotion decisions.
> 
> This benefits from reusing the existing MGLRU page table walk
> infrastructure, which is optimized with features such as hierarchical
> scanning and bloom filters to reduce CPU overhead.
> 
> As an additional optimization to be added in the future, we can tune
> the scan intervals for each memcg.
> 
> Signed-off-by: Kinsey Ho <kinseyho@google.com>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> 	[Reduced the scan interval to 100ms, pfn_t to unsigned long]
Some very minor comments inline.  I know even less about the stuff this
is using than IBS (and I don't know much about that ;)

J
> ---
>  mm/Kconfig     |   8 ++++
>  mm/Makefile    |   1 +
>  mm/klruscand.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 mm/klruscand.c
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 8b236eb874cf..6d53c1208729 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1393,6 +1393,14 @@ config PGHOT
>  	  by various sources. Asynchronous promotion is done by per-node
>  	  kernel threads.
>  
> +config KLRUSCAND
> +	bool "Kernel lower tier access scan daemon"
> +	default y

Why default to y? That's very rarely done for new features.

> +	depends on PGHOT && LRU_GEN_WALKS_MMU
> +	help
> +	  Scan for accesses from lower tiers by invoking MGLRU to perform
> +	  page table walks.

> diff --git a/mm/klruscand.c b/mm/klruscand.c
> new file mode 100644
> index 000000000000..1a51aab29bd9
> --- /dev/null
> +++ b/mm/klruscand.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/memcontrol.h>

Probably pick some ordering scheme for includes.
I'm not spotting what is currently used here.

> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +#include <linux/random.h>
> +#include <linux/migrate.h>
> +#include <linux/mm_inline.h>
> +#include <linux/slab.h>
> +#include <linux/sched/clock.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/sched/mm.h>
> +#include <linux/sched.h>
> +#include <linux/pghot.h>
> +
> +#include "internal.h"
> +
> +#define KLRUSCAND_INTERVAL_MS 100
> +#define BATCH_SIZE (2 << 16)
> +
> +static struct task_struct *scan_thread;
> +static unsigned long pfn_batch[BATCH_SIZE];
> +static int batch_index;
> +
> +static void flush_cb(void)
> +{
> +	int i = 0;
> +
> +	for (; i < batch_index; i++) {
> +		u64 pfn = pfn_batch[i];

Why dance through types?  pfn_batch is unsigned long and it is
cast back to that below.

> +
> +		pghot_record_access((unsigned long)pfn, NUMA_NO_NODE,
> +					PGHOT_PGTABLE_SCAN, jiffies);
> +
> +		if (i % 16 == 0)

No problem with this, but maybe a comment on why 16?

> +			cond_resched();
> +	}
> +	batch_index = 0;
> +}

> +static int klruscand_run(void *unused)
> +{
> +	struct lru_gen_mm_walk *walk;
> +
> +	walk = kzalloc(sizeof(*walk),
> +		       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);

Maybe use __free() magic so we can forget about having to clear this up on exit.
Entirely up to you though as doesn't simplify code much in this case.

> +	if (!walk)
> +		return -ENOMEM;
> +
> +	while (!kthread_should_stop()) {
> +		unsigned long next_wake_time;
> +		long sleep_time;
> +		struct mem_cgroup *memcg;
> +		int flags;
> +		int nid;
> +
> +		next_wake_time = jiffies + msecs_to_jiffies(KLRUSCAND_INTERVAL_MS);
> +
> +		for_each_node_state(nid, N_MEMORY) {
> +			pg_data_t *pgdat = NODE_DATA(nid);
> +			struct reclaim_state rs = { 0 };
> +
> +			if (node_is_toptier(nid))
> +				continue;
> +
> +			rs.mm_walk = walk;
> +			set_task_reclaim_state(current, &rs);
> +			flags = memalloc_noreclaim_save();
> +
> +			memcg = mem_cgroup_iter(NULL, NULL, NULL);
> +			do {
> +				struct lruvec *lruvec =
> +					mem_cgroup_lruvec(memcg, pgdat);
> +				unsigned long max_seq =
> +					READ_ONCE((lruvec)->lrugen.max_seq);
> +
> +				lru_gen_scan_lruvec(lruvec, max_seq,
> +						    accessed_cb, flush_cb);
> +				cond_resched();
> +			} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
> +
> +			memalloc_noreclaim_restore(flags);
> +			set_task_reclaim_state(current, NULL);
> +			memset(walk, 0, sizeof(*walk));
> +		}
> +
> +		sleep_time = next_wake_time - jiffies;
> +		if (sleep_time > 0 && sleep_time != MAX_SCHEDULE_TIMEOUT)
> +			schedule_timeout_idle(sleep_time);
> +	}
> +	kfree(walk);
> +	return 0;
> +}


