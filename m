Return-Path: <linux-kernel+bounces-781923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E215B318C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41502AC0C38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFF3074A5;
	Fri, 22 Aug 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="M72lKuoK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F402FD7BC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867408; cv=none; b=sCsIHYNOt0y0uV49H4n6mhhCfajvN79ynTq7JbnuCN+zMWbl1nwkto4IjkVaD2JV9KRuseGt95MrenuFq21LIYvRy3Szk0A36JIeJReWGGFfu4qQufGOl3y1dlklPc1oxaYC8jamnyaJEHY6Ps8a6RTI7k2w7GHV1TtI52EE5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867408; c=relaxed/simple;
	bh=NV6+rJDxkCRhM79mHIfKFRRwVUmLGb/zYkCLHClc0as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOktr7am6t4+DK4/QVCpnC8fMEok/1WTLx5fTPIOkUT5l2j9l0yXYMhM1uQywH8x6qx6yQkeMi81wv+dWFV5S2cc5uXD7S7aTGVJ7IOvkpxAOoLl33rbZgulKGuJQ34vnruVU8wfT3zJuQDD8ddtsYjV97f1aQtTP5dYkpPP0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=M72lKuoK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b474e8d6d04so1812673a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755867405; x=1756472205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvQIwb1NNcq0g0gNIsMaMiMcUpYuzVOnVto3+pLplyI=;
        b=M72lKuoKsB4FnfcvL5JS+VjNYxyT4xryr5Qj1GIy9mlx22AgT3ePm+vFxl8NPQ9Ghe
         OtWkgMeUHDL4yyzAFPqg7Ky6tNKJcnJBvigOt1SnsWz5e4Cjvt+IDy00EwblH2m1ps8K
         sQwJEtw0FpTbTg7lUwz76jTCaOjEsO/vaGkp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867405; x=1756472205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvQIwb1NNcq0g0gNIsMaMiMcUpYuzVOnVto3+pLplyI=;
        b=OVkrktUh/xpIveLPO3ok2YZViO9bbyg5YALE5NqdXHN+CV7ljxdZOaimMHzv9CAz0C
         O+hg+CQ13YbqBORKBIikwOTAxWAy/nv92HaGSwAb2LhPLjbLk0ZVGYogbDCkxgm0nolO
         o/KLb217djAyZITDjtPLRZxPbVwvzHzeFovYyoo+fJIxVfZsjE3T6zgjTSmG7ql23OwD
         w1U04Y9TOIgqmX+dok5hxjoyYYhqu+N3LYQwQd00AuDOr6FwP+2dqjW8KLO3VNpPQHAH
         XQqM/dkPW4IdG3yMek78cK75ZH/EwhoNr2EGjR/Snfa4hmzx2qqSmC5ztVcsM6aEOEfv
         rcQA==
X-Forwarded-Encrypted: i=1; AJvYcCXWx7wR8qDodYX2Zu1/9Ed1HlnU/SmsKWW2Jkrtc0/+vJk9gb+FmT91DWShOjMroar8n2+2FzeZhIwMTjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bGb2fsmwUiIrYXJXduSnZwBzKq41N34t9qvHpMyrJArA1epZ
	HLcdEbl7OVq3rK/C2220mPd64opiyn2XqX3hxPZpp/Uww3o5gNtc8UV8hMVuR8jfIrTwfmhfVMz
	e3y6N
X-Gm-Gg: ASbGncuEzlJElSPIl7zZZan0BMbxhVsS+5ciQ+Tjk+lEcU2xZYLHyUn6ALYZeS5r5Lm
	O5hePdJfCs92BfFsyo3CzJJsrPbRBpykJA6l7dXAf8dspJbU4JObxTSw6YifzI/6cs0rtg+1itY
	Qkh2mZiHxxrMiyNOhz4YR9q9Id5aHIeCZVA/qSzRFxZDk0H982bvWLGIcwB26N1RG9vLMMz/LJu
	Zz2PjShd6tEdBSyY1PGF3R3eLxMzbDXCC2ceAxujN5CFFfuKcvyWYXXCrcG9ke25u3zLYoqCiD6
	UtYS+i9OUVWtijBEJg8EEiUU8e5y0bC1VzfVn6YrprId/Tm7qk7LY/fcB/DF8wJDTX2DksYNxT7
	xYO/+eJDoxQZoA1jOcMkNqrox6HGU8fgIPer0FkVfXy0ptZiM8fWtRSK7D8UspWepSwtoB6ub1A
	NM6sqPMFQ=
