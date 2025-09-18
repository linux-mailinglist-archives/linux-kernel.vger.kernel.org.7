Return-Path: <linux-kernel+bounces-783047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86781B328B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5368B5E089A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E3259CB6;
	Sat, 23 Aug 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="CV1GjsN3";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="4MlzM4RZ"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB71E520B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755954329; cv=none; b=BPyCqIZJ+bdwdDKymAc0KASEQd1Tq5OOhKEUKhWS0tk9yM/75eRqalEvUS2PuVnB8XJhg21wlEK3sJMkUqmSkJX4LFIfQoao8ibVW6tVj4MLyigpAboXA38wcf8VE3RQzR+wnXJ4Txg+TH8J3o9tG4HBlw3mBSPlFfaFUK32Vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755954329; c=relaxed/simple;
	bh=AXPIszivA5La82EVZ3/J4qPYV3v2i3n8Ugozpq0Uro4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWsrC2CNURipznCuO0b9wRjSLaKb1VNff7t88i4WfX39W5d0sF4ZOwgahCZ4lv+jB06qYw+DIF475naeADcygA0yMVbgOBckCcNqXStXc8YygK0BW3y9BPNGvqrIEseDJuLlAWLGprhpBIwXPZvH5ZfLE0Foh4tDk4CKcM3rxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=CV1GjsN3; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=4MlzM4RZ; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755954325; x=1756559125;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=4zGvXg1y9SeBU8cgWL0AlC/yfYR8vXIZN9LtkXhZ8Ok=;
	b=CV1GjsN3b5xy3YI/43j9ZjytkE1raoLzfZNC1TIME1ThhM+SWwHGu9eV0FBfichq+lGzZ5qqHqTJs
	 raUdb3v4IXdvXw3wbbbKWwpmAKLaxThvzpVgK5KpnwmEqGBdHClnr+cV3eoMVertf740YS42HzVZ45
	 S0gW4lJgMvQn19/DI2sXLzL2H4H1ZYquhPpFHgsJ7xgz6t3Cqf5y/2UZOvw1mxUEDv6pRoa4poz8K0
	 9AnHyZb+NYvb2AAz098VQlbbZt1XbazRTdjVez/BKb8PUPkngufuya1htfbwr8xDvsGihlICPJfTk8
	 MW5XJ+8vHaNGBkQa4pYBLp8pclM5nSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755954325; x=1756559125;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=4zGvXg1y9SeBU8cgWL0AlC/yfYR8vXIZN9LtkXhZ8Ok=;
	b=4MlzM4RZrXxUG481LKKRCLRGkLxIqshj4V5NmZ3QCHTz0014KncuBdjbSnOPovxTU54ykFO8xhUek
	 khqbS0LAA==
X-HalOne-ID: d42fd706-8021-11f0-b365-4f541c8bf1cc
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id d42fd706-8021-11f0-b365-4f541c8bf1cc;
	Sat, 23 Aug 2025 13:05:24 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v4 2/2] rust: zpool: add abstraction for zpool drivers
Date: Sat, 23 Aug 2025 15:05:22 +0200
Message-Id: <20250823130522.867263-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250823130420.867133-1-vitaly.wool@konsulko.se>
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zpool is a common frontend for memory storage pool implementations.
These pools are typically used to store compressed memory objects,
e. g. for Zswap, the lightweight compressed cache for swap pages.

This patch provides the interface to use Zpool in Rust kernel code,
thus enabling Rust implementations of Zpool allocators for Zswap.

Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/zpool.c            |   6 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/zpool.rs            | 338 ++++++++++++++++++++++++++++++++
 5 files changed, 348 insertions(+)
 create mode 100644 rust/helpers/zpool.c
 create mode 100644 rust/kernel/zpool.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9..f0c4c454882b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -75,6 +75,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <linux/zpool.h>
 #include <trace/events/rust_sample.h>
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41d..e1a7556cc700 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -51,3 +51,4 @@
 #include "wait.c"
 #include "workqueue.c"
 #include "xarray.c"
