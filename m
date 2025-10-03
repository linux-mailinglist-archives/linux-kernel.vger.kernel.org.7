Return-Path: <linux-kernel+bounces-841838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150BBB85F1
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7931F19E3872
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70C277013;
	Fri,  3 Oct 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="esbGjvY5"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC5269CF1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533146; cv=none; b=tASiwQBVMWY2RWLzGdnX/7oM3JkSUj19LG6e5XW3yH9GxJ7KO6vfoxL/AJD8fvEKgYO0jyS38x7o2mXjLUZ8MvjC1w6/6rshSp8Q5s5FnnPG8Rw9wsgk1UK6Wv4+imRMaiG0hu7yOfdH9zW+fbbivG12LUhMlDjJgAzcp+oM4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533146; c=relaxed/simple;
	bh=wjDCmsK+fq06af1fCrbfRqcQ4am7/P0vgnzPCJDRAQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgd6i3abGZGWU2fIKycJwtDdBfH8wWy8N96GbsUVVoPCob268DI4vv4MofifRsPd9wq1iNRL1Vllx5OpQT6V8m15r8q/tZnmn13e8Oo3GLA5gfOCzlYRTJAy3X8PiUPs7kBJZxMzHS4xRxAvh5EGFEjhhXCVbr4jiRqwVGB9Ixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=esbGjvY5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so2299a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533143; x=1760137943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa7+UjUUhItNXpyy4gGeXX7e9AExegepugcBUZf1voo=;
        b=esbGjvY5RSM6LwXAykNioBrhA+9WyefdvLyzAym3qit/xOAS6RaSc8wfYnbjSW6F9n
         pd8fy3nMKVMF+DjyXQXSd0kZScVFZ4wGkt0WsWEzUIOIcr7lFNzPekgQtv6396NnxcP/
         yxA+vBdky30LhjtCxfjGpSXxvXqI5JEDHCZQMrjfon57V8XGTecZgCyFh3D2/Boy3soI
         4HobT09TlzdKloB7WDldNQB0Ajz6yDpXROwVuR4eddYjFErl6ypb2QeKGqOG6Ft1XkbI
         vPzgKCDSVyGKUXGG+m/4rLT1fB+EwZ+69dMHfS3OZbOibH2S/etQGTJaJNDirT10eoQR
         KXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533143; x=1760137943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sa7+UjUUhItNXpyy4gGeXX7e9AExegepugcBUZf1voo=;
        b=rSPajXd7vVKTUJ6eYZYoDg6AHRtiVN3BFVq22L8t8aknxqeuTWL/uekJBt97tDTdxg
         3uJwQU/Pwvg5tNNPfSxMPejSrWBqnDJh1M4qI7QrOxZ9zAbXj8DlaFfPlXGtrB8DIskX
         BG+rHKbUyTnLSp5nQHFrBNmcR+Hi/5f3mhj/QXysBOKlRMClSVsaV+VyvKq16WkNiC36
         RbjrAXTDMIbdGod5QdIFThzN0OI9iT5nu5Pwq12qXovNWBACzU/Na/bUl6KletD5FaA4
         qQ4ux4oQGIqC6lD0gFdYuCrpEI2XwvTd2AY+JaAbrKCNJr0s363MXt9bWkgU1mo5SJCJ
         3BBg==
X-Forwarded-Encrypted: i=1; AJvYcCX9IMfRoNFS3MEo2TR84EI+MvOLCy7YJ9aCpQIyHfIVMhgjiTMUOLYhHTqnP11X6XFyMzCHmDnENPHatQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQSD7ord1cNelSWwLSFlX4EFDyWQCGkfg7UPtNmOvzEaGx+WqK
	C4iif+Su98ZMdZLEyRUpb0WXjTBmKtOZF9eFMZuue062uynas5am00B+CITiGcjz5KfvQ3hQov3
	5Jv1nP00ug5usChZv2za+9l0XraiW7wFWDd+cKsnv
