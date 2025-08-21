Return-Path: <linux-kernel+bounces-779731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C9B2F7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0983E7AA372
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12AF30F806;
	Thu, 21 Aug 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJYwwa0u"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9F23D7D1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779170; cv=none; b=ON6MpqmjJHV6WymP41iUcmLswRXz8oiZxlzjqfaCXeHWTFYAGXbFDo2HmigMyNcq2SklL2moPilsKAAXAIxKHD+C29jMqXGzrjw7Z8PVLwRfx5eLGvYhY/cXs9AUEpRg9fR6kdKErHA/7spI4VylidXsYcWPIEo6+MPmgYZ15IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779170; c=relaxed/simple;
	bh=TK8mfgeVl4dS7yyBtSCeQWTKTGCi3hG1tqnZaSB40aE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7/BPt3Gn4clXnhon0z7zN5PksIGd4mkXZEi0F8TZSMetXGdoJ/EGumj/GVP/jlfMyCGy8zdEY3pd2ox51x/Z9J+8rCVP6/lbT7CUnMZROan2pnD26z04yv9+KYCwb/wCvQarARZ7/tyKyRZTF9xl1LJMps/6stSHv3L+bqBi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJYwwa0u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e4106460so838135f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755779167; x=1756383967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAagHufJuoUJhZ2Zew4f1Hn2k1WbQ/1+8IE/afqFx6g=;
        b=iJYwwa0uryrKZaSXvqwpEFEu8ozWKBVSE6PdJgcs5uTKUCklfUj8zQtbfKauSav82o
         sTaGXI1rk9noIkFSFDBYd9roSfsdXM9Nh4qK7OPecY4+m7pfhuO/KJfPNHgYYEkjb8Ry
         r+SQo9X39AIVPYdfogc6wnB5YKAsLXd/FP2d1zFfOs61YEqB5RrI0H8Ay+dUTyBK6r1X
         IE1KS675jtJ5XgMAxA7Ge8gS08i0DYy31UkfIJzhrt48V5HE/eC8XNofCD1/dZKxV3ye
         ZPjc7+yTA2au5Abm+SYNXOp78qm6I5y6CD7mnP/L+xxI0EW0s28+2kGTNmWDHE8lo7M+
         FP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779167; x=1756383967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAagHufJuoUJhZ2Zew4f1Hn2k1WbQ/1+8IE/afqFx6g=;
        b=dd6W9KxA6xcI1hMZIrjeLrgpmDmw3dJhFjE4m3ELKx6NF1op/u+Zq/7zxKBH9w+QIf
         BgfwsINTNeyZcwDwZzggBcAqcreZvSuBXXQbNdl/FfyfIhxXAocXtx0V9Q9MFkeE8uDd
         fqY6TDGHTV+X/y2X+nWxk2ejskTgISBH7z+kYr1rgunAV7T7hsp7aLub2/IfLB06QR8i
         uQZi2on6V/04EpDfkd43Qw2BKq0ZTAgc8RM4Sk2QPd2xd3/rSrSxu7WxLUokfrHd9/tK
         R2KyOhUfnRx4ta+qrA2oIR5MMChoKUX5xW6EIAeQF3SL+hDO5OjdBF5G8prtoj0mC7Jr
         TnpA==
X-Gm-Message-State: AOJu0YyVPbWIbwoZcklHg5WGKDIvfYxhkHS8JuF7uLueeg9dvaMTy3yB
	kzNHDHP/Hzj4RMj3I0NkA/90KRrEbXpVQU7E3O3jLk9uLEpgWQzvVrBm
X-Gm-Gg: ASbGncvIooTCCy0v99BKgkh/6C+8SAizEvKQGpLs9/4/tCTdZ5q1QaGB5f9LOhECz55
	Lwny+88m3cQdLHL6Tp7EjmJRL4Dnjn/tMlfwXPhe7Fkn1sw62x9AMRmo+DVRLkwMcA7kr/CibFJ
	LhfnqvDgETjLCCLsIlMaexTDMIePuT6DfNauWDm7YG/nrA6aj0qpCDogD1JJVk4kEWvO5rqYfgl
	MyehfbllDdg1GMe9xXaPSsisKIvczGfqHPM50PjYic8vpeDZyjAABw+iPGfxXZAHv+CMtg466xD
	gG0r7Hs+10cUBcFLJtMtaOYUJY3acy0slNjqc98PN5RJiycjyYwDWWWC1efOnXWf+PA+1eAbA7x
	ovzJFMonCPZW7ROYgn+6OIwef6ZAMXFCRwJRW6IqyucKyOeY7PZpFnj+77kpH/gCS
X-Google-Smtp-Source: AGHT+IGiwHJEZiPelDsRBTl+8BlYXm281nRA/iDzamvjoG5wxPy1ziuWxO3FirAx8UAT3wg8svrWLg==
X-Received: by 2002:a5d:5d86:0:b0:3b9:10ed:e6eb with SMTP id ffacd0b85a97d-3c494fc82d4mr1692737f8f.8.1755779166933;
        Thu, 21 Aug 2025 05:26:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789106sm11461252f8f.51.2025.08.21.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:26:06 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:26:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Uros Bizjak
 <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, Kees Cook
 <kees@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrew
 Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>, "Xin
 Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250821132605.2093c37a@pumpkin>
In-Reply-To: <20250820013452.495481-1-marcos@orca.pet>
References: <20250820013452.495481-1-marcos@orca.pet>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 03:34:46 +0200
Marcos Del Sol Vives <marcos@orca.pet> wrote:

