Return-Path: <linux-kernel+bounces-783360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22FB32C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E9D562764
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B929253F20;
	Sat, 23 Aug 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yNlnorQk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coGQChTk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4C2459CD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755989643; cv=none; b=eOnVNdaJfCWQMyaIyoY+d0KlIARVjkeYZjypAwP0WtZLTHvzqc6iIOZOsdg/Zk+KBbsqqkJPFxZ/89eWAFA1N+ZAi5DmJ/eKPlWMl0pIbxYmV5FdGor+ygCAFWRa5ehjZ92Rf4aI5xuADs17di9mmR4ZinlFD3WdjHWGMxbIT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755989643; c=relaxed/simple;
	bh=kyWjznqhGPxSOiGgH/W3h7AWjnPfHVUmutLQuD5i8qM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BpiWgZNDyeuh18OrTA2b0E53AbmBIrc6p+5pwT5bQ5wAKB3bwVO1JHlsyooiBLKDRfR8Ipo9qF2GAFL0nTdi6GKQc83YBZHXy0+tgjRP+LHA+v6dK/zlBKDXuUATM8mA/siCTymxFHeipYXDLLpGWTudxRBN6mUHghXFulXWtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yNlnorQk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coGQChTk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755989637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7fdhRIYOR+gE7Acyfm0ZfjdYMWHgOqEo0N4gHSmxf4=;
	b=yNlnorQkAal/KQJdKJCnJeT9m/Yu+J3+57UsSjWN0fjwQdWUFjvHLdxaV/0qTP0V8sm5AC
	pnDQpId3EdgKarR0sXTBFY+em6qcbvyrnlneV06Z2PYHkS+wcYJLFBZGjXB3iwo+axfF3P
	SpdyREa1JMcohYj3UuoLW9sEd1D2i1e6A2sYhwex4wbKFbCnQznIew7O+m9KL5/sOFZu6U
	3WmuL2/jPE5IDpjBddOF6YAQ2kJ7hsc0TN5wldfoDAg+ffClYmOXXoaZ9NVlTd+HEGyJc7
	bLPB1kxNHEcx+TaNmjC2JNPYAXovd1+hO1xn83BlU9gVTIIwQjzbfNAOGBYdvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755989637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7fdhRIYOR+gE7Acyfm0ZfjdYMWHgOqEo0N4gHSmxf4=;
	b=coGQChTk0hJ/nRMZ98t8Us73bP4JqUlkBF1qSEqaeesxdrSLRWanFuPZwt99qEJD6xUSxl
	yqXNF+Ck6EYFNcCQ==
To: vishnu singh <v-singh1@ti.com>, mark.rutland@arm.com, maz@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, jstultz@google.com,
 sboyd@kernel.org, akpm@linux-foundation.org, chenhuacai@kernel.org,
 pmladek@suse.com, agordeev@linux.ibm.com, bigeasy@linutronix.de,
 urezki@gmail.com, Llillian@star-ark.net, francesco@valla.it,
 guoweikang.kernel@gmail.com, alexander.shishkin@linux.intel.com,
 rrangel@chromium.org, kpsingh@kernel.org, anna-maria@linutronix.de,
 mingo@kernel.org, frederic@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot
 timestamp
In-Reply-To: <20250823044034.189939-1-v-singh1@ti.com>
References: <20250823044034.189939-1-v-singh1@ti.com>
Date: Sun, 24 Aug 2025 00:53:56 +0200
Message-ID: <871pp14pkr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23 2025 at  9:49, vishnu singh wrote:
On Sat, Aug 23 2025 at 10:10, vishnu singh wrote:

Why are you sending the same thing twice within 20 minutes?

> From: Vishnu Singh <v-singh1@ti.com>
>
> Part of BOOT SIG Initiative,

What the heck is BOOT SIG Initiative? Are you seriously expecting me to
look this up?

Please don't provide me a random link to it because it's not relevant to
the rest of what I have to say about this.

> , This patch adds a tiny,opt-in facility to help measure kernel boot
>   duration without full tracing:

1) Any spell checker would have pointed out to you that 'This' after a
   comma is not a proper sentence and neither is 'tiny,opt-in facility'

2) You failed to read documentation:

   # git grep "This patch" Documentation/process/

