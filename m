Return-Path: <linux-kernel+bounces-828592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF8B94F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9247F3BF75E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536AE3191D2;
	Tue, 23 Sep 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NbzWi2Us"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B511DE2A0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615549; cv=none; b=hAaNUuzYO+cDoB6fyqgqMLfdoMFUGz3GC27LJs3P1HVnKXHnbLyR8NYeNLlllN2edbsCRwKNsBfPdl71r9bcm/h0MDsWuo4x76tjC3Gk1m0kSnQZBeFMs1RWbul3UAm4LDDO5Or7bUvJ+cIbpXoK5tcRimkKv5CjE/McWIvWfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615549; c=relaxed/simple;
	bh=4Cy+SsH7TpRwaSvJKXJ+uWOTiC3m47dyLqKRuV38Y6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvYqo6vetZ2vK4zpW29JdlW7vRcKUPIRLZnSsBDFPRwqm13E5ob7Z6VIZUS2CYCLUzZpD17JgxIz2CP4sJuevMGorPS5tkBVIQ+GLSKm85OYQ9a96Xnlln8RhG4An618jw0QuVawbWHtBe8kIzizMARCjwktEJ6VZdeVvpLF9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NbzWi2Us; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MEWFTxrgvqJjROGSj2KletXP9xre/cRaJR07udiFZOE=; b=NbzWi2Us9DUmzXk65AfNWzvCOu
	2sjyllEUvQ+u3mRaKpU74Fy1BH2orn4Nf18iXzlIItm+je55nQRXfLnNY2FTMI/QzUW2tCEux+oK/
	njRLRHV6DbDeJN4+HzzirLR9fiXnTuP0fsidbSF0jdfOgp2IIOQMPfHnTU3JL1uCStJ7pTcHzinT1
	pzAhsCvaxdMLeJnCP7CkcKKQ1S0DXrRZki3yTKtfXZUtUbl9YziNxG2uAZf1hjauVtmmeGBEATneX
	AdPU9DkwQGF6cM2ADpQmcUnBfwce15Omnq/HGuaHI0HLzE70pPrOtkKGRPGQK+TJR8UNdfGFI0AXD
	yVySp2Nw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0yEl-00000007lOF-0yMP;
	Tue, 23 Sep 2025 08:18:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B334F30049C; Tue, 23 Sep 2025 10:18:58 +0200 (CEST)
Date: Tue, 23 Sep 2025 10:18:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de, anna-maria@linutronix.de, frederic@kernel.org,
	luto@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	oliver.sang@intel.com
Subject: Re: [RFC][PATCH 7/8] entry,hrtimer: Push reprogramming timers into
 the interrupt return path
Message-ID: <20250923081858.GU4068168@noisy.programming.kicks-ass.net>
References: <20250918075219.091828500@infradead.org>
 <20250918080206.180399724@infradead.org>
 <875xdd8oag.ffs@tglx>
 <20250923075240.GT3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923075240.GT3245006@noisy.programming.kicks-ass.net>

On Tue, Sep 23, 2025 at 09:52:40AM +0200, Peter Zijlstra wrote:

> > 2) I came up with the following scenario, which is broken with this
> >    delayed rearm.
> > 
> >    Assume this happens on the timekeeping CPU.
> > 
> >       hrtimer_interrupt()
> >         expire_timers();
> >         set(TIF_REARM);
> > 
> >       exit_to_user_mode_prepare()
> >         handle_tif_muck()
> >           ...
> >           to = jiffies + 2;
> >           while (!cond() && time_before(jiffies, to))
> >           	relax();
> > 
> >      If cond() does not become true for whatever reason, then this won't
> >      make progress ever because the tick hrtimer which increments
> >      jiffies is not happening.
> > 
> >      It can also be a wait on a remote CPU preventing progress
> >      indirectly or a subtle dependency on a timer (timer list or
> >      hrtimer) to expire.
> > 
> >   I have no idea whether that's related to the reported 0-day fallout,
> >   but it definitely is a real problem lurking in the dark.
> 
> Argh... that exit_to_user_mode_loop() thing enables IRQs. Yes, buggered
> something mighty.
> 
> Let me haz a poke.

Bah. So schedule() is first in the TIF loop. Delaying hrtimer_rearm()
until that first schedule() call might just be enough, but that also
means running all of sched_submit_work() without timers... it might just
work, but urgh.

Let me try that anyway. I'll push it out to the robot, we'll see what
happens.

