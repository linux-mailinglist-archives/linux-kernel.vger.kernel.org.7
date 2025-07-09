Return-Path: <linux-kernel+bounces-723878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5932AFEBEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3C41889621
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E56A2E3B17;
	Wed,  9 Jul 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvTpdrk0"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A102E175E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071068; cv=none; b=cFaXJ5nWlluMVFRankWVYW1H3ZuQT3maFrCg+piC8ZopLCPsuuDiuBvaFozYo0gzQaCitytX+NklZrcHvcRrf7c9q6YKuczv5q1xZ+fVIpna3bjmHeRMASYatH8ysCQcUt5VxQhtc/FF72Rjk1k/KKbwP/HDRvHzl9W+hK6H01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071068; c=relaxed/simple;
	bh=EQI7kIYEYUHQcXqnu5NSE+BVgCqlFQ5PfDIxIp538Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DU2LGUdkPDsPtlFlJHUQojmRQLiRuxktmlcWtpLJeq78dYxcE1YXn92szLjpwPnHSzvKzpDs80VkO5G2EnO2q8mZxUgzrVejnnCICCKG59qu9L89ETawVDhiVDItfiRq7ms6nh7ej7xkJQS2z4nbNHoOnBUueQamlhlHlMptM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvTpdrk0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a588da60dfso3920123f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071063; x=1752675863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74+QtSUmVjyffEEuc7m+DJsW1W/DKBGM87MhkWuK53E=;
        b=EvTpdrk0GfPZL6+ARAsqHov4GZRqnudbb1YOOq3XdQr7t87OZkH33+kTtxbaDQTJTH
         fzG47e3T5YOcJY25BtU7dokvTBwVG/ihnOZy4N8bxG151Gj6LI+3o3Qt3HvKiBSknKvu
         dhCt44n3M4619CV5hL2/eluOY9+gwXDt0Yb1yNTAiiybAqHty12eBVsfpPbDnw3p8ctU
         E1aJlfWqQgT/rMvKbkVdC6oJUusia8oXkNkTL9/6lwZ+q47ro24tReXCSeYdq4+Yklwd
         aIomwuoItSwrCnTDWbxnwOfwHqGW+KGxA7VQgC/KpOWriKwBZQuQlAzggQmN5+1OHKoq
         httA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071063; x=1752675863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74+QtSUmVjyffEEuc7m+DJsW1W/DKBGM87MhkWuK53E=;
        b=gLo0LcMoiM4EIQJZlHCfOKb0mfHGc/comz2CJoMn1L3E39Fh889PUZXkFGyMD0UBVe
         An/IS6GOT3KH9SkaXWg87uX+6MPgL7seoNeH+MzPH7jOhgzsMvCD9xNZxgDZo4wdcI3j
         eWadvDc0kEW4nkBOTwlqvo0hPJcGm/PAQ8uGH4iy+9Vo1Qm5d+LFL7WxqNyj24H9EWAh
         4lv03jkD2zF8JUF8OtdfDDO/8gIhZ8ms9/KVcvC7qxR9iu/Eqdh5uRzX4C1hsWMW6gba
         ildXEyHkFVL4aUIE3OYaaO5V/j+kM8kU1kyAW1/NoQRd6Dljr8WG/yBKwuTwwccSwRVy
         ulrw==
X-Forwarded-Encrypted: i=1; AJvYcCVpYdO9g1gia9x9e1hhaNQE13u8sLnZCfZljrGcZw8Sfvk1tfS2lvSFp3Im/gseyb/dxOa2tUaEVMro7X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkewp15Xdei9gd2sEYtJ0TNwdfpMkdfv6PrGfX0kgVkM53AHm
	sCLyI+IARm5qmMZ0Y2CqI584ZXNmGOaPAYE+JuY4P/N8YdVO9etGpieH
X-Gm-Gg: ASbGncuOPI9m851lZ8ecjhnSBWDHkDZzy00G55JKGa2KbPUvku6lKCN4xpttWbgUscn
	jqrqTt+AdlhsznMIP7oG4qX6oA/Qo7EtJWnk/4UpCZIvlcBd+M68kkFvUhufFzr9pINuoNK7qht
	Gu+8yx2rhUUp0VIrN7GSfs6jtzAXrAAPZkrQGSM14+xZtk4VhWp7gcTf3Nr1jSEulibRXuH9k0u
	T0fPr6ePN7P9E7JnTa3hEPAXLK31hBpmP7pqsiT3kgBdjqPqRckR0Eunj1pIuXL0cHCj99ox9j4
	Os7v1FdwBIrkDJp0WMwjcpqssN3IpG+fYCQtqdTS3MbZXK8HrPFQaQ6q+Wif0zQh2X6hLyK5Rgd
	M/xuM8KG+2h2MwcAF0g==
