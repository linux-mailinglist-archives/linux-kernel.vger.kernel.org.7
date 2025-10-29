Return-Path: <linux-kernel+bounces-877132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23627C1D474
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA343BEEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4030B533;
	Wed, 29 Oct 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NxQ7z5rC"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E72FFFB1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770876; cv=none; b=jJde3M+bYo4kXOi5hC3ZcNG/3L1EIX7rS1D5nstN47W911kB1wKUyCymIr6e+AgnBlt7RTh5Y3b89sj6oVjamFffK8t2zCy3oaEGHcGjh8oRnXdUivEZOAnIuDGexOHtgfYYQ0pbPuetceNhpM+LyGZLyowkHL/vzgP+d1tUUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770876; c=relaxed/simple;
	bh=X+JBbfpiCvYZ08j2A5xHMLkTrGHXmBApvPy/csOdlQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WeehE0+VtKdGYEQNL3uzc74M/EgR5uzUeI8rYTIm4aAm2ODCGHVVB/sNtab8NjprSrfRCvZedu0nM/dmPvJj4TDyLYHcn8EDpEX61NNeFwWEp1Yp5a3h6yh5TeXX955OQk7pdYtW3GWtZceMEP6NDZOZGOtypsjWwP4ZPM4rkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NxQ7z5rC; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78f75b0a058so3598576d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761770872; x=1762375672; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNweOULSqP1KmTVakEOlU0DhlWAA5N/VmAPu4C5GuRI=;
        b=NxQ7z5rCwDhHBreYTmF3DLBYMe8MEn919FP6P8OsNmDanHxPxTqPYd6EAJTf0kj+Bp
         9mIW5zTwAYDe9rOWarU2//0izLdQG60BTiESBxlZMZUJjijqlEFy6GdS5R//pTroqbIU
         Fn6GB51JW9cM2VDSwunCPi3drzEAOlK4csfJolPP8znZj+KAJ4j5UnehDBNQpQJdB/+i
         tr5YrVXT/tZZLZJdr+pXb/UVN28JoUmvfZu7g4FWU3KgMd5MddpR74VYugRR+wI8O3RR
         sCxFmAjdxchzwMimYr4PqU2pv71/JPSPBQWJPhok8XnEE77kOCDpWXpMzl0CWL4EsGoL
         PAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770872; x=1762375672;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNweOULSqP1KmTVakEOlU0DhlWAA5N/VmAPu4C5GuRI=;
        b=BsfouYttkm/9/M6FZevHoZQ3DZXuRcBMeZa9sLoUhos7ZwiNi1AUkkOggJ4ICABW8w
         vjIYMKs+ZUmZR9wMwDJJ2b+kuwsm+S357GAdbdxKxiEF0PiVEepjqVKsSdCe7dJxGZp7
         ENtoI6/sXUJh7PjLuvIGqapYTzhJnNbVIJO0U+ftgL31yrCBYIUQfeGdo3QBlr+hM0dE
         wPU7sI9ehQ8EiuHbubYS19TaSj+Ubs3UaF2+xJT7qpAsEnv/buuIR0oto93vFnxMMShO
         4OPXdQSOgDy4H/E90GsquHIwyKT9WcmheDQa8PchHhp3llZEqjUUBU5h5MqoG2JjTP+X
         VZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7LjHWrHK1qRZmkvxW+g6AG4c8FbchS0hsqbsa7aIwPst+qy6sit1GX5FcVy5rNkntfC/YmG/TJlrTg6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFfj+YiCdqW7QM1xUUXhnHYM5Y1GsbIpBTK+CL0ut1guWuSgL
	1GIUVMz4EAACXL9Je81ffa1wA8fWO5O/+n0feHkEZGdH1L2Xt4CNLrw6Lf6l1p8MeLo=
X-Gm-Gg: ASbGncstvrfY8iOpFVZvaAnksg6N9fyFz0E8BuevLeR3SLoc5TEM8cIrgvCr8quy0dq
	b8c3o1tBBy1ujQQaNpBODbK09Jkqa/ozK0aeeaezX7+HGATeSiQJTKVh/TTunsPv1d73L6ZEYMV
	IJAm7o1OJYF9M1R1ojFgZ8pQjpAGKPhMQ+4YQECdeuxaLpkr7CL8PO2bTIH4Btkhauvuv1NRPZw
	Ue6klEYjN2WXKBN6a06o8BxL+1I/LgldV7ZRpQUMkcIp+ykjSFW/DvzW7/ApqjLI+MCk3eJiXmv
	UCaKZBWCU0zyku8rBBDL2oU4gqw77gNujbkZxAMoeQsii230r8ZtHgSttvkR0XgaS41h6st5V/l
	poQjnDo+n9js7Dww9zjc5KHPN5lZLA+acgeYPylC8BS6agvRbZkm55EZFZdx9NDw4tidqE2Q28q
	dVyeFw2oEE0Lt6O8sj29HzLjhNvPvivg==
