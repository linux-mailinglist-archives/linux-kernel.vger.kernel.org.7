Return-Path: <linux-kernel+bounces-738725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D5FB0BC58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5217A129C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433E21D3CD;
	Mon, 21 Jul 2025 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCqJLtne";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GGS74zao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268721D018
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078131; cv=none; b=FocDAjcudni3G/xIZ37E9qQIJuuv66De4Gv2dxG6utI+VCmmBo7+zhJyWw6i/ybHgxh/v2sVqQoOeqs6RAGlW8YeVDb5KDY/MSRwyswU60YTxa287GRWqoVwBFs3Qs1KQX09WDzDyW03QdMyU3Lcp6ZNmpj+gjEEjv3UlqiKtpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078131; c=relaxed/simple;
	bh=XTAsoRnAn5Dp6oMI1z1ApkeMg7ex+W4Zuqu1f6zA8XI=;
	h=To:Cc:Subject:In-Reply-To:References:From:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhSJggn+k+bsWbYWJnJPDgE8AFRN31B44USOhK3x2Tcy+iN/zg5dAbtOP1q/ksK5WeiPkHQctt++Ns7YsIcqLLaLtmO2ByVqcM1x60jQCHaUk9YgY2lDOzR9K7roLNMZSm+q7UzUc4j/Jm2ytnSmGb5ymMa6Q3mcG9NN/1wfATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCqJLtne; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GGS74zao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
To: Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel
 <ardb@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753078127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ysTIC7pCktSIS1nRP5tLDYzzpUd1oxQj9vcPcdYZ/I=;
	b=WCqJLtnesga7oHUDorblGKEGHCslPa5pvXCNF8MeDZARlBQkbOuyxebvweNx64e6M37PnD
	GrpY5tvovPzsl32OIuXQ94+qM+QlQCB8NevCSpzD6uhabB2C5vlj8lp5hOOKNzZbl0YlLC
	VZMFBaMDLOL45xncQ/0wrc3ZuSCnFZ2eph8HX4aYMjKSIGpaC1W98u3QloJle2C58tbSBR
	0ASJPu6hgztFoPFQ1zH+7duUU/hq7kABTTNKefQW3nBF+8t7pnXxr1UUugW8TXp+JrtW1C
	EKtqvR07q32/b3Dhg4WRdedglsjWUixxpMhWqepT+c5yAZE02OFrjn2TmM6Odg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753078127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ysTIC7pCktSIS1nRP5tLDYzzpUd1oxQj9vcPcdYZ/I=;
	b=GGS74zao/TTGxUEOS13ltaOZdqSRWAt+pSrno8ufN7wMo4Y/70mH8kH7J/JaLqf2z9Oihz
	GSGwxK7Jtb6DIHAQ==
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>
Subject: Re: [GIT pull] x86/urgent for v6.16-rc7
In-Reply-To: <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
References: <175301303546.263023.1426155806374119244.tglx@xen13>
 <175301303889.263023.7762556142250207604.tglx@xen13>
 <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
From: tglx <tglx@linutronix.de>
Date: Mon, 21 Jul 2025 08:08:46 +0200
Message-ID: <8734aqulch.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jul 20 2025 at 11:35, Linus Torvalds wrote:
> On Sun, 20 Jul 2025 at 05:05, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> A single fix for a GCC wreckage, which emits a KCSAN instrumentation call
>> in __sev_es_nmi_complete() despite the function being annotated with
>> 'noinstr'. As all functions in that source file are noinstr, exclude the
>> whole file from KCSAN in the Makefile to cure it.
>
> Hmm. I'm not entirely sure if this counts as a gcc bug.
>
> In particular, look at the *declaration* of __sev_es_nmi_complete() in
> <asm/sev.h>, and note the complete lack of 'noinstr':
>
>     extern void __sev_es_nmi_complete(void);
>
> and I wonder if it might be the case that gcc might pick up the lack
> of 'noinstr' from the declaration, even if it's there in the
> definition..
>
> The fix for this obviously ends up working and is fine regardless, but
> it's _possible_ that this is self-inflicted pain rather than an
> outright compiler bug.

I agree. See below.

> Because having a declaration and a definition that doesn't match
> sounds like a bad idea in the first place.

I disagree here. When the compiler evaluates the function body it must
have evaluated noinstr on the definition, no?

Unfortunately the data provided in the change log does not tell what was
actually instrumented inside of that function. I just reproduced it
locally.

The problem are the invocations of ghcb_set_sw_*(), which are
implemented through a macro maze, but end up being marked
__always_inline all the way down. __always_inline is supposed to
guarantee that the noinstr (or other) constraints of the calling
function are preserved.

What makes these ghcb_set_sw_*() inlines so special?

They are defined by DEFINE_GHCB_ACCESSORS(field) and end up with this:

	static __always_inline void ghcb_set_##field(struct ghcb *ghcb, u64 value) \
	{									\
		__set_bit(GHCB_BITMAP_IDX(field),				\
			  (unsigned long *)&ghcb->save.valid_bitmap);		\
		ghcb->save.field = value;					\
	}

__set_bit() resolves to:

static __always_inline void ___set_bit(unsigned long nr, volatile unsigned long *addr)
{
	instrument_write(addr + BIT_WORD(nr), sizeof(long));
	arch___set_bit(nr, addr);
}

instrument_write() resolves to

static __always_inline void instrument_write(const volatile void *v, size_t size)
{
	kasan_check_write(v, size);
	kcsan_check_write(v, size);
}

and kcsan_check_write() is:

#define __kcsan_check_write(ptr, size)                                         \
	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)

__kcsan_check_access() is a function provided by the kernel. So GCC just
does as told and emits a function call.

If I replace the __set_bit() in ghcb_set_##field() with arch___set_bit()
the problem goes away.

Excluding the whole file from KCSAN switches to the non-instrumented
version of __set_bit() which directly resolves to arch___set_bit().

Thanks,

        tglx

