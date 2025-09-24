Return-Path: <linux-kernel+bounces-831161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E6DB9BBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C449D321AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A7275AE8;
	Wed, 24 Sep 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="doq1xTa8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DJ0MtHnp"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB62741DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742657; cv=none; b=qE8BrDT0dNGjFNTWAAscutQvsx69LvB8+1fwPLQbuywRSsDVx3H/brxAYw5WmouAIjeLcoeNLPoxOVIVHCxPTnf2wLtIWH7j13jYauFdZXs6JOELd59Gr1b5niW/34fD2kJD0CIS+PJUnEYhZ4fFb7RZTczLS+orruL5HIwVwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742657; c=relaxed/simple;
	bh=mhvkveGcZWfcnrbLCp9SZ1Sp/TzJ8TYYqJiYtHeYB1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=soeV4xBCkFAeWSvoB1UEwUkctdH8r0+S9cDCIE6bVNKFSf8PcnzoCh55992L4AMsk0C2pgF1aXTkSgsMz9WO8LYSkvtgSd/ozmXeYsZIUx80/HMEiKLx4fF6sk7UeYpq4HHbUKVFqX2F92A+FUqJneDCrB9dwxT+wsU0xwZkISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=doq1xTa8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DJ0MtHnp; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=doq1xTa8U0uZQ3+f8T+jKxMWMb4N5mJ00/BdGgPwSx0L6/6asYVj0N0VXmloKxvPTGU9uYyRBdYTI8gNI+fytD2gjrGnX/IJKhSX4a5yYPp8h2q574lJGavqlsQwnwkSFJAYwFRimliEJIv6ITU5+Qtxwy8TDc7GbyAqnZYpqqr/DaLac4rssAFlQ/nJPb3z/qJ6c+U5jTfNgWdVpsKnc4gNfqDKQxkaJrGyJW9nFZNpGAJJ6IV3hsnxGvk5gtPGyrVbVU7BWc3pWMVgnGyX3PxjT+nC5SHuKlB9c8GeSPfd8Mt/5CQC3Ct/cqD2mr+hqGbJT3BzMpaRrXuwHi4p3Q==; s=purelymail2; d=elijahs.space; v=1; bh=mhvkveGcZWfcnrbLCp9SZ1Sp/TzJ8TYYqJiYtHeYB1c=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=DJ0MtHnpyIP22JMH0Wml1x55Ot1joNwgsLaMDEbXCk83T0wFifXvx/svAEdXyLMV3pCbssH9wEkuWbfu8Rdo29GEDjvo6QZElXPkfG5e0y4lUxyRTCPLohxOg6mV7dmpcH4AyCLkYw15D7OuEcGSsaQJCfgwWKS18PGQa7+51zrdkLw5/CBkVjWPQ37TAHrmk30ENGpiDQDPEevClyijKsK8if9WceyNpztFKFV3yNAg1xQp1YhJMpwY45IB0qAMDJnnTQtOJt4c4lu9QReos9QfHWi8m0qF/YfMOZ/seybxahK3g9TrsFBV6k9BoybOnhnQIkRnwBigRWm5cvGjKw==; s=purelymail2; d=purelymail.com; v=1; bh=mhvkveGcZWfcnrbLCp9SZ1Sp/TzJ8TYYqJiYtHeYB1c=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 147366:4866:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1160976323;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 24 Sep 2025 19:36:51 +0000 (UTC)
From: Elijah Wright <git@elijahs.space>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Elijah Wright <git@elijahs.space>
Subject: [PATCH] rust: slab: add basic slab module
Date: Wed, 24 Sep 2025 12:36:35 -0700
Message-ID: <20250924193643.4001-1-git@elijahs.space>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

this patch adds a basic slab module for kmem_cache, primarily wrapping
kmem_cache_create, kmem_cache_alloc, kmem_cache_free, and kmem_cache_destro=
y.

Signed-off-by: Elijah Wright <git@elijahs.space>
---
 rust/helpers/slab.c | 10 ++++++
 rust/kernel/lib.rs  |  1 +
 rust/kernel/slab.rs | 85 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 rust/kernel/slab.rs

diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
index a842bfbddcba..799de7bc1405 100644
--- a/rust/helpers/slab.c
+++ b/rust/helpers/slab.c
@@ -13,3 +13,13 @@ rust_helper_kvrealloc(const void *p, size_t size, gfp_t =
flags)
 {
 =09return kvrealloc(p, size, flags);
 }
+
+struct kmem_cache * rust_helper_kmem_cache_create(const char *name, unsign=
ed int size, unsigned int align, gfp_t flags, void (*ctor)(void *))
+{
+=09return kmem_cache_create(name, size, align, flags, NULL);
+}
+
+void * rust_helper_kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags=
)
+{
+=09return kmem_cache_alloc(cachep, flags);
+}
\ No newline at end of file
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fef97f2a5098..bd76eadbe297 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -116,6 +116,7 @@
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
+pub mod slab;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/slab.rs b/rust/kernel/slab.rs
new file mode 100644
index 000000000000..8b418f9db7cb
--- /dev/null
+++ b/rust/kernel/slab.rs
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Slab bindings.
+//!
+//! C header: [`include/linux/slab.h`](srctree/include/linux/slab.h)
+
+use core::{marker::PhantomData, mem, ptr::NonNull};
+
+use crate::{
+    alloc::Flags,
+    bindings,
+    error::{code::ENOMEM, Result},
+    str::CStr,
+};
+
+/// A wrapper for kmem_cache that allocates objects of type `T`.
+#[repr(transparent)]
+pub struct Slab<T> {
+    cache: NonNull<bindings::kmem_cache>,
+    _p: PhantomData<T>,
+}
+
+impl<T> Slab<T> {
+    /// Creates a cache for objects of type `T`.
+    pub fn try_new(name: &CStr, flags: Flags) -> Result<Self> {
+        let size =3D mem::size_of::<T>();
+        let align =3D mem::align_of::<T>();
+        debug_assert!(size <=3D usize::MAX);
+        debug_assert!(align <=3D usize::MAX);
+
+        // SAFETY: `flags` is a valid impl, `name` is a valid C string, an=
d
+        // other arguments are plain values.
+        let cache =3D unsafe {
+            bindings::kmem_cache_create(
+                name.as_char_ptr(),
+                size as u32,
+                align as u32,
+                flags.as_raw(),
+                None,
+            )
+        };
+
+        NonNull::new(cache)
+            .map(|c| Slab {
+                cache: c,
+                _p: PhantomData,
+            })
+            .ok_or(ENOMEM)
+    }
+
+    /// Allocates one object from the cache with the given gfp flags.
+    #[inline]
+    pub fn alloc(&self, flags: Flags) -> Result<NonNull<T>> {
+        // SAFETY: `self.cache` is a valid pointer obtained from
+        // `kmem_cache_create` and still alive because `self` is borrowed.
+        let ptr =3D unsafe { bindings::kmem_cache_alloc(self.cache.as_ptr(=
), flags.as_raw()) };
+        NonNull::new(ptr.cast()).ok_or(ENOMEM)
+    }
+
+    /// Frees an object previously returned by `alloc()`.
+    ///
+    /// # Safety
+    /// The caller must guarantee that `obj` was allocated from this cache=
 and
+    /// is no longer accessed afterwards.
+    #[inline]
+    pub unsafe fn free(&self, obj: NonNull<T>) {
+        // SAFETY: By the safety contract the pointer is valid and unique =
at
+        // this point.
+        unsafe { bindings::kmem_cache_free(self.cache.as_ptr(), obj.cast()=
.as_ptr()) };
+    }
+
+    /// Returns the raw mutable pointer to the cache
+    #[inline]
+    pub fn as_ptr(&self) -> *mut bindings::kmem_cache {
+        self.cache.as_ptr()
+    }
+}
+
+impl<T> Drop for Slab<T> {
+    fn drop(&mut self) {
+        // SAFETY: `self.cache` is valid and we are the final owner becaus=
e
+        // of ownership rules.
+        unsafe { bindings::kmem_cache_destroy(self.cache.as_ptr()) };
+    }
+}
--=20
2.49.1


