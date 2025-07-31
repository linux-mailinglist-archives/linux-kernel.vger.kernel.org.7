Return-Path: <linux-kernel+bounces-751843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC2B16E23
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4BD7A345D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D126E71A;
	Thu, 31 Jul 2025 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rvtxKfq+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ada4j9gb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABD28D8FB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952957; cv=none; b=cXTsDXRaXVSOMpLGuEMdzW2xWpPaVeHuGIZDRYQpr2JfK0Ud0zTDFY7hqTtD554yPZAlT24P2trRAe/9Wdx9ySp4WW1Pt4gK3Pq5WQV1ICTZBZI9XSA1u/so+ZJC0S38XHaZFI1bDOuFj1doIxBr5PU1jvrUpbFDmP10XfbFw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952957; c=relaxed/simple;
	bh=5s+ptCHUwC2SaMraJA8SLXmhIPFFQ10ob5OCDobDTxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlEPVegf9JjK+UUxJreU+aPnOsUwYdP2KQBQUQJfR5nDyFz4GtV2Q2MD9Aw8Rb1axUisZOhT3E5D4JIi8dYFS0aNo93wnWZZKwdyGGDkC1+gTajIir7htz/VOu8W8Q2RZWd5md3eBXb9xECJkp8rX+Hxox4o+DcoogpP6vOmk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rvtxKfq+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ada4j9gb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Jul 2025 11:09:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753952954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c+e/K9Hj4Zr7iR3DYQKSK1puSA9rY8qyq7/7F17Bvos=;
	b=rvtxKfq+9x9ZjzbGUiq7v2M+oZ57jlrg0r1UyBlj8E10BrX4166grAprwDFU96LS6v7P29
	dWLT+tAz4qkfO8Md0O4mKWUgYjvExg3uSlq9Jm2Pcidd/FVd1q55s+wfaQHBlwYqNfGhTh
	Wv1B/VESD1v1qtRcNxY/XsXKsKJXQ9MhCrRo6RtbTXQmjMdh/YnpWm7r7rsWe1Ly3OnfV4
	D1HfI+CFgTE2lMVaCDzjjT0lBakJvU9ItT7AkDgKOES1HKuyTjPWWJF1mCuFohJjXbzF3k
	KoPs8UuoVLF6l3RMNex2kxI9J8cXYa8YALIvaQ/Ys7eWF3a+F0Y/5YLFTwM9ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753952954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c+e/K9Hj4Zr7iR3DYQKSK1puSA9rY8qyq7/7F17Bvos=;
	b=Ada4j9gb6ohJLc9CCkEN81Ot5r821xetqBjev0YdIeSRsmsSSBB88XBLRq0KclMt/UhhCj
	ZAUrbwJC712IHjBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: disable kasan_strings() kunit test when
 CONFIG_FORTIFY_SOURCE enabled
Message-ID: <20250731110823-9224fbee-6d66-4029-9e92-19447cbcda64@linutronix.de>
References: <20250731090246.887442-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731090246.887442-1-yeoreum.yun@arm.com>

On Thu, Jul 31, 2025 at 10:02:46AM +0100, Yeoreum Yun wrote:
> When CONFIG_FORTIFY_SOURCE is enabled, invalid access from source
> triggers __fortify_panic() which kills running task.
> 
> This makes failured of kasan_strings() kunit testcase since the
> kunit-try-cacth kthread running kasan_string() dies before checking the
> fault.
> 
> To address this, skip kasan_strings() kunit test when
> CONFIG_FORTIFY_SOURCE is enabled.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  mm/kasan/kasan_test_c.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 5f922dd38ffa..1577d3edabb4 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1576,6 +1576,12 @@ static void kasan_strings(struct kunit *test)
>  	 */
>  	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);
> 
> +	/*
> +	 * Harden common str/mem functions kills the kunit-try-catch thread
> +	 * before checking the fault.
> +	 */
> +	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_FORTIFY_SOURCE);

Would it be enough to enable -D__NO_FORTIFY for the whole of kasan_test_c.c?

> +
>  	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> 
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

