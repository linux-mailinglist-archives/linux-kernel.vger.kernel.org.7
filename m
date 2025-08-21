Return-Path: <linux-kernel+bounces-778973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19512B2ED62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CD5C430D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB441F09AC;
	Thu, 21 Aug 2025 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="c/j2maWu"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6783C17
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755752589; cv=none; b=SGWlauE++dTXymtdxXEEbVNz8BvwQwhgIq3jJamL+XF2QK5sdbXKBkLW6bDwPulaiU1qU6P/wVRVzgUyKX1i/7PlBdN5oLeyjzQ1vvaCnxrhI9hTK4T0uBLt+Y1QhLIglQHC+Pz5/eiyz/qvfNY84t93wRLeRTcDJZufC6fDiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755752589; c=relaxed/simple;
	bh=Wf9DXjS22InSNDUD8QbnDPGZ5B/Q4xot3wmOjKmVpq4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k1rRILZ3uZfYc8a5WFx/J8DQDIghUISGepWinu9wiIEd1lIpbvzNwHe2TZ9tiUiVKJHqCn5bK9gaMNzLgycpJ5M0Gc7k5ruYxqq0OtsuHjxenUyzMTExTa2mLcvQdb4vMUsFziMUgp3VXiKoqiL2DjT7C5W0mXTDgoI64MWCVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=c/j2maWu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57L52Hn8149699
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 20 Aug 2025 22:02:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57L52Hn8149699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755752539;
	bh=7xhhrNsbETJEy+6otM6cI4dBGbWirXmULvPQrp0lccA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=c/j2maWuxyIBgJWC660NSrD/6eAVEiU9ybIpPY2WnHzswKFRpCK3sTEGoRx3rawCL
	 OU0XLlrGcDTsjej3rljbg5SSxPO6wyyp7hPqX7rV51iaBYeUIXklHz2MJyU8xeaMAf
	 Wbgjc2YqgpPNISUbGVotlYXpkovdgL6MvNEHJ8scdW7rC+LQXmWwLa1c8EcqqT1lgs
	 2AkGg1fLEUsMGlzdZ4QzdgsYNOR4s22LJAUkkosn3fFnCYZKjXmKkWpAmua5BmxXiW
	 obX2fezfGJjpKr2KQ3sYEWY8eRQWcpt9qSzvZyK3AZzJNY6gt3XCkkL1YiqHhPQj5S
	 WkxJaGv49NdWQ==
Date: Wed, 20 Aug 2025 22:02:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Marcos Del Sol Vives <marcos@orca.pet>, linux-kernel@vger.kernel.org
CC: marcos@orca.pet, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, David Kaplan <david.kaplan@amd.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>, Kees Cook <kees@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
User-Agent: K-9 Mail for Android
In-Reply-To: <20250820013452.495481-1-marcos@orca.pet>
References: <20250820013452.495481-1-marcos@orca.pet>
Message-ID: <A928C630-1D4F-44FB-8F4E-900CD5CBAB41@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 19, 2025 6:34:46 PM PDT, Marcos Del Sol Vives <marcos@orca=2Epet>=
 wrote:
