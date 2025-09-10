Return-Path: <linux-kernel+bounces-809949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07492B513CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1801BC4B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DE231577D;
	Wed, 10 Sep 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="td/mqn6r"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A362DCF55
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499869; cv=none; b=bH3lB5R/lrtyXyxKixsY9HAet1kKymCpieYNZbAphNZvBQpAcZZTvGplvwoBfvTiYlL76aR691aBCBXOwuSEuuymCH6ZKBjpWz2SUpfTLMADTcSvB+iYRLM6qagA1/0C9Vk0rGEGXyZ0BwKBIkPQtiEAHc1W2qpf+EO+nFzCDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499869; c=relaxed/simple;
	bh=JNI1xafTZn6iCK80v9bddB92GDc91qjYHFvm0IrIlYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjdEfUYm7z0fOyriwXa0oXj4T1HK4Yfnh4T8Sx7AFuEUucK1o+0yENK2KIv77xNHAvzVE1/XKfmXpcsiUXFJPEr6kE32ucCrXTxBlySf1jEJWvG/KrzhBI/0pvKHSEuSTjPEnCzanfZRgfudw4dnr6prfqebCh4IV9BtpxxeGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=td/mqn6r; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dea538b826so5585054f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757499866; x=1758104666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW0FZZNyJC6DQyL0h+B3+4W3ivZ1mhg1DGb6+1jin8s=;
        b=td/mqn6rZx+wbPD4l7n1Y1cMpyKaXClnS1OfxI1HvwTNmwjza92S6kuXUneZNERATi
         Xzik5H2ExZvJek6uGUiluu7iO4uF8B1fcIqELzYgDf8Za939LXjAA4IwxnnogBi8jzk6
         UabwWDp2Sk8x5SkJwzPuTcfNsdf1LUCD71lpSkLQddBl933qCgt8nVU6pedHz3r9VPig
         iOqfjfyE/K6AeQtSFY9c6yqCzgfmQebmxzQtzFTs+Vha0dw5NUPzlnoRyJZ0UENh73/b
         gadnI5MmCKLUe40+dZLhZg3zQ4ZPw/6Vk2zRhm9dL6YMdHJyXvl+NZif+8itnvs5E3JD
         P6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757499866; x=1758104666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW0FZZNyJC6DQyL0h+B3+4W3ivZ1mhg1DGb6+1jin8s=;
        b=ehwdfCVcJ7xpQwl+d6AXaJUpC2bNm7eQks7IUdiAkDzmVPe5wBcgS9Ta13HamwiM1/
         iA2ZuPwRy4hLG73F2POUY2BzJDaW0LWHOUBKsVrjyeNBBE4i/FiMF88dF6Ly6SCl8DU6
         G/B9Dazrwqy2saZY0hE3LcDwLh53VtWdUbEAszKB4Sy6XcgaUU49vAz1R4xs2rR8Ugu6
         VlFas9BUR25KyrI6XLFeBGimwC7ZOm7qXpmSqNaz1+dxOYCowBOWRzR+LnVZ/szdM++w
         Qi5lBWe2uIOWh4TDGFxyAGQv9x86hGE6YG6/MEcjINz91n70hdqo+mJCaI3dPjMXt/f1
         wTfg==
X-Forwarded-Encrypted: i=1; AJvYcCUoD/VYt1lhLLCuwzWr0u5cgrXQg+nqANtT8P8ljezlhRDtAqnOpC1nHHOCf0EsStK9ZVZ6b+ofb4oEwoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKybduXUaqeyfulYG488q3kbSWo7ZgzqQY3RoorPsz8g9NrYQ
	zZu2rbqERF7UVLG3NZwJiC6bcRhInmiEiew5I1ipzsHHEDyQtfd0heV113C4xpdMcbqt0irxWab
	8cC1f3etcWyz3lx8VT82P52KMNmi9TmNYUKkmPDoL
X-Gm-Gg: ASbGnctBtzJQ2GtNbNzQ3NXrk/ugIiaIh0lLFX2ZanLCc+xNG5XS8Dl9A7nECYeIuhF
	/I0JwXS9Sb/KQhXx4Zr36iy7SdtkGPqrySvl4CbjgASrb8Ig3keiWgqon0zTnA6xLgHank3Uz2e
	0ky8UDddmrHWk6svzj4vwWnQpxSaHtmttm5Klb/k1WEgro6GIkW6u5hthOLMCKLqH+bwlJ8z4Qo
	AM1Twm7vEoiyNryFkbJk5vJdniJfXpFtIGbzfODRdeWVlU=
X-Google-Smtp-Source: AGHT+IGpIjBaaH28lZlXigtwqbex6iaGE3z3xj8Kfy1iwRJ6hJC1qIRa6GrV11hAN529VTFfyR9gXBuuvFaBwq0xgac=
X-Received: by 2002:a05:6000:40dd:b0:3dc:2912:14d0 with SMTP id
 ffacd0b85a97d-3e643ff65cbmr12031836f8f.33.1757499865819; Wed, 10 Sep 2025
 03:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905171209.944599-1-lossin@kernel.org> <20250905171209.944599-2-lossin@kernel.org>
 <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
In-Reply-To: <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 12:24:12 +0200
X-Gm-Features: AS18NWApose0qYKV2Zj1c4N1wmOA4t8FrjkdH5ovzXiiZUzBAmcn_x5yfJZd9Kc
Message-ID: <CAH5fLgi5M+9gaH8QmwLd=7Gto7C6nceLd6g25a4O7hcrax16kQ@mail.gmail.com>
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

On Wed, Sep 10, 2025 at 12:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
> >
> > Make the `#[pin_data]` macro generate a `*Projection` struct that holds
> > either `Pin<&mut Field>` or `&mut Field` for every field of the origina=
l
> > struct. Which version is chosen depends on weather there is a `#[pin]`
> > or not respectively. Access to this projected version is enabled throug=
h
> > generating `fn project(self: Pin<&mut Self>) -> SelfProjection<'_>`.
> >
> > Link: https://github.com/Rust-for-Linux/pin-init/pull/75/commits/2d6983=
67d646c7ede90e01aa22842c1002d017b3
> > [ Adapt workqueue to use the new projection instead of its own, custom
> >   one - Benno ]
> > Signed-off-by: Benno Lossin <lossin@kernel.org>
> > ---
> >  rust/kernel/workqueue.rs    | 10 ++-----
> >  rust/pin-init/src/macros.rs | 60 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+), 8 deletions(-)
> >
> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > index b9343d5bc00f..6ca14c629643 100644
> > --- a/rust/kernel/workqueue.rs
> > +++ b/rust/kernel/workqueue.rs
> > @@ -356,18 +356,12 @@ struct ClosureWork<T> {
> >      func: Option<T>,
> >  }
> >
> > -impl<T> ClosureWork<T> {
> > -    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
> > -        // SAFETY: The `func` field is not structurally pinned.
> > -        unsafe { &mut self.get_unchecked_mut().func }
> > -    }
> > -}
> > -
> >  impl<T: FnOnce()> WorkItem for ClosureWork<T> {
> >      type Pointer =3D Pin<KBox<Self>>;
> >
> >      fn run(mut this: Pin<KBox<Self>>) {
> > -        if let Some(func) =3D this.as_mut().project().take() {
> > +        if let Some(func) =3D this.as_mut().project().func.take() {
> > +            // if let Some(func) =3D this.as_mut().project_func().take=
() {

Spurious comment.

