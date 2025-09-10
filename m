Return-Path: <linux-kernel+bounces-810207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA4B5173E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED20E4E2C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3D31B10D;
	Wed, 10 Sep 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+IyQdV2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C12D594C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508620; cv=none; b=sShWN2xLxb52IpircH3oCZcxXgPIbcEw6tqTzTeLG9vgI2r9u1+xGVR8ArjMygvCu/mXnQ0t1o2GpEL28UboDy0p3PDIxnOSdlVvcx6cU1IKyW0hVSE1cxeHqAuwV9aAoiODkHDbQprza3DjHAaEtWDmWrbTbfuiHN/09G7IXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508620; c=relaxed/simple;
	bh=KPKpgcY5xKixyKiUfwzHTBY5sunC7kg8R3SkA4pQiUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpPGqfVEpT5BC0BKRfOkpvSVULt2w3q4qQxvzhNfzuJKqrv4WM44e59ZOqrZf/1RQmAQk1ItdlG+drivP5UeWebYt5O1qW3g9jsocNjWRzWiPEHlR7BgWBSqHX47kwHoUKLGoQJfZMtGHXeYg65Y01qo5utBwnQX7Ryx35hW3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+IyQdV2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so43433045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757508617; x=1758113417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxQmUaO34FNds/dKkUVjytcJcTLUNu+HbjN0DdBAszU=;
        b=Q+IyQdV2Qn699C4V/B3N8t1mZ07gWVcIwDoanrE1Gi5PLoo9LO/c8ltNOhRQuoHDmj
         6Y0BMXsr5HULw6xLxCtFf3scbs8aNpfOJVEdhtWZpbsRvaYyYZ1MzTCPT/ej6nvetjIy
         zGlZG8xFPrHzpqeQBEzGHWAhpYBxxccHHCyfOBy/M/1efkK23/1Gu6PCYgvZvFRev7CS
         oyXXwmMtT/8uBeAQOr0Owx+hKtj7hbpephJlzNWc6KDkbW3cmFkFOU6zWbk/G2+axiVN
         1xk7/L3wHu98vL7k0uNTrHpMGM5Tk/SkTv0mPCmqPEDnl9es7xzdJNOWnUBlZ9gES0Nw
         gMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757508617; x=1758113417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxQmUaO34FNds/dKkUVjytcJcTLUNu+HbjN0DdBAszU=;
        b=CvQDoGiwoNIOd5B1dZ43bCZk+QrxrUjATRUrIFCK7az5QP17t2A1IfF1M0J11ArZCx
         xQi0Hqxb0nfc9O2smy1hzZy5ldAdgVdEojgB1z9oT2xp/UzoGGB6JB+1dNTWyoRBQeAC
         3F83f+9LzG+v4hTPFRTx4NeO/6f3KoRYdpUcSu1j6akMbeMAP6dMxJXT5lYGZ05XpeJG
         YprrIEyQcLqoYoDMlxuO/4ugDet1GLGvsvM60pXGU52HYGd+pi+QfCMJ3ZP8u0mCkhzE
         CN6H2oY/1/I2GDMTao6rlS3bllP5v49iovLDWN1Ktp5bWNKxJP+jastyOIA2iVZQwAnd
         jPxg==
X-Forwarded-Encrypted: i=1; AJvYcCVQdjC+2SP9EnjfkGQwKV+zoYJn5q8WtpEUCNcjl9tM1Swvkv8NgCRAJ4XVScPQph7+FG3/kg7gTNAhHLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPjPVOf0hfQZD23LDUVLnnmtPNjnhJOwuVv1C+abvUj2Dcgm7
	057EsAROB6E3CrkVVhtGHurBULA74WWngTUz1/x/4LWbkk3MVLnb3suwhMCqrL0qcEEzzXMNMKW
	jPL/1fVZlICzU71HsaDwjCBKeC5iL79szR0z/Xy5K
X-Gm-Gg: ASbGncvJ04lw9jJ30DSBVOKfd3z/m7tM9tQRKJGSMQ8lRr/ytk7fRFOpIcJnzTp+08J
	CBCw+pWUAPN5nYUyMqySBK5UBVs7hfQRdpm9psVo77dVSdAscO9OLAZ4+pihyw4Bo1Quy/KPGO8
	f0gu2O7ftv9XKeXL3iJIyzCD6hGOXr6uUr7hvYBK87dauzPk5XScrDQb0bEGdPf3D9cE4jONtGr
	FemHHjoiu/cIGzaHLpgM2yRbm+mMpyd1Yqrvt53YJMUDKQ=
