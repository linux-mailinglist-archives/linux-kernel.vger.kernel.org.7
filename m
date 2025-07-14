Return-Path: <linux-kernel+bounces-729782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D183B03B73
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CAE3BBA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA79243371;
	Mon, 14 Jul 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY/AEwHB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184324291C;
	Mon, 14 Jul 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486859; cv=none; b=dT4aNK+IKnXYMHhGdlacTZ7Dc8d+dm9d5rUc/XfJmHTV0xbIpNwav6Pg0SXJiDmCRsZi+A16k3aRkXfIPn9Qe0DuLHAbpiBpPCbnn+Mh+XP+G3ga09/waI3ElElHHbbVMucvKw8Rw76o6IinWmSDKTsFeOZNc35bibji8UmwCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486859; c=relaxed/simple;
	bh=Sm3eiLV4kStXDWKx6U4SBDM2lCQIVC/K/9Bi01tpfjY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=sO3NhAjn2hNh0cu/Ih/F47NIUJB8lCx/ZW1zOyFgvswmOQlsFRPTdLMWNbqXK2JnzadXlIK8dKvaesOz2f11ncIhR0YDBcbwWcozTU6N/aDFddeQXrn6VjdoBV0qy9/hJP5XOhY+4VhH5CltODXWI7xnIuH3um1woWz8V0Kv6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY/AEwHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672EC4CEED;
	Mon, 14 Jul 2025 09:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752486855;
	bh=Sm3eiLV4kStXDWKx6U4SBDM2lCQIVC/K/9Bi01tpfjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WY/AEwHBn0K4zxiVE/Mvzb4ddg1YNQchRTLCar/ssDK3RJZ0U+IsCmOn7eO2lGTyd
	 k6BrxoVGUlNwyiVUepUPOo2R4kQEvof5v/nOegkkKFeTMwBBOEOLUz4S+8OkzF3cSa
	 F6bzUgVF2GP0psgTnmZ5Mpg66HVoLA1LnG5K60YozrnxNm2R+WZFh4VYpnNRd45osF
	 oqadaAwBc7PYLPGROGxylvfE4udBKMxXyo4IxlKyq1gRFvTX+v16HmkCXazeutl2nD
	 zGieM0nEjmg6CYqUIqqfA2LoHkHM1weKXlSMjzdv+jBlniKYoQzjsEaJLeDojx9XG2
	 SEONkHFiGhg9Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 11:54:10 +0200
Message-Id: <DBBOQP2KELBM.IWOU5PB0KR27@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/4] rust: move ARef and AlwaysRefCounted to
 sync::aref
X-Mailer: aerc 0.20.1
References: <20250713213614.188921-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250713213614.188921-1-shankari.ak0208@gmail.com>

On Sun Jul 13, 2025 at 11:36 PM CEST, Shankari Anand wrote:
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> new file mode 100644
> index 000000000000..c62dbb28282e
> --- /dev/null
> +++ b/rust/kernel/sync/aref.rs
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Built-in Reference Counting Support
> +
> +/// Types that are _always_ reference counted.
> +///
> +/// It allows such types to define their own custom ref increment and de=
crement functions.
> +/// Additionally, it allows users to convert from a shared reference `&T=
` to an owned reference
> +/// [`ARef<T>`].
> +///
> +/// This is usually implemented by wrappers to existing structures on th=
e C side of the code. For
> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to=
 create reference-counted
> +/// instances of a type.
> +use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonN=
ull};

This line seems misplaced?

> +
> +/// # Safety
> +///
> +/// Implementers must ensure that increments to the reference count keep=
 the object alive in memory
> +/// at least until matching decrements are performed.
> +///
> +/// Implementers must also ensure that all instances are reference-count=
ed. (Otherwise they
> +/// won't be able to honour the requirement that [`AlwaysRefCounted::inc=
_ref`] keep the object
> +/// alive.)
> +pub unsafe trait AlwaysRefCounted {
> +    /// Increments the reference count on the object.
> +    fn inc_ref(&self);
> +
> +    /// Decrements the reference count on the object.
> +    ///
> +    /// Frees the object when the count reaches zero.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that there was a previous matching increment=
 to the reference count,
> +    /// and that the object is no longer used after its reference count =
is decremented (as it may
> +    /// result in the object being freed), unless the caller owns anothe=
r increment on the refcount
> +    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> +    /// [`AlwaysRefCounted::dec_ref`] once).
> +    unsafe fn dec_ref(obj: NonNull<Self>);
> +}

> +impl<T: AlwaysRefCounted> Drop for ARef<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the `ARef` owns th=
e reference we're about to
> +        // decrement.
> +        unsafe { T::dec_ref(self.ptr) };
> +    }
> +}
> +
> +/// A sum type that always holds either a value of type `L` or `R`.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::types::Either;
> +///
> +/// let left_value: Either<i32, &str> =3D Either::Left(7);
> +/// let right_value: Either<i32, &str> =3D Either::Right("right value");
> +/// ```
> +pub enum Either<L, R> {
> +    /// Constructs an instance of [`Either`] containing a value of type =
`L`.
> +    Left(L),
> +
> +    /// Constructs an instance of [`Either`] containing a value of type =
`R`.
> +    Right(R),
> +}

What is the `Either` type doing here? Maybe a copy-paste mistake?

---
Cheers,
Benno

