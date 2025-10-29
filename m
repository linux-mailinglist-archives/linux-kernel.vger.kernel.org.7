Return-Path: <linux-kernel+bounces-877135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBABC1D48C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A12784E2D61
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ACC2C21F0;
	Wed, 29 Oct 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0nH5bM/W"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B32D9ED8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770928; cv=none; b=hP6nPiE9CGkbiqHBGrWH1WGnD2SI+1Mf0+VZYgSYIiBTW1E+G54XHzrbp178huWmolJ22v0LQGsT1OjL/3SwiTneP/tjDXrpY8n41wAh1MaSqdAcwP5NXTovuUskx8qZtXlP16Pwp2OD8GMBtd1/fpAj4Tbkoig1hiXQRpBlKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770928; c=relaxed/simple;
	bh=M4KjZEul/z+UuSEmOWESkP7VBrUOAOI+7SAVIJo/zes=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lmHS4XuxeNhMaaGt5dpNfYZFahWPzGmrB1HaTWjNvq6AZ2f7B0wwdAz69LiT8Xy8xNxTlckLdbdLmsP1K6uS5EtOH0ser/G2Y6JNrt51ZmUbzn4Nu6BGMfFEy4u2XpbsVav24CVf+hTPp0AzwUGS4Qc3HrC2pr8KYUQnBkKRT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0nH5bM/W; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89ead335934so25435985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761770925; x=1762375725; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdEJNRBrY3iN0PiwMStUP0hZUDBFMAnpL0qwffFr1iI=;
        b=0nH5bM/WWSbvQZ84NHfJrg0SYQVavAADFnjWTpFzKTmqbVVSK7onAw4eA6adPRiOrz
         2VYYe4am7GreIx1CBVcmMDDtcVvwc3WznT7nOK/j+0rVFjZjnTJ+kCqhaXutCopmejGZ
         zAr6kbEU/HUVH9kZwos8vo8IXSm07IoNNjPGt8LWmmAHopBq9r45GZvT76XnzL2TmhXb
         WpfRsvPs9El1kArFJ/LEECS0iXJ42ZAUap5/PHTgR09lT+Xn5YS/xUkRJrcfC2HZY8QL
         bnl84msPawogwlUc3eOm79k5dKPBZOGZ78f3cqg55i049D2Y0NrJuZSpewupmtTpqIqR
         N1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761770925; x=1762375725;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdEJNRBrY3iN0PiwMStUP0hZUDBFMAnpL0qwffFr1iI=;
        b=m4eXmYegcdxmAhlsqdxVZs+8d56914zrSiMKcQ2KXJLouCKVKQYflim1RKnefIZLX9
         +gvAx3wsgqBeur3M+U+JTHipyF5jd9nOKANlssBvxAGZM6Jl0k3d2F3bzAA3N8IszJFj
         vXpi68JZyALwGSP6Ld+x7w90Q6LmPRvqcmcP/so93aUxjPzp9tN1frdBXU2O3y2LfGLE
         J1u4OQioLnj2jjaI+aAI+COjT4dpl9fvWpHii898VxhSLzUUmeRepjR1OxWw8W9Xniqd
         7N83lDzthR7k6cAsvMwXD/CLjmPOLp3wWhNjd0lW1+JRe5m3uDgGz5UA/C9a5iPh1963
         omBw==
X-Forwarded-Encrypted: i=1; AJvYcCVqXF0KBYvd65xk3WjQ1ad4yeCqfbWYXcbJcxV/BCHrN2zdjBg3eLApMF1kcBLq55zIoeloblP2Wrdnwrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Ll2MWu01dzakCWrU2BoutRDnZZKzuZtLxygqehL5KTXpDZ3y
	2IwIk3YiKn9PcTjAsnd5UJ5mnus3aVJtZa6TngLQs6x5czWO6DoVpD+PBAt7et71Xd0=
