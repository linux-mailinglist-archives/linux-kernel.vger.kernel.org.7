Return-Path: <linux-kernel+bounces-791819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4130BB3BC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F335A27A25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6942F1FFE;
	Fri, 29 Aug 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OGAacuMY"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B392877FC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473355; cv=none; b=MD9AHuMO5YKa8fofUB8M3+v0ZOQrivGY9SRwoa62D/a3lOMnhJEZtSurIlPPMrvOL2V9l+k9OOEvs3D+Gu4NAXDv26n42sQXF6P+tANjTh+ObdUAb94bGyQ97+v5f6tPqjB6jocchV5RJtK5xAFa8UTkJFWG58pFbaG0FA1WyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473355; c=relaxed/simple;
	bh=csKOLavxF/L0b6WPd3dZ5jxVYXIPAsoPHytvX9zQx5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQU6GcfcdjceMupiuI2iV9zvVUZFbsQJMdcoJDS2CogfwstH/nIoNtYTsBU8yIt4oC3C4glRYpJYUeq+Ja6/8afxLDzry5utOxhAGA6+5leIGmjSL6tt/+tb+pmT9S6tTK1W1Y/psSwz17XTwUbCBdkb/OnmSAQvP5oqAzLkeYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OGAacuMY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cbe5cef28so4057449a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756473351; x=1757078151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zoalc8mNo6XyJsEnXMXEpstjIFOUJAFYo+O0q9oPNg0=;
        b=OGAacuMYPZ5RB10oOeCMNJ/48/gLtMUDGYzq9hHg3SeiAT5kmRQAaoP4+etsFKCv7d
         1vvXCDyLWlwHbVIeQjHJd+7y3r7qBsz+syRfqlsPVy4seVBCG4C3vNOqCWzJ7Jej6OLx
         DH2n9HTC1EkcZz/XNqWlCOD4OjA2ekUPAfHMGyMfXrDCz0qUSe6UqPM+HDAfdwBjI5A5
         Dw16VvAwYRzOZEt+QXNWRLl2OPBnz8usBT4QW3ham19CjxlwZ5glIc/nHLe1i7soHdl7
         E+21IVYvvJdrPpe/q3moGZ5gLdTP+pwQ77HDOqELMf+qbDRRfSAqfsRpQXeytRz+kqSJ
         KvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756473351; x=1757078151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zoalc8mNo6XyJsEnXMXEpstjIFOUJAFYo+O0q9oPNg0=;
        b=dV4iGvMznZKoQy/cZxiUXXL5usPv5+IMvXkoa9HuHBN51BvTwOc93tfMJA55shP4/r
         PPAI0VG6XBs23EwNzsR/fWrWUUNjiKJaOQuozQrpVbGAJMAqqrZm6vzAxdAq1XU1Ens2
         JczwEcCWGw63o81VzW93rJIwEmULM3J3iWdnJhH03IP2uh0M8PqWVSmu3U23PfWVIGDs
         xfWFhZQoHprPBWrWqszIc3yR2/lE6uuXbCsmL8Ep+cx0wulr2wbnYYAgMXGZkYqaX1d6
         1r/sYziOQdycjygfbq02NzLAgu5vXNSGsXFg1RUXDkNqvkbQ4wdaQtRUyn8mCrnMVRNA
         V5uw==
X-Forwarded-Encrypted: i=1; AJvYcCXSMAUO46Z1k39/meMAoeH2oQvf6Uk8XoSRSPXKEjbQYaM9hyVs2Cn6bDCcO4sggYlZxaWBaH6vbGspCug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuh2EhXiMD6flv+Wanep4zqfXGD6p/YLIzpHKsf3NehkgOz+cr
	ZxHAvZtl5Muw+9dyYTv1U8wCn/I7bUq7VsU7XTwz7YXt1GkvJthzSCfFIBhvL5r80TI=
X-Gm-Gg: ASbGnctIhNBdlUA10waL2fPSvmJwbVuCw03r7JHV7HH8TDp6RuW1jKQ/Imyc2/VnbtD
	3Pjl+MFsfqxAhbioF16rL5TEjYLiRIyTkgJG8u9SvbmThaaLo2bqNgh228EreBxMQcGzhc8GoPV
	Ijt9+mixPfj3vCOa/Lx123NTEoDpOHDnrWw3kCkJo5GmKvJ75GAkcRVDERe9PfwyjlNsoMNvPpD
	v3XbOvhzX+yECWDMxdw1+omCroFbyrijER7Nu9c3FYZBxBb+2JCQPHjpRZkPJ4Kv/xcIcDl0aTT
	I/LJQuar1l6ypA45i+0YbmzscS/3PyF/LrU8YkDSg74Af8O3bvRPxtJ+pAN5IRqpE41h6rFVh1j
	ADR9pHHkYhCIhrjlOviv44GKDd1Hx62F1yNJrLXNPQFd8xBw=
