Return-Path: <linux-kernel+bounces-745859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7DB11FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630514E3372
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641721DE896;
	Fri, 25 Jul 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtPcc26O"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B1610FD;
	Fri, 25 Jul 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452201; cv=none; b=ZVCoGn9xukl9qDLUFB7AWpE5AgMsA++MAQfmfOZZTWm7oCZSLF7ZIxT/Zvw7npFwnUmTlHA/LHt0OXSLWjM4OU1uMmTZEXXL3EZcViorUOhGIGZVP2p2FbRNFPEkZ9hpUx7yVX3zKgRy06/tS6TSpm1slrkxIwoG7hd42ruta04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452201; c=relaxed/simple;
	bh=hJUPEK2zx1hXKo94jB5BUHOoPwRqYRSkwPZupSBzeoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzBuGJb/y6fz1jfaqvgEe2sy4+W/dezPrP6kaKBD0Gl6zPiY9+A7gPNxfPSSbG5gfiokZPM2snRpVlh2IoB+J3ODGjAw0+wJnsPRAYwoEiAon7t2NEgtX9+w8mDhkn13emu/ERb14DbfXL44WV7dM0MH9WsLDEPNu/D1T6vBc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtPcc26O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b122f2feso750375ad.0;
        Fri, 25 Jul 2025 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753452200; x=1754057000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nieleqf9mPx7yLOK4lz4iNDabvGkxJ9/pa9XnLAQ+3E=;
        b=QtPcc26Or2hSbKwjd/3lfBFWb0pbKtDjNv3Hbl2lgzoENuXs7iiJ+o2GsatjMhDZGU
         Esl5Oe6N1P99NRgY+eHeb5jFNYYqfvTSspsDDCNRBzsVB8x9pBF6HiipnJqCi3IUunAH
         Nyk5qBFh21W/wXCKPoonCU9DY4x6ATx2/g325F2sabR25o7ZY793LpqvGIMMzICJWgll
         jRef/xKfl5oh2xLZJhe7QyxE006MfFTMv8OdTKKYFG4y4NDjT2PLOC6/ASzb+pN64i9i
         cwYGBJ32JkUbUwGYs33pkTbKyELBQl7MWrebQCABhQWqo26X4ScOP8dVusbMkyuOiwgC
         TOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452200; x=1754057000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nieleqf9mPx7yLOK4lz4iNDabvGkxJ9/pa9XnLAQ+3E=;
        b=C3FuvBKKoA01wGeLnqcCucHI+6HREjdX7ksXtRnxx1fQzzZXz7eTRJG4K4ReP0PqVW
         hQtwsYkQ+GYAZv31cULr+NT3zku85rUbrXmCd5Esr7pz6WlaVd/26B1X2Nmb8536qMWO
         q8sfEUjY1JKVCxuCm6FQ1Mu/ot8z6wI1PIsTQ3rGnIrq8Hdmlcc9c9iFaUrv+RI9QzAi
         AHiTyc+oVQZdMuoHp/ubXip2y5ua6qjq1WDWxbJAA8X8G2OyKwqQNama0CLS/b89/uX0
         OkQHYV8Y5ZyCYeB4fzZhhwhO+3MMUh0O2QR97Ix+mNCiv7clcxCXFrh2E+mN7Sky4dKa
         TvAA==
X-Forwarded-Encrypted: i=1; AJvYcCVxA6MXJfTDhnFc4B0XVYp9X3R1TIx+NEJG1czFrNQSQb/e3CAV7lyl/D6k/G1SuH9YlurLL2H38PXR0VHINw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Mrn9i5by0H/MRIH4EN2jewlHOgZ+HMKM9aq6Obwx2e7Id8Yo
	w27M9csESYOoLCoXOXISvB1tCd6/w4BdB3zz5RaG2+31wwghJhmHEFJxWkvjVOAedguNzFRwiJe
	PpYbcxJSu+oWA0GhncdUJX0puGkGHfq8=
X-Gm-Gg: ASbGncvPHkDc8FCY4BVB9E6vIOY4t6F0Tg8adBC0xZ+pYpXQiZy8E+cSBuaFoe10rjw
	PrsfGfQzEkwsdYuUff1u/DkvppeOq5cE4JyQwTQi3lEOATObpT+BY+v4t1BvV63lc2JPwG30RWp
	9n8OxYsnx83G6RZ33Y+UQHaJWgHiSJE+fPRUJe6id5YYesyJ1QhTfvAMUU81PY8AGCKD8LHK4lX
	UAmBnz4ru4A008xYGA=
X-Google-Smtp-Source: AGHT+IHgRPHmlz2g/bTYb3JR5MWMVQMZd8tkkGtKLjkIew7AdGAYq0ozGJcZzY5El/rwrrFKWB0g61yvkyiPE7pE5ZU=
X-Received: by 2002:a17:903:230d:b0:23e:3164:2bf0 with SMTP id
 d9443c01a7336-23fb3171895mr12552665ad.12.1753452199511; Fri, 25 Jul 2025
 07:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717073450.15090-1-shankari.ak0208@gmail.com> <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
In-Reply-To: <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 25 Jul 2025 16:03:07 +0200
X-Gm-Features: Ac12FXyPUZ-twJaC6HOlUh9Bfp3EGb2qFo7l-odP1rQY1jgPt-zRAR6LuVQgivs
Message-ID: <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 3:02=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Can this be picked up for review? Should I be splitting each core
> kernel file into a separate patch?

It has been only a week (and we are close to the merge window, thus
maintainers are typically dealing with other things/patches):

    https://docs.kernel.org/process/submitting-patches.html#don-t-get-disco=
uraged-or-impatient

Having said that, I am not sure why this one in particular has e.g.
`opp.rs` and `devres.rs` -- those are different
entries/trees/maintainers in `MAINTAINERS`. So it would likely help to
perform a split that doesn't involve different subsystems.

By the way, if you meant to send the patches as completely independent
ones, then I would suggest avoiding the series notation (e.g. "7/7")
-- at least I see them in Lore as separate threads:

    https://lore.kernel.org/rust-for-linux/20250717073450.15090-1-shankari.=
ak0208@gmail.com/

Thanks!

Cheers,
Miguel

