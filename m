Return-Path: <linux-kernel+bounces-740775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625CB0D904
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09F51C2201A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234A2E92AB;
	Tue, 22 Jul 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6PBub+C"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81742E8E03
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186193; cv=none; b=WfnpyMn8IyRdRh++g8gpLuZhXZP+K9jBbt/oOA0XvEjK5sk1faUaRV1iVNViRJwPg9wMRbRfud4S/pq2fSCB33Ex0oVOWVKXpzElH6ttPP933FBsjgHSAlRVDT/No44m1dTGAQ8jWtY+8Rh2CaAneSWz7JbWDb7XQJvxuD78TlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186193; c=relaxed/simple;
	bh=paVgEIJFuog1REePPwBycjPn7tI443Y0/bMTT5m1Q+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBjQbFtkPj37dUVkDFFXxerkEGA+hNy6uDPOYMSGAKh+njp8/38jdrLvB5M+xwC7+3bCrkCrIJAhvG3aj0ii8DBEXBthhVUKEebMpmMiCqnwgyTIx/iRFupEGXs7Vn6AZK4PhMFaxq5pGmiKoHHZPMP4dEbv+ojZBKggeHQ8PgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6PBub+C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563a57f947so14655025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753186190; x=1753790990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6AZ/31WfPaKOxu24Z0sBnwm2hvwPL5TuS0sOPk9KuI=;
        b=Z6PBub+C98y3Q4cp0O4gsXx57W5NzEOzWrVr1vIR00Teg66zeUXhNqTlJyACCvTOia
         k/+AmFOf4Zd/jDJCKoZPpPks5L09mk9LkXWnkxqjyH3DK2/SjiHX7oFc9t8fKPRvfSin
         uCd7ZeTM6K4Wgodui2pKyT6xgCgik5O4qcjbwLSVVoOYZC2s7/tdM/ZvA4J8gbsfoL2Q
         glukwfKp1utHdCWVk2ubk6L+fMD1Sh8Jv/djhVbGXek+9Wv9oRhNAlBYUpeaSfUVTKsP
         Br961w4NCMTfVLcykdBDTw1ntiBaB0kvCLvJUiyYVPeqf6gIqFNhjRjPt/mqe4yJcMMh
         1BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186190; x=1753790990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6AZ/31WfPaKOxu24Z0sBnwm2hvwPL5TuS0sOPk9KuI=;
        b=wZ3mXLJlTCNenEvAXYKEfuYO7cct46DD27AMn5UDJbPyJVg1pcWuCbJpc+B+JCaPO0
         awOjhC1jEpCcXmmFP8a0sPmaQuAZ/if88PswF6HtUO+JEk1lvXCsx5B/mcxmGbA/Ab6t
         r4OqbE8h6KK9iLuOHXWLx+09qT+56HZwfgPVysRuPVJfJfMdfPsfFiRxfD27zY7vJZR9
         s/nnjFoBqMrnWEG6nyr4muZ0mYC+e4zR8p+Irju/qZS6bVQGQaaN11okwdc9j4wOXFe8
         //AHXRYWHlxKKHatltsTVpCTENtU/7BOKwUIRZ7w5+IV3I2K0sDOrnMyQxsGJCF5Qhgh
         AQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCXJCsMGst3glQ84y8Iv9w+g6SSM3BiYsBoZh4p9mCWGZRDjr3jGRvzg3XbMdJnBFPYHkngzi1LfFwAO7Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy327ulwBcV9BdQ3Nky51ISrWQ0ZijumAbhiH5xzqRVq+vIcWKL
	AUR7H43NfLY2V8xymIbnBlY5Qe93Yw7BEFbbKZyui2eslTLrGctleHdG
