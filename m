Return-Path: <linux-kernel+bounces-725780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F5B003D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141EA1C80744
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3025A2BC;
	Thu, 10 Jul 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6kWbWwh"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2D85C5E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154817; cv=none; b=WE/K3GQdvT0Tm7z0eHOK/eyvBAoIdJ+uoqTjLrbjNRXv5x94J6NE3FFbZ6JSrdUDD2zZiVM0nwAi83Ptla5HJOvREZGjfjQfd5z7qiPK2oiuAdFGG5738m6JFxMrcyXu5Cbqn1iFoQvYrYR43nvghjHgwYqFN4ABTWhWawD472E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154817; c=relaxed/simple;
	bh=L8NAxkisOrUvB5X45MszjRrn1WdpFGJZaTdDegwtsNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0PocL+3g1tLCNSAd3xVT+usHN+dg2ADDl/RAUC5wQFPSdXljGgfn4NT39yd1E0eKvq/uuZtmprqoSwgMhwD/AEp2KWpMBOAcGT92yZqKAR0nlLQe/H7JufSijWPQyp8yy4h3NLFLjLQ7t6FNCMbD+nYFGnhJAJRYZmXkd/cpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6kWbWwh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4530921461aso6646015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752154814; x=1752759614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gK8SxTWD7UWQltVg6xSQeiZZywuBSSmhBPrVCrZSpc=;
        b=J6kWbWwhktu0zn0rmqPAT+d9t4PWigrqg4hIj2hrJUjrjk7ZqZXDXHaMBOg4y8hmUo
         wn7n8hxlyD73imVFAO9m3vdk6TtMd766+zqCYYyPX5/t0TVsZLy3VQRzBD29pe/4Ibm/
         M92I/QT+pw8NZhmIknNOn1u2rYAo+8Yz0GjyfGliuTeh4IFo6+LfVgWuRuH0/3nrGGFR
         DR3bhpB52lFRSWRVUlLEd4AWzkdrvGXHaORqu0ucsX5caWKWvD2QH2w8OK5iUPZDNuK6
         YQOOWjl72+gLSg2i5NW7WNqQZR/BMgJ3YTLdynYxGMVX85awrRbsK02ioAfDCj86lqCx
         RkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154814; x=1752759614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gK8SxTWD7UWQltVg6xSQeiZZywuBSSmhBPrVCrZSpc=;
        b=qZoG08URRv3eXz7ytTFR/Mw9DQQF6Hs623umUDfxRRmPwQj2XLinFlgfmGcOzLNHhL
         GSLvtTgmzBqNFHPKuGixbbwau+D2seTuNzonY+5XZbMD1b9VKomI/fo3vJ4p0y6NuLdJ
         q9qTD90LUbZit0RMtM5xZqyQi4en3CKdw0Zba+JpwYWWgVW9M8L4xtKeFizP4+k7B8hF
         gaQe3ZIRd93YxYTS6MIG8LgpK+bIwleKSZsEiyp4J88yGUG3iPIyBYPCKIX/Q06HYgea
         2+4aeRq4yqYtyaiYtcuWOr6bgdwIpRj8+0jlTGp56B0axnrPCH4NZy9zqkQqzmAsaDds
         MA0A==
X-Forwarded-Encrypted: i=1; AJvYcCUrhm+si7Pd9GQy4Inv/pR9dncIBquskVGN7mc3iwK5w3RBr0miHtF5UpzUNaUHYvXJV28fOovrVxcQ8DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnlP+u9MtzL1ciLPxhXfnpH/3oB1Ei5ryYjFh19MvAZ8+3LNeV
	PgVNj0eecomZ28SmRahHMTUmH6xq33Cix2oTydUpa5ignsP/SxEmSw+E1pwXj9pQLmUzw4ITAtS
	JpefYQaBgs8OlBIiwsaX4HOyenLD86a2bwpHJspTj
