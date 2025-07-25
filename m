Return-Path: <linux-kernel+bounces-745746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ED5B11DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36E8AE3772
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB92E6D12;
	Fri, 25 Jul 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOYa3t+I"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206723ABBB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443832; cv=none; b=DTgUvW0+Pyzay3rIClKdcApCV/bNdfV0RYWAs+a3cSy9y7gfnNGQrxOS9M3dGksf6QplfwChJEvyQnsGOVApnsdI1leGKJymm7mS/u5RhwZBHyj50laUb2CakO2UPfkBhezZYjrPEiZyDqOICyhbqdMw7YiciHo0SMCQ2Vtttrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443832; c=relaxed/simple;
	bh=SX27gt8WGyTc//pddi/5lVAJTYadDFPS22964W7q9kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMWepFT6DDce7Iq4JAGq1bVxR16PJC7Y9Yn6/8lbVX8JQnVNVAWmhOdVrTf726Oy8QduEfvnublvtjrgbteceswUFSfJIB9pOiej9bGbwDMxb1V0zr06orKnV2oEDRsa1sA1zAyCQ6DC3wyp5J8OfF5dkz5fic2ChEL8buNqpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOYa3t+I; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so17677491fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753443829; x=1754048629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX27gt8WGyTc//pddi/5lVAJTYadDFPS22964W7q9kc=;
        b=nOYa3t+I2/9mbsdf6n9iNGytmhggnMr/+rbnJIi5Y2QnimdgQKv9xAzWtwB+8G0yVg
         K9SziVUE7NYAQsdIuL2iSXvZJ4oWiIaWZ/J+rWq7kUIvo9h7NHlm6N6PyZkiS+bB3v6t
         nhtZpSKOWY6H/pPr+rKIty+wTkLqQTwTcLmhWfYf1+wyc5I8y61eX+sAKKNi0/mAKX0k
         igxOtmzZVlMYwSFetlBKEimliHMpteT/yP1pFknMgfe5xZp1K/9ngC+6vBtIThsUp9RU
         ZfzhvkN1picaAPk6pnViH48jAx59KWwnk5N7Nrbrt4IcfjpsLmR3VNn3vOWJ36oAvCkv
         4jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753443829; x=1754048629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX27gt8WGyTc//pddi/5lVAJTYadDFPS22964W7q9kc=;
        b=Ly9FVM8bnfsvKX5eevo2hUqSmJZlzKZBvyH4K2IYBLzFio0xmIzcwsAMtMywcyLK4e
         TFW8Oi1zv0nc1NEpnnWhPwSk8m3hqUxUS+P8iCaKm42XjpEvvfh3G33p3f/fU7itwGYg
         5/Nb47kuUXXL70rHdOvuNkusk+dejaPr7qhrdl/GlXvd33NtILr1if+MDd3Nk93DTNlQ
         7abqurSXxowU7tkQtrX1Ywc1HmKe+eSy6c7yydtzaMy4a5xFBLPAcUy+TPHZZgwLn6wB
         uC/mxxq6WjH/+TzysRviYvoV4TEqUMqJ0cImLvVIZqz89xM31IlW7sbAq9x8DwEb81mx
         oILA==
X-Forwarded-Encrypted: i=1; AJvYcCUoCMJC7yuwTA7Er6ckPVfaxrCqJ0ogqtl5wJ8kcglNDQb14Seu2VdoYeoKhZyBF0VJ7hc3ydN5IquE0hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyvG8W4QrV8dbjckuFhUZQqVlquHA10MuvDfdlSo0VZSTvZ5g
	pD1GDeL6ILvcJokMwhLyuxX5sWK5f+Myh5pp1rZSiWsA7/EmsdihEyt/RCX3o/xW1yIvqxFBLzl
	+PQEIWMCVpkckyYfvWikO3f62Ykm4WJE=
X-Gm-Gg: ASbGncsu0N12P1tB+K/Z7WVIKgjKk9SDgv+QQ707PM3mZXz6fi4wQa8qEFyzKT273c4
	fx9WDwSLVCje54XlQohOdUxXtWeBrfDhdw7Ft9ZejqaWjtIO2FEvCGL010P0myhb5vkwKtzPfsU
	fFEJvINPoUoSzuBByF2t1UJj6u9wtW8TOdyMt9Wabj3ibB/HTYjOrtkGbZjp0zONctDd/GDytBI
	K5UJXF2DKXt6gQfrREL97ExKvckBB633kg7wfG9Vg==
X-Google-Smtp-Source: AGHT+IF/uTq5VolVx8xgOwqCd67q1dDNjXpPQtZ/butMWQ8g+APYueKGfVZvFlHLNNPJ4DrX+vkmJhbG0cC9gN2MfJo=
X-Received: by 2002:a2e:a90c:0:b0:32f:1df5:aca1 with SMTP id
 38308e7fff4ca-331ee7c68a3mr4979891fa.22.1753443828658; Fri, 25 Jul 2025
 04:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607064444.4310-1-pranav.tyagi03@gmail.com>
 <87cybdp7to.ffs@tglx> <CAH4c4jLjSBxbd3bqkdgcCSWqXURratANgnbq9negrSU283xHpg@mail.gmail.com>
 <87frg3ss9s.ffs@tglx> <CAH4c4j+P2MJWZWv6M2s+wOdfCF6q6Wyq3=VsB=uNCtEH1LMp-g@mail.gmail.com>
 <202507241036.20E180AAA7@keescook>
In-Reply-To: <202507241036.20E180AAA7@keescook>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 25 Jul 2025 17:13:37 +0530
X-Gm-Features: Ac12FXwLzkH5UZuvU38crMxGk5nW6M3q3H-vJxGUPtSXw36fA455ThldReWsSs4
Message-ID: <CAH4c4jK45KVB7Zg_-xk6zYDgS16yq4Zrzvg1dTGxTaVQTMF=bg@mail.gmail.com>
Subject: Re: [PATCH] futex: don't leak robust_list pointer on exec race
To: Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	linux-kernel@vger.kernel.org, jann@thejh.net, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:07=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Jun 18, 2025 at 11:50:31AM +0530, Pranav Tyagi wrote:
> > I hope this explains the consequences of the race condition. If it is f=
ine,
> > I'll add it to changelog when I resubmit with the helper function.
>
> Thanks for working on this! Are you still planning to send a v2 of this
> patch? It'd be lovely to make progress on closing out all the items in
> https://github.com/KSPP/linux/issues/119
> :)
>
> -Kees
>
> --
> Kees Cook

Hi Kees,

I will definitely send a v2 of this patch and would like to work on all
of the issues listed on https://github.com/KSPP/linux/issues/119,
as it presents me with a great learning opportunity.

Regards
Pranav Tyagi

