Return-Path: <linux-kernel+bounces-724335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E1EAFF180
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9854F1C84E55
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0761E24468C;
	Wed,  9 Jul 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6KpdJu1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E859242D72
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088193; cv=none; b=tOSbTQT+vmsfAV7285KSF9JkLqSTzdElY8cR6X267OqVzXNzOvCRKwxj/dKEquN3IPf3iOrI7OaPDfV4nOY2U2HnIOBu/VPbZ/bCjsg71yEdcPN/Kq3Oa0pSfTRYQ/GLER8hy6Lz67qyNUd/2M8s5gZ0WIk0QL0g1w1oT6fzGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088193; c=relaxed/simple;
	bh=7IK1O/5Amrl0R0bRmZpGVYtUpbVxV03RaAkvF58lBNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ctg2+NSVfW1vP7QaGADLgfrqg6IEC+nx0l6C7N21dtpg2/Z/YoDfQQJCtjpChVGRNrTpcsEmbbYMN/7NRY/bHcRWMUJN+0go/GVlpBJn0G6iGt4i1GYNdKhKFleIn1uNJGjLI539kt4EKChsioVUBjmu8r4fSTbe7kdfJGOx0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6KpdJu1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748b4d5c045so165526b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752088191; x=1752692991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiRlWSeoLIb9HFDXbg9k1oMY9yJt9AprT6ImWGiZWHg=;
        b=N6KpdJu1Sexz/mGZOerqrCQhAOQvcWvDiY/KQYaU/qtwxEF7otqm77HyXjOiepeFER
         1/+IXg8jagiWG3UJKKH7ia2Q7B0mi1E4uQKywRibQ8cCJxvCcUAnaHfAlaGdZNkqirFW
         bkTDwQ55hXVAztFmE0HG/m2hTKz8/9hMTzj8HpkPET4ai34v7Gz9axwsH05rHaFbiAnP
         UO2yA5yXuMghM6/U5/OCWciiF73OMeITq7UD2yOJf7d1a5716Oay8imDczVJPRe48Bsy
         TwFclI2i0RGFL/QDqRhuNTXkIrsFs1WQ61NgczvpJuKXce3CDogfpPNrKva7K0bjCFQD
         Tz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088191; x=1752692991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiRlWSeoLIb9HFDXbg9k1oMY9yJt9AprT6ImWGiZWHg=;
        b=nv/4k8vDti9z8W3fYurM61cyVkaTw2lL9ixEkT3UMG4oKV9f7+CZeKWxDmY0PKxE2i
         cvraWLygn5HyM03RxH9w+mp5hKLkHPf73OCn0OQmuMHdSOjARXIVyITOQbuRE9YvEWGW
         B51HI2kwdS7c7qO1Pu7MddJg2a8ZIAFVpLe96VISIHwm3jO7dnr0D5pbkRb19DRXlxPt
         CpQAefaHcFme+ktAyoVxqCsqN1M47o9IDsxIAoTYki3GQgM8osH+pLfyj5i3g8pnlSr+
         h+JK/q8VqSU1khkqg8cWaY9Bj+3eiYkb6jqKVhCWQbdsGoUjeCbmLIEHySoBB+jX/o1A
         sMUQ==
X-Gm-Message-State: AOJu0YxXi7rgByhLd8RY8+9mdJxH31EzstgHLRtWSs7SBJ1o2xXUCJBA
	qPjDyik69eos9JK6zRBqH/SPS3Jgpa4v30BZbOnf+OYabNGoq1Cqyz56nDgb91MzIpwq/IK6kc0
	ZZMoBWYgtAg==
X-Google-Smtp-Source: AGHT+IHN503Rj0ScL/6cOTUeQyfURQT+PFW4aGADN27aj9y2O6RunrX4n4WS88uUHeWI5W6/G096auKfcXUC
X-Received: from pfblg25.prod.google.com ([2002:a05:6a00:7099:b0:746:1a2e:b29b])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:38c:b0:220:7cd5:e803
 with SMTP id adf61e73a8af0-22cd719e18fmr7010579637.21.1752088190867; Wed, 09
 Jul 2025 12:09:50 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:09:31 +0000
In-Reply-To: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752088183; l=5318;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=7IK1O/5Amrl0R0bRmZpGVYtUpbVxV03RaAkvF58lBNU=; b=Fy5lHm34IqwAx0oHmpPsUdSbyjH0UOrinaos8hd+g3B54hPnNaWo4OoS6UR2Uko+JNlXpev5k
 SGD6I4+XQAGBxdcbgWWQJWMu58qMc1I/8DfcFJRnbpspzfp+N7eYGeK
X-Mailer: b4 0.14.2
Message-ID: <20250709-debugfs-rust-v9-4-92b9eab5a951@google.com>
Subject: [PATCH v9 4/5] rust: debugfs: Support format hooks
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

Rather than always using Display, allow hooking arbitrary functions to
arbitrary files. Display technically has the expressiveness to do this,
but requires a new type be declared for every different way to render
things, which can be very clumsy.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/kernel/debugfs.rs              | 49 +++++++++++++++++++++++++++++++++++++
 rust/kernel/debugfs/display_file.rs | 39 ++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index a1a84dd309216f455ae8fe3d3c0fd00f957f82a9..083c49007cd7ae5b3d7954bf859c24b7eb62d557 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -9,6 +9,7 @@
 use crate::str::CStr;
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
+use core::fmt;
 use core::fmt::Display;
 use core::marker::PhantomPinned;
 use core::ops::Deref;