X-Google-Smtp-Source: AGHT+IEBbbN33U1p+Fgso9on/hc8WM1g3GBccw5ZG4tcIa5fsIQxIVWaz/RHinQetxJ3R3/+tNOhLA==
X-Received: by 2002:a5d:6449:0:b0:3a3:7987:945f with SMTP id ffacd0b85a97d-3b5e7907a98mr83623f8f.57.1752071062807;
        Wed, 09 Jul 2025 07:24:22 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bc5asm15796382f8f.20.2025.07.09.07.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:24:22 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:24:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: u.kleine-koenig@baylibre.com, Nicolas Pitre <npitre@baylibre.com>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, rostedt@goodmis.org, lirongqing@baidu.com
Subject: Re: [PATCH v3 next 09/10] lib: mul_u64_u64_div_u64() Optimise the
 divide code
Message-ID: <20250709152420.4c95c22d@pumpkin>
In-Reply-To: <20250614095346.69130-10-david.laight.linux@gmail.com>
References: <20250614095346.69130-1-david.laight.linux@gmail.com>
	<20250614095346.69130-10-david.laight.linux@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 10:53:45 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> Replace the bit by bit algorithm with one that generates 16 bits
> per iteration on 32bit architectures and 32 bits on 64bit ones.

I've spent far too long doing some clock counting exercises on this code.
This is the latest version with some conditional compiles and comments
explaining the various optimisation.
I think the 'best' version is with -DMULDIV_OPT=0xc3

#ifndef MULDIV_OPT
#define MULDIV_OPT 0
#endif

#ifndef BITS_PER_ITER
#define BITS_PER_ITER (__LONG_WIDTH__ >= 64 ? 32 : 16)
#endif

#define unlikely(x)  __builtin_expect((x), 0)
#define likely(x)  __builtin_expect(!!(x), 1)

#if __LONG_WIDTH__ >= 64

/* gcc generates sane code for 64bit. */
static unsigned int tzcntll(unsigned long long x)
{
        return __builtin_ctzll(x);
}

static unsigned int lzcntll(unsigned long long x)
{
        return __builtin_clzll(x);
}
#else
        
/*
 * Assuming that bsf/bsr dont change the output register
 * when the input is zero (should be true now that 486 aren't
 * supported) these simple conditional (and cmov) free functions
 * can be used to count trailing/leading zeros.
 */
static inline unsigned int tzcnt_z(u32 x, unsigned int if_z)
{               
        asm("bsfl %1,%0" : "+r" (if_z) : "r" (x));
        return if_z;
}

static inline unsigned int tzcntll(unsigned long long x)
{
        return tzcnt_z(x, 32 + tzcnt_z(x >> 32, 32));
}

static inline unsigned int bsr_z(u32 x, unsigned int if_z)
{
        asm("bsrl %1,%0" : "+r" (if_z) : "r" (x));
        return if_z;
}

static inline unsigned int bsrll(unsigned long long x)
{
        return 32 + bsr_z(x >> 32, bsr_z(x, -1) - 32);
}

static inline unsigned int lzcntll(unsigned long long x)
{
        return 63 - bsrll(x);
}

#endif

/*
 *  gcc (but not clang) makes a pigs-breakfast of mixed
 *  32/64 bit maths.
 */
#if !defined(__i386__) || defined(__clang__)
static u64 add_u64_u32(u64 a, u32 b)
{
        return a + b;
}

static inline u64 mul_u32_u32(u32 a, u32 b)
{
        return (u64)a * b;
}
#else
static u64 add_u64_u32(u64 a, u32 b)
{
        u32 hi = a >> 32, lo = a;

        asm ("addl %[b], %[lo]; adcl $0, %[hi]"
                         : [lo] "+r" (lo), [hi] "+r" (hi)
                         : [b] "rm" (b) );

        return (u64)hi << 32 | lo;
}

