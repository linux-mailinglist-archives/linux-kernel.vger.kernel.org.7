Return-Path: <linux-kernel+bounces-879826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9457DC24287
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4BD4072C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D65330338;
	Fri, 31 Oct 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek4n8HBb"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B83329399
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902365; cv=none; b=iCu3bwrGkIt/mr/meE+opLzDHIdifLjbwzYZbCY3DU421VTlcePMsyZzB9uJRg1lp/hrWvSDeVGZBELm+zq2RzxhknWRRcq7FcyEYQzB59cFNEgvkjn67iS3KIx+FHoLhBw/1aloniZpQeEU0YWjo5nmuE+Njd88e1z8Gajx1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902365; c=relaxed/simple;
	bh=1XvO4iPNfcd8g9nVmXWngDXCVUXYVP3ksUjbrbpAMdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twhrlbVg2ocpZtIthhZnEfoLvaodTwNPZW/ecotSZj//DFhvl843uVzYJgnElZ1oz6e9LiG6ImuBA32MhUuga39ZjFRFcLF6Ysw4Pagjb0A0VRYdD3WdjEn7ha6sLMoCfXRVzjt5gZQNuaRhAOtbh3Ggl91Scbc05dHmqDs3uqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek4n8HBb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c48e05aeso66256f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761902361; x=1762507161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv+NGUkJFrKXhqIcfxzTSRTFdDofncsQ+M9ii/bGVVo=;
        b=Ek4n8HBbo1kukhPmg80kELefMJeP6AkEbUo8xbVE0ZS1yBnsmFL9yf8t0KcFcWOOVg
         /r3oUE874P2nLUpsIr62VVBujoaAuJUiyy2yMDowVc+96cuh5buZhjaP8wHiaTZ6rjDu
         X9o3AtPOAXbXxEUow3aGBGUb27g5uMVVimgJEu9lS6qAx48YZc5o6wiaITxdAO2ZxHkO
         CcCZxnm9ecdVGAAQX3Ohx1rF+C+kulvgXT6FGOLj4n0TYcz6xxT+pn7+guwv/5HrAXPk
         qA3w7qiP9WBpXHv4+ktSS76eX4/27aTF0uuQBxozw9/zSb6mXP8eYASeTeNRJhTZnojf
         FsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902361; x=1762507161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv+NGUkJFrKXhqIcfxzTSRTFdDofncsQ+M9ii/bGVVo=;
        b=Ffoe29daKt/4a0dKVS+4SGKI4npDYsrKLmOmXnZvGTHZWzTYhJyQ2SCXnZ1BIhncXB
         YB3iePAGw9oFdKyzUZKfWQ6NWxdG+LowG6PpgiitSjg2Ig8DujeswY/QQ962wRNREUYz
         iyMDt6+cxvEw6c5lSJZvmzEs5nlsQ6e9SntIRmZ/DG1cfKhrzYveQn7EgGmscOKgmfOu
         00lIAUe4TLrdqLDM9ghoZxM4tQE90k+GbGs/Zg6fyOt45b9pSZKvapqGzkVw2x+rTNzw
         OP93PrGnLa/llMS0fiLILpqszAUSyfq0QNP1Z/HASj8ugx74HegbTSZzlUthbux/xHOj
         AUsw==
X-Forwarded-Encrypted: i=1; AJvYcCVBebZ76oZexyJHqRRZ7RRdd1R/lHUah8y+wTHmBngXIT3bZBOSZ/H5olYjjD8KlMChZoC659EizLxEMjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDkaH+qDCrpmZpzFrBjoL3Mn0q4xVfNTBgelQeM+PhCwcsaCz
	Zc1bFY5zHfbFgQRS4T3QmT1wsl8W8+6490ut8my6G5WCz8qOKFDJj1qhIa9Zmg==
X-Gm-Gg: ASbGncvwY72vmFmaOyZwuYlxQz37I025XAv0keEYBUeycIlaW10IPApLOZQaDc2Zs7l
	3/WDtyLTgDLY7wGYZGQ61fqrIkCtujHixn/Ft+/PQZ9UEmjsiNpZCiVdEICfxB9K6+p4EX9rr1e
	6qShO/0a9Y3+uq8iUfQKXVK9vEweKM8XCoiXqRu0xbKRrvbPLfmBqWgcQGhQbYxUOz8u54qIcaD
	RLJcdkE9qRWhkD52zX2wNGPpIreHeL7kYzquf340cuNc60lUcvo3LjvpeWi0Ho8KHqNfStJBhCX
	PyfIJzJcIfh2Z66vZiXtL9V4QBLihb5AVYxYzVuJWl+FJ4osZPlhfQwLxKz/WU2gmwFR2vp2e4r
	8EChke/QgeaMQxlWQ03b7Gl8NMLoYmtTWRWqEoKBuGtjrsanjKRfLaiDWX/7akb5d/Ql5qOVYrJ
	UuRHfBfLvQgAjAhHUiYmFARlcQfT4lNbVFxWBQGwwilSL8N3QIYK9j