X-Gm-Gg: ASbGncsTc7GzogTNoUZOhR1S5sSfvBflh/u++HP2qEyE8uViZTo0l58k4CJEgwm9PCI
	PfKQGXIW3Vh02pwYMjSCVhu4czvNxOR42x7MXpSZuNlTxq68+bZfOWGFKU3vHI46HcL7mhe0zR7
	SBK0QkrAiBtbnb96zSrlLF6jvBSqWss//ZptFs/0KaaRhKa983dFXwmQBLytz4NO/B4EUdkIlT7
	A==
X-Google-Smtp-Source: AGHT+IHWb1Xq0/Oarnazs9jnrq9g3D/RI7LYjXDzHlYykaJcgX83KF6n4sioYqT/vG6R3lN9oMhfwlrmUvLkIfVqi5w=
X-Received: by 2002:a05:6000:220d:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3b5e44e94damr5777078f8f.14.1752154813861; Thu, 10 Jul 2025
 06:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com>
 <20250704-topics-tyr-platform_iomem-v12-1-1d3d4bd8207d@collabora.com>
 <aGt6CZAUeuK0XnmP@google.com> <D7735793-D99E-44D4-945C-2AC0B500E1F9@collabora.com>
In-Reply-To: <D7735793-D99E-44D4-945C-2AC0B500E1F9@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Jul 2025 15:40:01 +0200
X-Gm-Features: Ac12FXx_E1R9f789vX3XKeepzt_E4gBqlYxHx9ZWW5DK1vZvG_UyCpsA_of1z9Y
Message-ID: <CAH5fLghe0-s2SQ+_cwNmagw8depC+=6kUwUm_epLFz30k9gQJw@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] rust: io: add resource abstraction
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Benno Lossin <lossin@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 3:34=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> [=E2=80=A6]
>
> >
> >> +    }
> >> +
> >> +    /// Returns the name of the resource.
> >> +    pub fn name(&self) -> &'static CStr {
> >> +        let inner =3D self.0.get();
> >> +        // SAFETY: safe as per the invariants of `Resource`
> >> +        unsafe { CStr::from_char_ptr((*inner).name) }
> >> +    }
> >> +
> >> +    /// Returns the flags associated with the resource.
> >> +    pub fn flags(&self) -> Flags {
> >> +        let inner =3D self.0.get();
> >> +        // SAFETY: safe as per the invariants of `Resource`
> >> +        let flags =3D unsafe { *inner }.flags;
> >> +
> >> +        Flags(flags)
> >> +    }
> >> +}
> >> +
> >> +// SAFETY: `Resource` only holds a pointer to a C `struct resource`, =
which is
> >> +// safe to be used from any thread.
> >> +unsafe impl Send for Resource {}
> >> +
> >> +// SAFETY: `Resource` only holds a pointer to a C `struct resource`, =
references
> >> +// to which are safe to be used from any thread.
> >> +unsafe impl Sync for Resource {}
> >> +
> >> +/// Resource flags as stored in the C `struct resource::flags` field.
> >> +///
> >> +/// They can be combined with the operators `|`, `&`, and `!`.
> >> +///
> >> +/// Values can be used from the [`flags`] module.
> >> +#[derive(Clone, Copy, PartialEq)]
> >> +pub struct Flags(usize);
> >
> > Based on usage it looks like the correct type is c_int?
>
> Shouldn=E2=80=99t this be c_ulong because of:
>
> #[repr(C)]
> #[derive(Copy, Clone)]
> pub struct resource {
>     pub start: resource_size_t,
>     pub end: resource_size_t,
>     pub name: *const ffi::c_char,
>     pub flags: ffi::c_ulong, <=E2=80=94=E2=80=94
>
> In any case, we will have to cast this because __request_region
> expects c_int.

I saw that you called a C function that expects an int, so that's why
I suggested c_int. It sounds like the cast from int to long happens in
C code.

Alice

