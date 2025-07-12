Return-Path: <linux-kernel+bounces-728552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09854B029DD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486A416A305
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F701222596;
	Sat, 12 Jul 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CHNcMGEG"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA518D656
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752307149; cv=none; b=N1JNaKRVOfCIluFdZ2WeNXE1TDtwhat/h6l/Fu7A+U2YKjVmLqMSe3oi9cgB9mQ2Zoy7Sg7VPBBlBObR7EGPgNIk02DHtBq5XPjhhFNQa6+pCCT+EHZICefM6o9wdy+YqDb5U5OrrN0httQ5GcvC3B0ne0TwXbI7UUXIHhwKtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752307149; c=relaxed/simple;
	bh=FN0PQxfHuK3EdDCCrIxhlOUw64BdT+oDgcKFmxSohTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4IEYlCIPGLQKqWABTJifSaUVKnzwXNA0FgTV87cgRQ1eqfseyLEs8mB+s90Y/VedyFo+ZPlqvKeWSrUtNb4mcPB0jImSmaCapSWaIB/7yZdjK1xpF6M0VRhtRwuEKiZ6ih8RiErmm0eP7u7DRw2SBZe26ib04IwKCL2964aiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CHNcMGEG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MWm8gtta77OhCZYJzBCjZU15jwOIKmAxZkU5DSMCQSc=;
	t=1752307146; x=1753516746; b=CHNcMGEGrxE7N0BRtsB2znlCLSH4qx1VRuh+wPezj3l3RgN
	Wv4laIzLxWmfjbXNuv7WVlLPeyIf+mlp7G9V6e8FIHD9XaxrXwHNu1OfS6XsdHT0Giwiw6swtSmI8
	YS82nCVjG9MYG4V+hOGuTNPGf3MzpAbnyrs1YBa5lwl8h+H5dDcO3hAldgEy2bRlodmcf9rMDZSOU
	bbz3BlA/g/cFicbl3StrCIC9OHKbXv/4nuLC/i7/2vGpvYiMmdWYhhdWSUF26E8NoJgojjLg1YBXq
	88BE49EziNO+z/l/rAPvkXF7ly5NF8mDsL+OZodWgfsyNPBDRpVC7D4SCMxvubKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uaV83-000000005Gk-3KZz;
	Sat, 12 Jul 2025 09:58:40 +0200
Message-ID: <4e0ce353fe0a24b767226ecb9a8cca9382e2f7e4.camel@sipsolutions.net>
Subject: Re: [PATCH v10 09/13] x86/um: nommu: signal handling
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Sat, 12 Jul 2025 09:58:38 +0200
In-Reply-To: <m2y0su2oq2.wl-thehajime@gmail.com> (sfid-20250712_031615_221818_4D6FB371)
References: <cover.1750594487.git.thehajime@gmail.com>
		<548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
		<3b407ed711c5d7e1819da7513c3e320699473b2d.camel@sipsolutions.net>
		<m2sejl47ke.wl-thehajime@gmail.com>
		<734965ac85b2c4cf481cc98ac53052fd5064d30e.camel@sipsolutions.net>
		<m2plem3urj.wl-thehajime@gmail.com>
		<a9133d9a69843948078f590a102bad9302f3f554.camel@sipsolutions.net>
		<m2jz4r438h.wl-thehajime@gmail.com>	<m2zfdb38cn.wl-thehajime@gmail.com>
		<0ce9c6ed00f1f1800196786b231ead8d025dc796.camel@sipsolutions.net>
		<275554830167b1463257621e6d6555e7d30d67bd.camel@sipsolutions.net>
	 <m2y0su2oq2.wl-thehajime@gmail.com> (sfid-20250712_031615_221818_4D6FB371)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Sat, 2025-07-12 at 10:16 +0900, Hajime Tazaki wrote:
>=20
> Hello,
>=20
> > Honestly, I think we need a test case to be able to move forward. The
> > test needs to trigger an exception (FPE, segfault, whatever) and then
> > handle the signal. In the signal handler, verify the register state in
> > the mcontext is expected (RIP, RSP, FP regs), then update it to not
> > raise an exception again and return. The test should obviously exit
> > cleanly afterwards.
>=20
> I agree to have a test case.
>=20
> I played with your RFC patch ([RFC 0/2] Experimental kunit test for
> signal context handling), which I guess the similar one which you gave
> me in the past, with minor modification for nommu mode, and looks like
> that test passed.

