Return-Path: <linux-kernel+bounces-810026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE6B514CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382061C82B54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5D3191A8;
	Wed, 10 Sep 2025 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQc6he65"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8EB317717
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502360; cv=none; b=JHB/f+/PdKRreGrIcpZt5tUDy6PGdKTG8mUjnGSkXP0nXdjUeobM9047Ca8/c3jbLrwPCAvVZDEgdceamzY9+tbbCUPF0Ohh2NYsdcZQs54QzkZBvnx4kBCa/cGyH7vNVWfgWi4vb5lhQ/VD7yF0w7I0012qWaizKUNvjGpxEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502360; c=relaxed/simple;
	bh=y1so4TbjMvONJOfZSG5Fi0E/0DAoWKO86CwMn9gP0XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxWtgOh1yYPd9DmiBgZ9jgPI1oEEG2FzLg/0Wxe75oFU20yZlJWCahD/edESHKfvTJLodK0j7RKQHvjQkrDTX8IGeDvrRZTmHZL8bzm7eLU7lJL/53SCghJjxbiAXP/63xW0DH3j2a1Z+KoovJNy0jQoWnji9j8TpDuYgDAqgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQc6he65; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dfb6cadf3so633045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757502356; x=1758107156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un8nhzB1WVU7qlNSbKSKoy2s60POBtDvaBHvldZIFU0=;
        b=hQc6he65J8bQgM9G7anquiwIwFl67d70jy8xYcy3bM8imfynSowdW8qix7JAsBS1A7
         vQHRh67k+7DUGR9yc3B/qLg/DfITjKB/r681RBnZ17GJNe0oknGxzCh0niR0OLMefU7P
         PfNMkDWivGhLzdGU/OQtgYuCrlySKUTMQMbIaBvq1n+S7+BdlD9C3bUXKB6CoIPBpI2K
         7TXKLugNGe4c2S/MkbC+iH6V3K9IR8q/ZEQlKD7n5p5T7aYEGYsScpvn0sun1xk4AMW6
         pxEVBLmBPklAH2ocklUMOyyWzcG9O+zSn8qB/jwJ3Ay0NRero19x0h1HVulJJI2LPgdC
         FXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502356; x=1758107156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un8nhzB1WVU7qlNSbKSKoy2s60POBtDvaBHvldZIFU0=;
        b=p4ffbI0IL6k4yGt96dfcVMs7RgviaFRSoAvkLOkwhSYb616tra2gN1YRVxPNP+oazI
         96jnw1BOmGfuYLflfmotbugmD/peWX9ZvzrhUHXvx3flZfTzaUF0lCcudEGV3sQEOkcL
         UnFwiWkeiMI5rxtOALdsJsKsnJbc5j7UYkjppmmaaTip0Ptclni8w/qTVhdGjjPxpUMd
         q8yxPpnBYVNWEIis33PXJfUQWiq1JlRG4o+KqgcR/BawxFrCUpf7eeANY+mwJM/ag7cc
         /mWcBl5/6CYHNq7+4GalhzyoAmhFvMNdLqbYH6ZzFcuAWYBGAwRZClWTJHGlSv6/9hDT
         0G9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeJxdjtZZof1Cnp6gqMpxwikHQ6Ca8+044cLUWlyem/m/BbL7vlWUk5+6/aGqaqN/J6/vRfhixmHaiD24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxq7/yhj2gfvU+YjMgaD7ZDKro6oMkYIoYlw9/ODDaUdX7Fbw
	z0Z+kUqwIo+D0U4moZsEBZu7PmeoF90Dbeshe21l8/t8oFZ+TmAmduIQqUWvsBzfeTKByK72T2x
	s93Xu6KaNxsVDSTYqGyKy1Bu5WTfvfGpWL6WNJTkE
X-Gm-Gg: ASbGncvfqSJXpbymBwb5WrgIQ9Gqpn2Nw5s3TXuymN43pAxorFowhZR8oJ+dZolplxm
	88vNdp7kuHcEs5T2COLI2NH4sHcwW6E4SNC4u+yMEva5cvOI9aq+/zJxOOcnR33gIuJ2P13/Am+
	KtGm0ErYU84pjJ67e4VI2FUYdEQ7xZMXTyhSl9qQF4Rz8dCOgmgKvtelVDipU2wiE9U8FOMfTKm
	cNtH5x8JiOOi5EZ78iNUFKP9GLPo8Vv/o2LCSfCA9/6oB6S18uwXRbiRQ==
X-Google-Smtp-Source: AGHT+IG/+91gjeD8g7gPwMhTt1ikXFi5N0FLHEo0UHw9OVEivkBLcW7lSPD7VE1w1l5KB6lOFVSe+BSVtZ+jf3FIAL8=
X-Received: by 2002:a05:600c:5299:b0:45d:dd47:b45f with SMTP id
 5b1f17b1804b1-45dddef7fdamr121487525e9.31.1757502356255; Wed, 10 Sep 2025
 04:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909170013.16025-1-work@onurozkan.dev> <20250909170013.16025-2-work@onurozkan.dev>
 <aMEaE2NEU2FctgH2@google.com> <20250910135848.1ea11519@nimda.home>
In-Reply-To: <20250910135848.1ea11519@nimda.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 13:05:42 +0200
X-Gm-Features: AS18NWB-5lon1PP9gczsJp-JwKcaPqyaIo_NMa9DPgfAMAEtZ0Iu-VPS9gr-fMY
Message-ID: <CAH5fLggb=_Vtk74RONc+pQUSc1XrVi=jdD1=mHNs6-67ZCYB0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original value
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com, 
	tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, a.hindborg@kernel.org, 
	lossin@kernel.org, bjorn3_gh@protonmail.com, gary@garyguo.net, 
	boqun.feng@gmail.com, alex.gaynor@gmail.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:59=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> On Wed, 10 Sep 2025 06:26:27 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Tue, Sep 09, 2025 at 08:00:13PM +0300, Onur =C3=96zkan wrote:
