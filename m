Return-Path: <linux-kernel+bounces-727645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B0EB01D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3DFA43C92
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74352D3747;
	Fri, 11 Jul 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h3LjkIH/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAA3A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240615; cv=none; b=sZxLufpIt4/4a3WfmwwQcpYFl/wLmCIc9HRK4Gj/yIChIqHXiBG+IK4gfAVdn7F18FU+4dJRgvhE8UoWX/kGTirK39Eqmt19nJu1mnN3lQdL0NNKGocILbUCnshJIJYnmSF5B02FCfQeGUD6quaULWhk5iqCUXE1nnILKwny8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240615; c=relaxed/simple;
	bh=NALJA9tLYinoQWUIjchNdsnTGOYWXZZVsdJNJs2qfhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msy1gWsRuWY63FAI1hfB9A+TWbxOwkDtjx2kJ3uRhr/M7M15zsEEjDXpf+BtKUSD4eGoU13091RHFctvwkbjtO/rVNQUj3den/X/5l58X8jc4ojbR7LHCXAn7puT6RCIfmvylN2XWkkaN7WfGtCYDBlmmgIoBImbSianJPHsObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h3LjkIH/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LF6lm7aBBAfk0wCQ1pvywRLLvXoTlrBZLSCuRZkY3sY=; b=h3LjkIH/NUD9kjhM6kcq+qEizl
	megYEgxzrswWdMTcpH5Aai25hWcOpf3vg/IYMEs2A4TJ5ePWm51Sy8bZeLJXMe+B4I1kGW6/CWvTn
	zzZLP5EAQ7xYp02O8x2zlx4wDzTFgsyaSdM5HKL08LEyDGuElBoiylq3PLkXvbcOZK1p5khajcBwo
	637lgkYOiLAjiBua4Z6Jq9uXxoPLy9RRgcrJQ3kG1qjhkQU0pK6fMcGOn/irb2+HAjbcaLfjtLCo3
	0hRk//5CZsIuXlxV6qwjN5rvKg311g2JUinZZ79jTp1P3nwEISfHSXeknUaxjHwdu6/BD3+KdzEcM
	BiuSmRSQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaDpD-0000000D8Hv-3g7C;
	Fri, 11 Jul 2025 13:30:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6C7A530023C; Fri, 11 Jul 2025 15:30:03 +0200 (CEST)
Date: Fri, 11 Jul 2025 15:30:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RESEND][PATCH v18 6/8] sched: Add an initial sketch of the
 find_proxy_task() function
Message-ID: <20250711133003.GH905792@noisy.programming.kicks-ass.net>
References: <20250707204409.1028494-1-jstultz@google.com>
 <20250707204409.1028494-7-jstultz@google.com>
 <20250710100206.GI1613376@noisy.programming.kicks-ass.net>
 <CANDhNCoMvY0s0AyePNouWqxdRpXCYJE=28E_b8RdmJ_2px_OBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCoMvY0s0AyePNouWqxdRpXCYJE=28E_b8RdmJ_2px_OBA@mail.gmail.com>

On Thu, Jul 10, 2025 at 05:43:36PM -0700, John Stultz wrote:

> > > @@ -6648,6 +6652,89 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
> > >       return true;
> > >  }
> > >
> > > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > > +static inline struct task_struct *proxy_resched_idle(struct rq *rq)
> > > +{
> > > +     put_prev_set_next_task(rq, rq->donor, rq->idle);
> > > +     rq_set_donor(rq, rq->idle);
> > > +     set_tsk_need_resched(rq->idle);
> > > +     return rq->idle;
> > > +}
> >
> > Nothing cares about the return value.
> 
> Well, nothing in this patch, but the last patch in this series I sent
> here uses it.  But if you think it makes the series easier to grok and
> I can drop it here and add the return in that later patch.

I found it in the later patch; I meant to reply here, but promptly
forgot. It can stay here I suppose, no harm done.

