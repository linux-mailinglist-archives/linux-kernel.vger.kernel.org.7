Return-Path: <linux-kernel+bounces-782484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18952B320EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6054C7AC18A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00B3128DF;
	Fri, 22 Aug 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EEdehDpw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D23009C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882092; cv=none; b=rUK7xTaWbOyGSPAK3i47QGIZar3EwZAW3NBXZwxl31EKITVrubm5t8thEFqRYlviRuYlS11aGG9MXbS0WkQiDcf42SrsuFUKbzAOilCUsVINSOJljUxHBtvmAF8p+f7CWPXMi+WlGKhLpsl4mOTne9Z7Z3teGg4QWUFy+TJbIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882092; c=relaxed/simple;
	bh=rq7LSyjPy4FOzwGG5+L2kk2kpDxUoVimHHnKzKRUlMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXcqnkl4ckzn3a1O8ct72FMvcr82E57khSd6jWhIbEtoL0kVDbOoEJaczKhLCzFzyjDN1qyvK5ZXpbgP8OA68lwngbizSkdpXEe9O8bSfGYsTk+32fwMTdrl/2z1NXiy8EfgwxbOTLAfEYFoxHmTqodk146lhi6zQHdgo7dtPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EEdehDpw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 30C9B40E025A;
	Fri, 22 Aug 2025 17:01:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Lsz9dzacqZHG; Fri, 22 Aug 2025 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755882081; bh=SInU0KzETsV7VqCIRC2aQVZupdz/ikVFHXns+8/Amko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEdehDpwUxhagvTT7HYirTWXWgyFsDLTMCDdxrOpGD5i+m2HazgfdpSir5w8eZfS4
	 v472g9dG+RG+JCIiLLTX59a9zJrWA5Cc291hj7kYAIHhXvEJSab/yVYieIzTjwL9xY
	 MoEDu2yfD5EbRu3LYcHXHvZ7D+pcmEqtDvh3VGka+p/UG/XK62qm6RB3osUsfn5NFa
	 BeVUx234j4r0I7UpUL+KQ3YU3XGffwc+giQ+ve3ntnc1vUncAKsVwuyA27YSQ0KzXe
	 mG4b7J4DnJbdThn+bCjG5J5Zrmetk9aC/t3jYdAeNZHbGYgPpujao/leDahOdi/fC7
	 VbW8W/SIc7fW8wBBsO0WiCYrwZzvX1HzC17kSqKuadeKN6QhNsXP0jlExS4gEEF6vR
	 tnAmZB/kMQBBokm8CSfWzj2wIDooY5TZwLYxJrFOZoxv4BnLEj5wbongRlXkuKMzDh
	 +aMAsN/x2ekPwjUDOV/YoyxAOd4CKjVRsb/yXaCN7TN+Kg9svOhXlI2qtwvl92/sM5
	 K0a0wtkwoOlgCzhRyWPH+kOAQnTF95zL4OQyRgiEN1rQZahJ0eoi6TyGVdp8J9oDla
	 KBgPeUkZzswilT+n56jKcCmcN6ZU5n3YJbPXnhnP8/P2iFhiCEuTMtzIeEmZLgOn2T
	 2KOuME2YZM+GicXa8J5hQpIQ=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9373E40E016D;
	Fri, 22 Aug 2025 17:01:15 +0000 (UTC)
Date: Fri, 22 Aug 2025 19:01:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Samuele Cerea <samuele@cerea.dev>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH] x86 Handle trap flag when instruction is emulated
Message-ID: <20250822170107.GGaKiiU-HFkxnbymhY@fat_crate.local>
References: <20250729214433.734459-1-samuele@cerea.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729214433.734459-1-samuele@cerea.dev>

On Tue, Jul 29, 2025 at 11:44:33PM +0200, Samuele Cerea wrote:
> Subject: Re: [PATCH] x86 Handle trap flag when instruction is emulated

Add a proper subject prefix:

"x86/traps: Handle ..."

or so.

> When the kernel emulates an instruction (for UIMP instruction emulation
> and iopl emulation) the trap flag (TF) is currently ignored. As a result no
> SIGTRAP event is delivered when the instruction is emulated successfully,
> breaking the expected behavior for signle-stepping in debuggers.
> 
> This patch checks if the TF is set and sends the expected SIGTRAP signal

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> to the user. Other exception take precedence over the trap flag the SIGTRAP
> signal is sent only if the emulation was successful.
> 
> The bug can be reproduced by signle-stepping in this code:
>     nop
>     sldt rax
>     sldt rax
>     nop
> The two sldt instruction will be skipped an the debugger will step directly
> to the second nop instruction.

Please spell all insns in all caps.

> Signed-off-by: Samuele Cerea <samuele@cerea.dev>
> ---
>  arch/x86/kernel/traps.c |  9 +++++++++
>  arch/x86/kernel/umip.c  | 10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 36354b470590..6e7d07a5f587 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -705,6 +705,15 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
>  	}
>  
>  	regs->ip += 1;
> +
> +	/* If the instruction was emulated successfully, emulate trap flag */
> +	if (regs->flags & X86_EFLAGS_TF) {
> +		t->cr2 = regs->ip;
> +		t->trap_nr = X86_TRAP_DB;
> +		t->error_code = 0;
> +		force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->ip);
> +	}

This looks like it wants to be a separate function instead of replicating the
same code below.

> +
>  	return true;
>  }
>  
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 5a4b21389b1d..c4c462074f1d 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -342,6 +342,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
>  	unsigned long *reg_addr;
>  	void __user *uaddr;
>  	struct insn insn;
> +	struct task_struct *tsk = current;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

>  
>  	if (!regs)
>  		return false;
> @@ -407,5 +408,14 @@ bool fixup_umip_exception(struct pt_regs *regs)
>  
>  	/* increase IP to let the program keep going */
>  	regs->ip += insn.length;
> +
> +	/* If the instruction was emulated successfully, emulate trap flag */
> +	if (regs->flags & X86_EFLAGS_TF) {
> +		tsk->thread.cr2 = regs->ip;
> +		tsk->thread.trap_nr = X86_TRAP_DB;
> +		tsk->thread.error_code = 0;
> +		force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->ip);
> +	}
> +
>  	return true;
>  }
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