X-Gm-Gg: ASbGncs4nPxivJGseNm5AAaHdrGBPttk3nz69auRwmBWUrdw4kfqbdm6Y+KVU8i5igN
	oxnAY8Gvg3QniSzQHeJNNZtiKnxZKaAbsJKnO4dV+h+IsS8JFVacLtRc6HdEi+Uo6AKKOD/smvP
	SggXr95Sk4kQBcs349DY9fHoA788cuuTPHvW4NGvN/tKPNvkDvocqmDotEB/7y8T9FRgF5FcHwt
	ddiPrt2y1/ydakBKz4rnXe1bMyIEouiHfRjTvJ9CpATW01pqvef7swm7dgsK4qSg3rMMJ3fdN0h
	DYjNUFzbk8K/D7mP7blMLj3uAll93ALSAf3QgQtZsdI08KhDAKo6nDBUz12ncdlosub+sD5KBsd
	2N/46heOjSyGez9bapz2V/418+Za9ljirUHS+/jivp47z0ZER14D/B63XvGkQACtI73d/C712zC
	UuDuQ5OnEL44hSf45yn+zHQ1pB7FPu3Q==
X-Google-Smtp-Source: AGHT+IGpAwJDBN+dOEqF1sTgMvlgSh06IGN9mEPlDdnwe3RV3UfzeUHEOnXVr7XZd2EZe2Av4SyTPw==
X-Received: by 2002:a05:620a:4414:b0:8a4:b9eb:e61e with SMTP id af79cd13be357-8a8e52e3b13mr647147085a.53.1761770925129;
        Wed, 29 Oct 2025 13:48:45 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2607f05csm1115269885a.53.2025.10.29.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:48:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 16:48:43 -0400 (EDT)
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
Subject: Re: [PATCH v4 next 9/9] lib: test_mul_u64_u64_div_u64: Test the
 32bit code on 64bit
In-Reply-To: <20251029173828.3682-10-david.laight.linux@gmail.com>
Message-ID: <q48550n6-94sq-90pr-6qrn-64r4r6429970@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-10-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, David Laight wrote:

> There are slight differences in the mul_u64_add_u64_div_u64() code
> between 32bit and 64bit systems.
> 
> Compile and test the 32bit version on 64bit hosts for better test
> coverage.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> 
> Changes for v4:
> - Fix build on non x86-64
> 
>  lib/math/test_mul_u64_u64_div_u64.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
> index a3c5e54f37ef..57d5c7158b10 100644
> --- a/lib/math/test_mul_u64_u64_div_u64.c
> +++ b/lib/math/test_mul_u64_u64_div_u64.c
> @@ -74,6 +74,10 @@ done
>   */
>  
>  static u64 test_mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d);
> +#if __LONG_WIDTH__ >= 64
> +#define TEST_32BIT_DIV
> +static u64 test_mul_u64_add_u64_div_u64_32bit(u64 a, u64 b, u64 c, u64 d);
> +#endif
>  
>  static int __init test_run(unsigned int fn_no, const char *fn_name)
>  {
> @@ -100,6 +104,12 @@ static int __init test_run(unsigned int fn_no, const char *fn_name)
>  			result = test_mul_u64_add_u64_div_u64(a, b, 0, d);
>  			result_up = test_mul_u64_add_u64_div_u64(a, b, d - 1, d);
>  			break;
> +#ifdef TEST_32BIT_DIV
> +		case 2:
> +			result = test_mul_u64_add_u64_div_u64_32bit(a, b, 0, d);
> +			result_up = test_mul_u64_add_u64_div_u64_32bit(a, b, d - 1, d);
> +			break;
> +#endif
>  		}
>  
>  		tests += 2;
> @@ -131,6 +141,10 @@ static int __init test_init(void)
>  		return -EINVAL;
>  	if (test_run(1, "test_mul_u64_u64_div_u64"))
>  		return -EINVAL;
> +#ifdef TEST_32BIT_DIV
> +	if (test_run(2, "test_mul_u64_u64_div_u64_32bit"))
> +		return -EINVAL;
> +#endif
>  	return 0;
>  }
>  
> @@ -152,6 +166,21 @@ static void __exit test_exit(void)
>  
>  #include "div64.c"
>  
> +#ifdef TEST_32BIT_DIV
> +/* Recompile the generic code for 32bit long */
> +#undef test_mul_u64_add_u64_div_u64
> +#define test_mul_u64_add_u64_div_u64 test_mul_u64_add_u64_div_u64_32bit
> +#undef BITS_PER_ITER
> +#define BITS_PER_ITER 16
> +
> +#define mul_u64_u64_add_u64 mul_u64_u64_add_u64_32bit
> +#undef mul_u64_long_add_u64
> +#undef add_u64_long
> +#undef mul_add
> +
> +#include "div64.c"
> +#endif
> +
>  module_init(test_init);
>  module_exit(test_exit);
>  
> -- 
> 2.39.5
> 
> 