@@ -194,6 +195,54 @@ pub fn display_file<'b, T: Display + Send + Sync, E, TI: PinInit<T, E>>(
         unsafe { self.create_file(name, data, vtable) }
     }
 
+    /// Create a file in a DebugFS directory with the provided name, and contents from invoking `f`
+    /// on the provided reference.
+    ///
+    /// `f` must be a function item or a non-capturing closure, or this will fail to compile.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use core::sync::atomic::{AtomicU32, Ordering};
+    /// # use kernel::c_str;
+    /// # use kernel::debugfs::Dir;
+    /// let dir = Dir::new(c_str!("foo"));
+    /// static MY_ATOMIC: AtomicU32 = AtomicU32::new(3);
+    /// let file = dir.fmt_file(c_str!("bar"), &MY_ATOMIC, &|val, f| {
+    ///   let out = val.load(Ordering::Relaxed);
+    ///   writeln!(f, "{out:#010x}")
+    /// });
+    /// MY_ATOMIC.store(10, Ordering::Relaxed);
+    /// ```
+    pub fn fmt_file<
+        'b,
+        T: Send + Sync,
+        E,
+        TI: PinInit<T, E>,
+        F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
+    >(
+        &self,
+        name: &'b CStr,
+        data: TI,
+        _f: &'static F,
+    ) -> impl PinInit<File<T>, E> + use<'_, 'b, T, TI, E, F> {
+        #[cfg(CONFIG_DEBUG_FS)]
+        let vtable = &<display_file::FormatAdapter<T, F> as display_file::DisplayFile>::VTABLE;
+        #[cfg(not(CONFIG_DEBUG_FS))]
+        let vtable = ();
+
+        // SAFETY: `vtable` is all stock `seq_file` implementations except for `open`.
+        // `open`'s only requirement beyond what is provided to all open functions is that the
+        // inode's data pointer must point to a `FormatAdapter<T, F>` that will outlive it.
+        // `create_file`'s safety requirements provide the lifetime aspect of this, but we are
+        // using a private `T` pointer. This is legal because:
+        // 1. `FormatAdapter<T, F>` is a `#[repr(transparent)]` wrapper around `T`, so the
+        //    implicit transmute is legal.
+        // 2. The invariant in `FormatAdapter` that `F` is inhabited is upheld because we have
+        //    `_f`, so constructing a `FormatAdapter<T, F> is legal.
+        unsafe { self.create_file(name, data, vtable) }
+    }
+
     /// Create a new directory in DebugFS at the root.
     ///
     /// # Examples
diff --git a/rust/kernel/debugfs/display_file.rs b/rust/kernel/debugfs/display_file.rs
index 2a58ca2685258b050089e4cfd62188885f7f5f04..6275283b9dabd8dae84a9335c8832e7943707d56 100644
--- a/rust/kernel/debugfs/display_file.rs
+++ b/rust/kernel/debugfs/display_file.rs
@@ -4,7 +4,8 @@
 use crate::prelude::*;
 use crate::seq_file::SeqFile;
 use crate::seq_print;
-use core::fmt::Display;
+use core::fmt::{Display, Formatter, Result};
+use core::marker::PhantomData;
 
 /// Implements `open` for `file_operations` via `single_open` to fill out a `seq_file`.
 ///
@@ -61,3 +62,39 @@ impl<T: Display + Sync> DisplayFile for T {
         ..unsafe { core::mem::zeroed() }
     };
 }
+
+/// Adapter to implement `Display` via a callback with the same representation as `T`.
+///
+/// # Invariants
+///
+/// If an instance for `FormatAdapter<_, F>` is constructed, `F` is inhabited.
+#[repr(transparent)]
+pub(crate) struct FormatAdapter<D, F> {
+    inner: D,
+    _formatter: PhantomData<F>,
+}
+
+impl<D, F> Display for FormatAdapter<D, F>
+where
+    F: Fn(&D, &mut Formatter<'_>) -> Result + 'static,
+{
+    fn fmt(&self, fmt: &mut Formatter<'_>) -> Result {
+        // SAFETY: FormatAdapter<_, F> can only be constructed if F is inhabited
+        let f: &F = unsafe { materialize_zst_fmt() };
+        f(&self.inner, fmt)
+    }
+}
+
+/// For types with a unique value, produce a static reference to it.
+///
+/// # Safety
+///
+/// The caller asserts that F is inhabited
+unsafe fn materialize_zst_fmt<F>() -> &'static F {
+    const { assert!(core::mem::size_of::<F>() == 0) };
+    let zst_dangle: core::ptr::NonNull<F> = core::ptr::NonNull::dangling();
+    // SAFETY: While the pointer is dangling, it is a dangling pointer to a ZST, based on the
+    // assertion above. The type is also inhabited, by the caller's assertion. This means
+    // we can materialize it.
+    unsafe { zst_dangle.as_ref() }
+}

-- 
2.50.0.727.gbf7dc18ff4-goog


