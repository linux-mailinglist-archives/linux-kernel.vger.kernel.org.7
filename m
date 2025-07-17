Return-Path: <linux-kernel+bounces-736006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6AB09688
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946131899826
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD3C238142;
	Thu, 17 Jul 2025 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxDPC3P/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA64237173
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788903; cv=none; b=S+317P1nGnGxiEvfICvy95Irsw3lRNtyBuaELKdeTPEwS4JvJ12HKfU7fsq+DmWS2LcFVNNMrfpdWdGmSHbQdc+bdnUvQggS5f8tjFtwOgVziP1kKdFJ894dfB25GK4XTEUUlJVYiu1bCWkiY/15T/Qj3xpO2bEeQWGpuJEalfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788903; c=relaxed/simple;
	bh=KFu/f4mb35n+OCQZznsVjFhv7QmBQ0nFhjam9YEqwIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfkXThF1a3EXrB4nGEFWAUzG9IY3aJ9oU80ysCK3qeNYhvwudIyTo3EaBva5iFA9H59l9389iGKW6U8LOIdUXTK1bJ4LUP+xeMHeOuFCKutNrx1ecpgsTIhsVS3Q6ik2Pv5HIpiJSYFKjqQehHtDFGsKeDu+Rst0+rvcA6EhMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxDPC3P/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64C9C4CEE3;
	Thu, 17 Jul 2025 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752788903;
	bh=KFu/f4mb35n+OCQZznsVjFhv7QmBQ0nFhjam9YEqwIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxDPC3P/gOTXNTRrGpD5sZ3TpjXo/Ulo+bK0Ygi7VHBrgKHcDPwBHSlIqbJLaN+L2
	 itUjotfgDbux1HtHnfdVQJ9A643KOa3dyuVaW0mOTBONLJby8KI/c9BSsRMjtkpIS5
	 mcF8Zy++3QGK8tNRSyptIRZPkTT9bcHuFei5YoG6FN3zMhHhOadJ6JX1GuQoI4aYbZ
	 gWoXlaQYgeSOw/WZwIjoaLOVoeButLNwwkhWxJ9n60faJZfZc5gU3npBIGqX9iZzRL
	 YvgnYwJ/rAp7pgn9tHKYRNovFJoRK0YZj17H6qM4QR2/aaUeFj/tpVu5idwK7nEIwM
	 042nDHNtmB51A==
Date: Thu, 17 Jul 2025 11:48:21 -1000
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
Subject: Re: [PATCH v2 2/2] sched_ext: Fix cpu_released while changing sched
 policy of the running task
Message-ID: <aHlvpRIcymNPPWh9@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>

Hello,

On Sat, Jun 28, 2025 at 07:20:59AM +0000, liuwenfang wrote:
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
>  {
> +	switch_class(rq, p, true);
> +
>  	scx_ops_disable_task(p);
>  }

Hmm... but this function can be called when @p is not currently running from
setscheduler() path, and it wouldn't make sense to call switch_class()
during that.

>  static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
> -static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
> +static void switched_to_scx(struct rq *rq, struct task_struct *p)
> +{
> +	lockdep_assert_rq_held(rq);
> +
> +	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
> +	    unlikely(rq->scx.cpu_released)) {
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

Ditto. This should only apply if @p is current, right?

Thanks.

-- 
tejun

