Return-Path: <linux-kernel+bounces-762885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88254B20BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBA8168476
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A524468E;
	Mon, 11 Aug 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gChytDSA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6124336B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922367; cv=none; b=GyrKMLfDEurJw0iXDwLXo1P7yxNe2ShFETCoeyRc50mKMs4A5Tc5YwK/Yq3E5ehWYgaccgmkoVJvr4xWhfRPDeUsT9jfgMNhrxOouoTq+1w+PMrLZ7063yo99ADeiaO/6zyJaAi9KiPg7bNCi4ADV8EB+v4OrxYYwjZe/MScP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922367; c=relaxed/simple;
	bh=FsHTQHcPfc/xyafo/jiO+MOWQJe03c1YlWGp/uZWzpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hg72bA3eLOztKvcmBA+BpBdkbqO+RZEUMnJhhK8w0T5c/WR9EZu4K0UNGXxdTSej9JtpH+VG2H+lJa6vGmUlzOiLO24js6m4gCPVAyB7t458PtfbCo/dPKcfPXrIXVrC1mPgXzhOWwK5pLWc7zh6J6A5FHFYRGArXsW3ZL8h3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gChytDSA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45994a72356so35133815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754922363; x=1755527163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvVQHPNPuBLFONIAghpsGXDOeOU7ltwpMqBFv5I9o+o=;
        b=gChytDSAEZYej+PNHWZMrEikTki/JuyUx2zcO4McXZe2oJSVbFBgFUMHmXui1yD4uK
         ON4fTEI7gArOQSoTIH5asQZB21+uA3Iep6mdBDOm657lL4nDdZXeOY38gDmwRslmXity
         pynkhvWukL0sJcvx1OpqzldeC14DlMAXyAQe34uEywKJLkqDCTOwT01v7IQ59835wFwn
         lOeG3PcIswsETwwaC+cLtIhUJveaBl8EpIZNf+AT8zyKwVa5vTu0mDSSe7tumeRrDUOh
         PnmOc2jwqNyXfRy3mNW5szeAKlmk7RtN88R2BlhxyOxS87yP/+oN12DDwzCkiVRiwBIl
         /U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922363; x=1755527163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvVQHPNPuBLFONIAghpsGXDOeOU7ltwpMqBFv5I9o+o=;
        b=Vkk+wPG5810270lnX0XzEkaNEc0PGGZlnTZ+7koqM6jM7ZpnKSGJ5TUOOQqzUERlBE
         ZwDQZw5CHTokTpB4hZ3IsvnyKqaC9nBFKY0x1HvZgTZ0vLqhZy7eHHJZexAz0eXjX22B
         Qk1BavsJYfHsuhUMOgazCmMGX1j8evMt2iLF/Hr5PanzonN4uGLm+qeUWGewylU+3gU5
         6KpaCdu2p6JWwrWnPM2b27OlkjPy6wT6nNlm3YnwUoEixrd0vPl+r3qBhctbVHOiXS3i
         pei5Ct9LF0kvh5W84NQdVgQ5xJl9RY/xnX7HodvUhqGRNnewXGMAodzYcAOOT/vM94w0
         tlIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfOLTfVeaBcB41tEQeoWDZCH5/yOxNBTohNp0PC6CuzSU0kRzp2E3OhTZd4ppKVGdc/oogk/3CV8Gee7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaQK2KdXcXn5Y7NvmZXkammvjDx7v6oH3RIrOlw1tRMDLk+Xz
	4adxRNuT9EUEE0pJxhiz/smiz99I9aDUnt2mb8fvlyZgLclhqSghO1nBC8fWVMYqsgxn6SHrFlt
	Fc/XXrApO3CD3rePrt4QaH8U7iIqj2pY6snmj0nJU
X-Gm-Gg: ASbGnct81kqR/fNTuJbVnlWDUZNnrsBF+IRiRM1tqUUSWy9Q4M07L9iJQ4j3MlQwnat
	o5V7FXkKP+pJ5+ISsw/GiBpdzvhKpiDAqfs1vDFr4TjxnSR38DJ7HG32ewy7UGF9pM4IfnzheFb
	QnBpAsCVHO92JSr1gVF/TqXhMuVnuNrDmTdXWtRlQC+APumMwg6xOw9j+JmQy45p95PLu8P5xJQ
	CpYsehs
X-Google-Smtp-Source: AGHT+IGCyDu4/ktjPNgn4Et50OquWgMjoD+wDy1tJFPjPT6pavqtrM7rffgXK3ocUP9k+uvfJdqmzFX00GkaLz4o37A=
X-Received: by 2002:a05:600c:3504:b0:459:dfa8:b85e with SMTP id
 5b1f17b1804b1-45a1080a071mr781745e9.0.1754922362597; Mon, 11 Aug 2025
 07:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
 <aJn2ogBSmedhpuCa@Mac.home> <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>
 <aJn9M3WPcI_ZGems@Mac.home>
