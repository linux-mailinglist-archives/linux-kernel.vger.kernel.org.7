Return-Path: <linux-kernel+bounces-818916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25688B59813
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874721893B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1A31B80F;
	Tue, 16 Sep 2025 13:45:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4637031A54D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030340; cv=none; b=da5YdUJIBN9h7diN3mf9iwzFNfL1+V8J7Y+J+Pr1X/7P/mSgi0dfkXdWmSIwRq29Eswv+Gfr1ei9RZymF5GpxLuRWC0FyhufSPO6ZJk/R2V7Pcf+h2re+G+f92g00DErffZHn/xTPak70A8wyXJYeV9RCeajpZb4TlMz1F0Imwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030340; c=relaxed/simple;
	bh=fVlNw793Cvpl8k3NvZ1IBi327yZSlQft4OAyJD9aoTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FURrhhHNXyiElMpqd0fBLiD1MrBf738PpEaoVSjwKJ/WVj27+xGxUkGA43/PM5b9aOYaAOfGzHYsUaN2bekDJqV7amHBy61DgegXIMoiEou854/X6pxEKnuNmmfQldzd2r52tCnDeCG4wtvSYnEhZFeVUrjTJo2lHl2DYWjei00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3F6113E;
	Tue, 16 Sep 2025 06:45:29 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0286D3F66E;
	Tue, 16 Sep 2025 06:45:34 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:45:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, james.morse@arm.com,
	ardb@kernel.org, scott@os.amperecomputing.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 4/6] arm64: futex: refactor futex atomic
 operation
Message-ID: <aMlp_Covl57nnVoe@J2N7QTR9R3.cambridge.arm.com>
References: <20250816151929.197589-1-yeoreum.yun@arm.com>
 <20250816151929.197589-5-yeoreum.yun@arm.com>
 <aMRQIeIdyiWVR8a0@arm.com>
 <aMfrR0vserl/hfZ3@e129823.arm.com>
 <aMhrscd1gz_syMtL@arm.com>
 <aMh4q4-xAPHnaOul@willie-the-truck>
 <aMkLb6jPiSbzeRWL@arm.com>
 <aMk1qxS3htyaTgEQ@e129823.arm.com>
 <aMlcf5oUNZU65u_I@J2N7QTR9R3.cambridge.arm.com>
 <aMllyaObyciHEEFX@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMllyaObyciHEEFX@e129823.arm.com>

