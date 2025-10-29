Return-Path: <linux-kernel+bounces-876913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E1EC1CBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21919188EBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97333F361;
	Wed, 29 Oct 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0YOxZiZE"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BD2F90F0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761871; cv=none; b=OT/EglpPqhv2bdQ5lbnh5tCBGBLFtHT0TMt4zKd+Z7EVQOAjGUizKGz9TenVtv2GKaT946CmcASMRjKdAzEngbiZItIiMXVH7vTmNWro63br72X87JtcceAItdb/P+Mt2hldEfMQFRq/ZVUXdlBDiLEWCV+5F/8GP3G4FRKbIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761871; c=relaxed/simple;
	bh=Ndg9d0oKkSFgdvQMGvjrvdyHRAlA5FSaaumNxXj8HOg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zvp6RsNCf5Tap/xjztK0cYfB5Pbch+ChLZgx52nJPskBYeHchoq82C7w9lpFz8y3K7M6mQw+mt6sKbA3Ll5hjmnBIOOiR7hjNGGgo/TTYiub0wA4JckV7ebJPFuOR3/jMwqgO5Exf7e2nbDgous+7pYM0/gJOqjXNYyA5SfACso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0YOxZiZE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-893c373500cso22352985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761761868; x=1762366668; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8t71JUrOcZIaMdBQxtkmzGKl/EzuPds3aBqzKQJUf5E=;
        b=0YOxZiZEaTossHTUFgYKc7hrldb/4MZL4QLl8f/sdhtM93r92GqlxuVHVFbula+0nC
         v8TLtX5VNAgLjHQfRzQDKabSSPuCnkLWN4UpFLlM4/HXDZ0kQqmlgUnVYsQOdGiqDpyS
         KbTEO7C6BVO/HuRveEBY7RkDSYmC/ABCsOGHSDrAcXGU9DIUqrDnV/lxn7feffZ4a4aa
         LgECqACkDMmwQTpuDFIkNviludc9OtOsrpGJmg8F1RAdWhcAkybOstKzGcAlHojCwFJV
         XvXesWN9/EPniIIhW9BVR519RmLi6M4EnrWczgDZM0/iexD3Yaz76/KMuWxiXxVkRLvk
         9hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761868; x=1762366668;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8t71JUrOcZIaMdBQxtkmzGKl/EzuPds3aBqzKQJUf5E=;
        b=Vzd61gvZa2Hh3LWK0LltI066ync+EehN10fen8cNV+vMhiTRANF66Ee3/fLiS7wqN6
         wp1BxPFHC1TjX288Z2pYtJG9lMKVBn4C3oCiGXfJSaJ1BBeUsVOey9P0r+kDNdDeO4W/
         ORbJf6Fbv5reJEVAacVliG0vVeOQ7qyj5Le4qhVD/ZXzlZJ5GN2nkKDNgcFxAxMtnyNK
         dcIYzHRAYHo7PozCtr9ZjP0iBPw9C7+oNAcQ2hM+MJU4rjidIC/vP8tV5Jstobq8Eqjr
         0/5mKbNJe8ckJEo0rA8VewMa0i3EQ4Tzz9azlXoK9Ug+L6GMYJuzwzdOi+MbZ4P1ue/c
         LYNg==
X-Forwarded-Encrypted: i=1; AJvYcCWmUTaZLaCFthuMN/R1eD+4YCkh2HP9TUJuC07sJ8bPpM/EOT/sWdxS6g9JuAIeKknjyILQuuLszAEgiGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4QcDQCL61LK/lGOJF3RBLVCFtdaACKX98yglwbRJeCND+WoN
	B4qnfYph0+dG6W7q4fnL1wEmlTF6u9SCAq3G8u/k6dQp/uUw5AeJxkHEKodDRDrM/tA=