static inline u64 mul_u32_u32(u32 a, u32 b)
{
        u32 high, low;

        asm ("mull %[b]" : "=a" (low), "=d" (high)
                         : [a] "a" (a), [b] "rm" (b) );

        return low | ((u64)high) << 32;
}
#endif

static inline u64 mul_add(u32 a, u32 b, u32 c)
{
        return add_u64_u32(mul_u32_u32(a, b), c);
}

#if defined(__SIZEOF_INT128__)
typedef unsigned __int128 u128;
static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
{
        /* native 64x64=128 bits multiplication */
        u128 prod = (u128)a * b + c;

        *p_lo = prod;
        return prod >> 64;
}

#else
static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
{
        /* perform a 64x64=128 bits multiplication in 32bit chunks */
        u64 x, y, z;

        /* Since (x-1)(x-1) + 2(x-1) == x.x - 1 two u32 can be added to a u64 */
        x = mul_add(a, b, c);
        y = mul_add(a, b >> 32, c >> 32);
        y = add_u64_u32(y, x >> 32);
        z = mul_add(a >> 32, b >> 32, y >> 32);
        y = mul_add(a >> 32, b, y);
        *p_lo = (y << 32) + (u32)x;
        return add_u64_u32(z, y >> 32);
}

#endif

#if BITS_PER_ITER == 32
#define mul_u64_long_add_u64(p_lo, a, b, c) mul_u64_u64_add_u64(p_lo, a, b, c)
#define add_u64_long(a, b) ((a) + (b))

#else
static inline u32 mul_u64_long_add_u64(u64 *p_lo, u64 a, u32 b, u64 c)
{
        u64 n_lo = mul_add(a, b, c);
        u64 n_med = mul_add(a >> 32, b, c >> 32);

        n_med = add_u64_u32(n_med, n_lo >> 32);
        *p_lo = n_med << 32 | (u32)n_lo;
        return n_med >> 32;
}

#define add_u64_long(a, b) add_u64_u32(a, b)

#endif

#if MULDIV_OPT & 0x40
/*
 * If the divisor has BITS_PER_ITER or fewer bits then a simple
 * long division can be done.
 */
#if BITS_PER_ITER == 16
static u64 div_u80_u16(u32 n_hi, u64 n_lo, u32 d)
{
        u64 q = 0;

        if (n_hi) {
                n_hi = n_hi << 16 | (u32)(n_lo >> 48);
                q = (n_hi / d) << 16;
                n_hi = (n_hi % d) << 16 | (u16)(n_lo >> 32);
        } else {
                n_hi = n_lo >> 32;
                if (!n_hi)
                        return (u32)n_lo / d;
        }
        q |= n_hi / d;
        q <<= 32;
        n_hi = (n_hi % d) << 16 | ((u32)n_lo >> 16);
        q |= (n_hi / d) << 16;
        n_hi = (n_hi % d) << 16 | (u16)n_lo;
        q |= n_hi / d;

        return q;
}
#else
static u64 div_u96_u32(u64 n_hi, u64 n_lo, u32 d)
{
        u64 q;

        if (!n_hi)
                return n_lo / d;

        n_hi = n_hi << 32 | n_lo >> 32;
        q = (n_hi / d) << 32;
        n_hi = (n_hi % d) << 32 | (u32)n_lo;
        return q | n_hi / d;
}
#endif
#endif

