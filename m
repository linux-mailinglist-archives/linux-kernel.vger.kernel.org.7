Return-Path: <linux-kernel+bounces-837362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B2FBAC21D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DE53B5DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CAB2F3C08;
	Tue, 30 Sep 2025 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KyZFX7Es"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5E241CA2;
	Tue, 30 Sep 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222251; cv=none; b=FclsWkbQZLLGqanEoTPPEIFKDSmv34iMvNw9tlrBJ3HDJgaVyIO0EOcRCyIbpZes0aEA0/8i7JrTW5caGCWN631rWgxvy/19dGA188g3hWtK+c9Fh5VDocWuK0DLFx+goPCeM755jR6Bn1Gt8Dy9KIVbsEYBeNxirJ1wRhCBiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222251; c=relaxed/simple;
	bh=HVt2hg7ER3e4vkI09LrbiwmF0rweJxwnrGPCeddGNvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gun7/NSvAbKbvwbQj0bAhYnf0ELoU+ZtKPPSPblpnx5zxxTONNEMYreN4NcCAYe6aR9boVdVCuUx5i+ekDqo7hjkPSMXLHqw4/CCuxgKh3PAYrZ1LVzA6Abrf9FB2CkKVfFHtddMAKKW8YIobGquYXhhE4xpQBJOljgh5TSmmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KyZFX7Es; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aobTZulWFXmpGgXd1UOGMZNj+dT6rlBFPFskVEYIlDw=; b=KyZFX7Es4Dd5bUX/mzcwB+vOuj
	ExiDc24/7BAEUgWFMa9sQ81GYI08smIHEcJPc4xpZFVvrIAWsJKV/suD+TLvxIA0gZNaE3RANUyat
	lC6Pxkor3BFMSZoXLt/HXEbUZJRY3OuepDlhgparx7srjXUWFTp2ahdQ7gnw0M4uTK10JoFtvSN67
	Ht+K1hJmn8KXvu/IUvhEzMkz0P6p6DVuDFrLTMOkb6NFKJjGk6emfpZWw5z0+kEw63GjgQCnKQK4+
	dsdj2/ixBcXQITXb66KQQt4jaD4Vr1aE/yrbTbanIfvdUphWCnxOW5yVN5XiwSETjLbrQA+hIGOYI
	IaSy9kKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3W4L-0000000Ci7J-0UIX;
	Tue, 30 Sep 2025 08:50:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1FF2B300220; Tue, 30 Sep 2025 10:50:44 +0200 (CEST)
Date: Tue, 30 Sep 2025 10:50:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
	xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
Message-ID: <20250930085044.GK3245006@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>

On Tue, Sep 30, 2025 at 10:46:23AM +0200, J=FCrgen Gro=DF wrote:
> On 30.09.25 10:31, Peter Zijlstra wrote:
> > On Tue, Sep 30, 2025 at 09:03:53AM +0200, Juergen Gross wrote:
> >=20
> > > +static __always_inline bool __wrmsrq_constant(u32 msr, u64 val, int =
type)
> > > +{
> > > +	BUILD_BUG_ON(!__builtin_constant_p(msr));
> > > +
> > > +	asm_inline volatile goto(
> > > +		"1:\n"
> > > +		ALTERNATIVE_2(PREPARE_RCX_RDX_FOR_WRMSR
> > > +			      "2: ds wrmsr",
> > > +			      PREPARE_RCX_RDX_FOR_WRMSR
> > > +			      ASM_WRMSRNS,
> > > +			      X86_FEATURE_WRMSRNS,
> > > +			      ASM_WRMSRNS_IMM,
> > > +			      X86_FEATURE_MSR_IMM)
> > > +		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For WRMSRNS immedia=
te */
> > > +		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For WRMSR(NS) */
> > > +
> > > +		:
> > > +		: [val] "a" (val), [msr] "i" (msr), [type] "i" (type)
> > > +		: "memory", "ecx", "rdx"
> > > +		: badmsr);
> > > +
> > > +	return false;
> > > +
> > > +badmsr:
> > > +	return true;
> > > +}
> >=20
> > Just wondering, would something this work?
> >=20
> > 	asm_inline volatile goto(
> > 		"1:\n"
> > 		ALTERNATIVE(PREPARE_RCX_RDX_FOR_WRMSR
> > 			    "2:\n"
> > 			    ALTERNATIVE("ds wrmsr",
> > 			                ASM_WRMSRNS, X86_FEATURE_WRMSRNS),
> > 			    ASM_WRMSRNS_IMM, X86_FEATURE_MSR_IMM);
> > 		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For WRMSRNS immediate =
*/
> > 		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For WRMSR(NS) */
> >=20
> > 		:
> > 		: [val] "a" (val), [msr] "i" (msr), [type] "i" (type)
> > 		: "memory", "ecx", "rdx"
> > 		: badmsr);
> >=20
> > Its a bit weird because the nested alternative isn't for the exact same
> > position I suppose. But I find it a more readable form.
>=20
> I don't think it would work. Nested ALTERNATIVE()s do work only with
> all of them starting at the same location. Have a look at the
> ALTERNATIVE() macro, which is defining the label "771" via OLDINSTR()
> and then referring to this label via ALTINSTR_ENTRY(). In your case
> the ALTINSTR_ENTRY() of the outer ALTERNATIVE() invocation would find
> the wrong "771" label (the one of the inner ALTERNATIVE()).
>=20
> Allowing such constructs would probably require switching from preprocess=
or
> macros to assembler macros.

Right, I was looking at the asm macros.=20

As long as the inner comes first in the apply list it should all just
work, except you get the double patching back.

Using the asm macros isn't going to make it more readable though.=20
Oh well, lets forget about this :-)

