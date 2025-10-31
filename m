Return-Path: <linux-kernel+bounces-880813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D2C26A44
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89641A66071
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4DE225762;
	Fri, 31 Oct 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N8p1fiMp"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91F27472
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936356; cv=none; b=qzDVyYC3FgcMSTM4C/o+UaQ1rPxB3+rDwttpGJ0JbtXMTuNjlUAVYYAOhuawoVOrfp21m1JUqR1OLM33qIw4g0aFGtGgbR6qtoRUryIcpUPUwvKQiOqG5ozn2RsPahZ64R+10DShzvDjv/acSwPS/roUvd5T/rPaakbVSMHewQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936356; c=relaxed/simple;
	bh=tvr1A4yl6ZqHy8xjurGdQOmYDNNUQvkQ1JmOifa6VqI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nFmf4pygqfBg+oc28YZRS8Jyg1ugFP4xXyIpC5+NOBn3JoUXfwQNChrW+AJNL6z9yw50zmycrrOS9s2YOC6/4506cVf6AkIteZhONwjiypl7yhkLXsjj2kk2zeN2AiAkpom6PKjWyd5u67Cvu+47937GvRcTqcmPwIMUqg88RN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N8p1fiMp; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8804650ca32so724826d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761936352; x=1762541152; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pT4v28yIdvIKuKQuZoRoZnqzD4LiC42FT1gxWVGUvrQ=;
        b=N8p1fiMp9U4NJANO99OlZ5fso9HVNR30PD/IxIIWA3grQY5aqZL2Z+e4tvDXsf81VO
         6GOAyKG0svyClzS9IPQH0CHd1d64LAO9Xj6uHQprQ0aqdKAfrzvGX8beyQXRQ7T6SPDt
         KUmUKMqfxxX7szZQC9aVDVf1A1mYff3gF5h5iLyjQT9JPFZwtRsT8xtedFyKNDBQ5x7u
         OlvOb9k+uRoGseBuRbZs4e2YJvps/8cMVM3qLmQPIlcZURjQO8adEUEqRREep8imcWP4
         5ZLlpRJjDM4+xY3fpWWmDjs1CS2QrYvZQfzwsMRfS+Bzk0lMCQLgYl47QSby72XF7w50
         NjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761936352; x=1762541152;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pT4v28yIdvIKuKQuZoRoZnqzD4LiC42FT1gxWVGUvrQ=;
        b=J3/M05xyl+Mi8VA+FWWzXe5Ysq0xtAtWwSgOaait+FceH6NX7IvXj7sEDRUaePYnqT
         7hd7HrBvSqY/f0rnsz8ylaV+04kjjgQcYjLRpvsqljvLM3fOlZnsqBXurogDIEzNwiV9
         Uy/EorzspjA3T0uBuiqTYPTim2DSEiWSKRck91XXdl0oEUUv/GY7uSaE5+/4DwXwMu7e
         pGF4FXpAPuA4LxeBMlZWVe/V0UdMruq2K+eI4mSfBfI7ZQKn1SvH2i/HxDv7v3oOe+6S
         QaQ57wwweN3pRqaTkK2bFfqjaxbnwMVzprejk/urhKE5L/nkDmH1lMIZ2iQShkssRgGO
         +d7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO6/AgFKD7HPAWIkLocM8Yc7cLXa/ieWCwwXU7yjSyqunke1Wuy3dj0xoP8nluexUGeY5NXIoI36Zby9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNXLF0ynfZdrye6JsMey4cFYvqRBLpX1WJs7diBgpITLaGWdE
	vi1uNFdF0X2DiIuNScKobq7nArqk4OakvTLKeI89gB7A4h2Qj7zdFS9EvOmquv8h3po=
X-Gm-Gg: ASbGncsH7Ht0Ut0jUkd/oroinHs/FGrljsEJXXKRwec6BhUnsc239tfedla25SEjraF
	t5VmGUz0rSU6C7XlqDuILXRsgOFwL7x+LTmRQ+zB+P9YfccSgdZ0gyXsDXDPTnB/+oFAZewetZg
	jVQUZUv5r84ritsqjSqDZ53pHptpcKQQ5P8dpsNh+xR6XAPyLaZLRMV6ph1ZVPYqerHepwESgC1
	mrRPuZuI0E8rRiMAdoYSTAmymj5MI4Pv3QC3YKaUBDJpRgOA9GgvvsiRjIfV2uPl8dZlq2w2vIL
	VhTCj4tMlg49qQY/wwHnbxiYwwq4LzjvCYtidKGwxbsIEW5LI3AO6FyHkoloGqgLGBwriajE+eT
	lYOyFt7wJIAGcIwUmfClWkRhkWlnKeI+NLmq/vgdUQUSIPcXtFadb0SdzhHhyUsHQxPfbk3JNBk
	VUck3LGZz2QF4+KqKwtMsvNeYLAcBe7Q==
X-Google-Smtp-Source: AGHT+IEZewel5dfeu23WjC5PDmeMH8piiDMOsKyv8SzWCUJvsUnNs2jVApnjV9zOu7qBYs4d/oPVlQ==
X-Received: by 2002:a05:6214:f29:b0:87e:d590:89b7 with SMTP id 6a1803df08f44-8802f2f1847mr70034896d6.19.1761936351907;
        Fri, 31 Oct 2025 11:45:51 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880360bda55sm15903686d6.26.2025.10.31.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 11:45:51 -0700 (PDT)
Date: Fri, 31 Oct 2025 14:45:49 -0400 (EDT)
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
Subject: Re: [PATCH v4 next 3/9] lib: mul_u64_u64_div_u64() simplify check
 for a 64bit product
