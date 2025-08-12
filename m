Return-Path: <linux-kernel+bounces-763776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C691B21A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855FB190751A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA15248F6A;
	Tue, 12 Aug 2025 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+ywJsO+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE132CA8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754962315; cv=none; b=OnosOTCfGx3+B0jNciGOaquTVApmvuYgAY+ZkJmeyCUPRWI+TcGPwrRmc6+1k1D/BQTOcaOCDxiq6B399kui2Kwwjau/9+TR/NFjfIM40Ovww/6IyZHT/yiNbgGBJ9akXmYq5FedS02irBW7DJjaQ0G2wEYH7JJRhQXxsegwei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754962315; c=relaxed/simple;
	bh=Hoz77JYdXZ/VWbTN8RSqaYl1D6SCdtd99VkI6hf/V2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VElPOJAbneZk3wSgkiIcHZK2vQUju86pcc1tXpEePrfRTWhqICI4Ddc9FpYPKoh11IPDMde6r/8LHWkskJUcTT3ctC5VHoq5UXcJXsmCZe73ovZwmJJDlPbXK+AXz0HLk+FL2Bwaqs2zqCJd1VnvHbUC0TFmywS6cxncdzuR+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+ywJsO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE3C4CEED;
	Tue, 12 Aug 2025 01:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754962315;
	bh=Hoz77JYdXZ/VWbTN8RSqaYl1D6SCdtd99VkI6hf/V2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+ywJsO+pZv3vILfVIijFiY2icBWCBhK1hkXaHS+f0cNei/6JX1wZNk3D1N+REnff
	 V6/ulv/yJOTVjhNeAU0rHTkTKCpo9nd4Wys7jG7792XmTSUpon8C0Ghxb8bsDrQInN
	 U0xWZuP5NRAkMS4gHrx413fwC3MH09Ph7AF0v4wewWN1+qlJlXEzkd8jPEI51Wh7hH
	 CCNcMhBKw5USp1zYav6umTWDMOc3+whABO2kdKAPeC0J3uaB4+sdX5KaW3DsFWF8Kx
	 si9k8Ki3gOBhstxAgSe/Me3Xd1cipe1IQdVm5Shqhz9Z0T3ICs2C+/aK37U1XAxInQ
	 MLxRbdPjwqF0g==
Date: Mon, 11 Aug 2025 15:31:54 -1000
From: 'Tejun Heo' <tj@kernel.org>
To: liuwenfang <liuwenfang@honor.com>
Cc: 'David Vernet' <void@manifault.com>, 'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Peter Zijlstra' <peterz@infradead.org>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Message-ID: <aJqZihOivRztpRtP@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <814bebd2ad844b08993836fd8e7274b8@honor.com>

On Sun, Jul 20, 2025 at 09:41:03AM +0000, liuwenfang wrote:
> Priority inheritance policy should be cared, eg., one SCX task can be
> boosted to REAL-TIME while holding a mutex lock, and then restored while
> releasing the lock. The value cpu_released is fixed when changing the
> sched class of the running task.
> 
> Signed-off-by: Wenfang Liu liuwenfang@honor.com
> ---
>  kernel/sched/ext.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index ddf4bd060..e3b9032e2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3899,11 +3899,30 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>  
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
>  {
> +	if (task_current(rq, p))
> +		switch_class(rq, p);

switch_class() should probably be named to something more specific - e.g.
maybe_cpu_release()?

>  	scx_ops_disable_task(p);
>  }
>  
>  static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
> -static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
> +static void switched_to_scx(struct rq *rq, struct task_struct *p)
> +{
> +	lockdep_assert_rq_held(rq);
> +
> +	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
> +	    unlikely(rq->scx.cpu_released) && task_current(rq, p)) {
> +		/*
> +		 * If the previous sched_class for the current CPU was not SCX,
> +		 * notify the BPF scheduler that it again has control of the
> +		 * core. This callback complements ->cpu_release(), which is
> +		 * emitted in switch_class().
> +		 */
> +		if (SCX_HAS_OP(cpu_acquire))
> +			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, rq, cpu_of(rq), NULL);
> +		rq->scx.cpu_released = false;
> +	}
> +}

and most of this can be factored into e.g. maybe_cpu_acquire() so that the
same code is not duplicated between here and balance_one()?

Also, please target the for-6.17-fixes branch of the sched_ext tree.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-6.17-fixes

Thank you.

-- 
tejun

