Return-Path: <linux-kernel+bounces-795418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D46B3F1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF007B0519
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F02DEA75;
	Tue,  2 Sep 2025 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U9P38L9i"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5C2DEA77
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756775476; cv=none; b=er3A0dhcJJibuvQ1bwd1RrRG6BtbIeJO4Px7PFX97MVDZDl5trSn/D2wVVroXP1iSWvI9acbemDtQ7y1zdBamaUhm2nmLXsQ5LgtcQiIsKyMf7MfeFjqrFaU/riDyZeYXx3AP3GMeh8ZXoyR9T6X33imYQZfC6ugWCJFQYNWyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756775476; c=relaxed/simple;
	bh=c5o80o6vcpMuWgLfr/QbjXE31WVM+Ds6u4CqTjk4pqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOVfHHIeckVGKHQP0YQ43R+Ed7sY0x7aD+0m0tJl03P5DNp2J9fKrYPV9zWE9ANsJZLrBnzI4YHfpojEayB9BktzdogILVk/jhSkAdl+LCjS5WrsbBme0kWAS2Ap+3BVJropt77mMKJFTERiUQ2kHzdrUDGGB1dpxMwS4XDVnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U9P38L9i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b157ba91bso393905ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 18:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756775473; x=1757380273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38uOW4o+frMHBzcM3WBeYU4muoSjwmWFfQE8NJYeKYA=;
        b=U9P38L9iT5dAtnoWoF5JF0PCOy+6AOoIqslv0nrwjaovMeMdlxwMQO0b8suHtr8sP4
         xUS5aBiHfzbxSDRZhfMtkMDS1H1jDW1CABQ2eE3A9SfZ9RUKvK2EM6McMRPNphrydIDE
         WL3v48fHsDnkEZcMCs/kDmQxIdc/FdYtkYVkMs/Yew1OSCG3N/T+d0x6sJNypt3PtdKO
         PwexMY/9Ai836dcubUxqC2kL604YQgKwjn58Weg9vnTt2OGWHwINqP81hUWMjUB9RKzA
         H64y/6sK7PY0JZPydcfxVo/C/Y/I8tBjiJQ/VTD10xqu6OQBsFS5RYJ8trv1aN/20M//
         4FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756775473; x=1757380273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38uOW4o+frMHBzcM3WBeYU4muoSjwmWFfQE8NJYeKYA=;
        b=kkzq//kh5Rs3ZNkYb6r2M5g3faeBFvRzp0KkZ//06f+TF65kZPsTrOH92+iJADoNNF
         wfotwqklfeKsOhu46aQCjW+8ripIva/JaIvttQRaK68mqb0mvFmJabt6ClriqWNcyGfx
         IXxCYT3EWlLtHQyR6jkdD3k23tTJlpLO2mH3OqwuJAb4D7cSgp7bg4FXIFfesb2IKHLx
         IkcMPPDw2z584xrIj0vBQn6Brkpf2PZw5N3+2LX053vPU1v/cPwqNxbcNLoZYz35gp7P
         VD3BYKVGV+XSR3qzun36QAyn1CQ/z/mtZrnQ9CDareDlzhtPlJqGcV5xVKLCCAB6bxqq
         N9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV2eINCOCTntBQLdf0MpIM21QR5BlEuDMNAoAdABIgVSpmLQUI36hwDBy0G7fKYySKqbFdNq7qx513EAU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVi7vTFYj07yD6k6SHECUqSUgEJ5sk6i/zJyXiNMPE70VZVJUU
	vx+TUub4z0v6SO58tCHbGsM1ss4tn50yaMwnGFsZVX+/UTlJ846gTGf0DwfPZgVTsKYV4WWXa6R
	9Z62oMznbXz5rH52Msn/YbKQfIc67G4M3+H191ImrWQ==
