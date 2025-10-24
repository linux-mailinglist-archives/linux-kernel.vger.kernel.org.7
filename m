Return-Path: <linux-kernel+bounces-868611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847FC059D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D151188B6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100D3101AB;
	Fri, 24 Oct 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="loqZkwQT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ro7Z+EQz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257C146585
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302292; cv=none; b=YzfYnUGLs086B70rZhNV98vkuq0xBZCNKEhfHEIZlDlQ03vSQH1wsi4HvdD6Oiq5KEUcLWl6Ey/ulZtfbNFjj0qMOKibZOJlP8zLYh/NI/kev9uOoj7z1IwIDSPrwZpk98Keyifrozrw7wXV7L0g3kL350XuFapfuIdh0+H1sz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302292; c=relaxed/simple;
	bh=QpDCzf7SyDqaGSbM2EYT67gkb7qD0CFtlSAektCo+mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY+iAFXXwU+4nPndwX4x5yzREwxXD1Kij3W/LPTVASAYS6+bEr823Z2P7H8MLRxS86aQU+0aHKjvTTJ9ijY6F9m4ZMWPObLzvGhal0Nf0o3BybBqegVOSKQXYlTwycipQ/HhpK3yhrE53PzS7MZpkWAZ+AYUkphfvrU8aeaY2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=loqZkwQT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ro7Z+EQz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 12:38:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761302289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWzzIxgH+/Qo8Z+B1+7YQcri7JqgR0aHrtqQynhOWuc=;
	b=loqZkwQTBgrHK/KZ2f/f4PQ+ofbDAkkuIu4aEEeGtPVukNBDfYXvm6X+8G6Ex8hCkT9GVy
	b1Z1L+PkIp+5lOPxsD6v74CHg+r+X6m8D0y+YmOX6opD+sWwUoLCR07tNK2ZTXAaB0jffa
	j2HYHBeUFIzFM3g5gD4oxp/cFCmGl9bIqEgh92GN9llihIPR7C426EXGanCq45/BSS8Sjv
	snMyd1hNdef9Fo1Tc2mXtsTiiOYmialU29DmwSzr4yxwyI8gL82o4uQZeFys7+6tStVsZN
	nrlyYoO8/zigzhSm6Wzn/ImF+Le2N6Y/MBlF/DiZuyJCHYy9TOrU67apXOxQPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761302289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWzzIxgH+/Qo8Z+B1+7YQcri7JqgR0aHrtqQynhOWuc=;
	b=Ro7Z+EQzxW1Yio1Mam5pF7Adi2UIRUB/Mjx4DaT2UW5P8f29EjfJSTsWpD7mmEjPpxrPqu
	1NCT+uwz7eon1GAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251024103808.umPAqCda@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
 <20251023151112.goqBFQcM@linutronix.de>
 <20251023154657.GD26461@redhat.com>
 <20251023191442.Uu0mD_Nq@linutronix.de>
 <aPtIUq7hf4R5-qfF@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aPtIUq7hf4R5-qfF@pathway.suse.cz>

On 2025-10-24 11:35:14 [+0200], Petr Mladek wrote:
> It is clear that the commit message and the comment above the mapping
> caused some confusion. I thought about better wording.
>=20
> I wanted to be as clear as possible, But the problem is that everyone
> has different background and might understand the same term
> differently. Also I am not a native speaker.
>=20
>=20
> /*
>  * Some legacy console drivers might violate raw_spinlock/spinlock nesting
>  * rules when printk() was called under a raw_spinlock and the driver used
>  * a spinlock. It is not a real problem because the legacy drivers should
>  * never be called directly from printk() in PREEMPT_RT.
>  *
>  * This map is used to pretend that printk() was called under a normal sp=
inlock
>  * to hide the above described locking violation. It still allows to catch
>  * other problems, for example, possible ABBA deadlocks or sleeping locks.

It is not "Some legacy console" but all of them. The only exception
would if they don't use any locking. Serial driver should use
uart_port::lock, VT has its printing_lock and so on.
Don't like the "might violate".
"should never be called" is misleading because we know how things work
and they must not be called. But this is minor=E2=80=A6

But why bring ABBA deadlocks into this and sleeping locks? Especially
since different people assume different things when "sleeping locks" is
used. And clearly the last was not handled well :)

I would suggest simple and focus on the change and why:
The override addresses the nesting problem on !RT which does not occur
on RT because the code flow is different.

What about the suggested:

  The legacy console always acquires a spinlock_t from its printing
  callback. This violates lock nesting if the caller acquired an always
  spinning lock (raw_spinlock_t) while invoking printk(). This is not a
  problem on PREEMPT_RT because legacy consoles print always from a
  dedicated thread and never from within printk(). Therefore we tell
  lockdep that a sleeping spin lock (spinlock_t) is valid here.


>  *
>  * The mapping is not used in PREEMPT_RT which allows to catch bugs when
>  * the legacy console driver would get called from an atomic context by m=
istake.
>  */
>=20
>=20
> And the commit message might be:
>=20
> <commit_message>
> printk_legacy_map: use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP
>=20
> printk_legacy_map is used to hide possible violations of
> raw_spinlock/spinlock nesting when printk() calls legacy console
> drivers directly. It is not a real problem in !PREEMPT_RT mode and
  s/real//

> the problematic code path should never be called in PREEMPT_RT mode.

  because this code path is never called on PREEMPT_RT.

> However, LD_WAIT_SLEEP is not exactly right. It fools lockdep as if it

Why is not exactly right? :) Usually you describe _why_ you do things
and because it wasn't right is okay if it is obvious to everyone.

> is fine to acquire a sleeping lock.
>=20
> Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.
>=20
> Also, update the comment to better describe the purpose of the mapping.
> </commit_message>

For my taste it is too verbose and you bring too much context. It is
*just* the lock nest override. No need to bring other aspects of lockdep
into the game.

  printk_legacy_map is used to hide lock nesting violations caused by
  legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
  for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
  lock type which are sleeping while spinning on PREEMPT_RT such as
  spinlock_t.

> Is this better and acceptable, please?
> If not then please provide alternatives ;-)

I made some suggestions. However you got rid of the points I complained
about initially so I fine with it. Thank you.

> Best Regards,
> Petr

Sebastian

