Return-Path: <linux-kernel+bounces-730905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3468B04C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2011C3AD9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB096242D99;
	Mon, 14 Jul 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="N3VRZgBP"
Received: from mail17.out.titan.email (mail17.out.titan.email [3.64.226.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65D1662E7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535451; cv=none; b=KFNw8dBfTedyvs3/na2VGZj53b7dlWSe4UAtgSafY9MUXAYJ/KRYh+gRwLct7JlGGkFkh7ywhu8EAXQsg37+MZZ+/52U2bBUseKsisEe1lT8lkzRxRBMrt6VWMq+S+Pi18jRqFyyuXJVLzsPanx09sW0g5ryDqEaO3atxqP5CRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535451; c=relaxed/simple;
	bh=w/njO+Eio19jojpm3LOUc6VAGrzjCD/N9jpa95dSiN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZXMHrMlZ/Q9K996QxYLlg9xYGLlnmtKCvBXjbyydqbiu1tMKkSlwc9C9Av9MLYZdQ1m7pRNEGFwrjTQC0qZhjlBs9h05ARugwY+dSddE4/GBITLzpHcCxrCq6ROKKXYVNE7iDRBZ1ECvgoY2GoKDQX9UgGyosQpGEwYwt6ePzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=N3VRZgBP; arc=none smtp.client-ip=3.64.226.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 9DE78A0006;
	Mon, 14 Jul 2025 23:14:54 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=IZEkWRPWmtJUxnmSXF7VAq23VNGGw/RoGxJV/hfIDTg=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=to:message-id:date:from:cc:subject:references:mime-version:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752534894; v=1;
	b=N3VRZgBPEIp9DETNkM7oN7lGHYv8y2O2btGPK/ZE6VCHA3pIi+/XGg4kiwDmLsrlLRLjDyu5
	gDQkG9M9mEOWwrUDPTpDUENUPGzpghAJBk0biI1sarRnCEnKtD9NWtOPh6izs2fJbfpRklx7mgR
	P5EyTAakwv/kflWf4KTCFrZc=
Received: from mail.blacknight.com (ip-84-203-196-90.broadband.digiweb.ie [84.203.196.90])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id C1CCEA0002;
	Mon, 14 Jul 2025 23:14:53 +0000 (UTC)
Date: Tue, 15 Jul 2025 00:14:52 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] sched: Add ttwu_queue controls
Message-ID: <yz42ivo4lgdmn2ikmfagzzmtj2iodz2rq6jw2og5n4yddsi5az@x2i7zypbh7xt>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.817814031@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20250702121158.817814031@infradead.org>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752534894450122467.2206.2939698480240242390@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=FN3hx/os c=1 sm=1 tr=0 ts=68758f6e
	a=+XWPlUOTt03IZrtNKHUAqA==:117 a=+XWPlUOTt03IZrtNKHUAqA==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
	a=bbLQEv47hkCM5Bk10OkA:9 a=PUjeQqilurYA:10 a=1CNFftbPRP8L7MoqJWF3:22

On Wed, Jul 02, 2025 at 01:49:29PM +0200, Peter Zijlstra wrote:
> There are two (soon three) callers of ttwu_queue_wakelist(),
> distinguish them with their own WF_ and add some knobs on.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.874587738@infradead.org
> ---
>  kernel/sched/core.c     |   22 ++++++++++++----------
>  kernel/sched/features.h |    2 ++
>  kernel/sched/sched.h    |    2 ++
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3888,7 +3888,7 @@ bool cpus_share_resources(int this_cpu,
>  	return per_cpu(sd_share_id, this_cpu) == per_cpu(sd_share_id, that_cpu);
>  }
>  
> -static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
> +static inline bool ttwu_queue_cond(struct task_struct *p, int cpu, bool def)
>  {
>  	/* See SCX_OPS_ALLOW_QUEUED_WAKEUP. */
>  	if (!scx_allow_ttwu_queue(p))
> @@ -3929,18 +3929,19 @@ static inline bool ttwu_queue_cond(struc
>  	if (!cpu_rq(cpu)->nr_running)
>  		return true;
>  
> -	return false;
> +	return def;
>  }
>  
>  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>  {
> -	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(p, cpu)) {
> -		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> -		__ttwu_queue_wakelist(p, cpu, wake_flags);
> -		return true;
> -	}
> +	bool def = sched_feat(TTWU_QUEUE_DEFAULT);
> +
> +	if (!ttwu_queue_cond(p, cpu, def))
> +		return false;
>  
> -	return false;
> +	sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> +	__ttwu_queue_wakelist(p, cpu, wake_flags);
> +	return true;
>  }
>  

I get that you're moving the feature checks into the callers but it's
unclear what the intent behind TTWU_QUEUE_DEFAULT is. It's somewhat
preserving existing behaviour and is probably preparation for a later
patch but it's less clear why it's necessary or what changing it would
reveal while debugging.

>  static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
> @@ -3948,7 +3949,7 @@ static void ttwu_queue(struct task_struc
>  	struct rq *rq = cpu_rq(cpu);
>  	struct rq_flags rf;
>  
> -	if (ttwu_queue_wakelist(p, cpu, wake_flags))
> +	if (sched_feat(TTWU_QUEUE) && ttwu_queue_wakelist(p, cpu, wake_flags))
>  		return;
>  
>  	rq_lock(rq, &rf);
> @@ -4251,7 +4252,8 @@ int try_to_wake_up(struct task_struct *p
>  		 * scheduling.
>  		 */
>  		if (smp_load_acquire(&p->on_cpu) &&
> -		    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
> +		    sched_feat(TTWU_QUEUE_ON_CPU) &&
> +		    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
>  			break;
>  
>  		cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -81,6 +81,8 @@ SCHED_FEAT(TTWU_QUEUE, false)
>   */
>  SCHED_FEAT(TTWU_QUEUE, true)
>  #endif
> +SCHED_FEAT(TTWU_QUEUE_ON_CPU, true)
> +SCHED_FEAT(TTWU_QUEUE_DEFAULT, false)
>  
>  /*
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2279,6 +2279,8 @@ static inline int task_on_rq_migrating(s
>  #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
>  #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
>  
> +#define WF_ON_CPU		0x0100
> +
>  static_assert(WF_EXEC == SD_BALANCE_EXEC);
>  static_assert(WF_FORK == SD_BALANCE_FORK);
>  static_assert(WF_TTWU == SD_BALANCE_WAKE);
> 

-- 
Mel Gorman
SUSE Labs

