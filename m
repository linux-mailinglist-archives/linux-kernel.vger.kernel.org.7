Return-Path: <linux-kernel+bounces-876947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D51FBC1CD45
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F3434E1CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231B6357A20;
	Wed, 29 Oct 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Oy4ATxSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bjt04KRT"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55003546E0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764002; cv=none; b=e8gduC7imgCGduAoSTlmh6SvFPdu3kPYnvPTM6FQ4tn/iGznDYemy3w7fYswF+mQ9dglpaB7lXKM7u8XzSlED9bPjPaRz3F6BKv/HqK4OWDnmisXZf2IvgyY5LTsbta88xeQ/4V7GhdNDB23OZs4FJ8g7+JSxn/3RkljVWqrwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764002; c=relaxed/simple;
	bh=wRMznDOqGBi9hyKvz/BjSxU2ib+WPCwV3akiITfgc3E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OWKOCrJ+WGjPglfdOdgHVKNt5lkBUgdw26eZjEio7ycOCU9MYvf/lijwMeu7fnjoULEMcHSWh2OKAz9PKji441qkygIbFSy2V9uBnGI3ERv5Ai8DCL2e3ALGlL48DQ6QbaCRu9gr/EUJzr8MLlaitv4EjQk3m9adiNsb6lFiBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Oy4ATxSh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bjt04KRT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 930A07A0132;
	Wed, 29 Oct 2025 14:53:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 29 Oct 2025 14:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761763998; x=1761850398; bh=xhWzsyF84r
	OxsZy1PQhYuMBk7u+GLofG6sdJyhzqzqM=; b=Oy4ATxShA5onn6JSH+ruS2ULVh
	mruFg6/7SgWfJ6pTKC5CL13St844gyb166wxShY7xE2yNMDCr/9p+dvuCI1Mk0id
	dgG1JgrosoDQaiEstEH74ssxutdWTWYSpT5jWHBUv6+f1hhkENNKMcbd+axrHkfq
	7zXjypZzYykAJ0aeQB2hafRrRqa0sInc1clF9jxfacyPR65qCqvCTJYUeBB4re7I
	K4761qJL87XTvJvsVsZJ4cuw6H9cN3/OL3YGhSP6DBIORhLwmBpTcPYrKz26gVV7
	0T0ed8a7HX8MUCjHQ0I3192jLXb+TS9HsKynJvUIRQhdWqtbjNfPNdhzK0XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761763998; x=1761850398; bh=xhWzsyF84rOxsZy1PQhYuMBk7u+GLofG6sd
	JyhzqzqM=; b=Bjt04KRTyUWBzvRRv9PbmuHkKuBY4YluIAWx1WjL7lQbpeeNXZU
	g7eGtBHx52IAKBn/vDcZA1jIqqXnBcuca2colZ3xbSUbv0buahPAyVvVHBxTNQye
	R8O5X/ugYTKtKLyY9GSSId49Rm0MGvOF+98was40WLh8wSc5C8//oyegcQNEFT3T
	ei6IokT8JDSfGJAOHZmlrmoYCTft6faS78lMG0m6Kl5wsRzq3cVE6E3+r8C6/YJT
	DZoafZVTOwqlvFYQNOcfJCJIQWBDZXUH3NphPX8sRnAH7C6T+Xz8BX+2k6bfwIw6
	Po5HtfGLvJwZCvQfsUkiHhmaYuPIfiYOorQ==
X-ME-Sender: <xms:m2ICaYwBJUPaM4zWUbqVy8TtQD3ukxtQK1ctj0pJIN7xTPG49zTvDQ>
    <xme:m2ICadPubefICf7aZTTFd12_vGZwXTC-t112nMtiw5Sv5hW32y8gx09x425heLqkT
    HuPT_65sSPtuIe-HCiF2ft4UjMHEdBa_VgWmv1q4_asIyh-fW8BIQ>
X-ME-Received: <xmr:m2ICaapHkVH5OfCe_0UwVhrc1hm_0jJ8qHM3DdVrCCc_n2X0b99uFEmdj4fTY52MDzsg2b_fZCwkd7FGqPw2xVsWey0b0WYrV_JcilZL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeghedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:m2ICaU8JeGu8VsTCq3u1gFUWwxZ8kSTWs2iOyPtplK_7iAJvjH8KmQ>
    <xmx:m2ICaQ2TQmu4vrlPatBmtX_598wE1-vCFSW_fdWDTDV2YkpuTP-a_Q>
    <xmx:m2ICaXAJt5rEBlRf0DEEN_d4YcMqMrYi1cWAUdag7yp_s_wAHTmz4w>
    <xmx:m2ICafBAi-ilJ5BFwxktMrjk6Cw6yrjgHoYIJ3XOG_LTGUvEbb4JQw>
    <xmx:nmICaQswlNpaaIMHxwcWHArh2x0pYmxojqGV43iHmxtjOY10LhfdeFYL>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 14:53:14 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 038AE13E371B;
	Wed, 29 Oct 2025 14:53:13 -0400 (EDT)
Date: Wed, 29 Oct 2025 14:53:13 -0400 (EDT)
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
Subject: Re: [PATCH v4 next 6/9] lib: test_mul_u64_u64_div_u64: Test both
 generic and arch versions
