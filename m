Return-Path: <linux-kernel+bounces-741582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BBAB0E60F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258DFAA15E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC2286412;
	Tue, 22 Jul 2025 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEOdT0+n"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE4221FC9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221827; cv=none; b=icVq/wxdssFqDUO+lLHgiBriZsdignRdEdEjlizyTotJHdJU58gAARdZevrRpv2Kk9zHjfZotx0Uh+KYaGcsfNnlfnrUMbAaG7T/L7Dw3rgXi6uH19ECk47ckgvwXfUw9F/U6eRgWBQYnhbHXtjMEdDDtDwPE1xO+vJ8gUUGmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221827; c=relaxed/simple;
	bh=/hk2v2tKv0aFWXaDAiRWiAFceqvq13jW55sQUz1Uo0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzKAZhXN+bSPXKWUf6L9Xk9ItmmV7W4LDlW4SJfXwWSSX6SIOtnOXOQCWdzUQAPa9LceAhr3fSHeNiPmsT1GwsfxFox4FB5dIsMCKqs6swE8bljJhtdjzrV4ua0vor4TbpzJwWUM9rj6cLHi3gdzemmHQpPOHVu2HSRlINntxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEOdT0+n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b45edf2303so5368558f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753221823; x=1753826623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+DOeS9uvizxe1iKfrbv/q108eWGpF97/hTRUl3WnSM=;
        b=JEOdT0+neNjs4U1mMJAUZDY9SaE2+7sVIO20E63tzXlbQ07ZLYHHbM07lsaL+0Szv5
         vQKkmuzk4A7yLxgrKN380l0CE2VSB0g6DyIzVMXWa9wgXdKEZj3+xF8eXskNOXgDkhnt
         bcM/45pItez7mupqxjKrzJxZ6v6ykZtDbFhO65ufS2QZ/kce7Z4jaraw+eZjXXjUOF5s
         9p9O7itsK+3EyPoMpvGF/JDMR1ymKc4St8l+UpLLvVAisMCGzuVyUdNNW2XQPoUe+ed5
         BBbaS4ssylDbFLeU4UA9mLytdxene7qQyw+AFDpXXXFz+LchMQRAE2A3ud6B/D8+/Yxe
         o8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221823; x=1753826623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+DOeS9uvizxe1iKfrbv/q108eWGpF97/hTRUl3WnSM=;
        b=NXi4oPhlHURG4Ok/bwKgaFxA/MTRH3TP57fK+N+YNv9e27UL8AvDG924HuC0JOkTvV
         0kdGJv3qR2knKhwQ4TMVn11STNGLnMWRLvHrnsK610EdymUlUvfwdXMoXlLlmgwL3NGp
         pnY5oShPlPAvWFgg6rKwhBXijgXPkeMWgn82aak0mNgqKWKRVdWna7C55D4XIUfRTf1G
         RTV98VCQGB2/+7SEbNMTJ6tstWN9YT7nUmSTYZr0hOOhQTU+djeQvdcKUz+yLhVmkR5J
         IX8C13D7n87+766dK4DOskatHYIsea93z4i8GssIVQ7TFUiCWLsbfCI8InTIEz3cvOj3
         rD5g==
X-Forwarded-Encrypted: i=1; AJvYcCXz+yMfKla82Dgp3bBDaqGpXJLB7A0/NpUn/w1kaSeFH9YjrQkJSAPwP0jpKsdqMNjZxp0DNmlx9o6D6Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7mwYufXafQyVsah/FS4iSVBiA3biSDQbwC7C0cZeEnmWOL+7
	mUlL74Y3sgaDGgdueTpW5M+YJmCx8vBoPqiu1QmwmDQzHClB5lFqxyGG
X-Gm-Gg: ASbGncu+itsvsN+Ht91WoxwoLbgpz4QnSY5+ZzvhMEtVyhk1Rt9y46N5cpHGpqxWXN9
	IkorR9geNiTYlqSSojvRAAbPlF9pokwRUpML8jVd5DzHv3sfxCP8yZt7z87+NgKNQfXZpos/2fC
	tJp75LyVdc/3IcPL/hXUaahqVG/RmnpqO9FYA2rPz7OzikHA2PQtRJIx7E5+/YBBS4GJbaC8Svm
	Q5MJkQK7rV3iXpq/jU89q5lhaH5h0vfqKa+GdxeKZXAvimGfcV2edCcp0zVeFak+Um16LJomiRM
	Qc3ZeEY9E2kGPZYN5U3PSTRSmsIcFfdldrnfxYLIFK2JPi4LsgEPe2DOH/OSunXkeXbVh22yBRp
	ovaqSHTEe32YnPH/qjAKfWYNL5r6ITa5evuvvd+4PpE3poE4bxBPsokiqKkmr
X-Google-Smtp-Source: AGHT+IHyxNg6IcA0YWHkdLgK6kpJvHyE1C0rTSBwsx4+hXBqvXstyEz8R51T6mj4iw7srnhvf35Cnw==
X-Received: by 2002:a5d:5d0c:0:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b768caa10cmr542755f8f.1.1753221823022;
        Tue, 22 Jul 2025 15:03:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869182fa5sm2668325e9.2.2025.07.22.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:03:42 -0700 (PDT)
Date: Tue, 22 Jul 2025 23:03:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250722230341.5a1cc5e5@pumpkin>
In-Reply-To: <20250722132147.GB2845@redhat.com>
References: <20250721130422.GA31640@redhat.com>
	<20250721192053.58843751@pumpkin>
	<20250722105034.GA2845@redhat.com>
	<20250722130947.0c97c96a@pumpkin>
	<20250722132147.GB2845@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 15:21:48 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/22, David Laight wrote:
> >
> > On Tue, 22 Jul 2025 12:50:35 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >  
> > > 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > > 	{
> > > 		char ok = 0;
> > > 		u64 q;
> > >
> > > 		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> > > 			_ASM_EXTABLE(1b, 2b)
> > > 			: "=a" (q), "+r" (ok)  
> >
> > That needs to be "+q" (ok)  
> 
> Thanks... I will never understand the asm constraints.

I'm not sure I understand all of them.
But the previous version wouldn't compile.

> 
> > > 		if (ok)
> > > 			return q;
> > > 		BUG_ON(!div);
> > > 		WARN_ON_ONCE(1);  
> >
> > I know there are are a lot of WARN_ON_ONCE(1) out there,
> > but maybe WARN_ON_ONCE("muldiv overflow") would be better?
> > (The linker will merge the strings).  
> 
> OK. If you are fine with this version I'll send V2.
> 
> 	/*
> 	 * Returns ULONG_MAX when the result doesn't fit u64.
> 	 */
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		char ok = 0;
> 		u64 q;
> 
> 		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> 			_ASM_EXTABLE(1b, 2b)
> 			: "=a" (q), "+q" (ok)
> 			: "a" (a), "rm" (mul), "rm" (div)
> 			: "rdx");
> 
> 		if (ok)
> 			return q;
> 		BUG_ON(!div);
> 		WARN_ONCE(1, "muldiv overflow.\n");

I wonder what WARN_ON_ONCE("muldiv overflow") outputs?

Actually, without the BUG or WARN you want:
	u64 fail = ~(u64)0;
then
	incq $1 ... "+r" (fail)
and finally
	return q | fail;
to remove the conditional branches from the normal path
(apart from one the caller might do)

	David

> 		return ~(u64)0;
> 	}
> 
> Oleg.
> 


