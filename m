Return-Path: <linux-kernel+bounces-721809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88CAFCE20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A899580674
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776C2E0937;
	Tue,  8 Jul 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UutgnWHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBC258CE5;
	Tue,  8 Jul 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985923; cv=none; b=Tk1DFmFK8Y5/rG9iBqC08znvnU7jqm+tox9qYuDWoQKNqj2CdXnpMT6lbNJ1WxX0gRdNOUSXIJrrAd0YaJa02IhjRGJDQcP7nmisUNPRf57htv6ChSXKL4GlfIWLKNAshCWv2wWAJhGQN7g7hLlgEO6DY6d1jsmh+RD05IBzaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985923; c=relaxed/simple;
	bh=7jjkHURGk/065PgIsLEFdU7q9C06GLDiDvsLEbi8k2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPFV+GPt/OWj3JHwYVkmwf0RITrma+H3p95ZUTTWf7p7Zb9u+7ETwVzNUgvenSlY4fiFlKq3pASiaO+K/ZszywGmB+L1OocBDr3T4xkSvEnPTh5e2S03zBeU6e2makIBwMYcNFvy75oWfuYzW9xv/oE9CVAmBncET7CT1Jh4JQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UutgnWHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16503C4CEEF;
	Tue,  8 Jul 2025 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985923;
	bh=7jjkHURGk/065PgIsLEFdU7q9C06GLDiDvsLEbi8k2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UutgnWHg3QVONCzVearw6Brv2lUVM1xl6Ze3mBmrkoVjgerWPlN7KmPfk+khJb5xz
	 9J8Yg8gJUleH7DO+hvNvz3uYnIfCOZU+WKug5h6EDUkfGj0KKhrWUq6oihYUdObChr
	 ITN+HSJJ/49i0A00hy1ZcKwymSOCMZWo7+gNHAoSLMzW7e3+aub01vFVLCLsWrJirP
	 elgD8vdZWlG1JevFPkt0SoLdLCOoaOJ88siVXjNcEDKLkIGbyIxlehHo07jaGo2UT/
	 elW0CKpkOf0zBg4boPuUp5SjpyCdydJwrQ5pNve7KegBkNdcQCdqMWnD/f5/7WDEo7
	 JTx3BVxJCbFXw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Matthew Maurer" <mmaurer@google.com>,  "Lee Jones"
 <lee@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  "Benno Lossin" <lossin@kernel.org>
Subject: Re: [PATCH v2 1/4] rust: iov: add iov_iter abstractions for
 ITER_SOURCE
In-Reply-To: <20250704-iov-iter-v2-1-e69aa7c1f40e@google.com> (Alice Ryhl's
	message of "Fri, 04 Jul 2025 09:26:00 +0000")
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
	<U16UjMBBh1b7dLeO-Nhqw__nw_JwypctB1ze_G44BtsX0l_eVK6Sp-efbobmnuF44J0wQNgnK7b8nCmBX0KS_Q==@protonmail.internalid>
	<20250704-iov-iter-v2-1-e69aa7c1f40e@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 16:45:14 +0200
Message-ID: <878qkyoi6d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> This adds abstractions for the iov_iter type in the case where
> data_source is ITER_SOURCE. This will make Rust implementations of
> fops->write_iter possible.
>
> This series only has support for using existing IO vectors created by C
> code. Additional abstractions will be needed to support the creation of
> IO vectors in Rust code.
>
> These abstractions make the assumption that `struct iov_iter` does not
> have internal self-references, which implies that it is valid to move it
> between different local variables.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/iov.rs | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs |   1 +
>  2 files changed, 153 insertions(+)
>
> diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..b4d7ec14c57a561a01cd65b6bdf0f94b1b373b84
> --- /dev/null
> +++ b/rust/kernel/iov.rs
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! IO vectors.
> +//!
> +//! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
> +//! [`include/linux/uio.h`](srctree/include/linux/uio.h)
> +
> +use crate::{
> +    alloc::{Allocator, Flags},
> +    bindings,
> +    prelude::*,
> +    types::Opaque,
> +};
> +use core::{marker::PhantomData, mem::MaybeUninit, slice};
> +
> +const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
> +
> +/// An IO vector that acts as a source of data.
> +///
> +/// The data may come from many different sources. This includes both things in kernel-space and
> +/// reading from userspace. It's not necessarily the case that the data source is immutable, so
> +/// rewinding the IO vector to read the same data twice is not guaranteed to result in the same
> +/// bytes. It's also possible that the data source is mapped in a thread-local manner using e.g.
> +/// `kmap_local_page()`, so this type is not `Send` to ensure that the mapping is read from the
> +/// right context in that scenario.
> +///
> +/// # Invariants
> +///
> +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
> +/// of `'data`, it must be safe to read the data in this IO vector.

