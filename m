Return-Path: <linux-kernel+bounces-880920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC97C26DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D570B4F1AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C8327202;
	Fri, 31 Oct 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIpgfHQM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A931D37B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941545; cv=none; b=FmbILAbWsjkgVvfeYMtuSFkbQruwRTA/KHO+CHEq7Y9btaDNc47/H/zVSw5JCYnhDz+rO8e6/bn2dOBCEYGOtgO8sOqQA1ugRBsnkTGqlKAtHPK60qCBSkaxbwamo73b638b1XWUJGd5GeUzcFHQeunQRYydVE/QakNPKwZ1O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941545; c=relaxed/simple;
	bh=qc0bLCb3AAhjeiRWnhDH2vcq51XYokCioTHCwOoVEB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpuyxQV9Xj0cQx2/sn2jsUnRiGDeJbV5HSoHvEIpanl/9JiGtPBfJQxmkRlr22yn7mT8L55eWEigfOF/u7Bvwg7ZsNpstx9xuu98tQw2o09x/E3IPjcG5JnCXsQySqmHBTNcZPggHco7sicWoeTk6N3AHsORa/90v2a6eQouYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIpgfHQM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so25351975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761941542; x=1762546342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTsY15OZNVbovVUCi53peKRLw69ZajroJKXqy8C5+5k=;
        b=ZIpgfHQMcTXXZZTGxWZS8BBOIZLXoiQvC0uZ+U9tYW2TzVb2vk8Y9LI4p0ixUB9PlW
         6tBXDdtmlb1ywM3m2RMOyY2+Mi1iFkDNOqe52/HWwaHeXenx27Rjb3Zf31aZYb7MjJxt
         aUQrTwmYT+dNHoGmQMgChb2yVWF6Xo2m0cG3Vs3Bh+3UrtrdrZB21XImwKDIZuf1MBEa
         lUmJX44hnInSs8JEIFnVO+8f0RlaGEcr03DXrOir5gwLawk8UuZtrhJ2H61bqd/2XOK9
         uRppvD88Q401az8OF0bQOu0h5yIuVwgFbohKDtXqmjhqfXsowRsfqf00IQAVtw/pQPWi
         YTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761941542; x=1762546342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTsY15OZNVbovVUCi53peKRLw69ZajroJKXqy8C5+5k=;
        b=ukaT99V4Vix+kkbB2/QlsaCmp0ww5jkQnsmOQKanSzVVs3IiP7ai/gb2lKC29gvpsT
         K0vG/CS8hAZ6XHazfl9Ip5rdMo6NiqVUgvd9qdXj855G+RRFb4PG5aruCw4jRDGI0Ccq
         7r5jCcSXdFd2gOXfda8poBUGfOwSovd9mxMkisuL8HlC7+u82cJWtnryvi6JCnZ/enpb
         MvKPAkOvGM70uNvwPYnXxn84GhAxw60JwWAA6VmgzlEzt/a27DLZn0WdEnKr5tHOItxX
         /ccs5SLlBYM6TwX8l0OB1LnwxAJdIw5z4WlQWD3dIDdmJTzZrKkPbWFYtvk3Q1SGRuHC
         Cbeg==
X-Forwarded-Encrypted: i=1; AJvYcCUfGAmFtBh7bQ186mO3+gdtLdavtNeS0HdIAyhjhnwJGz0t6kPlyk5jJO4PRZ28BbUgMZZjpiQWYab9vew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67LH83XTFVELqXkEzO5ABC70NjXcf31LVFGYDrDHTm0EDC2Bj
	tZ4myIS/1KdQQDftjnIXQajC0Ba/h86/5qwLKuUh82yngI1eNvNH8OZic6ayBw==
