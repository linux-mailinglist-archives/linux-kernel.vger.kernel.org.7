Return-Path: <linux-kernel+bounces-743238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7FFB0FC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBBF966B86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4100272E4C;
	Wed, 23 Jul 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+y3V5Qe"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379C7F9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307320; cv=none; b=rnIAsMtD6OZZTCzXSC7EGMly83WSKfCU7ohPG1OM/FVxUJWzdUki7nI7hAczz3+OL7S61lJNnOEochaApchtRLHBo/buIj+LbtU/quJxtmV5eu4+i07URcHSKNyJRMTlMUc0zpGLnD54U0EhjqOitkhE9JJ1fG/mA7A8uXZqZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307320; c=relaxed/simple;
	bh=111HmBKNW7Gc32cGDLh6PtVbTq1+IiiRl2N5WRtoOEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCtHbRCm7qJh+iRNmb8a1S/7ykYV885DDk8QgYuorMeLfQGo23uyMXjfXsz9VAbR+Vh2vuKjTOvhgrpEvWfzZheRlOq+lbbdrAwNA/EWil9W8ubt4qX53KsFvSpgnjfQ8uF/kKPthgm9jHxoo59V6OqJIrqiSyoPi0ZjS+gn14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+y3V5Qe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d6ade159so1744955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753307315; x=1753912115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYlC5bhIttx3KseLGoUe3QTXqfXXtUDSQucv+2ZCw0c=;
        b=N+y3V5QeMNxa1uRQqHUxeMkiJg5RcbBBHksdqFM/9OC8lWzuRmXDcJgSBEyPmvJTEK
         UWRf10vZkSyBJAxUAmqHhw6F9AoADSGVnpkJsF3PFw6bfvD3aJ795Cu/KqIpxjXOOm2C
         Vi+pWK2fO/NbcJf6Va8vplxZPDDN3eXoNeqDe7od4X3UE0/tv4bSsXTD2HIoqxnn3q+I
         lQszdkKqR9m2nIvICjeq57e77W4emw2ve48dwXEzvY274uZtELiPV3eFySs6uDw6GdTs
         epG9xzcBSJU+ay0kge+7PF5lZ0+GSzNq6QtZjSmcB+AnDVLP9Fqsb0FFG8S6M6BML01b
         1+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753307315; x=1753912115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYlC5bhIttx3KseLGoUe3QTXqfXXtUDSQucv+2ZCw0c=;
        b=KUuELRONCbv+UifdGxkwXHxUsXQaaDk6mfKDDNBpFKQYcE5uNlBBQGwT8ra16HyYmv
         d+q+xx0CuJL1s7ATHTmtjAKZZGJDSrCqLEwPbr1OV4XXYdQ6DOagLZMCbTa4VyzRvvEM
         haaM9D/ZaXgXi84PaV0F4enPPxbbzCk8V1ZOtb3gX/tLkIdsu5RNhwa71eVveMCh8YWT
         D4/p2h1Os4yfNI7E/medA2JxJ1CIsQ1Qj5AH9vVeYHvW3QMja2M1BqZy1txyo9iwjPT4
         0DXpIAwmiAsTPw1W8mPXxK91mnqHeYlF8nlDQGVDJDKilYGYTYWvOUanhHhxyREfugOP
         NMjA==
X-Forwarded-Encrypted: i=1; AJvYcCVQPP2CM8qmwC1Y8RXE2jU8uvgAfG5A+JlGtTfOVKhnbfU6bbWqSQ1hovEWYuy5VLCoCzCi8djy1eEdnew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzrFP01B8fqgC5xAUe4fuupsM/O9du6FulHL4XSBkdPKr6SRQ
	XrQ0ICsJNVCBtVkwFlc2YV4htEsuPjhzI3ySU1B0qUQRcixZ6Y1W5gLe
X-Gm-Gg: ASbGncspOi319Dt82LaJBVoUeYkoj6rx4CzhxclHGsiE3jzajIhg6evRocykK7tRdC3
	50dgaRtEmKG49NilMs9uGkluv+Ir0znW0BxMkO5xSOqeE7MptHRorJv+0rvfjpP5Vz3Pn6FNOi9
	Q11u6W7TEzosBDdHCxZpVd2/PnMXX/JmuB2qzUTbhSYKcpd0EVNDdZ+emUEfh2/t46ACfLGr9XX
	8HUdulF1snvqDv/QSHVtI8PWydZ6IDC5HD1s/8HbZXOqtIayOeFEKW0Qns5hES3pr0lRwWmrZL3
	m3t1Y/Im54Afgw633Y1lsNUffEbDw+wvmL2VwDxkeGD3U2Q1uaboo85/iEsIK9r4cVYHsL2fxDP
	HFmG4F6bNOCer5vyxoq4VWTVVV7paeAX4rZPN8GrzHQAl7TaNCtaFTLn32x5x