In my opinion, the phrasing you had in v1 was better:

  The buffers referenced by the IO vector must be valid for reading for
  the duration of `'data`.

That is, I would prefer "must be valid for reading" over "it must be
safe to read ...".

> +#[repr(transparent)]
> +pub struct IovIterSource<'data> {
> +    iov: Opaque<bindings::iov_iter>,
> +    /// Represent to the type system that this value contains a pointer to readable data it does
> +    /// not own.
> +    _source: PhantomData<&'data [u8]>,
> +}
> +
> +impl<'data> IovIterSource<'data> {
> +    /// Obtain an `IovIterSource` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * For the duration of `'iov`, the `struct iov_iter` must remain valid and must not be
> +    ///   accessed except through the returned reference.
> +    /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
> +    ///   reading.
> +    #[track_caller]
> +    #[inline]
> +    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterSource<'data> {
> +        // SAFETY: The caller ensures that `ptr` is valid.
> +        let data_source = unsafe { (*ptr).data_source };
> +        assert_eq!(data_source, ITER_SOURCE);
> +
> +        // SAFETY: The caller ensures the struct invariants for the right durations.
> +        unsafe { &mut *ptr.cast::<IovIterSource<'data>>() }
> +    }
> +
> +    /// Access this as a raw `struct iov_iter`.
> +    #[inline]
> +    pub fn as_raw(&mut self) -> *mut bindings::iov_iter {
> +        self.iov.get()
> +    }
> +
> +    /// Returns the number of bytes available in this IO vector.
> +    ///
> +    /// Note that this may overestimate the number of bytes. For example, reading from userspace
> +    /// memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        // SAFETY: It is safe to access the `count` field.

Reiterating my comment from v1: Why?

> +        unsafe {
> +            (*self.iov.get())
> +                .__bindgen_anon_1
> +                .__bindgen_anon_1
> +                .as_ref()
> +                .count
> +        }
> +    }
> +
> +    /// Returns whether there are any bytes left in this IO vector.
> +    ///
> +    /// This may return `true` even if there are no more bytes available. For example, reading from
> +    /// userspace memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
> +    #[inline]
> +    pub fn is_empty(&self) -> bool {
> +        self.len() == 0
> +    }
> +
> +    /// Advance this IO vector by `bytes` bytes.
> +    ///
> +    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
> +    #[inline]
> +    pub fn advance(&mut self, bytes: usize) {
> +        // SAFETY: `self.iov` is a valid IO vector.
> +        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
> +    }
> +
> +    /// Advance this IO vector backwards by `bytes` bytes.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The IO vector must not be reverted to before its beginning.
> +    #[inline]
> +    pub unsafe fn revert(&mut self, bytes: usize) {
> +        // SAFETY: `self.iov` is a valid IO vector, and `bytes` is in bounds.
> +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
> +    }
> +
> +    /// Read data from this IO vector.
> +    ///
> +    /// Returns the number of bytes that have been copied.
> +    #[inline]
> +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
> +        // SAFETY: We will not write uninitialized bytes to `out`.

Can you provide something to back this claim?


Best regards,
Andreas Hindborg