X-Gm-Gg: ASbGncujCFEbZETabz3O499+Wm9JUYFQUwmJ05cdh+CVk55+RJV2DKl8fck7QBAdliB
	gHmT6Xs2mmxVaOk6KyjOGyA7HOVW6Xnd0J7sz/Uqvc42T7CMYvidFhnmjSEy0q+4Kz/9amAunJQ
	zlJtYTSwR0pH72k6G3XK+dgW0aRswxPCAvnn6LObx48UskRNv6F1moXRafDX68hHKdtlrxq8OlJ
	LEZ9tTwUYgd1HTtBqEAyfc=
X-Google-Smtp-Source: AGHT+IFCRANaiPADhGuhVLJ2X4Zy9sSd2N0H0gVCClzflbzlkrwrHRXRFzPZIgj+6ImN5krIP7X29a3u/LrPDI9n9Ek=
X-Received: by 2002:a17:903:22c6:b0:248:dec9:4d2e with SMTP id
 d9443c01a7336-2491f1386ccmr82657695ad.7.1756775472934; Mon, 01 Sep 2025
 18:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822125555.8620-1-sidong.yang@furiosa.ai> <20250822125555.8620-4-sidong.yang@furiosa.ai>
In-Reply-To: <20250822125555.8620-4-sidong.yang@furiosa.ai>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Sep 2025 18:11:01 -0700
X-Gm-Features: Ac12FXx94fNfg8B0_JhSJhggRcOharrUPBsLlTTVYUUeyVIS9_5UUx2LXH4IxRU
Message-ID: <CADUfDZqBZStBW2ef4Dav4AO7BZMF9O9tzmbzSJnSvsSRP7r4HA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/5] rust: io_uring: introduce rust abstraction for
 io-uring cmd
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:56=E2=80=AFAM Sidong Yang <sidong.yang@furiosa.ai=
> wrote:
>
> Implment the io-uring abstractions needed for miscdevicecs and other

typo: "Implement"

