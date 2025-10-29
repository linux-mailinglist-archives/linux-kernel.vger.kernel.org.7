Return-Path: <linux-kernel+bounces-876890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34CC1CB81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580DA5639DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5062F83BE;
	Wed, 29 Oct 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zDOeHvZg"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CA25BEF1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760938; cv=none; b=sg+KN6DE41NvTuia7HSoEyo1/Qo/xOsJQ3YPYxVD7wvj6ULbH45lFlkVxgGBjH1/x0C9wuaivArn/0dxSjXb/MbnaIDfcPMs43QsLs/SLG+eRjJ/7oks75lwlxKyI8O8w6nGykSfSGaIdPKEmnFZKqmFvi7kU7/O5hVB929jgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760938; c=relaxed/simple;
	bh=8CWIIk9q/Ux58VJVkQER+gavit+qT8wfql20BtAKzQc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aqWWxHgJRQ39hoi+Rrak3ryhp019bNZvyn4/JxPxWvfHseJbuzz3FdOUpjgWn3DL8xwXfieHO3B/H21ZufQGX+GJN1/XAGjjkRczMscnGQiP4+IF8yQoc04HvPut8aOtNUK+MrK3ySiD+wpkWMNctYQRMBEb7b1CO0Q2OxE8kaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zDOeHvZg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-891667bcd82so22231685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761760934; x=1762365734; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ml3L0BfZNGzGavO1MO3NTMK1x2M+JGFYRsPpj+9UcB4=;
        b=zDOeHvZg7EX9vOd9Y/cXIXzguFeDaj8AKcXSyKekmLhn0jt42v/NYMFWrMi0uMUgaQ
         ki7K04VWldEcT4FUrCpkTu1+oJEIfREer1Kqd8STN/wdfODlcM0VkwmJKAdk7q1F5QEC
         vDQjuzTs5tbw59ZQX6uxF4O6k1gCHXIVbtW0QRMaCF9WwDLDcye6HyXV1oP4vLUcaeBB
         omctAaobi8Cn5FCuUlRHXf8s36LanyFkbaJOBkxPWkccbqU4d5pcJrqPJmYDa2fWuEN7
         gYmu51XzCf8LYoNok593boJmnI89SNqkoU7pm8t02r2uzzK9JFKeNBKMrZX/xxa88lsX
         NfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761760934; x=1762365734;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ml3L0BfZNGzGavO1MO3NTMK1x2M+JGFYRsPpj+9UcB4=;
        b=BcxdTIW030uAVqja8bn6bV7Kn8XBIOnrvyWD783Psxlien3BKsFWDqw4PSP2+UrnOQ
         CztH5aYtGYUloR8SIUTwj/q76OWw6VumQ/mdVArpAjny+F4kDJ9X14vEAuKBQCdOCj8x
         1A0BvtZe/qLaY4JHl3sq/EkUK2C6Z8Rz4GFrk8+rbKtDdqMKWwmc4ajm/yu+YXJFLB2Q
         PaH8wyYC4IOW0lxVypzH6Giivl8Mtw4kQWa6wMNY9r0mUPfJBvZmEpdYWkeQx8utDl+E
         BrNGNZCNiuuZSYq+EgSsWYucmrN1gBC+q3mhAhHABUML4s7zPHz1yrOJ6MulfUnTNeZG
         4QdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeBND3pOZGdMoLhdJfPd1yha6cgx8VhzzDo5go4x9XWOu+FyaQLK86DTy4z/9wUHNwFD9VaAP0IssG+D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEqPBz6fb3iQN2lvhcuui6RH36FYCJHuNaEj1gupcqWVbwVxx
	U5d35LDnwfV+zdxLVrO/XW/hnos8XxIjHqAqsSSFNaD4gPvausX5yS4V/RzAgB2uhEE=
X-Gm-Gg: ASbGncsFrTPsd1x76Bn5JT/jVGDOSD1IBNXZZ6Gc1VfmI2LyAAskkXmqo/VNo8KpmY+
	cnAJIhMz7i+xSYaCjGaBbrubvadJnGHzgp6Sgnsk8UIOoIhw4tYpMMmZhLG/9NsV5SBmKygBFhq
	omnNQc+0moQzNanNyabFg8RH3r6NPxzSKKL9c8I2N0ReQ77M1kRqwuFSaGOqSuTcVVRYrH1T5ye
	eJl6iKl4V6ZgzuW9SbHEc5CzqkYiKVl6kYl6zXdmfVGnR1mzxv2Rhx8jnSNVvsYW4detz0cu/es
	UdN6JDwpDkrdYq4/eIO+yuvYoPs32gMLfq7voYRSlPgdM+/K9U2dz+vY3tHYgFsgk/bJG3YnMOn
	bcgOcCEVZXI47GOZ3Vm0AAk20FOQcSdfpzNpXhzufVllypsMjdtX9tWwW4i6S/oCcgmEZ9B235C
	chylvC7Bu8gMAzX1K9lMYD61zHi96+Kw==
X-Google-Smtp-Source: AGHT+IELqolM0Ci+NHMnLtxo/blbPyhuuy13elN2RPm6z8LOJysIdG/oXs0C44NxtEkSvPPuOItx/Q==
X-Received: by 2002:a05:620a:458f:b0:89d:b1e7:29e5 with SMTP id af79cd13be357-8aa29d9a8admr70018885a.5.1761760934089;
        Wed, 29 Oct 2025 11:02:14 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25c91d9csm1079933985a.49.2025.10.29.11.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:02:13 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:02:10 -0400 (EDT)
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
Subject: Re: [PATCH v4 next 2/9] lib: mul_u64_u64_div_u64() Combine overflow
 and divide by zero checks
In-Reply-To: <20251029173828.3682-3-david.laight.linux@gmail.com>
Message-ID: <p8126roo-43s3-8266-5n3s-42969sso38s8@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> Since the overflow check always triggers when the divisor is zero
> move the check for divide by zero inside the overflow check.
> This means there is only one test in the normal path.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> 
> V3 contained a different patch 2 that did different chenges to the
> error paths.
> 
>  lib/math/div64.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 0ebff850fd4d..1092f41e878e 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -212,12 +212,16 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  
>  #endif
>  
> -	/* make sure d is not zero, trigger runtime exception otherwise */
> -	if (unlikely(d == 0)) {
> -		unsigned long zero = 0;
> +	if (unlikely(n_hi >= d)) {
> +		/* trigger runtime exception if divisor is zero */
> +		if (d == 0) {
> +			unsigned long zero = 0;
>  
> -		OPTIMIZER_HIDE_VAR(zero);
> -		return ~0UL/zero;
> +			OPTIMIZER_HIDE_VAR(zero);
> +			return ~0UL/zero;
> +		}
> +		/* overflow: result is unrepresentable in a u64 */
> +		return ~0ULL;
>  	}
>  
>  	int shift = __builtin_ctzll(d);
> @@ -234,11 +238,6 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  		 */
>  	}
>  
> -	if (n_hi >= d) {
> -		/* overflow: result is unrepresentable in a u64 */
> -		return -1;
> -	}
> -
>  	/* Do the full 128 by 64 bits division */
>  
>  	shift = __builtin_clzll(d);
> -- 
> 2.39.5
> 
> 

