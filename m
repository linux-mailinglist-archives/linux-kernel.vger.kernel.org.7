Return-Path: <linux-kernel+bounces-847427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DBBCACD8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0833B56E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7D27056F;
	Thu,  9 Oct 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nlk+4kPQ"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37326F471
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041720; cv=none; b=eh04rh2jUdWG75M04OywyfVI79w7tCUqTf7IbjrCeUXkyax8mJOozZR/oxjc+kYN0VaIX+DL8ZBfi35FZSyirduMX0rddnlxpSSLYwjIdBPBZwWxc0FvU4T4Oy0xr53Vdl+45zpxGzav+xaLFaorExJ3HDj/Zuy+T9Zb6yH5NCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041720; c=relaxed/simple;
	bh=3mesMJCHxKCQ9TPWRtvzUVvMs1gLbGsWIMyBh7CWM1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BXFrLthylhPaWR1Qg4VfPmg2xvd+7gyviMbx1qKR6G7WvZtzYVKlyxu0koBtuNYQfXluQGhW5PTFKK1p0pLTCsu1PUU2Gnrbbo7c9MCAQJ7ykJwptwbZktZURBRqWVMc+p2cPQoJxafh8dyBlv+5asMAbnCRDIEqS0OSmC5bgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nlk+4kPQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251009202834euoutp01cbda1b9fc7bfaeba60a1f6d9657d5c4c~s7J1N95N22910129101euoutp010
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:28:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251009202834euoutp01cbda1b9fc7bfaeba60a1f6d9657d5c4c~s7J1N95N22910129101euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760041714;
	bh=PEQt2CgrK+lTlqZJv4b9gffvbDj0I0LwSr+EGVx7o+M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nlk+4kPQaPH0OjKtHU2HerZ8oqVXQX4STzkU4FDKBWC0gUTfdoPuTHMZfbgtYCibG
	 03yoUe2MA2Qxuh6NkMpF8kRek6DVa/wnlrP/KZ1iNNWcYsT8pS53vLrJn2LugbRm22
	 UGSZ2fwrvO806Tjez4WYllNy7CsGXCm6jmB07FaM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251009202834eucas1p1bfe2bd8fdb6360bc836fa09dd2208a58~s7J0yGgka2691726917eucas1p1y;
	Thu,  9 Oct 2025 20:28:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251009202833eusmtip29563cfd0864227c6682b23fe26571a5b~s7Jz4niFS2491624916eusmtip2D;
	Thu,  9 Oct 2025 20:28:33 +0000 (GMT)
Message-ID: <58f317d8-3137-4847-9a27-cbdf0f54eff2@samsung.com>
Date: Thu, 9 Oct 2025 22:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] sched/deadline: stop dl_server before CPU goes offline
To: Shrikanth Hegde <sshegde@linux.ibm.com>, peterz@infradead.org,
	juri.lelli@redhat.com
Cc: mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	venkat88@linux.ibm.com, jstultz@google.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251009184727.673081-1-sshegde@linux.ibm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251009202834eucas1p1bfe2bd8fdb6360bc836fa09dd2208a58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251009202834eucas1p1bfe2bd8fdb6360bc836fa09dd2208a58
X-EPHeader: CA
X-CMS-RootMailID: 20251009202834eucas1p1bfe2bd8fdb6360bc836fa09dd2208a58
References: <20251009184727.673081-1-sshegde@linux.ibm.com>
	<CGME20251009202834eucas1p1bfe2bd8fdb6360bc836fa09dd2208a58@eucas1p1.samsung.com>

On 09.10.2025 20:47, Shrikanth Hegde wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> IBM CI tool reported kernel warning[1] when running a CPU removal
> operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"
>
> WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 cpudl_set+0x58/0x170
> NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
> LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> Call Trace:
> [c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
> [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> [c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
> [c00000000034f624] hrtimer_interrupt+0x124/0x300
> [c00000000002a230] timer_interrupt+0x140/0x320
>
> Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
>
> This happens since:
> - dl_server hrtimer gets enqueued close to cpu offline, when
>    kthread_park enqueues a fair task.
> - CPU goes offline and drmgr removes it from cpu_present_mask.
> - hrtimer fires and warning is hit.
>
> Fix it by stopping the dl_server before CPU is marked dead.
>
> [1]: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com/
> [2]: https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr
>
> [sshegde: wrote the changelog and tested it]
> Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com
Closes: 
https://lore.kernel.org/all/e56310b5-f7a9-4fad-b79a-dcbcdd3d3883@samsung.com/
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   kernel/sched/core.c     | 2 ++
>   kernel/sched/deadline.c | 3 +++
>   2 files changed, 5 insertions(+)
>
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

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