X-Gm-Gg: ASbGncv0wa37POLBgJvJBqfxy1gLfIhyWQ+YYlnH6UNvez0yC/diS9PoEKewiaLfHIK
	MGG6zmE+jYp87LdybT5Budxj6w+7lkd9qZTEio1aS1vSAcswXQ6YfLk7AAhQQNZcXPIp0MdEFtH
	s+b/iajZdSexQUUvjbilL+c50EnFgDPoaTPWf+pk49D0js7Zwk4k64IzmdRY/hk7xPmOqqloJAZ
	SoSoVvsA/XkpcxzYJcZy6ZNOYZdR/wtDwKLntBBYbtY5lZKbShSbbf5sBBBeC/FHymuuvffJA1/
	0eE9cR5s9FIGj6JCA/sesmVxLpAMTDy9r6rdqzwFpyVlCZVa0bXatecqgU+y6zyN3TTv0w+Dfl6
	P5PGoS8UL03fR6pryEkxdJNxZfN/Ky6ZQkgFTsFwW+OIswNkKqpY664FyPUh3eZ6KfZezvK//Un
	dzr2mUoY6ESxGOtR9lAiXDXRwQTfBbjw==
X-Google-Smtp-Source: AGHT+IGsKApRMXbtpSbik0j8aCCOmtn0qUVkDynogS1Sux0c0crZY/kuP7sKAf4rDZCZSY1Zmx3QEw==
X-Received: by 2002:a05:620a:29c6:b0:857:7b07:3af0 with SMTP id af79cd13be357-8aa2b111350mr83967985a.24.1761761867723;
        Wed, 29 Oct 2025 11:17:47 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f261747efsm1077467385a.55.2025.10.29.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:17:47 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:17:45 -0400 (EDT)
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
Subject: Re: [PATCH v4 next 4/9] lib: Add mul_u64_add_u64_div_u64() and
 mul_u64_u64_div_u64_roundup()