In-Reply-To: <20251029173828.3682-7-david.laight.linux@gmail.com>
Message-ID: <06s18s2p-97n5-9s2o-0rq0-7o8o2ns9s3qn@syhkavp.arg>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-7-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> Change the #if in div64.c so that test_mul_u64_u64_div_u64.c
> can compile and test the generic version (including the 'long multiply')
> on architectures (eg amd64) that define their own copy.
> 
> Test the kernel version and the locally compiled version on all arch.
> Output the time taken (in ns) on the 'test completed' trace.
> 
> For reference, on my zen 5, the optimised version takes ~220ns and the
> generic version ~3350ns.
> Using the native multiply saves ~200ns and adding back the ilog2() 'optimisation'
> test adds ~50ms.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> 
> Changes for v4:
> - Fix build on non x86 (eg arm32)
> 
>  lib/math/div64.c                    |  8 +++--
>  lib/math/test_mul_u64_u64_div_u64.c | 51 +++++++++++++++++++++++++----
>  2 files changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 25295daebde9..f92e7160feb6 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -177,16 +177,18 @@ EXPORT_SYMBOL(div64_s64);
>   * Iterative div/mod for use when dividend is not expected to be much
>   * bigger than divisor.
>   */
> +#ifndef iter_div_u64_rem
>  u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
>  {
>  	return __iter_div_u64_rem(dividend, divisor, remainder);
>  }
>  EXPORT_SYMBOL(iter_div_u64_rem);
> +#endif
>  
> -#ifndef mul_u64_add_u64_div_u64
> +#if !defined(mul_u64_add_u64_div_u64) || defined(test_mul_u64_add_u64_div_u64)
>  u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
>  {
> -#if defined(__SIZEOF_INT128__)
> +#if defined(__SIZEOF_INT128__) && !defined(test_mul_u64_add_u64_div_u64)
>  
>  	/* native 64x64=128 bits multiplication */
>  	u128 prod = (u128)a * b + c;
> @@ -267,5 +269,7 @@ u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d)
>  
>  	return res;
>  }
> +#if !defined(test_mul_u64_add_u64_div_u64)
>  EXPORT_SYMBOL(mul_u64_add_u64_div_u64);
>  #endif
> +#endif
> diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
> index 4d5e4e5dac67..a3c5e54f37ef 100644
> --- a/lib/math/test_mul_u64_u64_div_u64.c
> +++ b/lib/math/test_mul_u64_u64_div_u64.c
> @@ -73,21 +73,34 @@ done
>  
>   */
>  
> -static int __init test_init(void)
> +static u64 test_mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d);
> +
> +static int __init test_run(unsigned int fn_no, const char *fn_name)
>  {
> +	u64 start_time;
>  	int errors = 0;
>  	int tests = 0;
>  	int i;
>  
> -	pr_info("Starting mul_u64_u64_div_u64() test\n");
> +	start_time = ktime_get_ns();
>  
>  	for (i = 0; i < ARRAY_SIZE(test_values); i++) {
>  		u64 a = test_values[i].a;
>  		u64 b = test_values[i].b;
>  		u64 d = test_values[i].d;
>  		u64 expected_result = test_values[i].result;
> -		u64 result = mul_u64_u64_div_u64(a, b, d);
> -		u64 result_up = mul_u64_u64_div_u64_roundup(a, b, d);
> +		u64 result, result_up;
> +
> +		switch (fn_no) {
> +		default:
> +			result = mul_u64_u64_div_u64(a, b, d);
> +			result_up = mul_u64_u64_div_u64_roundup(a, b, d);
> +			break;
> +		case 1:
> +			result = test_mul_u64_add_u64_div_u64(a, b, 0, d);
> +			result_up = test_mul_u64_add_u64_div_u64(a, b, d - 1, d);
> +			break;
> +		}
>  
>  		tests += 2;
>  
> @@ -106,15 +119,39 @@ static int __init test_init(void)
>  		}
>  	}
>  
> -	pr_info("Completed mul_u64_u64_div_u64() test, %d tests, %d errors\n",
> -		tests, errors);
> -	return errors ? -EINVAL : 0;
> +	pr_info("Completed %s() test, %d tests, %d errors, %llu ns\n",
> +		fn_name, tests, errors, ktime_get_ns() - start_time);
> +	return errors;
> +}
> +
> +static int __init test_init(void)
> +{
> +	pr_info("Starting mul_u64_u64_div_u64() test\n");
> +	if (test_run(0, "mul_u64_u64_div_u64"))
> +		return -EINVAL;
> +	if (test_run(1, "test_mul_u64_u64_div_u64"))
> +		return -EINVAL;
> +	return 0;
>  }
>  
>  static void __exit test_exit(void)
>  {
>  }
>  
> +/* Compile the generic mul_u64_add_u64_div_u64() code */
> +#define __div64_32 __div64_32
> +#define div_s64_rem div_s64_rem
> +#define div64_u64_rem div64_u64_rem
> +#define div64_u64 div64_u64
> +#define div64_s64 div64_s64
> +#define iter_div_u64_rem iter_div_u64_rem
> +
> +#undef mul_u64_add_u64_div_u64
> +#define mul_u64_add_u64_div_u64 test_mul_u64_add_u64_div_u64
> +#define test_mul_u64_add_u64_div_u64 test_mul_u64_add_u64_div_u64
> +
> +#include "div64.c"
> +
>  module_init(test_init);
>  module_exit(test_exit);
>  
> -- 
> 2.39.5
> 
> 