X-Google-Smtp-Source: AGHT+IHs9PBBJd6VjsxGr8k912oIX5StJieFRWHn/DtrBrH0pH1VwJnbNB4issF3+rCOklpglvaNWA==
X-Received: by 2002:a05:6402:90e:b0:61c:931d:ccce with SMTP id 4fb4d7f45d1cf-61c983b81d2mr10225584a12.13.1756473350955;
        Fri, 29 Aug 2025 06:15:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5315c7sm1701157a12.46.2025.08.29.06.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:15:50 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:15:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aLGoBDapczoLH9-Y@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
 <aJoAYD_r7ygH9AdS@aspen.lan>
 <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
 <84h5xukti3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84h5xukti3.fsf@jogness.linutronix.de>

On Tue 2025-08-26 17:17:32, John Ogness wrote:
> On 2025-08-11, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > On Mon, 2025-08-11 at 15:38 +0100, Daniel Thompson wrote:
> >> On Mon, Aug 11, 2025 at 10:32:47AM -0300, Marcos Paulo de Souza
> >> wrote:
> >> > Function kdb_msg_write was calling con->write for any found
> >> > console, but it won't work on NBCON ones. In this case we should
> >> > acquire the ownership of the console using NBCON_PRIO_EMERGENCY,
> >> > since printing kdb messages should only be interrupted by a
> >> > panic. This is done by the nbcon_kdb_{acquire,release} functions.
> >> 
> >> Just wanted to check what it means to be "interrupted by a panic"?
> >> 
> >> kdb is called from the panic handler but, assuming the serial port is
> >> run syncrhonously when "bad things are happening", the serial port
> >> should be quiet when we enter kdb meaning we can still acquire
> >> ownership of the console?
> >
> > TBH I haven't thought about that. I talked with Petr Mladek about it,
> > and we agreed to have something similar to nbcon_device_try_acquire,
> > but with a higher priority, to make sure that we would get the context
> > at this point. But, when thinking about it, since KDB runs on the panic
> > handler, so we I'm not sure even if we need the _enter_unsafe() call at
> > this point, since nobody is going to interrupt either way.
> 
> Well, kdb can also run when not in panic. In that case, if a panic
> occurs while using kdb, those panic messages should be printed directly
> on the consoles.
> 
> Also be aware that the kdb interface is using dbg_io_ops->write_char()
> for printing and it will ignore a console that matches
> dbg_io_ops->cons. So there is no concern about the kdb interface
> conflicting with the nbcon console. This is just about the mirrored kdb
> output.

I was a bit confused by the "mirrored kdb output". It was a new term ;-)
Let me try to summarize how I see it. Take it with a caution because I
am not much familiar with the kdb code.

vkdb_printf() API
-----------------

It serializes calls using a custom recursive CPU lock (kdb_printf_cpu)

It shows/stores the messages using several interfaces:

     a) gdbstub_msg_write() probably shows the message inside
	an attached gdb debugger.

     b) kdb_msg_write() shows the message on the console where kdb
	is attached via dbg_io_ops->write_char()

     c) kdb_msg_write() also writes the message on all other consoles
	registered by printk. I guess that this is what John meant
	by mirroring.

     d) printk()/pr_info() stores the messages into printk log buffer
	and eventually shows them on printk consoles. It is called
	only when @logging is enabled

Note that either gdbstub_msg_write() or kdb_msg_write() is called.
Also I guess that @logging can be enabled only when gdb debugger is
attached. kdbgetintenv() most likely returns KDB_NOTENV when gdb is
not attached.

  => vkdb_printf() shows the message on only once on consoles:

      + via kdb_msg_write() when gdb is not attached

      + via printk() when gdb is attached and logging is enabled
	by setting LOGGING= environment variable


vkdb_printf() context
---------------------

vkdb_printf() is called when entering or being inside kdb code.
I guess that we might end there via:

   + int3 (break point)
   + kgdb_panic() called in panic()
   + NMI ???

I think that it might be called even before kdb synchronizes
all CPUs into some quiescent mode. Otherwise, the custom CPU
synchronization would not be needed.

For example, I guess that the CPUs are not synchronized here:

void kgdb_panic(const char *msg)
{
[...]
	if (dbg_kdb_mode)
		kdb_printf("PANIC: %s\n", msg);


But I might be wrong. Also it seems that kgdb_cpu_enter() makes sure
that all CPUs get synchronized before entering the main loop...


Serialization of vkdb_printf() vs. printk()
===========================================

Let's look at the various interfaces showing the messages:

    a) gdbstub_msg_write() does not conflict with printk()
       at all.

    b) It seems that kdb_msg_write() -> dbg_io_ops->write_char()
       uses some special API which tries to check whether the device
       is in a safe state and eventually waits for the safe state (pooling).

       It seems to be a one way synchronization. It "guarantees" that
       kdb would start write only when safe. But it does not block
       the other side.

       It might be safe when the other side is blocked which likely
       happens in kgdb_cpu_enter().


     c) kdb_msg_write() -> con->write()/con->write_atomic(), where

	  + con->write() is the legacy console callback. It is
	    internally synchronized via some lock, e.g. port->lock.

	    But kdb_msg_write() increments @oops_in_progress so that
	    the internal lock is basically ignored.

	      => It looks like a try-and-hope approach used also by panic().


	  + con->write_atomic() is nbcon console callback. It is going
	    to be synchronized via the new nbcon_kdb_try_acquire()

	       => The output won't be guaranteed because try_acquire()
		  might fail. But it should be safe.


      d) printk()/pr_info() is synchronized against other printk() out
	 of box. It would show the messages on the consoles only when
	 safe.

	 BTW: It might make sense to call printk()/pr_info() inside
	      nbcon_cpu_emergency_enter()/exit() section so that it
	      would try to flush the messages immediately when safe.


