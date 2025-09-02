Return-Path: <linux-kernel+bounces-796217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F13B3FD6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353193B404E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE62E92C5;
	Tue,  2 Sep 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="prf6gx4t"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C362F5485
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811482; cv=none; b=CzG8fceDrPyIeFOkc9EbDEkPpKqutxrXKkM24u4g7FiIOuPc8tg9dO+fMB6fo5Cq/JjXDd3VahShhG7UunfMCwvj7GdO8tB8JQhlfC4o6Srd8v3WVNP0jgbtgsRHIHJiFzIk/Jm6VkBN5hPwt6xp+8JtVtFzGO/gp5gwIZfZp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811482; c=relaxed/simple;
	bh=Jom8/sZ3aSp54aDEujFrIag5qt/vyvcqIXIU8/2T2Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fft8rljeikFb41pfpNW2OckScoUBRF9iN796SjiAIak3+8X4XdGubA1CaOAPfPz1swmiqq6671zhnNt0wSxH83YWQgUG+gVn6keERtld1mkvKZtHRoN4a3IwHWTPupPLD8QPui8GfDUbLury3935EuDhtzSVVihYFnT2+xmoCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=prf6gx4t; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso1449439b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1756811479; x=1757416279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UV1sMwcvCvsZIFksmQ+pAP9LWZs0hsijkfOdYKNHGOo=;
        b=prf6gx4tQjZfwK7P/FINtWtlIUtRwkIf9BlXMdbI0V1f24gU7CqaFD+Z7mCZ81umEB
         Y8rNTofb9zkonwRLJO0lh/HPyGjBUCXzKssj0J7hpuBNIhPCXMm27+lyy8ccCt5+t5eS
         0uqK7GNx+Kja+1gyYAGKy093EAQCopEfZB7dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811479; x=1757416279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UV1sMwcvCvsZIFksmQ+pAP9LWZs0hsijkfOdYKNHGOo=;
        b=hhQV+UvaXot5JZ9VTewq6BNcE3R7EJ31383X0MacbX6m/+AsanyD3PULvyKhqRFjQ4
         Bv/dXkGN6i8c5WqLkcsIFCoZ4ZeufZNM7VjMI/JTBlBkBOnNiFyei7IsgT3isli5ojRU
         k36qt9SuwGKR6l9Wk1Qx8THVe0WBguQzxk36EvgUbKPmlU9KtFfgW+qkeyHdc7EnsQto
         BJ2BaedQ9F8Zl4SSE3vvmEJoHQ/ZPzCKL4LYlCby2sTSeSbmQmfg5iGwZ808SrUN2QVB
         AK7RLgthlcw1SweURVCnIC0bg28tAKNK1M5CLL41t5vXz/GkOjm9iQBfj2RJA3CqEvOs
         IKkA==
X-Forwarded-Encrypted: i=1; AJvYcCWFI/DIgN8QWO/XHVuDKLAPSU9nTt0kjBzt5dX4ilWpG+rFVN0/2SK564knWRMKSIQgJDTCoR4AP3ChHdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4S1pI/W/2aeT6e2LkwcIO9iKalmI9yHGyBUowAWnruHDWkoN
	ui82rib8GjgBrHCm1Yl2HGolnYtdkirvMN8lwk0aEPEHl1qjuczrPWYWhunNxDXIycE=
X-Gm-Gg: ASbGnctPPNDhpUDvq2KRUQKifVBIqPDeEHvpnYPePAiyhZBU6oU+iFofhYSA5Hkh4P6
	QJ7kgh+95jEcUBAcCnA0ItfDebBEVJhg9YGLLDNjTfBepg9fFmbfJ4q38epCP5IBFzyYcqLFR0c
	uvHg8YXC7lF8VSOqQbzgUJZ8qeqIpf/WSgoTmcOvI0NLxgkLGmPvQ4of3CtlqUh9wlH2nwMtV0x
	rb4zDvAa1VLyoMMMN/mg2aWkhw3RhyAdsIBHKwSjbDZJK6D1Ie0mQGsoDN47loHGj0Bww8qklRS
	tqwywn5dDVKR7hxKshPsMMYKwZTvqII5Fe2LwMf64XK58+1z67X4d5OsrmzUbc6Th0rIC+qJ/bP
	Hoqw1d7u/HHN5MgD5kuYFKbKnQt/M/HlGsPPYwQvvFlEpjejQcRMOKg==
