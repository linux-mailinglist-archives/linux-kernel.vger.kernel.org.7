Return-Path: <linux-kernel+bounces-738298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3991B0B6E2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E65188F050
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DA218E9F;
	Sun, 20 Jul 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFaQogdf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0487D1F1306;
	Sun, 20 Jul 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753028661; cv=none; b=cfMkpwk7lp094kQRrTFoAqxF5mbSTeLFfrxnJc5KGghGd5dlwFcoKT2gK+W8vhd8gO/LZnDlAW2R3K46/4MV5UHwX7JqhVH/pFu7SNRsWHf1IkR8tcn3ADZ5ZGmHZxUdVDR7S7RdrWk441XBtGABUc0yv3umXGPQzyqxpxQ3kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753028661; c=relaxed/simple;
	bh=xrgoPjiUvoGsWpHb+BOGNOR5oviZKRrJauq/+EmDIpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueViCzfdjpcNFGJqYKkoLJqJmOdUrMDvvU6EQo6187FO53/WX7DxMXl0hZIGR+7W6K9WBtRQ/nQtwcrqZKHB6afmDowDqPCAYZdYoDbpzn9KHjFlxvBz57G4eILjFkAFTO4NYaRA7n/mdS5q2KaVWM3Kr4iPN1CUmjk4GPKJGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFaQogdf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso617680966b.0;
        Sun, 20 Jul 2025 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753028657; x=1753633457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrgoPjiUvoGsWpHb+BOGNOR5oviZKRrJauq/+EmDIpU=;
        b=jFaQogdfhR3mJKznberOuP0jZ6ylxEepxYBlJhs65mmKuSFPRcATqqwm2YXmJV1M2S
         hRQO7X/WkIf05Xk9k+mLxe8L3QUZJlG0o3f4ERPfRKBjUKHcOL5xcXtbpSVpgWgY0dr6
         3MSRSLIzRwYutd867NOBH25rBJ/mgEfkiTmwnFZfFJKBO2vlFhtkAGSSLuxtjafrtKvb
         POAX9j/aj+rKANeXQnFjKkbqE+KZMUjMBrtx2sPKSa+K4LwKk2V8YatHwpVvwggUNsHl
         pnuKGYfunGLeq9dLhbeHrpjXqbb3cknq6Qlhpf5dkkJB0kzlIU+aq547YiaVCenBi0DZ
         2fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753028657; x=1753633457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrgoPjiUvoGsWpHb+BOGNOR5oviZKRrJauq/+EmDIpU=;
        b=iWoS2mGxSg8Ca9xugwZSs7GiKuYQRb9Tj64Q/D/vqnPeCeUl4yCLaR8nNYJQkHzu8V
         0Uhxr2rVlttZSAfz9W7sI4CJI/Pa3Xo0xVRoHLog5gmjt+HyBtsiyhKKsL4qmJsZ/6JG
         DusuV6A8x1m44ow0UqYYMN2+b3vF/6JRabD4/KtD089NR6CsZNCxmuqiSu3yS2VNkXo4
         wrpfi+D0IRIcGJ27Vgjea1HiwiUlAGGDlFFGvDW7BXN70lyyUNPkHu4WrdEiMUDmCY+U
         s+WIOFQQIfrnMzre6ha/nxuTp3wDvjuYCP6uLMmAjvNExpM64P/Z5w/PPqbtnEZrAEX2
         D/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSN0lb4NyPDT2ve4HiZiwWsNbhIECnmGiFKKtBmA1pxmEIdKuQpfzPkg5p022/bHhR4bOfkXMjZco0MFW+UVI=@vger.kernel.org, AJvYcCXeYgo98HRZwr5H3J2qTDI/5cBwebogqTCDD2JsVV+oAO4FBNx6CxgHuEv6olVzdPpNbf30FYJGfBUyKg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvuPruiKmWZCjPPBsgPpyo7ztYQWr7R7mri9J+Y+89Kp+YjCY
	gK1lyYJfnaqZQ75FjMcftOkFbqdzEEr5wq3awTiGxzrtco03PXG96IxOHeXFAsgbWoxKxi6aOsj
	2sQ6JvUmx8gXobbyu4c6LgTuRl2UcEVLwW7frQlFOfvZX
