Return-Path: <linux-kernel+bounces-880771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85604C26851
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27FC34E4B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE083502AA;
	Fri, 31 Oct 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dedxiGL5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982522BEC20
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933871; cv=none; b=O4ht0TQ6z2SfJVkUTzsTkLpCoSYshXps5LYJCaZtF8Pi3Y5r/2swfElNpy6GX36atByIJRWXL5Wwthjz5zaGdRW0KTAIQjuaVXtR/zirNIkJTQVlrR3XZuR63rj0KCLKBtCU78YTQ6tyYBDlG7uzQ4Xg/8JaftTEvl97AGSsMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933871; c=relaxed/simple;
	bh=YfFttLxdiNG6z3RJOZ3GHRS6fWTjvMmw1M5uEGGP5Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtWuVYg754mXbH/txHKFCfCMOj/CSnlBZCdcU+QonH9o1Dq6b9663oFEuPwpBTdGYUsEkC5mGmW25jhJKN/pjqRj+CgTF3yLcB1dGpBiEo58mxObJmm+KRTAN6U6wUFV5IlrGlZuOWUmtqT+ubFnIlYKX3UzOO9oSQEgzVBRbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dedxiGL5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710022571cso26684765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761933868; x=1762538668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49KrRFv9kd1q36NjTnjLGrfTzqfV10YN5BSsLat3zVI=;
        b=dedxiGL5qTbImcoy5yN1l/kujf2w2e6bTqe1+n9H1yhYzml5XX0OcrHrcGhkZ+5eWp
         V9NDEeuPvyU432plpXA9ZHbt1equMni8K4QMMw3TkbYyGZTSzoYKDW0o/JLMCyMfz5lh
         Oldj+kG1Mm77XiBo3PHHHnqNtazedjYtqVUWA87tZancROKaLiTX2bKreJokcgLOO9b6
         C4G8tG872Auvz7fhOhbx2/mnEYrTvgG9vHXvmAMCiuUpkStFa914dyc88ZKVLb16xxea
         KF3dXzjN3v7Bos6Ww1GOmJsvc9/zxN8OWyWNWYi+5/mqy9qfomML3TJWYgxEUYTpu0Th
         Nfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761933868; x=1762538668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49KrRFv9kd1q36NjTnjLGrfTzqfV10YN5BSsLat3zVI=;
        b=UrYxFcZnLy+LSmx0fn2WKshyg8XYo0trAgQkJ0OVlg2ASeFGku7T1BcZP8CrsoqBk+
         0acvJ3RTuJQSpnuVlkPpUGoF/abBbL42LoCL88BOocQ20c1qB6I0eD5qssN0d26uNdPf
         YzrQgCy7LVfB3KD8g39xwTp0FmtvmGjFqcpmsBzgVi6k2s9nE8J/pTeRdlICRu7XPyjc
         tJc58SrTd0MlosRvAF3q3SR7c5O+6dDc1lgcDkTBdLrCC5BD3RnwjhdBqoY0M5M2MFiC
         iLcVmQ+kqHo64urae9QzRAK/WoSRlTj+oS9+BXVdkZMoZ/x1ADg96ihIZnqMr5ZhonWa
         H3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVRocBHiOjTSb+6BrVxHko+x/lSJdzVqIn7B/5DGzb/3z5YxtU+ng0nsUVJx73h+8P06WUqHDDGpCAOYqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysUD24Tanvaq81Nlyx4+eCsnpAeFwU1WWj4WkvLWJmEbHPZwPw
	j6fPQIzKOJj5lCaVjR6U7o8r2nl7eHaBszjGKilw4o+OobnvnL7gLfK6
X-Gm-Gg: ASbGncuAEQCSRviobrCtuq7LO2SxULrpwtM0OJtSXqhEf8YZm+iAxUIAXHJQdMcBQyO
	t0FHulaZ/Zv7b8IsfNbQB22ejKodQEnFzixNbCDhfn9bqtcsWSzBcKsMCEoaB0cqNHN2gLRFZQJ
	aRZBX5nTaDlNWRbkyWMnmH8IkkiiCoBhSb8LeqZUp8EDDV92ChEgTnOquvTOKsWhknrKAjkvPdh
	/YNpyo+ztg6aaHbYCdb8DKSNTWqzRp0O1HMoq7psK12oe60ISTHoOGA7moLfX7BOYtuatLpKUba
	qUxljGe0pzIsH2159aPzq/cmSuweup8gbSO6KF1RIB3I9SyEKoVKg6MxFkBFqTQtACEyBWT9DH7
	wGQunuR8cBlvC0HHc73Z51w5d9A9QfR2l0EjzqPXcIsWW7QDR4W75u4SZemwVWe4rNQZFKgsH9s
	MKbEWe8VWvG///EHKoUzrtfC9utC6wvfeQ8DWvmFWVgXDZ4yRyphJJ
X-Google-Smtp-Source: AGHT+IH363goOBXAGB8IPKboqgUYUHaNtdeHhYyLSPS2cS0DA9/uGuq1s/28cgkYsbzIPfs2Y+jhGQ==
X-Received: by 2002:a05:600c:3e83:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-477308a4e55mr51789215e9.34.1761933867282;
        Fri, 31 Oct 2025 11:04:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c383b75sm9839515e9.11.2025.10.31.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 11:04:26 -0700 (PDT)
