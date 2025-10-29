Return-Path: <linux-kernel+bounces-876962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A37C1CDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851B44064F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F712F12CC;
	Wed, 29 Oct 2025 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="BI76c9ck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0NNwfju"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB12773CB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764486; cv=none; b=mpLkemciNXf7s14fX68+YkutlRYyUx5pW8W0cv4Ipxu/MJ010+gne89xdataya5gU6voP5zS+7mSFJGtQmjEdHj7lFd60oGjp3Iuajx6pDwpIdMSTW06mNQ2CAvr/2wdcpEWRpX+HGB22X2UUMoW3jIZN8fbwT99dUsF0CeP9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764486; c=relaxed/simple;
	bh=6RVaaDYLV8Xqm/aUiQEembBKj8/wT7Kkzmf8Wb5G410=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PakGHW3ksEdIz99yfWpAs4M8RbgvyIChuAq4YYcbaggdP1+GGl2Mj9tiaFlTYpp3hJmuIeNdiJPRjjVel2nQM6c5WGjEG++zZMsm1xuv70tQamdMlVzEKDbIUva2KfRtbNTvUsp0mi4N+c26e6zXjOwjN6UN8+tukLWfdigyRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=BI76c9ck; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0NNwfju; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 510317A00A4;
	Wed, 29 Oct 2025 15:01:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 15:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761764483; x=1761850883; bh=q2OBwSfOLH
	7FZF6AMuMNLtPUlxRtKZ8gLw3EkIWFXps=; b=BI76c9ckDsGXDHtC4NhY/i+cWY
	RwlTbZwoBVQrGSLAoQ16HkMsFKE6ik9DkMOQqIpMsohMAYYZODfRl0OFbnou2siB
	j0aIicNtRfCmHqpT4YHUfaI35d/8vOkpOos8UM/USeposuAKv9lEIaCZ1zVhK/MN
	nD0s5uzbWNxpIrkVKJMlTIj5b8dtE3HBY6bQrJasOY7UxiH8u909YLxhXqGnW8gf
	FU95St3zEKeQkw/RW9ip7dgbokYMLg5oggW9kF/rPQf/HYzOD7t1nxTEXz+tKR5o
	SBlMA72oRK8VxzHjCjxH1nWrKYAKb+tJwjfBZOGiZxnFEaSsveScCHe2KarQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761764483; x=1761850883; bh=q2OBwSfOLH7FZF6AMuMNLtPUlxRtKZ8gLw3
	EkIWFXps=; b=H0NNwfjuVVMmC7RCBmVhIopBUI1xfaftwIlB+BmxZ15JtnQoAW0
	fITdLYO+9mvvuuIRVrcLeyQIJ5a8kZVEZvXrBUFY3/zwZxoInhCNJz1FldpVe+L2
	glyv11thTQb2WHY7DQ4b7TZDLcDhJpIE3IH7tCxpYJ2NLHdELfH8y/7jAr58k6jD
	nm71b3imzyGCWDPC1H+vhdMyN1nbwY3F/jdZlyvRSxymnYTF5xyqbt00mBzhFxo7
	JHR1sy2OBKdbi3p7z6MG5sz9VMj2iZmHh4+HlYcbXmvODzgD7rlblK7W8/4DejsM
	MzLK/xru8Y76ZvPQLRdDhSEKqea/B+uXEgQ==
X-ME-Sender: <xms:gWQCaSdbSxCdmsYlDzllWEO0oCHHbDX3hSEEUirRCrkq7Ji5Ui6Dnw>
    <xme:gWQCaW7fm1yAnpCDXiShLhNXI32MIiGIejNMx4Lk_bIX85VAwbMoS8wAInq_qDGZL
    06LF1Uycby69sxYNe1Shw_N0uOQdw-SJh2M-1-hdDKyhszL9S06Fas>
