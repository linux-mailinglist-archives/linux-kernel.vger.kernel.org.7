Return-Path: <linux-kernel+bounces-784751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E2B340A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD16B1A82730
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722B7273D8A;
	Mon, 25 Aug 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acSOaKNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659C273803;
	Mon, 25 Aug 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128362; cv=none; b=BczddxA4esZV9vPSo0WieJuo0m+U49Zyekq2XLC1EGXehf+4U+bxePpU2PtC6aJoqWi6L8Gy6ljF3jeNXtitLFUTbXmRF6fNn271TQVdJg3AKcw/fI1qqRhk1pGyP0LJ8dCisYVF6tK0+RFVSTZSawZextdqpXpOxO2muPdb7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128362; c=relaxed/simple;
	bh=Gg5vS9fldVoRNzNIbY69DFkPnzVFbaRQhfyOKls2PCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nenwplQYm/GnUijiOLHykzgvhVjPXQXlwG98m1ipVg5WNkVkIgoa+dnW7BlD9SeeFOAKC87oM6eM26heFskNn/UdHgnN2jspgPc6Omb7Hi9jJctQKFco6VtkVy0ZslzOxdxAtzpVU6fVV8c4Hvolwu5cGRcXZOROCqZ+ZJTifGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acSOaKNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D452C116D0;
	Mon, 25 Aug 2025 13:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128361;
	bh=Gg5vS9fldVoRNzNIbY69DFkPnzVFbaRQhfyOKls2PCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acSOaKNy40sKgOx3xbwjAgjINc1s7oybMSN3h4X3HRXLPmUEV4DvAXbxn3vrPZ0ST
	 jw0+6EqEW4YsVelKblRwqJ9tvTPSdnTN08HDwqyMHJdV5XHuwCA3MzHZExUYLNPdhf
	 NuvK8nrHm7EgpagwN3nXT64NyoMXNRscascHZadO0M7DuxjYeud0lpXVsuWFBnD2/6
	 p73T3SUb4wGkOtZInFJHj46uhc72bOWMehCuGEY5o7J3BF1drQ4ywaFQdmotnPk7UG
	 XFiXgZr3hlu7T3HPDatcgANVfZb5H4YidE/H5edk7saVsLu3x7J4E4OinFb6e8HiuY
	 XRSZQ6WyqA+zQ==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	abdiel.janulgue@gmail.com,
	acourbot@nvidia.com,
	jgg@ziepe.ca,
	lyude@redhat.com,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
Date: Mon, 25 Aug 2025 15:24:42 +0200
Message-ID: <20250825132539.122412-4-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825132539.122412-1-dakr@kernel.org>
References: <20250825132539.122412-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a safe Rust abstraction for the kernel's scatter-gather list
facilities (`struct scatterlist` and `struct sg_table`).

This commit introduces `SGTable<T>`, a wrapper that uses a generic
parameter to provide compile-time guarantees about ownership and lifetime.

The abstraction provides two primary states:
- `SGTable<Owned<P>>`: Represents a table whose resources are fully
  managed by Rust. It takes ownership of a page provider `P`, allocates
  the underlying `struct sg_table`, maps it for DMA, and handles all
  cleanup automatically upon drop. The DMA mapping's lifetime is tied to
  the associated device using `Devres`, ensuring it is correctly unmapped
  before the device is unbound.
- `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representation of
  an externally managed `struct sg_table`. It is created from a raw
  pointer using `SGTable::as_ref()` and provides a lifetime-bound
  reference (`&'a SGTable`) for operations like iteration.

The API exposes a safe iterator that yields `&SGEntry` references,
allowing drivers to easily access the DMA address and length of each
segment in the list.

Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/helpers.c     |   1 +
 rust/helpers/scatterlist.c |  24 ++
 rust/kernel/lib.rs         |   1 +
 rust/kernel/scatterlist.rs | 483 +++++++++++++++++++++++++++++++++++++
 4 files changed, 509 insertions(+)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41d..e94542bf6ea7 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -39,6 +39,7 @@
 #include "rcu.c"
 #include "refcount.c"
 #include "regulator.c"
+#include "scatterlist.c"
 #include "security.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