u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
{
        unsigned long d_msig, n_long, q_digit;
        unsigned int reps, d_z_hi;
        u64 quotient, n_lo, n_hi;
        u32 overflow;

        n_hi = mul_u64_u64_add_u64(&n_lo, a, b, c);
        if (unlikely(n_hi >= d)) {
                if (!d)
                        // Quotient infinity or NaN
                        return 0;
                // Quotient larger than 64 bits
                return ~(u64)0;
        }

#if !(MULDIV_OPT & 0x80)
        // OPT: Small divisors can be optimised here.
        // OPT: But the test is measurable and a lot of the cases get
        // OPT: picked up by later tests - especially 1, 2 and 0x40.
        // OPT: For 32bit a full 64bit divide will also be non-trivial.
        if (unlikely(!n_hi))
                return div64_u64(n_lo, d);
#endif

        d_z_hi = lzcntll(d);

#if MULDIV_OPT & 0x40
        // Optimise for divisors with less than BITS_PER_ITER significant bits.
        // OPT: A much simpler 'long division' can be done.
        // OPT: The test could be reworked to avoid the txcntll() when d_z_hi
        // OPT: is large enough - but the code starts looking horrid.
        // OPT: This picks up the same divisions as OPT 8, with a faster algorithm.
        u32 d_z_lo = tzcntll(d);
        if (d_z_hi + d_z_lo >= 64 - BITS_PER_ITER) {
                if (d_z_hi < 64 - BITS_PER_ITER) {
                        n_lo = n_lo >> d_z_lo | n_hi << (64 - d_z_lo);
                        n_hi >>= d_z_lo;
                        d >>= d_z_lo;
                }
#if BITS_PER_ITER == 16
                return div_u80_u16(n_hi, n_lo, d);
#else
                return div_u96_u32(n_hi, n_lo, d);
#endif
        }
#endif

        /* Left align the divisor, shifting the dividend to match */
#if MULDIV_OPT & 0x10
        // OPT: Replacing the 'pretty much always taken' branch
        // OPT: with an extra shift (one clock - should be noise)
        // OPT: feels like it ought to be a gain (for 64bit).
        // OPT: Most of the test cases have 64bit divisors - so lose,
        // OPT: but even some with a smaller divisor are hit for a few clocks.
        // OPT: Might be generating a register spill to stack.
        d <<= d_z_hi;
        n_hi = n_hi << d_z_hi | (n_lo >> (63 - d_z_hi) >> 1);
        n_lo <<= d_z_hi;
#else
        if (d_z_hi) {
                d <<= d_z_hi;
                n_hi = n_hi << d_z_hi | n_lo >> (64 - d_z_hi);
                n_lo <<= d_z_hi;
        }
#endif

        reps = 64 / BITS_PER_ITER;
        /* Optimise loop count for small dividends */
#if MULDIV_OPT & 1
        // OPT: Products with lots of leading zeros are almost certainly
        // OPT: very common.
        // OPT: The gain from removing the loop iterations is significant.
        // OPT: Especially on 32bit where two iterations can be removed
        // OPT: with a simple shift and conditional jump.
        if (!(u32)(n_hi >> 32)) {
                reps -= 32 / BITS_PER_ITER;
                n_hi = n_hi << 32 | n_lo >> 32;
                n_lo <<= 32;
        }
#endif
#if MULDIV_OPT & 2 && BITS_PER_ITER == 16
        if (!(u32)(n_hi >> 48)) {
                reps--;
                n_hi = add_u64_u32(n_hi << 16, n_lo >> 48);
                n_lo <<= 16;
        }
#endif

        /*
         * Get the most significant BITS_PER_ITER bits of the divisor.
         * This is used to get a low 'guestimate' of the quotient digit.
         */
        d_msig = (d >> (64 - BITS_PER_ITER));
#if MULDIV_OPT & 8
        // OPT: d_msig only needs rounding up - so can be unchanged if
        // OPT: all its low bits are zero.
        // OPT: However the test itself causes register pressure on x86-32.
        // OPT: The earlier check (0x40) optimises the same cases.
        // OPT: The code it generates is a lot better.
        d_msig += !!(d << BITS_PER_ITER);
#else
        d_msig += 1;
#endif


        /* Invert the dividend so we can use add instead of subtract. */
        n_lo = ~n_lo;
        n_hi = ~n_hi;

        /*
         * Now do a 'long division' with BITS_PER_ITER bit 'digits'.
         * The 'guess' quotient digit can be low and BITS_PER_ITER+1 bits.
         * The worst case is dividing ~0 by 0x8000 which requires two subtracts.
         */
        quotient = 0;
        while (reps--) {
                n_long = ~n_hi >> (64 - 2 * BITS_PER_ITER);
#if !(MULDIV_OPT & 0x20)
                // OPT: If the cpu divide instruction has a long latency an other
                // OPT: instructions can execute while the divide is pending then
                // OPT: you want the divide as early as possible.
                // OPT: I've seen delays if it moved below the shifts, but I suspect
                // OPT: the ivy bridge cpu spreads the u-ops between the execution
                // OPT: units so you don't get the full latency to play with.
                // OPT: gcc doesn't put the divide as early as it might, attempting to
                // OPT: do so by hand failed - and I'm not playing with custom asm.
                q_digit = n_long / d_msig;
#endif
                /* Shift 'n' left to align with the product q_digit * d */
                overflow = n_hi >> (64 - BITS_PER_ITER);
                n_hi = add_u64_u32(n_hi << BITS_PER_ITER, n_lo >> (64 - BITS_PER_ITER));
                n_lo <<= BITS_PER_ITER;
                quotient <<= BITS_PER_ITER;
#if MULDIV_OPT & 4
                // OPT: This optimises for zero digits.
                // OPT: With the compiler/cpu I using today (gcc 13.3 and Sandy bridge)
                // OPT: it needs the divide moved below the conditional.
                // OPT: For x86-64 0x24 and 0x03 are actually pretty similar,
                // OPT: but x86-32 is definitely slower all the time, and the outer
                // OPT: check removes two loop iterations at once.
                if (unlikely(n_long < d_msig)) {
                        // OPT: Without something here the 'unlikely' still generates
                        // OPT: a conditional backwards branch which some cpu will
                        // OPT: statically predict taken.
                        // asm( "nop");
                        continue;
                }
#endif
#if MULDIV_OPT & 0x20
                q_digit = n_long / d_msig;
#endif
                /* Add product to negated divisor */
                overflow += mul_u64_long_add_u64(&n_hi, d, q_digit, n_hi);
                /* Adjust for the q_digit 'guestimate' being low */
                while (unlikely(overflow < 0xffffffff >> (32 - BITS_PER_ITER))) {
                        q_digit++;
                        n_hi += d;
                        overflow += n_hi < d;
                }
                quotient = add_u64_long(quotient, q_digit);
        }

        /*
         * The above only ensures the remainder doesn't overflow,
         * it can still be possible to add (aka subtract) another copy
         * of the divisor.
         */
        if ((n_hi + d) > n_hi)
                quotient++;
        return quotient;
}

