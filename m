Return-Path: <linux-kernel+bounces-723644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E94AFE973
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6928F1C45B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3692DA765;
	Wed,  9 Jul 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOa2dc2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804322DFB6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065681; cv=none; b=dbu0Z0nw9sIJyWbTbLwGWUbpKx9+49dXQNClPlDaoEqY6ceNSU9IiGx5ioIbPiUY4blGNbZQeDYo/ka2ESOdyPNXqZYp+pQBlgpWngFWrk/nzl/zOtskigKnfjzYT51+mrD4eKjnaEF/6bok+YDlpa4vIpYwpcAc/l97Rc0lLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065681; c=relaxed/simple;
	bh=b/RWoSHb/J71wHvRhKcVkvuPaskkswkGyzbQoI+8wHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s097K8+gtwq9SYH9DrAV0rzAw6FT5LBSJehbcQlWu+gnnFgmRhtxJveWiVMV9gQCMwmSWowVG9y9VSglpXKzUDvu7JkB79GzE9WaDIVyUsNvQjaEohJGPlYOaGp+pyYH8r8T5UvS/0xVkV8Y/ULFEyY3KoJ/9K4QjgfuvO5oXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOa2dc2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F18C4CEEF;
	Wed,  9 Jul 2025 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065680;
	bh=b/RWoSHb/J71wHvRhKcVkvuPaskkswkGyzbQoI+8wHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOa2dc2udWdpo24DRb1Y8xv41+b82P879mR6Ng2s7UySpkMHOG04ZmihgwCgZrLoL
	 0QegvxSpPY3K6+eF/LseV8DRpfaTv/DXkmITuC3/zcwwHqHffiS2mYlQISkznTNB7n
	 WQ7NCEF7IROHCl3pY84gk6G+Y8Yzswgc9HEGQ61OrhTurJ372Ji6skGhr7ijmlmDEx
	 hHvfomeXNOzOTywORgbuFYEcA7gRR7zPLr7f4goG53e1h3GGb9SBLoz0vXSJpcOr91
	 SFxw3KAyK3guCTSLRGtEEuofCEfnLNkvNkn1lUdpqh12/eofry0D/SYuQMZWtyAknV
	 mTOMR5/oIyIdA==
Date: Wed, 9 Jul 2025 14:54:37 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: anna-maria@linutronix.de, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, xiexiuqi@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [PATCH] hrtimers: Update new CPU's next event in
 hrtimers_cpu_dying()
Message-ID: <aG5mjYxTVRovIETd@localhost.localdomain>
References: <20250708101727.166892-1-wangxiongfeng2@huawei.com>
 <aG0RxASJqknbaUkM@localhost.localdomain>
 <cb65f989-eb16-f2d0-3a58-32deb3f65fb8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb65f989-eb16-f2d0-3a58-32deb3f65fb8@huawei.com>

Le Wed, Jul 09, 2025 at 11:18:14AM +0800, Xiongfeng Wang a écrit :
> Hi Frederic,
> 
> On 2025/7/8 20:40, Frederic Weisbecker wrote:
> > Le Tue, Jul 08, 2025 at 06:17:27PM +0800, Xiongfeng Wang a écrit :
> >> When testing softirq based hrtimers on an ARM32 board, with high
> >> resolution mode and nohz are both inactive, softirq based hrtimers
> >> failed to trigger when moved away from an offline CPU. The flowpath
> >> is as follows.
> >>
> >> CPU0				CPU1
> >> 				softirq based hrtimers are queued
> >> 				offline CPU1
> >> 				move hrtimers to CPU0 in hrtimers_cpu_dying()
> >> 				send IPI to CPU0 to retrigger next event
> >> 'softirq_expires_next' is KTIME_MAX
> >> call retrigger_next_event()
> >> highres and nohz is inactive,just return
> >> 'softirq_expires_next' is not updated
> >> hrtimer softirq is never triggered
> >>
> >> Some softirq based hrtimers are queued on CPU1. Then we offline CPU1.
> >> hrtimers_cpu_dying() moves hrtimers from CPU1 to CPU0, and then it send
> >> a IPI to CPU0 to let CPU0 call retrigger_next_event(). But high
> >> resolution mode and nohz are both inactive. So retrigger_next_event()
> >> just returned. 'softirq_expires_next' is never updated and remains
> >> KTIME_MAX. So hrtimer softirq is never raised.
> >>
> >> To fix this issue, we call hrtimer_update_next_event() in
> >> hrtimers_cpu_dying() to update 'softirq_expires_next' for the new CPU.
> >> It also update hardirq hrtimer's next event, but it should have no bad
> >> effect.
> >>
> >> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> >> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >> ---
> >>  kernel/time/hrtimer.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> >> index 30899a8cc52c..ff97eb36c116 100644
> >> --- a/kernel/time/hrtimer.c
> >> +++ b/kernel/time/hrtimer.c
> >> @@ -2298,8 +2298,11 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
> >>  	/*
> >>  	 * The migration might have changed the first expiring softirq
> >>  	 * timer on this CPU. Update it.
> >> +	 * We also need to update 'softirq_expires_next' here, because it will
> >> +	 * not be updated in retrigger_next_event() if high resolution mode
> >> +	 * and nohz are both inactive.
> >>  	 */
> >> -	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
> >> +	hrtimer_update_next_event(new_base);
> >>  	/* Tell the other CPU to retrigger the next event */
> >>  	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
> > 
> > It seems that a similar problem can happen while enqueueing a timer
> > from an offline CPU (see the call to smp_call_function_single_async()).
> > 
> > How about this (untested) instead? retrigger_next_event, is not a fast
> > path so we don't care about rare extra cost:
> 
> This modification can solve the problem. Thanks a lot.

Thanks! Feel free to send an updated version of the patch.

> > 
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> > index 30899a8cc52c..e8c479329282 100644
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -787,10 +787,10 @@ static void retrigger_next_event(void *arg)
> >  	 * of the next expiring timer is enough. The return from the SMP
> >  	 * function call will take care of the reprogramming in case the
> >  	 * CPU was in a NOHZ idle sleep.
> > +	 *
> > +	 * In periodic low resolution mode, the next softirq expiration
> > +	 * must also be updated.
> >  	 */
> > -	if (!hrtimer_hres_active(base) && !tick_nohz_active)
> > -		return;
> 
> Once we remove this check. The problem disappears.
> Also I noticed that we check whether highres is active before we really program
> the hardware in __hrtimer_reprogram(). So if the above check in
> retrigger_next_event() is just to decrease extra cost, I think we can remove
> it

I think it was also to remove extra base locking.

But then again, this is a slow path so this should be harmless.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

