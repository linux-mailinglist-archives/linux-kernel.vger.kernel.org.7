Return-Path: <linux-kernel+bounces-852369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C5BD8C78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE241924873
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0C2F28FF;
	Tue, 14 Oct 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ccgx28eL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1722C0F87
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438090; cv=none; b=lVWeR/AEKjyKGR3pozrGizcuvy81d7C2ET+aIAxnlXFpB33o4ItX55h8B4u5rqoNyAlzCnLpaiYtz8Qh5LnzYhwHsavE9OmuZVifXJHNoTpFMC4gmWyCJYpcurLDPF1UViVaW3WnmNpawII1owO9owCpXPIwOmm28ZOR+Fvb2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438090; c=relaxed/simple;
	bh=r0ma43gIJEny3CjklQrv4kJsylnr+QHBfZoc8biNriA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJqpZ8cRmqCdi5LaVLux/GBwYaQCC3JwWArkywqvjgtUpB6ym8nJKe6hRWQyrxS+VvQrW33A+0tTUgEhqpC8hb1lx3zNYzghAiB8rdfhw4moFQW7reFmWCZ+BYydBuSFV+Y17irQRTxfBRbPR01TEK9ggwbpbsP1GM9srNT2oEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ccgx28eL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F1aeRgrBQkqCV5E89mAXaSfnx3KEktryo+h5xvr8hVQ=; b=Ccgx28eLZFlO8pqqk3rAnjakSr
	tAXrBNT88WcsHJkekw49MRA4QM+OFZ8rYhZchh6ZFnrPzHBi/H48Xi9ggkczJzaEMe+Qyt1ESk2Ri
	26KpS2r+lXpQwRPwPc79QmIfTxYWxTo3mBJ70evHU0y0PX0eNNsCzVzJytU0Oioz4pj9kaqNahcgz
	8tNUZfN/Mn+sXUE4Tm41HNjKX5QHt2tbErJw+J/Dm3q/vFVvmtN9ybErDcsVOwJzguJVv9+U9C46Q
	0cakSnTNNSrBIv4FQxo8wUQ2eSOzrs7i6Cn8EwiHWEJFaC8LODHK4cD4Gr3/Pi+CEIf+cEa+LHxb7
	RYGArLsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8cMY-00000008tuL-2KgX;
	Tue, 14 Oct 2025 10:34:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38E40300212; Tue, 14 Oct 2025 12:34:39 +0200 (CEST)
Date: Tue, 14 Oct 2025 12:34:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Breno Leitao <leitao@debian.org>,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org, Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
Message-ID: <20251014103439.GU3245006@noisy.programming.kicks-ass.net>
References: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
 <v3zyf7pp64yd4kakqniq4thjf2egb3kavkwzgoqt6ye5cuqkys@jmkcwst6lrn2>
 <67e75a68-7a03-46bb-ae40-b1a8f24c0b16@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e75a68-7a03-46bb-ae40-b1a8f24c0b16@suse.cz>

On Tue, Oct 14, 2025 at 12:13:23PM +0200, Vlastimil Babka wrote:
> On 10/14/25 11:56, Breno Leitao wrote:
> > On Thu, Oct 09, 2025 at 07:48:18PM +0000, Kriish Sharma wrote:
> >> The variable 'cpumask' in mm_cid_get() was assigned but never used,
> >> causing the following build error with -Werror:
> >> 
> >> kernel/sched/sched.h: In function ‘mm_cid_get’:
> >> kernel/sched/sched.h:3743:25: error: variable ‘cpumask’ set but not used [-Werror=unused-but-set-variable]
> >>  3743 |         struct cpumask *cpumask;
> >>       |                         ^~~~~~~
> > 
> > Thanks for the fix. I am hitting the same issue in my builds.
> 
> Let me add why this years old small issue became much more problematic in
> 6.18-rc1. When I want to test my own files I'm developing on with e.g. "make
> W=1 mm/slub.o", the W=1 hits earlier in:
> 
>   CC      kernel/sched/rq-offsets.s
> In file included from kernel/sched/rq-offsets.c:5:
> kernel/sched/sched.h:3718:18: error: variable 'cpumask' set but not used
> [-Werror,-Wunused-but-set-variable]
>  3718 |         struct cpumask *cpumask;
>       |                         ^
> 1 error generated.
> make[2]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1
> 
> So I can't get to the part where I test-compile my own code with W=1. So
> fixing this ASAP in 6.18 would be appreciated, thanks!
> 
> FWIW I've bisected this to commit
> 378b7708194f ("sched: Make migrate_{en,dis}able() inline")

People using W=1 and WERROR can keep the pieces. Anyway, this is a much
more coherent explanation that the original patch.

