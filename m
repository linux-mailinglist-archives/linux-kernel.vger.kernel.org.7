Return-Path: <linux-kernel+bounces-841167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7152BB664F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 233164EA7AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A92D5426;
	Fri,  3 Oct 2025 09:41:50 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB141E3DCF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484510; cv=none; b=ASBa2Rh/dVtV5WJbij/hvNpqvNDKk/CLMnMqSrrzH6f57Fyqam9tpelc/x4c37njalgfJg7II0aaLiPKxApFnwPHKGfh3H9fLYzqumjxFVGGkeQUfsllCf8G0p7Nct7e0nnqVrLua2G7Tu/trLNojqnDVuFkXUbvsLHaCHID+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484510; c=relaxed/simple;
	bh=YTNPE7mN3EHSq5ntZqDtlhOadteD1vuTKt+qxn3qoMU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=em00YWQZsx7dcNYD8O3DQ+AIP9NxkGr+74VKoRTjDVeCwHhPXHYfmobPm1McRDCRQ0U8KeM8fhbufwA7r67nK8U1LOAbl8sKRjJDJVW0sf0iW3CNCq2lm5kiY0GHkNlV9BQ/pODopOqigBXv6WMbdyvseIvhaFZTqby13EyILNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdNsq1bKyz6L4tL;
	Fri,  3 Oct 2025 17:39:27 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E68B1400D9;
	Fri,  3 Oct 2025 17:41:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 10:41:43 +0100
Date: Fri, 3 Oct 2025 10:41:41 +0100
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
Subject: Re: [RFC PATCH V3 09/17] mm: Add initial scan delay
Message-ID: <20251003104141.00001744@huawei.com>
In-Reply-To: <20250814153307.1553061-10-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-10-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 14 Aug 2025 15:32:59 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

>  This is  to prevent unnecessary scanning of short lived tasks
> to reduce CPU burning.
Add a tiny bit on why reusing the existing sysctl value.
Also useful to add a comment here on current default of that
so when considering this algorithm we know what it is.


> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  mm/kscand.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kscand.c b/mm/kscand.c
> index 39a7fcef7de8..880c3693866d 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c
> @@ -28,6 +28,7 @@
>  
>  static struct task_struct *kscand_thread __read_mostly;
>  static DEFINE_MUTEX(kscand_mutex);
> +extern unsigned int sysctl_numa_balancing_scan_delay;

Maybe we need to move the declaration from kernel/sched/sched.h
I'd rather see that than a somewhat hidden away extern declaration.

>  
>  /*
>   * Total VMA size to cover during scan.
> @@ -1010,6 +1011,7 @@ void __kscand_enter(struct mm_struct *mm)
>  {
>  	struct kscand_mm_slot *kscand_slot;
>  	struct mm_slot *slot;
> +	unsigned long now;
>  	int wakeup;
>  
>  	/* __kscand_exit() must not run from under us */
> @@ -1020,10 +1022,12 @@ void __kscand_enter(struct mm_struct *mm)
>  	if (!kscand_slot)
>  		return;
>  
> +	now = jiffies;
>  	kscand_slot->address = 0;
>  	kscand_slot->scan_period = kscand_mm_scan_period_ms;
>  	kscand_slot->scan_size = kscand_scan_size;
> -	kscand_slot->next_scan = 0;
> +	kscand_slot->next_scan = now +
> +			2 * msecs_to_jiffies(sysctl_numa_balancing_scan_delay);

I think one tab beyond line above is enough for indent here.

>  	kscand_slot->scan_delta = 0;
>  
>  	slot = &kscand_slot->slot;


