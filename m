Return-Path: <linux-kernel+bounces-801200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BCB44181
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E9A5878EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA352D372D;
	Thu,  4 Sep 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aM3MoRXO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QovsCbtb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B195280A5A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001454; cv=none; b=bGBZyS+cpSKzZN8+CNt5uYmcepDjBbamaheF+X6Gzy5xfQM5kg0IBb0MzBtP98oIoy/pFYnfJJ8YGFWJT6rvOfTZZKPLMA6H5RwCYbHHNYBkIQf6S/ct5gfwNBa4vdScSuZNIsAu39j8rbqlgVu5O8izUHoARGVi61wvQ3V34+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001454; c=relaxed/simple;
	bh=o8MxY15oYgymi06x5QgLEO2uD8/8sm37kk2ErSbl5Zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nwufJPwUwcGjiT3xLHOTTEcYi0GmeZqSOnD8RhTnvKW+o+3yThLwkmNq7mg7PnirB0f31JiTHcEcuvvSZlFnlv4Cy+3iB8D84zt2a14lXaVzivnuwhu9StJsV0vXDAjW0ok+L1oF/Bwkxym7IXpwL6NX3YPXDPDrEnkiEEkok4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aM3MoRXO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QovsCbtb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757001451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13UoqwgXArTk59f3NeL/fhVRlStlcBSEJq2cxPToQCY=;
	b=aM3MoRXO8NVf1SloZwu9C4wzfOq2/GQ5rVx/Y+m+Ap17bWJfitEhN9TXjOUuYW9mqTi1Db
	ShvzoZj/UpX2jmClxDVwh1XHPlZ/7vt0wFTEXp+eOz63cN6vG/5PWnFEfiTomXibtjxJmv
	/ic0YqbBpaw/ybleaPukJ4Kxiavc1ynxEY8bPp8dZP1gJPu7UioBukU93ShuCTU4lskvF6
	tctZg1WuUqmBoFYeAVD93vwRXnp8xlXS+v1mSgZZjWUHdvTKbYg7wtT0QU66FU9FiA7wZD
	WOmzj/Lb9/nwaqluVBB+W8h/w3ynEcclJsYrsZ9xoBoLYEz3mQFWcvO/0NAhAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757001451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13UoqwgXArTk59f3NeL/fhVRlStlcBSEJq2cxPToQCY=;
	b=QovsCbtblPkrEW4QFi0X0e0lSnghJKoIHzC/PGCyPGeIUsv4Ew8cuUxREcVRQ5b+U+mcoN
	Z9cOYCyN1g3p8lBg==
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Xianglai Li
 <lixianglai@loongson.cn>
Subject: Re: [PATCH v2 1/2] tick: Remove unreasonable detached state set in
 tick_shutdown()
In-Reply-To: <20250904071732.3513694-2-maobibo@loongson.cn>
References: <20250904071732.3513694-1-maobibo@loongson.cn>
 <20250904071732.3513694-2-maobibo@loongson.cn>
Date: Thu, 04 Sep 2025 17:57:30 +0200
Message-ID: <87frd2xlat.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025 at 15:17, Bibo Mao wrote:
> Function clockevents_switch_state() will check whether it has already
> switched to specified state, do nothing if it has.
>
> In function tick_shutdown(), it will set detached state at first and
> call clockevents_switch_state() in clockevents_exchange_device(). The
> function clockevents_switch_state() will do nothing since it is already
> detached state. So the tick timer device will not be shutdown when CPU
> is offline. In guest VM system, timer interrupt will prevent vCPU to
> sleep if vCPU is hot removed.
>
> Here remove state set before calling clockevents_exchange_device(),
> its state will be set in function clockevents_switch_state() if it
> succeeds to do so.

This explanation is incomplete. tick_shutdown() did this because it was
originally invoked on a life CPU and not on the outgoing CPU.

That got changed in

  3b1596a21fbf ("clockevents: Shutdown and unregister current clockevents at CPUHP_AP_TICK_DYING")

which is the actual root cause.

The pile of 'Fixes:' below is just enumerating the subsequent problems.

> Fixes: bf9a001fb8e4 ("clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining")
> Fixes: cd165ce8314f ("clocksource/drivers/qcom: Remove clockevents shutdown call on offlining")
> Fixes: 30f8c70a85bc ("clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining")
> Fixes: ba23b6c7f974 ("clocksource/drivers/exynos_mct: Remove clockevents shutdown call on offlining")
> Fixes: 15b810e0496e ("clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining")
> Fixes: 78b5c2ca5f27 ("clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining")
> Fixes: 900053d9eedf ("ARM: smp_twd: Remove clockevents shutdown call on offlining")
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/time/tick-common.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 9a3859443c04..eb9b777f5492 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -424,11 +424,6 @@ void tick_shutdown(unsigned int cpu)
>  
>  	td->mode = TICKDEV_MODE_PERIODIC;
>  	if (dev) {
> -		/*
> -		 * Prevent that the clock events layer tries to call
> -		 * the set mode function!
> -		 */
> -		clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
>  		clockevents_exchange_device(dev, NULL);
>  		dev->event_handler = clockevents_handle_noop;
>  		td->evtdev = NULL;

Can this pretty please cleanup the misleading comment above
tick_shutdown() as well?

 * Shutdown an event device on a given cpu:
 *
 * This is called on a life CPU, when a CPU is dead. So we cannot
 * access the hardware device itself.
 * We just set the mode and remove it from the lists.

That should have been removed or updated with 3b1596a21fbf too, no?

With that the cpu argument is not longer useful either, because this is
now guaranteed to be invoked on the outgoing CPU, no?

Thanks,

        tglx