X-Google-Smtp-Source: AGHT+IGRO9SuQdLMSbPbP0TxZEUJXcDOc/VejYeKDaipJ8M3W9u2cNilXzHIajif3LULvBfIeWSZ3A==
X-Received: by 2002:a05:6a00:1828:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-772499e9e23mr13805530b3a.18.1756811479125;
        Tue, 02 Sep 2025 04:11:19 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26abbbsm13180460b3a.5.2025.09.02.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:11:18 -0700 (PDT)
Date: Tue, 2 Sep 2025 20:11:13 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v3 3/5] rust: io_uring: introduce rust abstraction
 for io-uring cmd
Message-ID: <aLbQ0TPUegON738P@sidongui-MacBookPro.local>
References: <20250822125555.8620-1-sidong.yang@furiosa.ai>
 <20250822125555.8620-4-sidong.yang@furiosa.ai>
 <CADUfDZqBZStBW2ef4Dav4AO7BZMF9O9tzmbzSJnSvsSRP7r4HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqBZStBW2ef4Dav4AO7BZMF9O9tzmbzSJnSvsSRP7r4HA@mail.gmail.com>

On Mon, Sep 01, 2025 at 06:11:01PM -0700, Caleb Sander Mateos wrote:
> On Fri, Aug 22, 2025 at 5:56 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > Implment the io-uring abstractions needed for miscdevicecs and other
> 
> typo: "Implement"