On Tue, Sep 16, 2025 at 02:27:37PM +0100, Yeoreum Yun wrote:
> Hi Mark,
> 
> [...]
> > > diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
> > > index 1d6d9f856ac5..0aeda7ced2c0 100644
> > > --- a/arch/arm64/include/asm/futex.h
> > > +++ b/arch/arm64/include/asm/futex.h
> > > @@ -126,6 +126,60 @@ LSUI_FUTEX_ATOMIC_OP(or, ldtset, al)
> > >  LSUI_FUTEX_ATOMIC_OP(andnot, ldtclr, al)
> > >  LSUI_FUTEX_ATOMIC_OP(set, swpt, al)
> > >
> > > +
> > > +#define LSUI_CMPXCHG_HELPER(suffix, start_bit)                                 \
> > > +static __always_inline int                                                     \
> > > +__lsui_cmpxchg_helper_##suffix(u64 __user *uaddr, u32 oldval, u32 newval)      \
> > > +{                                                                              \
> > > +       int ret = 0;                                                            \
> > > +       u64 oval, nval, tmp;                                                    \
> > > +                                                                               \
> > > +       asm volatile("//__lsui_cmpxchg_helper_" #suffix "\n"                    \
> > > +       __LSUI_PREAMBLE                                                         \
> > > +"      prfm    pstl1strm, %2\n"                                                \
> > > +"1:    ldtr    %x1, %2\n"                                                      \
> > > +"      mov     %x3, %x1\n"                                                     \
> > > +"      bfi     %x1, %x5, #" #start_bit ", #32\n"                               \
> > > +"      bfi     %x3, %x6, #" #start_bit ", #32\n"                               \
> > > +"      mov     %x4, %x1\n"                                                     \
> > > +"2:    caslt   %x1, %x3, %2\n"                                                 \
> > > +"      sub     %x1, %x1, %x4\n"                                                \
> > > +"      cbz     %x1, 3f\n"                                                      \
> > > +"      mov     %w0, %w7\n"                                                     \
> > > +"3:\n"                                                                         \
> > > +"      dmb     ish\n"                                                          \
> > > +"4:\n"                                                                         \
> > > +       _ASM_EXTABLE_UACCESS_ERR(1b, 4b, %w0)                                   \
> > > +       _ASM_EXTABLE_UACCESS_ERR(2b, 4b, %w0)                                   \
> > > +       : "+r" (ret), "=&r" (oval), "+Q" (*uaddr), "=&r" (nval), "=&r" (tmp)    \
> > > +       : "r" (oldval), "r" (newval), "Ir" (-EAGAIN)                            \
> > > +       : "memory");                                                            \
> > > +                                                                               \
> > > +       return ret;                                                             \
> > > +}
> > > +
> > > +LSUI_CMPXCHG_HELPER(lo, 0)
> > > +LSUI_CMPXCHG_HELPER(hi, 32)
> > > +
> > > +static __always_inline int
> > > +__lsui_cmpxchg_helper(u32 __user *uaddr, u32 oldval, u32 newval, u32 *oval)
> > > +{
> > > +       int ret;
> > > +       unsigned long uaddr_al;
> > > +
> > > +       uaddr_al = ALIGN_DOWN((unsigned long)uaddr, sizeof(u64));
> > > +
> > > +       if (uaddr_al != (unsigned long)uaddr)
> > > +               ret = __lsui_cmpxchg_helper_hi((u64 __user *)uaddr_al, oldval, newval);
> > > +       else
> > > +               ret = __lsui_cmpxchg_helper_lo((u64 __user *)uaddr_al, oldval, newval);
> > > +
> > > +       if (!ret)
> > > +               *oval = oldval;
> > > +
> > > +       return ret;
> > > +}
> >
> > I think Will expects that you do more of this in C, e.g. have a basic
> > user cmpxchg on a 64-bit type, e.g.
> >
> > /*
> >  * NOTE: *oldp is NOT updated if a fault is taken.
> >  */
> > static __always_inline int
> > user_cmpxchg64_release(u64 __usr *addr, u64 *oldp, u64 new)
> > {
> > 	int err = 0;
> >
> > 	asm volatile(
> > 	__LSUI_PREAMBLE
> > 	"1:	caslt	%x[old], %x[new], %[addr]\n"
> > 	"2:\n"
> > 	_ASM_EXTABLE_UACCESS_ERR(1b, 4b, %w0)
> > 	: [addr] "+Q" (addr),
> > 	  [old] "+r" (*oldp)
> > 	: [new] "r" (new)
> > 	: "memory"
> > 	);
> >
> > 	return err;
> > }
> >
> > That should be the *only* assembly you need to implement.
> >
> > Atop that, have a wrapper that uses get_user() and that helper above to
> > implement the 32-bit user cmpxchg, with all the bit manipulation in C:
> 
> Thanks for your suggestion. But small question.
> I think it's enough to use usafe_get_user() instead of get_user() in here
> since when FEAT_LSUI enabled, it doeesn't need to call
> uaccess_ttbr0_enable()/disable().

Regardless of uaccess_ttbr0_enable() and uaccess_ttbr0_disable()
specifically, API-wise unsafe_get_user() is only supposed to be called
between user_access_begin() and user_access_end(), and there's some
stuff we probably want to add there (e.g. might_fault(), which
unsafe_get_user() lacks today).

Do we call those?

Mark.

