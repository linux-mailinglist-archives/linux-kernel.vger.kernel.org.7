Return-Path: <linux-kernel+bounces-741561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593BB0E5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B365645AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E34284678;
	Tue, 22 Jul 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1nA75dJ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508171B808
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221418; cv=none; b=nukbMWIJt9a90Zd9+66qgawos1I17EdVdXZjlRKeWIFGzTpQTRqoTAVvuqQuI+dakxl5KG3q65YA+w/80rbg/1hNgqaMM+Bh3HKeSS2SX2dvfybvBF2nET7RW+FoJE43MUo7aqUBGg1MaQPQ8XYDvQUOsHWg4T7kX6M9g2E1AWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221418; c=relaxed/simple;
	bh=uh6MTlKOayxB290TRwlvOOnQrfYiXTvogD7wrBI82FE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puWZwWeuQw1W0yuFR6kHStfbN4LWbVGt34GIiONR9IgL5+sD0YhEcacRDzeaAaRtrjQLeBWt66d4Skie1TeqsmrJlAoTPPSMJeA+yy8VZqh1kJsmdX7Nl5Winu+9ohxiUvAVlXEmSd7CuPGFF+3+27HYe/nt8LSuz2OGoaQOC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1nA75dJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b5e6bfb427so3212593f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753221415; x=1753826215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jaQml7z8e1kgu126oSEegcw+RIKH/SOoIdjTioWg4w=;
        b=A1nA75dJ+HryAbcPMB6mPYc3mb498O7d6BTEhbtwEnYp7loSym6NvNIGUD0eqHoUix
         ehd3JggFQknpk4uApJN1Q1xE3BDW/I8N6E49TFvDVrRJzrFQ1iLvj9ZvOmAeb0B2H8+M
         ysGp7GcVuqDOfO7tuz5UB2LRZDuoNpThR/4A64NNzqDr1tcaCxQFKN/tsN2M98i+ER9f
         XVbfcuNg7dWqv9JbdbG1s37ATFf+Zx8Zfk8fp9B1eu85yfpL36dB237COtwNmgKbXiKg
         u1K956Pj+IapFVfKrhAssSICKlrYMchP6wnoBrWoU9M/o/+ZJvZHGYla7IB8rBAmteFe
         F0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221415; x=1753826215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jaQml7z8e1kgu126oSEegcw+RIKH/SOoIdjTioWg4w=;
        b=D9KM4/I/E9sD8K9MyHfnevJ6Vq0VqoFvgQTpYf5eLcX626HOxgCM3H9FsSsvO6PZK2
         IIjg/PG1+idFV6QHOwd0oWGuwAGT5LQmwdwovlAtV+22GqQqvgBv6jnU3EdeZa48yThq
         6Ro/v5Bzf6WDddMx8Jm6yPj3dr0Y+TpwIEVinUNi5gsjBqcveU8BMq7c5P9Z4dzEcdNk
         UaTeOThL8jr/c0YfzsfWsCQkyjBHSb61JfvRRLmWYvSfx9nEfdQIzcyVWSruKVkZ8e1G
         t4MvWGQn3ZNq+b9XPdlt8Y9ctrv4Q3BB3FY/o3ZjXY5p2IfaQ+LA4syT8FIPos9O4vFQ
         F+3A==
X-Forwarded-Encrypted: i=1; AJvYcCXqBrgA2O9H52+/GnZL3Rv4wldes7WoMl761KVvxHH9pLlEB9FO2F7q/UTdQA5QAcJKpb9CFeSyOleD954=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEy+FpLvzhfa2lvBZjaf6gX4VxVX4noyWsy10x9Q3MeiK1BfP
	2TRTv/cvjwz6UEzM35kaRATqT/EjTTgKHhvBaO4fTtl1VLICCYPxKur5
X-Gm-Gg: ASbGncs+zht+pZPeWnhsvijEhPAwa65spdRj9625mysQGuaYX6zLWChUk/7pbElElLa
	UOzhIGPLgE13SYVrEItlhCAGK3GYewtxs/EB9PRzvLQadpG++CfRPtYPrUpt8ZVcRSAhHf3HRg5
	EfoM9c/3hOnMWpxoaPJnNZK4V9gUiNE8npmzfR3iieRuRaQCqw0ulw+d80xM14IAS8yuJNzVr9q
	9qUues9qbIcmoHM0JEPym68kUXkYhUb5y0RVQZtweINNW/E/wsI+fTI4RPMoBagkDPqwSwm489n
	V9T1lLO3q0cNtpRcs1kK4lDV9+BpQd7/OK+qWSrYLi7epcEAJtW0rFkciWwanUrULR7aQ3c/GXA
	UYPZ9yG+hbpjYitsr+ny4RVdyLM8l+99UhIWu7OKGbm6iwvjUIp8yAulQEtXO