X-ME-Received: <xmr:gWQCacO_BIQiEfCcDLS9v-HStL6iJJ4bSApQUFFeDgw7Np4KSG-zxjYwaO5a96kR1mDGwboeJAjeWiq0T7wDFrC3WbkgLzyezTdauCDi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpefgvedvhfefueejgefggfefhfelffeiieduvdehffduheduffekkefhgeffhfefveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtoh
    esfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehlihhroh
    hnghhqihhnghessggrihguuhdrtghomhdprhgtphhtthhopehurdhklhgvihhnvgdqkhho
    vghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegsihhjuhdruggrshdrjh
    iisegsphdrrhgvnhgvshgrshdrtghomhdprhgtphhtthhopehkhhgriihhhiestghhrhho
    mhhiuhhmrdhorhhgpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohephihukhhurghifeeshhhurgifvghirdgtohhm
    pdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eprgigsghovgeskhgvrhhnvghlrdgukh
X-ME-Proxy: <xmx:gWQCaXF6CBYVAX745E7tcqS45F1XOUrOhgNxw_QPMTz9-9V67Negaw>
    <xmx:gWQCaQRnDie7oBc8ReKqW_qI1mEVq6UxCZgI4nRTUdZCm3jdi0ZLtA>
    <xmx:gWQCafQQQcQO0bGmjR9_dTCief0NeekyJqBBVjBkNXklg85SDBYFrg>
    <xmx:gWQCabdIhWBnwz5JN2tJIDli00cGF4_9XNeVJ4FdEJ3AsedsgIEFig>
    <xmx:g2QCaZLprdr9tvpb-sSefcqQFG_1TtJ7N6YQOPnTCcn_18CBWTJdRDqO>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 15:01:21 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C263013E377B;
	Wed, 29 Oct 2025 15:01:20 -0400 (EDT)
Date: Wed, 29 Oct 2025 15:01:20 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
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
Subject: Re: [PATCH v4 next 7/9] lib: mul_u64_u64_div_u64() optimise multiply
 on 32bit x86
