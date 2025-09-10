Return-Path: <linux-kernel+bounces-810116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51220B5161E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A001C200D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44A30E0D9;
	Wed, 10 Sep 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeDAY/M6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE072877DC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505150; cv=none; b=orRGBokVmKnHen1v5InMEO4Et1/HIp6FQi8u9fbxD2fI9aohHGGiA3FpN7CL1keBcfQml2kYokIMRn4+1rSx4uUb+7ByyxpJ6XFRb182Wblog5UdgJ1KGKu1eCs+dcxwbdA7Rm2xOApFff0RAk4f+zuq2v1KVtbW9okQ9UwN2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505150; c=relaxed/simple;
	bh=e4bdA9laZbM3EfcZ0X9/imMIUb2Gb39r21T9GFYy+58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZExV/KO1q6GJXtVBRkPrf105SJ17Px9wIXZx65iyRdVu5a7VERN2yGp1TXTjA7WaQEAb6eGn9UaL6tCj0sTo2Nf+zY1vA4i7Mf7FzRNJMlfduNUSCkyyqs0RJ7SAaAyhO/y0Z4hEw1aScawngL2o0FJFbJtIsDzHNSzcPgrExLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeDAY/M6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de56a042dso23746635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757505147; x=1758109947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U46X76YKHn1BRClXohd2pCqWqgDo3sVqrrD/BOqtq6c=;
        b=CeDAY/M6L9S82earBtraBVwXVIsIAoqdZV6FeAewZAILRKNLIJmeMdxqH3nVMsSQVr
         FmIA+FIA6ktCxrRbptJhEKLgMV+gTxnL5DKC1rWcuskHbEciiVw93XmZSgxtdemTR4/o
         JGuyAi7MNbosp0bCUJ1vEhTWUrtSWKMzW9GAOGiPTTTrzlB2cAmo11+49QEk/HtWT4WS
         oMBrR5PkouMQOnUSSnMP+M8wW0shwU2UZBJXPOo4+7GPSusdOzQpw8bM/ZPqv6O+cFA3
         OxNMU6vXp+aZ2GaU+baAwTaUTBJ9VEdS6xuKuPhF5h1y3J8n1jWzWcVZVMgUGM+hfavy
         tgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757505147; x=1758109947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U46X76YKHn1BRClXohd2pCqWqgDo3sVqrrD/BOqtq6c=;
        b=UR1+HREGEHMzy3tUsZ3E6WB6w632bZwSPP+96erBBxFljrI+Qe81vrG8ahRYc0n4QK
         okTgpOpCWNrXgsKVqw2CQc2umJdKF+TKzyydOOg9VDOvNzhyNxEmY9WBXdkRSk0NdBwA
         jXTEcbDyyERQNSkl+7PTf1NqCYHWy9px3xIYQQp8kW61ONF7YNl3Vr2igWbc1NaXm2GW
         WnknI2iXSFzHgFfeSq+G2htnbEXNxNg3S4zkzuXpXBdEzh/9xgI8BX7J/w4Tq2FAv23a
         DKg4OTByKX4qPd7TT5FTpy7pCgy5zDEtQDz41u7tKgQiKGuqDHMLq9tlCD+eoNWwee55
         n91g==
X-Forwarded-Encrypted: i=1; AJvYcCWlkFfI7T+UdYksv3yl2Algs2tjcVvqIyFzxASJrnjX7AlwcQOXr+WLQenYXchXOQxjmNvkhgt4869uNJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LDyCH5gBEE9l1vTMBEDbWAjc0MqlC2sICnWPQ9sFNdKbtC77
	t0K7F+WwlzNPUvVylvv9jiRPkSK8u3ITWYA7pAY9cm//jl95JmTh1rZzqaWGxpHWu95hV2x+nhk
	GWWneBkZIrCNOG3iUfLQJsh4Mpr10GUFK2yJqPbB7
X-Gm-Gg: ASbGncus1JrdNbAOD3FN8ZlTPBjkNgT4NPYK/zV5NIzUV0M8pjiRNfwhi+wTl014qUA
	mXsnM7sC/MIwtf5+oe6xbtZ1yL/exoXjcMq7zDHeiZVjWgYLunUs5SleRRJo4WeozQ3ys7qAV/l
	t/aDZ8LYoOunia7Tj7ZVfguIS2mS9PqfuexS17OgQtReR2wvpSPJ+2duZ6FbA+1/sqsK5SvEr7b
	r4l+30xf4JBGYGJQWUANXZxpTCNEXgKsIkUvQd14Hi+SUMjQ494WBuO/w==
