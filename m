Return-Path: <linux-kernel+bounces-728483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C8B028CE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF80A65B13
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BD12CD96;
	Sat, 12 Jul 2025 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DESpj0Dt"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AC111BF
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752282974; cv=none; b=T3zSx4Ufs8N7VAi3rG7ksTNVQwqspR50OoZ87uiFGDNTK2JTGl5WNk92BwnTl0A5ZK6mii386H6hiKbj/Ny3QkO2i08KswQhjJZbw1tRY2LtEekrhEniw/N06NQ8D7GZv0BWO3LByq4GH/7e6x+Tcgy7E9IHH9QuHVrW0AvPC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752282974; c=relaxed/simple;
	bh=LauKrYSoe/zuoqXArhlY+vkKn8XBb7PEmyydABWCwY8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W114lSCeVJ2SoSB/BmzCfJe0JiI3ceM0n6BnZVBqta7D8ZppjQv4uh/bI5V3p+LSYsTB6vFIlEZg9eISOvbvmxXMssymGK4SzXZkSK1ndQLxOKqb1YvO4WZ69/AfVScM3wp/S5cFkqDhceMI0JLN4H9rUrfhAHxz71CkCjQ43Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DESpj0Dt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234bfe37cccso23790045ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752282971; x=1752887771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B96SylzwiHccgvrXlIEPWGTmc9ApyqR+uXyZTODCqtA=;
        b=DESpj0DtAt9SF0dS4jTj26vmLXoXr/b69DLPJTy2HgxI/K2v8LL/DIK7xJjraQ9i9g
         Es5NK/6AssTRHIeP19UaBdovTCFP8e+VGb4hnguxEdR/9BrfaFAnM7sh7yEFuhxLxSTm
         31E2Kc63SSpUMc+kUhaxQES0j8CNFUAqFhevZXKQpU0YLVS7DXsNxFlRxB9/v5QyNuSz
         eHt/F0gHyI4GKS2Up3SuYXMG7XivjpzYtQXFsbmW23Ro74C50qEiyIbLBiX+5PHi7WHD
         H7wXYteEg2wLiTTAtGC9y+FlCOXcxsPUcYfn76EtKEqfAriYuVuQxrKTaatPdQF98f49
         wxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752282971; x=1752887771;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B96SylzwiHccgvrXlIEPWGTmc9ApyqR+uXyZTODCqtA=;
        b=e7E6h1QtUgBiwWsptAh3Fb6SyUFKvI9H5Wi4PntcCtcJuISYMfNZsIPVs7tGSw0niT
         Vqk//QbbjAPE5qc5t75mZwNZAM8DKxHdoKvilgukXC1fTtaFtCm8JGA5l+JRs3O3sNHB
         YMiU0adcZI434xQffHjDzoRJNGef+8D6MPeEwU7RYGqhyntVP7GqKxwFqXOvQ1q+dyd6
         KAqpiSgSBZavEyVHvXNZ4uvxcUMARVIFbay4inKHJbdRDhohohyToJyuzX/3cQ0S40ca
         BzNFnDool54fGqYVLHAm9MmYEkT0RB5/mWDM430UqYN0j3DpL84OLDh4/6U7N61GKWqR
         S7RA==
X-Forwarded-Encrypted: i=1; AJvYcCWf0OOGpYQOIdeCIuYrpScrLz9HBhBERNcfd48gmT7qoXDreEJ/kwjTifgb6o7xRWkQVV2t8enOZBqm/2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFpDYuWo4iykSnsneoK+VAxuOnV8GNB2ltsWaxFfKlkonEzx5F
	Vhz1rDiLSK3qaOLnS2Fl1C2e3DRaMp2LetyBh8LGY1gcHWwrxps65IG6
