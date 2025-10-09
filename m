Return-Path: <linux-kernel+bounces-846749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A3BC8E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCA0420393
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294E2E0939;
	Thu,  9 Oct 2025 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bu192Bjv"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0862E1F13
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010882; cv=none; b=t8jrhA4fdtjpu5NwWX8NoeI2gc/lyUyy6UvumpM347VK7MAqPx2KyULhG0Ehopvv6xpQQd76SmkyBQGCp0Zo168e0AK/wR3zC/iGrQTR5mIP+PqH4gePvp9pljLFps9fcZqUH3GGdrN8a0ssUKJDrL0njwwX0Ecvi/F/6RQhCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010882; c=relaxed/simple;
	bh=JC9jgIxIHsC0rpTcUOBqkaqzNLHG5l/luB/jXou2SH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=f6cG12BH7C9PJvuj/MawNg4iToRqvGouUAscbzS6gbnO3qPyIX4tu0CcvGXiSLarEzmgNJa3WDlVGEq9OvcXFJC0xNZ/kSVh0dKCK/5gahAL2H5r7poHXv1tGG3bKVGliBpg8T7Dbi9pdHf6XyCG+gwM14xQaDUM7+Ejap7qIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bu192Bjv; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251009115436euoutp01cbe75eb3fdb658498eabdaca36828ad7~s0JFSX55L0788007880euoutp01W
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:54:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251009115436euoutp01cbe75eb3fdb658498eabdaca36828ad7~s0JFSX55L0788007880euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760010877;
	bh=89YoilszcVgtY2WH9xkUBX5haHu7VfKEfNvtGBAHGdM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bu192Bjv4DCyMt7YU61OG1pYaDl8eyq6hJkNiecFAvJUn73QTZW1fP9YjBIisqt5f
	 f/wiDSTUCbW6KbHBroFQzToTC/AGg4bO4n6ljDpOTc1+soTZpDNaY+TX7K4lWRGUui
	 9wTa90wgFU9JWr5y2taU+ASF65/nFgLB++a56bOA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251009115436eucas1p23974f9afcd730fa3fdf66a7d6919d47f~s0JFAHA-N1574615746eucas1p2s;
	Thu,  9 Oct 2025 11:54:36 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251009115435eusmtip1e8fd4f06ffd3e6a355d1458090c4b984~s0JEHJ53D1953819538eusmtip1j;
	Thu,  9 Oct 2025 11:54:35 +0000 (GMT)
Message-ID: <0d3eb8e5-5588-4718-b01c-ef32b7dcb4a1@samsung.com>
Date: Thu, 9 Oct 2025 13:54:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [bisected][mainline]Kernel warnings at
 kernel/sched/cpudeadline.c:219
To: Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde
	<sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, LKML
	<linux-kernel@vger.kernel.org>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	jstultz@google.com, stultz@google.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251009080007.GH3245006@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251009115436eucas1p23974f9afcd730fa3fdf66a7d6919d47f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251009115436eucas1p23974f9afcd730fa3fdf66a7d6919d47f
X-EPHeader: CA
X-CMS-RootMailID: 20251009115436eucas1p23974f9afcd730fa3fdf66a7d6919d47f
References: <8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com>
	<20251008095039.GG3245006@noisy.programming.kicks-ass.net>
	<5a248390-ddaa-4127-a58a-794d0d70461a@linux.ibm.com>
	<20251008111314.GI3289052@noisy.programming.kicks-ass.net>
	<86fbf707-9ecf-4941-ae70-3332c360533d@linux.ibm.com>
	<20251009080007.GH3245006@noisy.programming.kicks-ass.net>
	<CGME20251009115436eucas1p23974f9afcd730fa3fdf66a7d6919d47f@eucas1p2.samsung.com>

On 09.10.2025 10:00, Peter Zijlstra wrote:
> On Wed, Oct 08, 2025 at 11:39:11PM +0530, Shrikanth Hegde wrote:
>> *It pointed to this*
>>
>> NIP [c0000000001fd798] dl_server_start+0x50/0xd8
>> LR [c0000000001d9534] enqueue_task_fair+0x228/0x8ec
>> Call Trace:
>> [c000006684a579c0] [0000000000000001] 0x1 (unreliable)
>> [c000006684a579f0] [c0000000001d9534] enqueue_task_fair+0x228/0x8ec
>> [c000006684a57a60] [c0000000001bb344] enqueue_task+0x5c/0x1c8
>> [c000006684a57aa0] [c0000000001c5fc0] ttwu_do_activate+0x98/0x2fc
>> [c000006684a57af0] [c0000000001c671c] try_to_wake_up+0x2e0/0xa60
>> [c000006684a57b80] [c00000000019fb48] kthread_park+0x7c/0xf0
>> [c000006684a57bb0] [c00000000015fefc] takedown_cpu+0x60/0x194
>> [c000006684a57c00] [c000000000161924] cpuhp_invoke_callback+0x1f4/0x9a4
>> [c000006684a57c90] [c0000000001621a4] __cpuhp_invoke_callback_range+0xd0/0x188
>> [c000006684a57d30] [c000000000165aec] _cpu_down+0x19c/0x560
>> [c000006684a57df0] [c0000000001637c0] __cpu_down_maps_locked+0x2c/0x3c
>> [c000006684a57e10] [c00000000018a100] work_for_cpu_fn+0x38/0x54
>> [c000006684a57e40] [c00000000019075c] process_one_work+0x1d8/0x554
>> [c000006684a57ef0] [c00000000019165c] worker_thread+0x308/0x46c
>> [c000006684a57f90] [c00000000019e474] kthread+0x16c/0x19c
>> [c000006684a57fe0] [c00000000000dd58] start_kernel_thread+0x14/0x18
>>
>> It is takedown_cpu called from CPU0(boot CPU) and it wakes up kthread
>> which is CPU Bound I guess.  Since happens after rq was marked
>> offline, it ends up starting the deadline server again.
>>
>> So i think it is sensible idea to stop the deadline server if the cpu
>> is going down.  Once we stop the server we will return
>> HRTIMER_NORESTART.
> D'0h.. that stop was far too early.
>
> How about moving that dl_server_stop() into sched_cpu_dying() like so.
>
> This seems to survive a few hotplugs for me.
>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 198d2dd45f59..f1ebf67b48e2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8571,10 +8571,12 @@ int sched_cpu_dying(unsigned int cpu)
>   	sched_tick_stop(cpu);
>   
>   	rq_lock_irqsave(rq, &rf);
> +	update_rq_clock(rq);
>   	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
>   		WARN(true, "Dying CPU not properly vacated!");
>   		dump_rq_tasks(rq, KERN_WARNING);
>   	}
> +	dl_server_stop(&rq->fair_server);
>   	rq_unlock_irqrestore(rq, &rf);
>   
>   	calc_load_migrate(rq);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 615411a0a881..7b7671060bf9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1582,6 +1582,9 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>   	if (!dl_server(dl_se) || dl_se->dl_server_active)
>   		return;
>   
> +	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
> +		return;
> +
>   	dl_se->dl_server_active = 1;
>   	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>   	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))

This fixes a similar issue observed on Samsung Exynos SoC based boards 
(ARM 32bit and 64bit) that I've reported in the following thread:

https://lore.kernel.org/all/e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com/

Thanks for the fix! Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


