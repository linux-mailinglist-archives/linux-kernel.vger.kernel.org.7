Return-Path: <linux-kernel+bounces-830467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81351B99BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC77B16C3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809A305953;
	Wed, 24 Sep 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lE7OU9/3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MiszbaIw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63D3019BA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715260; cv=none; b=R70Oll/VLlYDgONvuf9Lw6AqxKxlFY9yxAd0lJx1qzou0wdaAeRqVznPau/UhekIILoigG/RtXMus6vCqTT8VdJUravYGjcD1u2LH/eGYYgrAdmlpj31I5/+SnGr/TToYPvnJ3AbtQ8EyhDVVoRUZy/sPp8NUmeqCG2yQUbFp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715260; c=relaxed/simple;
	bh=vgTbUdc3QBZFZR+KlBZwwdzs6Hto3QbFIsG1PtyAwhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwtpQFJ5hGPU1/7JyB72pLvqCMBhngZ8IZ174crPZdx3j32tbD9dDP6pb8em9zw7EI44xTx7uHKXQJ9kg4/4z1PRw8Qlwc4wY0X1ArYKJjU9PW/5yVWLGFw0E6fyo7JuCe0qieRfVlaNqAgFabrYZ2Ho4gWQU5M5LDesLwlCo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lE7OU9/3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MiszbaIw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1758715251; x=1790251251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GVeEbXZHLLVdgtkq3Rt5skmTBi/qzB86iEFJYe7MbOY=;
  b=lE7OU9/3bOpNoJF2a3+QnZw4L+usGOV3ddvn2XgszSBCmtKwnwtGMD4z
   3sv1c6BAch6cpQDjjhS1OvXyenEBrJRtHjALJwS4qgd/V0qWi47p3sK4O
   de+GvIP+X7NLPIREE94byB5oRofCUJ51NnAUXM+OeI4mw5yPZzHYWJG/F
   Q6GQ23nQ8r5vg5kHIio5jDNGTEkLJEHhXLKjTK7CEgWFki8Bz/2uY7aQy
   UQC5Lh+/vIchvYjAzQh4g62DK7X0+pKPbBCjwqC5yggrqOyvx+Gpvz2BD
   kjjPeHS79BEr+jjA+gJ4ZKbmXXOT9GDwCRpGCRFv4hZts/Rk7Ru2LHOl9
   Q==;
X-CSE-ConnectionGUID: SEZAPg5SSv+Xkd0I3Bz+rQ==
X-CSE-MsgGUID: eazkGnp5TNGYZVKNdD1K2Q==
X-IronPort-AV: E=Sophos;i="6.18,290,1751234400"; 
   d="scan'208";a="46192635"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Sep 2025 13:59:39 +0200
X-CheckPoint: {68D3DD2B-5-690ADD0E-C022EA8D}
X-MAIL-CPID: EA6A543783A22A079A34EFAE6113B43F_3
X-Control-Analysis: str=0001.0A2D0325.68D3DD2B.0075,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2DAD11611D7;
	Wed, 24 Sep 2025 13:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1758715174;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GVeEbXZHLLVdgtkq3Rt5skmTBi/qzB86iEFJYe7MbOY=;
	b=MiszbaIwL75n4NinMTq+BtlT448qY1P4vjFdNNNxGvnFo5VbY/XtEhFJx57K1X2drvQ8Wy
	eFHuNGbe+zA4jYso57yNiZDcPKjj30UANNnydpV8lMLt57Qz+2EdIANvQtyZDigrVlQRP2
	ThjtrAKGiMQhwQsXr6tTKoFhNeEKosH0CIqKc413ZDZQT3PRPlHH5KPEvWtCg7lyokJQMr
	Aey54GL7SRvgoJW7b44SH158DUntQm3nCjEN3ztKX8uwwlMUPP9tRmr9yFey34nuOXa2wm
	hRE4qUWIuBCM5kLf0QgnbQukWDG7pgJpaA8scFRKpdpXB/ChxnDRiWOQdBDXMQ==