In-Reply-To: <20251029173828.3682-5-david.laight.linux@gmail.com>
Message-ID: <q72q16nr-q934-s4ss-s5n1-6581769pq65r@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-5-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> The existing mul_u64_u64_div_u64() rounds down, a 'rounding up'
> variant needs 'divisor - 1' adding in between the multiply and
> divide so cannot easily be done by a caller.
> 
> Add mul_u64_add_u64_div_u64(a, b, c, d) that calculates (a * b + c)/d
> and implement the 'round down' and 'round up' using it.
> 
> Update the x86-64 asm to optimise for 'c' being a constant zero.
> 
> Add kerndoc definitions for all three functions.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
> 
> Changes for v2 (formally patch 1/3):
> - Reinstate the early call to div64_u64() on 32bit when 'c' is zero.
>   Although I'm not convinced the path is common enough to be worth
>   the two ilog2() calls.
> 
> Changes for v3 (formally patch 3/4):
> - The early call to div64_u64() has been removed by patch 3.
>   Pretty much guaranteed to be a pessimisation.
> 
> Changes for v4:
> - For x86-64 split the multiply, add and divide into three asm blocks.
>   (gcc makes a pigs breakfast of (u128)a * b + c)
> - Change the kerndoc since divide by zero will (probably) fault.
> 
>  arch/x86/include/asm/div64.h | 20 +++++++++------
>  include/linux/math64.h       | 48 +++++++++++++++++++++++++++++++++++-
>  lib/math/div64.c             | 14 ++++++-----
>  3 files changed, 67 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
> index 9931e4c7d73f..cabdc2d5a68f 100644
> --- a/arch/x86/include/asm/div64.h
> +++ b/arch/x86/include/asm/div64.h
> @@ -84,21 +84,25 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>   * Will generate an #DE when the result doesn't fit u64, could fix with an
>   * __ex_table[] entry when it becomes an issue.
>   */
> -static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> +static inline u64 mul_u64_add_u64_div_u64(u64 rax, u64 mul, u64 add, u64 div)
>  {
> -	u64 q;
> +	u64 rdx;
>  
> -	asm ("mulq %2; divq %3" : "=a" (q)
> -				: "a" (a), "rm" (mul), "rm" (div)
> -				: "rdx");
> +	asm ("mulq %[mul]" : "+a" (rax), "=d" (rdx) : [mul] "rm" (mul));
>  
> -	return q;
> +	if (statically_true(add))
> +		asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
> +			[lo] "+r" (rax), [hi] "+r" (rdx) : [add] "irm" (add));
> +
> +	asm ("divq %[div]" : "+a" (rax), "+d" (rdx) : [div] "rm" (div));
> +
> +	return rax;
>  }
> -#define mul_u64_u64_div_u64 mul_u64_u64_div_u64
> +#define mul_u64_add_u64_div_u64 mul_u64_add_u64_div_u64
>  
>  static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
>  {
> -	return mul_u64_u64_div_u64(a, mul, div);
> +	return mul_u64_add_u64_div_u64(a, mul, 0, div);
>  }
>  #define mul_u64_u32_div	mul_u64_u32_div
>  
> diff --git a/include/linux/math64.h b/include/linux/math64.h
> index 6aaccc1626ab..e889d850b7f1 100644
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -282,7 +282,53 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
>  }
>  #endif /* mul_u64_u32_div */
>  
> -u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
> +/**
> + * mul_u64_add_u64_div_u64 - unsigned 64bit multiply, add, and divide
> + * @a: first unsigned 64bit multiplicand
> + * @b: second unsigned 64bit multiplicand
> + * @c: unsigned 64bit addend
> + * @d: unsigned 64bit divisor
> + *
> + * Multiply two 64bit values together to generate a 128bit product
> + * add a third value and then divide by a fourth.
> + * The Generic code divides by 0 if @d is zero and returns ~0 on overflow.
> + * Architecture specific code may trap on zero or overflow.
> + *
> + * Return: (@a * @b + @c) / @d
> + */
> +u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d);
> +
> +/**
> + * mul_u64_u64_div_u64 - unsigned 64bit multiply and divide
> + * @a: first unsigned 64bit multiplicand
> + * @b: second unsigned 64bit multiplicand
> + * @d: unsigned 64bit divisor
> + *
> + * Multiply two 64bit values together to generate a 128bit product
> + * and then divide by a third value.
> + * The Generic code divides by 0 if @d is zero and returns ~0 on overflow.
> + * Architecture specific code may trap on zero or overflow.
> + *
> + * Return: @a * @b / @d
> + */
> +#define mul_u64_u64_div_u64(a, b, d) mul_u64_add_u64_div_u64(a, b, 0, d)
> +
> +/**
> + * mul_u64_u64_div_u64_roundup - unsigned 64bit multiply and divide rounded up
> + * @a: first unsigned 64bit multiplicand
> + * @b: second unsigned 64bit multiplicand
> + * @d: unsigned 64bit divisor
> + *
> + * Multiply two 64bit values together to generate a 128bit product
> + * and then divide and round up.
> + * The Generic code divides by 0 if @d is zero and returns ~0 on overflow.
> + * Architecture specific code may trap on zero or overflow.
> + *
> + * Return: (@a * @b + @d - 1) / @d
> + */
> +#define mul_u64_u64_div_u64_roundup(a, b, d) \
> +	({ u64 _tmp = (d); mul_u64_add_u64_div_u64(a, b, _tmp - 1, _tmp); })
> +
>  
>  /**
>   * DIV64_U64_ROUND_UP - unsigned 64bit divide with 64bit divisor rounded up
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 7158d141b6e9..25295daebde9 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -183,13 +183,13 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
>  }
>  EXPORT_SYMBOL(iter_div_u64_rem);
>  
> -#ifndef mul_u64_u64_div_u64
> -u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> +#ifndef mul_u64_add_u64_div_u64
> +u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
>  {
>  #if defined(__SIZEOF_INT128__)
>  
>  	/* native 64x64=128 bits multiplication */
> -	u128 prod = (u128)a * b;
> +	u128 prod = (u128)a * b + c;
>  	u64 n_lo = prod, n_hi = prod >> 64;
>  
>  #else
> @@ -198,8 +198,10 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  	u32 a_lo = a, a_hi = a >> 32, b_lo = b, b_hi = b >> 32;
>  	u64 x, y, z;
>  
> -	x = (u64)a_lo * b_lo;
> -	y = (u64)a_lo * b_hi + (u32)(x >> 32);
> +	/* Since (x-1)(x-1) + 2(x-1) == x.x - 1 two u32 can be added to a u64 */
> +	x = (u64)a_lo * b_lo + (u32)c;
> +	y = (u64)a_lo * b_hi + (u32)(c >> 32);
> +	y += (u32)(x >> 32);
>  	z = (u64)a_hi * b_hi + (u32)(y >> 32);
>  	y = (u64)a_hi * b_lo + (u32)y;
>  	z += (u32)(y >> 32);
> @@ -265,5 +267,5 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  
>  	return res;
>  }
> -EXPORT_SYMBOL(mul_u64_u64_div_u64);
> +EXPORT_SYMBOL(mul_u64_add_u64_div_u64);
>  #endif
> -- 
> 2.39.5
> 
> 