> char devices that have io-uring command interface.
>
> * `io_uring::IoUringCmd` : Rust abstraction for `io_uring_cmd` which
>   will be used as arg for `MiscDevice::uring_cmd()`. And driver can get
>   `cmd_op` sent from userspace. Also it has `flags` which includes option
>   that is reissued.
>
> * `io_uring::IoUringSqe` : Rust abstraction for `io_uring_sqe` which
>   could be get from `IoUringCmd::sqe()` and driver could get `cmd_data`
>   from userspace. Also `IoUringSqe` has more data like opcode could be us=
ed in
>   driver.
>
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>  rust/kernel/io_uring.rs | 306 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs      |   1 +
>  2 files changed, 307 insertions(+)
>  create mode 100644 rust/kernel/io_uring.rs
>
> diff --git a/rust/kernel/io_uring.rs b/rust/kernel/io_uring.rs
> new file mode 100644
> index 000000000000..61e88bdf4e42
> --- /dev/null
> +++ b/rust/kernel/io_uring.rs
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: (C) 2025 Furiosa AI
> +
> +//! Abstractions for io-uring.
> +//!
> +//! This module provides types for implements io-uring interface for cha=
r device.
> +//!
> +//!
> +//! C headers: [`include/linux/io_uring/cmd.h`](srctree/include/linux/io=
_uring/cmd.h) and
> +//! [`include/linux/io_uring/io_uring.h`](srctree/include/linux/io_uring=
/io_uring.h)
> +
> +use core::{mem::MaybeUninit, pin::Pin};
> +
> +use crate::error::from_result;
> +use crate::transmute::{AsBytes, FromBytes};
> +use crate::{fs::File, types::Opaque};
> +
> +use crate::prelude::*;
> +
> +/// io-uring opcode
> +pub mod opcode {
> +    /// opcode for uring cmd
> +    pub const URING_CMD: u32 =3D bindings::io_uring_op_IORING_OP_URING_C=
MD;
> +}
> +
> +/// A Rust abstraction for the Linux kernel's `io_uring_cmd` structure.
> +///
> +/// This structure is a safe, opaque wrapper around the raw C `io_uring_=
cmd`
> +/// binding from the Linux kernel. It represents a command structure use=
d
> +/// in io_uring operations within the kernel.
> +/// This type is used internally by the io_uring subsystem to manage
> +/// asynchronous I/O commands.
> +///
> +/// This type should not be constructed or manipulated directly by
> +/// kernel module developers.
> +///
> +/// # INVARIANT
> +/// - `self.inner` always points to a valid, live `bindings::io_uring_cm=
d`.
> +#[repr(transparent)]
> +pub struct IoUringCmd {
> +    /// An opaque wrapper containing the actual `io_uring_cmd` data.
> +    inner: Opaque<bindings::io_uring_cmd>,
> +}
> +
> +impl IoUringCmd {
> +    /// Returns the cmd_op with associated with the `io_uring_cmd`.
> +    #[inline]
> +    pub fn cmd_op(&self) -> u32 {
> +        // SAFETY: `self.inner` is guaranteed by the type invariant to p=
oint
> +        // to a live `io_uring_cmd`, so dereferencing is safe.
> +        unsafe { (*self.inner.get()).cmd_op }
> +    }
> +
> +    /// Returns the flags with associated with the `io_uring_cmd`.
> +    #[inline]
> +    pub fn flags(&self) -> u32 {
> +        // SAFETY: `self.inner` is guaranteed by the type invariant to p=
oint
> +        // to a live `io_uring_cmd`, so dereferencing is safe.
> +        unsafe { (*self.inner.get()).flags }
> +    }
> +
> +    /// Reads protocol data unit as `T` that impl `FromBytes` from uring=
 cmd
> +    ///
> +    /// Fails with [`EFAULT`] if size of `T` is bigger than pdu size.
> +    #[inline]
> +    pub fn read_pdu<T: FromBytes>(&self) -> Result<T> {
> +        // SAFETY: `self.inner` is guaranteed by the type invariant to p=
oint
> +        // to a live `io_uring_cmd`, so dereferencing is safe.
> +        let inner =3D unsafe { &mut *self.inner.get() };

Why does this reference need to be mutable?

> +
> +        let len =3D size_of::<T>();
> +        if len > inner.pdu.len() {
> +            return Err(EFAULT);
> +        }
> +
> +        let mut out: MaybeUninit<T> =3D MaybeUninit::uninit();

Why is the intermediate MaybeUninit necessary? Would
core::ptr::read_unaligned() not work?

> +        let ptr =3D &raw mut inner.pdu as *const c_void;
> +
> +        // SAFETY:
> +        // * The `ptr` is valid pointer from `self.inner` that is guaran=
teed by type invariant.
> +        // * The `out` is valid pointer that points `T` which impls `Fro=
mBytes` and checked
> +        //   size of `T` is smaller than pdu size.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(ptr, out.as_mut_ptr().cast::<=
c_void>(), len);
> +        }
> +
> +        // SAFETY: The read above has initialized all bytes in `out`, an=
d since `T` implements
> +        // `FromBytes`, any bit-pattern is a valid value for this type.
> +        Ok(unsafe { out.assume_init() })
> +    }
> +
> +    /// Writes the provided `value` to `pdu` in uring_cmd `self`
> +    ///
> +    /// Fails with [`EFAULT`] if size of `T` is bigger than pdu size.
> +    #[inline]
> +    pub fn write_pdu<T: AsBytes>(&mut self, value: &T) -> Result<()> {
> +        // SAFETY: `self.inner` is guaranteed by the type invariant to p=
oint
> +        // to a live `io_uring_cmd`, so dereferencing is safe.
> +        let inner =3D unsafe { &mut *self.inner.get() };
> +
> +        let len =3D size_of::<T>();
> +        if len > inner.pdu.len() {
> +            return Err(EFAULT);
> +        }
> +
> +        let src =3D (value as *const T).cast::<c_void>();
> +        let dst =3D &raw mut inner.pdu as *mut c_void;
> +
> +        // SAFETY:
> +        // * The `src` is points valid memory that is guaranteed by `T` =
impls `AsBytes`
> +        // * The `dst` is valid. It's from `self.inner` that is guarante=
ed by type invariant.
> +        // * It's safe to copy because size of `T` is no more than len o=
f pdu.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(src, dst, len);
> +        }
> +
> +        Ok(())
> +    }
> +
> +    /// Constructs a new [`IoUringCmd`] from a raw `io_uring_cmd`
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must guarantee that:
> +    /// - `ptr` is non-null, properly aligned, and points to a valid
> +    ///   `bindings::io_uring_cmd`.
> +    /// - The pointed-to memory remains initialized and valid for the en=
tire
> +    ///   lifetime `'a` of the returned reference.
> +    /// - While the returned `Pin<&'a mut IoUringCmd>` is alive, the und=
erlying
> +    ///   object is **not moved** (pinning requirement).
> +    /// - **Aliasing rules:** the returned `&mut` has **exclusive** acce=
ss to the same
> +    ///   object for its entire lifetime:
> +    ///   - No other `&mut` **or** `&` references to the same `io_uring_=
cmd` may be
> +    ///     alive at the same time.
> +    ///   - There must be no concurrent reads/writes through raw pointer=
s, FFI, or
> +    ///     other kernel paths to the same object during this lifetime.
> +    ///   - If the object can be touched from other contexts (e.g. IRQ/a=
nother CPU),
> +    ///     the caller must provide synchronization to uphold this exclu=
sivity.
> +    /// - This function relies on `IoUringCmd` being `repr(transparent)`=
 over
> +    ///   `bindings::io_uring_cmd` so the cast preserves layout.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::io_uring_cmd) -> Pin<=
&'a mut IoUringCmd> {
> +        // SAFETY:
> +        // * The caller guarantees that the pointer is not dangling and =
stays
> +        //   valid for the duration of 'a.
> +        // * The cast is okay because `IoUringCmd` is `repr(transparent)=
` and
> +        //   has the same memory layout as `bindings::io_uring_cmd`.
> +        // * The returned `Pin` ensures that the object cannot be moved,=
 which
> +        //   is required because the kernel may hold pointers to this me=
mory
> +        //   location and moving it would invalidate those pointers.
> +        unsafe { Pin::new_unchecked(&mut *ptr.cast()) }
> +    }
> +
> +    /// Returns the file that referenced by uring cmd self.
> +    #[inline]
> +    pub fn file(&self) -> &File {
> +        // SAFETY: `self.inner` is guaranteed by the type invariant to p=
oint
> +        // to a live `io_uring_cmd`, so dereferencing is safe.
> +        let file =3D unsafe { (*self.inner.get()).file };
> +
> +        // SAFETY:
> +        // * The `file` points valid file.
> +        // * refcount is positive after submission queue entry issued.
> +        // * There is no active fdget_pos region on the file on this thr=
ead.
> +        unsafe { File::from_raw_file(file) }
> +    }
> +
> +    /// Returns an reference to the [`IoUringSqe`] associated with this =
command.
> +    #[inline]
> +    pub fn sqe(&self) -> &IoUringSqe {
> +        // SAFETY: `self.inner` is guaranteed by the type invariant to p=
oint
> +        // to a live `io_uring_cmd`, so dereferencing is safe.
> +        let sqe =3D unsafe { (*self.inner.get()).sqe };
> +        // SAFETY: The call guarantees that the `sqe` points valid io_ur=
ing_sqe.
> +        unsafe { IoUringSqe::from_raw(sqe) }
> +    }
> +
> +    /// Completes an this [`IoUringCmd`] request that was previously que=
ued.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - This function must be called **only** for a command whose `uri=
ng_cmd`
> +    ///   handler previously returned **`-EIOCBQUEUED`** to io_uring.
> +    ///
> +    /// # Parameters
> +    ///
> +    /// - `ret`: Result to return to userspace.
> +    /// - `res2`: Extra for big completion queue entry `IORING_SETUP_CQE=
32`.
> +    /// - `issue_flags`: Flags associated with this request, typically t=
he same
> +    ///   as those passed to the `uring_cmd` handler.
> +    #[inline]
> +    pub fn done(self: Pin<&mut IoUringCmd>, ret: Result<i32>, res2: u64,=
 issue_flags: u32) {

Since this takes the IoUringCmd by reference, it allows a single
io_uring_cmd to be completed multiple times, which would not be safe.
This method probably needs to take ownership of the IoUringCmd. Even
better would be to enforce at compile time that the number of times
IoUringCmd::done() is called matches the return value from
uring_cmd(): io_uring_cmd_done() may only be called if uring_cmd()
returns -EIOCBQUEUED; -EAGAIN will result in another call to
uring_cmd() and all other return values synchronously complete the
io_uring_cmd.

It's also not safe for the caller to pass an arbitrary value for
issue_flags here; it needs to exactly match what was passed into
uring_cmd(). Maybe we could introduce a type that couples the
IoUringCmd and issue_flags passed to uring_cmd()?

> +        let ret =3D from_result(|| ret) as isize;
> +        // SAFETY: The call guarantees that `self.inner` is not dangling=
 and stays valid
> +        unsafe {
> +            bindings::io_uring_cmd_done(self.inner.get(), ret, res2, iss=
ue_flags);
> +        }
> +    }
> +}
> +
> +/// A Rust abstraction for the Linux kernel's `io_uring_sqe` structure.
> +///
> +/// This structure is a safe, opaque wrapper around the raw C [`io_uring=
_sqe`](srctree/include/uapi/linux/io_uring.h)
> +/// binding from the Linux kernel. It represents a Submission Queue Entr=
y
> +/// used in io_uring operations within the kernel.
> +///
> +/// # Type Safety
> +///
> +/// The `#[repr(transparent)]` attribute ensures that this wrapper has
> +/// the same memory layout as the underlying `io_uring_sqe` structure,
> +/// allowing it to be safely transmuted between the two representations.
> +///
> +/// # Fields
> +///
> +/// * `inner` - An opaque wrapper containing the actual `io_uring_sqe` d=
ata.
> +///             The `Opaque` type prevents direct access to the internal
> +///             structure fields, ensuring memory safety and encapsulati=
on.
> +///
> +/// # Usage
> +///
> +/// This type represents a submission queue entry that describes an I/O
> +/// operation to be executed by the io_uring subsystem. It contains
> +/// information such as the operation type, file descriptor, buffer
> +/// pointers, and other operation-specific data.
> +///
> +/// Users can obtain this type from [`IoUringCmd::sqe()`] method, which
> +/// extracts the submission queue entry associated with a command.
> +///
> +/// This type should not be constructed or manipulated directly by
> +/// kernel module developers.
> +///
> +/// # INVARIANT
> +/// - `self.inner` always points to a valid, live `bindings::io_uring_sq=
e`.
> +#[repr(transparent)]
> +pub struct IoUringSqe {
> +    inner: Opaque<bindings::io_uring_sqe>,
> +}
> +
> +impl IoUringSqe {
> +    /// Reads and interprets the `cmd` field of an `bindings::io_uring_s=
qe` as a value of type `T`.
> +    ///
> +    /// # Safety & Invariants
> +    /// - Construction of `T` is delegated to `FromBytes`, which guarant=
ees that `T` has no
> +    ///   invalid bit patterns and can be safely reconstructed from raw =
bytes.
> +    /// - **Limitation:** This implementation does not support `IORING_S=
ETUP_SQE128` (larger SQE entries).
> +    ///   Only the standard `io_uring_sqe` layout is handled here.
> +    ///
> +    /// # Errors
> +    /// * Returns `EINVAL` if the `self` does not hold a `opcode::URING_=
CMD`.
> +    /// * Returns `EFAULT` if the command buffer is smaller than the req=
uested type `T`.
> +    ///
> +    /// # Returns
> +    /// * On success, returns a `T` deserialized from the `cmd`.
> +    /// * On failure, returns an appropriate error as described above.
> +    pub fn cmd_data<T: FromBytes>(&self) -> Result<T> {
> +        // SAFETY: `self.inner` guaranteed by the type invariant to poin=
t
> +        // to a live `io_uring_sqe`, so dereferencing is safe.
> +        let sqe =3D unsafe { &*self.inner.get() };
> +
> +        if u32::from(sqe.opcode) !=3D opcode::URING_CMD {

io_uring opcodes are u8 values. Can the URING_CMD constant be made a
u8 instead of converting sqe.opcode here?

The read of the opcode should also be using read_volatile(), as it may
lie in the userspace-mapped SQE region, which could be concurrently
written by another userspace thread. That would probably be buggy
behavior on the userspace side, but it can cause undefined behavior on
the kernel side without a volatile read, as the compiler could choose
to re-read the value multiple times assuming it will get the same
value each time.

> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: Accessing the `sqe.cmd` union field is safe because w=
e've
> +        // verified that `sqe.opcode =3D=3D IORING_OP_URING_CMD`, which =
guarantees
> +        // that this union variant is initialized and valid.

The opcode check isn't necessary. It doesn't provide any assurances
that this variant of the union is actually initialized, since a buggy
userspace process could set the opcode without initializing the cmd
field. It's always valid to access this memory since it's part of the
SQE region created at io_uring setup time. So I would drop the opcode
check.

> +        let cmd =3D unsafe { sqe.__bindgen_anon_6.cmd.as_ref() };
> +        let cmd_len =3D size_of_val(&sqe.__bindgen_anon_6.bindgen_union_=
field);
> +
> +        if cmd_len < size_of::<T>() {
> +            return Err(EFAULT);
> +        }
> +
> +        let cmd_ptr =3D cmd.as_ptr() as *mut T;
> +
> +        // SAFETY: `cmd_ptr` is valid from `self.inner` which is guarant=
eed by
> +        // type variant. And also it points to initialized `T` from user=
space.
> +        let ret =3D unsafe { core::ptr::read_unaligned(cmd_ptr) };

Similarly, needs to be volatile. The C uring_cmd() implementations use
READ_ONCE() to read the cmd field.

Best,
Caleb

> +
> +        Ok(ret)
> +    }
> +
> +    /// Constructs a new `IoUringSqe` from a raw `io_uring_sqe`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must guarantee that:
> +    /// - `ptr` is non-null, properly aligned, and points to a valid ini=
tialized
> +    ///   `bindings::io_uring_sqe`.
> +    /// - The pointed-to memory remains valid (not freed or repurposed) =
for the
> +    ///   entire lifetime `'a` of the returned reference.
> +    /// - **Aliasing rules (for `&T`):** while the returned `&'a IoUring=
Sqe` is
> +    ///   alive, there must be **no mutable access** to the same object =
through any
> +    ///   path (no `&mut`, no raw-pointer writes, no FFI/IRQ/other-CPU w=
riters).
> +    ///   Multiple `&` is fine **only if all of them are read-only** for=
 the entire
> +    ///   overlapping lifetime.
> +    /// - This relies on `IoUringSqe` being `repr(transparent)` over
> +    ///   `bindings::io_uring_sqe`, so the cast preserves layout.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::io_uring_sqe) -> &'=
a IoUringSqe {
> +        // SAFETY: The caller guarantees that the pointer is not danglin=
g and stays valid for the
> +        // duration of 'a. The cast is okay because `IoUringSqe` is `rep=
r(transparent)` and has the
> +        // same memory layout as `bindings::io_uring_sqe`.
> +        unsafe { &*ptr.cast() }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..d38cf7137401 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -91,6 +91,7 @@
>  pub mod fs;
>  pub mod init;
>  pub mod io;
> +pub mod io_uring;
>  pub mod ioctl;
>  pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
> --
> 2.43.0
>

