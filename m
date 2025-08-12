Return-Path: <linux-kernel+bounces-763772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8FB21A25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F071A20C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D752D8781;
	Tue, 12 Aug 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxlEZ12X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99CF22332E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961968; cv=none; b=jwrv1sBImBUi9i8VFrf+FsPt85rrjrHMBdHaKxLp1NJWUn9RLoQkzulxaf5aqVrHSJM8qlsqSdZviTMPvnsAUkdNBzBzReuF359o+XI95JcIOB8hGvHkuKz3f+N3qgkfdn7PkSOOB9CvG7xlYJnrKDIlyJd4wB6AWKRNWKIQakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961968; c=relaxed/simple;
	bh=0S7dwP5Sj3ULEgzSCA6+rFT7RmHRIuRUrVuwfbQpSdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do0m8Uy1q5V94Pm2WezPpcB6tRvJyHFYx9nUQpNoYBy0ODi7ted2EJI8uN6cXsJKce2nFrEz+S+tue81JsNaHrRGBTcNMcjGv9u1MUOkA/h0KFoJoitN5Dk7XF15Vx9Fq/NRypZskBEEXOT/1r6esAPPFwW2bGO0mXHxtTCjC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxlEZ12X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F05C4CEED;
	Tue, 12 Aug 2025 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754961968;
	bh=0S7dwP5Sj3ULEgzSCA6+rFT7RmHRIuRUrVuwfbQpSdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxlEZ12XWm8GIZpqGWC6bfAW2aJEOt+JazH4BV0Lu18N1cmsISqlO0A1jNi2n5OmZ
	 pUXi58AEsELUU/0cVmBSQuXkn5j8BbFuekV2HtvCkjTEst4/azDDDv3orJdlbNXfn3
	 uSvXj48bAQ5HG/MOgZPESzLc3uOJmMCPGjemGEemFnBT/ZWkgWbKcxcfn7cGAwGFA9
	 +cnuYlL0MMswCALQBpxVNxavBHDBMjxxofH8qOQLBWqbhZO6VqzFZG6os4bYmRq7+E
	 Ei0SRKdD1lb7I7NNPmvsGJy8i+eiEH/LYJILV/704o/53R+mNUO7iMmjIrOkhW/3aj
	 T+wOHgx/FH3PQ==
Date: Mon, 11 Aug 2025 15:26:07 -1000
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
Subject: Re: [PATCH v3 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Message-ID: <aJqYL1mq8G8wMJes@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <ea7ad66c0e6140979ce941189f5a93cc@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7ad66c0e6140979ce941189f5a93cc@honor.com>

On Sun, Jul 20, 2025 at 09:38:50AM +0000, liuwenfang wrote:
> Supposed RT task(RT1) is running on CPU0 and RT task(RT2) is awakened on CPU1,
> RT1 becomes sleep and SCX task(SCX1) will be dispatched to CPU0, RT2 will be
> placed on CPU0:
> 
> CPU0(schedule)                                     CPU1(try_to_wake_up)
> set_current_state(TASK_INTERRUPTIBLE)              try_to_wake_up # RT2
> __schedule                                           select_task_rq # CPU0 is selected
> LOCK rq(0)->lock # lock CPU0 rq                        ttwu_queue
>   deactivate_task # RT1                                  LOCK rq(0)->lock # busy waiting
>     pick_next_task # no more RT tasks on rq                 |
>       prev_balance                                          |
>         balance_scx                                         |
>           balance_one                                       |
>             rq->scx.cpu_released = false;                   |
>               consume_global_dsq                            |
>                 consume_dispatch_q                          |
>                   consume_remote_task                       |
>                     UNLOCK rq(0)->lock                      V
>                                                          LOCK rq(0)->lock # succ
>                     deactivate_task # SCX1               ttwu_do_activate
>                     LOCK rq(0)->lock # busy waiting      activate_task # RT2 equeued
>                        |                                 UNLOCK rq(0)->lock
>                        V
>                     LOCK rq(0)->lock # succ
>                     activate_task # SCX1
>       pick_task # RT2 is picked
>       put_prev_set_next_task # prev is RT1, next is RT2, rq->scx.cpu_released = false;
> UNLOCK rq(0)->lock
> 
> At last, RT2 will be running on CPU0 with rq->scx.cpu_released being false!

It'd be better to describe the result of this - ie. cpu_release() /
cpu_acquire() calls being missed.

Thanks.

-- 
tejun