That test triggers the signal emission using a self-kill (i.e. SIGSYS
and then the syscall entry point). The problems that I believe exist
will only happen if the kernel is entered for other reasons. I was
primarily thinking about exceptions (e.g. SIGFPE), but I suppose it
could even be scheduling right now (SIGALRM).

Benjamin


>=20
>=20
> (none):/#=C2=A0 /root/test-fp-save-restore=20
> TAP version 13
> 1..1
> # pre-signal:=C2=A0 50 / 100, 11223344 55667788 99aabbcc ddeeff00
> # sighandler: extended_size: 2700, xstate_size: 2696
> # post-signal: 51200 / 100, 11233345 55677789 99abbbcd ddefff01 (should c=
hange: 1, changed: 1)
> ok 1 mcontext
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>=20
>=20
> I couldn't invoke this test via `kunit.py run` (which I should
> investigate more), but this can be a good start to have the test case
> which you proposed.
>=20
> I will follow up the highlevel discussion on how syscall/signal
> entry/exit code is implemented in nommu, which I think I've been
> explained several times but why not :)
>=20
> -- Hajime
>=20
> On Fri, 11 Jul 2025 19:05:13 +0900,
> Benjamin Berg wrote:
> >=20
> > On Fri, 2025-07-11 at 11:39 +0200, Benjamin Berg wrote:
> > > [SNIP]
> > >=20
> > > That said, I would also still like to see a higher level discussion o=
n
> > > how userspace registers are saved and restored. We have two separate
> > > cases--interrupts/exceptions (host signals) and the syscall path--and
> > > both need to be well defined. My hope is still that both of these can
> > > use the same register save/restore mechanism.
> >=20
> > Now syscalls are also just signals. The crucial difference is that for=
=20
> > syscalls you are allowed to clobber R11 and RCX. Your current syscall
> > entry code uses that fact, but that does not work for other signals.
> >=20
> > Benjamin
> >=20
> > >=20
> > > Benjamin
> > >=20
> > > >=20
> > > > ---
> > > > =C2=A0arch/um/include/shared/kern_util.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 4 +
> > > > =C2=A0arch/um/nommu/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +-
> > > > =C2=A0arch/um/nommu/os-Linux/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> > > > =C2=A0arch/um/nommu/trap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 201
> > > > ++++++++++++++++++++++++
> > > > =C2=A0arch/um/os-Linux/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> > > > =C2=A0arch/x86/um/nommu/do_syscall_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > > > =C2=A0arch/x86/um/nommu/entry_64.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 ++
> > > > =C2=A0arch/x86/um/nommu/os-Linux/mcontext.c=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +
> > > > =C2=A0arch/x86/um/shared/sysdep/mcontext.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > > > =C2=A0arch/x86/um/shared/sysdep/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
> > > > =C2=A0arch/x86/um/shared/sysdep/syscalls_64.h |=C2=A0=C2=A0 1 +
> > > > =C2=A011 files changed, 244 insertions(+), 3 deletions(-)
> > > > =C2=A0create mode 100644 arch/um/nommu/trap.c
> > > >=20
> > > > diff --git a/arch/um/include/shared/kern_util.h
> > > > b/arch/um/include/shared/kern_util.h
> > > > index ec8ba1f13c58..7f55402b6385 100644
> > > > --- a/arch/um/include/shared/kern_util.h
> > > > +++ b/arch/um/include/shared/kern_util.h
> > > > @@ -73,4 +73,8 @@ void um_idle_sleep(void);
> > > > =C2=A0
> > > > =C2=A0void kasan_map_memory(void *start, size_t len);
> > > > =C2=A0
> > > > +#ifndef CONFIG_MMU
> > > > +extern void nommu_relay_signal(void *ptr);
> > > > +#endif
> > > > +
> > > > =C2=A0#endif
> > > > diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
> > > > index baab7c2f57c2..096221590cfd 100644
> > > > --- a/arch/um/nommu/Makefile
> > > > +++ b/arch/um/nommu/Makefile
> > > > @@ -1,3 +1,3 @@
> > > > =C2=A0# SPDX-License-Identifier: GPL-2.0
> > > > =C2=A0
> > > > -obj-y :=3D os-Linux/
> > > > +obj-y :=3D trap.o os-Linux/
> > > > diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-
> > > > Linux/signal.c
> > > > index 19043b9652e2..27b6b37744b7 100644
> > > > --- a/arch/um/nommu/os-Linux/signal.c
> > > > +++ b/arch/um/nommu/os-Linux/signal.c
> > > > @@ -5,6 +5,7 @@
> > > > =C2=A0#include <os.h>
> > > > =C2=A0#include <sysdep/mcontext.h>
> > > > =C2=A0#include <sys/ucontext.h>
> > > > +#include <as-layout.h>
> > > > =C2=A0
> > > > =C2=A0void sigsys_handler(int sig, struct siginfo *si,
> > > > =C2=A0		=C2=A0=C2=A0=C2=A0 struct uml_pt_regs *regs, void *ptr)
> > > > @@ -14,3 +15,10 @@ void sigsys_handler(int sig, struct siginfo *si,
> > > > =C2=A0	/* hook syscall via SIGSYS */
> > > > =C2=A0	set_mc_sigsys_hook(mc);
> > > > =C2=A0}
> > > > +
> > > > +void nommu_relay_signal(void *ptr)
> > > > +{
> > > > +	mcontext_t *mc =3D (mcontext_t *) ptr;
> > > > +
> > > > +	set_mc_return_address(mc);
> > > > +}
> > > > diff --git a/arch/um/nommu/trap.c b/arch/um/nommu/trap.c
> > > > new file mode 100644
> > > > index 000000000000..430297517455
> > > > --- /dev/null
> > > > +++ b/arch/um/nommu/trap.c
> > > > @@ -0,0 +1,201 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include <linux/mm.h>
> > > > +#include <linux/sched/signal.h>
> > > > +#include <linux/hardirq.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/uaccess.h>
> > > > +#include <linux/sched/debug.h>
> > > > +#include <asm/current.h>
> > > > +#include <asm/tlbflush.h>
> > > > +#include <arch.h>
> > > > +#include <as-layout.h>
> > > > +#include <kern_util.h>
> > > > +#include <os.h>
> > > > +#include <skas.h>
> > > > +
> > > > +/*
> > > > + * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM
> > > > by
> > > > + * segv().
> > > > + */
> > > > +int handle_page_fault(unsigned long address, unsigned long ip,
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int is_write, int is_user, int *c=
ode_out)
> > > > +{
> > > > +	/* !MMU has no pagefault */
> > > > +	return -EFAULT;
> > > > +}
> > > > +
> > > > +static void show_segv_info(struct uml_pt_regs *regs)
> > > > +{
> > > > +	struct task_struct *tsk =3D current;
> > > > +	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> > > > +
> > > > +	if (!unhandled_signal(tsk, SIGSEGV))
> > > > +		return;
> > > > +
> > > > +	pr_warn_ratelimited("%s%s[%d]: segfault at %lx ip %p sp %p
> > > > error %x",
> > > > +			=C2=A0=C2=A0=C2=A0 task_pid_nr(tsk) > 1 ? KERN_INFO :
> > > > KERN_EMERG,
> > > > +			=C2=A0=C2=A0=C2=A0 tsk->comm, task_pid_nr(tsk),
> > > > FAULT_ADDRESS(*fi),
> > > > +			=C2=A0=C2=A0=C2=A0 (void *)UPT_IP(regs), (void
> > > > *)UPT_SP(regs),
> > > > +			=C2=A0=C2=A0=C2=A0 fi->error_code);
> > > > +}
> > > > +
> > > > +static void bad_segv(struct faultinfo fi, unsigned long ip)
> > > > +{
> > > > +	current->thread.arch.faultinfo =3D fi;
> > > > +	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *)
> > > > FAULT_ADDRESS(fi));
> > > > +}
> > > > +
> > > > +void fatal_sigsegv(void)
> > > > +{
> > > > +	force_fatal_sig(SIGSEGV);
> > > > +	do_signal(&current->thread.regs);
> > > > +	/*
> > > > +	 * This is to tell gcc that we're not returning -
> > > > do_signal
> > > > +	 * can, in general, return, but in this case, it's not,
> > > > since
> > > > +	 * we just got a fatal SIGSEGV queued.
> > > > +	 */
> > > > +	os_dump_core();
> > > > +}
> > > > +
> > > > +/**
> > > > + * segv_handler() - the SIGSEGV handler
> > > > + * @sig:	the signal number
> > > > + * @unused_si:	the signal info struct; unused in this handler
> > > > + * @regs:	the ptrace register information
> > > > + *
> > > > + * The handler first extracts the faultinfo from the UML ptrace
> > > > regs struct.
> > > > + * If the userfault did not happen in an UML userspace process,
> > > > bad_segv is called.
> > > > + * Otherwise the signal did happen in a cloned userspace process,
> > > > handle it.
> > > > + */
> > > > +void segv_handler(int sig, struct siginfo *unused_si, struct
> > > > uml_pt_regs *regs,
> > > > +		=C2=A0 void *mc)
> > > > +{
> > > > +	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> > > > +
> > > > +	/* !MMU specific part; detection of userspace */
> > > > +	/* mark is_user=3D1 when the IP is from userspace code. */
> > > > +	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) <
> > > > high_physmem)
> > > > +		regs->is_user =3D 1;
> > > > +
> > > > +	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
> > > > +		show_segv_info(regs);
> > > > +		bad_segv(*fi, UPT_IP(regs));
> > > > +		return;
> > > > +	}
> > > > +	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs, mc);
> > > > +
> > > > +	/* !MMU specific part; detection of userspace */
> > > > +	relay_signal(sig, unused_si, regs, mc);
> > > > +}
> > > > +
> > > > +/*
> > > > + * We give a *copy* of the faultinfo in the regs to segv.
> > > > + * This must be done, since nesting SEGVs could overwrite
> > > > + * the info in the regs. A pointer to the info then would
> > > > + * give us bad data!
> > > > + */
> > > > +unsigned long segv(struct faultinfo fi, unsigned long ip, int
> > > > is_user,
> > > > +		=C2=A0=C2=A0 struct uml_pt_regs *regs, void *mc)
> > > > +{
> > > > +	int si_code;
> > > > +	int err;
> > > > +	int is_write =3D FAULT_WRITE(fi);
> > > > +	unsigned long address =3D FAULT_ADDRESS(fi);
> > > > +
> > > > +	if (!is_user && regs)
> > > > +		current->thread.segv_regs =3D container_of(regs,
> > > > struct pt_regs, regs);
> > > > +
> > > > +	if (current->mm =3D=3D NULL) {
> > > > +		show_regs(container_of(regs, struct pt_regs,
> > > > regs));
> > > > +		panic("Segfault with no mm");
> > > > +	} else if (!is_user && address > PAGE_SIZE && address <
> > > > TASK_SIZE) {
> > > > +		show_regs(container_of(regs, struct pt_regs,
> > > > regs));
> > > > +		panic("Kernel tried to access user memory at addr
> > > > 0x%lx, ip 0x%lx",
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 address, ip);
> > > > +	}
> > > > +
> > > > +	if (SEGV_IS_FIXABLE(&fi))
> > > > +		err =3D handle_page_fault(address, ip, is_write,
> > > > is_user,
> > > > +					&si_code);
> > > > +	else {
> > > > +		err =3D -EFAULT;
> > > > +		/*
> > > > +		 * A thread accessed NULL, we get a fault, but CR2
> > > > is invalid.
> > > > +		 * This code is used in __do_copy_from_user() of
> > > > TT mode.
> > > > +		 * XXX tt mode is gone, so maybe this isn't needed
> > > > any more
> > > > +		 */
> > > > +		address =3D 0;
> > > > +	}
> > > > +
> > > > +	if (!err)
> > > > +		goto out;
> > > > +	else if (!is_user && arch_fixup(ip, regs))
> > > > +		goto out;
> > > > +
> > > > +	if (!is_user) {
> > > > +		show_regs(container_of(regs, struct pt_regs,
> > > > regs));
> > > > +		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 address, ip);
> > > > +	}
> > > > +
> > > > +	show_segv_info(regs);
> > > > +
> > > > +	if (err =3D=3D -EACCES) {
> > > > +		current->thread.arch.faultinfo =3D fi;
> > > > +		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user
> > > > *)address);
> > > > +	} else {
> > > > +		WARN_ON_ONCE(err !=3D -EFAULT);
> > > > +		current->thread.arch.faultinfo =3D fi;
> > > > +		force_sig_fault(SIGSEGV, si_code, (void __user *)
> > > > address);
> > > > +	}
> > > > +
> > > > +out:
> > > > +	if (regs)
> > > > +		current->thread.segv_regs =3D NULL;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs
> > > > *regs,
> > > > +		=C2=A0 void *mc)
> > > > +{
> > > > +	int code, err;
> > > > +
> > > > +	/* !MMU specific part; detection of userspace */
> > > > +	/* mark is_user=3D1 when the IP is from userspace code. */
> > > > +	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) <
> > > > high_physmem)
> > > > +		regs->is_user =3D 1;
> > > > +
> > > > +	if (!UPT_IS_USER(regs)) {
> > > > +		if (sig =3D=3D SIGBUS)
> > > > +			pr_err("Bus error - the host /dev/shm or
> > > > /tmp mount likely just ran out of space\n");
> > > > +		panic("Kernel mode signal %d", sig);
> > > > +	}
> > > > +	/* if is_user=3D=3D1, set return to userspace sig handler to
> > > > relay signal */
> > > > +	nommu_relay_signal(mc);
> > > > +
> > > > +	arch_examine_signal(sig, regs);
> > > > +
> > > > +	/* Is the signal layout for the signal known?
> > > > +	 * Signal data must be scrubbed to prevent information
> > > > leaks.
> > > > +	 */
> > > > +	code =3D si->si_code;
> > > > +	err =3D si->si_errno;
> > > > +	if ((err =3D=3D 0) && (siginfo_layout(sig, code) =3D=3D
> > > > SIL_FAULT)) {
> > > > +		struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> > > > +
> > > > +		current->thread.arch.faultinfo =3D *fi;
> > > > +		force_sig_fault(sig, code, (void __user
> > > > *)FAULT_ADDRESS(*fi));
> > > > +	} else {
> > > > +		pr_err("Attempted to relay unknown signal %d
> > > > (si_code =3D %d) with errno %d\n",
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sig, code, err);
> > > > +		force_sig(sig);
> > > > +	}
> > > > +}
> > > > +
> > > > +void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs
> > > > *regs,
> > > > +	=C2=A0=C2=A0 void *mc)
> > > > +{
> > > > +	do_IRQ(WINCH_IRQ, regs);
> > > > +}
> > > > diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> > > > index 53e276e81b37..67dcd88b45b1 100644
> > > > --- a/arch/um/os-Linux/signal.c
> > > > +++ b/arch/um/os-Linux/signal.c
> > > > @@ -40,9 +40,10 @@ static void sig_handler_common(int sig, struct
> > > > siginfo *si, mcontext_t *mc)
> > > > =C2=A0	int save_errno =3D errno;
> > > > =C2=A0
> > > > =C2=A0	r.is_user =3D 0;
> > > > +	if (mc)
> > > > +		get_regs_from_mc(&r, mc);
> > > > =C2=A0	if (sig =3D=3D SIGSEGV) {
> > > > =C2=A0		/* For segfaults, we want the data from the
> > > > sigcontext. */
> > > > -		get_regs_from_mc(&r, mc);
> > > > =C2=A0		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
> > > > =C2=A0	}
> > > > =C2=A0
> > > > diff --git a/arch/x86/um/nommu/do_syscall_64.c
> > > > b/arch/x86/um/nommu/do_syscall_64.c
> > > > index 74d5bcc4508d..d77e69e097c1 100644
> > > > --- a/arch/x86/um/nommu/do_syscall_64.c
> > > > +++ b/arch/x86/um/nommu/do_syscall_64.c
> > > > @@ -44,6 +44,9 @@ __visible void do_syscall_64(struct pt_regs
> > > > *regs)
> > > > =C2=A0	/* set fs register to the original host one */
> > > > =C2=A0	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
> > > > =C2=A0
> > > > +	/* save fp registers */
> > > > +	asm volatile("fxsaveq %0" : "=3Dm"(*(struct _xstate *)regs-
> > > > > regs.fp));
> > > > +
> > > > =C2=A0	if (likely(syscall < NR_syscalls)) {
> > > > =C2=A0		PT_REGS_SET_SYSCALL_RETURN(regs,
> > > > =C2=A0				EXECUTE_SYSCALL(syscall, regs));
> > > > @@ -54,6 +57,9 @@ __visible void do_syscall_64(struct pt_regs
> > > > *regs)
> > > > =C2=A0	/* handle tasks and signals at the end */
> > > > =C2=A0	interrupt_end();
> > > > =C2=A0
> > > > +	/* restore fp registers */
> > > > +	asm volatile("fxrstorq %0" : : "m"((current-
> > > > > thread.regs.regs.fp)));
> > > > +
> > > > =C2=A0	/* restore back fs register to userspace configured one */
> > > > =C2=A0	os_x86_arch_prctl(0, ARCH_SET_FS,
> > > > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)(current-
> > > > > thread.regs.regs.gp[FS_BASE
> > > > diff --git a/arch/x86/um/nommu/entry_64.S
> > > > b/arch/x86/um/nommu/entry_64.S
> > > > index 950447dfa66b..e038bc7b53ac 100644
> > > > --- a/arch/x86/um/nommu/entry_64.S
> > > > +++ b/arch/x86/um/nommu/entry_64.S
> > > > @@ -111,3 +111,17 @@ ENTRY(userspace)
> > > > =C2=A0	jmp	*%r11
> > > > =C2=A0
> > > > =C2=A0END(userspace)
> > > > +
> > > > +/*
> > > > + * this routine prepares the stack to return via host-generated
> > > > + * signals (e.g., SEGV, FPE) via do_signal() from interrupt_end().
> > > > + */
> > > > +ENTRY(__prep_sigreturn)
> > > > +	/*
> > > > +	 * Switch to current top of stack, so "current->" points
> > > > +	 * to the right task.
> > > > +	 */
> > > > +	movq	current_top_of_stack, %rsp
> > > > +
> > > > +	jmp	userspace
> > > > +END(__prep_sigreturn)
> > > > diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c
> > > > b/arch/x86/um/nommu/os-Linux/mcontext.c
> > > > index c4ef877d5ea0..87fb2a35e7ff 100644
> > > > --- a/arch/x86/um/nommu/os-Linux/mcontext.c
> > > > +++ b/arch/x86/um/nommu/os-Linux/mcontext.c
> > > > @@ -6,6 +6,11 @@
> > > > =C2=A0#include <sysdep/mcontext.h>
> > > > =C2=A0#include <sysdep/syscalls.h>
> > > > =C2=A0
> > > > +void set_mc_return_address(mcontext_t *mc)
> > > > +{
> > > > +	mc->gregs[REG_RIP] =3D (unsigned long) __prep_sigreturn;
> > > > +}
> > > > +
> > > > =C2=A0void set_mc_sigsys_hook(mcontext_t *mc)
> > > > =C2=A0{
> > > > =C2=A0	mc->gregs[REG_RCX] =3D mc->gregs[REG_RIP];
> > > > diff --git a/arch/x86/um/shared/sysdep/mcontext.h
> > > > b/arch/x86/um/shared/sysdep/mcontext.h
> > > > index 9a0d6087f357..de4041b758f3 100644
> > > > --- a/arch/x86/um/shared/sysdep/mcontext.h
> > > > +++ b/arch/x86/um/shared/sysdep/mcontext.h
> > > > @@ -19,6 +19,7 @@ extern int set_stub_state(struct uml_pt_regs
> > > > *regs, struct stub_data *data,
> > > > =C2=A0
> > > > =C2=A0#ifndef CONFIG_MMU
> > > > =C2=A0extern void set_mc_sigsys_hook(mcontext_t *mc);
> > > > +extern void set_mc_return_address(mcontext_t *mc);
> > > > =C2=A0#endif
> > > > =C2=A0
> > > > =C2=A0#ifdef __i386__
> > > > diff --git a/arch/x86/um/shared/sysdep/ptrace.h
> > > > b/arch/x86/um/shared/sysdep/ptrace.h
> > > > index 8f7476ff6e95..7d553d9f05be 100644
> > > > --- a/arch/x86/um/shared/sysdep/ptrace.h
> > > > +++ b/arch/x86/um/shared/sysdep/ptrace.h
> > > > @@ -65,7 +65,7 @@ struct uml_pt_regs {
> > > > =C2=A0	int is_user;
> > > > =C2=A0
> > > > =C2=A0	/* Dynamically sized FP registers (holds an XSTATE) */
> > > > -	unsigned long fp[];
> > > > +	unsigned long fp[] __attribute__((aligned(16)));
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0#define EMPTY_UML_PT_REGS { }
> > > > diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h
> > > > b/arch/x86/um/shared/sysdep/syscalls_64.h
> > > > index ffd80ee3b9dc..bd152422cdfb 100644
> > > > --- a/arch/x86/um/shared/sysdep/syscalls_64.h
> > > > +++ b/arch/x86/um/shared/sysdep/syscalls_64.h
> > > > @@ -29,6 +29,7 @@ extern syscall_handler_t sys_arch_prctl;
> > > > =C2=A0extern void do_syscall_64(struct pt_regs *regs);
> > > > =C2=A0extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t=
 a2,
> > > > int64_t a3,
> > > > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t a4, int64_t a5, int=
64_t a6);
> > > > +extern void __prep_sigreturn(void);
> > > > =C2=A0#endif
> > > > =C2=A0
> > > > =C2=A0#endif
> > >=20
> >=20
>=20


