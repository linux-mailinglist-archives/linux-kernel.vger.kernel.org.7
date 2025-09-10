Return-Path: <linux-kernel+bounces-809948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD3B513CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90E83B3540
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E5315783;
	Wed, 10 Sep 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1nA5JWSX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827C314A9A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499814; cv=none; b=uYw29pX345LxOK/pux7RSfC4siYeLbWT46dBr9d1Zmbr0SR57oO3sdKqkEm7oZA48UYclWjSGlpOAGUJh86F75DT6Ubhxhg3hUTXaQt6FCOHtA0QbLmO8IwEwYTPOBpSacO8pYXK2YfPGHleDLBMAouXDrmB9dUzJXdIYAFeQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499814; c=relaxed/simple;
	bh=PGttvBL9JFQtk+P9936QbIX5psM2HFw2fTKtEkCUi+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Osd0YcPr9eu9yNoUaa9mPfSZRUbPOwQDwz2BFj6vYiNC3AJVJ0o9nJyI6gZ8HLF2CUOn3bFea3yzOabBXaUf+mKhbCq4zxrw281vzaMn6eDzut5iQ7KUJXRjINqzSzVDzvsEHkx2Z7MiCj7lyU0XXh1OWahB1YfQ9hcnRSVsgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1nA5JWSX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e7512c8669so1281845f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757499811; x=1758104611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tufP6z/2etbln4lUc4bR0WynCFYZ0JZvTvmDKR+ycI=;
        b=1nA5JWSXaVA+Ro3GqgR9d6dUMzrY1ad0fDc8uqggFlOQTLM2S2bcE0P4u/gQ2ysg3G
         edqYmnoWhvmViTERpGA6nDn8+otwSnyrfBRt69vxj2jQCyXQvUZM6QseQ8AOEvgAD/dO
         DWhCs0mglamnXxXqqmK5b4NDnYkihWS4dSnLeHBJBY//Gzj0eh1yIrhuCmk+rcK6PjJl
         Y6PNZ9VWi2Th+gZvGsOy3hXu9zLnEE1XKTnSo0ieWM/eH8MZ1wCwHnO8UZHqmMVFNJ5S
         CbKnN1+P00DPE7rkTZEccETW+VmI5DlO+z91ljunwxPYCdoPhGsPNO6N1ZD4djYDfL6s
         mVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757499811; x=1758104611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tufP6z/2etbln4lUc4bR0WynCFYZ0JZvTvmDKR+ycI=;
        b=sU3bpM8TWgHcDQVJ31qvB4rVyj3SwY8sNCXP/wwwevW374o0fq8p75sCOPZDvGrgcL
         XFXv00m/XfzDJJ7yc1A7NCuGyN8H1Rn4yYmwf1YWh8sao3jAQ16si47TNkFuQqim4lKz
         AR9NVtzdsBbzIN2hSBfY7duyVglnom6ictKpQQkgBCB4u6LUJ2P1ytgtQ0jHN0DTyJK/
         HAzGt766jSGttPZfGObShLH4scKmJ8inmsMWtJ2A9ESqdVKtkvQAm3v2LwI4MeCVJlrU
         YOJK29r4nhPavBkVcvKdqSCEZ2cdGcLNCrLRSzbMI162biO/5j1ULBln2Z/EJguWB/kQ
         FcAg==
X-Forwarded-Encrypted: i=1; AJvYcCWUldAuzXp0iC8ObHiHUTInHK7E+N6lIxDKLvU6Ykr5gHAuGSAS7Q+TcoSSJbcHAHlVh1pSBoSsn+Ir62I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3l/4bGk6IiIx9yVFWiRtkzI1FZKXEU9evsp7crn9xcx3TS2x
	HfN2AX0ai2zUBY/RkloLVNNBEYKPC7GTXi2qe/hqeEqJTZapLPHGyQwMtPUq/dJ+2MY/GgloRyq
	k6nziLDJYfp3txKlLUOaOHP9j5KojJrm3sGNcXH62
X-Gm-Gg: ASbGncuDyB1AfGfEbVamvGaHQLmqobpkyUNnPBrOAY8sI6XENSCfAufxekuyodbXlmK
	xLZCIc/DaCwS19liPYsv+KIBA2foiZjJodXNex7beYsoUpsbuomRez31Xx3RnRUnOf4iKX0WXXA
	IGzwr3zEJGko7VzKxrLjxv4rErv4vwbuk6GPTcjfiTZlS++uQirtFyRc49CzopWaXUj837A0egu
	8mnHqiTHQpoDY/oE7gcGo8R/eLcBcQfL5uS0fx0rLWjysDA6BvqePj93Q==
