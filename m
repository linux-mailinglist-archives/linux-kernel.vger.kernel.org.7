Return-Path: <linux-kernel+bounces-768218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F2B25E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0383A4420
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB972E62CB;
	Thu, 14 Aug 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBWkJxXa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38D27A12B;
	Thu, 14 Aug 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158816; cv=none; b=fQhlQNOI5PE+CDve6sxPVJgcPYoPxjKwG+vGQcBf64XKJhR8xwZVWyCWTpRVljTlnTZO5IOxPlWamvZjRVRQgf98PGiW8toZiFZr4Zw4quCW5VneW7XQOEjAEqoIAgJes5QimgLZoxCtK2vYzsrGD9qzPclLv2Dpgk4/GvM9/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158816; c=relaxed/simple;
	bh=cICgknm5aE0tdDgyfidlUK1Hbu9WfKnqPKmWMA3QDyk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=VbVP5vhWZjhVKUaqmT70D5pURFlTO4Rnmsx9/QSXj6QZryWxTZdPjuWOn9PQXy8tweosrAdtresWdvGm+zYcpErL82fLLlcJmH0tfbW15D856hAkDEEdXoSuplnRYEQ8V/bjWzF+QdHSZO40eWIJeIPi1nmFSx2BCWJdbpjfElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBWkJxXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B7FC4CEEF;
	Thu, 14 Aug 2025 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755158815;
	bh=cICgknm5aE0tdDgyfidlUK1Hbu9WfKnqPKmWMA3QDyk=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=WBWkJxXaYlnmb0wwTZrD5h2yYfkZzlw31h6V8C1NZJfblLkryaWBiS0ZPuZ4bn4Md
	 g7rmnBokkG6JpC4V4d/QUmjf8q3zX091wSXtHCCuhF1xNDzoAnPcM6i7FW7zTxPD4e
	 INRSopUL17efivYxJq2dMqgyqQ17yHn7qPS0TAuMsViWrDDZuqyoO3woMqgInIIUz+
	 8g1msaKFsLWAhg9TKEeh3D5GUMxcKZq8TjEVrXjpxr9YeLB/1s2lmIPPtcMYc/lCqK
	 8ontYLD0tKRLpdyiUfgyxk6wDqtG4xsbEmFk/0SQYxa2mjRhEx9pUinTjt7sUonjWt
	 VnBM52ufi7cGA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 10:06:50 +0200
Message-Id: <DC1ZVE8AM8GJ.3UZBQBW7HOFE3@kernel.org>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Christian S. Lima" <christiansantoslima21@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~lkcamp/patches@lists.sr.ht>,
 <richard120310@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
In-Reply-To: <20250811213851.65644-1-christiansantoslima21@gmail.com>

On Mon Aug 11, 2025 at 11:38 PM CEST, Christian S. Lima wrote:
> @@ -9,27 +11,136 @@
>  ///
>  /// It's okay for the type to have padding, as initializing those bytes =
has no effect.
>  ///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::transmute::FromBytes;
> +///
> +/// let foo =3D [1, 2, 3, 4];
> +///
> +/// let result =3D u32::from_bytes(&foo)?;
> +///
> +/// #[cfg(target_endian =3D "little")]
> +/// assert_eq!(*result, 0x4030201);
> +///
> +/// #[cfg(target_endian =3D "big")]
> +/// assert_eq!(*result, 0x1020304);
> +/// ```
> +///
> +/// # Safety
> +///
> +/// All bit-patterns must be valid for this type. This type must not hav=
e interior mutability.
> +pub unsafe trait FromBytes {
> +    /// Converts a slice of bytes to a reference to `Self` when the refe=
rence
> +    /// is properly aligned and the size of slice is equal to that of `T=
`
> +    /// and is different from zero. In another case, it will return
> +    ///`None`.

The first line in any documentation should be a single, short sentence.
Also separate it from the contents by a newline, otherwise markdown will
render it as a single paragraph.

> +    fn from_bytes(bytes: &[u8]) -> Option<&Self>;
> +
> +    /// Converts a mutable slice of bytes to a reference to `Self`
> +    /// when the reference is properly aligned and the size of slice
> +    /// is equal to that of `T` and is different from zero. In another
> +    /// case, it will return `None`.
> +    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
> +    where
> +        Self: AsBytes;
> +}

> +
> +// SAFETY: If all bit patterns are acceptable for individual values in a=
n array, then all bit
> +// patterns are also acceptable for arrays of that type.
> +unsafe impl<T: FromBytes> FromBytes for [T] {
> +    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
> +        let size =3D ::core::mem::size_of::<T>();
> +        build_assert!(size =3D=3D 0, "Can't create a slice with zero ele=
ments");

This message is wrong, it sounds as if the size of `bytes` was zero and
you can definitely create a slice with zero elements.

> +        let slice_ptr =3D bytes.as_ptr().cast::<T>();
> +        if bytes.len() % size =3D=3D 0 && slice_ptr.is_aligned() {
> +            // SAFETY: Since the number of elements is different from
> +            // zero and the pointer is aligned, the slice is valid.

Please take a look at the documentation of `from_raw_parts`, there are
several bullet points of safety requirements. Please provide a
justification for each one and also place them in a bullet point list.

---
Cheers,
Benno

> +            unsafe { Some(::core::slice::from_raw_parts(slice_ptr, bytes=
.len() / size)) }
> +        } else {
> +            None
> +        }
> +    }
> +
> +    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
> +    where
> +        Self: AsBytes,
> +    {
> +        let size =3D ::core::mem::size_of::<T>();
> +        build_assert!(size =3D=3D 0, "Can't create a slice with zero ele=
ments");
> +        let slice_ptr =3D bytes.as_mut_ptr().cast::<T>();
> +        if bytes.len() % size =3D=3D 0 && slice_ptr.is_aligned() {
> +            // SAFETY: Since the number of elements is different from
> +            // zero and the pointer is aligned, the slice is valid.
> +            unsafe {
> +                Some(::core::slice::from_raw_parts_mut(
> +                    slice_ptr,
> +                    bytes.len() / size,
> +                ))
> +            }
> +        } else {
> +            None
> +        }
> +    }
>  }
> =20
>  /// Types that can be viewed as an immutable slice of initialized bytes.


