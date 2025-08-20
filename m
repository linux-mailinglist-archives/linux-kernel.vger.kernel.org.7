Return-Path: <linux-kernel+bounces-777312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB72B2D7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6BF4E481C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA272DD60E;
	Wed, 20 Aug 2025 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyKg6JpT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VDBG/WqT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824D2DCF70
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681270; cv=none; b=jm//C4zDe9w6FlvWnOK434+Pbg0isL75BRWCmIXz0lKm2ofmkofVjD4d38OBSAe02mFOsgVG2pEjC07DEwiOTvHjtJV+ynzXKbIm0dBTy9IHruKjrOHpnvhPixfIHPsdNVFXYuulfp6RaSLA8CXq3igOQ/e6cFR74bz9guaWAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681270; c=relaxed/simple;
	bh=/aHrcK7fqDa4LqZc5qfbI68TVz++H+mC0NhMVvHbFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhSDImOIbZxJIPf0oZuAPAogb2qh9Ts9ePH+El4pJ+KigtywDwH+9wde2+SpJ+Mf68DE01AiOyp/upWfs7IvH3U+6NJPBUDkGbxiyKil0bQ2LsdXFtKI9tOi9R/+KUZDKrE/u6FFO3xgYnvtVhfylEwkrLQus/zg/aws5Y4VQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyKg6JpT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VDBG/WqT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 11:14:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755681267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+cul7dWLXQ4JCWu12EbN+AslJkIvxuCed3HuYkZuLs=;
	b=yyKg6JpTK+0uAdAQw+TZXGDcoLbKVYCYoUaL2vrTJ1K9gbOEUgJ/i1affhJv/ZFJTTlA1j
	xAowJqrzVGJVR7CIh7DBHL5a/kuCb6SlAr1hDLjbreXDQLs7gNmytoKfboCUyDGxEnZtG6
	d9YgMCOOBSgbH420/eF922qzQIeGcCpM02hDvndjIy2DeKpW6FFlzXXgwpZre0qzhED7XI
	PazDhjL1oMCs/HwnQSFw9Sv+KQ6FyZjGuPjnUOerAqeGIqjHh9hMb3oyxbY/PZJixBzugR
	lEJuEA+AVZpUZQuagNaieWluqwkSb/gVbnPRSQ9xVrsQChMRd7EjjEDNr/u3XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755681267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+cul7dWLXQ4JCWu12EbN+AslJkIvxuCed3HuYkZuLs=;
	b=VDBG/WqTZRhAk/rJb+ZGS5bcBtiCBSYIVNabUAHQDHxhbCs5dyhL2SO6+B7uBP1szvcTYD
	XkuOYvPmOUzfy1CA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <aKWR8e6VUEZEgbkw@lx-t490>
References: <20250820013452.495481-1-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820013452.495481-1-marcos@orca.pet>

Hi Marcos,

On Wed, 20 Aug 2025, Marcos Del Sol Vives wrote:
...
>
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
...
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -178,6 +178,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	p->thread.io_bitmap = NULL;
>  	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
>  	p->thread.iopl_warn = 0;
> +#ifdef CONFIG_X86_HNOP_EMU
> +	p->thread.hnop_warn = 0;
> +#endif
...
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> +
> +	if (!t->hnop_warn) {
> +		pr_warn_ratelimited("%s[%d] emulating hintable NOP, ip:%lx\n",
> +		       current->comm, task_pid_nr(current), regs->ip);
> +		t->hnop_warn = 1;
> +	}

Can we please remove all this 'hnop_warn' trickery?  Removing it will
simplifiy the code and avoid complicating 'thread_struct' further.

It's just the kernel doing its normal job.

And if the system is full of binaries with hintable NOPs, ratelimiting
will not save you much.  I got hit recently by a 'ratelimited'
correctible error PCI subsystem warning, and it still overflows the log
buffers of my Thinkpad laptop, in just 4 to 5 days :(

>
> static inline void handle_invalid_op(struct pt_regs *regs)
> {
> +#ifdef CONFIG_X86_HNOP_EMU
> +	if (user_mode(regs) && handle_hnop(regs))
> +		return;
> +#endif
> +
>

CPP conditionals within C function code are ugly.  Please do instead:

    static bool handle_hnop(struct pt_regs *regs)
    {
	if (!IS_ENABLED(CONFIG_X86_HNOP_EMU))
		return false;
	...
    }

Thanks for your contribution!

--
Ahmed S. Darwish
Linutronix GmbH

