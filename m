Return-Path: <linux-kernel+bounces-772541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3983FB293E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D17B486C9C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85429D28D;
	Sun, 17 Aug 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cSU6mYZh"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B911F1538
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444987; cv=none; b=dyF0ytnEswDGJMKhjS8FT0MCTGQ7FfGeJ6flkTl+NU7ktTJSWedfqwkqIQiN+0XtKuQt7wHiua8JmjGhzik6nscOHP2TFpGf3sEZX3H1zYcsC1VHXovTqziJnBEUf4AfL1HgOkZO5Fe32iEik+XduOkTLhrDwKDvKtdw70sSh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444987; c=relaxed/simple;
	bh=8zIH/Vxiw6+4KJA8zM1NgdPLSuYjydXDROzPgQyncUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxc0g8im8fpxE+Xe9HVoeoCVPLZ7/t7usCmS7rAzyTnuwOZrHSlkderkvfBpzlEohOtRlWSn6weZrFizI4k4eKe+DSPgzWfSmUEsaay09UOpZ7cP7DiHMBcQiUS/Wqh/Jy1TYQCL5WvuUODddYUmBe8Bef3gdtrzCDI1QqHSy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cSU6mYZh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78ead12so484655466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755444984; x=1756049784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf4r+lmHvMNXzAtZIlS23aMvnorO7UZ/20ObTrW0tww=;
        b=cSU6mYZhtKYupGz9WomP4phEmkiJPbtuJ7dzm76Fm3/MzxrF+msOD3dFBGB2iorp07
         z6Kd3W46hn5FvVSenOt7eDQsKsHZQGnK9BC6RIXtrJYprVGbaXgZNicZOgzYjOIEBvi6
         4y69rUVeJZ19nfHmKyPLnpd4LCNDJY+GqE6bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755444984; x=1756049784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf4r+lmHvMNXzAtZIlS23aMvnorO7UZ/20ObTrW0tww=;
        b=aQK9mMDBAVARU7kKFwjIl/j1BI1+dyxXU+XSuuyxSEm85WfsIKGdeuykd6czQoVZMm
         D2bcQ43yNwMU/jGR3/8kvuL+ndax4kSHhirnbfUGj6hWGCN1uZMCT+i+jjlIRS9w2V8q
         uph5qr1DmzU5U3p2M1FOdmuzS1RUPFFxc/VuLkhJlqvpgnAdEqzIgXMDDI96sBFjaCs9
         VoDVITtcNMO77N6L9BEvlbikiAf4mvbsBK1NZlp1P/cqFylzC/eKLJ3XhF26PxRlngc6
         NPv76poSdGd+r7wVZdNcmX8f36kYJplFY7ZeFkE/Az/j99E9eeinS686n43bxb69jrq1
         TE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNGmC6OTJQYEbnYXXmMV4UQZyZu7Xsmeo+CE7MDhZA2qMB2k4XUq009PLp395hUQmg5eFkcdKVn/xoY4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2kQHMw4uu99g233j2l7p0kYzro1t+8jj2kpFGP0Dh/wAdtgS
	Fwn8Dy+dVigeS7CtqXVe2LnN5k/i+Nc2Pero9VSEzEKPGuwbKjyKlmQ9S57ZWpex6OVn4qXqxn5
	x+A1tH80=
X-Gm-Gg: ASbGncslfKDXoLFXjqFFcmfgOZuLEA5/NGX62xsXhyuijOHt0W+l7Bzt2PVBofG6B6E
	WKzJ/dq5dMUp2YQeTfi2PkVGJ94qP3HGW/NSoZllVjuElhdGc90ykgHFzrlaFUSTfm/T+wFP8F1
	sVAnoTCXNsnah/UixgkdmxqD+EYHqnni8X6nBTM/CA/m0RwLIq8Zl73lRHPgmzBHgn7JcD643L0
	NLUe81uysHlHDJ7eqHefF50p6/IylkDNut1Pe5TINxzsXJxX8JFADJ3zNnZETmQ9g86uwIJMbag
	boBPw9n++bmO87TSmMcu97Ng/zjzYKlGiz4vM63Jtvoka/K4pFShJwVsaYD3rJnGa9EzWXjZy7m
	nf+zOW7RAOhCQE1fdnskmO39FqZp7EyBFPB5MgcRFR1kUf2d0vCYk/JLkCymNClDG4FPt4BM99k
	ZZ8IOZi00=
X-Google-Smtp-Source: AGHT+IGef29qk8o321rL28ohNvDhfQ+pxRlyTC1IBpRn6hwS/svceUgzzQmlmKIsdBcxww9C3engAQ==
X-Received: by 2002:a17:907:94cc:b0:afa:1d17:b5c5 with SMTP id a640c23a62f3a-afcdc08301fmr610456466b.19.1755444983654;
        Sun, 17 Aug 2025 08:36:23 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccbb7sm619447366b.79.2025.08.17.08.36.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 08:36:22 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b5f620dso3643029a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXteUaeKmK+FUmfkAct0BrsHKghoNrJ6jJivAtoaaTCzVTRvge1xnYVkSe4m/4h7tYIfgsRCgIhXWhjUFY=@vger.kernel.org
X-Received: by 2002:a05:6402:42c6:b0:618:1cd9:4af2 with SMTP id
 4fb4d7f45d1cf-618b054b7b9mr8315276a12.22.1755444982424; Sun, 17 Aug 2025
 08:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
 <CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com> <20250817162945.64c943e1@pumpkin>
In-Reply-To: <20250817162945.64c943e1@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Aug 2025 08:36:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpAJiSSU-pVr297PX5kax_VvftXhDaKSrx8mpPxyfHRg@mail.gmail.com>
X-Gm-Features: Ac12FXw9gByTZpcG1G0n1kBC-N-MQtnZ68IaWz9cANis1ZGolEBil5sRRGcnMw4
Message-ID: <CAHk-=wgpAJiSSU-pVr297PX5kax_VvftXhDaKSrx8mpPxyfHRg@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Aug 2025 at 08:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just requiring the caller pass &user_ptr would make it more obvious.
> The generated code (with 'src' -> *&src) will be the same.

I personally absolutely detest passing pointers in and then hoping the
compiler will fix it up and not make the assembler do the stupid thing
that the source code does.

That's actually true in general - I strive to make the source code and
the generated code line up fairly closely, rather than "compilers fix
up the mistakes in the source code".

> > We've done this before, and I have done it myself. The classic example
> > is the whole "do_div()" macro that everybody hated because it did
> > exactly the same thing
>
> Divide is (well was, I think my zen5 has a fast divide) also slow enough that
> I doubt it would have mattered.

It mattered for code generation quality and smaller simpler code to look at.

I still look at the generated asm (not for do_div(), but other
things), and having compiler-generated code that makes sense and
matches the source is a big plus in my book.

                 Linus