Date: Fri, 31 Oct 2025 18:04:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, Yu Kuai
 <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe
 <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 3/9] lib: mul_u64_u64_div_u64() simplify check
 for a 64bit product
Message-ID: <20251031180424.006f117b@pumpkin>
In-Reply-To: <689390nn-ssr5-3341-018r-s181qrr81qop@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
	<20251029173828.3682-4-david.laight.linux@gmail.com>
	<26p1nq66-8pq5-3655-r7n5-102o989391s2@onlyvoer.pbz>
	<20251031091918.643b0868@pumpkin>
	<689390nn-ssr5-3341-018r-s181qrr81qop@onlyvoer.pbz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 13:26:41 -0400 (EDT)
Nicolas Pitre <npitre@baylibre.com> wrote:

> On Fri, 31 Oct 2025, David Laight wrote:
> 
> > On Wed, 29 Oct 2025 14:11:08 -0400 (EDT)
> > Nicolas Pitre <npitre@baylibre.com> wrote:
> >   
> > > On Wed, 29 Oct 2025, David Laight wrote:
> > >   
> > > > If the product is only 64bits div64_u64() can be used for the divide.
> > > > Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
> > > > simple post-multiply check that the high 64bits are zero.
> > > > 
> > > > This has the advantage of being simpler, more accurate and less code.
> > > > It will always be faster when the product is larger than 64bits.
> > > > 
> > > > Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
> > > > (for the low 64bits) even when div64_u64() is called - so the early
> > > > check gains nothing and is just extra code.
> > > > 
> > > > 32bit cpu will need a compare (etc) to generate the 64bit ilog2()
> > > > from two 32bit bit scans - so that is non-trivial.
> > > > (Never mind the mess of x86's 'bsr' and any oddball cpu without
> > > > fast bit-scan instructions.)
> > > > Whereas the additional instructions for the 128bit multiply result
> > > > are pretty much one multiply and two adds (typically the 'adc $0,%reg'
> > > > can be run in parallel with the instruction that follows).
> > > > 
> > > > The only outliers are 64bit systems without 128bit mutiply and
> > > > simple in order 32bit ones with fast bit scan but needing extra
> > > > instructions to get the high bits of the multiply result.
> > > > I doubt it makes much difference to either, the latter is definitely
> > > > not mainstream.
> > > > 
> > > > If anyone is worried about the analysis they can look at the
> > > > generated code for x86 (especially when cmov isn't used).
> > > > 
> > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>    
> > > 
> > > Comment below.
> > > 
> > >   
> > > > ---
> > > > 
> > > > Split from patch 3 for v2, unchanged since.
> > > > 
> > > >  lib/math/div64.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/lib/math/div64.c b/lib/math/div64.c
> > > > index 1092f41e878e..7158d141b6e9 100644
> > > > --- a/lib/math/div64.c
> > > > +++ b/lib/math/div64.c
> > > > @@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
> > > >  #ifndef mul_u64_u64_div_u64
> > > >  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > > >  {
> > > > -	if (ilog2(a) + ilog2(b) <= 62)
> > > > -		return div64_u64(a * b, d);
> > > > -
> > > >  #if defined(__SIZEOF_INT128__)
> > > >  
> > > >  	/* native 64x64=128 bits multiplication */
> > > > @@ -224,6 +221,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > > >  		return ~0ULL;
> > > >  	}
> > > >  
> > > > +	if (!n_hi)
> > > > +		return div64_u64(n_lo, d);    
> > > 
> > > I'd move this before the overflow test. If this is to be taken then 
> > > you'll save one test. same cost otherwise.
> > >   
> > 
> > I wanted the 'divide by zero' result to be consistent.  
> 
> It is. div64_u64(x, 0) will produce the same result/behavior.

Are you sure, for all architectures?

> 
> > Additionally the change to stop the x86-64 version panicking on
> > overflow also makes it return ~0 for divide by zero.
> > If that is done then this version needs to be consistent and
> > return ~0 for divide by zero - which div64_u64() won't do.  
> 
> Well here I disagree. If that is some x86 peculiarity then x86 should 
> deal with it and not impose it on everybody. At least having most other 
> architectures raising SIGFPE when encountering a divide by 0 should 
> provide enough coverage to have such obviously buggy code fixed.

The issue here is that crashing the kernel isn't really acceptable.
An extra parameter could be added to return the 'status',
but that makes the calling interface horrid.
So returning ~0 on overflow and divide-by-zero makes it possible
for the caller to check for errors.
Ok, you lose ~0 as a valid result - but that is very unlikely to
need to be treated differently to 'overflow'.

> 
> > It is worth remembering that the chance of (a * b + c)/d being ~0
> > is pretty small (for non-test inputs), and any code that might expect
> > such a value is likely to have to handle overflow as well.
> > (Not to mention avoiding overflow of 'a' and 'b'.)
> > So using ~0 for overflow isn't really a problem.  
> 
> It is not.
> 
> To be clear I'm not talking about overflow nor divide by zero here. I'm 
> suggesting that the case where div64_u64() can be used should be tested 
> first as this is a far more prevalent valid occurrence than a zero 
> divisor which is not.

and I'd rather use the same error path for 'divide by zero'.

	David

> 
> 
> Nicolas


