Return-Path: <linux-kernel+bounces-883072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5D0C2C6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6E63343DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92228032D;
	Mon,  3 Nov 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/tbENM2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t/X98/ZS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E527FB0E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180312; cv=none; b=h5EEsavNyTwfLFCcag+u/j1b27rvFZLMcd/cABlD0lj0V/axPrqk2OANZu0cPS1IkbIydtDxOKDaPuS0SDutNhpnVESzpdTbtbozrLy6hMuwKNwOw9uYVZJ6rE2Mt5cvqHJix8HfAn22iv/FH8bTjodpAerkgEq763TDtntfErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180312; c=relaxed/simple;
	bh=gXA5ghk9AogHNyb5R4l/IfwVe2qAz57wngSzbYD+EpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxyxFaiWv1F87RFkWHzrVeMtCLwFo77tR3+xkffD7ul82eOH4J7g89CbpB3Ii7PPs+bhMwjeGTF0kG3SV12Q8DWXYkeZ7yuu11+JHeHeY9kHjOFzNjgmuM4TpR3ncXlHYiyejsFL+4ehC7fD67kof2ASfeRPg7TveoahIMezTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/tbENM2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t/X98/ZS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Nov 2025 15:31:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762180309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMCmar1obBkcsxxCkq+rOwZHgdbiYWeXVb5R0swSzb0=;
	b=x/tbENM2wjHqpOPB9sqbwXA0EgYv4x/ibzxE00EvkqhU8JBqePir2NxP0uYh4KS7m+ZCST
	aRrDNCaMynt2Wp3PyH+xuu1qtn1aAYEFL96WuX5iimwxuxYh4Nvh9VpuiL+I/G2xIOP7OA
	19C0pgnO+Mpj9atcoHLbz1OQC90Bb35078r25VgUu/ASHCpRfnmiYcGL4uySJWXNRprMRp
	faRypGKwdBbcrfT2rWcz8Dy+lPsuyEOJubiaBB9/jDs655V05HwGVmGdEOC1RgEL2/xlcC
	GgPppP+UcYRYUlbK9/5nGuvtRdSag7ZYG49iwMZ3nljXMTcJ3QWr9GxnAsP3RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762180309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMCmar1obBkcsxxCkq+rOwZHgdbiYWeXVb5R0swSzb0=;
	b=t/X98/ZS01WKCJ4Kfh4ebxMBp/uDKd/5B3almYrIJyvtxuTbuA/XYD892cntrQHhbFkBit
	ZM+xGxR8kbGE0fCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] cpu: Make atomic callbacks run on UP with disabled
 interrupts
Message-ID: <20251103143147.PBAiL3fW@linutronix.de>
References: <20251103120354.HU-oB1_z@linutronix.de>
 <20251103124254.GA3245006@noisy.programming.kicks-ass.net>
 <20251103132820.0llS_QPg@linutronix.de>
 <20251103141058.GD3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103141058.GD3245006@noisy.programming.kicks-ass.net>

On 2025-11-03 15:10:58 [+0100], Peter Zijlstra wrote:
> On Mon, Nov 03, 2025 at 02:28:20PM +0100, Sebastian Andrzej Siewior wrote:
> > On SMP callbacks in the "starting" range are invoked while the CPU is
> > brought up and interrupts are still disabled. Callbacks which are added
> > later ar invoked via the hotplug-thread on the target CPU and interrupts
> > are explicitly disabled.
> > In the UP case callbacks which are added later are invoked "directly"
> > without the thread. This is okay since there is just one CPU but with
> > enabled interrupts debug code, such as smp_processor_id(), will issue
> > warnings.
> > 
> > Disable interrupts before invoking the calback on UP if the state is
> > atomic and interrupts are expected to be disabled.
> > The "save" part is required because this is also invoked early in the
> > boot process while interrupts are disabled and must not be enabled. The
> > warnings aligns the function with cpuhp_thread_fun().
> > 
> > Fixes: 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and scheduler_ipi()")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Did we want me to merge this into sched/urgent or what was the
> hope/intention for this patch.

I did testing on ARM/UP and run into this. Therefore I would suggest
sched/urgent or the matching hotplug/urgent should one exist.

But since it is just a smp_processor_id() debug warning on UP and
nothing serious I don't mind to delay it until the next merge window.

Sebastian