Some measurements on an ivy bridge.
These are the test vectors from the test module with a few extra values on the
end that pick different paths through this implementatoin.
The numbers are 'performance counter' deltas for 10 consecutive calls with the
same values.
So the latter values are with the branch predictor 'trained' to the test case.
The first few (larger) values show the cost of mispredicted branches.

Apologies for the very long lines.

$ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0xc3  && sudo ./div_perf
0: ok   162   134    78    78    78    78    78    80    80    80 mul_u64_u64_div_u64_new b*7/3 = 19
1: ok    91    91    91    91    91    91    91    91    91    91 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
2: ok    75    77    75    77    77    77    77    77    77    77 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
3: ok    89    91    91    91    91    91    89    90    91    91 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   147   147   128   128   128   128   128   128   128   128 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok   128   128   128   128   128   128   128   128   128   128 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   121   121   121   121   121   121   121   121   121   121 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   274   234   146   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok   177   148   148   149   149   149   149   149   149   149 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   138    90   118    91    91    91    91    92    92    92 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
10: ok   113   114    86    86    84    86    86    84    87    87 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
11: ok    87    88    88    86    88    88    88    88    90    90 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
12: ok    82    86    84    86    83    86    83    86    83    87 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok    82    86    84    86    83    86    83    86    83    86 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   189   187   138   132   132   132   131   131   131   131 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   221   175   159   131   131   131   131   131   131   131 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   134   132   134   134   134   135   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   172   134   137   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok   182   182   129   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok   130   129   130   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok   130   129   129   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   130   129   129   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   206   140   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok   174   140   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok   135   137   137   137   137   137   137   137   137   137 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok   134   136   136   136   136   136   136   136   136   136 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok   136   134   134   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok   139   138   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   130   143    95    95    96    96    96    96    96    96 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok   169   158   158   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   178   164   144   147   147   147   147   147   147   147 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok   163   128   128   128   128   128   128   128   128   128 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok   163   184   137   136   136   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

$ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x03  && sudo ./div_perf
0: ok   125    78    78    79    79    79    79    79    79    79 mul_u64_u64_div_u64_new b*7/3 = 19
1: ok    88    89    89    88    89    89    89    89    89    89 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
2: ok    75    76    76    76    76    76    74    76    76    76 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
3: ok    87    89    89    89    89    89    89    88    88    88 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   305   221   148   144   147   147   147   147   147   147 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok   179   178   141   141   141   141   141   141   141   141 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   148   200   143   145   145   145   145   145   145   145 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   201   186   140   135   135   135   135   135   135   135 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok   227   154   145   141   141   141   141   141   141   141 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   111   111    89    89    89    89    89    89    89    89 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
10: ok   149   156   124    90    90    90    90    90    90    90 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
11: ok    91    91    90    90    90    90    90    90    90    90 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
12: ok   197   197   138   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok   260   136   136   135   135   135   135   135   135   135 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   186   187   164   130   127   127   127   127   127   127 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   171   172   173   158   160   128   125   127   125   127 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   157   164   129   130   130   130   130   130   130   130 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   191   158   130   132   132   130   130   130   130   130 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok   197   214   163   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok   196   196   135   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok   191   216   176   140   138   138   138   138   138   138 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   232   157   156   145   145   145   145   145   145   145 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   159   192   133   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok   133   134   134   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok   134   131   131   131   131   134   131   131   131   131 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok   133   130   130   130   130   130   130   130   130   130 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok   133   130   130   130   130   130   130   130   130   131 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok   133   134   134   134   134   134   134   134   134   133 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   151    93   119    93    93    93    93    93    93    93 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok   193   137   134   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   194   151   150   137   137   137   137   137   137   137 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok   137   173   172   137   138   138   138   138   138   138 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok   160   149   131   134   134   134   134   134   134   134 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

$ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x24  && sudo ./div_perf
0: ok   130   106    79    79    78    78    78    78    81    81 mul_u64_u64_div_u64_new b*7/3 = 19
1: ok    88    92    92    89    92    92    92    92    91    91 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
2: ok    74    78    78    78    78    78    75    79    78    78 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
3: ok    87    92    92    92    92    92    92    92    92    92 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   330   275   181   145   147   148   148   148   148   148 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok   225   175   141   146   146   146   146   146   146   146 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   187   194   193   194   178   144   148   148   148   148 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   202   189   178   139   140   139   140   139   140   139 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok   228   168   150   143   143   143   143   143   143   143 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   112   112    92    89    92    92    92    92    92    87 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
10: ok   153   184    92    93    95    95    95    95    95    95 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
11: ok   158    93    93    93    95    92    95    95    95    95 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
12: ok   206   178   146   139   139   140   139   140   139   140 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok   187   146   140   139   140   139   140   139   140   139 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   167   173   136   136   102    97    97    97    97    97 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   166   150   105    98    98    98    97    99    97    99 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   209   197   139   136   136   136   136   136   136   136 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   170   142   170   137   136   135   136   135   136   135 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok   238   197   172   140   140   140   139   141   140   139 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok   185   206   139   141   142   142   142   142   142   142 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok   207   226   146   142   140   140   140   140   140   140 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   161   153   148   148   148   148   148   148   148   146 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   172   199   141   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok   172   137   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok   135   138   138   138   138   138   138   138   138   138 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok   136   137   137   137   137   137   137   137   137   137 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok   136   136   136   136   136   136   136   136   136   136 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok   139   140   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   132    94    97    96    96    96    96    96    96    96 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok   139   140   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   159   141   141   141   141   141   141   141   141   141 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok   244   186   154   141   139   141   140   139   141   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok   165   140   140   140   140   140   140   140   140   140 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

$ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0xc3 -m32 && sudo ./div_perf
0: ok   336   131   104   104   102   102   103   103   103   105 mul_u64_u64_div_u64_new b*7/3 = 19
1: ok   195   195   171   171   171   171   171   171   171   171 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
2: ok   165   162   162   162   162   162   162   162   162   162 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
3: ok   165   173   173   173   173   173   173   173   173   173 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   220   216   202   206   202   206   202   206   202   206 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok   203   205   208   205   209   205   209   205   209   205 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   203   203   199   203   199   203   199   203   199   203 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   574   421   251   242   246   254   246   254   246   254 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok   370   317   263   262   254   259   258   262   254   259 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   214   199   177   177   177   177   177   177   177   177 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
10: ok   163   150   128   129   129   129   129   129   129   129 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
11: ok   135   133   135   135   135   135   135   135   135   135 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
12: ok   206   208   208   180   183   183   183   183   183   183 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok   205   183   183   184   183   183   183   183   183   183 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   331   296   238   229   232   232   232   232   232   232 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   324   311   238   239   239   239   239   239   239   242 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   300   262   265   233   238   234   238   234   238   234 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   295   282   244   244   244   244   244   244   244   244 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok   245   247   235   222   221   222   219   222   221   222 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok   235   221   222   221   222   219   222   221   222   219 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok   220   222   221   222   219   222   219   222   221   222 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   225   221   222   219   221   219   221   219   221   219 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   309   274   250   238   237   244   239   241   237   244 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok   284   284   250   247   243   247   247   243   247   247 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok   239   239   243   240   239   239   239   239   239   239 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok   255   255   255   255   247   243   247   247   243   247 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok   327   274   240   242   240   242   240   242   240   242 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok   461   313   340   259   257   259   257   259   257   259 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   291   219   180   174   170   173   171   174   171   174 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok   280   319   258   257   259   257   259   257   259   257 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   379   352   247   239   220   225   225   229   228   229 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok   235   219   221   219   221   219   221   219   221   219 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok   305   263   257   257   258   258   263   257   257   257 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

$ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x03 -m32 && sudo ./div_perf
0: ok   292   127   129   125   123   128   125   123   125   121 mul_u64_u64_div_u64_new b*7/3 = 19
1: ok   190   196   151   149   151   149   151   149   151   149 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
2: ok   141   139   139   139   139   139   139   139   139   139 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
3: ok   152   149   151   149   151   149   151   149   151   149 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   667   453   276   270   271   271   271   267   274   272 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok   366   319   373   337   278   278   278   278   278   278 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   380   349   268   268   271   265   265   265   265   265 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   340   277   255   251   249   255   251   249   255   251 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok   377   302   253   252   256   256   256   256   256   256 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   181   184   157   155   157   155   157   155   157   155 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
10: ok   304   223   142   139   139   141   139   139   139   139 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
11: ok   153   143   148   142   143   142   143   142   143   142 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
12: ok   428   323   292   246   257   248   253   250   248   253 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok   289   256   260   257   255   257   255   257   255   257 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   334   246   234   234   227   233   229   233   229   233 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   324   302   273   236   236   236   236   236   236   236 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   269   328   285   259   232   230   236   232   232   236 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   307   329   330   244   247   246   245   245   245   245 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok   359   361   324   258   258   258   258   258   258   258 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok   347   325   295   258   260   253   251   251   251   251 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok   339   312   261   260   255   255   255   255   255   255 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   411   349   333   276   272   272   272   272   272   272 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   297   330   290   266   239   236   238   237   238   237 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok   299   311   250   247   250   245   247   250   245   247 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok   274   245   238   237   237   237   237   237   237   247 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok   247   247   245   247   250   245   247   250   245   247 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok   341   354   288   239   242   240   239   242   240   239 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok   408   375   288   312   257   260   259   259   259   259 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   289   259   199   198   201   170   170   174   173   173 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok   334   257   260   257   260   259   259   259   259   259 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   341   267   244   233   229   233   229   233   229   233 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok   323   323   297   297   264   268   267   268   267   268 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok   284   262   251   251   253   251   251   251   251   251 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

