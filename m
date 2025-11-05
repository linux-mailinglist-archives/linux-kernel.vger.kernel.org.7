Return-Path: <linux-kernel+bounces-887303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE543C37CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C53934BAF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB862D9EC4;
	Wed,  5 Nov 2025 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xdSW9RWi"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60663277007
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376351; cv=none; b=ZSGesnHFZPKiFogjUaDs0stfiEaCY/3fkw1muw7K82EmiFvV1eg9zeLbnrDKN5IloDSnOr5EVZByzoO+1TUrw3IvdHOkFqvxba9+qrC3R84AJiIY9aUFCwf9ZvY801/lliJA1RkcC879oTb4I+6VkIHrpIn7H9Fl3FpbuAE0unQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376351; c=relaxed/simple;
	bh=et5tVWw0iVSKze1Coi4IRZefP8Y7AVrUaDb2+DY+bzg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y7Xwu0zZlPr5Dr43+vyJKV+ph1vi5xW6GF33y+XzspyuNlrtPZxtneY1qK2dJqKA1XeFOXXPntSvqDvwVE2UN+56DFvE8hkvrgX+SR9j7OS1JXLZVrDhDWK2M2EP1PeBw4aHVM8MdG5hM2Q3RU+lfZ9BQDuF++yUNHTLPAi7UOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xdSW9RWi; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e8850b09eeso1843741cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762376345; x=1762981145; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm09GQU0+FYC5S2gFVwlTc0H104Kabp++alZovl4g/s=;
        b=xdSW9RWiw3urfb44i1B99KWeeouz4hOL7jd0F5o440ApdnBaZoItgx+Sb8q5YI0UUf
         9WrU2eK6R/9lh00d9Pr+KP+vOaQjv3arybTgv03tyBcb9HBE6LMdizE+m50DrXRf7qYO
         jFLFJbdPx9xn3xfe7rrdwqrqZoVwNP+tcWvc4sF5D/3XkVaVumD9FcYe2EiXObBozltM
         JOb/PMrLvWXI1gLiEzWCTuPgD0t0fbDFdN2J9I+4Te9BxoINSkrkPLYDKLd0FtM8rxA/
         0boiwyz4hRAtUVd4f5QlttJWiwbH3zRo4PTW32tx4bNJBQrjzujGeN5uUx9YaPTUA+fr
         pQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376345; x=1762981145;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm09GQU0+FYC5S2gFVwlTc0H104Kabp++alZovl4g/s=;
        b=AiSrpRugY8aCGT9wL1DPs6TDGPLUgp6FphEm6cETEp37ZXRmaW6hxXGXy1DC7D8vAY
         iUycwq+J6a88ylu6dCXrOPoa0T0lkw9nqGZkLTWSMVYEms/bRDNxZJvJi+QKNMwFzl1v
         T5bj0h5hSMTF3h2JMi7I9sMq92YiiQ7Q5qLOQ3s0bbmGIG/ZbrLrvj8u5aLfwzAOnVr7
         nGdvnGe8i5S3s8IOy486e8shh+ho8RJONL8wRPabH6mdVjLy7dsnbLZB3i/quxiECwp4
         3VOZDGC05ItdPtYrQdAQj8YJe1lBJrh4cJwBTwakYikr8Q/TUjncyQywfkdBWFPLTnaN
         GmWg==
X-Forwarded-Encrypted: i=1; AJvYcCW6kw0al+wk9faF4xlGtVd0tPhfz2+blCR61inonsW1y2WXTFGqkBWJ1FQu/oy7y10BK/KnOCDIjvb0Ss4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1alfpJE2DCBUCopqPWHZlhF5cQ8UQ9rp77wOu2PKDMViV/BSY
	Ma2rNs2hsKPvl0piY6SYo8VJuumUtX/X/kHcN3RvJhJjssZLmvWU87EWAb/rWjzv3T0=