X-Gm-Gg: ASbGnctTt+zzbH38B8NNIuXSEuesQ1Oa/A6316M9jkhYEAjbONxuh+udQySAVXMBm8A
	gYunHjB+2t61i4l5nU/tNnuRkctf7ss1ZVaVQyAvSaEUtQ5gCO16XgW//UyR9BFTICFv88d2bRo
	Wi4LZD5vgflNImLItZeLHVQhaJ903b+plaqTM3wlG1+en5mAVlNND+tfQvXyG5HeMIJK3e0jUys
	vUOLzeb5dnydL/Jzr+yEvC0g+4obojMVY/TK6ItDkILECL1/BjcQLbocL+2siVFG5Ci04o3I1GL
	UNuKrzBWZGzZH0xvUdn4P7dlZxrP/1P8xdoCdi3rLcbwFYzG7KdbJtkTkGWMFkC+TDn5F5rlTpz
	tIVnFp8w2icSs06ILNAnojdk0a264uOdbdnNEVnU7O2uTBKnMXvJNyAFdqvG4LvtX6BixPE8W/B
	5eTBrcGaOl
X-Google-Smtp-Source: AGHT+IH9clS8L8aUmPAYrCvyCbd1AL2jD0M7ak1kUBgr/oXCgJv30GR3xdxjJZKcXxXCeeRlpcrNrw==
X-Received: by 2002:a17:902:f707:b0:234:9068:ed99 with SMTP id d9443c01a7336-23dede860afmr91719725ad.24.1752282971296;
        Fri, 11 Jul 2025 18:16:11 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f56a9sm5730840a12.59.2025.07.11.18.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 18:16:08 -0700 (PDT)
Date: Sat, 12 Jul 2025 10:16:05 +0900
Message-ID: <m2y0su2oq2.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 09/13] x86/um: nommu: signal handling
In-Reply-To: <275554830167b1463257621e6d6555e7d30d67bd.camel@sipsolutions.net>
References: <cover.1750594487.git.thehajime@gmail.com>
	<548dcef198b79a4f8eb166481e39abe6e13ed2e3.1750594487.git.thehajime@gmail.com>
	<3b407ed711c5d7e1819da7513c3e320699473b2d.camel@sipsolutions.net>
	<m2sejl47ke.wl-thehajime@gmail.com>
	<734965ac85b2c4cf481cc98ac53052fd5064d30e.camel@sipsolutions.net>
	<m2plem3urj.wl-thehajime@gmail.com>
	<a9133d9a69843948078f590a102bad9302f3f554.camel@sipsolutions.net>
	<m2jz4r438h.wl-thehajime@gmail.com>
	<m2zfdb38cn.wl-thehajime@gmail.com>
	<0ce9c6ed00f1f1800196786b231ead8d025dc796.camel@sipsolutions.net>
	<275554830167b1463257621e6d6555e7d30d67bd.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hello,

> Honestly, I think we need a test case to be able to move forward. The
> test needs to trigger an exception (FPE, segfault, whatever) and then
> handle the signal. In the signal handler, verify the register state in
> the mcontext is expected (RIP, RSP, FP regs), then update it to not
> raise an exception again and return. The test should obviously exit
> cleanly afterwards.

I agree to have a test case.

I played with your RFC patch ([RFC 0/2] Experimental kunit test for
signal context handling), which I guess the similar one which you gave
me in the past, with minor modification for nommu mode, and looks like
that test passed.


(none):/#  /root/test-fp-save-restore=20
TAP version 13
1..1
# pre-signal:  50 / 100, 11223344 55667788 99aabbcc ddeeff00
# sighandler: extended_size: 2700, xstate_size: 2696
# post-signal: 51200 / 100, 11233345 55677789 99abbbcd ddefff01 (should cha=
nge: 1, changed: 1)
ok 1 mcontext
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0


I couldn't invoke this test via `kunit.py run` (which I should
investigate more), but this can be a good start to have the test case
which you proposed.

I will follow up the highlevel discussion on how syscall/signal
entry/exit code is implemented in nommu, which I think I've been
explained several times but why not :)

-- Hajime