In-Reply-To: <aJn9M3WPcI_ZGems@Mac.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 16:25:50 +0200
X-Gm-Features: Ac12FXwAdHcuhl4tSFWfQ1pDPx3Xe03sJ8_chcrIyexcIFZdekPm1szgSPr_PGY
Message-ID: <CAH5fLgg+1FtiHkXOzKLHFP-gRrq1Dq8yUO4RmyE7tM4aSDYioA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: irq: add &Device<Bound> argument to irq callbacks
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:24=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Aug 11, 2025 at 04:05:31PM +0200, Alice Ryhl wrote:
> > On Mon, Aug 11, 2025 at 3:56=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
> > > [...]
> > > > @@ -207,8 +207,8 @@ pub fn new<'a>(
> > > >              inner <- Devres::new(
> > > >                  request.dev,
> > > >                  try_pin_init!(RegistrationInner {
> > > > -                    // SAFETY: `this` is a valid pointer to the `R=
egistration` instance
> > > > -                    cookie: unsafe { &raw mut (*this.as_ptr()).han=
dler }.cast(),
> > > > +                    // INVARIANT: `this` is a valid pointer to the=
 `Registration` instance
> > > > +                    cookie: this.as_ptr().cast::<c_void>(),
> > >
> > > At this moment the `Regstration` is not fully initialized...
> > >
> > > >                      irq: {
> > > >                          // SAFETY:
> > > >                          // - The callbacks are valid for use with =
request_irq.
> > > > @@ -221,7 +221,7 @@ pub fn new<'a>(
> > > >                                  Some(handle_irq_callback::<T>),
> > > >                                  flags.into_inner(),
> > > >                                  name.as_char_ptr(),
> > > > -                                (&raw mut (*this.as_ptr()).handler=
).cast(),
> > > > +                                this.as_ptr().cast::<c_void>(),
> > > >                              )
> > >
> > > ... and interrupt can happen right after request_irq() ...
> > >
> > > >                          })?;
> > > >                          request.irq
> > > > @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>)=
 -> Result {
> > > >  ///
> > > >  /// This function should be only used as the callback in `request_=
irq`.
> > > >  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, pt=
r: *mut c_void) -> c_uint {
> > > > -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> > > > -    let handler =3D unsafe { &*(ptr as *const T) };
> > > > -    T::handle(handler) as c_uint
> > > > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Reg=
istration::new`
> > > > +    let registration =3D unsafe { &*(ptr as *const Registration<T>=
) };
> > >
> > > ... hence it's not correct to construct a reference to `Registration`
> > > here, but yes, both `handler` and the `device` part of `inner` has be=
en
> > > properly initialized. So
> > >
> > >         let registration =3D ptr.cast::<Registration<T>>();
> > >
> > >         // SAFETY: The `data` part of `Devres` is `Opaque` and here w=
e
> > >         // only access `.device()`, which has been properly initializ=
ed
> > >         // before `request_irq()`.
> > >         let device =3D unsafe { (*registration).inner.device() };
> > >
> > >         // SAFETY: The irq callback is removed before the device is
> > >         // unbound, so the fact that the irq callback is running impl=
ies
> > >         // that the device has not yet been unbound.
> > >         let device =3D unsafe { device.as_bound() };
> > >
> > >         // SAFETY: `.handler` has been properly initialized before
> > >         // `request_irq()`.
> > >         T::handle(unsafe { &(*registration).handler }, device) as c_u=
int
> > >
> > > Thoughts? Similar for the threaded one.
> >
> > This code is no different. It creates a reference to `inner` before
> > the `irq` field is written. Of course, it's also no different in that
> > since data of a `Devres` is in `Opaque`, this is not actually UB.
> >
>
> Well, I think we need at least mentioning that it's safe because we
> don't access .inner.inner here, but..
>
> > What I can offer you is to use the closure form of pin-init to call
> > request_irq after initialization has fully completed.
> >
>
> .. now you mention this, I think we can just move the `request_irq()`
> to the initializer of `_pin`:
>
> ------>8
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> index ae5d967fb9d6..3343964fc1ab 100644
> --- a/rust/kernel/irq/request.rs
> +++ b/rust/kernel/irq/request.rs
> @@ -209,26 +209,26 @@ pub fn new<'a>(
>                  try_pin_init!(RegistrationInner {
>                      // INVARIANT: `this` is a valid pointer to the `Regi=
stration` instance
>                      cookie: this.as_ptr().cast::<c_void>(),
> -                    irq: {
> -                        // SAFETY:
> -                        // - The callbacks are valid for use with reques=
t_irq.
> -                        // - If this succeeds, the slot is guaranteed to=
 be valid until the
> -                        //   destructor of Self runs, which will deregis=
ter the callbacks
> -                        //   before the memory location becomes invalid.
> -                        to_result(unsafe {
> -                            bindings::request_irq(
> -                                request.irq,
> -                                Some(handle_irq_callback::<T>),
> -                                flags.into_inner(),
> -                                name.as_char_ptr(),
> -                                this.as_ptr().cast::<c_void>(),
> -                            )
> -                        })?;
> -                        request.irq
> -                    }
> +                    irq: request.irq
>                  })
>              ),
> -            _pin: PhantomPinned,
> +            _pin: {
> +                // SAFETY:
> +                // - The callbacks are valid for use with request_irq.
> +                // - If this succeeds, the slot is guaranteed to be vali=
d until the
> +                //   destructor of Self runs, which will deregister the =
callbacks
> +                //   before the memory location becomes invalid.
> +                to_result(unsafe {
> +                    bindings::request_irq(
> +                        request.irq,
> +                        Some(handle_irq_callback::<T>),
> +                        flags.into_inner(),
> +                        name.as_char_ptr(),
> +                        this.as_ptr().cast::<c_void>(),
> +                    )
> +                })?;
> +                PhantomPinned
> +            },
>          })
>      }
>
>
> Thoughts?

That calls free_irq if request_irq fails, which is illegal.

Alice

