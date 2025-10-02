Return-Path: <linux-kernel+bounces-840268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301A1BB3FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC80719C51B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473DF31158E;
	Thu,  2 Oct 2025 13:12:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08729ACC5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410737; cv=none; b=oVQUVN5Wtxc411VCP1+ogOCbnotth2SPf/In3LiAwDfFjdK7o87G97C5Z1LB+7CeTd6WnIRXa+XxRHVYNe4bY6C4oFo3fc6wu8AbidDtA1poB0akSisFp/cN2EmEKdDgSfbtuYnVXur/urv4iQJYQMuaag3x3/ZSe9CDN/QiZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410737; c=relaxed/simple;
	bh=sQzU2kePbMg21U9hQNJqXwvo/QhuZCoGyWAJ1f1T//Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUEy9A1BDeTvUXkzirQa1x2Q5gqBgZ08DkrZ7MbHZYxBP05Ik9CfWhXYgqu+ku+mBNjyQzY3ElTaJYvncM4k2IPR4tm6H4zR6YCF3bAil72oxowlvMnQvgzjCQd9TZ73gcnZ68wQbffm6w4HS2g4/M116kJ/JI3McnPPO1oxRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccsb730Fzz6L4sd;
	Thu,  2 Oct 2025 21:09:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 68093140426;
	Thu,  2 Oct 2025 21:12:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 14:12:09 +0100
Date: Thu, 2 Oct 2025 14:12:07 +0100
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
Subject: Re: [RFC PATCH V3 01/17] mm: Add kscand kthread for PTE A bit scan
Message-ID: <20251002141207.00007b58@huawei.com>
In-Reply-To: <20250814153307.1553061-2-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-2-raghavendra.kt@amd.com>
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

On Thu, 14 Aug 2025 15:32:51 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Also add a config option for the same.
> 
> High level design:
> 
> While (1):
>   Scan the slowtier pages belonging to VMAs of a task.
>   Add to migation list.
> 
> A separate thread:
>   Migrate scanned pages to a toptier node based on heuristics.
> 
> The overall code is influenced by khugepaged design.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

Hi Raghavendra,

A few comments inline.

Thanks,

Jonathan

> diff --git a/mm/kscand.c b/mm/kscand.c
> new file mode 100644
> index 000000000000..f7bbbc70c86a
> --- /dev/null
> +++ b/mm/kscand.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/mm.h>

Good to pick an order for includes.   Various options, my personal
preference is alphabetical with groups of linux/* asm/* and local headers.

> +#include <linux/mm_types.h>
> +#include <linux/sched.h>
> +#include <linux/sched/mm.h>
> +#include <linux/mmu_notifier.h>
> +#include <linux/swap.h>
> +#include <linux/mm_inline.h>
> +#include <linux/kthread.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/cleanup.h>
> +
> +#include <asm/pgalloc.h>
> +#include "internal.h"
...


> +static void kscand_wait_work(void)
> +{
> +	const unsigned long scan_sleep_jiffies =
> +		msecs_to_jiffies(kscand_scan_sleep_ms);
> +
> +	if (!scan_sleep_jiffies)
> +		return;
> +
> +	kscand_sleep_expire = jiffies + scan_sleep_jiffies;
> +
> +	/* Allows kthread to pause scanning */
> +	wait_event_timeout(kscand_wait, kscand_should_wakeup(),
> +			scan_sleep_jiffies);
> +}

Trivial but more consistent I think to have a blank line here.

> +static void kscand_do_scan(void)
> +{
> +	unsigned long iter = 0, mms_to_scan;
> +
> +	mms_to_scan = READ_ONCE(kscand_mms_to_scan);
Slightly nicer perhaps as

	unsigned long iter = 0;
	unsigned long mms_to_scan = READ_ONCE(kscand_mms_to_scan);

> +
> +	while (true) {
> +		if (unlikely(kthread_should_stop()) ||
> +			!READ_ONCE(kscand_scan_enabled))
> +			break;
> +
> +		if (kscand_has_work())
> +			msleep(100);
> +
> +		iter++;
> +
> +		if (iter >= mms_to_scan)
> +			break;
> +		cond_resched();
> +	}
> +}
> +

> +
> +static int start_kscand(void)
> +{
> +	struct task_struct *kthread;
> +
> +	guard(mutex)(&kscand_mutex);
> +
> +	if (kscand_thread)
> +		return 0;
> +
> +	kthread = kthread_run(kscand, NULL, "kscand");
> +	if (IS_ERR(kscand_thread)) {

That looks like the wrong variable to check.

> +		pr_err("kscand: kthread_run(kscand) failed\n");
> +		return PTR_ERR(kthread);
> +	}
> +
> +	kscand_thread = kthread;
> +	pr_info("kscand: Successfully started kscand");
> +
> +	if (!list_empty(&kscand_scan.mm_head))

You have kscand_has_work() for this.

> +		wake_up_interruptible(&kscand_wait);
> +
> +	return 0;
> +}
> +
> +static int stop_kscand(void)
> +{
> +	guard(mutex)(&kscand_mutex);
> +
> +	if (kscand_thread) {
> +		kthread_stop(kscand_thread);
> +		kscand_thread = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init kscand_init(void)
> +{
> +	int err;
> +
> +	err = start_kscand();
> +	if (err)
> +		goto err_kscand;
This breaks the nice principle of side effect free calls
on error. If start_kscand() has failed, I'd not really expect to have
have stop explicitly.   I'm not sure you actually do need to do so.


> +
> +	return 0;
> +
> +err_kscand:
> +	stop_kscand();
> +
> +	return err;
> +}
> +subsys_initcall(kscand_init);