X-Google-Smtp-Source: AGHT+IFtwyxVfbJCXBXf+sVdhT9ynKPqlefJhLSD4LJiR0W8Y3nswcLtwbiQh1+SOFF+aSwL2CioXQ==
X-Received: by 2002:a05:600c:4686:b0:456:2212:46b8 with SMTP id 5b1f17b1804b1-45868d3092emr36759035e9.28.1753307314299;
        Wed, 23 Jul 2025 14:48:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f410f5esm1400825e9.20.2025.07.23.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 14:48:33 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:48:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250723224831.4492ec75@pumpkin>
In-Reply-To: <20250723093825.GA12884@redhat.com>
References: <20250721130422.GA31640@redhat.com>
	<20250721192053.58843751@pumpkin>
	<20250722105034.GA2845@redhat.com>
	<20250722130947.0c97c96a@pumpkin>
	<20250722132147.GB2845@redhat.com>
	<20250722230341.5a1cc5e5@pumpkin>
	<20250723093825.GA12884@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 11:38:25 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/22, David Laight wrote:
> >
> > On Tue, 22 Jul 2025 15:21:48 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >  
> > > 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > > 	{
> > > 		char ok = 0;
> > > 		u64 q;
> > >
> > > 		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> > > 			_ASM_EXTABLE(1b, 2b)
> > > 			: "=a" (q), "+q" (ok)
> > > 			: "a" (a), "rm" (mul), "rm" (div)
> > > 			: "rdx");
> > >
> > > 		if (ok)
> > > 			return q;
> > > 		BUG_ON(!div);
> > > 		WARN_ONCE(1, "muldiv overflow.\n");  
> >
> > I wonder what WARN_ON_ONCE("muldiv overflow") outputs?  
> 
> Well, it outputs "muldiv overflow." ;) So I am not sure it is better
> than just WARN_ON_ONCE(1).
> 
> > Actually, without the BUG or WARN you want:
> > 	u64 fail = ~(u64)0;
> > then
> > 	incq $1 ... "+r" (fail)
> > and finally
> > 	return q | fail;
> > to remove the conditional branches from the normal path
> > (apart from one the caller might do)  
> 
> I was thinking about
> 
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		u64 q;
> 
> 		asm ("mulq %2; 1: divq %3; jmp 3f; 2: movq $-1,%0; 3:\n"
> 			_ASM_EXTABLE(1b, 2b)
> 			: "=a" (q)
> 			: "a" (a), "rm" (mul), "rm" (div)
> 			: "rdx");
> 
> 		return q;
> 	}
> 
> to remove the conditional branch and additional variable. Your version
> is probably beterr... But this is without WARN/BUG.

I wish there was a way of doing a WARN_ONCE from asm with a single instruction.
Then you could put one after your 2:
Otherwise is it a conditional and a load of inlined code.

> So, which version do you prefer?

I wish I knew :-)

Yours is a few bytes shorter, uses one less register, but has that unconditional jmp.
I suspect we don't worry about the cpu not predicting a jump - especially with
the divq.
It's not as though some real-time code relies on this code being as fast
as absolutely possible.
Not using a register is probably the main win.

So maybe I lose (this time).

Further work could add an 'int *' parameter that is set non-zero (from %rax)
if the divide traps; optimised out if NULL.
The easy way is two copies of the asm statement.
But I've already got two copies in the version that does (a * b + c)/d
and four copies is getting silly.

Actually this seems ok - at least as a real function:

    u64 mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 div)
    {
        unsigned __int128 v = (__int128)a * b + c;
                
        asm ("1: divq %1; jmp 3f; 2: movq $-1,%%rax; 3:\n"
			_ASM_EXTABLE(1b, 2b)
			: "+A" (v)
			: "r" (div));
        return v;
    }

But (as I found with 32bit) gcc can decide to do a 128x128 multiply.
It does do a full 128bit add - with an extra register for the zero.

Not that you should never pass "rm" to clang, needs to be "r".
There is a #define for it.

	David


> 
> Oleg.
> 