X-Google-Smtp-Source: AGHT+IErhntOQVzgPns8ISGDADdpAB61F5bnMVwtgDnrhzYG8zp4IeEhc7oW9TpLnTCtbJ5aJuLv6ZOvVJkT4RdrFy8=
X-Received: by 2002:a05:6000:25c2:b0:3df:33e9:14cc with SMTP id
 ffacd0b85a97d-3e6442da8d5mr13285933f8f.54.1757505146808; Wed, 10 Sep 2025
 04:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910100755.2361281-1-lossin@kernel.org> <aMFQL-Hq1KvBG5lh@google.com>
 <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org> <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP2STI9M1XX.3RHBQDPQOC3JO@kernel.org>
In-Reply-To: <DCP2STI9M1XX.3RHBQDPQOC3JO@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 13:52:14 +0200
X-Gm-Features: AS18NWC693vUyJRrFe_67v99ngDuGtmgBjD0KGQIP9wthtOlQgbODTCOn6ws5us
Message-ID: <CAH5fLgjS+T1acN9jsEv85bhhXwevSA2trqu-9aFFsKpH82b8iA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>, 
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:15=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
> > On Wed, Sep 10, 2025 at 12:36=E2=80=AFPM Benno Lossin <lossin@kernel.or=
g> wrote:
> >>
> >> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
> >> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
> >> >> Assigning a field a value in an initializer macro can be marked wit=
h the
> >> >> `#[bind]` attribute. Doing so creates a `let` binding with the same
> >> >> name. This `let` binding has the type `Pin<&mut T>` if the field is
> >> >> structurally pinned or `&mut T` otherwise (where `T` is the type of=
 the
> >> >> field).
> >> >>
> >> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
> >> >
> >> > Is there a reason we can't apply this to all fields and avoid the
> >> > attribute?
> >>
> >> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
> >> might be surprising too, but I'm also happy with no attribute.
> >>
> >> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
> >
> > IMO the ideal is if it works without an attribute. Perhaps trying that
> > in the kernel is a reasonable experiment to find out whether that's
> > reasonable to do for the general language feature?
> >
> >> > Do we have a place that might be able to use this?
> >>
> >> I didn't find one, but Danilo plans to base some changes on top this
> >> cycle that need this.
>
> We can use it in devres right away:
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index d04e3fcebafb..97c616a1733d 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -137,10 +137,11 @@ pub fn new<'a, E>(
>      {
>          let callback =3D Self::devres_callback;
>
> -        try_pin_init!(&this in Self {
> +        try_pin_init!(Self {
>              dev: dev.into(),
>              callback,
>              // INVARIANT: `inner` is properly initialized.
> +            #[bind]
>              inner <- Opaque::pin_init(try_pin_init!(Inner {
>                      devm <- Completion::new(),
>                      revoke <- Completion::new(),
> @@ -150,8 +151,7 @@ pub fn new<'a, E>(
>              //
>              // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
>              _add_action: {
> -                // SAFETY: `this` is a valid pointer to uninitialized me=
mory.
> -                let inner =3D unsafe { &raw mut (*this.as_ptr()).inner }=
;
> +                let inner =3D core::ptr::from_ref(inner.into_ref().get_r=
ef());

Overall looks good. Looks like you want Opaque::get here rather than
the cast cast cast operation.

>                  // SAFETY:
>                  // - `dev.as_raw()` is a pointer to a valid bound device=
.
> @@ -160,7 +160,7 @@ pub fn new<'a, E>(
>                  //    properly initialized, because we require `dev` (i.=
e. the *bound* device) to
>                  //    live at least as long as the returned `impl PinIni=
t<Self, Error>`.
>                  to_result(unsafe {
> -                    bindings::devm_add_action(dev.as_raw(), Some(callbac=
k), inner.cast())
> +                    bindings::devm_add_action(dev.as_raw(), Some(callbac=
k), inner.cast_mut().cast())
>                  }).inspect_err(|_| {
>                      let inner =3D Opaque::cast_into(inner);
>
>
> Together with the initializer code blocks this becomes quite nice. :)
>
> > Danilo, what plans do you have?
>
> Besides that, the plan is [1].
>
> [1] https://lore.kernel.org/all/DCL32RUQ6Z56.1ERY7JBK6O1J6@kernel.org/

Looks nice :)

Alice