X-Gm-Gg: ASbGncurMDux/2t3yGTDRcRZN45NPLMPdH4kZw1CLUW3Z6qMWJpZYliTID6VveXuv30
	2r+dh6ciki/r8IfgXW5HLH4r6lohYsupczo+d5LQSmYwSY6wlfEbvTfbF1WH/G9BZV7j2ilanyM
	VeHLf8VywEIUYaVTdfTzyCMXcRpTclBNtMAfCRDSrofw6W4dbQufb13df4JpN0Otcvkh46+j+2u
	XrUgqWEyHAg0CSNDAzGWfSWH2aWpuzNz6r28iUUdeacEP6zxYDxZwWOPNMNfl1paw7H3IbaJQh2
	Utg1rwDoOgz3TSDWWvNCxtugPyX0jTD5WXAnWvX/gCiSkoYjNxIArgGCgSB1mJV/5Z7iy6lXmsU
	hPfkw3AQYGii9WzO/vOzdWO3yJn/vXqoTkTsf84OuhIOyIZGmm2O1TghBgUkvdcs3PVpsp+s=
X-Google-Smtp-Source: AGHT+IHwxzIsNZ1M913/8//Xa+97+n29hd0WgeVomPGC/+jH919Bsyzi7wtWQwv4I6+rXnezI/qaeA==
X-Received: by 2002:a5d:5f8a:0:b0:3b6:cdd:a41f with SMTP id ffacd0b85a97d-3b7634856bdmr2380413f8f.4.1753186189854;
        Tue, 22 Jul 2025 05:09:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5a4253sm132173445e9.3.2025.07.22.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:09:49 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:09:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250722130947.0c97c96a@pumpkin>
In-Reply-To: <20250722105034.GA2845@redhat.com>
References: <20250721130422.GA31640@redhat.com>
	<20250721192053.58843751@pumpkin>
	<20250722105034.GA2845@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 12:50:35 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/21, David Laight wrote:
> >
> > On Mon, 21 Jul 2025 15:04:22 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >  
> > > Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't
> > > fit u64, this matches the generic implementation in lib/math/div64.c.  
> >
> > Not quite, the generic version is likely to trap on divide by zero.  
> 
> I meant that the generic implementation returns -1ul too if the result
> doesn't fit into u64.
> 
> > I think it would be better to always trap (eg BUG_ON(!div)).  
> 
> Well, I don't like adding a BUG_ON(), but OK.
> 
> > The trouble there is that (an ignored) ~(u64)0 is likely to cause another
> > arithmetic overflow with even more consequences.
> >
> > So I'm not at all sure what it should look like or whether 0 is a better
> > error return (esp for div == 0).  
> 
> I'm not sure either but x86/generic versions should be consistent. Let's
> discuss this and possibly change both implementations later?

My thought as well.
Getting both to agree is a start.

My latest thought is to add another parameter for the return value
when the result overflows or is infinity/NaN.
So the calling code can get 0, 1, ~0 (or any other 'safe' value) returned.
A special 'magic' value could be used to mean BUG().

> 
> > >  static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > >  {
> > > +	int ok = 0;
> > >  	u64 q;
> > >
> > > -	asm ("mulq %2; divq %3" : "=a" (q)
> > > -				: "a" (a), "rm" (mul), "rm" (div)
> > > -				: "rdx");
> > > +	asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"  
> >
> > The "movl $1,%1" is a 5 byte instruction.
> > Better to use either 'incl' or get the constraints right for 'movb'  
> 
> Agreed, thanks,
> 
> > > +	if (ok)
> > > +		return q;
> > > +	WARN_ON_ONCE(!div);  
> >
> > I think you need to WARN for overflow as well as divide by zero.  
> 
> The generic implementation doesn't WARN... OK, I won't argue.

I've a set of patches I need to do a new version of.
I'll add a WARN_ON_ONCE() to the generic version.
I'll also put a copy of this patch in my set so that the later patches
will apply after this is applied without too much hastle.

> How about
> 
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		char ok = 0;
> 		u64 q;
> 
> 		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> 			_ASM_EXTABLE(1b, 2b)
> 			: "=a" (q), "+r" (ok)

That needs to be "+q" (ok)

> 			: "a" (a), "rm" (mul), "rm" (div)
> 			: "rdx");
> 
> 		if (ok)
> 			return q;
> 		BUG_ON(!div);
> 		WARN_ON_ONCE(1);

I know there are are a lot of WARN_ON_ONCE(1) out there,
but maybe WARN_ON_ONCE("muldiv overflow") would be better?
(The linker will merge the strings).

	David

> 		return ~(u64)0;
> 	}
> 
> ?
> 
> Oleg.
> 