X-Gm-Gg: ASbGncvfL/P6WCfCJX3DUfJ3NndBHDN0Fn4EiJBrfAaF0JydJc1vZC2HUf7dWmxtAva
	3x9AM4cmCraKqNk+nEpkL4CTjecAALLQ9psPRQQWHP0EPg1VPAxrKNCdjSVHQqsz7sSHAWbrubD
	nY1IDrBhnnq5wJGg41ew65iofPEm54GxzzTO1rbdx+CDM/vBrq2dvuz0OP3sid6BvOtRv3mCMSn
	AvlctXGtrdXBdMtOj3WnMY4Xr2BW5rds+UQKSn8AOWZ3PE9HNeD5FQjVQRfJjCNw0Z50QEaqPwS
	cKd130ZuS3jusxoK1ifm+WAtzPySweRbaspnGgTSf/TUBm/tiusTBYQPDtYKdDJaGNIvmm4+VCB
	dOGnZ8OwenXQZr9zDwaCMRA8ryH3bI6HNCJXEYfs2/AMkuC95Ou5JrI9hY/WtR4MaH/tjgg56r5
	27n4dp6neRTEBmos+7XMghrkX3xh/sMTVtWzZYsQY2
X-Google-Smtp-Source: AGHT+IHfJjlyeqzYTwSHyfVBk8XFi4D3E10jZLMhaBu8dgCF9xKZvzwdqM2BmYqeXKpJRB9ypr0ScA==
X-Received: by 2002:a05:622a:1455:b0:4ec:ee66:166b with SMTP id d75a77b69052e-4ed7260259fmr57369841cf.57.1762376345101;
        Wed, 05 Nov 2025 12:59:05 -0800 (PST)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed8133579bsm3510281cf.10.2025.11.05.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:59:04 -0800 (PST)
Date: Wed, 5 Nov 2025 15:59:02 -0500 (EST)
From: Nicolas Pitre <npitre@baylibre.com>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, 
    Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
    x86@kernel.org
Subject: Re: [PATCH v5 next 3/9] lib: mul_u64_u64_div_u64() simplify check
 for a 64bit product
In-Reply-To: <20251105201035.64043-4-david.laight.linux@gmail.com>
Message-ID: <16633q71-9005-o3op-45ns-p40snps22n25@onlyvoer.pbz>
References: <20251105201035.64043-1-david.laight.linux@gmail.com> <20251105201035.64043-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Nov 2025, David Laight wrote:

> If the product is only 64bits div64_u64() can be used for the divide.
> Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
> simple post-multiply check that the high 64bits are zero.
> 
> This has the advantage of being simpler, more accurate and less code.
> It will always be faster when the product is larger than 64bits.
> 
> Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
> (for the low 64bits) even when div64_u64() is called - so the early
> check gains nothing and is just extra code.
> 
> 32bit cpu will need a compare (etc) to generate the 64bit ilog2()
> from two 32bit bit scans - so that is non-trivial.
> (Never mind the mess of x86's 'bsr' and any oddball cpu without
> fast bit-scan instructions.)
> Whereas the additional instructions for the 128bit multiply result
> are pretty much one multiply and two adds (typically the 'adc $0,%reg'
> can be run in parallel with the instruction that follows).
> 
> The only outliers are 64bit systems without 128bit mutiply and
> simple in order 32bit ones with fast bit scan but needing extra
> instructions to get the high bits of the multiply result.
> I doubt it makes much difference to either, the latter is definitely
> not mainstream.
> 
> If anyone is worried about the analysis they can look at the
> generated code for x86 (especially when cmov isn't used).
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>


> ---
> 
> Split from patch 3 for v2.
> 
> Changes for v5:
> - Test for small dividends before overflow.
> 
>  lib/math/div64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 1092f41e878e..4a4b1aa9e6e1 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
>  #ifndef mul_u64_u64_div_u64
>  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  {
> -	if (ilog2(a) + ilog2(b) <= 62)
> -		return div64_u64(a * b, d);
> -
>  #if defined(__SIZEOF_INT128__)
>  
>  	/* native 64x64=128 bits multiplication */
> @@ -212,6 +209,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
>  
>  #endif
>  
> +	if (!n_hi)
> +		return div64_u64(n_lo, d);
> +
>  	if (unlikely(n_hi >= d)) {
>  		/* trigger runtime exception if divisor is zero */
>  		if (d == 0) {
> -- 
> 2.39.5
> 
> 

