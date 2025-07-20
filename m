Return-Path: <linux-kernel+bounces-738137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346EB0B4EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FED17B5DD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071E1F1534;
	Sun, 20 Jul 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mm+CK9OS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/E7nUaS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFC4CE08
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008264; cv=none; b=KdQniCuDNgl+YZMpe3nMPIWclZk5KB8hr59dZneUw6WR+ZtnLYqxVvVZyUzVI4gbH+7PjzL1kShBAx1SvEgaEGYwIWXffSd9bK6N8FzXQg0O+PaNYIfOwEOjqqGwLYALsXpYObiVHHr7/SPufJxlYmAl4D5yysuXotVyz8kpKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008264; c=relaxed/simple;
	bh=lVKdc+tJ7FfRINXc/ujFRtN5h17UFT3DPFq0381gtrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tDUreic/teNcC7kYfkesXJ5WsGZ792lHWZv0a5wuDcrNCpBwZFPPlJrG2FYdVm+/4gwBTIBTAxdie8jVUwGCyCXlsFgAs2OxMpriF07mWUUHeeZRPAxAAwNYEjlcmlTBMsfJhDJwVIKmIMAIViipKiGbHbo7tEEc3TadUinqz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mm+CK9OS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/E7nUaS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753008260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AROlAM8L+MN+xV+BPhHguC5F0Fg6H2fq2BsOliXx4N4=;
	b=mm+CK9OSffTINwSUljs3NVYt5nXP9RBa/NkoUZ0dqXVtGj861clBfL4K7h5LtaQUgAJ8iM
	1nI4Z4TL6eNodTtG4GVibz8kFnt3jKE//iFpoW+QetHkI/L5xsc0AB/oKmMmKUTJtPMGCy
	zUJczAFcRBDTswTitr8hhCSXMI5WLOX8cNHzSkc+XghVXtWermh2b+ddqpS+zfyj1SeXIp
	rX+nR2K2uZjrk1fXVVSxBpyez2O5wdQwpzml762BX55g+JgRa8nCWodE9WjcVqYknEhl92
	kPjh52M2UZ+wblG2TLZz9411LJee6T7XJ2u7SDGulHZD/aeqCeL/vzTm+ni8gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753008260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AROlAM8L+MN+xV+BPhHguC5F0Fg6H2fq2BsOliXx4N4=;
	b=W/E7nUaSJVngOf5E68FI1ghTpW3Wd0qGUKbL4NCerl7x6FDDvHuwuBfcuddJvzB10BeiuJ
	Qp3wVkW1WQ0DTKDA==
To: Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ilpo =?utf-8?Q?J=C3=A4rv?=
 =?utf-8?Q?inen?=
 <ilpo.jarvinen@linux.intel.com>, Fernando Fernandez Mancera
 <ffmancera@riseup.net>, "Xin Li (Intel)" <xin@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 1/2] bitmap: add bitmap_weight_from()
In-Reply-To: <20250720014146.432316-2-yury.norov@gmail.com>
References: <20250720014146.432316-1-yury.norov@gmail.com>
 <20250720014146.432316-2-yury.norov@gmail.com>
Date: Sun, 20 Jul 2025 12:44:19 +0200
Message-ID: <87cy9vuoos.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 19 2025 at 21:41, Yury Norov wrote:
>  
> +#define BITMAP_WEIGHT_FROM(FETCH, start, bits)				\
> +({										\
> +	unsigned long __start = (start), __bits = (bits);			\
> +	unsigned int idx, w = 0;						\
> +										\
> +	if (unlikely(__start >= bits))						\
> +		goto out;							\
> +										\
> +	idx = __start / BITS_PER_LONG;						\
> +	w = (FETCH) & BITMAP_FIRST_WORD_MASK(__start);				\

So this expands to

        w = bitmap[idx] & (~0UL << ((start) & (BITS_PER_LONG - 1)));

Which means @w contains the content of the first bitmap word except for
the masked off bits. Let's assume @start is 0 and @bits is 32. Therefore
@idx is 0.

Assume further bitmap[idx] is all ones, which means 64bits set on a
64bit system. That results in

      w = bitmap[0] & (~0UL << ((0) & (BITS_PER_LONG - 1)));
-->   w = 0xFFFFFFFFFFFFFFFF & (0xFFFFFFFFFFFFFFFF << (0 & 0x3F));
-->   w = 0xFFFFFFFFFFFFFFFF;

which is obviously bogus.

> +	for (++idx; idx < __bits / BITS_PER_LONG; idx++)			\
> +		w += hweight_long(FETCH);					\

Evaluates to false

> +	if (__bits % BITS_PER_LONG)						\

Evaluates to true.

> +		w += hweight_long((FETCH) & BITMAP_LAST_WORD_MASK(__bits));	\

So this is executed and evaluates to:

      w += hweight_long(bitmap[1] & (~0UL >> (-(32UL) & (BITS_PER_LONG - 1))));

Let's assume the second word contains all ones as well.

-->   w += hweight_long(0xFFFFFFFFFFFFFFFF & (0xFFFFFFFFFFFFFFFF >> (0xFFFFFFFFFFFFFFE0 & 0x3F)));
-->   w += hweight_long(0xFFFFFFFFFFFFFFFF & (0xFFFFFFFFFFFFFFFF >> (0x20)));
-->   w += hweight_long(0xFFFFFFFFFFFFFFFF & 0xFFFFFFFF);

-->   w += 32;

Due to the wraparound of the addition it results in

      w = 31

which is not making the bogosity above more correct. And no, you can't
just fix up the initial assignment to @w:

	w = hweight_long((FETCH) & BITMAP_FIRST_WORD_MASK(__start);

because then the result is 32 + 32 == 64 as the final clause is
unconditionally executed.

Something like this should work:

        unsigned int idx, maxidx, w = 0;

	idx = start / BITS_PER_LONG;
	w = hweight_long((FETCH) & BITMAP_FIRST_WORD_MASK((unsigned long)start));

        maxidx = bits / BITS_PER_LONG;
        for (idx++; idx < maxidx; idx++)
        	w += hweight_long((FETCH));

        if (maxidx * BITS_PER_LONG < bits)
        	w += hweight_long((FETCH) & BITMAP_LAST_WORD_MASK((unsigned long)bits));
        
No?

Thanks,

        tglx