X-Gm-Gg: ASbGncvU1DADcy1L6efcCyxCgtSOms525+YhVqaashMKfKUULNUKSmXxsr0Qaki1lgB
	h1ONDrdqmGIIrp0GdgXfYgkagu8DILjDnTmzRf5cRcBGVKs2Wem/fylSmHdEjr4btuRDoUe9Xb7
	+5tVcbSXOry7vRXTn/CmULAnBQkEwTXGewyra1MSndapC7CSDT2/9tEojcBrHRfbnJ55z9FMp30
	TYksAtPQ0jq7zgZyQ1gFluQ/SWBuo6zcp4iX7okF7uRAFjh5VEfMBeNSxU3FclW+c8y/c37fu8I
	KELgxOxsn3iS1N1hq4cXXt3H5FB4zovZ8xFtwuUXwEqc0LpO9vXVkacJSUSoRSk9wex8MZW9EZB
	EL8XKwZqfJ82ygD4GWzWPksPI1miJunCIGAHlVgN8JKpwpKIOxXPAW6CgJsXBOigbDnzS0uLA8l
	d5NJapr0/Zxnc8a8bQ+nZFOnba+JWRw/Oe/D7mFD5FSUQjgDtYOleO
X-Google-Smtp-Source: AGHT+IEi3OZHw0heOLlDHv+UJLQ4qVCkWpuOdl+ls99A5rmmVZ5kRg6wEvnNE4nyHEtHj4fXw16qig==
X-Received: by 2002:a05:600c:5307:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-47730890cd5mr51627635e9.31.1761941541378;
        Fri, 31 Oct 2025 13:12:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e6771sm13345415e9.2.2025.10.31.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:12:20 -0700 (PDT)
Date: Fri, 31 Oct 2025 20:12:19 +0000
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
Message-ID: <20251031201219.63dafab7@pumpkin>
In-Reply-To: <0o57noo5-5691-r898-9277-891355713011@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
	<20251029173828.3682-4-david.laight.linux@gmail.com>
	<26p1nq66-8pq5-3655-r7n5-102o989391s2@onlyvoer.pbz>
	<20251031091918.643b0868@pumpkin>
	<689390nn-ssr5-3341-018r-s181qrr81qop@onlyvoer.pbz>
	<20251031180424.006f117b@pumpkin>
	<0o57noo5-5691-r898-9277-891355713011@onlyvoer.pbz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 14:45:49 -0400 (EDT)
Nicolas Pitre <npitre@baylibre.com> wrote:

