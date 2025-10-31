Return-Path: <linux-kernel+bounces-880681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32735C26548
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003F03B80D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC83054F7;
	Fri, 31 Oct 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U7NkMFPY"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681592F3C34
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931608; cv=none; b=CoOCDI+h1Mex+yV4zwNJchhHbA7+r1PC18F6FI/PwToPJTKFw/MfTeL8JqwXameWtE2dtIAEWBI0FcHUzJXatnSc1IN1OYr3vlaVan3oShK/ZN7Ey2vx8FdjU6aR61avx9du/XbNt4Q0yVMNWzOhjCcZUi6w+CECGE0BzS4jk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931608; c=relaxed/simple;
	bh=5jKZQnGfWIPBfEdMU3/GpXnA8AzNlM4kmlbx9UGKjh0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JQdIOeZtO7mpPxTRK6ntEynTonJPhxLCiWNhfNbbtOyw1qyCAVfeNAQqQ8TWEB2AQDoT8jSQi0NSudsx/FNU2PEj7Ir0l92DpcSz11ZxDSwNfkqU4HQDYyuERN9NaqsnsFVA5R/mg3+ozvK4wiVpeMsAud1Qy8u3gkj6esiYPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U7NkMFPY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88f2b29b651so243508285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761931604; x=1762536404; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnjJjq1uXSia2MqKg+bdbADtCIwkFyG1D2hZxLKYUgI=;
        b=U7NkMFPYLNIl+yW552PdrCJFkCZgsNauXElPOJ3HcESJorGbzkWDLmkZSNvW5ldI8n
         j8bjOSURw3rztsYCKsjHDuCiLPWtUIkuLSxTGo/kJjsBrRcXsF8FpuntM4RNd1KI7GGu
         j6yTVEqITk7F0oATRG61DZ0BvmpSK0e6Tv1zdrRHXkepGm1IH1Qcw313lFQsaoJfqvpC
         skYSaVNT3KsF2FVQ/N1/fVCFRRRRND9zPy5PVLSQ+TBSX7Kh11Z9dutT4kGITBJ1K75/
         Z3P3IsqNfBgZPG7cF2eO8/6F4w2doRv7MTV/Dr5MtoNTcapWfe8zGlAxCYbXqofFadz0
         xQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761931604; x=1762536404;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnjJjq1uXSia2MqKg+bdbADtCIwkFyG1D2hZxLKYUgI=;
        b=iTUOx5LD6cXh4Gf6GWsUuYKzg2QDmruSfu/A84OwUe+dR/Nz8WwfuM71N/1zOKmnf6
         aWkKXldvMcextmoGkj7E3jhi6cmDu8h1w5SGHkNIiixBsuxbHDgi/VLOQdZVs5NgVQwR
         V0Wf3n5yml7fGBlUNd4Ji0fGbvZQXaYJqmqgJinqrEpMK+nDJRShpzi3683izIluxloK
         I1SVsi+kDxUCzYrZFlDR3xin8NDEyxV7cmdEQJeve2y+Fqhcb4iPbdhyTel/tgvD6RnD
         zuoIN+kxOY+dzpsHFrfpJ1Duj/spbO7+pEYMKD1bUVeR52kqWp7pCS/5YUNToscw5hJF
         EwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMNMzkwrmJU0TrxZOK16LVQx6hK4efqzNisGPqJitFXBPEUzjqJslxRdko4f8OguM4bfwQqVnCZNmTp/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kYZs+hVKeNLP2k7TBYfqZx3DAlWkt3BwHI+LDPnJIJO8+TlC
	ZT4lyhRPScoahROOyE11r5j6dTfcilFyc91yzFzhw97W/p+gv3NvA1lYKhp1hd1S1js=
X-Gm-Gg: ASbGncvMu5y5sv/DmFBvEaIwL3pznNnK7eJvpbK6GHO0EAEzNayfiQZbMnjj35hlKrE
	LJlqukJtvvO74VuLXOKePTVrmTZUEGQNW2y1J6IoCIH9XhhOni8hEXy4nDej1D0mJc0wuJxLKt9
	eeuDwbMos60XngPmXgiP53HjBJQETWbwjJjoEPRfhBB2AldJ3bDCrj67x04ovzEQb9QNRJBDf5E
	vg4tlaelXvrH4Yac/FPV9tx4h/Ck/l7Fy/19d2mDA0l19CSb/q9Y79aSuD+2ZrX7UAGdvtBSxrL
	d75c41HBjFkvwmkqyifz+v4cCJAnq6a8GW7aokb6y3RTx7smddKrPjCzfa4V8vRTjMEaw/Tmbqu
	xzpcc9AmnCzEIc3DcywXLh/RVZKMi9o2iUPAvD+ianUpq7/pE+BB0nzYIwYnPnib+ZAAUpOLlYy
	H8sOvp+ySKCNR9mhNo8M4yAD/A0V9YSw==