X-Gm-Gg: ASbGncvWr5w2ijLBDx4X2ezIjl113MF/WMK4v/d5dLrA+uy3vwRW9dwce1mXiBM46w5
	o8S2D4enWDOvT3Q2tSdjjrGoTjM1VH4G3OzIYghIAVIRNhv4hWRCNpHGtA2NOezhMSpiWnq/X6i
	Csveejwp7qNULeLPynPT1tPlw1jW6/Ky8iJm6+VCnhms4KPPaNoNbNkHzSAFZZzhyy+NUrOVLa+
	vG5uPHEmeTbvQq67VFMox+dejRnkT1qZ0eWcz1oTFu7n3GamI0nGgfeMW+B7IBJ7hQ=
X-Google-Smtp-Source: AGHT+IHJFMzYqwJxQONYYwooqAWeKipZbOKejzmyeCNLGSSzGla7A5YFNjA8AAZFnIqGzwo22FCg8xDa3nyGSwBnYAU=
X-Received: by 2002:a05:6402:52c2:b0:633:10ba:136f with SMTP id
 4fb4d7f45d1cf-63962f97267mr42207a12.1.1759533142870; Fri, 03 Oct 2025
 16:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-5-dakr@kernel.org>
In-Reply-To: <20251003222729.322059-5-dakr@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Fri, 3 Oct 2025 16:12:11 -0700
X-Gm-Features: AS18NWAXfvQn1-lxPHHLqval_szOjB8rSFdCIrZzr-AwGwThR93QkQIBJdyXdUE
Message-ID: <CAGSQo02ASwf3Wn21jgB804LMLi3qivhtZuo7SmmD9O4m5O_Qfw@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: debugfs: support blobs from smart pointers
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 3:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Extend Rust debugfs binary support to allow exposing data stored in
> common smart pointers and heap-allocated collections.
>
> - Implement BinaryWriter for Box<T>, Pin<Box<T>>, Arc<T>, and Vec<T>.
> - Introduce BinaryReaderMut for mutable binary access with outer locks.
> - Implement BinaryReaderMut for Box<T>, Vec<T>, and base types.
> - Update BinaryReader to delegate to BinaryReaderMut for Mutex<T>,
>   Box<T>, Pin<Box<T>> and Arc<T>.
>
> This enables debugfs files to directly expose or update data stored
> inside heap-allocated, reference-counted, or lock-protected containers
> without manual dereferencing or locking.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/debugfs.rs        |   2 +-
>  rust/kernel/debugfs/traits.rs | 145 +++++++++++++++++++++++++++++++++-
>  2 files changed, 144 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index b1a3adca7fd4..3c3bbcc126ef 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -21,7 +21,7 @@
>  use core::ops::Deref;
>
>  mod traits;
> -pub use traits::{BinaryReader, BinaryWriter, Reader, Writer};
> +pub use traits::{BinaryReader, BinaryReaderMut, BinaryWriter, Reader, Wr=
iter};
>
>  mod callback_adapters;
>  use callback_adapters::{FormatAdapter, NoWriter, WritableAdapter};
> diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.r=
s
> index 60a6ee6c6b58..bcd0a9db3cc9 100644
> --- a/rust/kernel/debugfs/traits.rs
> +++ b/rust/kernel/debugfs/traits.rs
> @@ -3,11 +3,14 @@
>
>  //! Traits for rendering or updating values exported to DebugFS.
>
> +use crate::alloc::Allocator;
>  use crate::prelude::*;
> +use crate::sync::Arc;
>  use crate::sync::Mutex;
>  use crate::transmute::{AsBytes, FromBytes};
>  use crate::uaccess::{UserSliceReader, UserSliceWriter};
>  use core::fmt::{self, Debug, Formatter};
> +use core::ops::{Deref, DerefMut};
>  use core::str::FromStr;
>  use core::sync::atomic::{
>      AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, A=
tomicU32, AtomicU64,
> @@ -50,12 +53,14 @@ pub trait BinaryWriter {
>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize=
) -> Result<usize>;
>  }
>
> +// Base implementation for any `T: AsBytes`.
>  impl<T: AsBytes> BinaryWriter for T {
>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize=
) -> Result<usize> {
>          writer.write_slice_partial(self.as_bytes(), offset)
>      }
>  }
>
> +// Delegate for `Mutex<T>`: Support a `T` with an outer mutex.
>  impl<T: BinaryWriter> BinaryWriter for Mutex<T> {
>      fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize=
) -> Result<usize> {
>          let guard =3D self.lock();
> @@ -64,6 +69,56 @@ fn write_to_slice(&self, writer: &mut UserSliceWriter,=
 offset: usize) -> Result<
>      }
>  }
>
> +// Delegate for `Box<T, A>`: Support a `Box<T, A>` with no lock or an in=
ner lock.
> +impl<T, A> BinaryWriter for Box<T, A>
> +where
> +    T: BinaryWriter,
> +    A: Allocator,
> +{
> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize=
) -> Result<usize> {
> +        self.deref().write_to_slice(writer, offset)
> +    }
> +}
> +
> +// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with no loc=
k or an inner lock.
> +impl<T, A> BinaryWriter for Pin<Box<T, A>>
> +where
> +    T: BinaryWriter,
> +    A: Allocator,
> +{
> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize=
) -> Result<usize> {
> +        self.deref().write_to_slice(writer, offset)
> +    }
> +}
> +
> +// Delegate for `Arc<T>`: Support a `Arc<T>` with no lock or an inner lo=
ck.
> +impl<T> BinaryWriter for Arc<T>
> +where
> +    T: BinaryWriter,
> +{
> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize=
) -> Result<usize> {
> +        self.deref().write_to_slice(writer, offset)
> +    }
> +}

