Return-Path: <linux-kernel+bounces-801218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC3EB44245
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C424A45B53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6732FB63D;
	Thu,  4 Sep 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5N+iYyc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08762F8BD1;
	Thu,  4 Sep 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002094; cv=none; b=sWvnOCWpi9EEEaWdjRCDc+dFXwvyFXelva5p7mFYP2j2bSCO4lGdnHcTnoJYJrEwOnMPKOMm2L9ObSwi/vvCucRUNHACSFR2NHUQOERXa5bPwO7IGD41SV2mbjH3Z/JCBa4mAiD/umooovTc7png6/ZIeoIa53TFaewaHjciHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002094; c=relaxed/simple;
	bh=9CpHF3e779/0EiTNYs7BVku2HEp20J+MBisbKh39eq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roitekEEr2Pxqq75bMuPPi891zysxyT1cZGzJXdzGWAQIsxwU2/cp6hkXpBOCvYDocSU0e1jS5gz2nCl3AA6T24xE83iYtEeBrbxA98vp6D3LAdpOp2oTN7kd2XVgs0uY0/gbIlmGZLnJOJ13/S2d/OXayJ9hZYLArm3+TarjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5N+iYyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12938C4CEF6;
	Thu,  4 Sep 2025 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002093;
	bh=9CpHF3e779/0EiTNYs7BVku2HEp20J+MBisbKh39eq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5N+iYycovpeRk8V9xKnvZ3Up5BSP7TH+UEcPvEbYRnIUoYbTz0+JV23vqILN/sJp
	 uP+BnNP4/CA8ojS3aLAUdtlCVacVCNc8/IOt+E7tZmy8UslQe2Lj1ZjwDnonIA3+5z
	 gYGDElGWt35RV10wCsZ+ImVfgqY7FWT7Xv9MGYa8b5DncoULVsTb50Mf/V8p72r1P+
	 3mzSEPwLDgjpezuic7IGa5WJl0waTVeIdlOE8lzqhwk3LPXCIUl+xBY4eMFA38iamP
	 iPg3wVfxDHB8aXXGm3ow0QjYQ1Mr4rsREBKx5RBNSGwybAC3GawMDPzWtnwpspRrUy
	 ooeWA615kCotg==
Date: Thu, 4 Sep 2025 18:08:10 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/2] tick: Remove unreasonable detached state set in
 tick_shutdown()
Message-ID: <aLm5aodjygSZkN8j@localhost.localdomain>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
 <20250904071732.3513694-2-maobibo@loongson.cn>
 <87frd2xlat.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frd2xlat.ffs@tglx>

Le Thu, Sep 04, 2025 at 05:57:30PM +0200, Thomas Gleixner a écrit :
> On Thu, Sep 04 2025 at 15:17, Bibo Mao wrote:
> > Function clockevents_switch_state() will check whether it has already
> > switched to specified state, do nothing if it has.
> >
> > In function tick_shutdown(), it will set detached state at first and
> > call clockevents_switch_state() in clockevents_exchange_device(). The
> > function clockevents_switch_state() will do nothing since it is already
> > detached state. So the tick timer device will not be shutdown when CPU
> > is offline. In guest VM system, timer interrupt will prevent vCPU to
> > sleep if vCPU is hot removed.
> >
> > Here remove state set before calling clockevents_exchange_device(),
> > its state will be set in function clockevents_switch_state() if it
> > succeeds to do so.
> 
> This explanation is incomplete. tick_shutdown() did this because it was
> originally invoked on a life CPU and not on the outgoing CPU.

Ok I didn't know that.

> 
> That got changed in
> 
>   3b1596a21fbf ("clockevents: Shutdown and unregister current clockevents at CPUHP_AP_TICK_DYING")
> 
> which is the actual root cause.
> 
> The pile of 'Fixes:' below is just enumerating the subsequent problems.
> 
> > Fixes: bf9a001fb8e4 ("clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining")
> > Fixes: cd165ce8314f ("clocksource/drivers/qcom: Remove clockevents shutdown call on offlining")
> > Fixes: 30f8c70a85bc ("clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining")
> > Fixes: ba23b6c7f974 ("clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining")
> > Fixes: 15b810e0496e ("clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining")
> > Fixes: 78b5c2ca5f27 ("clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining")
> > Fixes: 900053d9eedf ("ARM: smp_twd: Remove clockevents shutdown call on
> > offlining")

Makes sense.

> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/time/tick-common.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> > index 9a3859443c04..eb9b777f5492 100644
> > --- a/kernel/time/tick-common.c
> > +++ b/kernel/time/tick-common.c
> > @@ -424,11 +424,6 @@ void tick_shutdown(unsigned int cpu)
> >  
> >  	td->mode = TICKDEV_MODE_PERIODIC;
> >  	if (dev) {
> > -		/*
> > -		 * Prevent that the clock events layer tries to call
> > -		 * the set mode function!
> > -		 */
> > -		clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
> >  		clockevents_exchange_device(dev, NULL);
> >  		dev->event_handler = clockevents_handle_noop;
> >  		td->evtdev = NULL;
> 
> Can this pretty please cleanup the misleading comment above
> tick_shutdown() as well?
> 
>  * Shutdown an event device on a given cpu:
>  *
>  * This is called on a life CPU, when a CPU is dead. So we cannot
>  * access the hardware device itself.
>  * We just set the mode and remove it from the lists.
> 
> That should have been removed or updated with 3b1596a21fbf too, no?

Right, missed that.

> 
> With that the cpu argument is not longer useful either, because this is
> now guaranteed to be invoked on the outgoing CPU, no?

Right.

Thanks!

> 
> Thanks,
> 
>         tglx
> 

-- 
Frederic Weisbecker
SUSE Labs

