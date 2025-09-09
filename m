Return-Path: <linux-kernel+bounces-808741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F25B5042C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF617B01B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A13431EC;
	Tue,  9 Sep 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQHgqusb"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA735E4E0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437941; cv=none; b=eUWwpAkm/zlSoUmXhPPI3H7RkOnMZmA9sij8VuJqeCA0ZomBTWn1dcvXNOkWPhTQ6s3VneCDtBzZlInfxaGUeIsqCEj/ROqTjUOwOU3vr7MejJb56dBHZCCd3ToUde123k84f8KcqWX0ZbmHiGAQ6M631gDPXlPMeNuuB/nJZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437941; c=relaxed/simple;
	bh=pZl9KmUTOudQy15/vr3pLhP7rnPAj40pW4802s5NWJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQWcaFZq49KiyeBJ7buwNkGcZaeAXYLASdLpSXB2/GucfX59e78Z/mqoFG64wL5Sfjg7dtvlvwO5KMbvp5f/q6szTwWVxea3GeItSV9gaxtfv8TMuQeBHdxipqApj5vtggabufp+fyuB8brhGCafDu6FCscftpWZWT4WMenjoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQHgqusb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b522e2866bcso218000a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757437939; x=1758042739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZl9KmUTOudQy15/vr3pLhP7rnPAj40pW4802s5NWJg=;
        b=RQHgqusb43uEsiz/Qq24KeTT+MdFr5ccsOa9UTnWOOLEk8F3LVY2TglbSVdpWqvVWl
         NtfHKVZAs/i/OZDclB+jYnRKTuHEN82chf6QE/eOpdGIDn8u0QqhGXuwG8aBA4Okj95P
         zdG72TH6jETBVDLZ6tZzWKYSGL5+m23FW3FavHe/pSLojZiEilhaotgrP4RszInAB9gg
         CCFlud/LUeIiJ1owocLE2Qib3QaOlGKYEYyk6+vDYrz5LB0+6CsiPZa7xZqvvibQScbr
         Yd8qOrmIUhXp2s22rez+UIMXsixe/nrp119PbSIjktxN2lyU6qKDMo2M33HI+1B/lHyA
         Fi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437939; x=1758042739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZl9KmUTOudQy15/vr3pLhP7rnPAj40pW4802s5NWJg=;
        b=NxF0kmjcJLoI5o9wXY5IAPTeQ2mgIY9ztvluulSJsr0nbCgsmnKxtBdMmVn59aMKzg
         OxPMWFgNvTKsNbE3MDoFgFYXJtfRecJJSkuSdT5cI8mJXOm/4s1oodwSM+TaS+PbGfvM
         LzGJ+DrEARwmlxiHCDocoI4fs7+WTiIET1l+nTeT/rpsPoUCsFaRuaQ+qxWYbveQV24U
         XRiYSEpU7ZUihS20s0iwKNrUB7mpEgiiG2LQu4qiMXQkQghuC7wyAcp/kHgqlffyKbo8
         p4U/uul8AslttUxLIOkJ1xygI3StrOIxjboFPx4DkJrCAtjxhirhHv+1nuang+ezmEgZ
         cwIw==
X-Forwarded-Encrypted: i=1; AJvYcCXXo8ViUMYug2DKYWy8TGmK95k/vMwGKd6lDKmVfa/vqtT1DZtp4rq4yTT9bfFnx8lm2wlGIkK1LUvHygY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1rLjOLK0FJ3XpmlQ9x5rCi9E1v3I/5V5v+E7poenUSJPIsBs
	8p8pXqeXPRf6MEvO52SY4gyoHDazViX34wifyMLPUxQwtZu6kQhsvR4cNg+Uu+8Zv9yTTzjtZ0f
	On1N0CzaRrjKPGKRiRNGGdk0X6r7Pd6E=
X-Gm-Gg: ASbGnctTe5S4OxyprkLTp8RVPgUYalMHBNwN42Vq/KZ46iwwbIGfnaQP7HqNH+uU2BM
	8D7V0sMF0OMIrXBMQvKWNljM+c8W6pWRFB3moAWNCe4h9nqRX09aDMPtUtYcfHOASA1eJlOkw2y
	+d1Lz0UIm8rEXfCjz6Mb5doffXhK3NBMrjp/MXXTPQ4okf05RSteG8wz96j5zIj+7L0AeoRINy/
	651uF3oBDeMlngKxuXVp9ZBEEA4Tg7xrZTFH7kWoepuFA/poU30mjvKMRGBnBBPyM22GZ52dgdK
	Tpn9w/56ixSgLVfyUrpQ+6E8bA==
X-Google-Smtp-Source: AGHT+IHd4zHzKJHiSaDYt+fas3wn4v2M9LloxztcReggEbdZvs7nvGHlisZ6Va1BAVyt7RDoMvRIKgyRryjYrTxDWWk=
X-Received: by 2002:a17:903:1cc:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-251771d5b61mr95742675ad.11.1757437939384; Tue, 09 Sep 2025
 10:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-gcc-rust-v2-v2-1-35e086b1b255@gmail.com>
In-Reply-To: <20250909-gcc-rust-v2-v2-1-35e086b1b255@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 19:12:06 +0200
X-Gm-Features: AS18NWAUC9KOXLRVuptzGWpY6jU98Yraxc-lyvHQvj-0Ea4KpP1HNw-UevG-aP8
Message-ID: <CANiq72kZAeVjPF_O+o9zy=1-wh+6nUiW26_ngqf8unNi4twMCA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: re-enable gcc + rust builds
To: Asuna Yang <spriteovo@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Han Gao <rabenda.cn@gmail.com>, Conor Dooley <conor@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 6:55=E2=80=AFPM Asuna Yang <spriteovo@gmail.com> wro=
te:
>
> The separation of get-rust-bindgen-libclang script is reverted based on t=
he
> concerns raised by Miguel. However, it's worth noting that we now have 3
> different places rust/Makefile scripts/{Kconfig.include,rust_is_avilable.=
sh}
> where manually calling bindgen rust_is_available_bindgen_libclang.h + sed=
 to get
> the version of libclang, and in particular, for our newly added Kconfig s=
ymbol,
> we now use awk to canonicalize the version to an integer. I would still l=
ike to
> do the script separation later for better maintainability and readability=
 if
> possible, which can be discussed further later when Miguel has time.

To clarify, since this probably targets the next cycle, there is time
to discuss and get feedback to do whatever we feel it is best
(personally, I can take a look after Kangrejos at some point). Is
there a particular rush for this?

Having said that, this v2 looks substantially simpler than v1, which
is nice, and perhaps RISC-V wants to land it already. Up to them in
that case.

(I see the `ifeq ($(BINDGEN_TARGET),)` is still there -- in general I
would suggest splitting things if they don't depend on each other, but
it is not a huge deal. I would also probably have split the
`rustc-bindgen-libclang-version` into its own, but at least that is a
dependency).

Thanks!

Cheers,
Miguel

