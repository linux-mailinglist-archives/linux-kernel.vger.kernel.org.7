Return-Path: <linux-kernel+bounces-882061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944EC29869
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3518F344813
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ACD9460;
	Sun,  2 Nov 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9oUVqV7"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC41DE8AF
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122052; cv=none; b=nwflfIlM02SnxVQ98knlaghh9XjoMi706+IdN19qYPtOkkWAcAdWfcdG/qikh/XlUQDGtD6s5jAPPKqFEslp68HawqX4dT9ALbg5XNbNMukoRgVpl3cSaylDMZsgVfU45n+8J0LyZUlWheuSNB+ZNY8vc8/aHsKpEF2ppp+sh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122052; c=relaxed/simple;
	bh=WT7V+mIh7biSb9hoQQKTPcN5LrBBwROnmw3huldzWHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vvn6a3QlyWJTtN+Omov2LogrRJckQCGWAN74N1sRqCaMOZtNN8LlSZQj8yxfDXPyXytxUeTQ8x4a2jsMHC5Upn63PKkN5n68chGT4fsataUdCWzVUms3rLnjU+LUkEY0ok4RgVzDZq2Jrlpjx2iivEFYy1FrBlzL0qCXDfVah6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9oUVqV7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33257e0fb88so596846a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762122051; x=1762726851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldh/rrZAKoIw8nkk3grHKnCTpuj+wVkO9BtM8FlPSJs=;
        b=X9oUVqV7P1rOUBrqf086oFJ51nz318w3F3ADuNBXg/gWop7pmvDi34Sq9j/PWbDrmx
         cgRUQD0YzJNi13LkMEYb++llpAt0BteLJpoyTbHfeABNE3AyFMPjkJG1rbI06lxkniZP
         NgSnoKp6tLGjLAL2Q0MVtOZKacBQwyXZriOu6K5fqSdtW1GlAVJQiwgHYJ0gM19XOnW0
         qDZutohzS7lzLziaPN0GCwRN8Mh2/Obky1ZNSOL5c+U10tAQTs3D28oeShHE4N9qY1E9
         /KOfiDqtCyZk+Ko8JMN0QEuCCUnYnFMfCDTueaZxkvUrdMKltok28ktEbeLYXnNwOIlR
         e7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762122051; x=1762726851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldh/rrZAKoIw8nkk3grHKnCTpuj+wVkO9BtM8FlPSJs=;
        b=B/MQvdM5O8I/YaPWVgKUMx41c+WafBKGWnSgS1O34gNkYz8R233J6BesO2ngnKXqvZ
         JvbjMgaBRVn8CqsFMWnUGR/pknTOy7KgW0MyvHKi0ek20almDPYBOenr80I2ZEdIkPMZ
         XntWXClrQ1BXM4EoE0OV92anBpMhc4Zn/X/DbIYo1cYB+zWrao4laXuaIREq2C0iRu9x
         4/gu4Ke7bYjryntpQtINbrzGDZQgTpHL+hMO23MqZqDneyBot7PuO6ogI6bZYK3uHJJp
         Xbhoy+3Z4lRwOGLbs6mT6loH5Tu7iGKumHjEM23gSA0zuWNT8b74UycwKeqXACa14PVs
         JTlw==
X-Forwarded-Encrypted: i=1; AJvYcCWdEBJyX/JBIhght4j2jpVepgubl/GJBIZUQNdOJFfq1QdU6pREroP3K84ZOND36jGhlbpYcf8me1CSiDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbKAJKxRIiWtBF+sRDRJGuQArhmMfuyql8oy9S/r84sc8SGjm
	fxHIxtfWEVf3Up5WOgR+2Msrq0pZ/qYltng1Mwc2aKsQsAtUJEpjhjg6bQ4B1N0k24MsQTHH/BR
	TMjJa3Beku+g0UkOa9DDCowmwiRhpLBA=
X-Gm-Gg: ASbGnctpJu4cnGHGJdJt+gnDmoqQn/kl2FxRoccghLzG3mG2EnRGxyeFDSYx6ELpFcT
	/EkJWFhhxBRFSztnkxOcXntcKoZckxOOEiNPb4XxslxoiZs4CH1ZJuURrARUCSWOZ4zfqzfmGtS
	aBU1zYupxXMc4UPmFPGJS0r637ZrPRev2eqW2Gi/SQlwVWJoLEsJWNzAHqduwePPLRnZeixzveY
	ShFx6vwd8My+P16hGNn3E+7Rw5REQPHXEygUYanrABA/6HtFfQQS9FVvEfK1chnC7Vy4UbB4upY
	n6K3Cz107UUFhNoI/alcG/ieO2k3+P8vP1Dpi3Lf/hyeJ7Zq6/qU+0wID0/4k3LJvpPETQHZ59N
	6BBM=
X-Google-Smtp-Source: AGHT+IHryhoTOrFuU+nX2/XXVf7kh67HIj6pJAwGZM07cNYk4Ch5KXgJowgB3YhvDy4LBmrqXMtVIjcCmU0HL6FeUno=
X-Received: by 2002:a17:903:188f:b0:27a:186f:53ec with SMTP id
 d9443c01a7336-2951a4da98fmr50067215ad.9.1762122050659; Sun, 02 Nov 2025
 14:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029071406.324511-1-ojeda@kernel.org>
In-Reply-To: <20251029071406.324511-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Nov 2025 23:20:38 +0100
X-Gm-Features: AWmQ_bmo-1G4gStAz5BNMs8sUlqk3doCuOqq-d5OyHMqc8oaNkX_-Dz-ZcwIf5I
Message-ID: <CANiq72k-7f91kNrAAnwFoRYyFYjRB+mo3PCRFzTkn7E-7xrCNw@mail.gmail.com>
Subject: Re: [PATCH] rust: devres: fix private intra-doc link
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:15=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The future move of pin-init to `syn` uncovers the following private
> intra-doc link:
>
>     error: public documentation for `Devres` links to private item `Self:=
:inner`
>        --> rust/kernel/devres.rs:106:7
>         |
>     106 | /// [`Self::inner`] is guaranteed to be initialized and is alwa=
ys accessed read-only.
>         |       ^^^^^^^^^^^ this item is private
>         |
>         =3D note: this link will resolve properly if you pass `--document=
-private-items`
>         =3D note: `-D rustdoc::private-intra-doc-links` implied by `-D wa=
rnings`
>         =3D help: to override `-D warnings` add `#[allow(rustdoc::private=
_intra_doc_links)]`
>
> Currently, when rendered, the link points to "nowhere" (an inexistent
> anchor for a "method").
>
> Thus fix it.
>
> Cc: stable@vger.kernel.org
> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