> > > Current `to_result` helper takes a `c_int` and returns `Ok(())` on
> > > success and this has some issues like:
> > >
> > >     - Callers lose the original return value and often have to store
> > >     it in a temporary variable before calling `to_result`.
> > >
> > >     - It only supports `c_int`, which makes callers to unnecessarily
> > >     cast when working with other types (e.g. `u16` in phy
> > >     abstractions). We even have some places that ignore to use
> > >     `to_result` helper because the input doesn't fit in `c_int`
> > >     (see [0]).
> > >
> > > [0]: https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
> > >
> > > This patch changes `to_result` to be generic and also return the
> > > original value on success.
> > >
> > > So that the code that previously looked like:
> > >
> > >     let ret =3D unsafe { bindings::some_ffi_call() };
> > >     to_result(ret).map(|()| SomeType::new(ret))
> > >
> > > can now be written more directly as:
> > >
> > >     to_result(unsafe { bindings::some_ffi_call() })
> > >     .map(|ret| SomeType::new(ret))
> > >
> > > Similarly, code such as:
> > >
> > >     let res: isize =3D $some_ffi_call();
> > >     if res < 0 {
> > >         return Err(Error::from_errno(res as i32));
> > >     }
> > >
> > > can now be used with `to_result` as:
> > >
> > >     to_result($some_ffi_call())?;
> > >
> > > This patch only fixes the callers that broke after the changes on
> > > `to_result`. I haven't included all the improvements made possible
> > > by the new design since that could conflict with other ongoing
> > > patches [1]. Once this patch is approved and applied, I am planning
> > > to follow up with creating a "good first issue" on [2] for those
> > > additional changes.
> > >
> > > [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
> > > [2]: https://github.com/Rust-for-Linux/linux
> > >
> > > Link:
> > > https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/n=
ear/536374456
> > > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> >
> > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > index a41de293dcd1..6563ea71e203 100644
> > > --- a/rust/kernel/error.rs
> > > +++ b/rust/kernel/error.rs
> > > @@ -376,12 +376,19 @@ fn from(e: core::convert::Infallible) ->
> > > Error { pub type Result<T =3D (), E =3D Error> =3D
> > > core::result::Result<T, E>;
> > >
> > >  /// Converts an integer as returned by a C kernel function to an
> > > error if it's negative, and -/// `Ok(())` otherwise.
> > > -pub fn to_result(err: crate::ffi::c_int) -> Result {
> > > -    if err < 0 {
> > > -        Err(Error::from_errno(err))
> > > +/// returns the original value otherwise.
> > > +pub fn to_result<T>(code: T) -> Result<T>
> > > +where
> > > +    T: Copy + TryInto<i32>,
> > > +{
> > > +    // Try casting into `i32`.
> > > +    let casted: crate::ffi::c_int =3D code.try_into().unwrap_or(0);
> > > +
> > > +    if casted < 0 {
> > > +        Err(Error::from_errno(casted))
> > >      } else {
> > > -        Ok(())
> > > +        // Return the original input value.
> > > +        Ok(code)
> > >      }
> > >  }
> >
> > I don't think this is the best way to declare this function. The
> > conversions I would want are:
> >
> > * i32 -> Result<u32>
> > * isize -> Result<usize>
> > * i64 -> Result<u64>
> >
> > Your commit messages mentions i16, but does the error types even fit
> > in 16 bits? Maybe. But they don't fit in i8. That is to say, I think
> > it should support all the types larger than i32 (the errors fit in
> > those types too), but for the ones that are smaller, it might not
> > make sense if the type is too small. That's the reverse of what you
> > have now.
> >
> > We probably need a new trait. E.g.:
> >
> > trait ToResult {
> >     type Unsigned;
> >     fn to_result(self) -> Result<Self::Unsigned, Error>;
> > }
> >
> > impl ToResult for i32 {
> >     type Unsigned =3D u32;
> >     fn to_result(self) -> Result<u32, Error> {
> >         ...
> >     }
> > }
> >
> > impl ToResult for isize {
> >     type Unsigned =3D usize;
> >     fn to_result(self) -> Result<usize, Error> {
> >         ...
> >     }
> > }
> >
> > pub fn to_result<T: ToResult>(code: T) -> Result<T::Unsigned> {
> >     T::to_result(code)
> > }
> >
>
> `Error::from_errno` is limited to i32, that's why I followed the
> `TryInto<i32>` approach, but I like this design too.

If you pass an i32 that is not a valid errno, then it becomes EINVAL.
In the case of `isize`, I would say that if a negative isize does not
fit in i32, then that should fall into the same scenario.


> > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > index 6373fe183b27..22b72ae84c03 100644
> > > --- a/rust/kernel/miscdevice.rs
> > > +++ b/rust/kernel/miscdevice.rs
> > > @@ -79,7 +79,7 @@ pub fn register(opts: MiscDeviceOptions) -> impl
> > > PinInit<Self, Error> { // the destructor of this type deallocates
> > > the memory. // INVARIANT: If this returns `Ok(())`, then the `slot`
> > > will contain a registered // misc device.
> > > -                to_result(unsafe { bindings::misc_register(slot) })
> > > +                to_result(unsafe { bindings::misc_register(slot)
> > > }).map(|_| ())
> >
> > This still uses the `map` pattern. Please change it too.
> >
> > Alice
>
>
> I left that part intentionally and explained the reason in v2 changelog.

I missed that, ok. I still prefer Ok::<...>()

