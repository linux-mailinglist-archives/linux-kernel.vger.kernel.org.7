Return-Path: <linux-kernel+bounces-880946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3BC26F75
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD5AD4E4BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1A329C59;
	Fri, 31 Oct 2025 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0rJ/LYD"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50A328B5E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944363; cv=none; b=JAaKTMCdzBJUnfxgmpVBUzp8U4Dfyxei3EXCjL9dtl+kFVoJuzNAr3eAVJJk8TMCfgGNgDXN2z+m7H8Y2AG0rquGCGguFxGn5SFYu9vJTb3mEEE3fWspfW/LeF3/P5iKgJUEZe925hBB6sxBhE8G1NF2kYD2PPLcUWpQeeBd0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944363; c=relaxed/simple;
	bh=aLqmljkpD2zl6j6GgB0sK1QrN36B8GI1GZAlwlHtooo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUeVZC0BNCge88KXiLgTd45FyxmCgUG/Ooy3TctnZHzQrgHL8XJ6K4qNtfg/n/TsK9YfxgR8Co11o35dx3ZKIsRc83IffPSD66YYLlyoMsQOEBAmLk7l8Ox45IUL9FtCkOn4snzzyMmP6/OmZ+VAgveJb50pQ85R4qLOQ0q5t14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0rJ/LYD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429be5d31c9so999542f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761944360; x=1762549160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgp3f7L8ordIG8lFk3MXWjOE/D+2lwOocuB1EdZHw3s=;
        b=R0rJ/LYD03nasPZ1/WWmdWoNDkgs7Wp5O5dN9iGTuvx1ag9NIz0qMExgcajAn2aafL
         sTHTwdXMbbOOdu7aLbVfa6UZ8c1TDuUwzArEiFVz2Q3Ru8e6n9TCCYEaKrl4S2JM+rbO
         YHaDzx8O3vCNDEWyBWxO4JPCoku5vnGAXOoktA/rfLzEplgZuGMCzkaoF8Jb54qNymtF
         z/ze92v+bFB/om2if8HYFZpNG9mwaltE2BJhqRVtRd29VL9I3xUUGck9Th2Tj/cZxwDR
         BTWmbpLfFRAuzT005B0wikBIf/wTIlTdL1zVOWHW/Oh1Bt7hI0SAcrVHcZwBSSbBzoUh
         mwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761944360; x=1762549160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgp3f7L8ordIG8lFk3MXWjOE/D+2lwOocuB1EdZHw3s=;
        b=FT3ZZstd3aKDwVZigYttL+iOnSuJcZhvVf4cG/EcpHwGrVGuLYA+tsWOnmi9y/zPGE
         C8Ts3C83fgj5pMfpshdjuh+wtthasYBhvfaCPDayKzC6QbW4NHu44Xb9Cy3Y05VefYFX
         ZnXZMOXyApMaz8nfpwvmzBPsP9/YdZ/UY5NgZchWZPw+lmGhVYYk3pIT7dwyRJL7ph5A
         /ZR7hxy5aEO+6D7IMhISDcVvyAfJTpylAJS0frJ9Q7HBJU2vWU83efQz5dW7UnVNlQGY
         wMRit1fplzLLz1Vgz35mEqnWGCzqx/NcZpwmgJ0uwcbETr0DwtCU4u1nq8mM8C7b5o/A
         JFwg==
X-Forwarded-Encrypted: i=1; AJvYcCVQMZdBKdPgf3aDZv75QXTQiDLtECkNByvXM69QaHDK2HajJPopJw9+fNlzhYxriffx281bRWplOhcHpRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50z3erbHMa/QufMkyvUdJYscwLJJZRHhD76aY5fnwUAv1KR1z
	omf7poHmJkASkCqMetCYu+4JSMrIQVw9g8BkAweabSYftK4jbqKpMa0o
X-Gm-Gg: ASbGnctLgwZ5leLAZ4I/hep5jwi708rWeWQ1dWbw6mmR7zigfd5P+vKbnvFJyvAxt+v
	oQUOg/NnuUly8IM6vLVUL+0r21AZghoQe7CSyPNRSCOADbOlbUn9vmhoz6SaI8FKJ6JnLNJJ5bT
	njJEtfLBA4xozOfGLW3HQs+kyfNFQnXCTvCEzCPjiCjZEkitsauHnEqZ7ev7ijLTypGCh4PiIxG
	FQs/gIM0ramdasRnJrWEMhvWercw6hH9mKmCH3B8u9HrTboEI3/YqqA/NxwZPb9auEYZ+pl14Hc
	szq74YlE3HkojrR+FOI+W2KhvmQojhwm4TmG+y9DpBdNfP4fQCcH0lKqFOe1x1sjAqHQRSw7umI
	mxLQcQTnIGp1aTI+k3uqg1jrGWXxLwSrhVp/88XUx51CmqQ6QT3MNxvQFS8MQYt60IT6dKxuPKF
	XhEbmICkkzvhb1NztjP8qwSyZcwThIrEbLGMeDv/GQcg==
X-Google-Smtp-Source: AGHT+IEpkOT+lds5i+MlFlnlvPse3C56GNXRHFvHhbzk78p7CP82ggJGlgmNbIHMcxNRtkEcmzgV3w==
X-Received: by 2002:a5d:59c5:0:b0:429:c66c:5bc9 with SMTP id ffacd0b85a97d-429c66c6504mr432614f8f.27.1761944359598;
        Fri, 31 Oct 2025 13:59:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1405fffsm5167638f8f.45.2025.10.31.13.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:59:19 -0700 (PDT)
Date: Fri, 31 Oct 2025 20:59:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: u.kleine-koenig@baylibre.com, Nicolas Pitre <npitre@baylibre.com>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Li
 RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>, Khazhismel
 Kumykov <khazhy@chromium.org>, Jens Axboe <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 4/9] lib: Add mul_u64_add_u64_div_u64() and
 mul_u64_u64_div_u64_roundup()
Message-ID: <20251031205917.56763269@pumpkin>
In-Reply-To: <20251029173828.3682-5-david.laight.linux@gmail.com>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
	<20251029173828.3682-5-david.laight.linux@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 17:38:23 +0000
David Laight <david.laight.linux@gmail.com> wrote:

There is a slight bug ...

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

This needs to be:
	if (!statically_true(!add))

Do you need me to resend the full series?

	David

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