X-Google-Smtp-Source: AGHT+IGZX1O3gZTOoZhCoRM+zyQUph9V6W5vr3kG+gLz6Yk5WxIhEf4rxAsFu67TgAyrUJy13/AFoA==
X-Received: by 2002:a05:6000:208a:b0:3a4:dc2a:924e with SMTP id ffacd0b85a97d-3b768ecf481mr538195f8f.6.1753221415305;
        Tue, 22 Jul 2025 14:56:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25533sm14252198f8f.11.2025.07.22.14.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:56:55 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:56:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250722225653.65520fa3@pumpkin>
In-Reply-To: <20250722183853.GD2845@redhat.com>
References: <20250721130422.GA31640@redhat.com>
	<20250721192053.58843751@pumpkin>
	<20250722105034.GA2845@redhat.com>
	<0818676F-ED90-44B1-AB10-42DDB7F1B139@zytor.com>
	<20250722175807.GC2845@redhat.com>
	<548B24CC-2E58-4CC5-9025-950408BDCAA5@zytor.com>
	<20250722183853.GD2845@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 20:38:54 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/22, H. Peter Anvin wrote:
> >
> > On July 22, 2025 10:58:08 AM PDT, Oleg Nesterov <oleg@redhat.com> wrote=
: =20
> > >On 07/22, H. Peter Anvin wrote: =20
> > >>
> > >> On July 22, 2025 3:50:35 AM PDT, Oleg Nesterov <oleg@redhat.com> wro=
te: =20
> > >> >
> > >> >The generic implementation doesn't WARN... OK, I won't argue.
> > >> >How about
> > >> >
> > >> >	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > >> >	{
> > >> >		char ok =3D 0;
> > >> >		u64 q;
> > >> >
> > >> >		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
> > >> >			_ASM_EXTABLE(1b, 2b)
> > >> >			: "=3Da" (q), "+r" (ok)
> > >> >			: "a" (a), "rm" (mul), "rm" (div)
> > >> >			: "rdx");
> > >> >
> > >> >		if (ok)
> > >> >			return q;
> > >> >		BUG_ON(!div);
> > >> >		WARN_ON_ONCE(1);
> > >> >		return ~(u64)0;
> > >> >	}
> > >> >
> > >> >?
> > >> >
> > >> >Oleg. =20
> > >>
> > >> Maybe the generic version *should* warn? =20
> > >
> > >David is going to change the generic version to WARN.
> > > =20
> > >> As far as the ok output, the Right Way=E2=84=A2 to do it is with an =
asm goto instead
> > >> of a status variable; the second best tends to be to use the flags o=
utput. =20
> > >
> > >This is what I was going to do initially. But this needs
> > >CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> > >
> > >Oleg.
> > > =20
> >
> > But that's what you want to optimize for, since that is all the modern =
compilers, even if you have to have two versions as a result. =20
>=20
> Well, this 'divq' is slow anyway, I don't won't to add 2 versions.
> Can we add the optimized version later if it really makes sense?

Yes, what matters more is code size and simplicity of use (by the caller).
Zen3 has a reasonably fast divq, but you have to get to 'cannon lake' to
get an intel one that isn't near to 100 clocks.

The generic code is horrid - nearly 1000 clocks for random data running
the 32bit code on sandy bridge! (I'm not sure newer will be much better).
(And non-x86 without 'sh[rl]d' will be worse.)

I've re-written it (patches posted a few weeks back).
Sandy bridge is now (from memory) ~250 clcoks in 32bit and ~150 in 64bit,
zen5 ~80 (helped by the much faster divq used for 64/64 divide).

The killer is mispredicted branches, change the arguments so a
slightly different path is taken and it costs at least 20 clocks.

I'm timing single calls, any kind of loop trains the branch predictor
(I'm not running cold cache though).

Given those clock counts I rally wouldn't worry about a few integer
instructions in the x86_64 path.

	David

>=20
> Oleg.
>=20


