Return-Path: <linux-kernel+bounces-843141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E61BBE7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498D53ADD4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2050C2D738F;
	Mon,  6 Oct 2025 15:24:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774124BBEC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764264; cv=none; b=PklSMa4fQJBPazcRIXoR1sBHs+SD5YzT2daRWromaCC5ExbRijoBdLZOio8v9Jgb8ltFQqd2IRXFdeLF3gQbUk6nfn3CPD0RT/Wc5J8uCpptfd4HQnqfcBqsPBzbL8r3mKmsbAaflWM9xMvboPw1aVoOZFd2UZkO8UmFRaBvDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764264; c=relaxed/simple;
	bh=gw9cA22Z4YbUt00zjbHwgiE1xjnd2/sdP6u89zPlgtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R70ndigXGHujmIOdns8H13WbMHLO2MQI3tnVRkEha1k/U3YbZBlB2tXeHgz72uurD8b52EJJTpSl2Vchb4pT1ovmcMxJkrHf/7zMqaY4OlYeAUkO1Yj5T+Xaes4r1yXbXk4LQ4cHMv6jKlu4dY1juqnzBa407leTcE5VPjOy95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEBFC4CEF5;
	Mon,  6 Oct 2025 15:24:21 +0000 (UTC)
Date: Mon, 6 Oct 2025 16:24:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Fix GIC CDEOI instruction encoding
Message-ID: <aOPfIgrxZaqzu-7s@arm.com>
References: <20251006100758.624934-1-lpieralisi@kernel.org>
 <aOPEXEx-QRv7v9A5@arm.com>
 <aOPZqM2xGIrPJH/d@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPZqM2xGIrPJH/d@lpieralisi>

On Mon, Oct 06, 2025 at 05:00:56PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Oct 06, 2025 at 02:30:04PM +0100, Catalin Marinas wrote:
> > On Mon, Oct 06, 2025 at 12:07:58PM +0200, Lorenzo Pieralisi wrote:
> > > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > > index 6455db1b54fd..6cf8c46ddde5 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -113,14 +113,14 @@
> > >  /* Register-based PAN access, for save/restore purposes */
> > >  #define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
> > >  
> > > -#define __SYS_BARRIER_INSN(op0, op1, CRn, CRm, op2, Rt)			\
> > > +#define __SYS_INSN(op0, op1, CRn, CRm, op2, Rt)				\
> > >  	__emit_inst(0xd5000000					|	\
> > >  		    sys_insn((op0), (op1), (CRn), (CRm), (op2))	|	\
> > >  		    ((Rt) & 0x1f))
> > >  
> > > -#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 3, 3, 0, 7, 31)
> > > -#define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
> > > -#define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
> > > +#define SB_BARRIER_INSN			__SYS_INSN(0, 3, 3, 0, 7, 31)
> > > +#define GSB_SYS_BARRIER_INSN		__SYS_INSN(1, 0, 12, 0, 0, 31)
> > > +#define GSB_ACK_BARRIER_INSN		__SYS_INSN(1, 0, 12, 0, 1, 31)
> > >  
> > >  /* Data cache zero operations */
> > >  #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
> > > @@ -1075,7 +1075,6 @@
> > >  #define GICV5_OP_GIC_CDDIS		sys_insn(1, 0, 12, 1, 0)
> > >  #define GICV5_OP_GIC_CDHM		sys_insn(1, 0, 12, 2, 1)
> > >  #define GICV5_OP_GIC_CDEN		sys_insn(1, 0, 12, 1, 1)
> > > -#define GICV5_OP_GIC_CDEOI		sys_insn(1, 0, 12, 1, 7)
> > >  #define GICV5_OP_GIC_CDPEND		sys_insn(1, 0, 12, 1, 4)
> > >  #define GICV5_OP_GIC_CDPRI		sys_insn(1, 0, 12, 1, 2)
> > >  #define GICV5_OP_GIC_CDRCFG		sys_insn(1, 0, 12, 1, 5)
> > > @@ -1129,6 +1128,17 @@
> > >  #define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
> > >  #define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
> > >  
> > > +/*
> > > + * GIC CDEOI encoding requires Rt to be 0b11111.
> > > + * gic_insn() with an immediate value of 0 cannot be used to encode it
> > > + * because some compilers do not follow asm inline constraints in
> > > + * write_sysreg_s() to turn an immediate 0 value into an XZR as
> > > + * MSR source register.
> > > + * Use __SYS_INSN to specify its precise encoding explicitly.
> > > + */
> > > +#define GICV5_CDEOI_INSN		__SYS_INSN(1, 0, 12, 1, 7, 31)
> > > +#define gic_cdeoi()			asm volatile(GICV5_CDEOI_INSN)
> > 
> > Would something like this work? Completely untested (and build still
> > going):
> 
> I tested the GIC CDEOI code generated with GCC/LLVM and it works.
> 
> My only remark there is that even as the code in mainline stands with
> GCC, it is not very clear that we rely on implicit XZR generation to
> make sure the instruction encoding generated is correct - it looks
> like a bit of a stretch to reuse a sysreg write with immediate value == 0
> to generate a system instruction write with Rt == 0b11111, it works
> but it is a bit opaque or at least not straighforward to grok.
> 
> Obviously the patch below improves LLVM code generation too in the process.
> 
> I don't know what's best - I admit I am on the fence on this one.

My concern is other cases where we may rely on this, so we might as well
go with a generic approach than fixing each case individually. If that's
the only case, I'll leave it to you and Marc do decide whichever you
prefer.

I assume we don't need this for write_sysreg(), those are accesses to
named registers gas already knows about, not used to generate new
instructions.

-- 
Catalin