3) This change log starts with the WHAT and fails completely to explain
   the WHY. See:

     https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#cha=
ngelog

> New CONFIG_BOOT_TIME_TRACKER in kernel/time/Kconfig.
> When enabled, the kernel logs two boot markers:
>     1. kernel entry in start_kernel()
>     2. first userspace start in kernel_init() before run_init_process()
>
> These markers are intended for post-boot parsers to compute coarse
> kernel boot time and to merge with bootloader/MCU/DSP records into
> a unified timeline.
>
> Core helper u64 boot_time_now() in kernel/time/boot_time_now.c,
> exporting a counter=E2=80=91derived timestamp via small per-arch primitiv=
es.
> This series includes an initial arm64 primitive that uses CNTVCT_EL0
> as the source, other architectures can wire up equivalents.
>
> Files touched:
> kernel/time/Kconfig, kernel/time/Makefile
> kernel/time/boot_time_now.c (new core helper)
> arch/arm64/include/asm/boot_time_primitives.h (arm64 primitive)
> include/linux/boot_time_now.h (public API + IDs)
> init/main.c (print two markers)

Seriously? This can be seen from the diffstat and the patch itself.

You still fail to explain the problem you are trying to solve and
instead babble about WHAT you are doing, which means you never read the
documentation of the project which you are trying to contribute to.

Do you really think that the people who spent time on writing it, did
so just to be ignored?

> This complements U-Boot=E2=80=99s stashed bootstage records so a userspac=
e tool
> can build a system-wide boot timeline across SPL, U-Boot, kernel and other
> subsystems.
>
> Reference boot-time parser utility:
>      https://github.com/v-singh1/boot-time-parser
>
> Sample boot time report:
> +--------------------------------------------------------------------+
>                  am62xx-evm Boot Time Report
> +--------------------------------------------------------------------+
> Device Power On         : 0 ms

<SNIP>

> IPC_SYNC_ALL                   =3D   6787 ms (+151 ms)
> +--------------------------------------------------------------------+

How are these 30 lines of useless information helpful to understand the
underlying problem?

That's what cover letters are for.

>  MAINTAINERS                                   |  3 +++
>  arch/arm64/include/asm/boot_time_primitives.h | 14 ++++++++++++++
>  include/linux/boot_time_now.h                 | 16 ++++++++++++++++
>  init/main.c                                   | 13 +++++++++++++
>  kernel/time/Kconfig                           | 10 ++++++++++
>  kernel/time/Makefile                          |  1 +
>  kernel/time/boot_time_now.c                   | 13 +++++++++++++

This does too many things at once. See Documentation.

One patch for creating the infrastructure with a proper rationale and
then one which hooks it up.

Again:

    Documentation has not been written to be ignored. RFC patches are
    not exempt from that.

> +static inline u64 arch_boot_counter_now(void)
> +{
> +	return ((arch_timer_read_cntvct_el0() * 1000000) / arch_timer_get_cntfr=
q());
> +}

Q: What guarantees that this timer is available and functional at this
   point?

A: Nothing

> +++ b/include/linux/boot_time_now.h

What means boot_time_now?

You couldn't come up with a less non-descriptive name, right?

> +enum kernel_bootstage_id {
> +	BOOTSTAGE_ID_KERNEL_START =3D 300,
> +	BOOTSTAGE_ID_KERNEL_END =3D 301,

Aside of the formatting (See Documentation), these are random numbers
pulled out of thin air without any explanation why they need to start at
300.

> +};
> +
> +/* Return boot time in nanoseconds using hardware counter */
> +u64 boot_time_now(void);

That's a function name which is as bad as is can be. This is about
getting an early time stamp and that needs to be properly named _AND_
encapsulated so it works universally without some magic hardware
dependency. If at all, see below.

>  #include <kunit/test.h>
>=20=20
> +#ifdef CONFIG_BOOT_TIME_TRACKER
> +#include <linux/boot_time_now.h>
> +#endif

What's this ifdeffery for? Headers have to be written in a way that they
can be unconditionally included. IOW, put the ifdeffery into the header.