On Fri, 11 Jul 2025 19:05:13 +0900,
Benjamin Berg wrote:
>=20
> On Fri, 2025-07-11 at 11:39 +0200, Benjamin Berg wrote:
> > [SNIP]
> >=20
> > That said, I would also still like to see a higher level discussion on
> > how userspace registers are saved and restored. We have two separate
> > cases--interrupts/exceptions (host signals) and the syscall path--and
> > both need to be well defined. My hope is still that both of these can
> > use the same register save/restore mechanism.
>=20
> Now syscalls are also just signals. The crucial difference is that for=20
> syscalls you are allowed to clobber R11 and RCX. Your current syscall
> entry code uses that fact, but that does not work for other signals.
>=20
> Benjamin
>=20
> >=20
> > Benjamin
> >=20
> > >=20
> > > ---
> > > =A0arch/um/include/shared/kern_util.h=A0=A0=A0=A0=A0 |=A0=A0 4 +
> > > =A0arch/um/nommu/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 2 +-
> > > =A0arch/um/nommu/os-Linux/signal.c=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 +
> > > =A0arch/um/nommu/trap.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | 201
> > > ++++++++++++++++++++++++
> > > =A0arch/um/os-Linux/signal.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 3 +-
> > > =A0arch/x86/um/nommu/do_syscall_64.c=A0=A0=A0=A0=A0=A0 |=A0=A0 6 +
> > > =A0arch/x86/um/nommu/entry_64.S=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
 14 ++