> Hintable NOPs are a series of instructions introduced by Intel with the
> Pentium Pro (i686), and described in US patent US5701442A.
> 
> These instructions were reserved to allow backwards-compatible changes
> in the instruction set possible, by having old processors treat them as
> variable-length NOPs, while having other semantics in modern processors.
> 
> Some modern uses are:
>  - Multi-byte/long NOPs
>  - Indirect Branch Tracking (ENDBR32)
>  - Shadow Stack (part of CET)
> 
> Some processors advertising i686 compatibility lack full support for
> them, which may cause #UD to be incorrectly triggered, crashing software
> that uses then with an unexpected SIGILL.
> 
> One such software is sudo in Debian bookworm, which is compiled with
> GCC -fcf-protection=branch and contains ENDBR32 instructions. It crashes
> on my Vortex86DX3 processor and VIA C3 Nehalem processors [1].
> 
> This patch is a much simplified version of my previous patch for x86
> instruction emulation [2], that only emulates hintable NOPs.
> 
> When #UD is raised, it checks if the opcode corresponds to a hintable NOP
> in user space. If true, it warns the user via the dmesg and advances the
> instruction pointer, thus emulating its expected NOP behaviour.
> 
> [1]: https://lists.debian.org/debian-devel/2023/10/msg00118.html
> [2]: https://lore.kernel.org/all/20210626130313.1283485-1-marcos@orca.pet/
> 
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
> ---
>  arch/x86/Kconfig                 | 29 +++++++++++++++++++++++++
>  arch/x86/include/asm/processor.h |  4 ++++
>  arch/x86/kernel/process.c        |  3 +++
>  arch/x86/kernel/traps.c          | 36 ++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 58d890fe2100..a6daebdc2573 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1286,6 +1286,35 @@ config X86_IOPL_IOPERM
>  	  ability to disable interrupts from user space which would be
>  	  granted if the hardware IOPL mechanism would be used.
>  
> +config X86_HNOP_EMU
> +	bool "Hintable NOPs emulation"
> +	depends on X86_32
> +	default y
> +	help
> +	  Hintable NOPs are a series of instructions introduced by Intel with
> +	  the Pentium Pro (i686), and described in US patent US5701442A.
> +
> +	  These instructions were reserved to allow backwards-compatible
> +	  changes in the instruction set possible, by having old processors
> +	  treat them as variable-length NOPs, while having other semantics in
> +	  modern processors.
> +
> +	  Some modern uses are:
> +	   - Multi-byte/long NOPs
> +	   - Indirect Branch Tracking (ENDBR32)
> +	   - Shadow Stack (part of CET)
> +
> +	  Some processors advertising i686 compatibility (such as Cyrix MII,
> +	  VIA C3 Nehalem or DM&P Vortex86DX3) lack full support for them,
> +	  which may cause SIGILL to be incorrectly raised in user space when
> +	  a hintable NOP is encountered.
> +
> +	  Say Y here if you want the kernel to emulate them, allowing programs
> +	  that make use of them to run transparently on such processors.
> +
> +	  This emulation has no performance penalty for processors that
> +	  properly support them, so if unsure, enable it.
> +
>  config TOSHIBA
>  	tristate "Toshiba Laptop support"
>  	depends on X86_32
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index bde58f6510ac..c34fb678c4de 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -499,6 +499,10 @@ struct thread_struct {
>  
>  	unsigned int		iopl_warn:1;
>  
> +#ifdef CONFIG_X86_HNOP_EMU
> +	unsigned int		hnop_warn:1;
> +#endif
> +
>  	/*
>  	 * Protection Keys Register for Userspace.  Loaded immediately on
>  	 * context switch. Store it in thread_struct to avoid a lookup in
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 1b7960cf6eb0..6ec8021638d0 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -178,6 +178,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	p->thread.io_bitmap = NULL;
>  	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
>  	p->thread.iopl_warn = 0;
> +#ifdef CONFIG_X86_HNOP_EMU
> +	p->thread.hnop_warn = 0;
> +#endif
>  	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 36354b470590..2dcb7d7edf8a 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -295,12 +295,48 @@ DEFINE_IDTENTRY(exc_overflow)
>  	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
>  }
>  
> +#ifdef CONFIG_X86_HNOP_EMU
> +static bool handle_hnop(struct pt_regs *regs)
> +{
> +	struct thread_struct *t = &current->thread;
> +	unsigned char buf[MAX_INSN_SIZE];
> +	unsigned long nr_copied;
> +	struct insn insn;
> +
> +	nr_copied = insn_fetch_from_user(regs, buf);
> +	if (nr_copied <= 0)
> +		return false;
> +
> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
> +		return false;
> +
> +	/* Hintable NOPs cover 0F 18 to 0F 1F */
> +	if (insn.opcode.bytes[0] != 0x0F ||
> +		insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)
> +		return false;

Can you swap the order of those tests?
Looks like the 'decode' is only needed for the length.

> +
> +	if (!t->hnop_warn) {
> +		pr_warn_ratelimited("%s[%d] emulating hintable NOP, ip:%lx\n",
> +		       current->comm, task_pid_nr(current), regs->ip);
> +		t->hnop_warn = 1;
> +	}
> +
> +	regs->ip += insn.length;
> +	return true;
> +}
> +#endif
> +
>  #ifdef CONFIG_X86_F00F_BUG
>  void handle_invalid_op(struct pt_regs *regs)
>  #else
>  static inline void handle_invalid_op(struct pt_regs *regs)
>  #endif
>  {
> +#ifdef CONFIG_X86_HNOP_EMU
> +	if (user_mode(regs) && handle_hnop(regs))
> +		return;

Why not move the user_mode() test into handle_hnop() ?
Should make the config tests easier.

	David

> +#endif
> +
>  	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
>  		      ILL_ILLOPN, error_get_trap_addr(regs));
>  }


