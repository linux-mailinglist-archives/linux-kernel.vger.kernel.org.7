Return-Path: <linux-kernel+bounces-840281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F8BB4056
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7980F42165A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ED6311977;
	Thu,  2 Oct 2025 13:23:25 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E63126AB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411405; cv=none; b=tKh2rH8L5TJi0C6uzPrQskDic+7bTUee3qg5CTnRpTbo+mWdRv82VLVG5fR1Ev/nBeJ69LQqMitJ4box0dLjNmHq2OI077x2qHrWJh73xAV2agAtt54d4tz1N3tmlm2evURk3rXUpadt8JKGaqivVDt2k1xQOeEEZGBW4iwA/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411405; c=relaxed/simple;
	bh=yIoDS1rE5QwCZkmYO797Qyo84zn+h0EMvmzJyUyTs7E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/g1BNWijSYbBOvP8KsmzC8wSJS5X109PmxfgTw/XbdAGr0NeX7dmKi6OHDjjPL6a/hFoUFtKdHso98dpcQqei9hS6W/kTvduTDSCVjvMFPZEJ+F8rlHfHVOcMbYk9a7ueYKpF59iFpRepVFzdqbvyE3uHov6yUHU3WaTg1YZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccsqz2cMyz6L4t4;
	Thu,  2 Oct 2025 21:21:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D8661402EB;
	Thu,  2 Oct 2025 21:23:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 14:23:17 +0100
Date: Thu, 2 Oct 2025 14:23:15 +0100
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
Subject: Re: [RFC PATCH V3 02/17] mm: Maintain mm_struct list in the system
Message-ID: <20251002142315.000072f2@huawei.com>
In-Reply-To: <20250814153307.1553061-3-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-3-raghavendra.kt@amd.com>
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

On Thu, 14 Aug 2025 15:32:52 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> The list is used to iterate over all the mm and do PTE A bit scanning.
> mm_slot infrastructure is reused to aid insert and lookup of mm_struct.
> 
> CC: linux-fsdevel@vger.kernel.org

This is part of the tags block.  Some tools moan if you have blank lines
in that.  Alternatively push it below the --- and it won't end up in
the git commit but tooling will still add the +CC.

> 
> Suggested-by: Bharata B Rao <bharata@amd.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

A few minor comments on formatting.

> diff --git a/mm/kscand.c b/mm/kscand.c
> index f7bbbc70c86a..d5b0d3041b0f 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c

> +void __kscand_enter(struct mm_struct *mm)
> +{
> +	struct kscand_mm_slot *kscand_slot;
> +	struct mm_slot *slot;
> +	int wakeup;
> +
> +	/* __kscand_exit() must not run from under us */
> +	VM_BUG_ON_MM(kscand_test_exit(mm), mm);
> +
> +	kscand_slot = mm_slot_alloc(kscand_slot_cache);
> +
Similar to below. I'd keep call and error check more closely coupled
visually by dropping this blank line.

> +	if (!kscand_slot)
> +		return;
> +
> +	slot = &kscand_slot->slot;
> +
> +	spin_lock(&kscand_mm_lock);
> +	mm_slot_insert(kscand_slots_hash, mm, slot);
> +
> +	wakeup = list_empty(&kscand_scan.mm_head);

Looks familiar.

wakeup = kscand_has_work()

Or maybe just get rid of that helper and check it explicitly like this.


> +	list_add_tail(&slot->mm_node, &kscand_scan.mm_head);
> +	spin_unlock(&kscand_mm_lock);
> +
> +	mmgrab(mm);
> +	if (wakeup)
> +		wake_up_interruptible(&kscand_wait);
> +}

> +
>  static int start_kscand(void)
>  {
>  	struct task_struct *kthread;
> @@ -149,6 +228,12 @@ static int __init kscand_init(void)
>  {
>  	int err;
>  
> +	kscand_slot_cache = KMEM_CACHE(kscand_mm_slot, 0);
> +

I'd drop this blank line. Keep the call and the error check tightly coupled
in one block of code.

> +	if (!kscand_slot_cache) {
> +		pr_err("kscand: kmem_cache error");
> +		return -ENOMEM;
> +	}
>  	err = start_kscand();
>  	if (err)
>  		goto err_kscand;
> @@ -157,6 +242,7 @@ static int __init kscand_init(void)
>  
>  err_kscand:
>  	stop_kscand();
> +	kscand_destroy();
>  
>  	return err;
>  }