Message-ID: <e347ec137033975423c262bc4dce1132e1de04fe.camel@ew.tq-group.com>
Subject: Re: [PATCH v6 1/2] arm64: entry: Skip single stepping into
 interrupt handlers
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, dianders@chromium.org,
  liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org, ardb@kernel.org,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 will@kernel.org, catalin.marinas@arm.com, linux@ew.tq-group.com
Date: Wed, 24 Sep 2025 13:59:32 +0200
In-Reply-To: <20230202073148.657746-2-sumit.garg@linaro.org>
References: <20230202073148.657746-1-sumit.garg@linaro.org>
	 <20230202073148.657746-2-sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 2023-02-02 at 13:01 +0530, Sumit Garg wrote:
> Currently on systems where the timer interrupt (or any other
> fast-at-human-scale periodic interrupt) is active then it is impossible
> to step any code with interrupts unlocked because we will always end up
> stepping into the timer interrupt instead of stepping the user code.
>=20
> The common user's goal while single stepping is that when they step then
> the system will stop at PC+4 or PC+I for a branch that gets taken
> relative to the instruction they are stepping. So, fix broken single step
> implementation via skipping single stepping into interrupt handlers.
>=20
> The methodology is when we receive an interrupt from EL1, check if we
> are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
> clear the register bit if it was set. Then unmask only D and leave I set.
> On return from the interrupt, set D and restore MDSCR_EL1.SS. Along with
> this skip reschedule if we were stepping.
>=20
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

Hi Sumit,

I was wondering what the status of this patch is. [1] sounds like there wer=
e
remaining concerns, but I'm not sure about the details.

The current state is very unsatisfactory, as I need to apply this patch eve=
ry
time I want to use KGDB on arm64. It is not only required for single-steppi=
ng,
but it also fixes 'continue' endlessly hitting the same breakpoint (until t=
he
breakpoint is deleted or disabled).

Best,
Matthias


[1] https://lkml.org/lkml/2023/2/22/49

> ---
>  arch/arm64/kernel/entry-common.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-c=
ommon.c
> index cce1167199e3..568481f66977 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -231,11 +231,15 @@ DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_con=
d_resched);
>  #define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
>  #endif
> =20
> -static void __sched arm64_preempt_schedule_irq(void)
> +static void __sched arm64_preempt_schedule_irq(struct pt_regs *regs)
>  {
>  	if (!need_irq_preemption())
>  		return;
> =20
> +	/* Don't reschedule in case we are single stepping */
> +	if (regs->pstate & DBG_SPSR_SS)
> +		return;
> +
>  	/*
>  	 * Note: thread_info::preempt_count includes both thread_info::count
>  	 * and thread_info::need_resched, and is not equivalent to
> @@ -471,19 +475,33 @@ static __always_inline void __el1_irq(struct pt_reg=
s *regs,
>  	do_interrupt_handler(regs, handler);
>  	irq_exit_rcu();
> =20
> -	arm64_preempt_schedule_irq();
> +	arm64_preempt_schedule_irq(regs);
> =20
>  	exit_to_kernel_mode(regs);
>  }
> +
>  static void noinstr el1_interrupt(struct pt_regs *regs,
>  				  void (*handler)(struct pt_regs *))
>  {
> +	unsigned long mdscr;
> +
> +	/* Disable single stepping within interrupt handler */
> +	if (regs->pstate & DBG_SPSR_SS) {
> +		mdscr =3D read_sysreg(mdscr_el1);
> +		write_sysreg(mdscr & ~DBG_MDSCR_SS, mdscr_el1);
> +	}
> +
>  	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> =20
>  	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
>  		__el1_pnmi(regs, handler);
>  	else
>  		__el1_irq(regs, handler);
> +
> +	if (regs->pstate & DBG_SPSR_SS) {
> +		write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
> +		write_sysreg(mdscr, mdscr_el1);
> +	}
>  }
> =20
>  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