>Hintable NOPs are a series of instructions introduced by Intel with the
>Pentium Pro (i686), and described in US patent US5701442A=2E
>
>These instructions were reserved to allow backwards-compatible changes
>in the instruction set possible, by having old processors treat them as
>variable-length NOPs, while having other semantics in modern processors=
=2E
>
>Some modern uses are:
> - Multi-byte/long NOPs
> - Indirect Branch Tracking (ENDBR32)
> - Shadow Stack (part of CET)
>
>Some processors advertising i686 compatibility lack full support for
>them, which may cause #UD to be incorrectly triggered, crashing software
>that uses then with an unexpected SIGILL=2E
>
>One such software is sudo in Debian bookworm, which is compiled with
>GCC -fcf-protection=3Dbranch and contains ENDBR32 instructions=2E It cras=
hes
>on my Vortex86DX3 processor and VIA C3 Nehalem processors [1]=2E
>
>This patch is a much simplified version of my previous patch for x86
>instruction emulation [2], that only emulates hintable NOPs=2E
>
>When #UD is raised, it checks if the opcode corresponds to a hintable NOP
>in user space=2E If true, it warns the user via the dmesg and advances th=
e
>instruction pointer, thus emulating its expected NOP behaviour=2E
>
>[1]: https://lists=2Edebian=2Eorg/debian-devel/2023/10/msg00118=2Ehtml
>[2]: https://lore=2Ekernel=2Eorg/all/20210626130313=2E1283485-1-marcos@or=
ca=2Epet/
>
>Signed-off-by: Marcos Del Sol Vives <marcos@orca=2Epet>
>---
> arch/x86/Kconfig                 | 29 +++++++++++++++++++++++++
> arch/x86/include/asm/processor=2Eh |  4 ++++
> arch/x86/kernel/process=2Ec        |  3 +++
> arch/x86/kernel/traps=2Ec          | 36 ++++++++++++++++++++++++++++++++
> 4 files changed, 72 insertions(+)
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 58d890fe2100=2E=2Ea6daebdc2573 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -1286,6 +1286,35 @@ config X86_IOPL_IOPERM
> 	  ability to disable interrupts from user space which would be
> 	  granted if the hardware IOPL mechanism would be used=2E
>=20
>+config X86_HNOP_EMU
>+	bool "Hintable NOPs emulation"
>+	depends on X86_32
>+	default y
>+	help
>+	  Hintable NOPs are a series of instructions introduced by Intel with
>+	  the Pentium Pro (i686), and described in US patent US5701442A=2E
>+
>+	  These instructions were reserved to allow backwards-compatible
>+	  changes in the instruction set possible, by having old processors
>+	  treat them as variable-length NOPs, while having other semantics in
>+	  modern processors=2E
>+
>+	  Some modern uses are:
>+	   - Multi-byte/long NOPs
>+	   - Indirect Branch Tracking (ENDBR32)
>+	   - Shadow Stack (part of CET)
>+
>+	  Some processors advertising i686 compatibility (such as Cyrix MII,
>+	  VIA C3 Nehalem or DM&P Vortex86DX3) lack full support for them,
>+	  which may cause SIGILL to be incorrectly raised in user space when
>+	  a hintable NOP is encountered=2E
>+
>+	  Say Y here if you want the kernel to emulate them, allowing programs
>+	  that make use of them to run transparently on such processors=2E
>+
>+	  This emulation has no performance penalty for processors that
>+	  properly support them, so if unsure, enable it=2E
>+
> config TOSHIBA
> 	tristate "Toshiba Laptop support"
> 	depends on X86_32
>diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm/pr=
ocessor=2Eh
>index bde58f6510ac=2E=2Ec34fb678c4de 100644
>--- a/arch/x86/include/asm/processor=2Eh
>+++ b/arch/x86/include/asm/processor=2Eh
>@@ -499,6 +499,10 @@ struct thread_struct {
>=20
> 	unsigned int		iopl_warn:1;
>=20
>+#ifdef CONFIG_X86_HNOP_EMU
>+	unsigned int		hnop_warn:1;
>+#endif
>+
> 	/*
> 	 * Protection Keys Register for Userspace=2E  Loaded immediately on
> 	 * context switch=2E Store it in thread_struct to avoid a lookup in
>diff --git a/arch/x86/kernel/process=2Ec b/arch/x86/kernel/process=2Ec
>index 1b7960cf6eb0=2E=2E6ec8021638d0 100644
>--- a/arch/x86/kernel/process=2Ec
>+++ b/arch/x86/kernel/process=2Ec
>@@ -178,6 +178,9 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
> 	p->thread=2Eio_bitmap =3D NULL;
> 	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
> 	p->thread=2Eiopl_warn =3D 0;
>+#ifdef CONFIG_X86_HNOP_EMU
>+	p->thread=2Ehnop_warn =3D 0;
>+#endif
> 	memset(p->thread=2Eptrace_bps, 0, sizeof(p->thread=2Eptrace_bps));
>=20
> #ifdef CONFIG_X86_64
>diff --git a/arch/x86/kernel/traps=2Ec b/arch/x86/kernel/traps=2Ec
>index 36354b470590=2E=2E2dcb7d7edf8a 100644
>--- a/arch/x86/kernel/traps=2Ec
>+++ b/arch/x86/kernel/traps=2Ec
>@@ -295,12 +295,48 @@ DEFINE_IDTENTRY(exc_overflow)
> 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
> }
>=20
>+#ifdef CONFIG_X86_HNOP_EMU
>+static bool handle_hnop(struct pt_regs *regs)
>+{
>+	struct thread_struct *t =3D &current->thread;
>+	unsigned char buf[MAX_INSN_SIZE];
>+	unsigned long nr_copied;
>+	struct insn insn;
>+
>+	nr_copied =3D insn_fetch_from_user(regs, buf);
>+	if (nr_copied <=3D 0)
>+		return false;
>+
>+	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
>+		return false;
>+
>+	/* Hintable NOPs cover 0F 18 to 0F 1F */
>+	if (insn=2Eopcode=2Ebytes[0] !=3D 0x0F ||
>+		insn=2Eopcode=2Ebytes[1] < 0x18 || insn=2Eopcode=2Ebytes[1] > 0x1F)
>+		return false;
>+
>+	if (!t->hnop_warn) {
>+		pr_warn_ratelimited("%s[%d] emulating hintable NOP, ip:%lx\n",
>+		       current->comm, task_pid_nr(current), regs->ip);
>+		t->hnop_warn =3D 1;
>+	}
>+
>+	regs->ip +=3D insn=2Elength;
>+	return true;
>+}
>+#endif
>+
> #ifdef CONFIG_X86_F00F_BUG
> void handle_invalid_op(struct pt_regs *regs)
> #else
> static inline void handle_invalid_op(struct pt_regs *regs)
> #endif
> {
>+#ifdef CONFIG_X86_HNOP_EMU
>+	if (user_mode(regs) && handle_hnop(regs))
>+		return;
>+#endif
>+
> 	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
> 		      ILL_ILLOPN, error_get_trap_addr(regs));
> }

Why are they using -fcf-protection=3Dbranch on 32 buts when the kernel vds=
o doesn't even (currently) support it?

