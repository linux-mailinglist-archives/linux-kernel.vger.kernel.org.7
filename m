Return-Path: <linux-kernel+bounces-843111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C76BBE6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70DCA4EE9D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495B627F754;
	Mon,  6 Oct 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghD8fpiZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61B1799F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762862; cv=none; b=TYMKvmKt7Yh1LkZ+SZ80Cov+aBXZ2IKskSbeRwEo2SarFrNUYkbVIH0QGpqjJ3ogZXKHK2SNVFL4m6rk+QbqkWfbqXZ8C/+n/hIumYwZVh08zdsiDh0MimqJ1azXNrzVzhmnej5IOJ1n4Ou1nBNbv39tT5PPNparJCUq6Z9Ke0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762862; c=relaxed/simple;
	bh=PRg9QTHdBIQ2drBq4Jauhpal3A3q0Xroku6xft7iOEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/3oog1MfQNGPHnJk84HgCKXA50xILnR0rztXrPJ49eyrsSSAlDZ6VsP0Da2o19dUZSlQwXkJKxgdxqFbqtewn8q+EU4zLSKmuGSTkKdxmA5rxse559JHbXCc+YiDcaUJNb59I5tuED01o4XklW4WirJsUni/Jn1wD2EexBbtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghD8fpiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92EC4CEF5;
	Mon,  6 Oct 2025 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759762862;
	bh=PRg9QTHdBIQ2drBq4Jauhpal3A3q0Xroku6xft7iOEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghD8fpiZsoXXJu9uoHHp6SN+bVL1Vz+pFOosG1v3TxPaC8aN6TsjsZXQA/60mCtJ6
	 XEcwlIVFTjDI/+5DzteTNePKVXs0L3MRU/dEYfN80EVa2uj85p9Pu0yX5vDS3NhnpX
	 9txbpPWiJ1HBrN15Xi8AYwUi0Q7spUqFcG/j7kqctqPSx1Of8MHdENllihszCYIPPT
	 3zEsxeu34QItDPb+izcWyc3wl375PUQcDQdFHREDx4Io84ucrxRYK6477xv3IYLMJh
	 /XZjjkC54p/EytjpOioxbPtpMF+Zykm+GPVpW/kTNSU64CX6jSOOcmgLAPmSVUAaCz
	 n2a8WrmSGTCIA==
Date: Mon, 6 Oct 2025 17:00:56 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Fix GIC CDEOI instruction encoding
Message-ID: <aOPZqM2xGIrPJH/d@lpieralisi>
References: <20251006100758.624934-1-lpieralisi@kernel.org>
 <aOPEXEx-QRv7v9A5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPEXEx-QRv7v9A5@arm.com>

On Mon, Oct 06, 2025 at 02:30:04PM +0100, Catalin Marinas wrote:
> On Mon, Oct 06, 2025 at 12:07:58PM +0200, Lorenzo Pieralisi wrote:
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 6455db1b54fd..6cf8c46ddde5 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -113,14 +113,14 @@
> >  /* Register-based PAN access, for save/restore purposes */
> >  #define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
> >  
> > -#define __SYS_BARRIER_INSN(op0, op1, CRn, CRm, op2, Rt)			\
> > +#define __SYS_INSN(op0, op1, CRn, CRm, op2, Rt)				\
> >  	__emit_inst(0xd5000000					|	\
> >  		    sys_insn((op0), (op1), (CRn), (CRm), (op2))	|	\
> >  		    ((Rt) & 0x1f))
> >  
> > -#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 3, 3, 0, 7, 31)
> > -#define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
> > -#define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
> > +#define SB_BARRIER_INSN			__SYS_INSN(0, 3, 3, 0, 7, 31)
> > +#define GSB_SYS_BARRIER_INSN		__SYS_INSN(1, 0, 12, 0, 0, 31)
> > +#define GSB_ACK_BARRIER_INSN		__SYS_INSN(1, 0, 12, 0, 1, 31)
> >  
> >  /* Data cache zero operations */
> >  #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
> > @@ -1075,7 +1075,6 @@
> >  #define GICV5_OP_GIC_CDDIS		sys_insn(1, 0, 12, 1, 0)
> >  #define GICV5_OP_GIC_CDHM		sys_insn(1, 0, 12, 2, 1)
> >  #define GICV5_OP_GIC_CDEN		sys_insn(1, 0, 12, 1, 1)
> > -#define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
> >  #define GICV5_OP_GIC_CDPEND		sys_insn(1, 0, 12, 1, 4)
> >  #define GICV5_OP_GIC_CDPRI		sys_insn(1, 0, 12, 1, 2)
> >  #define GICV5_OP_GIC_CDRCFG		sys_insn(1, 0, 12, 1, 5)
> > @@ -1129,6 +1128,17 @@
> >  #define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
> >  #define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
> >  
> > +/*
> > + * GIC CDEOI encoding requires Rt to be 0b11111.
> > + * gic_insn() with an immediate value of 0 cannot be used to encode it
> > + * because some compilers do not follow asm inline constraints in
> > + * write_sysreg_s() to turn an immediate 0 value into an XZR as
> > + * MSR source register.
> > + * Use __SYS_INSN to specify its precise encoding explicitly.
> > + */
> > +#define GICV5_CDEOI_INSN		__SYS_INSN(1, 0, 12, 1, 7, 31)
> > +#define gic_cdeoi()			asm volatile(GICV5_CDEOI_INSN)
> 
> Would something like this work? Completely untested (and build still
> going):

I tested the GIC CDEOI code generated with GCC/LLVM and it works.

My only remark there is that even as the code in mainline stands with
GCC, it is not very clear that we rely on implicit XZR generation to
make sure the instruction encoding generated is correct - it looks
like a bit of a stretch to reuse a sysreg write with immediate value == 0
to generate a system instruction write with Rt == 0b11111, it works
but it is a bit opaque or at least not straighforward to grok.

Obviously the patch below improves LLVM code generation too in the process.

I don't know what's best - I admit I am on the fence on this one.

Thanks !
Lorenzo

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6604fd6f33f4..7aa962f7bdd6 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -1234,7 +1234,10 @@
>  #define write_sysreg_s(v, r) do {					\
>  	u64 __val = (u64)(v);						\
>  	u32 __maybe_unused __check_r = (u32)(r);			\
> -	asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));		\
> +	if (__builtin_constant_p(__val) && __val == 0)			\
> +		asm volatile(__msr_s(r, "xzr"));			\
> +	else								\
> +		asm volatile(__msr_s(r, "%x0") : : "r" (__val));	\
>  } while (0)
>  
>  /*
> 
> -- 
> Catalin