+#include "zpool.c"
diff --git a/rust/helpers/zpool.c b/rust/helpers/zpool.c
new file mode 100644
index 000000000000..71ba173f917a
--- /dev/null
+++ b/rust/helpers/zpool.c
@@ -0,0 +1,6 @@
+#include <linux/zpool.h>
+
+void rust_helper_zpool_register_driver(struct zpool_driver *driver)
+{
+	zpool_register_driver(driver);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..165d52feeea4 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -129,6 +129,8 @@
 pub mod uaccess;
 pub mod workqueue;
 pub mod xarray;
+#[cfg(CONFIG_ZPOOL)]
+pub mod zpool;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/zpool.rs b/rust/kernel/zpool.rs
new file mode 100644
index 000000000000..88b863b71c8d
--- /dev/null
+++ b/rust/kernel/zpool.rs
@@ -0,0 +1,338 @@
+use crate::{
+    bindings,
+    error::{from_result, Result},
+    kernel::alloc::Flags,
+    str::CStr,
+    types::{ForeignOwnable, Opaque},
+};
+use core::ffi::{c_int, c_uchar, c_void};
+use core::ptr::{null_mut, NonNull};
+use kernel::alloc::NumaNode;
+use kernel::driver;
+use kernel::ThisModule;
+
+/// Zpool API.
+///
+/// The [`ZpoolDriver`] trait serves as an interface for Zpool drivers implemented in Rust.
+/// Such drivers implement memory storage pools in accordance with the zpool API.
+///
+/// # Example
+///
+/// A zpool driver implementation which uses KVec of 2**n sizes, n = 6, 7, ..., PAGE_SHIFT.
+/// Every zpool object is packed into a KVec that is sufficiently large, and n (the
+/// denominator) is saved in the least significant bits of the handle, which is guaranteed
+/// to be at least 2**6 aligned by kmalloc.
+///
+/// ```
+/// use core::ptr::{NonNull, copy_nonoverlapping};
+/// use core::sync::atomic::{AtomicU64, Ordering};
+/// use kernel::alloc::{Flags, KBox, KVec, NumaNode};
+/// use kernel::page::PAGE_SHIFT;
+/// use kernel::prelude::EINVAL;
+/// use kernel::zpool::*;
+///
+/// struct MyZpool {
+///     name: &'static CStr,
+///     bytes_used: AtomicU64,
+/// }
+///
+/// struct MyZpoolDriver;
+///
+/// impl ZpoolDriver for MyZpoolDriver {
+///     type Pool = KBox<MyZpool>;
+///
+///     fn create(name: &'static CStr, gfp: Flags) -> Result<KBox<MyZpool>> {
+///         let my_pool = MyZpool { name, bytes_used: AtomicU64::new(0) };
+///         let pool = KBox::new(my_pool, gfp)?;
+///
+///         Ok(pool)
+///     }
+///
+///     fn destroy(p: KBox<MyZpool>) {
+///         drop(p);
+///     }
+///
+///     fn malloc(pool: &mut MyZpool, size: usize, gfp: Flags, _nid: NumaNode) -> Result<usize> {
+///         let mut pow: usize = 0;
+///         for n in 6..=PAGE_SHIFT {
+///             if size <= 1 << n {
+///                 pow = n;
+///                 break;
+///             }
+///         }
+///         match pow {
+///             0 => Err(EINVAL),
+///             _ => {
+///                 let vec = KVec::<u64>::with_capacity(1 << (pow - 3), gfp)?;
+///                 let (ptr, _len, _cap) = vec.into_raw_parts();
+///                 pool.bytes_used.fetch_add(1 << pow, Ordering::Relaxed);
+///                 Ok(ptr as usize | (pow - 6))
+///             }
+///         }
+///     }
+///
+///     unsafe fn free(pool: &MyZpool, handle: usize) {
+///         let n = (handle & 0x3F) + 3;
+///         let uptr = handle & !0x3F;
+///
+///         // SAFETY:
+///         // - uptr comes from handle which points to the KVec allocation from `alloc`.
+///         // - size == capacity and is coming from the first 6 bits of handle.
+///         let vec = unsafe { KVec::<u64>::from_raw_parts(uptr as *mut u64, 1 << n, 1 << n) };
+///         drop(vec);
+///         pool.bytes_used.fetch_sub(1 << (n + 3), Ordering::Relaxed);
+///     }
+///
+///     unsafe fn read_begin(_pool: &MyZpool, handle: usize) -> NonNull<u8> {
+///         let uptr = handle & !0x3F;
+///         // SAFETY: uptr points to a memory area allocated by KVec
+///         unsafe { NonNull::new_unchecked(uptr as *mut u8) }
+///     }
+///
+///     unsafe fn read_end(_pool: &MyZpool, _handle: usize, _handle_mem: NonNull<u8>) {}
+///
+///     unsafe fn write(_p: &MyZpool, handle: usize, handle_mem: NonNull<u8>, mem_len: usize) {
+///         let uptr = handle & !0x3F;
+///         // SAFETY: handle_mem is a valid non-null pointer provided by zpool, uptr points to
+///         // a KVec allocated in `malloc` and is therefore also valid.
+///         unsafe {
+///             copy_nonoverlapping(handle_mem.as_ptr().cast(), uptr as *mut c_void, mem_len)
+///         };
+///     }
+///
+///     fn total_pages(pool: &MyZpool) -> u64 {
+///         pool.bytes_used.load(Ordering::Relaxed) >> PAGE_SHIFT
+///     }
+/// }
+/// ```
+///
+pub trait ZpoolDriver {
+    /// Opaque Rust representation of `struct zpool`.
+    type Pool: ForeignOwnable;
+
+    /// Create a pool.
+    fn create(name: &'static CStr, gfp: Flags) -> Result<Self::Pool>;
+
+    /// Destroy the pool.
+    fn destroy(pool: Self::Pool);
+
+    /// Allocate an object of size `size` bytes from `pool`, with the allocation flags `gfp` and
+    /// preferred NUMA node `nid`. If the allocation is successful, an opaque handle is returned.
+    fn malloc(
+        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
+        size: usize,
+        gfp: Flags,
+        nid: NumaNode,
+    ) -> Result<usize>;
+
+    /// Free a previously allocated from the `pool` object, represented by `handle`.
+    ///
+    /// # Safety
+    ///
+    /// - `handle` must be a valid handle previously returned by `malloc`.
+    /// - `handle` must not be used any more after the call to `free`.
+    unsafe fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle: usize);
+
+    /// Make all the necessary preparations for the caller to be able to read from the object
+    /// represented by `handle` and return a valid pointer to the `handle` memory to be read.
+    ///
+    /// # Safety
+    ///
+    /// - `handle` must be a valid handle previously returned by `malloc`.
+    /// - `read_end` with the same `handle` must be called for each `read_begin`.
+    unsafe fn read_begin(
+        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
+        handle: usize,
+    ) -> NonNull<u8>;
+
+    /// Finish reading from a previously allocated `handle`. `handle_mem` must be the pointer
+    /// previously returned by `read_begin`.
+    ///
+    /// # Safety
+    ///
+    /// - `handle` must be a valid handle previously returned by `malloc`.
+    /// - `handle_mem` must be the pointer previously returned by `read_begin`.
+    unsafe fn read_end(
+        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
+        handle: usize,
+        handle_mem: NonNull<u8>,
+    );
+
+    /// Write to the object represented by a previously allocated `handle`. `handle_mem` points
+    /// to the memory to copy data from, and `mem_len` defines the length of the data block to
+    /// be copied.
+    ///
+    /// # Safety
+    ///
+    /// - `handle` must be a valid handle previously returned by `malloc`.
+    /// - `handle_mem` must be a valid pointer to an allocated memory area.
+    /// - `handle_mem` + `mem_len` must not point outside the allocated memory area.
+    unsafe fn write(
+        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
+        handle: usize,
+        handle_mem: NonNull<u8>,
+        mem_len: usize,
+    );
+
+    /// Get the number of pages used by the `pool`.
+    fn total_pages(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>) -> u64;
+}
+
+/// An "adapter" for the registration of zpool drivers.
+pub struct Adapter<T: ZpoolDriver>(T);
+
+impl<T: ZpoolDriver> Adapter<T> {
+    extern "C" fn create_(name: *const c_uchar, gfp: u32) -> *mut c_void {
+        // SAFETY: the memory pointed to by name is guaranteed by zpool to be a valid string
+        let pool = unsafe { T::create(CStr::from_char_ptr(name), Flags::from_raw(gfp)) };
+        match pool {
+            Err(_) => null_mut(),
+            Ok(p) => T::Pool::into_foreign(p),
+        }
+    }
+    extern "C" fn destroy_(pool: *mut c_void) {
+        // SAFETY: The pointer originates from an `into_foreign` call.
+        T::destroy(unsafe { T::Pool::from_foreign(pool) })
+    }
+    extern "C" fn malloc_(
+        pool: *mut c_void,
+        size: usize,
+        gfp: u32,
+        handle: *mut usize,
+        nid: c_int,
+    ) -> c_int {
+        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
+        // `from_foreign`, then that happens in `_destroy` which will not be called during this
+        // method.
+        let pool = unsafe { T::Pool::borrow_mut(pool) };
+
+        from_result(|| {
+            let real_nid = match nid {
+                bindings::NUMA_NO_NODE => NumaNode::NO_NODE,
+                _ => NumaNode::new(nid)?,
+            };
+            let h = T::malloc(pool, size, Flags::from_raw(gfp), real_nid)?;
+            // SAFETY: handle is guaranteed to be a valid pointer by zpool.
+            unsafe { *handle = h };
+            Ok(0)
+        })
+    }
+    extern "C" fn free_(pool: *mut c_void, handle: usize) {
+        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
+        // `from_foreign`, then that happens in `_destroy` which will not be called during this
+        // method.
+        let pool = unsafe { T::Pool::borrow(pool) };
+
+        // SAFETY: the caller (zswap) guarantees that `handle` is a valid handle previously
+        // allocated by `malloc`.
+        unsafe { T::free(pool, handle) }
+    }
+    extern "C" fn obj_read_begin_(
+        pool: *mut c_void,
+        handle: usize,
+        _local_copy: *mut c_void,
+    ) -> *mut c_void {
+        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
+        // `from_foreign`, then that happens in `_destroy` which will not be called during this
+        // method.
+        let pool = unsafe { T::Pool::borrow(pool) };
+
+        // SAFETY: the caller (zswap) guarantees that `handle` is a valid handle previously
+        // allocated by `malloc`.
+        let non_null_ptr = unsafe { T::read_begin(pool, handle) };
+        non_null_ptr.as_ptr().cast()
+    }
+    extern "C" fn obj_read_end_(pool: *mut c_void, handle: usize, handle_mem: *mut c_void) {
+        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
+        // `from_foreign`, then that happens in `_destroy` which will not be called during this
+        // method.
+        let pool = unsafe { T::Pool::borrow(pool) };
+
+        // SAFETY: handle_mem is guaranteed to be non-null by the caller (zswap)
+        let handle_mem_ptr = unsafe { NonNull::new_unchecked(handle_mem.cast()) };
+
+        // SAFETY: the caller (zswap) guarantees that `handle` is a valid handle previously
+        // allocated by `malloc`.
+        unsafe { T::read_end(pool, handle, handle_mem_ptr) }
+    }
+    extern "C" fn obj_write_(
+        pool: *mut c_void,
+        handle: usize,
+        handle_mem: *mut c_void,
+        mem_len: usize,
+    ) {
+        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
+        // `from_foreign`, then that happens in `_destroy` which will not be called during this
+        // method.
+        let pool = unsafe { T::Pool::borrow(pool) };
+
+        // SAFETY: handle_mem is guaranteed to be non-null by the caller (zswap)
+        let handle_mem_ptr = unsafe { NonNull::new_unchecked(handle_mem.cast()) };
+
+        // SAFETY: the caller (zswap) guarantees that `handle` is a valid handle previously
+        // allocated by `malloc`.
+        unsafe {
+            T::write(pool, handle, handle_mem_ptr, mem_len);
+        }
+    }
+    extern "C" fn total_pages_(pool: *mut c_void) -> u64 {
+        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
+        // `from_foreign`, then that happens in `_destroy` which will not be called during this
+        // method.
+        let pool = unsafe { T::Pool::borrow(pool) };
+        T::total_pages(pool)
+    }
+}
+
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid
+// because preceding call to `register` never fails for zpool.
+unsafe impl<T: ZpoolDriver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::zpool_driver;
+
+    unsafe fn register(
+        pdrv: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        _module: &'static ThisModule,
+    ) -> Result {
+        // SAFETY: It's safe to set the fields of `struct zpool_driver` on initialization.
+        unsafe {
+            (*(pdrv.get())).type_ = name.as_char_ptr().cast_mut();
+            (*(pdrv.get())).create = Some(Self::create_);
+            (*(pdrv.get())).destroy = Some(Self::destroy_);
+            (*(pdrv.get())).malloc = Some(Self::malloc_);
+            (*(pdrv.get())).free = Some(Self::free_);
+            (*(pdrv.get())).obj_read_begin = Some(Self::obj_read_begin_);
+            (*(pdrv.get())).obj_read_end = Some(Self::obj_read_end_);
+            (*(pdrv.get())).obj_write = Some(Self::obj_write_);
+            (*(pdrv.get())).total_pages = Some(Self::total_pages_);
+
+            bindings::zpool_register_driver(pdrv.get());
+        }
+        Ok(())
+    }
+    unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
+        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::zpool_unregister_driver(pdrv.get()) };
+    }
+}
+
+/// Declares a kernel module that exposes a zpool driver (i. e. an implementation of the zpool
+/// API).
+///
+/// # Examples
+///
+///```ignore
+/// kernel::module_zpool_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     authors: ["Author name"],
+///     description: "Description",
+///     license: "GPL",
+/// }
+///```
+#[macro_export]
+macro_rules! module_zpool_driver {
+($($f:tt)*) => {
+    $crate::module_driver!(<T>, $crate::zpool::Adapter<T>, { $($f)* });
+};
+}
-- 
2.39.2