In-Reply-To: <20251031180424.006f117b@pumpkin>
Message-ID: <0o57noo5-5691-r898-9277-891355713011@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-4-david.laight.linux@gmail.com> <26p1nq66-8pq5-3655-r7n5-102o989391s2@onlyvoer.pbz> <20251031091918.643b0868@pumpkin> <689390nn-ssr5-3341-018r-s181qrr81qop@onlyvoer.pbz>
 <20251031180424.006f117b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Oct 2025, David Laight wrote:

> On Fri, 31 Oct 2025 13:26:41 -0400 (EDT)
> Nicolas Pitre <npitre@baylibre.com> wrote:
> 
> > On Fri, 31 Oct 2025, David Laight wrote:
> > 
> > > On Wed, 29 Oct 2025 14:11:08 -0400 (EDT)
> > > Nicolas Pitre <npitre@baylibre.com> wrote:
> > >   
> > > > On Wed, 29 Oct 2025, David Laight wrote:
> > > >   
> > > > > If the product is only 64bits div64_u64() can be used for the divide.
> > > > > Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
> > > > > simple post-multiply check that the high 64bits are zero.
> > > > > 
> > > > > This has the advantage of being simpler, more accurate and less code.
> > > > > It will always be faster when the product is larger than 64bits.
> > > > > 
> > > > > Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
> > > > > (for the low 64bits) even when div64_u64() is called - so the early
> > > > > check gains nothing and is just extra code.
> > > > > 
> > > > > 32bit cpu will need a compare (etc) to generate the 64bit ilog2()
> > > > > from two 32bit bit scans - so that is non-trivial.
> > > > > (Never mind the mess of x86's 'bsr' and any oddball cpu without
> > > > > fast bit-scan instructions.)
> > > > > Whereas the additional instructions for the 128bit multiply result
> > > > > are pretty much one multiply and two adds (typically the 'adc $0,%reg'
> > > > > can be run in parallel with the instruction that follows).
> > > > > 
> > > > > The only outliers are 64bit systems without 128bit mutiply and
> > > > > simple in order 32bit ones with fast bit scan but needing extra
> > > > > instructions to get the high bits of the multiply result.
> > > > > I doubt it makes much difference to either, the latter is definitely
> > > > > not mainstream.
> > > > > 
> > > > > If anyone is worried about the analysis they can look at the
> > > > > generated code for x86 (especially when cmov isn't used).
> > > > > 
> > > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>    
> > > > 
> > > > Comment below.
> > > > 
> > > >   
> > > > > ---
> > > > > 
> > > > > Split from patch 3 for v2, unchanged since.
> > > > > 
> > > > >  lib/math/div64.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/lib/math/div64.c b/lib/math/div64.c
> > > > > index 1092f41e878e..7158d141b6e9 100644
> > > > > --- a/lib/math/div64.c
> > > > > +++ b/lib/math/div64.c
> > > > > @@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
> > > > >  #ifndef mul_u64_u64_div_u64
> > > > >  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > > > >  {
> > > > > -	if (ilog2(a) + ilog2(b) <= 62)
> > > > > -		return div64_u64(a * b, d);
> > > > > -
> > > > >  #if defined(__SIZEOF_INT128__)
> > > > >  
> > > > >  	/* native 64x64=128 bits multiplication */
> > > > > @@ -224,6 +221,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > > > >  		return ~0ULL;
> > > > >  	}
> > > > >  
> > > > > +	if (!n_hi)
> > > > > +		return div64_u64(n_lo, d);    
> > > > 
> > > > I'd move this before the overflow test. If this is to be taken then 
> > > > you'll save one test. same cost otherwise.
> > > >   
> > > 
> > > I wanted the 'divide by zero' result to be consistent.  
> > 
> > It is. div64_u64(x, 0) will produce the same result/behavior.
> 
> Are you sure, for all architectures?

At least all the ones I'm familiar with.

> > 
> > > Additionally the change to stop the x86-64 version panicking on
> > > overflow also makes it return ~0 for divide by zero.
> > > If that is done then this version needs to be consistent and
> > > return ~0 for divide by zero - which div64_u64() won't do.  
> > 
> > Well here I disagree. If that is some x86 peculiarity then x86 should 
> > deal with it and not impose it on everybody. At least having most other 
> > architectures raising SIGFPE when encountering a divide by 0 should 
> > provide enough coverage to have such obviously buggy code fixed.
> 
> The issue here is that crashing the kernel isn't really acceptable.

Encountering a div-by-0 _will_ crash the kernel (or at least kill the 
current task) with most CPUs. They do raise an exception already with 
the other division types. This is no different.

> An extra parameter could be added to return the 'status',
> but that makes the calling interface horrid.

No please.

> So returning ~0 on overflow and divide-by-zero makes it possible
> for the caller to check for errors.

The caller should check for a possible zero divisor _before_ performing 
a division not after. Relying on the div-by_0 CPU behavior is a bug.

> Ok, you lose ~0 as a valid result - but that is very unlikely to
> need to be treated differently to 'overflow'.

I disagree. You need to check for a zero divisor up front and not rely 
on the division to tell you about it.  This is true whether you do
a = b/c; a = div64_u64(b, c); or a = mul_u64_u64_div_u64(a, b, c);.
Most architectures will simply raise an exception if you attempt a div 
by 0, some will return a plain 0. You can't rely on that.

But you need to perform the mul+div before you know there is an 
overflow. Maybe the handling of those cases is the same for the caller 
but this is certainly not universal.


Nicolas