X-Google-Smtp-Source: AGHT+IFUsehCGOfZistHEaN6+J+4p2f5uUzKwncvYpuYdsFqJWvzkLLRlUScB/Cvtgvlof1Oz+7Xvg==
X-Received: by 2002:a17:903:320d:b0:245:f53f:f7bc with SMTP id d9443c01a7336-2462edee95bmr32712685ad.9.1755867405306;
        Fri, 22 Aug 2025 05:56:45 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764003537sm7194544a12.25.2025.08.22.05.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:56:44 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 3/5] rust: io_uring: introduce rust abstraction for io-uring cmd
Date: Fri, 22 Aug 2025 12:55:53 +0000
Message-ID: <20250822125555.8620-4-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125555.8620-1-sidong.yang@furiosa.ai>
References: <20250822125555.8620-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implment the io-uring abstractions needed for miscdevicecs and other
char devices that have io-uring command interface.

* `io_uring::IoUringCmd` : Rust abstraction for `io_uring_cmd` which
  will be used as arg for `MiscDevice::uring_cmd()`. And driver can get
  `cmd_op` sent from userspace. Also it has `flags` which includes option
  that is reissued.

* `io_uring::IoUringSqe` : Rust abstraction for `io_uring_sqe` which
  could be get from `IoUringCmd::sqe()` and driver could get `cmd_data`
  from userspace. Also `IoUringSqe` has more data like opcode could be used in
  driver.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 rust/kernel/io_uring.rs | 306 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs      |   1 +
 2 files changed, 307 insertions(+)
 create mode 100644 rust/kernel/io_uring.rs