X-Gm-Gg: ASbGncv3wJohfWEO6vlyPfAAnF935Wn4WkG5dl9Rh/SkSema95FE4CGcc7Xu7unk3Yt
	JX41Y6sC0mx6gc0B//JBEKmqfJ7t0Ijrz/dHENexFNQDsM7EbbVTtKXmpWkcllXK/2ep/YDZTAS
	NpycVIXweAcvhNwjIpigNu2zHxCrXLR4Z0GVZDZG66RGE1uIs5sWSWjTo1xHxLZZ9dfCq1rwlvu
	gpsYlr2LAUQjBtZTT2RdVBKEtpbtwRFiQ44kCY73w==
X-Google-Smtp-Source: AGHT+IF9OZggaULTg8FfoSWlCNKAT23TTVHE8vbOTTQlH21PwwN7RblgGNlIyPQqHzNjHk5zJzm3pQBnKCV0x7I+6EU=
X-Received: by 2002:a17:906:ef03:b0:ae3:cd73:efde with SMTP id
 a640c23a62f3a-aec6a623802mr900514766b.44.1753028657008; Sun, 20 Jul 2025
 09:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629024310.97937-1-contact@antoniohickey.com>
 <20250629024310.97937-2-contact@antoniohickey.com> <CAJ-ks9m45p9FHCvbuOS0zJvZfHMcXOLvN+rfjQfyNTHzDovspA@mail.gmail.com>
 <20250720161733.364025-1-contact@antoniohickey.com>
In-Reply-To: <20250720161733.364025-1-contact@antoniohickey.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 20 Jul 2025 12:23:40 -0400
X-Gm-Features: Ac12FXzHEygNZnrfZTaS7xmFgh6Il2UusGUfrBxMduT6AaUubRMUt0BZQTW2WwA
Message-ID: <CAJ-ks9mXgEsZbm9yyBBj-z_nYtxB1BcCpEToj5rQp+G1Nmdiag@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: kernel: create `overflow_assert!` macro
To: Antonio Hickey <contact@antoniohickey.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, 
	danielstonecote@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	lossin@kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 12:17=E2=80=AFPM Antonio Hickey
<contact@antoniohickey.com> wrote:
>
> Tamir Duberstein wrote:
> > On Sat, Jun 28, 2025 at 10:43=E2=80=AFPM Antonio Hickey
> > <contact@antoniohickey.com> wrote:
> > > +//! Overflow assertion.
> > > +
> > > +/// Verifies at runtime that an expression is within an expected bou=
nd.
> >
> > This is a strange comment, imo. The only thing special about this
> > macro relative to a plain `assert` is that it disabled when
> > CONFIG_RUST_OVERFLOW_CHECKS=3Dn.
>
> Special yes, but it also documents the intent of the `assert`.
> I did include a comment about the conditional behaviour with
> CONFIG_RUST_OVERFLOW_CHECKS being enabled/disabled.
>
> I'm open to rewording this doc comment to be better though.
> I should also add information about the optional panic message
> like the `static_assert` does as well, what about something like:
>
> ```
> /// Overflow assertion.
> ///
> /// Runtime assertion that an expression is within an expected bounds.

I still disprefer this phrasing because there's nothing stopping
someone from writing

overflow_assert!(sky_is_blue());

In other words the type of the expression is bool while the comment
implies that the type of the expression is numeric.

> ///
> /// This macro is only enabled when `CONFIG_RUST_OVERFLOW_CHECKS` is true=
.
> ///
> /// An optional panic message can be supplied after the expression.
> /// Currently only a string literal without formatting is supported
> /// due to constness limitations of the [`assert!`] macro.

I don't think this is correct; in a non-const context you could use
formatting with this macro, no? IMO the doc comment on `debug_assert`
is good to use as a guide here.

https://doc.rust-lang.org/stable/std/macro.debug_assert.html

Consider also using the same implementation as that macro; there's no
need to separate `cond` from the other arguments.

> ```
>
> Thanks
>
> >
> > > +///
> > > +/// This macro is only active when `CONFIG_RUST_OVERFLOW_CHECKS` is =
enabled.
>

