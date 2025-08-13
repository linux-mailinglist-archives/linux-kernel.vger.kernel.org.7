Return-Path: <linux-kernel+bounces-766579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A9B24893
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0414E4E240D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F592F7453;
	Wed, 13 Aug 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdvK7816"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B274420;
	Wed, 13 Aug 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085158; cv=none; b=k4xVFWue0sia1n4E8urXWAHHq9I6p3ybH0x2Sx+GnpqBh2N/CCELt6KT1LzhVgQDQK9BzQnDQSP3EGiyHnUBM9oPArna2CI3YxaGxYSC/vbvKO27wdoFpe/J3ntB5P+EGztF2zPqVtHlkmzpOV0uYSQa5BuVdjXKTGRq7e9rXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085158; c=relaxed/simple;
	bh=5IhWcO6Hlh8+7Bh9KVR8E9e7jvvQP/xcEdo0b6n7GpM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=W6nzr2tnV4SZUN6XdcOWc5iSjn7XZKSTv1OjGkidL9vM1AoB7rB2VSSv0jaovfjE9ciWCYkiIUoGhL5iaaXZ06DjVvaD2HasYFI8KSN3XFGCsWoEvcPMiSc/Z7PZScEvRztOmC31UHXZ8+IXHFJyCQyTYkm/2W4r5bKaCKmcj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdvK7816; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98326C4CEEB;
	Wed, 13 Aug 2025 11:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755085157;
	bh=5IhWcO6Hlh8+7Bh9KVR8E9e7jvvQP/xcEdo0b6n7GpM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bdvK7816x427a1xdfXtGxAsNJFmHCD9Ct09EqV7Eaa2KDYZ3vB53SYbbttqizc9wC
	 1mgVzmvtnoVtlTU7rW/p0+BXLRJYOyapTOkcnbvKvH0dhDCjM23tviej/L7oYjJFyO
	 2b6+2YoSr+QcGsvLrhxqQz3JeEtCMhdfSj2nZPf7GqxOs4LrISczAwFKGzZ7MsYof7
	 OyIw+EkPjD20+0YLhhTzav91/rMqhezlACZtsUiAI3Db7rF5DoD6UZVypfmLF/C2iB
	 UW9PrUXcHlGlXR6Q7qlABBH5x/nebN5tkiJPoHHIg3a4mVGBl+6KxFvlPKPBce8dXZ
	 mlZfZ9iyu98aw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 13:39:12 +0200
Message-Id: <DC19RGJ4EPSK.1QRTOMYUKY34@kernel.org>
Subject: Re: [PATCH v4 3/4] rust: miscdevice: Provide additional
 abstractions for iov_iter and kiocb structures
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Arnd Bergmann" <arnd@arndb.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Matthew Maurer" <mmaurer@google.com>,
 "Lee Jones" <lee@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
 <20250813-iov-iter-v4-3-c4f1932b05ef@google.com>
In-Reply-To: <20250813-iov-iter-v4-3-c4f1932b05ef@google.com>

On Wed Aug 13, 2025 at 10:27 AM CEST, Alice Ryhl wrote:
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 0121b38c59e63d01a89f22c8ef6983ef5c3234de..6ba6bdf143cb991c6e7821517=
8eb585260215da0 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -6,3 +6,6 @@
> =20
>  pub mod file;
>  pub use self::file::{File, LocalFile};
> +
> +mod kiocb;
> +pub use self::kiocb::Kiocb;
> diff --git a/rust/kernel/fs/kiocb.rs b/rust/kernel/fs/kiocb.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..84c936cd69b0e9b490d54c87d=
8c7279b27d4476a
> --- /dev/null
> +++ b/rust/kernel/fs/kiocb.rs
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Kernel IO callbacks.
> +//!
> +//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
> +
> +use core::marker::PhantomData;
> +use core::ptr::NonNull;
> +use kernel::types::ForeignOwnable;
> +
> +/// Wrapper for the kernel's `struct kiocb`.
> +///
> +/// Currently this abstractions is incomplete and is essentially just a =
tuple containing a
> +/// reference to a file and a file position.
> +///
> +/// The type `T` represents the filesystem or driver specific data assoc=
iated with the file.
> +///
> +/// # Invariants
> +///
> +/// `inner` points at a valid `struct kiocb` whose file has the type `T`=
 as its private data.
> +pub struct Kiocb<'a, T> {
> +    inner: NonNull<bindings::kiocb>,
> +    _phantom: PhantomData<&'a T>,
> +}
> +
> +impl<'a, T: ForeignOwnable> Kiocb<'a, T> {
> +    /// Create a `Kiocb` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must reference a valid `struct kiocb` for the durati=
on of `'a`. The private
> +    /// data of the file must be `T`.
> +    pub unsafe fn from_raw(kiocb: *mut bindings::kiocb) -> Self {
> +        Self {
> +            // SAFETY: If a pointer is valid it is not null.
> +            inner: unsafe { NonNull::new_unchecked(kiocb) },
> +            _phantom: PhantomData,
> +        }
> +    }
> +
> +    /// Access the underlying `struct kiocb` directly.
> +    pub fn as_raw(&self) -> *mut bindings::kiocb {
> +        self.inner.as_ptr()
> +    }
> +
> +    /// Get the filesystem or driver specific data associated with the f=
ile.
> +    pub fn file(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
> +        // SAFETY: We have shared access to this kiocb and hence the und=
erlying file, so we can
> +        // read the file's private data.
> +        let private =3D unsafe { (*(*self.as_raw()).ki_filp).private_dat=
a };
> +        // SAFETY: The kiocb has shared access to the private data.
> +        unsafe { <T as ForeignOwnable>::borrow(private) }
> +    }
> +
> +    /// Gets the current value of `ki_pos`.
> +    pub fn ki_pos(&self) -> i64 {
> +        // SAFETY: We have shared access to the kiocb, so we can read it=
s `ki_pos` field.
> +        unsafe { (*self.as_raw()).ki_pos }
> +    }
> +
> +    /// Gets a mutable reference to the `ki_pos` field.
> +    pub fn ki_pos_mut(&mut self) -> &mut i64 {
> +        // SAFETY: We have exclusive access to the kiocb, so we can writ=
e to `ki_pos`.
> +        unsafe { &mut (*self.as_raw()).ki_pos }
> +    }
> +}

I think this should be a separate commit.

