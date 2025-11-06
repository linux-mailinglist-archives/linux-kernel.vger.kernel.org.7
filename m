Return-Path: <linux-kernel+bounces-888318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F09EC3A7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5EA3BE606
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF52E2EF9;
	Thu,  6 Nov 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hdhsf/6h"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED23261B8F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427399; cv=none; b=sqS7CAjiN2Dcc9vRp8M98LJLuwq9tKYC9PPJoHmZzFcpQjqtcacAP0o0l1YrRaKNNKL1/e2KDLs1DHBzLC4gJrw6SneOVLwj2V7X6yOEtIVI6kbHaD4tTgQNMCkMjMCLGZB8H/kKkH5kB3Nu7NT9ioEip5LMJ/d5UMCcqbqKNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427399; c=relaxed/simple;
	bh=tCy8VqKGG7CXvtSa8wxpteUDjxac13mnYPBFpl4pMo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM4fK1/H+2jYc/AmcYR+37Gj3IzwejFda5oktdIcBs7odLbuZjzGAMBwwWweutjpo6wpqWvdKgda+3VVmnIlFSYUhhTaipazpKsUZYagPY1BUTGe0TGinW0rErmudkbfWCNQSgDycLvUFzpDXO60XgGbvWzk/LH1JQi8Xh2pfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hdhsf/6h; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RDYkIHMMLGYhCdnLDe34F4CZJjKtUlSQdL0+EHv7sF0=; b=Hdhsf/6hjbVGkg8ij6s5Ft6v8V
	N6n4/1AvEJIDJiK6fdFEaLAZOU+USYTrC9k2fYZo67O/5I370CbR/WEfiEbPyy1jmHWLC5/GTPFT9
	CUTvixH/hgibKt7AW+5wN8IWMau+XuVomb8qN+eWxItGiUwUVsfCcEN9GgkVccwr5oCHViNQBKgIJ
	3ubhimQ/rwftE4Ll7mhqKlKyjEgR6OoneCIyNlg9EgNMpeydDy994o3v4qp4gMHAG/oW5pGAyvO8F
	ruXCQ9KyLz4V/G5Qt+a1Tfu2xSuz6qaKKVikgfwkETZYAsWvLaQ0CJEei4UzIkIoqs3ZqDp9Qj/20
	ioDJGv6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGx0R-000000045oi-1EZ1;
	Thu, 06 Nov 2025 10:14:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8D0330049A; Thu, 06 Nov 2025 12:09:43 +0100 (CET)
Date: Thu, 6 Nov 2025 12:09:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Fernand Sieber <sieberf@amazon.com>, mingo@redhat.com,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, dwmw@amazon.co.uk,
	jschoenh@amazon.de, liuyuxua@amazon.com
Subject: Re: [PATCH] sched: Optimize core cookie matching check
Message-ID: <20251106110943.GP3245006@noisy.programming.kicks-ass.net>
References: <20251105152538.470586-1-sieberf@amazon.com>
 <f7169de1-76f4-4bde-8d9a-cc62b7e3157a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7169de1-76f4-4bde-8d9a-cc62b7e3157a@amd.com>

On Wed, Nov 05, 2025 at 10:04:01PM +0530, K Prateek Nayak wrote:
> Hello Fernand,
> 
> On 11/5/2025 8:55 PM, Fernand Sieber wrote:
> > Early return true if the core cookie matches. This avoids the SMT mask
> > loop to check for an idle core, which might be more expensive on wide
> > platforms.
> > 
> > Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> > ---
> >  kernel/sched/sched.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index adfb6e3409d7..381cd561e99b 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1432,6 +1432,9 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> >  	if (!sched_core_enabled(rq))
> >  		return true;
> >  
> > +	if (rq->core->core_cookie == p->core_cookie)
> > +		return true;
> 
> nit. We can use sched_cpu_cookie_match(rq, p) to check for the
> above two conditions. but even this is good.
> 
> Apart from that, I think this optimization makes sense.
> 
> > +
> >  	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> >  		if (!available_idle_cpu(cpu)) {
> >  			idle_core = false;
> > @@ -1443,7 +1446,7 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> >  	 * A CPU in an idle core is always the best choice for tasks with
> >  	 * cookies.
> >  	 */
> > -	return idle_core || rq->core->core_cookie == p->core_cookie;
> > +	return idle_core;
> 
> Peter, do we care about checking the core_cookie again before
> returning just in case the task cookie was selected between the
> check above an here?

I don't think it really matters, but someone what runs this stuff would
probably know better than me ;-)

> If not, then this looks good to me. Feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks all!

