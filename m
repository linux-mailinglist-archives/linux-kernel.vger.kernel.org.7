Return-Path: <linux-kernel+bounces-756362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9AB1B31A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E8D180FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B426CE2A;
	Tue,  5 Aug 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbx3yAa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328B242D79;
	Tue,  5 Aug 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395813; cv=none; b=oGYfQ0giLzzj09De9VHfe6eWsER6jqmiHcBMs5bDFo2XP1bgSHPNgYj0JTu8AEf1nTnrQih/MbKfeKBsYkCrwWRspIZ/cMb/1x1VcxFmLitDyjzc1g58pEWJFU+EDJezoFX26o1U6JJjwPUg65PdMIKjT/X28VDy4PjT1BczWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395813; c=relaxed/simple;
	bh=XWJ526Oo5Ih2m2C6bWeJOL052qvES/f6SpIjgwWwAQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lj/AHzjyv3svuYo/M/jAue/GVyobgXSBhinD2B9MLdF1RV8SVXZYe8ziERMJ12A8liNbSMHasWZBagQPDCZQkg6vVg4FNGQz60+P8iSqvqRlLpVBzBdIHhw765WPZ3YCQITxKnfeXTcHBHfw6md0OgR3s67tDU+z9DICy55vTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbx3yAa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC0FC4CEF9;
	Tue,  5 Aug 2025 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754395813;
	bh=XWJ526Oo5Ih2m2C6bWeJOL052qvES/f6SpIjgwWwAQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rbx3yAa/fLSz/sHa2WqBhOwpnxRQPo7vwLSft4CE3WoWayBeRkPLVHFH5DpHYS2Yn
	 Y02oUhxxxtYKd5q338HF/cN8R9lhTfLuKKeW7PfcFZhhLM6I6toXdfYTOfiLWQwxEq
	 N4A5GDUj9v+LmwG2tPzqW/6q1kMpDaXUSAhdcdkrEFvN+RLIxBGqo4VATkBaDX8BkW
	 01szr/X4EFt2UpRnFPu08JBh9tvsV/oEZGD8eahdt6D9TxIRfcTITzz56XomQyud/6
	 7+U77hU1Y61gV+n4l5Rg5zzuRfz+WVtH5mXL42OXeZuJrT+XB6yBgIfV9alVztC7sx
	 lLBMQj4a8xASQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>,
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Alice
 Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 3/4] rust: miscdevice: Provide additional
 abstractions for iov_iter and kiocb structures
In-Reply-To: <20250722-iov-iter-v3-3-3efc9c2c2893@google.com>
References: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
 <E6U80MwGVnLCOldmKdZUJDhmh8r-6yjQfvaEQTSgC3YjpfvauNRQ2wM4mMZzhXTW2LisXtk-0y5MYt5SPEHU6Q==@protonmail.internalid>
 <20250722-iov-iter-v3-3-3efc9c2c2893@google.com>
Date: Tue, 05 Aug 2025 14:10:01 +0200
Message-ID: <87v7n27yw6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> These will be used for the read_iter() and write_iter() callbacks, which
> are now the preferred back-ends for when a user operates on a char device
> with read() and write() respectively.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Co-developed-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/fs.rs         |  3 +++
>  rust/kernel/fs/kiocb.rs   | 67 +++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/miscdevice.rs | 63 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 132 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 0121b38c59e63d01a89f22c8ef6983ef5c3234de..6ba6bdf143cb991c6e78215178eb585260215da0 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -6,3 +6,6 @@
>
>  pub mod file;
>  pub use self::file::{File, LocalFile};
> +
> +mod kiocb;
> +pub use self::kiocb::Kiocb;
> diff --git a/rust/kernel/fs/kiocb.rs b/rust/kernel/fs/kiocb.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..837f4be7cb8fbca6e3f9aeff74d1c904df3ff7ff
> --- /dev/null
> +++ b/rust/kernel/fs/kiocb.rs
> @@ -0,0 +1,67 @@
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
> +/// Currently this abstractions is incomplete and is essentially just a tuple containing a
> +/// reference to a file and a file position.
> +///
> +/// The type `T` represents the private data of the underlying file.

In my opinion, this paragraph could use some clarification:

  The type `T` represents the filesystem or driver specific data
  associated with the file.

> +///
> +/// # Invariants
> +///
> +/// `inner` points at a valid `struct kiocb` whose file has the type `T` as its private data.
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
> +    /// The pointer must reference a valid `struct kiocb` for the duration of `'a`. The private
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
> +    /// Get the Rust data stored in the private data of the file.

I would suggest:

  Get the filesystem or driver specific data associated with the file.

> +    pub fn file(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
> +        // SAFETY: The `kiocb` lets us access the private data.

This safety comment is strange. I like what you did in patch 1:

++        // SAFETY: We have shared access to this IO vector, so we can read its `count` field.

> +        let private = unsafe { (*(*self.as_raw()).ki_filp).private_data };
> +        // SAFETY: The kiocb has shared access to the private data.
> +        unsafe { <T as ForeignOwnable>::borrow(private) }
> +    }
> +
> +    /// Gets the current value of `ki_pos`.
> +    pub fn ki_pos(&self) -> i64 {
> +        // SAFETY: The `kiocb` can access `ki_pos`.

Same.

> +        unsafe { (*self.as_raw()).ki_pos }
> +    }
> +
> +    /// Gets a mutable reference to the `ki_pos` field.
> +    pub fn ki_pos_mut(&mut self) -> &mut i64 {
> +        // SAFETY: The `kiocb` can access `ki_pos`.

Same.


Best regards,
Andreas Hindborg



