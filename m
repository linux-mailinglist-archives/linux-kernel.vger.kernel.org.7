Return-Path: <linux-kernel+bounces-800838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A1B43CCD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778084E3D36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E1191F89;
	Thu,  4 Sep 2025 13:15:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF5301022
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991709; cv=none; b=l7F5txvHE6UuYv+7bKYdEJgO7+R2N9GgIef+ATZZboPjf7fjT4Er2Z98zcAIv08Q0fukyPxUKvW1BVjF4Fqtfv/D4aYlErVlRO9RhCctYEOhJtsPx1Ie5PM5fCCE/in2cepZ8MPWfa28J5Ija7rAKl3SnNEkQ4htdicm1YxdmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991709; c=relaxed/simple;
	bh=yuK2F22uNiu3WpPR/1wG4I0Pa9KpQmCvCZIlxl4EiVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzkBp3eo+uI0d6drz99JX6+pn0Izz5UvzxSOd5sFIGy+DBsc+AUSSyFKO0C/igR3Ny/AEDmYgTrr0hLRlGsQLbRpbZbl91SXOJ6iBmsAyIISzVSxlG3lvfeg/K8fGpnDgz7GaGwADZAU/2f8/kymeR10OTQUUb9umo3s94xD2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C84F1756;
	Thu,  4 Sep 2025 06:14:59 -0700 (PDT)
Received: from [10.1.26.85] (e127648.arm.com [10.1.26.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7213F6A8;
	Thu,  4 Sep 2025 06:15:06 -0700 (PDT)
Message-ID: <3dae6610-7a1f-459d-8280-3c8d00117495@arm.com>
Date: Thu, 4 Sep 2025 14:15:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Fix NULL dereference in
 scx_bpf_cpu_rq() warning
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Jake Hillion <jakehillion@meta.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250904125522.561737-1-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250904125522.561737-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 13:55, Andrea Righi wrote:
> When printing the deprecation warning for scx_bpf_cpu_rq(), we may hit a
> NULL pointer dereference if the kfunc is called before a BPF scheduler
> is fully attached, for example, when invoked from a BPF timer or during
> ops.init():
> 
>  [   50.752775] BUG: kernel NULL pointer dereference, address: 0000000000000331
>  ...
>  [   50.764205] RIP: 0010:scx_bpf_cpu_rq+0x30/0xa0
>  ...
>  [   50.787661] Call Trace:
>  [   50.788398]  <TASK>
>  [   50.789061]  bpf_prog_08f7fd2dcb187aaf_wakeup_timerfn+0x75/0x1a8
>  [   50.792477]  bpf_timer_cb+0x7e/0x140
>  [   50.796003]  hrtimer_run_softirq+0x91/0xe0
>  [   50.796952]  handle_softirqs+0xce/0x3c0
>  [   50.799087]  run_ksoftirqd+0x3e/0x70
>  [   50.800197]  smpboot_thread_fn+0x133/0x290
>  [   50.802320]  kthread+0x115/0x220
>  [   50.804984]  ret_from_fork+0x17a/0x1d0
>  [   50.806920]  ret_from_fork_asm+0x1a/0x30
>  [   50.807799]  </TASK>
> 
> Fix this by only printing the warning once the scheduler is fully
> registered.
> 
> Fixes: 5c48d88fe0049 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()")
> Cc: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 489462290142a..04fefd34db238 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6362,17 +6362,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>   */
>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  {
> -	struct scx_sched *sch = scx_root;
> +	struct scx_sched *sch;
>  
>  	if (!kf_cpu_valid(cpu, NULL))
>  		return NULL;
>  
> -	if (!sch->warned_deprecated_rq) {
> +	rcu_read_lock();
> +	sch = rcu_dereference(scx_root);
> +	if (sch && sch->warned_deprecated_rq) {
>  		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
>  				"use scx_bpf_locked_rq() when holding rq lock "
>  				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
>  		sch->warned_deprecated_rq = true;
>  	}
> +	rcu_read_unlock();
>  
>  	return cpu_rq(cpu);
>  }

Ah yes of course.
I guess the other ones that can happen during the actual lifetime
of the scheduler have a likely(sch) around it, which we could
add here as well.

