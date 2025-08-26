Return-Path: <linux-kernel+bounces-786888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83D7B36D79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4934356340E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF07920CCE4;
	Tue, 26 Aug 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N64Mc9AD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PTlGNQVF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747981E522
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221102; cv=none; b=Mzd9K7w7h2p1LTX643nzIEGvO6cDf5t+UAjAWnE1ja+yqL9n5pvmq8vQcScPKjZR7SZa4/ySHYnZSQKWaxL0NnWn8y+3IH35srxjRfFR421WVaByWPfVYDVMkgz+ciHW4ZoJBqx+JdScW7O63ppmmZSbLgdgzRtXgu03tg0KOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221102; c=relaxed/simple;
	bh=VVVCUtyDYZ0buOY+ZdDaiV951AxgSpMaOxc/5ty10GY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qm1IHOs6Jr/XFu5Qhu4RzsykpB+8t6DA9e8V0xHyj2Qu8bU8hP3BdxyQsksDPyq/4lQBAUxxiaq/AvYZ/Wd+sA92HWfFNDG/wF9C+e7xnIxAY3ImB1F3Gw2HtMjq7k15SdIvJ4pdwFMAdWjz9v11iVJrsET4M0ItxDE4jDJYG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N64Mc9AD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PTlGNQVF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756221093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/yXlfO8Uy4zaE30Fj0arVRS1PTUrfVGm3+QcjZ6aTI=;
	b=N64Mc9ADHY3q+V4ETWWrYQny5lL4fSh31sdQLk5q+t+zoi0dcD+S4vPK9SNjWYuV2UgsQ2
	U0jtlU7DlPsEdonOp9g8fUee7TVhrvZqxSSNYvpIKNxjVVP5H09OgkzGSg3nEsjO+Z7spb
	p+t7UmHoi0FjlijUs67URnUGuaN4Y5l9oODFOxtQ+IMpg8cE01YA0bQHSt+xaQ5GO9085i
	aAz55tNjJWERbYXuJW93tRWUFWACU4qQOa8azf6ujGYUlAkWenaQ51SrP8yMab76bj4vMs
	Pb4DWXK7sUbgDGlbLxmwjmBOS1r9OGQLyvqNF4cufhcXAJOZPo5kiUl7v50cUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756221093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/yXlfO8Uy4zaE30Fj0arVRS1PTUrfVGm3+QcjZ6aTI=;
	b=PTlGNQVFKfrxKIXPM7WJhU5dmv4vSerF7WYt0qPiIe+nPVdFkKjpRPGGYGmUHsCOQAYUXt
	249M/og3SWsmRXCQ==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Daniel Thompson
 <daniel@riscstar.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
In-Reply-To: <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
 <aJoAYD_r7ygH9AdS@aspen.lan>
 <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
Date: Tue, 26 Aug 2025 17:17:32 +0206
Message-ID: <84h5xukti3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-08-11, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> On Mon, 2025-08-11 at 15:38 +0100, Daniel Thompson wrote:
>> On Mon, Aug 11, 2025 at 10:32:47AM -0300, Marcos Paulo de Souza
>> wrote:
>> > Function kdb_msg_write was calling con->write for any found
>> > console, but it won't work on NBCON ones. In this case we should
>> > acquire the ownership of the console using NBCON_PRIO_EMERGENCY,
>> > since printing kdb messages should only be interrupted by a
>> > panic. This is done by the nbcon_kdb_{acquire,release} functions.
>> 
>> Just wanted to check what it means to be "interrupted by a panic"?
>> 
>> kdb is called from the panic handler but, assuming the serial port is
>> run syncrhonously when "bad things are happening", the serial port
>> should be quiet when we enter kdb meaning we can still acquire
>> ownership of the console?
>
> TBH I haven't thought about that. I talked with Petr Mladek about it,
> and we agreed to have something similar to nbcon_device_try_acquire,
> but with a higher priority, to make sure that we would get the context
> at this point. But, when thinking about it, since KDB runs on the panic
> handler, so we I'm not sure even if we need the _enter_unsafe() call at
> this point, since nobody is going to interrupt either way.

Well, kdb can also run when not in panic. In that case, if a panic
occurs while using kdb, those panic messages should be printed directly
on the consoles.

Also be aware that the kdb interface is using dbg_io_ops->write_char()
for printing and it will ignore a console that matches
dbg_io_ops->cons. So there is no concern about the kdb interface
conflicting with the nbcon console. This is just about the mirrored kdb
output.

> About the try_acquire part, I haven't checked about the state of the
> console devices when the panic happens, if they drop the ownership of
> the console on non-panic CPUs or not, so I'm not sure if this is needed
> or not. I'll wait for Petr and/or maybe John to add some info.

If any context owned the console and is in an unsafe section while being
interrupted by kdb (regardless if panic or not), then
nbcon_kdb_try_acquire() will fail and the mirrored kdb output will not
be visible on that console.

I am not sure how important it is that the output is mirrored in this
case. A hostile takeover is not acceptable. And implementing some sort
of delay so that the current owner has a chance to release the ownership
(similar to what was attempted here [0]) is not only complicated, but
has its own set of problems.

Currently there is no mirrored output for nbcon consoles. With this
series it is at least possible.

BTW, in order for CPU switching during panic to be able to mirror output
on nbcon consoles, an additional exception must be added to
nbcon_context_try_acquire_direct(). It would look like this:

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 79d8c74378061..2c168eaf378ed 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
+#include <linux/kgdb.h>
 #include <linux/kthread.h>
 #include <linux/minmax.h>
 #include <linux/percpu.h>
@@ -247,6 +248,8 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * Panic does not imply that the console is owned. However,
 		 * since all non-panic CPUs are stopped during panic(), it
 		 * is safer to have them avoid gaining console ownership.
+		 * The only exception is if kgdb is active, which may print
+		 * from multiple CPUs during a panic.
 		 *
 		 * If this acquire is a reacquire (and an unsafe takeover
 		 * has not previously occurred) then it is allowed to attempt
@@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * interrupted by the panic CPU while printing.
 		 */
 		if (other_cpu_in_panic() &&
+		    atomic_read(&kgdb_active) == -1 &&
 		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
 		}

>> > @@ -605,7 +616,14 @@ static void kdb_msg_write(const char *msg, int msg_len)
>> > 		 * for this calling context.
>> > 		 */
>> > 		++oops_in_progress;
>> > -		c->write(c, msg, msg_len);
>> > +		if (flags & CON_NBCON) {
>> > +			wctxt.outbuf = (char *)msg;
>> > +			wctxt.len = msg_len;
>> > +			c->write_atomic(c, &wctxt);
>> > +			nbcon_kdb_release(&wctxt);
>> > +		} else {
>> > +			c->write(c, msg, msg_len);
>> > +		}
>> > 		--oops_in_progress;
>> > 		touch_nmi_watchdog();
>> > 	}
>> 
>> Dumb question, but is the oops_in_progress bump still useful with
>> atomic consoles? Will the console have any spinlocks to disregard or
>> will the console ownership code already handled any mutual exclusion
>> issues meaning there should be no spinlocks taking by the atomic
>> write handler?
>
> IIUC, since we can have multiple consoles, and some of them are NB and
> others aren't, I believe that this oops_in_progress is still useful.

Correct, but only for legacy consoles. Please move the @oops_in_progress
increment/decrement to only be around the c->write() call. This makes it
clear that the hack is only "useful" for the legacy consoles.

John

[0] https://lore.kernel.org/lkml/20210803131301.5588-4-john.ogness@linutronix.de

