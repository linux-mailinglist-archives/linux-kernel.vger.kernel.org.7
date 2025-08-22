Return-Path: <linux-kernel+bounces-781132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B787B30DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119817B57A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A10728934F;
	Fri, 22 Aug 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ILlcBO6U"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72784289367;
	Fri, 22 Aug 2025 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839347; cv=none; b=DFcJIKh9YOTrZp5HHrUhWgGkouxww+ccgj2ikoZ2xpSmrcmive4QH2czAACSlM7lwWozwb5A5K8UjOpVCT4bDa28topllbKLDsN1/hQhen7hU9sR/isq3gGEXLiPbC7B5q+WhuY6W4DB/yEJGCQE237pRUwUQgr3o8qo121v/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839347; c=relaxed/simple;
	bh=B7makR98zXZWe0FoOZrqaG6g0cXGEp9K5AWHAIBJ5+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5C1KuX1pmYwRCaYXW5X4gqCUfdCJ8jEtc86Zw6vRDifpqHzc16sAN8iiGkBeYtNOJmJ+vWNZFm81GcWo0wUhdDJcFaA3EsBCN62CzOiAUNoqBteCQ9Pnj+FcB3ZO4GuB474kK+zG3vuoXNofNeaqwkfiKu8LYzM19fs9YcOJxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ILlcBO6U; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 6FEC0C1175;
	Fri, 22 Aug 2025 08:02:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s2M8Ax6LvSw0-rfS34ftp;
	Fri, 22 Aug 2025 08:02:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755838977;
	bh=78DwEG1kk2vp5xo827tUVblTtqo8Jep6l9HkGmdTeIM=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=ILlcBO6UaC3X2gkSfh43bDuc1Ks/8D36oksGYJoDcOYKP1Kdn1aXeGlPEjsETIUaa
	 2he68JoFuo//8LoGAd0iNN6ZEhanHZdLWLydoALifZdr+MZSg8Nh4DAbpL6AzDwefM
	 Rz5iqZf8qMDcr1Gm+zqp+x/GEbMf24ez0IgVATN0=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Fri, 22 Aug 2025 08:02:52 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 dakr@kernel.org, tamird@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: uaccess: use to_result for error handling
Message-ID: <20250822080252.773d6f54@nimda.home>
In-Reply-To: <CAH5fLggt4YJe93xo9KTr=hTQoj28=jjJtaxo=gFmnTbWmm8SRg@mail.gmail.com>
References: <20250821091939.14019-1-work@onurozkan.dev>
	<CAH5fLggt4YJe93xo9KTr=hTQoj28=jjJtaxo=gFmnTbWmm8SRg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 13:04:18 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Thu, Aug 21, 2025 at 11:19=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.=
dev>
> wrote:
> >
> > Simplifies error handling by replacing the manual check
> > of the return value with the `to_result` helper.
> >
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/uaccess.rs | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> > index a8fb4764185a..9992eece2694 100644
> > --- a/rust/kernel/uaccess.rs
> > +++ b/rust/kernel/uaccess.rs
> > @@ -7,7 +7,7 @@
> >  use crate::{
> >      alloc::{Allocator, Flags},
> >      bindings,
> > -    error::Result,
> > +    error::{to_result, Result},
> >      ffi::{c_char, c_void},
> >      prelude::*,
> >      transmute::{AsBytes, FromBytes},
> > @@ -495,9 +495,7 @@ fn raw_strncpy_from_user(dst: &mut
> > [MaybeUninit<u8>], src: UserPtr) -> Result<us )
> >      };
> >
> > -    if res < 0 {
> > -        return Err(Error::from_errno(res as i32));
> > -    }
> > +    to_result(res as i32)?;
>=20
> This is wrong. The type of `res` is isize, and casting a positive
> isize to i32 can result in a negative number and incorrectly trigger
> this error. For example: 2147483650i64 as i32 is -2147483646.
>=20
> Alice

Nice catch. I could use `try_into().unwrap_or(0)` but that feels a bit
iffy since it would silently avoid the error if `isize` happens to be
much smaller than what `i32` can handle (though I am not sure if it's
possible in practice in the kernel codebase). Let's just ignore this
patch.

Thanks,
Onur