X-Google-Smtp-Source: AGHT+IEbxhh8cTjZB/V6q92Pchj2dBc2ScpYmlbGUllxoq8p9L1AznFEPoNTObajMnViT6wWxEvxi59ZyfF2QEWst5g=
X-Received: by 2002:a05:600c:1993:b0:45b:8b3e:9f66 with SMTP id
 5b1f17b1804b1-45dddeb93b3mr123082635e9.13.1757508616333; Wed, 10 Sep 2025
 05:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909170013.16025-1-work@onurozkan.dev> <20250909170013.16025-2-work@onurozkan.dev>
 <aMEaE2NEU2FctgH2@google.com> <20250910135848.1ea11519@nimda.home>
 <CAH5fLggb=_Vtk74RONc+pQUSc1XrVi=jdD1=mHNs6-67ZCYB0A@mail.gmail.com> <20250910154746.03a3bc2f@nimda.home>
In-Reply-To: <20250910154746.03a3bc2f@nimda.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 14:50:03 +0200
X-Gm-Features: AS18NWDWXd1HXdc12LmAivcw38d0hGJ5DtWRvFLZjwivmB8y9UPifJXdqpKPH4A
Message-ID: <CAH5fLgjT3LLpg-CjdbR5_+sgBZEsrCP-c4eJt=E3NmtVDKMJ5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original value
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com, 
	tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, a.hindborg@kernel.org, 
	lossin@kernel.org, bjorn3_gh@protonmail.com, gary@garyguo.net, 
	boqun.feng@gmail.com, alex.gaynor@gmail.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:47=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> On Wed, 10 Sep 2025 13:05:42 +0200
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Wed, Sep 10, 2025 at 12:59=E2=80=AFPM Onur =C3=96zkan <work@onurozka=
n.dev>
> > wrote:
> > >
> > > On Wed, 10 Sep 2025 06:26:27 +0000
> > > Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > > On Tue, Sep 09, 2025 at 08:00:13PM +0300, Onur =C3=96zkan wrote:
> > > > > Current `to_result` helper takes a `c_int` and returns `Ok(())`
> > > > > on success and this has some issues like:
> > > > >
> > > > >     - Callers lose the original return value and often have to
> > > > > store it in a temporary variable before calling `to_result`.
> > > > >
> > > > >     - It only supports `c_int`, which makes callers to
> > > > > unnecessarily cast when working with other types (e.g. `u16` in
> > > > > phy abstractions). We even have some places that ignore to use
> > > > >     `to_result` helper because the input doesn't fit in `c_int`
> > > > >     (see [0]).
> > > > >
> > > > > [0]:
> > > > > https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
> > > > >
> > > > > This patch changes `to_result` to be generic and also return the
> > > > > original value on success.
> > > > >
> > > > > So that the code that previously looked like:
> > > > >
> > > > >     let ret =3D unsafe { bindings::some_ffi_call() };
> > > > >     to_result(ret).map(|()| SomeType::new(ret))
> > > > >
> > > > > can now be written more directly as:
> > > > >
> > > > >     to_result(unsafe { bindings::some_ffi_call() })
> > > > >     .map(|ret| SomeType::new(ret))
> > > > >
> > > > > Similarly, code such as:
> > > > >
> > > > >     let res: isize =3D $some_ffi_call();
> > > > >     if res < 0 {
> > > > >         return Err(Error::from_errno(res as i32));
> > > > >     }
> > > > >
> > > > > can now be used with `to_result` as:
> > > > >
> > > > >     to_result($some_ffi_call())?;
> > > > >
> > > > > This patch only fixes the callers that broke after the changes
> > > > > on `to_result`. I haven't included all the improvements made
> > > > > possible by the new design since that could conflict with other
> > > > > ongoing patches [1]. Once this patch is approved and applied, I
> > > > > am planning to follow up with creating a "good first issue" on
> > > > > [2] for those additional changes.
> > > > >
> > > > > [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
> > > > > [2]: https://github.com/Rust-for-Linux/linux
> > > > >
> > > > > Link:
> > > > > https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic=
/x/near/536374456
> > > > > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > > >
> > > > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > > > index a41de293dcd1..6563ea71e203 100644
> > > > > --- a/rust/kernel/error.rs
> > > > > +++ b/rust/kernel/error.rs
> > > > > @@ -376,12 +376,19 @@ fn from(e: core::convert::Infallible) ->
> > > > > Error { pub type Result<T =3D (), E =3D Error> =3D
> > > > > core::result::Result<T, E>;
> > > > >
> > > > >  /// Converts an integer as returned by a C kernel function to
> > > > > an error if it's negative, and -/// `Ok(())` otherwise.
> > > > > -pub fn to_result(err: crate::ffi::c_int) -> Result {
> > > > > -    if err < 0 {
> > > > > -        Err(Error::from_errno(err))
> > > > > +/// returns the original value otherwise.
> > > > > +pub fn to_result<T>(code: T) -> Result<T>
> > > > > +where
> > > > > +    T: Copy + TryInto<i32>,
> > > > > +{
> > > > > +    // Try casting into `i32`.
> > > > > +    let casted: crate::ffi::c_int =3D
> > > > > code.try_into().unwrap_or(0); +
> > > > > +    if casted < 0 {
> > > > > +        Err(Error::from_errno(casted))
> > > > >      } else {
> > > > > -        Ok(())
> > > > > +        // Return the original input value.
> > > > > +        Ok(code)
> > > > >      }
> > > > >  }
> > > >
> > > > I don't think this is the best way to declare this function. The
> > > > conversions I would want are:
> > > >
> > > > * i32 -> Result<u32>
> > > > * isize -> Result<usize>
> > > > * i64 -> Result<u64>
> > > >
> > > > Your commit messages mentions i16, but does the error types even
> > > > fit in 16 bits? Maybe. But they don't fit in i8. That is to say,
> > > > I think it should support all the types larger than i32 (the
> > > > errors fit in those types too), but for the ones that are
> > > > smaller, it might not make sense if the type is too small. That's
> > > > the reverse of what you have now.
> > > >
> > > > We probably need a new trait. E.g.:
> > > >
> > > > trait ToResult {
> > > >     type Unsigned;
> > > >     fn to_result(self) -> Result<Self::Unsigned, Error>;
> > > > }
> > > >
> > > > impl ToResult for i32 {
> > > >     type Unsigned =3D u32;
> > > >     fn to_result(self) -> Result<u32, Error> {
> > > >         ...
> > > >     }
> > > > }
> > > >
> > > > impl ToResult for isize {
> > > >     type Unsigned =3D usize;
> > > >     fn to_result(self) -> Result<usize, Error> {
> > > >         ...
> > > >     }
> > > > }
> > > >
> > > > pub fn to_result<T: ToResult>(code: T) -> Result<T::Unsigned> {
> > > >     T::to_result(code)
> > > > }
> > > >
> > >
> > > `Error::from_errno` is limited to i32, that's why I followed the
> > > `TryInto<i32>` approach, but I like this design too.
> >
> > If you pass an i32 that is not a valid errno, then it becomes EINVAL.
> > In the case of `isize`, I would say that if a negative isize does not
> > fit in i32, then that should fall into the same scenario.
> >
>
> In that case replacing `unwrap_or(0)` with `map_err(|_| code::EINVAL)`
> should do the job?
>
> I also thought of an alternative to the custom-trait=E2=80=93based approa=
ch.
> What do you think about something like this:
>
>     pub fn to_result<T, R>(code: T) -> Result<R>
>     where
>         T: Copy + TryInto<i32> + TryInto<R>,
>     {
>         // Try casting into `i32`.
>         let casted: crate::ffi::c_int =3D code.try_into().map_err(|_|
>     code::EINVAL)?;
>
>         if casted < 0 {
>             Err(Error::from_errno(casted))
>         } else {
>             // Return the original input value as `R`.
>             code.try_into().map_err(|_| code::EINVAL)
>         }
>     }
>
>
> On the caller side, it would look like this:
>
>     let val: u16 =3D to_result(...)?;
>
> The main difference here is that this version can be used to cast into
> multiple different types, not just `i32 -> u32` or `i64 -> u64`.

I think making the return type a separate generic makes this too
difficult to use. It means that any time you would write this:

to_result(unsafe { ... })?;
Ok(())

now you need to tell the compiler what kind of integer you want to get
from to_result, just so you can immediately ignore the integer.

Alice