X-Google-Smtp-Source: AGHT+IEDxP9vwyv7ouxIhibFgZNx+LhZvF97GTT8bElIHceMVNW5ssNQSqUHJbYZg7UAidVl4EZQZw==
X-Received: by 2002:a05:620a:2913:b0:89a:5b62:d9e9 with SMTP id af79cd13be357-8ab9b59c430mr440378785a.65.1761931603515;
        Fri, 31 Oct 2025 10:26:43 -0700 (PDT)
Received: from xanadu (modemcable048.4-80-70.mc.videotron.ca. [70.80.4.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac03f4d585sm143968785a.56.2025.10.31.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:26:42 -0700 (PDT)
Date: Fri, 31 Oct 2025 13:26:41 -0400 (EDT)
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
In-Reply-To: <20251031091918.643b0868@pumpkin>
Message-ID: <689390nn-ssr5-3341-018r-s181qrr81qop@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com> <20251029173828.3682-4-david.laight.linux@gmail.com> <26p1nq66-8pq5-3655-r7n5-102o989391s2@onlyvoer.pbz> <20251031091918.643b0868@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Oct 2025, David Laight wrote:

> On Wed, 29 Oct 2025 14:11:08 -0400 (EDT)
> Nicolas Pitre <npitre@baylibre.com> wrote:
> 
> > On Wed, 29 Oct 2025, David Laight wrote:
> > 
> > > If the product is only 64bits div64_u64() can be used for the divide.
> > > Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
> > > simple post-multiply check that the high 64bits are zero.
> > > 
> > > This has the advantage of being simpler, more accurate and less code.
> > > It will always be faster when the product is larger than 64bits.
> > > 
> > > Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
> > > (for the low 64bits) even when div64_u64() is called - so the early
> > > check gains nothing and is just extra code.
> > > 
> > > 32bit cpu will need a compare (etc) to generate the 64bit ilog2()
> > > from two 32bit bit scans - so that is non-trivial.
> > > (Never mind the mess of x86's 'bsr' and any oddball cpu without
> > > fast bit-scan instructions.)
> > > Whereas the additional instructions for the 128bit multiply result
> > > are pretty much one multiply and two adds (typically the 'adc $0,%reg'
> > > can be run in parallel with the instruction that follows).
> > > 
> > > The only outliers are 64bit systems without 128bit mutiply and
> > > simple in order 32bit ones with fast bit scan but needing extra
> > > instructions to get the high bits of the multiply result.
> > > I doubt it makes much difference to either, the latter is definitely
> > > not mainstream.
> > > 
> > > If anyone is worried about the analysis they can look at the
> > > generated code for x86 (especially when cmov isn't used).
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> > 
> > Comment below.
> > 
> > 
> > > ---
> > > 
> > > Split from patch 3 for v2, unchanged since.
> > > 
> > >  lib/math/div64.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/lib/math/div64.c b/lib/math/div64.c
> > > index 1092f41e878e..7158d141b6e9 100644
> > > --- a/lib/math/div64.c
> > > +++ b/lib/math/div64.c
> > > @@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
> > >  #ifndef mul_u64_u64_div_u64
> > >  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > >  {
> > > -	if (ilog2(a) + ilog2(b) <= 62)
> > > -		return div64_u64(a * b, d);
> > > -
> > >  #if defined(__SIZEOF_INT128__)
> > >  
> > >  	/* native 64x64=128 bits multiplication */
> > > @@ -224,6 +221,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > >  		return ~0ULL;
> > >  	}
> > >  
> > > +	if (!n_hi)
> > > +		return div64_u64(n_lo, d);  
> > 
> > I'd move this before the overflow test. If this is to be taken then 
> > you'll save one test. same cost otherwise.
> > 
> 
> I wanted the 'divide by zero' result to be consistent.

It is. div64_u64(x, 0) will produce the same result/behavior.

> Additionally the change to stop the x86-64 version panicking on
> overflow also makes it return ~0 for divide by zero.
> If that is done then this version needs to be consistent and
> return ~0 for divide by zero - which div64_u64() won't do.

Well here I disagree. If that is some x86 peculiarity then x86 should 
deal with it and not impose it on everybody. At least having most other 
architectures raising SIGFPE when encountering a divide by 0 should 
provide enough coverage to have such obviously buggy code fixed.

> It is worth remembering that the chance of (a * b + c)/d being ~0
> is pretty small (for non-test inputs), and any code that might expect
> such a value is likely to have to handle overflow as well.
> (Not to mention avoiding overflow of 'a' and 'b'.)
> So using ~0 for overflow isn't really a problem.

It is not.

To be clear I'm not talking about overflow nor divide by zero here. I'm 
suggesting that the case where div64_u64() can be used should be tested 
first as this is a far more prevalent valid occurrence than a zero 
divisor which is not.


Nicolas