X-Google-Smtp-Source: AGHT+IFjEgYFGrcmPgggqL7SOlE8Cvi/8ijfclUwOksIktRtxum1JWy8VXL6gR6ObDPw404jEWbDXLTruwRGyXw9t5A=
X-Received: by 2002:a05:6000:420f:b0:3d1:e22d:df2f with SMTP id
 ffacd0b85a97d-3e641969ce2mr16378740f8f.23.1757499810745; Wed, 10 Sep 2025
 03:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905171209.944599-1-lossin@kernel.org> <20250905171209.944599-2-lossin@kernel.org>
In-Reply-To: <20250905171209.944599-2-lossin@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 12:23:17 +0200
X-Gm-Features: AS18NWD6xYvlI13ABsfyCh0SoWvgFM4fz7y9hvPt5Zv6mWQjfHhmjU85KdCzgzg
Message-ID: <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pin-init: add pin projections to `#[pin_data]`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Alban Kurti <kurti@invicto.ai>, Fiona Behrens <me@kloenk.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.org> wro=
te:
>
> Make the `#[pin_data]` macro generate a `*Projection` struct that holds
> either `Pin<&mut Field>` or `&mut Field` for every field of the original
> struct. Which version is chosen depends on weather there is a `#[pin]`
> or not respectively. Access to this projected version is enabled through
> generating `fn project(self: Pin<&mut Self>) -> SelfProjection<'_>`.
>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/75/commits/2d698367=
d646c7ede90e01aa22842c1002d017b3
> [ Adapt workqueue to use the new projection instead of its own, custom
>   one - Benno ]
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>  rust/kernel/workqueue.rs    | 10 ++-----
>  rust/pin-init/src/macros.rs | 60 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index b9343d5bc00f..6ca14c629643 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -356,18 +356,12 @@ struct ClosureWork<T> {
>      func: Option<T>,
>  }
>
> -impl<T> ClosureWork<T> {
> -    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
> -        // SAFETY: The `func` field is not structurally pinned.
> -        unsafe { &mut self.get_unchecked_mut().func }
> -    }
> -}
> -
>  impl<T: FnOnce()> WorkItem for ClosureWork<T> {
>      type Pointer =3D Pin<KBox<Self>>;
>
>      fn run(mut this: Pin<KBox<Self>>) {
> -        if let Some(func) =3D this.as_mut().project().take() {
> +        if let Some(func) =3D this.as_mut().project().func.take() {
> +            // if let Some(func) =3D this.as_mut().project_func().take()=
 {
>              (func)()
>          }
>      }
> diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
> index 9ced630737b8..d225cc144904 100644
> --- a/rust/pin-init/src/macros.rs
> +++ b/rust/pin-init/src/macros.rs
> @@ -831,6 +831,17 @@ macro_rules! __pin_data {
>              $($fields)*
>          }
>
> +        $crate::__pin_data!(make_pin_projections:
> +            @vis($vis),
> +            @name($name),
> +            @impl_generics($($impl_generics)*),
> +            @ty_generics($($ty_generics)*),
> +            @decl_generics($($decl_generics)*),
> +            @where($($whr)*),
> +            @pinned($($pinned)*),
> +            @not_pinned($($not_pinned)*),
> +        );
> +
>          // We put the rest into this const item, because it then will no=
t be accessible to anything
>          // outside.
>          const _: () =3D {
> @@ -980,6 +991,55 @@ fn drop(&mut self) {
>              stringify!($($rest)*),
>          );
>      };
> +    (make_pin_projections:
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @decl_generics($($decl_generics:tt)*),
> +        @where($($whr:tt)*),
> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_ty=
pe:ty),* $(,)?),
> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type=
:ty),* $(,)?),
> +    ) =3D> {
> +        $crate::macros::paste! {
> +            #[doc(hidden)]
> +            $vis struct [< $name Projection >] <'__pin, $($decl_generics=
)*> {

I'm not sure we want $vis here. That's the visibility of the original
struct, but I don't think we want it to be pub just because the struct
is.

Otherwise looks reasonable.

Alice