> @@ -929,6 +933,11 @@ void start_kernel(void)
>  	page_address_init();
>  	pr_notice("%s", linux_banner);
>  	setup_arch(&command_line);
> +
> +#ifdef CONFIG_BOOT_TIME_TRACKER
> +	pr_info("[BOOT TRACKER] - ID:%d, %s =3D %llu\n",
> +		BOOTSTAGE_ID_KERNEL_START, __func__, boot_time_now());
> +#endif

Seriously? Have you looked at all the functions invoked in this file?

Those which depend on a config have:

#ifdef CONFIG_FOO
void foo_init(void);
#else
static inline void foo_init(void) { }
#endif

in the headers to avoid this horrible #ifdef maze. No?

> diff --git a/kernel/time/boot_time_now.c b/kernel/time/boot_time_now.c
> new file mode 100644
> index 000000000000..6dc12d454be0
> --- /dev/null
> +++ b/kernel/time/boot_time_now.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: LGPL-2.0
> +
> +#include <linux/boot_time_now.h>
> +#include <asm/boot_time_primitives.h>
> +
> +u64 boot_time_now(void)
> +{
> +	return arch_boot_counter_now();
> +}
> +EXPORT_SYMBOL_GPL(boot_time_now);

Why does this need to exported for modules when the only users are
always built in?

> +
> +MODULE_DESCRIPTION("boot time tracker");
> +MODULE_LICENSE("GPL");

Why needs this a module description? This has always to be built in, no?

Copy and pasta from some boilerplate template is fine, but using brain
on what to paste is not optional.

But that's all irrelevant, because none of this is actually required in
the first place as there is existing infrastructure, which allows you to
gather most of that information already today.

Extending it to gain what you really want to achieve is trivial enough
when you actually start to look at the existing infrastructure instead
of blindly hacking some ill-defined mechanism into the kernel, which
relies on the assumption that a particular piece of hardware is
available and functional.

That assumption is not even true for ARM64 under all circumstances.

dmesg already exposes time stamps and while they might be coarse grained
until a sched clock is registered, you still can utilize that
registration:

--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -236,16 +236,14 @@ sched_clock_register(u64 (*read)(void),
 	/* Calculate the ns resolution of this counter */
 	res =3D cyc_to_ns(1ULL, new_mult, new_shift);
=20
-	pr_info("sched_clock: %u bits at %lu%cHz, resolution %lluns, wraps every =
%lluns\n",
-		bits, r, r_unit, res, wrap);
+	pr_info("sched_clock: %pS: %u bits at %lu%cHz, resolution %lluns, wraps e=
very %lluns hwcnt: %llu\n",
+		read, bits, r, r_unit, res, wrap, read());
=20
 	/* Enable IRQ time accounting if we have a fast enough sched_clock() */
 	if (irqtime > 0 || (irqtime =3D=3D -1 && rate >=3D 1000000))
 		enable_sched_clock_irqtime();
=20
 	local_irq_restore(flags);
-
-	pr_debug("Registered %pS as sched_clock source\n", read);
 }
=20
 void __init generic_sched_clock_init(void)

That message provides you all the information you need for your pretty
printed postprocessing results by re-calculating all the other coarse
grained dmesg timestamps from there, no?

That obviously does not work on architectures which do no use the
sched_clock infrastructure. Some of them do not for a good reason, but
emitting the same information for them if anyone is interested is
trivial enough. And that's none of your problems.

If you really need some not yet existing dedicated time stamp in the
maze of dmesg, then add it unconditionlly and without introducing an
artifical subsystem which is of no value at all.

But I tell you that's not necessary at all. The points in dmesg are well
defined. Here is the relevant output on a arm64 machine:

[    0.000000] Linux version 6.17.0-rc1 ...
...
[    0.000008] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every =
3579139424256ns

which is missing the actual hardware value, but see above...

So let's assume this give you

[    0.000008] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
                            every 3579139424256ns hwcnt: 19000000

Which means that the counter accumulated 19000000 increments since the
hardware was powered up, no?

So the [0.000008] timestamp happens exactly 1.0 seconds after power on.
At least to my understanding of basic math, but your favourite AI bot
might disagree with that.

So anything you need for your pretty printing boot record can be
retrieved from there without any magic 300 and 301 numbers.

Because there is another printk() which has been there forever:

[   11.651192] Run /init as init process

No?

Thanks,

        tglx

