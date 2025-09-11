Return-Path: <linux-kernel+bounces-811971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68EB5310E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB431C8455A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272A3375AA;
	Thu, 11 Sep 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gC6zRqT/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688AC33438D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590678; cv=none; b=P7al5I7/b3zL+B1EPWJdMuUFD0+rP15a/gT73hgAqE68HBFlEeedXEgtYuU9xBXFAs9szMyjjyj52Si37egZ4BQXZ4k0/UjMxqXd2l2USkP6a5Hxdq2nnNZoaiGp4IAnAqGlbFDTQYgVEsB7ZMkOibkjNLQSEoVS2jTyqtWHIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590678; c=relaxed/simple;
	bh=GNFr34R7rej45ssdHKM1DXp7hmxvIRT4IOH0+shk3Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/aXA65ULRz4YkofzMu1D2Bog5RkBGs7c0Do8tjih+Bvz3drWexO2wZAjNqOvV50hBd4qepBIjGd2mc8yL9c5P2nvWwDDlCovdbeec7uDMhK7Z3oM95sXsfJK8TuQ3Xibz5TifVuRmvFlhNi3CusFbuS/aan6HXsHsyY0D0RfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gC6zRqT/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vb4npP54T1KcXZKWzVGoONGakfBAiuQeQvLs4VeRip0=; b=gC6zRqT/BDIlTDZ+BSA7B82hfO
	LxFUbFCVy5Ac0LSuHeUO4h0U88oSWLr7Yvv/rCS7CrYWBqESxG+x2MG+DgyniUshEz6Wehh6Z7KwV
	co2xtQIJxpyEWkFzoy3jiKikZB3JoSnZ1SPzwC7siOr45YBgUEGCMl1irANAyLaeBabfTWXdho8EI
	mKpHfKc0xbZmWbBSahbdrG8Bhp/+HMD8MhORBO+LXxkbVBnjYAzH24Gda1ZNIDysQM9shkrQ1katk
	sOAHcdGuwzB3bjZb9y7yFn8qAYCuaLI5D2kUtu6VZvqnKFxbKCpV0eMOj35LtT62VlEI9esR/jdJo
	ogFjtsmQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfcZ-0000000A3oN-3fWI;
	Thu, 11 Sep 2025 11:37:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B59C73002EB; Thu, 11 Sep 2025 13:37:46 +0200 (CEST)
Date: Thu, 11 Sep 2025 13:37:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, bsegall@google.com, graf@amazon.com,
	wangtao554@huawei.com, tanghui20@huawei.com, zhangqiao22@huawei.com,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH RESEND] sched/fair: Only increment deadline once on yield
Message-ID: <20250911113746.GO4067720@noisy.programming.kicks-ass.net>
References: <20250911095113.203439-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911095113.203439-1-sieberf@amazon.com>

On Thu, Sep 11, 2025 at 11:51:13AM +0200, Fernand Sieber wrote:
> If a task yields, the scheduler may decide to pick it again. The task in
> turn may decide to yield immediately or shortly after, leading to a tight
> loop of yields.
> 
> If there's another runnable task as this point, the deadline will be
> increased by the slice at each loop. This can cause the deadline to runaway
> pretty quickly, and subsequent elevated run delays later on as the task
> doesn't get picked again. The reason the scheduler can pick the same task
> again and again despite its deadline increasing is because it may be the
> only eligible task at that point.
> 
> Fix this by updating the deadline only to one slice ahead.
> 
> Note, we might want to consider iterating on the implementation of yield as
> follow up:
> * the yielding task could be forfeiting its remaining slice by
>   incrementing its vruntime correspondingly

This..

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..d6a0d22d08d7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8921,7 +8921,7 @@ static void yield_task_fair(struct rq *rq)
>  	 */
>  	rq_clock_skip_update(rq);
> 
> -	se->deadline += calc_delta_fair(se->slice, se);
> +	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);

Have you tried:

	se->vruntime = se->deadline;
	se->deadline += calc_delta_fair(se->slice, se);

instead?

