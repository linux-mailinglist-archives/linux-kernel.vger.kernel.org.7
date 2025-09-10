Return-Path: <linux-kernel+bounces-810218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA91B5175B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22164484DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219031C57F;
	Wed, 10 Sep 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="lv/ovcp8"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D459226D1F;
	Wed, 10 Sep 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508975; cv=none; b=QPmdlJNE15yg51W09N3cT4Xg+g9WhXfzKl2UuiEd4pD+3MlOSpb3q3O/bkrCr3g9sDK6cuvQOOQa8gZJo0A9tVYEe2Ys6eMA05g+sR96GdRF7dE5cKDN53uMPa3MsRSR4qmwLP78uWdMfhSfLGwJ1hK3cZWCVJ92y71dlultftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508975; c=relaxed/simple;
	bh=53WONVDAOrYbWHTo33FZdUjYOHITBRsjxqcruBXoacs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0KOLC8KaWrzDj/YpPJ/BmmelbDznZ8Ia8/Jcq2vw5ZpleynATqzVeasDfiPGfgG2EEiZeAfUrdHUa0xBNWWNnTeamfH5uUZURn9MTzhmHfeLB/625kg4NyEy2E7eaD4g0FKMBBO0FrksoRzi0fFAcAWZegQ/fcMW50EsAHHnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=lv/ovcp8; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3d8d:0:640:b127:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id E5D708270B;
	Wed, 10 Sep 2025 15:56:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xtJu85GMomI0-XmJY2Gmq;
	Wed, 10 Sep 2025 15:56:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757508963;
	bh=Fxi1AP0JW+8xhnVMhlRNLoIDo/8xyqHk/5hEL4LoNXs=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=lv/ovcp846IBQvOLCRLst39sEhQRc3Wy+stTiMKSImc+h80DwNoMFInWJ9l19op4w
	 dMRBMrSsnPrsUyhtS02byRk6eqVUCH4BTcqWI0bzNYeuztUWGh3m8eN6Rxv/C+HaBc
	 hD7J8gkPP2VVf+CI+5AGSHGqhaeQbaL/TQnGTVJM=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 10 Sep 2025 15:55:58 +0300
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
Message-ID: <20250910155558.36ebf8df@nimda.home>
In-Reply-To: <CAH5fLgjT3LLpg-CjdbR5_+sgBZEsrCP-c4eJt=E3NmtVDKMJ5Q@mail.gmail.com>
References: <20250909170013.16025-1-work@onurozkan.dev>
	<20250909170013.16025-2-work@onurozkan.dev>
	<aMEaE2NEU2FctgH2@google.com>
	<20250910135848.1ea11519@nimda.home>
	<CAH5fLggb=_Vtk74RONc+pQUSc1XrVi=jdD1=mHNs6-67ZCYB0A@mail.gmail.com>
	<20250910154746.03a3bc2f@nimda.home>
	<CAH5fLgjT3LLpg-CjdbR5_+sgBZEsrCP-c4eJt=E3NmtVDKMJ5Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 14:50:03 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Sep 10, 2025 at 2:47=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.d=
