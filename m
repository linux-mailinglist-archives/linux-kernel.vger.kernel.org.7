Return-Path: <linux-kernel+bounces-893337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE1C471B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3313B7763
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A453126C4;
	Mon, 10 Nov 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5qNsVdI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5C22256B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783846; cv=none; b=Vx8IdGAlH67GHK2p9Px/gE3ZDC/gIGSyZ6GUM4pUmEtddEmlB7cJO15KLdPy8FMDYmY18WuYIx9h2KgLFKvSFzBy0av1YyV6UmIpwd3qxS0VjHsBHPBgQ+Z92DE/bsGFWnHJX7v3Ll166oj6I3rz8+SB7Xr9L94QRLiKLvElfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783846; c=relaxed/simple;
	bh=3p3wxwpNQ/XmLtrgoywAByK8BSTifSyOSRCHIwf9xCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxhG1+kxx7ye4jqc0JoQ9ICkqAdhDkZFjGy+N1TiFG3GcfHLxLqW0xYEOlAlgiAfvdsbaKXjbONdHdjUMpFZKv6z+luGHPbGiLI0Uw63/Dn1ZSG+fIugxLUJdLLvfrhW6FzYPWQfOVC6e6SfcfOSHTJpBQDV7zCnCGCIfCVGNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e5qNsVdI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Oj38Gi0UFuIHYGsRMjwElP/HvTM4cjf4iJtSTOb1cZ8=; b=e5qNsVdI3XBU6UDG8g5e+oThIc
	fDFVybsx95fUFAGC3gDmEdQ6jCejtUoTVOU2MC4c92KswFHZjIBZy7l1UYPrTIz9l63nZYBv8+hAY
	xiRQkVwTcGDuu52C3H9gV4N3JWeIhzmO07Nxzl1prCdOCVOOZwQN6jj7ictukIE0w1cGKueaMz7th
	f9ayaieJ2KBqxJN5ySWuc8IeqxdAzS/NFEurUjfpeYIGrwJSY2sHAKxtwCTZj5TS0+rEDtti4EeYK
	34BwFRRraplqZLjNKs920U0OyA8omkAjkNdcItl9h3uzrZhb430vuunjsTDQEDwrFU0XUc2qkuLjJ
	ebd3P+pg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIRjj-0000000AqRv-2SPM;
	Mon, 10 Nov 2025 13:15:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60F9230029E; Mon, 10 Nov 2025 15:10:38 +0100 (CET)
Date: Mon, 10 Nov 2025 15:10:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: juri.lelli@redhat.com, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, nico@fluxnic.net
Subject: Re: [PATCH 1/2] sched/deadline: minor code cleanups
Message-ID: <20251110141038.GY3245006@noisy.programming.kicks-ass.net>
References: <20251014100342.978936-1-sshegde@linux.ibm.com>
 <20251014100342.978936-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014100342.978936-2-sshegde@linux.ibm.com>

On Tue, Oct 14, 2025 at 03:33:41PM +0530, Shrikanth Hegde wrote:
> - In dl_server_timer, there is same dl_runtime check above. So
> this check is duplicate. This could save a few cycles.
> 
> - In select_task_rq_dl, there is only one goto statement, there is
> no need for it. 
> 
> No functional changes.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/deadline.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 7b7671060bf9..8b7c4ee41fd8 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1166,9 +1166,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
>  		sched_clock_tick();
>  		update_rq_clock(rq);
>  
> -		if (!dl_se->dl_runtime)
> -			return HRTIMER_NORESTART;
> -
>  		if (dl_se->dl_defer_armed) {
>  			/*
>  			 * First check if the server could consume runtime in background.

That one got lost here:

  https://lkml.kernel.org/r/20251020141130.GJ3245006@noisy.programming.kicks-ass.net

> @@ -2173,7 +2170,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
>  	struct rq *rq;
>  
>  	if (!(flags & WF_TTWU))
> -		goto out;
> +		return cpu;
>  
>  	rq = cpu_rq(cpu);
>  
> @@ -2211,7 +2208,6 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
>  	}
>  	rcu_read_unlock();
>  
> -out:
>  	return cpu;
>  }

And this is completely different code, which would suggest it ought to
have been a separate patch.

But yeah, that makes sense.