> On Fri, 31 Oct 2025, David Laight wrote:
> 
> > On Fri, 31 Oct 2025 13:26:41 -0400 (EDT)
> > Nicolas Pitre <npitre@baylibre.com> wrote:
> >   
> > > On Fri, 31 Oct 2025, David Laight wrote:
> > >   
> > > > On Wed, 29 Oct 2025 14:11:08 -0400 (EDT)
> > > > Nicolas Pitre <npitre@baylibre.com> wrote:
> > > >     
> > > > > On Wed, 29 Oct 2025, David Laight wrote:
> > > > >     
> > > > > > If the product is only 64bits div64_u64() can be used for the divide.
> > > > > > Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
> > > > > > simple post-multiply check that the high 64bits are zero.
> > > > > > 
> > > > > > This has the advantage of being simpler, more accurate and less code.
> > > > > > It will always be faster when the product is larger than 64bits.
> > > > > > 
> > > > > > Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
> > > > > > (for the low 64bits) even when div64_u64() is called - so the early
> > > > > > check gains nothing and is just extra code.
> > > > > > 
> > > > > > 32bit cpu will need a compare (etc) to generate the 64bit ilog2()
> > > > > > from two 32bit bit scans - so that is non-trivial.
> > > > > > (Never mind the mess of x86's 'bsr' and any oddball cpu without
> > > > > > fast bit-scan instructions.)
> > > > > > Whereas the additional instructions for the 128bit multiply result
> > > > > > are pretty much one multiply and two adds (typically the 'adc $0,%reg'
> > > > > > can be run in parallel with the instruction that follows).
> > > > > > 
> > > > > > The only outliers are 64bit systems without 128bit mutiply and
> > > > > > simple in order 32bit ones with fast bit scan but needing extra
> > > > > > instructions to get the high bits of the multiply result.
> > > > > > I doubt it makes much difference to either, the latter is definitely
> > > > > > not mainstream.
> > > > > > 
> > > > > > If anyone is worried about the analysis they can look at the
> > > > > > generated code for x86 (especially when cmov isn't used).
> > > > > > 
> > > > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>      
> > > > > 
> > > > > Comment below.
> > > > > 
> > > > >     
> > > > > > ---
> > > > > > 
> > > > > > Split from patch 3 for v2, unchanged since.
> > > > > > 
> > > > > >  lib/math/div64.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/lib/math/div64.c b/lib/math/div64.c
> > > > > > index 1092f41e878e..7158d141b6e9 100644
> > > > > > --- a/lib/math/div64.c
> > > > > > +++ b/lib/math/div64.c
> > > > > > @@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
> > > > > >  #ifndef mul_u64_u64_div_u64
> > > > > >  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > > > > >  {
> > > > > > -	if (ilog2(a) + ilog2(b) <= 62)
> > > > > > -		return div64_u64(a * b, d);
> > > > > > -
> > > > > >  #if defined(__SIZEOF_INT128__)
> > > > > >  
> > > > > >  	/* native 64x64=128 bits multiplication */
> > > > > > @@ -224,6 +221,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> > > > > >  		return ~0ULL;
> > > > > >  	}
> > > > > >  
> > > > > > +	if (!n_hi)
> > > > > > +		return div64_u64(n_lo, d);      
> > > > > 
> > > > > I'd move this before the overflow test. If this is to be taken then 
> > > > > you'll save one test. same cost otherwise.
> > > > >     
> > > > 
> > > > I wanted the 'divide by zero' result to be consistent.    
> > > 
> > > It is. div64_u64(x, 0) will produce the same result/behavior.  
> > 
> > Are you sure, for all architectures?  
> 
> At least all the ones I'm familiar with.
> 
> > >   
> > > > Additionally the change to stop the x86-64 version panicking on
> > > > overflow also makes it return ~0 for divide by zero.
> > > > If that is done then this version needs to be consistent and
> > > > return ~0 for divide by zero - which div64_u64() won't do.    
> > > 
> > > Well here I disagree. If that is some x86 peculiarity then x86 should 
> > > deal with it and not impose it on everybody. At least having most other 
> > > architectures raising SIGFPE when encountering a divide by 0 should 
> > > provide enough coverage to have such obviously buggy code fixed.  
> > 
> > The issue here is that crashing the kernel isn't really acceptable.  
> 
> Encountering a div-by-0 _will_ crash the kernel (or at least kill the 
> current task) with most CPUs. They do raise an exception already with 
> the other division types. This is no different.
> 
> > An extra parameter could be added to return the 'status',
> > but that makes the calling interface horrid.  
> 
> No please.
> 
> > So returning ~0 on overflow and divide-by-zero makes it possible
> > for the caller to check for errors.  
> 
> The caller should check for a possible zero divisor _before_ performing 
> a division not after. Relying on the div-by_0 CPU behavior is a bug.
> 
> > Ok, you lose ~0 as a valid result - but that is very unlikely to
> > need to be treated differently to 'overflow'.  
> 
> I disagree. You need to check for a zero divisor up front and not rely 
> on the division to tell you about it.  This is true whether you do
> a = b/c; a = div64_u64(b, c); or a = mul_u64_u64_div_u64(a, b, c);.
> Most architectures will simply raise an exception if you attempt a div 
> by 0, some will return a plain 0. You can't rely on that.
> 
> But you need to perform the mul+div before you know there is an 
> overflow. Maybe the handling of those cases is the same for the caller 
> but this is certainly not universal.

Anyway this is all pretty much irrelevant for this patch.

	David

> 
> 
> Nicolas