Thanks.
> 
> > char devices that have io-uring command interface.
> >
> > * `io_uring::IoUringCmd` : Rust abstraction for `io_uring_cmd` which
> >   will be used as arg for `MiscDevice::uring_cmd()`. And driver can get
> >   `cmd_op` sent from userspace. Also it has `flags` which includes option
> >   that is reissued.
> >
> > * `io_uring::IoUringSqe` : Rust abstraction for `io_uring_sqe` which
> >   could be get from `IoUringCmd::sqe()` and driver could get `cmd_data`
> >   from userspace. Also `IoUringSqe` has more data like opcode could be used in
> >   driver.
> >
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >  rust/kernel/io_uring.rs | 306 ++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs      |   1 +
> >  2 files changed, 307 insertions(+)
> >  create mode 100644 rust/kernel/io_uring.rs
> >
> > diff --git a/rust/kernel/io_uring.rs b/rust/kernel/io_uring.rs
> > new file mode 100644
> > index 000000000000..61e88bdf4e42
> > --- /dev/null
> > +++ b/rust/kernel/io_uring.rs
> > @@ -0,0 +1,306 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-FileCopyrightText: (C) 2025 Furiosa AI
> > +
> > +//! Abstractions for io-uring.
> > +//!
> > +//! This module provides types for implements io-uring interface for char device.
> > +//!
> > +//!
> > +//! C headers: [`include/linux/io_uring/cmd.h`](srctree/include/linux/io_uring/cmd.h) and
> > +//! [`include/linux/io_uring/io_uring.h`](srctree/include/linux/io_uring/io_uring.h)
> > +
> > +use core::{mem::MaybeUninit, pin::Pin};
> > +
> > +use crate::error::from_result;
> > +use crate::transmute::{AsBytes, FromBytes};
> > +use crate::{fs::File, types::Opaque};
> > +
> > +use crate::prelude::*;
> > +
> > +/// io-uring opcode
> > +pub mod opcode {
> > +    /// opcode for uring cmd
> > +    pub const URING_CMD: u32 = bindings::io_uring_op_IORING_OP_URING_CMD;
> > +}
> > +
> > +/// A Rust abstraction for the Linux kernel's `io_uring_cmd` structure.
> > +///
> > +/// This structure is a safe, opaque wrapper around the raw C `io_uring_cmd`
> > +/// binding from the Linux kernel. It represents a command structure used
> > +/// in io_uring operations within the kernel.
> > +/// This type is used internally by the io_uring subsystem to manage
> > +/// asynchronous I/O commands.
> > +///
> > +/// This type should not be constructed or manipulated directly by
> > +/// kernel module developers.
> > +///
> > +/// # INVARIANT
> > +/// - `self.inner` always points to a valid, live `bindings::io_uring_cmd`.
> > +#[repr(transparent)]
> > +pub struct IoUringCmd {
> > +    /// An opaque wrapper containing the actual `io_uring_cmd` data.
> > +    inner: Opaque<bindings::io_uring_cmd>,
> > +}
> > +
w> > +impl IoUringCmd {
> > +    /// Returns the cmd_op with associated with the `io_uring_cmd`.
> > +    #[inline]
> > +    pub fn cmd_op(&self) -> u32 {
> > +        // SAFETY: `self.inner` is guaranteed by the type invariant to point
> > +        // to a live `io_uring_cmd`, so dereferencing is safe.
> > +        unsafe { (*self.inner.get()).cmd_op }
> > +    }
> > +
> > +    /// Returns the flags with associated with the `io_uring_cmd`.
> > +    #[inline]
> > +    pub fn flags(&self) -> u32 {
> > +        // SAFETY: `self.inner` is guaranteed by the type invariant to point
> > +        // to a live `io_uring_cmd`, so dereferencing is safe.
> > +        unsafe { (*self.inner.get()).flags }
> > +    }
> > +
> > +    /// Reads protocol data unit as `T` that impl `FromBytes` from uring cmd
> > +    ///
> > +    /// Fails with [`EFAULT`] if size of `T` is bigger than pdu size.
> > +    #[inline]
> > +    pub fn read_pdu<T: FromBytes>(&self) -> Result<T> {
> > +        // SAFETY: `self.inner` is guaranteed by the type invariant to point
> > +        // to a live `io_uring_cmd`, so dereferencing is safe.
> > +        let inner = unsafe { &mut *self.inner.get() };
> 
> Why does this reference need to be mutable?

It don't need to be mutable. This could be borrow without mutable.
> 
> > +
> > +        let len = size_of::<T>();
> > +        if len > inner.pdu.len() {
> > +            return Err(EFAULT);
> > +        }
> > +
> > +        let mut out: MaybeUninit<T> = MaybeUninit::uninit();
> 
> Why is the intermediate MaybeUninit necessary? Would
> core::ptr::read_unaligned() not work?

It's okay to use `read_unaligned`. It would be simpler than now. Thanks.

> 
> > +        let ptr = &raw mut inner.pdu as *const c_void;
> > +
> > +        // SAFETY:
> > +        // * The `ptr` is valid pointer from `self.inner` that is guaranteed by type invariant.
> > +        // * The `out` is valid pointer that points `T` which impls `FromBytes` and checked
> > +        //   size of `T` is smaller than pdu size.
> > +        unsafe {
> > +            core::ptr::copy_nonoverlapping(ptr, out.as_mut_ptr().cast::<c_void>(), len);
> > +        }
> > +
> > +        // SAFETY: The read above has initialized all bytes in `out`, and since `T` implements
> > +        // `FromBytes`, any bit-pattern is a valid value for this type.
> > +        Ok(unsafe { out.assume_init() })
> > +    }
> > +
> > +    /// Writes the provided `value` to `pdu` in uring_cmd `self`
> > +    ///
> > +    /// Fails with [`EFAULT`] if size of `T` is bigger than pdu size.
> > +    #[inline]
> > +    pub fn write_pdu<T: AsBytes>(&mut self, value: &T) -> Result<()> {
> > +        // SAFETY: `self.inner` is guaranteed by the type invariant to point
> > +        // to a live `io_uring_cmd`, so dereferencing is safe.
> > +        let inner = unsafe { &mut *self.inner.get() };
> > +
> > +        let len = size_of::<T>();
> > +        if len > inner.pdu.len() {
> > +            return Err(EFAULT);
> > +        }
> > +
> > +        let src = (value as *const T).cast::<c_void>();
> > +        let dst = &raw mut inner.pdu as *mut c_void;
> > +
> > +        // SAFETY:
> > +        // * The `src` is points valid memory that is guaranteed by `T` impls `AsBytes`
> > +        // * The `dst` is valid. It's from `self.inner` that is guaranteed by type invariant.
> > +        // * It's safe to copy because size of `T` is no more than len of pdu.
> > +        unsafe {
> > +            core::ptr::copy_nonoverlapping(src, dst, len);
> > +        }
> > +
> > +        Ok(())
> > +    }
> > +
> > +    /// Constructs a new [`IoUringCmd`] from a raw `io_uring_cmd`
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must guarantee that:
> > +    /// - `ptr` is non-null, properly aligned, and points to a valid
> > +    ///   `bindings::io_uring_cmd`.
> > +    /// - The pointed-to memory remains initialized and valid for the entire
> > +    ///   lifetime `'a` of the returned reference.
> > +    /// - While the returned `Pin<&'a mut IoUringCmd>` is alive, the underlying
> > +    ///   object is **not moved** (pinning requirement).
> > +    /// - **Aliasing rules:** the returned `&mut` has **exclusive** access to the same
> > +    ///   object for its entire lifetime:
> > +    ///   - No other `&mut` **or** `&` references to the same `io_uring_cmd` may be
> > +    ///     alive at the same time.
> > +    ///   - There must be no concurrent reads/writes through raw pointers, FFI, or
> > +    ///     other kernel paths to the same object during this lifetime.
> > +    ///   - If the object can be touched from other contexts (e.g. IRQ/another CPU),
> > +    ///     the caller must provide synchronization to uphold this exclusivity.
> > +    /// - This function relies on `IoUringCmd` being `repr(transparent)` over
> > +    ///   `bindings::io_uring_cmd` so the cast preserves layout.
> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::io_uring_cmd) -> Pin<&'a mut IoUringCmd> {
> > +        // SAFETY:
> > +        // * The caller guarantees that the pointer is not dangling and stays
> > +        //   valid for the duration of 'a.
> > +        // * The cast is okay because `IoUringCmd` is `repr(transparent)` and
> > +        //   has the same memory layout as `bindings::io_uring_cmd`.
> > +        // * The returned `Pin` ensures that the object cannot be moved, which
> > +        //   is required because the kernel may hold pointers to this memory
> > +        //   location and moving it would invalidate those pointers.
> > +        unsafe { Pin::new_unchecked(&mut *ptr.cast()) }
> > +    }
> > +
> > +    /// Returns the file that referenced by uring cmd self.
> > +    #[inline]
> > +    pub fn file(&self) -> &File {
> > +        // SAFETY: `self.inner` is guaranteed by the type invariant to point
> > +        // to a live `io_uring_cmd`, so dereferencing is safe.
> > +        let file = unsafe { (*self.inner.get()).file };
> > +
> > +        // SAFETY:
?> > +        // * The `file` points valid file.
> > +        // * refcount is positive after submission queue entry issued.
> > +        // * There is no active fdget_pos region on the file on this thread.
> > +        unsafe { File::from_raw_file(file) }
> > +    }
> > +
> > +    /// Returns an reference to the [`IoUringSqe`] associated with this command.
> > +    #[inline]
> > +    pub fn sqe(&self) -> &IoUringSqe {
> > +        // SAFETY: `self.inner` is guaranteed by the type invariant to point
> > +        // to a live `io_uring_cmd`, so dereferencing is safe.
> > +        let sqe = unsafe { (*self.inner.get()).sqe };
> > +        // SAFETY: The call guarantees that the `sqe` points valid io_uring_sqe.
> > +        unsafe { IoUringSqe::from_raw(sqe) }
> > +    }
> > +
> > +    /// Completes an this [`IoUringCmd`] request that was previously queued.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - This function must be called **only** for a command whose `uring_cmd`
> > +    ///   handler previously returned **`-EIOCBQUEUED`** to io_uring.
> > +    ///
> > +    /// # Parameters
> > +    ///
> > +    /// - `ret`: Result to return to userspace.
> > +    /// - `res2`: Extra for big completion queue entry `IORING_SETUP_CQE32`.
> > +    /// - `issue_flags`: Flags associated with this request, typically the same
> > +    ///   as those passed to the `uring_cmd` handler.
> > +    #[inline]
> > +    pub fn done(self: Pin<&mut IoUringCmd>, ret: Result<i32>, res2: u64, issue_flags: u32) {
> 
> Since this takes the IoUringCmd by reference, it allows a single
> io_uring_cmd to be completed multiple times, which would not be safe.
> This method probably needs to take ownership of the IoUringCmd. Even
> better would be to enforce at compile time that the number of times
> IoUringCmd::done() is called matches the return value from
> uring_cmd(): io_uring_cmd_done() may only be called if uring_cmd()
> returns -EIOCBQUEUED; -EAGAIN will result in another call to
> uring_cmd() and all other return values synchronously complete the
> io_uring_cmd.
> 
> It's also not safe for the caller to pass an arbitrary value for
> issue_flags here; it needs to exactly match what was passed into
> uring_cmd(). Maybe we could introduce a type that couples the
> IoUringCmd and issue_flags passed to uring_cmd()?

Agreed. We could introduce a new type like below

pub struct IoUringCmd<'a> {
    cmd: Pin<&'a mut IoUringCmdInner>,
    issue_flags: IssueFlags,
}