> > About the try_acquire part, I haven't checked about the state of the
> > console devices when the panic happens, if they drop the ownership of
> > the console on non-panic CPUs or not, so I'm not sure if this is needed
> > or not. I'll wait for Petr and/or maybe John to add some info.
> 
> If any context owned the console and is in an unsafe section while being
> interrupted by kdb (regardless if panic or not), then
> nbcon_kdb_try_acquire() will fail and the mirrored kdb output will not
> be visible on that console.
> 
> I am not sure how important it is that the output is mirrored in this
> case. A hostile takeover is not acceptable. And implementing some sort
> of delay so that the current owner has a chance to release the ownership
> (similar to what was attempted here [0]) is not only complicated, but
> has its own set of problems.

The solution proposed in this patch (nbcon_kdb_try_acquire()) looks
acceptable to me. The output is not guaranteed. But is should
hopefully work in most situations.

The great thing is that it would be safe in compare with the legacy
consoles where @oops_in_progress causes ignoring the internal locking.


> Currently there is no mirrored output for nbcon consoles. With this
> series it is at least possible.
> 
> BTW, in order for CPU switching during panic to be able to mirror output
> on nbcon consoles, an additional exception must be added to
> nbcon_context_try_acquire_direct(). It would look like this:

Great idea. I am just not sure about the condition, see below.

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 79d8c74378061..2c168eaf378ed 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -10,6 +10,7 @@
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/irqflags.h>
> +#include <linux/kgdb.h>
>  #include <linux/kthread.h>
>  #include <linux/minmax.h>
>  #include <linux/percpu.h>
> @@ -247,6 +248,8 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>  		 * Panic does not imply that the console is owned. However,
>  		 * since all non-panic CPUs are stopped during panic(), it
>  		 * is safer to have them avoid gaining console ownership.
> +		 * The only exception is if kgdb is active, which may print
> +		 * from multiple CPUs during a panic.
>  		 *
>  		 * If this acquire is a reacquire (and an unsafe takeover
>  		 * has not previously occurred) then it is allowed to attempt
> @@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>  		 * interrupted by the panic CPU while printing.
>  		 */
>  		if (other_cpu_in_panic() &&
> +		    atomic_read(&kgdb_active) == -1 &&

This would likely work for most kgdb_printk() calls. But what about
the one called from kgdb_panic()?

Alternative solution would be to allow it only for the CPU locked
by kdb, something like:

		    READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id() &&

Note that I used READ_ONCE() to guarantee an atomic read. The
condition will fail only when we are inside a code locked by
the kdb_printf_cpu().

An alternative would be smp_load_acquire(&kdb_printf_cpu). But
I think that it is a "too big" hammer and it does not fit here.

> +		    atomic_read(&kgdb_active) == -1 &&
>  		    (!is_reacquire || cur->unsafe_takeover)) {
>  			return -EPERM;
>  		}
> 
> >> > @@ -605,7 +616,14 @@ static void kdb_msg_write(const char *msg, int msg_len)
> >> > 		 * for this calling context.
> >> > 		 */
> >> > 		++oops_in_progress;
> >> > -		c->write(c, msg, msg_len);
> >> > +		if (flags & CON_NBCON) {
> >> > +			wctxt.outbuf = (char *)msg;
> >> > +			wctxt.len = msg_len;
> >> > +			c->write_atomic(c, &wctxt);
> >> > +			nbcon_kdb_release(&wctxt);
> >> > +		} else {
> >> > +			c->write(c, msg, msg_len);
> >> > +		}
> >> > 		--oops_in_progress;
> >> > 		touch_nmi_watchdog();
> >> > 	}
> >> 
> >> Dumb question, but is the oops_in_progress bump still useful with
> >> atomic consoles? Will the console have any spinlocks to disregard or
> >> will the console ownership code already handled any mutual exclusion
> >> issues meaning there should be no spinlocks taking by the atomic
> >> write handler?
> >
> > IIUC, since we can have multiple consoles, and some of them are NB and
> > others aren't, I believe that this oops_in_progress is still useful.
> 
> Correct, but only for legacy consoles. Please move the @oops_in_progress
> increment/decrement to only be around the c->write() call. This makes it
> clear that the hack is only "useful" for the legacy consoles.

I agree.

> John
> 
> [0] https://lore.kernel.org/lkml/20210803131301.5588-4-john.ogness@linutronix.de

Sigh, I have already forgotten that we discussed this in the past.

Best Regards,
Petr