X-Google-Smtp-Source: AGHT+IGj0qEQa0W1SC+hL9VDI5j8zUo1EBKgLGdOShjcNYowjyO1G7tAolxE+mlp9+BRdp73OEbnKA==
X-Received: by 2002:a05:6214:2122:b0:87d:f2ea:6758 with SMTP id 6a1803df08f44-8801b1e996fmr15077326d6.44.1761770871772;
        Wed, 29 Oct 2025 13:47:51 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8a10sm108655586d6.10.2025.10.29.13.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:47:51 -0700 (PDT)
Date: Wed, 29 Oct 2025 16:47:49 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, 
    Yu Kuai <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, 
    Jens Axboe <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 8/9] lib: mul_u64_u64_div_u64() Optimise the
 divide code
In-Reply-To: <20251029173828.3682-9-david.laight.linux@gmail.com>
Message-ID: <5n9676sp-qro5-8907-o0pn-nqn82n0141r6@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-9-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> Replace the bit by bit algorithm with one that generates 16 bits
> per iteration on 32bit architectures and 32 bits on 64bit ones.
> 
> On my zen 5 this reduces the time for the tests (using the generic
> code) from ~3350ns to ~1000ns.
> 
> Running the 32bit algorithm on 64bit x86 takes ~1500ns.
> It'll be slightly slower on a real 32bit system, mostly due
> to register pressure.
> 
> The savings for 32bit x86 are much higher (tested in userspace).
> The worst case (lots of bits in the quotient) drops from ~900 clocks
> to ~130 (pretty much independant of the arguments).
> Other 32bit architectures may see better savings.
> 
> It is possibly to optimise for divisors that span less than
> __LONG_WIDTH__/2 bits. However I suspect they don't happen that often
> and it doesn't remove any slow cpu divide instructions which dominate
> the result.
> 
> Typical improvements for 64bit random divides:
>                old     new
> sandy bridge:  470     150
> haswell:       400     144
> piledriver:    960     467   I think rdpmc is very slow.
> zen5:          244      80
> (Timing is 'rdpmc; mul_div(); rdpmc' with the multiply depending on the
> first rdpmc and the second rdpmc depending on the quotient.)
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
> 
> Algorithm unchanged from v3.
> 
>  lib/math/div64.c | 124 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 39 deletions(-)
> 
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index f6da7b5fb69e..4e4e962261c3 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -190,7 +190,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
>  #define mul_add(a, b, c) add_u64_u32(mul_u32_u32(a, b), c)
>  
>  #if defined(__SIZEOF_INT128__) && !defined(test_mul_u64_add_u64_div_u64)
> -
>  static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
>  {
>  	/* native 64x64=128 bits multiplication */
> @@ -199,9 +198,7 @@ static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
>  	*p_lo = prod;
>  	return prod >> 64;
>  }
> -
>  #else
> -
>  static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
>  {
>  	/* perform a 64x64=128 bits multiplication in 32bit chunks */
> @@ -216,12 +213,37 @@ static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
>  	*p_lo = (y << 32) + (u32)x;
>  	return add_u64_u32(z, y >> 32);
>  }
> +#endif
> +
> +#ifndef BITS_PER_ITER
> +#define BITS_PER_ITER (__LONG_WIDTH__ >= 64 ? 32 : 16)
> +#endif
> +
> +#if BITS_PER_ITER == 32
> +#define mul_u64_long_add_u64(p_lo, a, b, c) mul_u64_u64_add_u64(p_lo, a, b, c)
> +#define add_u64_long(a, b) ((a) + (b))
> +#else
> +#undef BITS_PER_ITER
> +#define BITS_PER_ITER 16
> +static inline u32 mul_u64_long_add_u64(u64 *p_lo, u64 a, u32 b, u64 c)
> +{
> +	u64 n_lo = mul_add(a, b, c);
> +	u64 n_med = mul_add(a >> 32, b, c >> 32);
> +
> +	n_med = add_u64_u32(n_med, n_lo >> 32);
> +	*p_lo = n_med << 32 | (u32)n_lo;
> +	return n_med >> 32;
> +}
>  
> +#define add_u64_long(a, b) add_u64_u32(a, b)
>  #endif
>  
>  u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
>  {
> -	u64 n_lo, n_hi;
> +	unsigned long d_msig, q_digit;
> +	unsigned int reps, d_z_hi;
> +	u64 quotient, n_lo, n_hi;
> +	u32 overflow;
>  
>  	n_hi = mul_u64_u64_add_u64(&n_lo, a, b, c);
>  
> @@ -240,46 +262,70 @@ u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
>  	if (!n_hi)
>  		return div64_u64(n_lo, d);
>  
> -	int shift = __builtin_ctzll(d);
> -
> -	/* try reducing the fraction in case the dividend becomes <= 64 bits */
> -	if ((n_hi >> shift) == 0) {
> -		u64 n = shift ? (n_lo >> shift) | (n_hi << (64 - shift)) : n_lo;
> -
> -		return div64_u64(n, d >> shift);
> -		/*
> -		 * The remainder value if needed would be:
> -		 *   res = div64_u64_rem(n, d >> shift, &rem);
> -		 *   rem = (rem << shift) + (n_lo - (n << shift));
> -		 */
> +	/* Left align the divisor, shifting the dividend to match */
> +	d_z_hi = __builtin_clzll(d);
> +	if (d_z_hi) {
> +		d <<= d_z_hi;
> +		n_hi = n_hi << d_z_hi | n_lo >> (64 - d_z_hi);
> +		n_lo <<= d_z_hi;
>  	}
>  
> -	/* Do the full 128 by 64 bits division */
> -
> -	shift = __builtin_clzll(d);
> -	d <<= shift;
> -
> -	int p = 64 + shift;
> -	u64 res = 0;
> -	bool carry;
> +	reps = 64 / BITS_PER_ITER;
> +	/* Optimise loop count for small dividends */
> +	if (!(u32)(n_hi >> 32)) {
> +		reps -= 32 / BITS_PER_ITER;
> +		n_hi = n_hi << 32 | n_lo >> 32;
> +		n_lo <<= 32;
> +	}
> +#if BITS_PER_ITER == 16
> +	if (!(u32)(n_hi >> 48)) {
> +		reps--;
> +		n_hi = add_u64_u32(n_hi << 16, n_lo >> 48);
> +		n_lo <<= 16;
> +	}
> +#endif
>  
> -	do {
> -		carry = n_hi >> 63;
> -		shift = carry ? 1 : __builtin_clzll(n_hi);
> -		if (p < shift)
> -			break;
> -		p -= shift;
> -		n_hi <<= shift;
> -		n_hi |= n_lo >> (64 - shift);
> -		n_lo <<= shift;
> -		if (carry || (n_hi >= d)) {
> -			n_hi -= d;
> -			res |= 1ULL << p;
> +	/* Invert the dividend so we can use add instead of subtract. */
> +	n_lo = ~n_lo;
> +	n_hi = ~n_hi;
> +
> +	/*
> +	 * Get the most significant BITS_PER_ITER bits of the divisor.
> +	 * This is used to get a low 'guestimate' of the quotient digit.
> +	 */
> +	d_msig = (d >> (64 - BITS_PER_ITER)) + 1;
> +
> +	/*
> +	 * Now do a 'long division' with BITS_PER_ITER bit 'digits'.
> +	 * The 'guess' quotient digit can be low and BITS_PER_ITER+1 bits.
> +	 * The worst case is dividing ~0 by 0x8000 which requires two subtracts.
> +	 */
> +	quotient = 0;
> +	while (reps--) {
> +		q_digit = (unsigned long)(~n_hi >> (64 - 2 * BITS_PER_ITER)) / d_msig;
> +		/* Shift 'n' left to align with the product q_digit * d */
> +		overflow = n_hi >> (64 - BITS_PER_ITER);
> +		n_hi = add_u64_u32(n_hi << BITS_PER_ITER, n_lo >> (64 - BITS_PER_ITER));
> +		n_lo <<= BITS_PER_ITER;
> +		/* Add product to negated divisor */
> +		overflow += mul_u64_long_add_u64(&n_hi, d, q_digit, n_hi);
> +		/* Adjust for the q_digit 'guestimate' being low */
> +		while (overflow < 0xffffffff >> (32 - BITS_PER_ITER)) {
> +			q_digit++;
> +			n_hi += d;
> +			overflow += n_hi < d;
>  		}
> -	} while (n_hi);
> -	/* The remainder value if needed would be n_hi << p */
> +		quotient = add_u64_long(quotient << BITS_PER_ITER, q_digit);
> +	}
>  
> -	return res;
> +	/*
> +	 * The above only ensures the remainder doesn't overflow,
> +	 * it can still be possible to add (aka subtract) another copy
> +	 * of the divisor.
> +	 */
> +	if ((n_hi + d) > n_hi)
> +		quotient++;
> +	return quotient;
>  }
>  #if !defined(test_mul_u64_add_u64_div_u64)
>  EXPORT_SYMBOL(mul_u64_add_u64_div_u64);
> -- 
> 2.39.5
> 
> 