$ cc -O2 -o div_perf div_perf.c -DMULDIV_OPT=0x24 -m32 && sudo ./div_perf
0: ok   362   127   125   122   123   122   125   129   126   126 mul_u64_u64_div_u64_new b*7/3 = 19
1: ok   190   175   149   150   154   150   154   150   154   150 mul_u64_u64_div_u64_new ffff0000*ffff0000/f = 1110eeef00000000
2: ok   144   139   139   139   139   139   139   139   139   139 mul_u64_u64_div_u64_new ffffffff*ffffffff/1 = fffffffe00000001
3: ok   146   150   154   154   150   154   150   154   150   154 mul_u64_u64_div_u64_new ffffffff*ffffffff/2 = 7fffffff00000000
4: ok   747   554   319   318   316   319   318   328   314   324 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/2 = fffffffe80000000
5: ok   426   315   312   315   315   315   315   315   315   315 mul_u64_u64_div_u64_new 1ffffffff*ffffffff/3 = aaaaaaa9aaaaaaab
6: ok   352   391   317   316   323   327   323   327   323   324 mul_u64_u64_div_u64_new 1ffffffff*1ffffffff/4 = ffffffff00000000
7: ok   369   328   298   292   298   292   298   292   298   292 mul_u64_u64_div_u64_new ffff000000000000*ffff000000000000/ffff000000000001 = fffeffffffffffff
8: ok   436   348   298   299   298   300   307   297   297   301 mul_u64_u64_div_u64_new 3333333333333333*3333333333333333/5555555555555555 = 1eb851eb851eb851
9: ok   180   183   151   151   151   151   151   151   151   153 mul_u64_u64_div_u64_new 7fffffffffffffff*2/3 = 5555555555555554
10: ok   286   251   188   169   174   170   178   170   178   170 mul_u64_u64_div_u64_new ffffffffffffffff*2/8000000000000000 = 3
11: ok   230   177   172   177   172   177   172   177   172   177 mul_u64_u64_div_u64_new ffffffffffffffff*2/c000000000000000 = 2
12: ok   494   412   371   331   296   298   305   290   296   298 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000004/8000000000000000 = 8000000000000007
13: ok   330   300   304   305   290   305   294   302   290   296 mul_u64_u64_div_u64_new ffffffffffffffff*4000000000000001/8000000000000000 = 8000000000000001
14: ok   284   241   175   172   176   175   175   172   176   175 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/ffffffffffffffff = 8000000000000001
15: ok   283   263   171   176   175   175   175   175   175   175 mul_u64_u64_div_u64_new fffffffffffffffe*8000000000000001/ffffffffffffffff = 8000000000000000
16: ok   346   247   258   208   202   205   208   202   205   208 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffe = 8000000000000001
17: ok   242   272   208   213   209   213   209   213   209   213 mul_u64_u64_div_u64_new ffffffffffffffff*8000000000000001/fffffffffffffffd = 8000000000000002
18: ok   494   337   306   309   309   309   309   309   309   309 mul_u64_u64_div_u64_new 7fffffffffffffff*ffffffffffffffff/c000000000000000 = aaaaaaaaaaaaaaa8
19: ok   392   394   329   305   299   302   294   302   292   305 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/a000000000000000 = ccccccccccccccca
20: ok   372   307   306   310   308   310   308   310   308   310 mul_u64_u64_div_u64_new ffffffffffffffff*7fffffffffffffff/9000000000000000 = e38e38e38e38e38b
21: ok   525   388   310   320   314   313   314   315   312   315 mul_u64_u64_div_u64_new 7fffffffffffffff*7fffffffffffffff/5000000000000000 = ccccccccccccccc9
22: ok   400   293   289   354   284   283   284   284   284   284 mul_u64_u64_div_u64_new ffffffffffffffff*fffffffffffffffe/ffffffffffffffff = fffffffffffffffe
23: ok   320   324   289   290   289   289   290   289   289   290 mul_u64_u64_div_u64_new e6102d256d7ea3ae*70a77d0be4c31201/d63ec35ab3220357 = 78f8bf8cc86c6e18
24: ok   279   289   290   285   285   285   285   285   285   285 mul_u64_u64_div_u64_new f53bae05cb86c6e1*3847b32d2f8d32e0/cfd4f55a647f403c = 42687f79d8998d35
25: ok   288   290   289   289   290   289   289   290   289   289 mul_u64_u64_div_u64_new 9951c5498f941092*1f8c8bfdf287a251/a3c8dc5f81ea3fe2 = 1d887cb25900091f
26: ok   361   372   351   325   288   293   286   293   294   293 mul_u64_u64_div_u64_new 374fee9daa1bb2bb*d0bfbff7b8ae3ef/c169337bd42d5179 = 3bb2dbaffcbb961
27: ok   483   349   302   302   305   300   307   304   307   304 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
28: ok   339   328   234   233   213   214   213   208   215   208 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/d63ec35ab3220357 = 1a599d6e
29: ok   406   300   303   300   307   304   307   304   307   304 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216
30: ok   404   421   335   268   265   271   267   271   267   272 mul_u64_u64_div_u64_new 2d256d7ea3ae*7d0be4c31201/63ec35ab3220357 = 387f55cef
31: ok   484   350   310   309   306   309   309   306   309   309 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb000000000000 = dc5f7e8b334db07d
32: ok   368   306   301   307   304   307   304   307   304   307 mul_u64_u64_div_u64_new eac0d03ac10eeaf0*89be05dfa162ed9b/92bb1679a41f0e4b = dc5f5cc9e270d216

	David

