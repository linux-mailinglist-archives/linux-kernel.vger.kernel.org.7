Return-Path: <linux-kernel+bounces-758913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B9B1D580
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7017F637
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C822B5AC;
	Thu,  7 Aug 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HGGfEoLZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E3222593
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561181; cv=none; b=Sm+FhcJUh3CdBIju7+grxyOS9LKzjPVe3jvDwKY2pr5hTOnp9Ry3HR2VjCdDNFe/dn2Q1tQ0HxZkGYipNwc9wBhz/7jAa7JLnSrlVhN0ViLw2xk8tji0zh2QkxhctZEk2HpN4i/yO7gxqjsJW0ThDe+ISwDgMD4qb6cHSXHDBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561181; c=relaxed/simple;
	bh=bpTvd9kY0BSNp2AYeh+4uwszKdEXu5/frZYnL+WgEeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhTamnruFizi6iaeoYq4w+8huDXpm6cWrRthMW72J3/K7nGJOZeB1YawrW0nX+rC9aNt6JHA9VD9suhp323E6MyVGc5vV/BnL0TDzGbXzaopaowpKEGfq+nn2IMdLdpMsQWzbwXpYj3f/DaxMMDHhmwYIM14Qn/HK3vR0x3YMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HGGfEoLZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D3E2140E0191;
	Thu,  7 Aug 2025 10:06:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J6YvumZt2dJo; Thu,  7 Aug 2025 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754561172; bh=gXcp+swCFZ4zZxUqLhtYU6zzPnFJHoGvkH7pAriS+pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGGfEoLZqAToiZuicWEboUZJg/ul2gALyAlUOYLnOhuwJAsucmnUCeCXjW9uCXJhD
	 oKVZoFSemZ/n+8wt7HEepCAvrjCIpRxeYcYmJkRJiFkc+SNrX82bhAHZz8eOqGZ4MT
	 24BJcQFYVQiAIqA9trz8BOJMAFvOEgliMlNhHjwdYMNIgVDAJeN1p8AMKPi7LXmhbF
	 VwNIL0IdFh3Vf9gIsI70cRPGYbwGABDFJWTH0PYNj9wz/cEYkgckFOPjdpA3ooCUAt
	 kX7ZEmuLxNtcudiQFEukoissoxeOtKO8pm28dxVoy70PWU9t9VFpD988gzL2IWC4Es
	 UwMjgbT/60bA2N5/zD2D3B6zfG/keuhg/9AEtFJWDLcW0ZZ5VWVq36HECbHR4nXwhI
	 wGicR4d75MI4fWrKIbNCq5ySFF7m+evp4SfzhlO5vQEHZ7QvDwxKQGk67m4WFMH0kY
	 eBBlCJdwboQIezdbVPpa4SsnvY6dRSIFwAPEZwtiTC3CbCA7EAZkQV9s4zDwT8Zoyh
	 eA195Kdw7l+080QNMsEYp5YiCiOU3QqtdfRMIkRoTn/QexUEan2GVww9ZH36pQRxnC
	 Iu88HHgB1SdLiwc50lDkwu/TRxoWNPXsLORZAeq/gk3UUy74iUplTtZYDNcX3v5chb
	 vJ7SdlDnXjlKSEqhrajn+ZXw=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 507B140E0217;
	Thu,  7 Aug 2025 10:06:05 +0000 (UTC)
Date: Thu, 7 Aug 2025 12:05:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: drop REG_OUT macro from hweight functions
Message-ID: <20250807100558.GCaJR6hvI-UY-xpZrd@fat_crate.local>
References: <20190728115140.GA32463@avx2>
 <20190729094329.GW31381@hirez.programming.kicks-ass.net>
 <20190729100447.GD31425@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729100447.GD31425@hirez.programming.kicks-ass.net>

On Mon, Jul 29, 2019 at 12:04:47PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 11:43:29AM +0200, Peter Zijlstra wrote:
> 
> > I _think_ something like the below should also work:
> > 
> > (fwiw _ASM_ARG 5 and 6 are broken, as are all the QLWB variants)
> 
> Fixed that, because
> 
> > ---
> > diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
> > index ba88edd0d58b..88704612b2f7 100644
> > --- a/arch/x86/include/asm/arch_hweight.h
> > +++ b/arch/x86/include/asm/arch_hweight.h
> > @@ -3,22 +3,15 @@
> >  #define _ASM_X86_HWEIGHT_H
> >  
> >  #include <asm/cpufeatures.h>
> > -
> > -#ifdef CONFIG_64BIT
> > -#define REG_IN "D"
> > -#define REG_OUT "a"
> > -#else
> > -#define REG_IN "a"
> > -#define REG_OUT "a"
> > -#endif
> > +#include <asm/asm.h>
> >  
> >  static __always_inline unsigned int __arch_hweight32(unsigned int w)
> >  {
> >  	unsigned int res;
> >  
> >  	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
> > -			 : "="REG_OUT (res)
> > -			 : REG_IN (w));
> > +			 : "=a" (res)
> > +			 : _ASM_ARG1 (w));
> 
> That needs _ASM_ARG1L because popcntl..

Frankly, the ASM_ARG* thing is less readable than simply having "=a" there.

ASM_ARG<number> naming needs optimizing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

