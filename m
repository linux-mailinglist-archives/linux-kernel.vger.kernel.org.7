Return-Path: <linux-kernel+bounces-810017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F0B514AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5797AB288
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1531576C;
	Wed, 10 Sep 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="UrKSKuIr"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F318FC97;
	Wed, 10 Sep 2025 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501945; cv=none; b=TEEB358z55H/ZQyS99Jefv/niWNd+E3+iWXyNvC15xv83b4Vf+bT0nJnsRGqLKvjHlVwYkbDhTh1hCBC2KAee6UY0XG39YV/3/1GSJJhBJAeByRcKvgK1KtnX4/F/VHX88HDH2EX9Iao8WWT6zEYpj4K51DhCIEsAgMSfrEj8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501945; c=relaxed/simple;
	bh=LfkW7+godablUCnUw+RxZ0UOcEJognGUZ7Oi6euYX6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sb4iasDor6fBO+D/hCbchp/JNBI7w9MyWRon5o3ycd+caWw/vbnHr0ySf+swFMnVPzqEsPPxJzE2LKfKhiMWnn1wcBebNJ+eHpXpiz2VZF31i8dgEh0DEI58sxXvUZE3soiNaC5NjpV6oX8emtRzokrsG4/CASOkn31OGQbtWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=UrKSKuIr; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:160e:0:640:2589:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 47338C1B86;
	Wed, 10 Sep 2025 13:58:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id swHnkSBMu4Y0-y2KfdKi4;
	Wed, 10 Sep 2025 13:58:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757501938;
	bh=kZkUcDMg2LSkPRZlDUL3r2d6ErfJziliT14Z/IR233U=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=UrKSKuIrxHYb1+h0+94ynqGVVpYqK0Z6h6YsOym3y2p8LMhZUz2UYjnS4QdvmeNtx
	 u/X+9ozZpfjHWwuzbea+Aw3bP5/iwua+m4Lqes/M9A8+UmVoh8/6T5iKQ1dR6Pv+RI
	 zPKPP11A8rYUewOO5tTbp67ebJmk5L3EpshtABaA=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 10 Sep 2025 13:58:48 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com,
 tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu,
 a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com,
 gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com,
 ojeda@kernel.org
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original
 value
Message-ID: <20250910135848.1ea11519@nimda.home>
In-Reply-To: <aMEaE2NEU2FctgH2@google.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
	<20250909170013.16025-2-work@onurozkan.dev>
	<aMEaE2NEU2FctgH2@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 06:26:27 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Tue, Sep 09, 2025 at 08:00:13PM +0300, Onur =C3=96zkan wrote:
> > Current `to_result` helper takes a `c_int` and returns `Ok(())` on
> > success and this has some issues like:
> >=20
> >     - Callers lose the original return value and often have to store
> > 	it in a temporary variable before calling `to_result`.
> >=20
> >     - It only supports `c_int`, which makes callers to unnecessarily
> > 	cast when working with other types (e.g. `u16` in phy
> > 	abstractions). We even have some places that ignore to use
> > 	`to_result` helper because the input doesn't fit in `c_int`
> > 	(see [0]).
> >=20
> > [0]: https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
> >=20
> > This patch changes `to_result` to be generic and also return the
> > original value on success.
> >=20
> > So that the code that previously looked like:
> >=20
> >     let ret =3D unsafe { bindings::some_ffi_call() };
> >     to_result(ret).map(|()| SomeType::new(ret))
> >=20
> > can now be written more directly as:
> >=20
> >     to_result(unsafe { bindings::some_ffi_call() })
> > 	.map(|ret| SomeType::new(ret))
> >=20
> > Similarly, code such as:
> >=20
> >     let res: isize =3D $some_ffi_call();
> >     if res < 0 {
> > 	    return Err(Error::from_errno(res as i32));
> >     }
> >=20
> > can now be used with `to_result` as:
> >=20
> >     to_result($some_ffi_call())?;
> >=20
> > This patch only fixes the callers that broke after the changes on
> > `to_result`. I haven't included all the improvements made possible
> > by the new design since that could conflict with other ongoing
> > patches [1]. Once this patch is approved and applied, I am planning
> > to follow up with creating a "good first issue" on [2] for those
> > additional changes.
> >=20
> > [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
> > [2]: https://github.com/Rust-for-Linux/linux
> >=20
> > Link:
> > https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/nea=
r/536374456
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>=20
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index a41de293dcd1..6563ea71e203 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -376,12 +376,19 @@ fn from(e: core::convert::Infallible) ->
> > Error { pub type Result<T =3D (), E =3D Error> =3D
> > core::result::Result<T, E>;
> >=20
> >  /// Converts an integer as returned by a C kernel function to an
> > error if it's negative, and -/// `Ok(())` otherwise.
> > -pub fn to_result(err: crate::ffi::c_int) -> Result {
> > -    if err < 0 {
> > -        Err(Error::from_errno(err))
> > +/// returns the original value otherwise.
> > +pub fn to_result<T>(code: T) -> Result<T>
> > +where
> > +    T: Copy + TryInto<i32>,
> > +{
> > +    // Try casting into `i32`.
> > +    let casted: crate::ffi::c_int =3D code.try_into().unwrap_or(0);
> > +
> > +    if casted < 0 {
> > +        Err(Error::from_errno(casted))
> >      } else {
> > -        Ok(())
> > +        // Return the original input value.
> > +        Ok(code)
> >      }
> >  }
>=20
> I don't think this is the best way to declare this function. The
> conversions I would want are:
>=20
> * i32 -> Result<u32>
> * isize -> Result<usize>
> * i64 -> Result<u64>
>=20
> Your commit messages mentions i16, but does the error types even fit
> in 16 bits? Maybe. But they don't fit in i8. That is to say, I think
> it should support all the types larger than i32 (the errors fit in
> those types too), but for the ones that are smaller, it might not
> make sense if the type is too small. That's the reverse of what you
> have now.
>=20
> We probably need a new trait. E.g.:
>=20
> trait ToResult {
>     type Unsigned;
>     fn to_result(self) -> Result<Self::Unsigned, Error>;
> }
>=20
> impl ToResult for i32 {
>     type Unsigned =3D u32;
>     fn to_result(self) -> Result<u32, Error> {
>         ...
>     }
> }
>=20
> impl ToResult for isize {
>     type Unsigned =3D usize;
>     fn to_result(self) -> Result<usize, Error> {
>         ...
>     }
> }
>=20
> pub fn to_result<T: ToResult>(code: T) -> Result<T::Unsigned> {
>     T::to_result(code)
> }
>=20

`Error::from_errno` is limited to i32, that's why I followed the
`TryInto<i32>` approach, but I like this design too.

> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 6373fe183b27..22b72ae84c03 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -79,7 +79,7 @@ pub fn register(opts: MiscDeviceOptions) -> impl
> > PinInit<Self, Error> { // the destructor of this type deallocates
> > the memory. // INVARIANT: If this returns `Ok(())`, then the `slot`
> > will contain a registered // misc device.
> > -                to_result(unsafe { bindings::misc_register(slot) })
> > +                to_result(unsafe { bindings::misc_register(slot)
> > }).map(|_| ())
>=20
> This still uses the `map` pattern. Please change it too.
>=20
> Alice


I left that part intentionally and explained the reason in v2 changelog.

Thanks,
Onur