For `Box`, `Pin<Box<`, and `Arc`, where the only operation being
performed is to deref, is there a reason that we couldn't have the
`File` object be *inside* the object, thus avoiding any need for
these? I can't see them causing trouble, but

```
Box<File<T>>
Pin<Box<File<T>>>
Arc<File<T>>
```

seem like they'd usually be fine. The one caveat I can think of is
that if you had other functions that wanted to take an `&Arc<T>` for
operations on the Arc, then having an `Arc<File<T>>` would be
suboptimal. Am I missing something?

Depending on the use case I'm missing, would a blanket implementation
for `T: Deref` in this case and `DerefMut` later on make more sense?
That should contract these into a single definition and generalize to
e.g. `ListArc` without further code.

> +
> +// Delegate for `Vec<T, A>`.
> +impl<T, A> BinaryWriter for Vec<T, A>
> +where
> +    T: AsBytes,
> +    A: Allocator,
> +{
> +    fn write_to_slice(&self, writer: &mut UserSliceWriter, offset: usize=
) -> Result<usize> {
> +        let slice =3D self.as_slice();
> +
> +        // SAFETY: `T: AsBytes` allows us to treat `&[T]` as `&[u8]`.
> +        let buffer =3D unsafe {
> +            core::slice::from_raw_parts(slice.as_ptr().cast(), core::mem=
::size_of_val(slice))
> +        };
> +
> +        writer.write_slice_partial(buffer, offset)
> +    }
> +}
> +
>  /// A trait for types that can be updated from a user slice.
>  ///
>  /// This works similarly to `FromStr`, but operates on a `UserSliceReade=
r` rather than a &str.
> @@ -92,6 +147,70 @@ fn read_from_slice(&self, reader: &mut UserSliceReade=
r) -> Result {
>  }
>
>  /// Trait for types that can be constructed from a binary representation=
.
> +///
> +/// See also [`BinaryReader`] for interior mutability.
> +pub trait BinaryReaderMut {
> +    /// Reads the binary form of `self` from `reader`.
> +    ///
> +    /// Same as [`BinaryReader::read_from_slice`], but takes a mutable r=
eference.
> +    ///
> +    /// `offset` is the requested offset into the binary representation =
of `self`.
> +    ///
> +    /// On success, returns the number of bytes read from `reader`.
> +    fn read_from_slice_mut(&mut self, reader: &mut UserSliceReader, offs=
et: usize)
> +        -> Result<usize>;
> +}
> +
> +// Base implementation for any `T: AsBytes + FromBytes`.
> +impl<T: AsBytes + FromBytes> BinaryReaderMut for T {
> +    fn read_from_slice_mut(
> +        &mut self,
> +        reader: &mut UserSliceReader,
> +        offset: usize,
> +    ) -> Result<usize> {
> +        reader.read_slice_partial(self.as_bytes_mut(), offset)
> +    }
> +}
> +
> +// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an outer lock.
> +impl<T: ?Sized + BinaryReaderMut, A: Allocator> BinaryReaderMut for Box<=
T, A> {
> +    fn read_from_slice_mut(
> +        &mut self,
> +        reader: &mut UserSliceReader,
> +        offset: usize,
> +    ) -> Result<usize> {
> +        self.deref_mut().read_from_slice_mut(reader, offset)
> +    }
> +}
> +
> +// Delegate for `Vec<T, A>`: Support a `Vec<T, A>` with an outer lock.
> +impl<T, A> BinaryReaderMut for Vec<T, A>
> +where
> +    T: AsBytes + FromBytes,
> +    A: Allocator,
> +{
> +    fn read_from_slice_mut(
> +        &mut self,
> +        reader: &mut UserSliceReader,
> +        offset: usize,
> +    ) -> Result<usize> {
> +        let slice =3D self.as_mut_slice();
> +

Nit: This is safe, but it also requires `FromBytes`, and is &mut, &mut

> +        // SAFETY: `T: AsBytes` allows us to treat `&[T]` as `&[u8]`.
> +        let buffer =3D unsafe {
> +            core::slice::from_raw_parts_mut(
> +                slice.as_mut_ptr().cast(),
> +                core::mem::size_of_val(slice),
> +            )
> +        };
> +
> +        reader.read_slice_partial(buffer, offset)
> +    }
> +}
> +
> +/// Trait for types that can be constructed from a binary representation=
.
> +///
> +/// See also [`BinaryReaderMut`] for the mutable version.
>  pub trait BinaryReader {
>      /// Reads the binary form of `self` from `reader`.
>      ///
> @@ -101,11 +220,33 @@ pub trait BinaryReader {
>      fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usiz=
e) -> Result<usize>;
>  }
>
> -impl<T: AsBytes + FromBytes> BinaryReader for Mutex<T> {
> +// Delegate for `Mutex<T>`: Support a `T` with an outer `Mutex`.
> +impl<T: BinaryReaderMut> BinaryReader for Mutex<T> {
>      fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usiz=
e) -> Result<usize> {
>          let mut this =3D self.lock();
>
> -        reader.read_slice_partial(this.as_bytes_mut(), offset)
> +        this.read_from_slice_mut(reader, offset)
> +    }
> +}
> +
> +// Delegate for `Box<T, A>`: Support a `Box<T, A>` with an inner lock.
> +impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Box<T, A> =
{
> +    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usiz=
e) -> Result<usize> {
> +        self.deref().read_from_slice(reader, offset)
> +    }
> +}
> +
> +// Delegate for `Pin<Box<T, A>>`: Support a `Pin<Box<T, A>>` with an inn=
er lock.
> +impl<T: ?Sized + BinaryReader, A: Allocator> BinaryReader for Pin<Box<T,=
 A>> {
> +    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usiz=
e) -> Result<usize> {
> +        self.deref().read_from_slice(reader, offset)
> +    }
> +}
> +
> +// Delegate for `Arc<T>`: Support an `Arc<T>` with an inner lock.
> +impl<T: ?Sized + BinaryReader> BinaryReader for Arc<T> {
> +    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: usiz=
e) -> Result<usize> {
> +        self.deref().read_from_slice(reader, offset)
>      }
>  }
>
> --
> 2.51.0
>