diff --git a/rust/kernel/io_uring.rs b/rust/kernel/io_uring.rs
new file mode 100644
index 000000000000..61e88bdf4e42
--- /dev/null
+++ b/rust/kernel/io_uring.rs
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: (C) 2025 Furiosa AI
+
+//! Abstractions for io-uring.
+//!
+//! This module provides types for implements io-uring interface for char device.
+//!
+//!
+//! C headers: [`include/linux/io_uring/cmd.h`](srctree/include/linux/io_uring/cmd.h) and
+//! [`include/linux/io_uring/io_uring.h`](srctree/include/linux/io_uring/io_uring.h)
+
+use core::{mem::MaybeUninit, pin::Pin};
+
+use crate::error::from_result;
+use crate::transmute::{AsBytes, FromBytes};
+use crate::{fs::File, types::Opaque};
+
+use crate::prelude::*;
+
+/// io-uring opcode
+pub mod opcode {
+    /// opcode for uring cmd
+    pub const URING_CMD: u32 = bindings::io_uring_op_IORING_OP_URING_CMD;
+}
+
+/// A Rust abstraction for the Linux kernel's `io_uring_cmd` structure.
+///
+/// This structure is a safe, opaque wrapper around the raw C `io_uring_cmd`
+/// binding from the Linux kernel. It represents a command structure used
+/// in io_uring operations within the kernel.
+/// This type is used internally by the io_uring subsystem to manage
+/// asynchronous I/O commands.
+///
+/// This type should not be constructed or manipulated directly by
+/// kernel module developers.
+///
+/// # INVARIANT
+/// - `self.inner` always points to a valid, live `bindings::io_uring_cmd`.
+#[repr(transparent)]
+pub struct IoUringCmd {
+    /// An opaque wrapper containing the actual `io_uring_cmd` data.
+    inner: Opaque<bindings::io_uring_cmd>,
+}
+
+impl IoUringCmd {
+    /// Returns the cmd_op with associated with the `io_uring_cmd`.
+    #[inline]
+    pub fn cmd_op(&self) -> u32 {
+        // SAFETY: `self.inner` is guaranteed by the type invariant to point
+        // to a live `io_uring_cmd`, so dereferencing is safe.
+        unsafe { (*self.inner.get()).cmd_op }
+    }
+
+    /// Returns the flags with associated with the `io_uring_cmd`.
+    #[inline]
+    pub fn flags(&self) -> u32 {
+        // SAFETY: `self.inner` is guaranteed by the type invariant to point
+        // to a live `io_uring_cmd`, so dereferencing is safe.
+        unsafe { (*self.inner.get()).flags }
+    }
+
+    /// Reads protocol data unit as `T` that impl `FromBytes` from uring cmd
+    ///
+    /// Fails with [`EFAULT`] if size of `T` is bigger than pdu size.
+    #[inline]
+    pub fn read_pdu<T: FromBytes>(&self) -> Result<T> {
+        // SAFETY: `self.inner` is guaranteed by the type invariant to point
+        // to a live `io_uring_cmd`, so dereferencing is safe.
+        let inner = unsafe { &mut *self.inner.get() };
+
+        let len = size_of::<T>();
+        if len > inner.pdu.len() {
+            return Err(EFAULT);
+        }
+
+        let mut out: MaybeUninit<T> = MaybeUninit::uninit();
+        let ptr = &raw mut inner.pdu as *const c_void;
+
+        // SAFETY:
+        // * The `ptr` is valid pointer from `self.inner` that is guaranteed by type invariant.
+        // * The `out` is valid pointer that points `T` which impls `FromBytes` and checked
+        //   size of `T` is smaller than pdu size.
+        unsafe {
+            core::ptr::copy_nonoverlapping(ptr, out.as_mut_ptr().cast::<c_void>(), len);
+        }
+
+        // SAFETY: The read above has initialized all bytes in `out`, and since `T` implements
+        // `FromBytes`, any bit-pattern is a valid value for this type.
+        Ok(unsafe { out.assume_init() })
+    }
+
+    /// Writes the provided `value` to `pdu` in uring_cmd `self`
+    ///
+    /// Fails with [`EFAULT`] if size of `T` is bigger than pdu size.
+    #[inline]
+    pub fn write_pdu<T: AsBytes>(&mut self, value: &T) -> Result<()> {
+        // SAFETY: `self.inner` is guaranteed by the type invariant to point
+        // to a live `io_uring_cmd`, so dereferencing is safe.
+        let inner = unsafe { &mut *self.inner.get() };
+
+        let len = size_of::<T>();
+        if len > inner.pdu.len() {
+            return Err(EFAULT);
+        }
+
+        let src = (value as *const T).cast::<c_void>();
+        let dst = &raw mut inner.pdu as *mut c_void;
+
+        // SAFETY:
+        // * The `src` is points valid memory that is guaranteed by `T` impls `AsBytes`
+        // * The `dst` is valid. It's from `self.inner` that is guaranteed by type invariant.
+        // * It's safe to copy because size of `T` is no more than len of pdu.
+        unsafe {
+            core::ptr::copy_nonoverlapping(src, dst, len);
+        }
+
+        Ok(())
+    }
+
+    /// Constructs a new [`IoUringCmd`] from a raw `io_uring_cmd`
+    ///
+    /// # Safety
+    ///
+    /// The caller must guarantee that:
+    /// - `ptr` is non-null, properly aligned, and points to a valid
+    ///   `bindings::io_uring_cmd`.
+    /// - The pointed-to memory remains initialized and valid for the entire
+    ///   lifetime `'a` of the returned reference.
+    /// - While the returned `Pin<&'a mut IoUringCmd>` is alive, the underlying
+    ///   object is **not moved** (pinning requirement).
+    /// - **Aliasing rules:** the returned `&mut` has **exclusive** access to the same
+    ///   object for its entire lifetime:
+    ///   - No other `&mut` **or** `&` references to the same `io_uring_cmd` may be
+    ///     alive at the same time.
+    ///   - There must be no concurrent reads/writes through raw pointers, FFI, or
+    ///     other kernel paths to the same object during this lifetime.
+    ///   - If the object can be touched from other contexts (e.g. IRQ/another CPU),
+    ///     the caller must provide synchronization to uphold this exclusivity.
+    /// - This function relies on `IoUringCmd` being `repr(transparent)` over
+    ///   `bindings::io_uring_cmd` so the cast preserves layout.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::io_uring_cmd) -> Pin<&'a mut IoUringCmd> {
+        // SAFETY:
+        // * The caller guarantees that the pointer is not dangling and stays
+        //   valid for the duration of 'a.
+        // * The cast is okay because `IoUringCmd` is `repr(transparent)` and
+        //   has the same memory layout as `bindings::io_uring_cmd`.
+        // * The returned `Pin` ensures that the object cannot be moved, which
+        //   is required because the kernel may hold pointers to this memory
+        //   location and moving it would invalidate those pointers.
+        unsafe { Pin::new_unchecked(&mut *ptr.cast()) }
+    }
+
+    /// Returns the file that referenced by uring cmd self.
+    #[inline]
+    pub fn file(&self) -> &File {
+        // SAFETY: `self.inner` is guaranteed by the type invariant to point
+        // to a live `io_uring_cmd`, so dereferencing is safe.
+        let file = unsafe { (*self.inner.get()).file };
+
+        // SAFETY:
+        // * The `file` points valid file.
+        // * refcount is positive after submission queue entry issued.
+        // * There is no active fdget_pos region on the file on this thread.
+        unsafe { File::from_raw_file(file) }
+    }
+
+    /// Returns an reference to the [`IoUringSqe`] associated with this command.
+    #[inline]
+    pub fn sqe(&self) -> &IoUringSqe {
+        // SAFETY: `self.inner` is guaranteed by the type invariant to point
+        // to a live `io_uring_cmd`, so dereferencing is safe.
+        let sqe = unsafe { (*self.inner.get()).sqe };
+        // SAFETY: The call guarantees that the `sqe` points valid io_uring_sqe.
+        unsafe { IoUringSqe::from_raw(sqe) }
+    }
+
+    /// Completes an this [`IoUringCmd`] request that was previously queued.
+    ///
+    /// # Safety
+    ///
+    /// - This function must be called **only** for a command whose `uring_cmd`
+    ///   handler previously returned **`-EIOCBQUEUED`** to io_uring.
+    ///
+    /// # Parameters
+    ///
+    /// - `ret`: Result to return to userspace.
+    /// - `res2`: Extra for big completion queue entry `IORING_SETUP_CQE32`.
+    /// - `issue_flags`: Flags associated with this request, typically the same
+    ///   as those passed to the `uring_cmd` handler.
+    #[inline]
+    pub fn done(self: Pin<&mut IoUringCmd>, ret: Result<i32>, res2: u64, issue_flags: u32) {
+        let ret = from_result(|| ret) as isize;
+        // SAFETY: The call guarantees that `self.inner` is not dangling and stays valid
+        unsafe {
+            bindings::io_uring_cmd_done(self.inner.get(), ret, res2, issue_flags);
+        }
+    }
+}
+
+/// A Rust abstraction for the Linux kernel's `io_uring_sqe` structure.
+///
+/// This structure is a safe, opaque wrapper around the raw C [`io_uring_sqe`](srctree/include/uapi/linux/io_uring.h)
+/// binding from the Linux kernel. It represents a Submission Queue Entry
+/// used in io_uring operations within the kernel.
+///
+/// # Type Safety
+///
+/// The `#[repr(transparent)]` attribute ensures that this wrapper has
+/// the same memory layout as the underlying `io_uring_sqe` structure,
+/// allowing it to be safely transmuted between the two representations.
+///
+/// # Fields
+///
+/// * `inner` - An opaque wrapper containing the actual `io_uring_sqe` data.
+///             The `Opaque` type prevents direct access to the internal
+///             structure fields, ensuring memory safety and encapsulation.
+///
+/// # Usage
+///
+/// This type represents a submission queue entry that describes an I/O
+/// operation to be executed by the io_uring subsystem. It contains
+/// information such as the operation type, file descriptor, buffer
+/// pointers, and other operation-specific data.
+///
+/// Users can obtain this type from [`IoUringCmd::sqe()`] method, which
+/// extracts the submission queue entry associated with a command.
+///
+/// This type should not be constructed or manipulated directly by
+/// kernel module developers.
+///
+/// # INVARIANT
+/// - `self.inner` always points to a valid, live `bindings::io_uring_sqe`.
+#[repr(transparent)]
+pub struct IoUringSqe {
+    inner: Opaque<bindings::io_uring_sqe>,
+}
+
+impl IoUringSqe {
+    /// Reads and interprets the `cmd` field of an `bindings::io_uring_sqe` as a value of type `T`.
+    ///
+    /// # Safety & Invariants
+    /// - Construction of `T` is delegated to `FromBytes`, which guarantees that `T` has no
+    ///   invalid bit patterns and can be safely reconstructed from raw bytes.
+    /// - **Limitation:** This implementation does not support `IORING_SETUP_SQE128` (larger SQE entries).
+    ///   Only the standard `io_uring_sqe` layout is handled here.
+    ///
+    /// # Errors
+    /// * Returns `EINVAL` if the `self` does not hold a `opcode::URING_CMD`.
+    /// * Returns `EFAULT` if the command buffer is smaller than the requested type `T`.
+    ///
+    /// # Returns
+    /// * On success, returns a `T` deserialized from the `cmd`.
+    /// * On failure, returns an appropriate error as described above.
+    pub fn cmd_data<T: FromBytes>(&self) -> Result<T> {
+        // SAFETY: `self.inner` guaranteed by the type invariant to point
+        // to a live `io_uring_sqe`, so dereferencing is safe.
+        let sqe = unsafe { &*self.inner.get() };
+
+        if u32::from(sqe.opcode) != opcode::URING_CMD {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: Accessing the `sqe.cmd` union field is safe because we've
+        // verified that `sqe.opcode == IORING_OP_URING_CMD`, which guarantees
+        // that this union variant is initialized and valid.
+        let cmd = unsafe { sqe.__bindgen_anon_6.cmd.as_ref() };
+        let cmd_len = size_of_val(&sqe.__bindgen_anon_6.bindgen_union_field);
+
+        if cmd_len < size_of::<T>() {
+            return Err(EFAULT);
+        }
+
+        let cmd_ptr = cmd.as_ptr() as *mut T;
+
+        // SAFETY: `cmd_ptr` is valid from `self.inner` which is guaranteed by
+        // type variant. And also it points to initialized `T` from userspace.
+        let ret = unsafe { core::ptr::read_unaligned(cmd_ptr) };
+
+        Ok(ret)
+    }
+
+    /// Constructs a new `IoUringSqe` from a raw `io_uring_sqe`.
+    ///
+    /// # Safety
+    ///
+    /// The caller must guarantee that:
+    /// - `ptr` is non-null, properly aligned, and points to a valid initialized
+    ///   `bindings::io_uring_sqe`.
+    /// - The pointed-to memory remains valid (not freed or repurposed) for the
+    ///   entire lifetime `'a` of the returned reference.
+    /// - **Aliasing rules (for `&T`):** while the returned `&'a IoUringSqe` is
+    ///   alive, there must be **no mutable access** to the same object through any
+    ///   path (no `&mut`, no raw-pointer writes, no FFI/IRQ/other-CPU writers).
+    ///   Multiple `&` is fine **only if all of them are read-only** for the entire
+    ///   overlapping lifetime.
+    /// - This relies on `IoUringSqe` being `repr(transparent)` over
+    ///   `bindings::io_uring_sqe`, so the cast preserves layout.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::io_uring_sqe) -> &'a IoUringSqe {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `IoUringSqe` is `repr(transparent)` and has the
+        // same memory layout as `bindings::io_uring_sqe`.
+        unsafe { &*ptr.cast() }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..d38cf7137401 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -91,6 +91,7 @@
 pub mod fs;
 pub mod init;
 pub mod io;
+pub mod io_uring;
 pub mod ioctl;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
-- 
2.43.0