In-Reply-To: <20251029173828.3682-8-david.laight.linux@gmail.com>
Message-ID: <2r385158-3144-32rp-38ro-r1opo37qsq1r@syhkavp.arg>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-8-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> gcc generates horrid code for both ((u64)u32_a * u32_b) and (u64_a + u32_b).
> As well as the extra instructions it can generate a lot of spills to stack
> (including spills of constant zeros and even multiplies by constant zero).
> 
> mul_u32_u32() already exists to optimise the multiply.
> Add a similar add_u64_32() for the addition.
> Disable both for clang - it generates better code without them.
> 
> Move the 64x64 => 128 multiply into a static inline helper function
> for code clarity.
> No need for the a/b_hi/lo variables, the implicit casts on the function
> calls do the work for us.
> Should have minimal effect on the generated code.
> 
> Use mul_u32_u32() and add_u64_u32() in the 64x64 => 128 multiply
> in mul_u64_add_u64_div_u64().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
> 
> Changes for v4:
> - merge in patch 8.
> - Add comments about gcc being 'broken' for mixed 32/64 bit maths.
>   clang doesn't have the same issues.
> - use a #defdine for define mul_add() to avoid 'defined but not used'
>   errors.
> 
>  arch/x86/include/asm/div64.h | 19 +++++++++++++++++
>  include/linux/math64.h       | 11 ++++++++++
>  lib/math/div64.c             | 40 +++++++++++++++++++++++-------------
>  3 files changed, 56 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
> index cabdc2d5a68f..a18c045aa8a1 100644
> --- a/arch/x86/include/asm/div64.h
> +++ b/arch/x86/include/asm/div64.h
> @@ -60,6 +60,12 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
>  }
>  #define div_u64_rem	div_u64_rem
>  
> +/*
> + * gcc tends to zero extend 32bit values and do full 64bit maths.
> + * Define asm functions that avoid this.
> + * (clang generates better code for the C versions.)
> + */
> +#ifndef __clang__
>  static inline u64 mul_u32_u32(u32 a, u32 b)
>  {
>  	u32 high, low;
> @@ -71,6 +77,19 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>  }
>  #define mul_u32_u32 mul_u32_u32
>  
> +static inline u64 add_u64_u32(u64 a, u32 b)
> +{
> +	u32 high = a >> 32, low = a;
> +
> +	asm ("addl %[b], %[low]; adcl $0, %[high]"
> +		: [low] "+r" (low), [high] "+r" (high)
> +		: [b] "rm" (b) );
> +
> +	return low | (u64)high << 32;
> +}
> +#define add_u64_u32 add_u64_u32
> +#endif
> +
>  /*
>   * __div64_32() is never called on x86, so prevent the
>   * generic definition from getting built.
> diff --git a/include/linux/math64.h b/include/linux/math64.h
> index e889d850b7f1..cc305206d89f 100644
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -158,6 +158,17 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>  }
>  #endif
>  
> +#ifndef add_u64_u32
> +/*
> + * Many a GCC version also messes this up.
> + * Zero extending b and then spilling everything to stack.
> + */
> +static inline u64 add_u64_u32(u64 a, u32 b)
> +{
> +	return a + b;
> +}
> +#endif
> +
>  #if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
>  
>  #ifndef mul_u64_u32_shr
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index f92e7160feb6..f6da7b5fb69e 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -186,33 +186,45 @@ EXPORT_SYMBOL(iter_div_u64_rem);
>  #endif
>  
>  #if !defined(mul_u64_add_u64_div_u64) || defined(test_mul_u64_add_u64_div_u64)
> -u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
> -{
> +
> +#define mul_add(a, b, c) add_u64_u32(mul_u32_u32(a, b), c)
> +
>  #if defined(__SIZEOF_INT128__) && !defined(test_mul_u64_add_u64_div_u64)
>  
> +static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
> +{
>  	/* native 64x64=128 bits multiplication */
>  	u128 prod = (u128)a * b + c;
> -	u64 n_lo = prod, n_hi = prod >> 64;
> +
> +	*p_lo = prod;
> +	return prod >> 64;
> +}
>  
>  #else
>  
> -	/* perform a 64x64=128 bits multiplication manually */
> -	u32 a_lo = a, a_hi = a >> 32, b_lo = b, b_hi = b >> 32;
> +static inline u64 mul_u64_u64_add_u64(u64 *p_lo, u64 a, u64 b, u64 c)
> +{
> +	/* perform a 64x64=128 bits multiplication in 32bit chunks */
>  	u64 x, y, z;
>  
>  	/* Since (x-1)(x-1) + 2(x-1) == x.x - 1 two u32 can be added to a u64 */
> -	x = (u64)a_lo * b_lo + (u32)c;
> -	y = (u64)a_lo * b_hi + (u32)(c >> 32);
> -	y += (u32)(x >> 32);
> -	z = (u64)a_hi * b_hi + (u32)(y >> 32);
> -	y = (u64)a_hi * b_lo + (u32)y;
> -	z += (u32)(y >> 32);
> -	x = (y << 32) + (u32)x;
> -
> -	u64 n_lo = x, n_hi = z;
> +	x = mul_add(a, b, c);
> +	y = mul_add(a, b >> 32, c >> 32);
> +	y = add_u64_u32(y, x >> 32);
> +	z = mul_add(a >> 32, b >> 32, y >> 32);
> +	y = mul_add(a >> 32, b, y);
> +	*p_lo = (y << 32) + (u32)x;
> +	return add_u64_u32(z, y >> 32);
> +}
>  
>  #endif
>  
> +u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
> +{
> +	u64 n_lo, n_hi;
> +
> +	n_hi = mul_u64_u64_add_u64(&n_lo, a, b, c);
> +
>  	if (unlikely(n_hi >= d)) {
>  		/* trigger runtime exception if divisor is zero */
>  		if (d == 0) {
> -- 
> 2.39.5
> 
> 