X-Google-Smtp-Source: AGHT+IG0cOgQcCBPAPSHEqS7ZoaA0ltKBsXWBUigW0apu1LeOuM2fjU9xeG+X8n3/zbvXMNzpJRQwQ==
X-Received: by 2002:a05:6000:420b:b0:429:ba48:4be with SMTP id ffacd0b85a97d-429bcd0502bmr2862414f8f.7.1761902361275;
        Fri, 31 Oct 2025 02:19:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c114c944sm2439306f8f.20.2025.10.31.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:19:20 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:19:18 +0000
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
Message-ID: <20251031091918.643b0868@pumpkin>
In-Reply-To: <26p1nq66-8pq5-3655-r7n5-102o989391s2@onlyvoer.pbz>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
	<20251029173828.3682-4-david.laight.linux@gmail.com>
	<26p1nq66-8pq5-3655-r7n5-102o989391s2@onlyvoer.pbz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 14:11:08 -0400 (EDT)
Nicolas Pitre <npitre@baylibre.com> wrote:

> On Wed, 29 Oct 2025, David Laight wrote:
> 
> > If the product is only 64bits div64_u64() can be used for the divide.
> > Replace the pre-multiply check (ilog2(a) + ilog2(b) <= 62) with a
> > simple post-multiply check that the high 64bits are zero.
> > 
> > This has the advantage of being simpler, more accurate and less code.
> > It will always be faster when the product is larger than 64bits.
> > 
> > Most 64bit cpu have a native 64x64=128 bit multiply, this is needed
> > (for the low 64bits) even when div64_u64() is called - so the early
> > check gains nothing and is just extra code.
> > 
> > 32bit cpu will need a compare (etc) to generate the 64bit ilog2()
> > from two 32bit bit scans - so that is non-trivial.
> > (Never mind the mess of x86's 'bsr' and any oddball cpu without
> > fast bit-scan instructions.)
> > Whereas the additional instructions for the 128bit multiply result
> > are pretty much one multiply and two adds (typically the 'adc $0,%reg'
> > can be run in parallel with the instruction that follows).
> > 
> > The only outliers are 64bit systems without 128bit mutiply and
> > simple in order 32bit ones with fast bit scan but needing extra
> > instructions to get the high bits of the multiply result.
> > I doubt it makes much difference to either, the latter is definitely
> > not mainstream.
> > 
> > If anyone is worried about the analysis they can look at the
> > generated code for x86 (especially when cmov isn't used).
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> Comment below.
> 
> 
> > ---
> > 
> > Split from patch 3 for v2, unchanged since.
> > 
> >  lib/math/div64.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/math/div64.c b/lib/math/div64.c
> > index 1092f41e878e..7158d141b6e9 100644
> > --- a/lib/math/div64.c
> > +++ b/lib/math/div64.c
> > @@ -186,9 +186,6 @@ EXPORT_SYMBOL(iter_div_u64_rem);
> >  #ifndef mul_u64_u64_div_u64
> >  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> >  {
> > -	if (ilog2(a) + ilog2(b) <= 62)
> > -		return div64_u64(a * b, d);
> > -
> >  #if defined(__SIZEOF_INT128__)
> >  
> >  	/* native 64x64=128 bits multiplication */
> > @@ -224,6 +221,9 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
> >  		return ~0ULL;
> >  	}
> >  
> > +	if (!n_hi)
> > +		return div64_u64(n_lo, d);  
> 
> I'd move this before the overflow test. If this is to be taken then 
> you'll save one test. same cost otherwise.
> 

I wanted the 'divide by zero' result to be consistent.

Additionally the change to stop the x86-64 version panicking on
overflow also makes it return ~0 for divide by zero.
If that is done then this version needs to be consistent and
return ~0 for divide by zero - which div64_u64() won't do.

It is worth remembering that the chance of (a * b + c)/d being ~0
is pretty small (for non-test inputs), and any code that might expect
such a value is likely to have to handle overflow as well.
(Not to mention avoiding overflow of 'a' and 'b'.)
So using ~0 for overflow isn't really a problem.

	David


 