> > > =A0arch/x86/um/nommu/os-Linux/mcontext.c=A0=A0 |=A0=A0 5 +
> > > =A0arch/x86/um/shared/sysdep/mcontext.h=A0=A0=A0 |=A0=A0 1 +
> > > =A0arch/x86/um/shared/sysdep/ptrace.h=A0=A0=A0=A0=A0 |=A0=A0 2 +-
> > > =A0arch/x86/um/shared/sysdep/syscalls_64.h |=A0=A0 1 +
> > > =A011 files changed, 244 insertions(+), 3 deletions(-)
> > > =A0create mode 100644 arch/um/nommu/trap.c
> > >=20
> > > diff --git a/arch/um/include/shared/kern_util.h
> > > b/arch/um/include/shared/kern_util.h
> > > index ec8ba1f13c58..7f55402b6385 100644
> > > --- a/arch/um/include/shared/kern_util.h
> > > +++ b/arch/um/include/shared/kern_util.h
> > > @@ -73,4 +73,8 @@ void um_idle_sleep(void);
> > > =A0
> > > =A0void kasan_map_memory(void *start, size_t len);
> > > =A0
> > > +#ifndef CONFIG_MMU
> > > +extern void nommu_relay_signal(void *ptr);
> > > +#endif
> > > +
> > > =A0#endif
> > > diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
> > > index baab7c2f57c2..096221590cfd 100644
> > > --- a/arch/um/nommu/Makefile
> > > +++ b/arch/um/nommu/Makefile
> > > @@ -1,3 +1,3 @@
> > > =A0# SPDX-License-Identifier: GPL-2.0
> > > =A0
> > > -obj-y :=3D os-Linux/
> > > +obj-y :=3D trap.o os-Linux/
> > > diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-
> > > Linux/signal.c
> > > index 19043b9652e2..27b6b37744b7 100644
> > > --- a/arch/um/nommu/os-Linux/signal.c
> > > +++ b/arch/um/nommu/os-Linux/signal.c
> > > @@ -5,6 +5,7 @@
> > > =A0#include <os.h>
> > > =A0#include <sysdep/mcontext.h>
> > > =A0#include <sys/ucontext.h>
> > > +#include <as-layout.h>
> > > =A0
> > > =A0void sigsys_handler(int sig, struct siginfo *si,
> > > =A0		=A0=A0=A0 struct uml_pt_regs *regs, void *ptr)
> > > @@ -14,3 +15,10 @@ void sigsys_handler(int sig, struct siginfo *si,
> > > =A0	/* hook syscall via SIGSYS */
> > > =A0	set_mc_sigsys_hook(mc);
> > > =A0}
> > > +
> > > +void nommu_relay_signal(void *ptr)
> > > +{
> > > +	mcontext_t *mc =3D (mcontext_t *) ptr;
> > > +
> > > +	set_mc_return_address(mc);
> > > +}
> > > diff --git a/arch/um/nommu/trap.c b/arch/um/nommu/trap.c
> > > new file mode 100644
> > > index 000000000000..430297517455
> > > --- /dev/null
> > > +++ b/arch/um/nommu/trap.c
> > > @@ -0,0 +1,201 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/mm.h>
> > > +#include <linux/sched/signal.h>
> > > +#include <linux/hardirq.h>
> > > +#include <linux/module.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/sched/debug.h>
> > > +#include <asm/current.h>
> > > +#include <asm/tlbflush.h>
> > > +#include <arch.h>
> > > +#include <as-layout.h>
> > > +#include <kern_util.h>
> > > +#include <os.h>
> > > +#include <skas.h>
> > > +
> > > +/*
> > > + * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM
> > > by
> > > + * segv().
> > > + */
> > > +int handle_page_fault(unsigned long address, unsigned long ip,
> > > +		=A0=A0=A0=A0=A0 int is_write, int is_user, int *code_out)
> > > +{
> > > +	/* !MMU has no pagefault */
> > > +	return -EFAULT;
> > > +}
> > > +
> > > +static void show_segv_info(struct uml_pt_regs *regs)
> > > +{
> > > +	struct task_struct *tsk =3D current;
> > > +	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> > > +
> > > +	if (!unhandled_signal(tsk, SIGSEGV))
> > > +		return;
> > > +
> > > +	pr_warn_ratelimited("%s%s[%d]: segfault at %lx ip %p sp %p
> > > error %x",
> > > +			=A0=A0=A0 task_pid_nr(tsk) > 1 ? KERN_INFO :
> > > KERN_EMERG,
> > > +			=A0=A0=A0 tsk->comm, task_pid_nr(tsk),
> > > FAULT_ADDRESS(*fi),
> > > +			=A0=A0=A0 (void *)UPT_IP(regs), (void
> > > *)UPT_SP(regs),
> > > +			=A0=A0=A0 fi->error_code);
> > > +}
> > > +
> > > +static void bad_segv(struct faultinfo fi, unsigned long ip)
> > > +{
> > > +	current->thread.arch.faultinfo =3D fi;
> > > +	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *)
> > > FAULT_ADDRESS(fi));
> > > +}
> > > +
> > > +void fatal_sigsegv(void)
> > > +{
> > > +	force_fatal_sig(SIGSEGV);
> > > +	do_signal(&current->thread.regs);
> > > +	/*
> > > +	 * This is to tell gcc that we're not returning -
> > > do_signal
> > > +	 * can, in general, return, but in this case, it's not,
> > > since
> > > +	 * we just got a fatal SIGSEGV queued.
> > > +	 */
> > > +	os_dump_core();
> > > +}
> > > +
> > > +/**
> > > + * segv_handler() - the SIGSEGV handler
> > > + * @sig:	the signal number
> > > + * @unused_si:	the signal info struct; unused in this handler
> > > + * @regs:	the ptrace register information
> > > + *
> > > + * The handler first extracts the faultinfo from the UML ptrace
> > > regs struct.
> > > + * If the userfault did not happen in an UML userspace process,
> > > bad_segv is called.
> > > + * Otherwise the signal did happen in a cloned userspace process,
> > > handle it.
> > > + */
> > > +void segv_handler(int sig, struct siginfo *unused_si, struct
> > > uml_pt_regs *regs,
> > > +		=A0 void *mc)
> > > +{
> > > +	struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> > > +
> > > +	/* !MMU specific part; detection of userspace */
> > > +	/* mark is_user=3D1 when the IP is from userspace code. */
> > > +	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) <
> > > high_physmem)
> > > +		regs->is_user =3D 1;
> > > +
> > > +	if (UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)) {
> > > +		show_segv_info(regs);
> > > +		bad_segv(*fi, UPT_IP(regs));
> > > +		return;
> > > +	}
> > > +	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs, mc);
> > > +
> > > +	/* !MMU specific part; detection of userspace */
> > > +	relay_signal(sig, unused_si, regs, mc);
> > > +}
> > > +
> > > +/*
> > > + * We give a *copy* of the faultinfo in the regs to segv.
> > > + * This must be done, since nesting SEGVs could overwrite
> > > + * the info in the regs. A pointer to the info then would
> > > + * give us bad data!
> > > + */
> > > +unsigned long segv(struct faultinfo fi, unsigned long ip, int
> > > is_user,
> > > +		=A0=A0 struct uml_pt_regs *regs, void *mc)
> > > +{
> > > +	int si_code;
> > > +	int err;
> > > +	int is_write =3D FAULT_WRITE(fi);
> > > +	unsigned long address =3D FAULT_ADDRESS(fi);
> > > +
> > > +	if (!is_user && regs)
> > > +		current->thread.segv_regs =3D container_of(regs,
> > > struct pt_regs, regs);
> > > +
> > > +	if (current->mm =3D=3D NULL) {
> > > +		show_regs(container_of(regs, struct pt_regs,
> > > regs));
> > > +		panic("Segfault with no mm");
> > > +	} else if (!is_user && address > PAGE_SIZE && address <
> > > TASK_SIZE) {
> > > +		show_regs(container_of(regs, struct pt_regs,
> > > regs));
> > > +		panic("Kernel tried to access user memory at addr
> > > 0x%lx, ip 0x%lx",
> > > +		=A0=A0=A0=A0=A0=A0 address, ip);
> > > +	}
> > > +
> > > +	if (SEGV_IS_FIXABLE(&fi))
> > > +		err =3D handle_page_fault(address, ip, is_write,
> > > is_user,
> > > +					&si_code);
> > > +	else {
> > > +		err =3D -EFAULT;
> > > +		/*
> > > +		 * A thread accessed NULL, we get a fault, but CR2
> > > is invalid.
> > > +		 * This code is used in __do_copy_from_user() of
> > > TT mode.
> > > +		 * XXX tt mode is gone, so maybe this isn't needed
> > > any more
> > > +		 */
> > > +		address =3D 0;
> > > +	}
> > > +
> > > +	if (!err)
> > > +		goto out;
> > > +	else if (!is_user && arch_fixup(ip, regs))
> > > +		goto out;
> > > +
> > > +	if (!is_user) {
> > > +		show_regs(container_of(regs, struct pt_regs,
> > > regs));
> > > +		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
> > > +		=A0=A0=A0=A0=A0 address, ip);
> > > +	}
> > > +
> > > +	show_segv_info(regs);
> > > +
> > > +	if (err =3D=3D -EACCES) {
> > > +		current->thread.arch.faultinfo =3D fi;
> > > +		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user
> > > *)address);
> > > +	} else {
> > > +		WARN_ON_ONCE(err !=3D -EFAULT);
> > > +		current->thread.arch.faultinfo =3D fi;
> > > +		force_sig_fault(SIGSEGV, si_code, (void __user *)
> > > address);
> > > +	}
> > > +
> > > +out:
> > > +	if (regs)
> > > +		current->thread.segv_regs =3D NULL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs
> > > *regs,
> > > +		=A0 void *mc)
> > > +{
> > > +	int code, err;
> > > +
> > > +	/* !MMU specific part; detection of userspace */
> > > +	/* mark is_user=3D1 when the IP is from userspace code. */
> > > +	if (UPT_IP(regs) > uml_reserved && UPT_IP(regs) <
> > > high_physmem)
> > > +		regs->is_user =3D 1;
> > > +
> > > +	if (!UPT_IS_USER(regs)) {
> > > +		if (sig =3D=3D SIGBUS)
> > > +			pr_err("Bus error - the host /dev/shm or
> > > /tmp mount likely just ran out of space\n");
> > > +		panic("Kernel mode signal %d", sig);
> > > +	}
> > > +	/* if is_user=3D=3D1, set return to userspace sig handler to
> > > relay signal */
> > > +	nommu_relay_signal(mc);
> > > +
> > > +	arch_examine_signal(sig, regs);
> > > +
> > > +	/* Is the signal layout for the signal known?
> > > +	 * Signal data must be scrubbed to prevent information
> > > leaks.
> > > +	 */
> > > +	code =3D si->si_code;
> > > +	err =3D si->si_errno;
> > > +	if ((err =3D=3D 0) && (siginfo_layout(sig, code) =3D=3D
> > > SIL_FAULT)) {
> > > +		struct faultinfo *fi =3D UPT_FAULTINFO(regs);
> > > +
> > > +		current->thread.arch.faultinfo =3D *fi;
> > > +		force_sig_fault(sig, code, (void __user
> > > *)FAULT_ADDRESS(*fi));
> > > +	} else {
> > > +		pr_err("Attempted to relay unknown signal %d
> > > (si_code =3D %d) with errno %d\n",
> > > +		=A0=A0=A0=A0=A0=A0 sig, code, err);
> > > +		force_sig(sig);
> > > +	}
> > > +}
> > > +
> > > +void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs
> > > *regs,
> > > +	=A0=A0 void *mc)
> > > +{
> > > +	do_IRQ(WINCH_IRQ, regs);
> > > +}
> > > diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> > > index 53e276e81b37..67dcd88b45b1 100644
> > > --- a/arch/um/os-Linux/signal.c
> > > +++ b/arch/um/os-Linux/signal.c
> > > @@ -40,9 +40,10 @@ static void sig_handler_common(int sig, struct
> > > siginfo *si, mcontext_t *mc)
> > > =A0	int save_errno =3D errno;
> > > =A0
> > > =A0	r.is_user =3D 0;
> > > +	if (mc)
> > > +		get_regs_from_mc(&r, mc);
> > > =A0	if (sig =3D=3D SIGSEGV) {
> > > =A0		/* For segfaults, we want the data from the
> > > sigcontext. */
> > > -		get_regs_from_mc(&r, mc);
> > > =A0		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
> > > =A0	}
> > > =A0
> > > diff --git a/arch/x86/um/nommu/do_syscall_64.c
> > > b/arch/x86/um/nommu/do_syscall_64.c
> > > index 74d5bcc4508d..d77e69e097c1 100644
> > > --- a/arch/x86/um/nommu/do_syscall_64.c
> > > +++ b/arch/x86/um/nommu/do_syscall_64.c
> > > @@ -44,6 +44,9 @@ __visible void do_syscall_64(struct pt_regs
> > > *regs)
> > > =A0	/* set fs register to the original host one */
> > > =A0	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
> > > =A0
> > > +	/* save fp registers */
> > > +	asm volatile("fxsaveq %0" : "=3Dm"(*(struct _xstate *)regs-
> > > >regs.fp));
> > > +
> > > =A0	if (likely(syscall < NR_syscalls)) {
> > > =A0		PT_REGS_SET_SYSCALL_RETURN(regs,
> > > =A0				EXECUTE_SYSCALL(syscall, regs));
> > > @@ -54,6 +57,9 @@ __visible void do_syscall_64(struct pt_regs
> > > *regs)
> > > =A0	/* handle tasks and signals at the end */
> > > =A0	interrupt_end();
> > > =A0
> > > +	/* restore fp registers */
> > > +	asm volatile("fxrstorq %0" : : "m"((current-
> > > >thread.regs.regs.fp)));
> > > +
> > > =A0	/* restore back fs register to userspace configured one */
> > > =A0	os_x86_arch_prctl(0, ARCH_SET_FS,
> > > =A0		=A0=A0=A0=A0=A0 (void *)(current-
> > > >thread.regs.regs.gp[FS_BASE
> > > diff --git a/arch/x86/um/nommu/entry_64.S
> > > b/arch/x86/um/nommu/entry_64.S
> > > index 950447dfa66b..e038bc7b53ac 100644
> > > --- a/arch/x86/um/nommu/entry_64.S
> > > +++ b/arch/x86/um/nommu/entry_64.S
> > > @@ -111,3 +111,17 @@ ENTRY(userspace)
> > > =A0	jmp	*%r11
> > > =A0
> > > =A0END(userspace)
> > > +
> > > +/*
> > > + * this routine prepares the stack to return via host-generated
> > > + * signals (e.g., SEGV, FPE) via do_signal() from interrupt_end().
> > > + */
> > > +ENTRY(__prep_sigreturn)
> > > +	/*
> > > +	 * Switch to current top of stack, so "current->" points
> > > +	 * to the right task.
> > > +	 */
> > > +	movq	current_top_of_stack, %rsp
> > > +
> > > +	jmp	userspace
> > > +END(__prep_sigreturn)
> > > diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c
> > > b/arch/x86/um/nommu/os-Linux/mcontext.c
> > > index c4ef877d5ea0..87fb2a35e7ff 100644
> > > --- a/arch/x86/um/nommu/os-Linux/mcontext.c
> > > +++ b/arch/x86/um/nommu/os-Linux/mcontext.c
> > > @@ -6,6 +6,11 @@
> > > =A0#include <sysdep/mcontext.h>
> > > =A0#include <sysdep/syscalls.h>
> > > =A0
> > > +void set_mc_return_address(mcontext_t *mc)
> > > +{
> > > +	mc->gregs[REG_RIP] =3D (unsigned long) __prep_sigreturn;
> > > +}
> > > +
> > > =A0void set_mc_sigsys_hook(mcontext_t *mc)
> > > =A0{
> > > =A0	mc->gregs[REG_RCX] =3D mc->gregs[REG_RIP];
> > > diff --git a/arch/x86/um/shared/sysdep/mcontext.h
> > > b/arch/x86/um/shared/sysdep/mcontext.h
> > > index 9a0d6087f357..de4041b758f3 100644
> > > --- a/arch/x86/um/shared/sysdep/mcontext.h
> > > +++ b/arch/x86/um/shared/sysdep/mcontext.h
> > > @@ -19,6 +19,7 @@ extern int set_stub_state(struct uml_pt_regs
> > > *regs, struct stub_data *data,
> > > =A0
> > > =A0#ifndef CONFIG_MMU
> > > =A0extern void set_mc_sigsys_hook(mcontext_t *mc);
> > > +extern void set_mc_return_address(mcontext_t *mc);
> > > =A0#endif
> > > =A0
> > > =A0#ifdef __i386__
> > > diff --git a/arch/x86/um/shared/sysdep/ptrace.h
> > > b/arch/x86/um/shared/sysdep/ptrace.h
> > > index 8f7476ff6e95..7d553d9f05be 100644
> > > --- a/arch/x86/um/shared/sysdep/ptrace.h
> > > +++ b/arch/x86/um/shared/sysdep/ptrace.h
> > > @@ -65,7 +65,7 @@ struct uml_pt_regs {
> > > =A0	int is_user;
> > > =A0
> > > =A0	/* Dynamically sized FP registers (holds an XSTATE) */
> > > -	unsigned long fp[];
> > > +	unsigned long fp[] __attribute__((aligned(16)));
> > > =A0};
> > > =A0
> > > =A0#define EMPTY_UML_PT_REGS { }
> > > diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h
> > > b/arch/x86/um/shared/sysdep/syscalls_64.h
> > > index ffd80ee3b9dc..bd152422cdfb 100644
> > > --- a/arch/x86/um/shared/sysdep/syscalls_64.h
> > > +++ b/arch/x86/um/shared/sysdep/syscalls_64.h
> > > @@ -29,6 +29,7 @@ extern syscall_handler_t sys_arch_prctl;
> > > =A0extern void do_syscall_64(struct pt_regs *regs);
> > > =A0extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2,
> > > int64_t a3,
> > > =A0			=A0=A0=A0=A0=A0 int64_t a4, int64_t a5, int64_t a6);
> > > +extern void __prep_sigreturn(void);
> > > =A0#endif
> > > =A0
> > > =A0#endif
> >=20
>=20