ev> wrote:
> >
> > On Wed, 10 Sep 2025 13:05:42 +0200
> > Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > > On Wed, Sep 10, 2025 at 12:59=E2=80=AFPM Onur =C3=96zkan <work@onuroz=
kan.dev>
> > > wrote:
> > > >
> > > > On Wed, 10 Sep 2025 06:26:27 +0000
> > > > Alice Ryhl <aliceryhl@google.com> wrote:
> > > >
> > > > > On Tue, Sep 09, 2025 at 08:00:13PM +0300, Onur =C3=96zkan wrote:
> > > > > > Current `to_result` helper takes a `c_int` and returns
> > > > > > `Ok(())` on success and this has some issues like:
> > > > > >
> > > > > >     - Callers lose the original return value and often have
> > > > > > to store it in a temporary variable before calling
> > > > > > `to_result`.
> > > > > >
> > > > > >     - It only supports `c_int`, which makes callers to
> > > > > > unnecessarily cast when working with other types (e.g.
> > > > > > `u16` in phy abstractions). We even have some places that
> > > > > > ignore to use `to_result` helper because the input doesn't
> > > > > > fit in `c_int` (see [0]).
> > > > > >
> > > > > > [0]:
> > > > > > https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
> > > > > >
> > > > > > This patch changes `to_result` to be generic and also
> > > > > > return the original value on success.
> > > > > >
> > > > > > So that the code that previously looked like:
> > > > > >
> > > > > >     let ret =3D unsafe { bindings::some_ffi_call() };
> > > > > >     to_result(ret).map(|()| SomeType::new(ret))
> > > > > >
> > > > > > can now be written more directly as:
> > > > > >
> > > > > >     to_result(unsafe { bindings::some_ffi_call() })
> > > > > >     .map(|ret| SomeType::new(ret))
> > > > > >
> > > > > > Similarly, code such as:
> > > > > >
> > > > > >     let res: isize =3D $some_ffi_call();
> > > > > >     if res < 0 {
> > > > > >         return Err(Error::from_errno(res as i32));
> > > > > >     }
> > > > > >
> > > > > > can now be used with `to_result` as:
> > > > > >
> > > > > >     to_result($some_ffi_call())?;
> > > > > >
> > > > > > This patch only fixes the callers that broke after the
> > > > > > changes on `to_result`. I haven't included all the
> > > > > > improvements made possible by the new design since that
> > > > > > could conflict with other ongoing patches [1]. Once this
> > > > > > patch is approved and applied, I am planning to follow up
> > > > > > with creating a "good first issue" on [2] for those
> > > > > > additional changes.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
> > > > > > [2]: https://github.com/Rust-for-Linux/linux
> > > > > >
> > > > > > Link:
> > > > > > https://rust-for-linux.zulipchat.com/#narrow/channel/288089/top=
ic/x/near/536374456
> > > > > > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > > > >
> > > > > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > > > > index a41de293dcd1..6563ea71e203 100644
> > > > > > --- a/rust/kernel/error.rs
> > > > > > +++ b/rust/kernel/error.rs
> > > > > > @@ -376,12 +376,19 @@ fn from(e: core::convert::Infallible)
> > > > > > -> Error { pub type Result<T =3D (), E =3D Error> =3D
> > > > > > core::result::Result<T, E>;
> > > > > >
> > > > > >  /// Converts an integer as returned by a C kernel function
> > > > > > to an error if it's negative, and -/// `Ok(())` otherwise.
> > > > > > -pub fn to_result(err: crate::ffi::c_int) -> Result {
> > > > > > -    if err < 0 {
> > > > > > -        Err(Error::from_errno(err))
> > > > > > +/// returns the original value otherwise.
> > > > > > +pub fn to_result<T>(code: T) -> Result<T>
> > > > > > +where
> > > > > > +    T: Copy + TryInto<i32>,
> > > > > > +{
> > > > > > +    // Try casting into `i32`.
> > > > > > +    let casted: crate::ffi::c_int =3D
> > > > > > code.try_into().unwrap_or(0); +
> > > > > > +    if casted < 0 {
> > > > > > +        Err(Error::from_errno(casted))
> > > > > >      } else {
> > > > > > -        Ok(())
> > > > > > +        // Return the original input value.
> > > > > > +        Ok(code)
> > > > > >      }
> > > > > >  }
> > > > >
> > > > > I don't think this is the best way to declare this function.
> > > > > The conversions I would want are:
> > > > >
> > > > > * i32 -> Result<u32>
> > > > > * isize -> Result<usize>
> > > > > * i64 -> Result<u64>
> > > > >
> > > > > Your commit messages mentions i16, but does the error types
> > > > > even fit in 16 bits? Maybe. But they don't fit in i8. That is
> > > > > to say, I think it should support all the types larger than
> > > > > i32 (the errors fit in those types too), but for the ones
> > > > > that are smaller, it might not make sense if the type is too
> > > > > small. That's the reverse of what you have now.
> > > > >
> > > > > We probably need a new trait. E.g.:
> > > > >
> > > > > trait ToResult {
> > > > >     type Unsigned;
> > > > >     fn to_result(self) -> Result<Self::Unsigned, Error>;
> > > > > }
> > > > >
> > > > > impl ToResult for i32 {
> > > > >     type Unsigned =3D u32;
> > > > >     fn to_result(self) -> Result<u32, Error> {
> > > > >         ...
> > > > >     }
> > > > > }
> > > > >
> > > > > impl ToResult for isize {
> > > > >     type Unsigned =3D usize;
> > > > >     fn to_result(self) -> Result<usize, Error> {
> > > > >         ...
> > > > >     }
> > > > > }
> > > > >
> > > > > pub fn to_result<T: ToResult>(code: T) -> Result<T::Unsigned>
> > > > > { T::to_result(code)
> > > > > }
> > > > >
> > > >
> > > > `Error::from_errno` is limited to i32, that's why I followed the
> > > > `TryInto<i32>` approach, but I like this design too.
> > >
> > > If you pass an i32 that is not a valid errno, then it becomes
> > > EINVAL. In the case of `isize`, I would say that if a negative
> > > isize does not fit in i32, then that should fall into the same
> > > scenario.
> > >
> >
> > In that case replacing `unwrap_or(0)` with `map_err(|_|
> > code::EINVAL)` should do the job?
> >
> > I also thought of an alternative to the custom-trait=E2=80=93based appr=
oach.
> > What do you think about something like this:
> >
> >     pub fn to_result<T, R>(code: T) -> Result<R>
> >     where
> >         T: Copy + TryInto<i32> + TryInto<R>,
> >     {
> >         // Try casting into `i32`.
> >         let casted: crate::ffi::c_int =3D code.try_into().map_err(|_|
> >     code::EINVAL)?;
> >
> >         if casted < 0 {
> >             Err(Error::from_errno(casted))
> >         } else {
> >             // Return the original input value as `R`.
> >             code.try_into().map_err(|_| code::EINVAL)
> >         }
> >     }
> >
> >
> > On the caller side, it would look like this:
> >
> >     let val: u16 =3D to_result(...)?;
> >
> > The main difference here is that this version can be used to cast
> > into multiple different types, not just `i32 -> u32` or `i64 ->
> > u64`.
>=20
> I think making the return type a separate generic makes this too
> difficult to use. It means that any time you would write this:
>=20
> to_result(unsafe { ... })?;
> Ok(())
>=20
> now you need to tell the compiler what kind of integer you want to get
> from to_result, just so you can immediately ignore the integer.
>=20
> Alice

Yes, and with the custom trait you need to import it in order to use
the `to_result` helper. I don't have a strong preference either way.
I guess I will wait a couple of days to get more feedback from others
as well. Thank you for your quick feedback and review so far!

-Onur