Is `io_uring_cmd_done` should be called in iopoll callback? If so, it's
better to make new type for iopoll and move this function to the type.

> 
> > +        let ret = from_result(|| ret) as isize;
> > +        // SAFETY: The call guarantees that `self.inner` is not dangling and stays valid
> > +        unsafe {
> > +            bindings::io_uring_cmd_done(self.inner.get(), ret, res2, issue_flags);
> > +        }
> > +    }
> > +}
> > +
> > +/// A Rust abstraction for the Linux kernel's `io_uring_sqe` structure.
> > +///
> > +/// This structure is a safe, opaque wrapper around the raw C [`io_uring_sqe`](srctree/include/uapi/linux/io_uring.h)
> > +/// binding from the Linux kernel. It represents a Submission Queue Entry
> > +/// used in io_uring operations within the kernel.
> > +///
> > +/// # Type Safety
> > +///
> > +/// The `#[repr(transparent)]` attribute ensures that this wrapper has
> > +/// the same memory layout as the underlying `io_uring_sqe` structure,
> > +/// allowing it to be safely transmuted between the two representations.
> > +///
> > +/// # Fields
> > +///
> > +/// * `inner` - An opaque wrapper containing the actual `io_uring_sqe` data.
> > +///             The `Opaque` type prevents direct access to the internal
> > +///             structure fields, ensuring memory safety and encapsulation.
> > +///
> > +/// # Usage
> > +///
> > +/// This type represents a submission queue entry that describes an I/O
> > +/// operation to be executed by the io_uring subsystem. It contains
> > +/// information such as the operation type, file descriptor, buffer
> > +/// pointers, and other operation-specific data.
> > +///
> > +/// Users can obtain this type from [`IoUringCmd::sqe()`] method, which
> > +/// extracts the submission queue entry associated with a command.
> > +///
> > +/// This type should not be constructed or manipulated directly by
> > +/// kernel module developers.
> > +///
> > +/// # INVARIANT
> > +/// - `self.inner` always points to a valid, live `bindings::io_uring_sqe`.
> > +#[repr(transparent)]
> > +pub struct IoUringSqe {
> > +    inner: Opaque<bindings::io_uring_sqe>,
> > +}
> > +
> > +impl IoUringSqe {
> > +    /// Reads and interprets the `cmd` field of an `bindings::io_uring_sqe` as a value of type `T`.
> > +    ///
> > +    /// # Safety & Invariants
> > +    /// - Construction of `T` is delegated to `FromBytes`, which guarantees that `T` has no
> > +    ///   invalid bit patterns and can be safely reconstructed from raw bytes.
> > +    /// - **Limitation:** This implementation does not support `IORING_SETUP_SQE128` (larger SQE entries).
> > +    ///   Only the standard `io_uring_sqe` layout is handled here.
> > +    ///
> > +    /// # Errors
> > +    /// * Returns `EINVAL` if the `self` does not hold a `opcode::URING_CMD`.
> > +    /// * Returns `EFAULT` if the command buffer is smaller than the requested type `T`.
> > +    ///
> > +    /// # Returns
> > +    /// * On success, returns a `T` deserialized from the `cmd`.
> > +    /// * On failure, returns an appropriate error as described above.
> > +    pub fn cmd_data<T: FromBytes>(&self) -> Result<T> {
> > +        // SAFETY: `self.inner` guaranteed by the type invariant to point
> > +        // to a live `io_uring_sqe`, so dereferencing is safe.
> > +        let sqe = unsafe { &*self.inner.get() };
> > +
> > +        if u32::from(sqe.opcode) != opcode::URING_CMD {
> 
> io_uring opcodes are u8 values. Can the URING_CMD constant be made a
> u8 instead of converting sqe.opcode here?
> 
> The read of the opcode should also be using read_volatile(), as it may
> lie in the userspace-mapped SQE region, which could be concurrently
> written by another userspace thread. That would probably be buggy
> behavior on the userspace side, but it can cause undefined behavior on
> the kernel side without a volatile read, as the compiler could choose
> to re-read the value multiple times assuming it will get the same
> value each time.

Thanks, opcode should be read with read_volatile(). And I would introduce new type
for opcode.

> 
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // SAFETY: Accessing the `sqe.cmd` union field is safe because we've
> > +        // verified that `sqe.opcode == IORING_OP_URING_CMD`, which guarantees
> > +        // that this union variant is initialized and valid.
> 
> The opcode check isn't necessary. It doesn't provide any assurances
> that this variant of the union is actually initialized, since a buggy
> userspace process could set the opcode without initializing the cmd
> field. It's always valid to access this memory since it's part of the
> SQE region created at io_uring setup time. So I would drop the opcode
> check.
> 
> > +        let cmd = unsafe { sqe.__bindgen_anon_6.cmd.as_ref() };
> > +        let cmd_len = size_of_val(&sqe.__bindgen_anon_6.bindgen_union_field);
> > +
> > +        if cmd_len < size_of::<T>() {
> > +            return Err(EFAULT);
> > +        }
> > +
> > +        let cmd_ptr = cmd.as_ptr() as *mut T;
> > +
> > +        // SAFETY: `cmd_ptr` is valid from `self.inner` which is guaranteed by
> > +        // type variant. And also it points to initialized `T` from userspace.
> > +        let ret = unsafe { core::ptr::read_unaligned(cmd_ptr) };
> 
> Similarly, needs to be volatile. The C uring_cmd() implementations use
> READ_ONCE() to read the cmd field.

Okay, This should use read_volatile too.

Thanks,
Sidong
> 
> Best,
> Caleb
> 
> > +
> > +        Ok(ret)
> > +    }
> > +
> > +    /// Constructs a new `IoUringSqe` from a raw `io_uring_sqe`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must guarantee that:
> > +    /// - `ptr` is non-null, properly aligned, and points to a valid initialized
> > +    ///   `bindings::io_uring_sqe`.
> > +    /// - The pointed-to memory remains valid (not freed or repurposed) for the
> > +    ///   entire lifetime `'a` of the returned reference.
> > +    /// - **Aliasing rules (for `&T`):** while the returned `&'a IoUringSqe` is
> > +    ///   alive, there must be **no mutable access** to the same object through any
> > +    ///   path (no `&mut`, no raw-pointer writes, no FFI/IRQ/other-CPU writers).
> > +    ///   Multiple `&` is fine **only if all of them are read-only** for the entire
> > +    ///   overlapping lifetime.
> > +    /// - This relies on `IoUringSqe` being `repr(transparent)` over
> > +    ///   `bindings::io_uring_sqe`, so the cast preserves layout.
> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(ptr: *const bindings::io_uring_sqe) -> &'a IoUringSqe {
> > +        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
> > +        // duration of 'a. The cast is okay because `IoUringSqe` is `repr(transparent)` and has the
> > +        // same memory layout as `bindings::io_uring_sqe`.
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index ed53169e795c..d38cf7137401 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -91,6 +91,7 @@
> >  pub mod fs;
> >  pub mod init;
> >  pub mod io;
> > +pub mod io_uring;
> >  pub mod ioctl;
> >  pub mod jump_label;
> >  #[cfg(CONFIG_KUNIT)]
> > --
> > 2.43.0
> >

