Return-Path: <linux-kernel+bounces-763748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6FB219D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E6B7AF6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E752D3A7D;
	Tue, 12 Aug 2025 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuLS0Ega"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1A2701B6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958654; cv=none; b=meLe0U+uXVOCmQ0zv48EzDWtAPsISMozUcX5LLluwJHKhc3gysn6WWdc12BysZAPJIYnXF6HsHSCTm+JqF5pR7WGIrS8wWBpct6Wm5YUuzu8FQ9ivWLN5qqrBa2NMFgJZ29nhtm7pfuANPqt51MW+wx3bNEjjdnVpIuYW8uDGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958654; c=relaxed/simple;
	bh=pk2PnBt1vF1GB3w+u2ULLw4ZeWLajXkns8BiAoAPAO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtdD3R8GdwNeAKTBQ/q+lDQyX+D52KYjfM4R+jDj1dWY+GtzOq93fh/g/w+fToH0QHi+G2BNr8eaWLsPkm+6ThJyiTtgwdAhn1nfHTN4lXTvqqDaj3GKMvkKcfP1cBInSQEoRbYuvvzlcXoXXCuRifPd8qN/wqJpBo8pj+u59fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuLS0Ega; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11886C4CEF6;
	Tue, 12 Aug 2025 00:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754958654;
	bh=pk2PnBt1vF1GB3w+u2ULLw4ZeWLajXkns8BiAoAPAO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuLS0EgaaZrDFtyM/zjsYmw6hak01e3EPFuFrNY5hqMSvB+gj/vYkdM2FMsn9OHk0
	 vebffKDOWZf2kffQ3MH6i+uEQwIpZSeGa53lFFRMxx9ICBG29s6cYQwjgdSZH7/Bpr
	 y39JTD3dzDUWlT0zLakyw1qs9N31iQiCOPoz3m4PsDrUOC7m2cijCqIFSSsyagmtx2
	 oW2POoct/Av2snNEwQ7tiQ/U90bziF8wWb85VF2s7XX+m7tC6D+hytRgLYm2MMti1Q
	 a0c69/2WmsPU/IExyzE1EwKbW6enFEoLUy1yYlsyoIOzPFrmnFnCuTRP35ckPJ0keg
	 QQqAq5AamQA2g==
Date: Mon, 11 Aug 2025 14:30:52 -1000
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
Subject: Re: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Message-ID: <aJqLPLxpNgKWbFmu@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
 <46cef95e02d64b35a9d9d51d5debee22@honor.com>
 <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
 <aJqExL-CjemhWfqB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJqExL-CjemhWfqB@slm.duckdns.org>

Hello,

On Mon, Aug 11, 2025 at 02:03:16PM -1000, 'Tejun Heo' wrote:
...
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0fb9bf995..50d757e92 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8887,6 +8887,9 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
> >  
> >  	__put_prev_set_next_dl_server(rq, prev, p);
> >  
> > +	if (scx_enabled())
> > +		scx_put_prev_set_next(rq, prev, p);
> > +
> >  	/*
> >  	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
> >  	 * likely that a next task is from the same cgroup as the current.
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 47972f34e..bcb7f175c 100644
> > @@ -2465,6 +2470,9 @@ static inline void put_prev_set_next_task(struct rq *rq,
> >  
> >  	__put_prev_set_next_dl_server(rq, prev, next);
> >  
> > +	if (scx_enabled())
> > +		scx_put_prev_set_next(rq, prev, next);
> > +
> >  	if (next == prev)
> >  		return;
> 
> I'm not sure these are the best spots to call this function. How about
> putting it in the CONFIG_SCHED_CLASS_EXT section in prev_balance()? The goal
> of the seq counter is to wait for scheduler path to be entered, so that's
> good enough a spot and there already is scx specific section, so it doesn't
> add too much noise.

Strike that. I see that we need a hook after task is picked to resolve the
bug around cpu_released. Can you please move scx_enabled() test into
scx_put_prev_set_next() and add a helper which calls both
__put_prev_set_next_dl_server() and scx_put_prev_set_next() so that the call
doesn't have to be added to two places?

Thanks.

-- 
tejun