new file mode 100644
index 000000000000..80c956ee09ab
--- /dev/null
+++ b/rust/helpers/scatterlist.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-direction.h>
+
+dma_addr_t rust_helper_sg_dma_address(struct scatterlist *sg)
+{
+	return sg_dma_address(sg);
+}
+
+unsigned int rust_helper_sg_dma_len(struct scatterlist *sg)
+{
+	return sg_dma_len(sg);
+}
+
+struct scatterlist *rust_helper_sg_next(struct scatterlist *sg)
+{
+	return sg_next(sg);
+}
+
+void rust_helper_dma_unmap_sgtable(struct device *dev, struct sg_table *sgt,
+				   enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_unmap_sgtable(dev, sgt, dir, attrs);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..55acbc893736 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -113,6 +113,7 @@
 pub mod rbtree;
 pub mod regulator;
 pub mod revocable;
+pub mod scatterlist;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..e76e5c2cbdc7
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for scatter-gather lists.
+//!
+//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
+//!
+//! Scatter-gather (SG) I/O is a memory access technique that allows devices to perform DMA
+//! operations on data buffers that are not physically contiguous in memory. It works by creating a
+//! "scatter-gather list", an array where each entry specifies the address and length of a
+//! physically contiguous memory segment.
+//!
+//! The device's DMA controller can then read this list and process the segments sequentially as
+//! part of one logical I/O request. This avoids the need for a single, large, physically contiguous
+//! memory buffer, which can be difficult or impossible to allocate.
+//!
+//! This module provides safe Rust abstractions over the kernel's `struct scatterlist` and
+//! `struct sg_table` types.
+//!
+//! The main entry point is the [`SGTable`] type, which represents a complete scatter-gather table.
+//! It can be either:
+//!
+//! - An owned table ([`SGTable<Owned<P>>`]), created from a Rust memory buffer (e.g., [`VVec`]).
+//!   This type manages the allocation of the `struct sg_table`, the DMA mapping of the buffer, and
+//!   the automatic cleanup of all resources.
+//! - A borrowed reference (&[`SGTable`]), which provides safe, read-only access to a table that was
+//!   allocated by other (e.g., C) code.
+//!
+//! Individual entries in the table are represented by [`SGEntry`], which can be accessed by
+//! iterating over an [`SGTable`].
+
+use crate::{
+    alloc,
+    alloc::allocator::VmallocPageIter,
+    bindings,
+    device::{Bound, Device},
+    devres::Devres,
+    dma, error,
+    io::resource::ResourceSize,
+    page,
+    prelude::*,
+    types::{ARef, Opaque},
+};
+use core::{ops::Deref, ptr::NonNull};
+
+/// A single entry in a scatter-gather list.
+///
+/// An `SGEntry` represents a single, physically contiguous segment of memory that has been mapped
+/// for DMA.
+///
+/// Instances of this struct are obtained by iterating over an [`SGTable`]. Drivers do not create
+/// or own [`SGEntry`] objects directly.
+#[repr(transparent)]
+pub struct SGEntry(Opaque<bindings::scatterlist>);
+
+// SAFETY: `SGEntry` can be send to any task.
+unsafe impl Send for SGEntry {}
+
+// SAFETY: `SGEntry` can be accessed concurrently.
+unsafe impl Sync for SGEntry {}
+
+impl SGEntry {
+    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the
+    /// lifetime `'a`.
+    #[inline]
+    unsafe fn from_raw<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
+        // SAFETY: The safety requirements of this function guarantee that `ptr` is a valid pointer
+        // to a `struct scatterlist` for the duration of `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Obtain the raw `struct scatterlist *`.
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::scatterlist {
+        self.0.get()
+    }
+
+    /// Returns the DMA address of this SG entry.
+    ///
+    /// This is the address that the device should use to access the memory segment.
+    #[inline]
+    pub fn dma_address(&self) -> dma::DmaAddress {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct scatterlist`.
+        unsafe { bindings::sg_dma_address(self.as_raw()) }
+    }
+
+    /// Returns the length of this SG entry in bytes.
+    #[inline]
+    pub fn dma_len(&self) -> ResourceSize {
+        #[allow(clippy::useless_conversion)]
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct scatterlist`.
+        unsafe { bindings::sg_dma_len(self.as_raw()) }.into()
+    }
+}
+
+/// The borrowed type state of an [`SGTable`], representing a borrowed or externally managed table.
+#[repr(transparent)]
+pub struct Borrowed(Opaque<bindings::sg_table>);
+
+// SAFETY: `Borrowed` can be send to any task.
+unsafe impl Send for Borrowed {}
+
+// SAFETY: `Borrowed` can be accessed concurrently.
+unsafe impl Sync for Borrowed {}
+
+/// A scatter-gather table.
+///
+/// This struct is a wrapper around the kernel's `struct sg_table`. It manages a list of DMA-mapped
+/// memory segments that can be passed to a device for I/O operations.
+///
+/// The generic parameter `T` is used as a type state to distinguish between owned and borrowed
+/// tables.
+///
+///  - [`SGTable<Owned>`]: An owned table created and managed entirely by Rust code. It handles
+///    allocation, DMA mapping, and cleanup of all associated resources. See [`SGTable::new`].
+///  - [`SGTable<Borrowed>`} (or simply [`SGTable`]): Represents a table whose lifetime is managed
+///    externally. It can be used safely via a borrowed reference `&'a SGTable`, where `'a` is the
+///    external lifetime.
+///
+/// All [`SGTable`] variants can be iterated over the individual [`SGEntry`]s.
+#[repr(transparent)]
+#[pin_data]
+pub struct SGTable<T: private::Sealed = Borrowed> {
+    #[pin]
+    inner: T,
+}
+
+impl SGTable {
+    /// Creates a borrowed `&'a SGTable` from a raw `struct sg_table` pointer.
+    ///
+    /// This allows safe access to an `sg_table` that is managed elsewhere (for example, in C code).
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    ///
+    /// - the `struct sg_table` pointed to by `ptr` is valid for the entire lifetime of `'a`,
+    /// - the data behind `ptr` is not modified concurrently for the duration of `'a`.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::sg_table) -> &'a Self {
+        // SAFETY: The safety requirements of this function guarantee that `ptr` is a valid pointer
+        // to a `struct sg_table` for the duration of `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::sg_table {
+        self.inner.0.get()
+    }
+
+    /// Returns an [`SGTableIter`] bound to the lifetime of `self`.
+    pub fn iter(&self) -> SGTableIter<'_> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct sg_table`.
+        let nents = unsafe { (*self.as_raw()).nents };
+
+        let pos = if nents > 0 {
+            // SAFETY: `self.as_raw()` is a valid pointer to a `struct sg_table`.
+            let ptr = unsafe { (*self.as_raw()).sgl };
+
+            // SAFETY: `ptr` is guaranteed to be a valid pointer to a `struct scatterlist`.
+            Some(unsafe { SGEntry::from_raw(ptr) })
+        } else {
+            None
+        };
+
+        SGTableIter { pos, nents }
+    }
+}
+
+/// Represents the DMA mapping state of a `struct sg_table`.
+///
+/// This is used as an inner type of [`Owned`] to manage the DMA mapping lifecycle.
+///
+/// # Invariants
+///
+/// - `sgt` is a valid pointer to a `struct sg_table` for the entire lifetime of the
+///   [`DmaMappedSgt`].
+/// - `sgt` is always DMA mapped.
+struct DmaMappedSgt {
+    sgt: NonNull<bindings::sg_table>,
+    dev: ARef<Device>,
+    dir: dma::DataDirection,
+}
+
+// SAFETY: `DmaMappedSgt` can be send to any task.
+unsafe impl Send for DmaMappedSgt {}
+
+// SAFETY: `DmaMappedSgt` can be accessed concurrently.
+unsafe impl Sync for DmaMappedSgt {}
+
+impl DmaMappedSgt {
+    /// # Safety
+    ///
+    /// - `sgt` must be a valid pointer to a `struct sg_table` for the entire lifetime of the
+    ///   returned [`DmaMappedSgt`].
+    /// - The caller must guarantee that `sgt` remains DMA mapped for the entire lifetime of
+    ///   [`DmaMappedSgt`].
+    unsafe fn new(
+        sgt: NonNull<bindings::sg_table>,
+        dev: &Device<Bound>,
+        dir: dma::DataDirection,
+    ) -> Result<Self> {
+        // SAFETY:
+        // - `dev.as_raw()` is a valid pointer to a `struct device`, which is guaranteed to be
+        //   bound to a driver for the duration of this call.
+        // - `sgt` is a valid pointer to a `struct sg_table`.
+        error::to_result(unsafe {
+            bindings::dma_map_sgtable(dev.as_raw(), sgt.as_ptr(), dir.into(), 0)
+        })?;
+
+        // INVARIANT: By the safety requirements of this function it is guaranteed that `sgt` is
+        // valid for the entire lifetime of this object instance.
+        Ok(Self {
+            sgt,
+            dev: dev.into(),
+            dir,
+        })
+    }
+}
+
+impl Drop for DmaMappedSgt {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY:
+        // - `self.dev.as_raw()` is a pointer to a valid `struct device`.
+        // - `self.dev` is the same device the mapping has been created for in `Self::new()`.
+        // - `self.sgt.as_ptr()` is a valid pointer to a `struct sg_table` by the type invariants
+        //   of `Self`.
+        // - `self.dir` is the same `dma::DataDirection` the mapping has been created with in
+        //   `Self::new()`.
+        unsafe {
+            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sgt.as_ptr(), self.dir.into(), 0)
+        };
+    }
+}
+
+#[repr(transparent)]
+#[pin_data(PinnedDrop)]
+struct RawSGTable {
+    #[pin]
+    sgt: Opaque<bindings::sg_table>,
+}
+
+// SAFETY: `RawSGTable` can be send to any task.
+unsafe impl Send for RawSGTable {}
+
+// SAFETY: `RawSGTable` can be accessed concurrently.
+unsafe impl Sync for RawSGTable {}
+
+impl RawSGTable {
+    fn new(
+        pages: &mut [*mut bindings::page],
+        size: usize,
+        max_segment: u32,
+        flags: alloc::Flags,
+    ) -> impl PinInit<Self, Error> + '_ {
+        try_pin_init!(Self {
+            sgt <- Opaque::try_ffi_init(|slot: *mut bindings::sg_table| {
+                // `sg_alloc_table_from_pages_segment()` expects at least one page, otherwise it
+                // produces a NPE.
+                if pages.is_empty() {
+                    return Err(EINVAL);
+                }
+
+                // SAFETY:
+                // - `slot` is a valid pointer to uninitialized memory.
+                // - As by the check above, `pages` is not empty.
+                error::to_result(unsafe {
+                    bindings::sg_alloc_table_from_pages_segment(
+                        slot,
+                        pages.as_mut_ptr(),
+                        pages.len().try_into()?,
+                        0,
+                        size,
+                        max_segment,
+                        flags.as_raw(),
+                    )
+                })
+            }),
+        })
+    }
+
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::sg_table {
+        self.sgt.get()
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for RawSGTable {
+    #[inline]
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: `sgt` is a valid and initialized `struct sg_table`.
+        unsafe { bindings::sg_free_table(self.sgt.get()) };
+    }
+}
+
+/// The [`Owned`] type state of an [`SGTable`].
+///
+/// A [`SGTable<Owned>`] signifies that the [`SGTable`] owns all associated resources:
+///
+/// - The backing memory pages.
+/// - The `struct sg_table` allocation (`sgt`).
+/// - The DMA mapping, managed through a [`Devres`]-managed `DmaMappedSgt`.
+///
+/// Users interact with this type through the [`SGTable`] handle and do not need to manage
+/// [`Owned`] directly.
+#[pin_data]
+pub struct Owned<P> {
+    // Note: The drop order is relevant; we first have to unmap the `struct sg_table`, then free the
+    // `struct sg_table` and finally free the backing pages.
+    #[pin]
+    dma: Devres<DmaMappedSgt>,
+    #[pin]
+    sgt: RawSGTable,
+    _pages: P,
+}
+
+// SAFETY: `Owned` can be send to any task if `P` can be send to any task.
+unsafe impl<P: Send> Send for Owned<P> {}
+
+// SAFETY: `Owned` can be accessed concurrently if `P` can be accessed concurrently.
+unsafe impl<P: Sync> Sync for Owned<P> {}
+
+impl<P> Owned<P>
+where
+    for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+{
+    fn new(
+        dev: &Device<Bound>,
+        mut pages: P,
+        dir: dma::DataDirection,
+        flags: alloc::Flags,
+    ) -> Result<impl PinInit<Self, Error> + '_> {
+        let page_iter = pages.page_iter();
+        let size = page_iter.size();
+
+        let mut page_vec: KVec<*mut bindings::page> =
+            KVec::with_capacity(page_iter.page_count(), flags)?;
+
+        for page in page_iter {
+            page_vec.push(page.as_ptr(), flags)?;
+        }
+
+        // `dma_max_mapping_size` returns `size_t`, but `sg_alloc_table_from_pages_segment()` takes
+        // an `unsigned int`.
+        //
+        // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device`.
+        let max_segment = match unsafe { bindings::dma_max_mapping_size(dev.as_raw()) } {
+            0 => u32::MAX,
+            max_segment => u32::try_from(max_segment).unwrap_or(u32::MAX),
+        };
+
+        Ok(try_pin_init!(&this in Self {
+            sgt <- RawSGTable::new(&mut page_vec, size, max_segment, flags),
+            dma <- {
+                // SAFETY: `this` is a valid pointer to uninitialized memory.
+                let sgt = unsafe { &raw mut (*this.as_ptr()).sgt }.cast();
+
+                // SAFETY: `sgt` is guaranteed to be non-null.
+                let sgt = unsafe { NonNull::new_unchecked(sgt) };
+
+                // SAFETY:
+                // - It is guaranteed that the object returned by `DmaMappedSgt::new` won't out-live
+                //   `sgt`.
+                // - `sgt` is never DMA unmapped manually.
+                Devres::new(dev, unsafe { DmaMappedSgt::new(sgt, dev, dir) })
+            },
+            _pages: pages,
+        }))
+    }
+}
+
+impl<P> SGTable<Owned<P>>
+where
+    for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
+{
+    /// Allocates a new scatter-gather table from the given pages and maps it for DMA.
+    ///
+    /// This constructor creates a new [`SGTable<Owned>`] that takes ownership of `P`.
+    /// It allocates a `struct sg_table`, populates it with entries corresponding to the physical
+    /// pages of `P`, and maps the table for DMA with the specified [`Device`] and
+    /// [`dma::DataDirection`].
+    ///
+    /// The DMA mapping is managed through [`Devres`], ensuring that the DMA mapping is unmapped
+    /// once the associated [`Device`] is unbound, or when the [`SGTable<Owned>`] is dropped.
+    ///
+    /// # Parameters
+    ///
+    /// * `dev`: The [`Device`] that will be performing the DMA.
+    /// * `pages`: The entity providing the backing pages. It must implement [`page::AsPageIter`].
+    ///   The ownership of this entity is moved into the new [`SGTable<Owned>`].
+    /// * `dir`: The [`dma::DataDirection`] of the DMA transfer.
+    /// * `flags`: Allocation flags for internal allocations (e.g., [`GFP_KERNEL`]).
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::{
+    ///     device::{Bound, Device},
+    ///     dma, page,
+    ///     prelude::*,
+    ///     scatterlist::{SGTable, Owned},
+    /// };
+    ///
+    /// fn test(dev: &Device<Bound>) -> Result {
+    ///     let size = 4 * page::PAGE_SIZE;
+    ///     let pages = VVec::<u8>::with_capacity(size, GFP_KERNEL)?;
+    ///
+    ///     let sgt = KBox::pin_init(SGTable::new(
+    ///         dev,
+    ///         pages,
+    ///         dma::DataDirection::ToDevice,
+    ///         GFP_KERNEL,
+    ///     ), GFP_KERNEL)?;
+    ///
+    ///     Ok(())
+    /// }
+    /// ```
+    pub fn new(
+        dev: &Device<Bound>,
+        pages: P,
+        dir: dma::DataDirection,
+        flags: alloc::Flags,
+    ) -> impl PinInit<Self, Error> + '_ {
+        try_pin_init!(Self {
+            inner <- Owned::new(dev, pages, dir, flags)?
+        })
+    }
+}
+
+impl<P> Deref for SGTable<Owned<P>> {
+    type Target = SGTable;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY:
+        // - `self.inner.sgt.as_raw()` is a valid pointer to a `struct sg_table` for the entire
+        //   lifetime of `self`.
+        // - The backing `struct sg_table` is not modified for the entire lifetime of `self`.
+        unsafe { SGTable::from_raw(self.inner.sgt.as_raw()) }
+    }
+}
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Borrowed {}
+    impl<P> Sealed for super::Owned<P> {}
+}
+
+/// An [`Iterator`] over the DMA mapped [`SGEntry`] items of an [`SGTable`].
+///
+/// Note that the existence of an [`SGTableIter`] does not guarantee that the [`SGEntry`] items
+/// actually remain DMA mapped; they are prone to be unmapped on device unbind.
+pub struct SGTableIter<'a> {
+    pos: Option<&'a SGEntry>,
+    /// The number of DMA mapped entries in a `struct sg_table`.
+    nents: c_uint,
+}
+
+impl<'a> Iterator for SGTableIter<'a> {
+    type Item = &'a SGEntry;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let entry = self.pos?;
+        self.nents = self.nents.saturating_sub(1);
+
+        // SAFETY: `entry.as_raw()` is a valid pointer to a `struct scatterlist`.
+        let next = unsafe { bindings::sg_next(entry.as_raw()) };
+
+        self.pos = (!next.is_null() && self.nents > 0).then(|| {
+            // SAFETY: If `next` is not NULL, `sg_next()` guarantees to return a valid pointer to
+            // the next `struct scatterlist`.
+            unsafe { SGEntry::from_raw(next) }
+        });
+
+        Some(entry)
+    }
+}
-- 
2.51.0


