Return-Path: <linux-kernel+bounces-736703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B74B0A0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363281C45BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50B2BCF67;
	Fri, 18 Jul 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzNUaPFs"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455729E0F5;
	Fri, 18 Jul 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834858; cv=none; b=mH9HOM7kE7EvWfvqUBdFTEc8J2DiURCxSObNdAWFZmG9lNr+ZHY5oq988O2/jf4mPdxQ2K2AjIO0kgnU/8Pw1Mlsn8JhPHQKfZ72pJpc8XvzLXe3Cb2wYHNP2/M4eEVhKa0vF8ukfaH7kKXBtO0cJydudA24B2xvPQPJ8Bd9sUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834858; c=relaxed/simple;
	bh=aBqxDZ1/mgaSKPlSv32BgkRQGt1vHo0efLDDYvj6MMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHGmKSYXUiE/OkaTEW8p6K054koCRkQ799V2s+AJfO+7lmJR0Djh574Sfuf1en8mYpIG4PFvycasNwY8xGoDB5Il6aMHT3BV584oHZJXokIkMmMoOdpeqGN/Zgs7i4wDPIMRET4hFmJ7KuuVajKfLUyL6JMR8HPaNH189MNm2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzNUaPFs; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553d52cb80dso2241336e87.1;
        Fri, 18 Jul 2025 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752834853; x=1753439653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBNTTvDcnUbY587rkH7haQFH8Fttl3Apog3xYkxmAs4=;
        b=LzNUaPFsTttjJKs4aGPwPjdwfWtVh69kowXdU2NbNxmgh0/pGtQt37enskbgy9BByA
         Z8Eo/pCgb6ojZ/U0UlxpjuZFarpJKZ0BhFSvViyTjlYRk99OXm1iSXM1bEtHbfw3NC+B
         nbBYE8i6lD7jchvJL+jJciWmvN2PcQBGgqC9sJS+Y0lG42fodQtDI/TS8o5bHI7FydUy
         gD+RTchq05Jp7Bq6Xjsz00P504iu6j1/GuG9+kPxhykYA1jBKUGdBvB2F0nk7C8nZ3Zl
         4TRxiWq/72p7YY+WEyVhHawo3tCIRMtzJ56+JGBX286CDzJ0VbWqs2te0nTSmA6O7LJu
         TRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834853; x=1753439653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBNTTvDcnUbY587rkH7haQFH8Fttl3Apog3xYkxmAs4=;
        b=e0qU2cNzpo9hWdD1CP25vKJu4qdpJ3mNia8sZ31aMzXG5xa5fw2NlbrwJ3blLMwkiu
         xixDTvHGe3ulDNmZATmHNX0pBVu8vsjNhVYKjYyr8agnOKAJRa9vvIl51iaYgZC9213R
         llp9CsZ0FFBRlItz0cbPqSULsrwyAu3WuETgeOOABfFsnNfHtgI0EzuSaoZrZ5j8Y7Bf
         YAerY353+xJSAIOfDtEmwwvVIywwlNgWRJF85+dIQlQ0SwPUdXYdklS2bOOKYwYUyZ7f
         9BJDOL+Xae430D4/q8i8H8THpAvHZJmMToh5+o7K9ojPllhDt6aSnFpm+CSBgtZS9Ir5
         IeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYkSe7zrt3vNpu/G496955A+lKi/AzH7ZOZusouguzT+frF+Yj6WFt/Rxdv/5zpf2dDVfyKuyYHS5pkJE=@vger.kernel.org, AJvYcCV7C1QoV4lotwA+kzSa6lvRP/Ly+zvbWOtS0R94+yfmmcQMVZGJMqr4nUoMhumP/WnEuLpUcwx5zjF8sSNqOEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iqzgtJO1MmACfOoVzWhT2RoZb6S3HVixrZR6RxTJtEEegdjx
	6Pw2j3hfBmjJiXbS5vbrk6nGdPk9TDO5PjtvXyK4tPajWfwwOPOkoVDX
X-Gm-Gg: ASbGncuq277PCtmP6/+EpixShLA4hr97ibazdX3su0tiPXiPpYFiRMVRpsDo1psizrn
	+RLdhJjP9RkQ4NWIcWN7jauOinrQzrlesnouZJ/F+AXUzrjglQ1ETHMZEc/g6CiG/GGfSgDyQvm
	VSYi+Fk58Nsw7kaYNyNInI7dPJjZqYjcECvUpHUu4J5cJlgMHAWw/GG9aZDOIHIR6gpnGzi/mLO
	KpUjb9sFHjI6Qkvj4j9WLocdeSqAQn7wLXSGHYf4qrN+INO/miLXQm3vSrKNwjSfxNhtQv9axiA
	g/L4uOyeXCizEd0aiWbkeKcAicP/LAPE52T3bLgztKdjsCqvLhMujItVDPWQVACeFXUDd7y911E
	xd/DeMdK1eDqA2IwNRT75KDX+AAu/pCpTtBjmdDFnN53tTH1hsyJ1jrj6gTY8l7pIHQ3Zoq9yoM
	+r2pbwY24JBg==
X-Google-Smtp-Source: AGHT+IH0MsNweM8xSTYQ+M+hA9t/qQZscAZJpsmxNCp3KIxfi0iDPhqMnlIhJinbwcTVdvidEFD5rg==
X-Received: by 2002:a05:6512:61a1:b0:554:e7ce:97f8 with SMTP id 2adb3069b0e04-55a28cc9ba1mr2009941e87.15.1752834853087;
        Fri, 18 Jul 2025 03:34:13 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d9176bsm203689e87.161.2025.07.18.03.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:34:12 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org,
	jgg@ziepe.ca,
	lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	rust-for-linux@vger.kernel.org,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 1/2] rust: add initial scatterlist abstraction
Date: Fri, 18 Jul 2025 13:33:34 +0300
Message-ID: <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the rust abstraction for scatterlist. This allows use of the C
scatterlist within Rust code which the caller can allocate themselves
or to wrap existing kernel sg_table objects.

Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  30 +++
 rust/kernel/dma.rs              |  18 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 405 ++++++++++++++++++++++++++++++++
 6 files changed, 456 insertions(+)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8cbb660e2ec2..e1e289284ce8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -47,6 +47,7 @@
 #include <linux/cred.h>
 #include <linux/device/faux.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direction.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0683fffdbde2..7b18bde78844 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -35,6 +35,7 @@
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
+#include "scatterlist.c"
 #include "security.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
new file mode 100644
index 000000000000..c871de853539
--- /dev/null
+++ b/rust/helpers/scatterlist.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-direction.h>
+
+void rust_helper_sg_set_page(struct scatterlist *sg, struct page *page,
+			     unsigned int len, unsigned int offset)
+{
+	return sg_set_page(sg, page, len, offset);
+}
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
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 1f7bae643416..598fa50e878d 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -102,6 +102,24 @@ pub mod attrs {
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
 
+/// DMA mapping direction.
+///
+/// Corresponds to the kernel's [`enum dma_data_direction`].
+///
+/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
+#[derive(Copy, Clone, PartialEq, Eq)]
+#[repr(i32)]
+pub enum DmaDataDirection {
+    /// Direction isn't known.
+    DmaBidirectional = bindings::dma_data_direction_DMA_BIDIRECTIONAL,
+    /// Data is going from the memory to the device.
+    DmaToDevice = bindings::dma_data_direction_DMA_TO_DEVICE,
+    /// Data is coming from the device to the memory.
+    DmaFromDevice = bindings::dma_data_direction_DMA_FROM_DEVICE,
+    /// No direction (used for debugging).
+    DmaNone = bindings::dma_data_direction_DMA_NONE,
+}
+
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f61ac6f81f5d..48391a75bb62 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -101,6 +101,7 @@
 pub mod print;
 pub mod rbtree;
 pub mod revocable;
+pub mod scatterlist;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..0242884bf9fd
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Scatterlist
+//!
+//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
+
+use core::borrow::{Borrow, BorrowMut};
+
+use crate::{
+    bindings,
+    device::{Bound, Device},
+    dma::DmaDataDirection,
+    error::{Error, Result},
+    page::Page,
+    types::{ARef, Opaque},
+};
+
+/// A single scatter-gather entry, representing a span of pages in the device's DMA address space.
+///
+/// This interface is accessible only via the `SGTable` iterators. When using the API safely, certain
+/// methods are only available depending on a specific state of operation of the scatter-gather table,
+/// i.e. setting page entries is done internally only during construction while retrieving the DMA address
+/// is only possible when the `SGTable` is already mapped for DMA via a device.
+///
+/// # Invariants
+///
+/// The `scatterlist` pointer is valid for the lifetime of an SGEntry instance.
+#[repr(transparent)]
+pub struct SGEntry(Opaque<bindings::scatterlist>);
+
+impl SGEntry {
+    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
+    ///
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the lifetime
+    /// of the returned reference.
+    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
+        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
+    ///
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
+    ///
+    /// # Safety
+    ///
+    /// See safety requirements of [`SGEntry::as_ref`]. In addition, callers must ensure that only
+    /// a single mutable reference can be taken from the same raw pointer, i.e. for the lifetime of the
+    /// returned reference, no other call to this function on the same `struct scatterlist *` should
+    /// be permitted.
+    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> &'a mut Self {
+        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Obtain the raw `struct scatterlist *`.
+    pub(crate) fn as_raw(&self) -> *mut bindings::scatterlist {
+        self.0.get()
+    }
+
+    /// Returns the DMA address of this SG entry.
+    pub fn dma_address(&self) -> bindings::dma_addr_t {
+        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
+        unsafe { bindings::sg_dma_address(self.0.get()) }
+    }
+
+    /// Returns the length of this SG entry.
+    pub fn dma_len(&self) -> u32 {
+        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
+        unsafe { bindings::sg_dma_len(self.0.get()) }
+    }
+
+    /// Internal constructor helper to set this entry to point at a given page. Not to be used directly.
+    fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
+        let c: *mut bindings::scatterlist = self.0.get();
+        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
+        // `Page` invariant also ensure the pointer is valid.
+        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
+    }
+}
+
+/// Trait implemented by all mapping states.
+pub trait MappingState {}
+
+/// Trait implemented by all mapping states representing the fact that a `struct sg_table` is
+/// mapped (and thus its DMA addresses are valid).
+pub trait MappedState: MappingState {}
+
+/// Represents the fact that a `struct sg_table` is not DMA-mapped.
+pub struct Unmapped;
+impl MappingState for Unmapped {}
+
+/// Represents the fact that a `struct sg_table` is DMA-mapped by an external entity.
+pub struct BorrowedMapping;
+impl MappingState for BorrowedMapping {}
+impl MappedState for BorrowedMapping {}
+
+/// A managed DMA mapping of a `struct sg_table` to a given device.
+///
+/// The mapping is cleared when this object is dropped.
+///
+/// # Invariants
+///
+/// - The `scatterlist` pointer is valid for the lifetime of a `ManagedMapping` instance.
+/// - The `Device` instance is within a [`kernel::device::Bound`] context.
+pub struct ManagedMapping {
+    dev: ARef<Device>,
+    dir: DmaDataDirection,
+    // This works because the `sgl` member of `struct sg_table` never moves, and the fact we can
+    // build this implies that we have an exclusive reference to the `sg_table`, thus it cannot be
+    // modified by anyone else.
+    sgl: *mut bindings::scatterlist,
+    orig_nents: ffi::c_uint,
+}
+
+/// SAFETY: An `ManagedMapping` object is an immutable interface and should be safe to `Send` across threads.
+unsafe impl Send for ManagedMapping {}
+impl MappingState for ManagedMapping {}
+impl MappedState for ManagedMapping {}
+
+impl Drop for ManagedMapping {
+    fn drop(&mut self) {
+        // SAFETY: Invariants on `Device<Bound>` and `Self` ensures that the `self.dev` and `self.sgl`
+        // are valid.
+        unsafe {
+            bindings::dma_unmap_sg_attrs(
+                self.dev.as_raw(),
+                self.sgl,
+                self.orig_nents as i32,
+                self.dir as i32,
+                0,
+            )
+        };
+    }
+}
+
+/// A scatter-gather table of DMA address spans.
+///
+/// This structure represents the Rust abstraction for a C `struct sg_table`. This implementation
+/// abstracts the usage of an already existing C `struct sg_table` within Rust code that we get
+/// passed from the C side.
+pub struct SGTable<T: Borrow<bindings::sg_table>, M: MappingState> {
+    /// Mapping state of the underlying `struct sg_table`.
+    ///
+    /// This defines which methods of `SGTable` are available.
+    ///
+    /// Declared first so it is dropped before `table`, so we remove the mapping before freeing the
+    /// SG table if the latter is owned.
+    _mapping: M,
+
+    /// Something that can borrow the underlying `struct sg_table`.
+    table: T,
+}
+
+impl<T> SGTable<T, Unmapped>
+where
+    T: Borrow<bindings::sg_table>,
+{
+    /// Create a new unmapped `SGTable` from an already-existing `struct sg_table`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct sg_table` borrowed by `r` is initialized, valid for
+    /// the lifetime of the returned reference, and is not mapped.
+    pub unsafe fn new_unmapped(r: T) -> Self {
+        Self {
+            table: r,
+            _mapping: Unmapped,
+        }
+    }
+}
+
+impl<T> SGTable<T, BorrowedMapping>
+where
+    T: Borrow<bindings::sg_table>,
+{
+    /// Create a new mapped `SGTable` from an already-existing `struct sg_table`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct sg_table` borrowed by `r` is initialized, valid for
+    /// the lifetime of the returned reference, and is DMA-mapped.
+    pub unsafe fn new_mapped(r: T) -> Self {
+        Self {
+            table: r,
+            _mapping: BorrowedMapping,
+        }
+    }
+}
+
+impl<T, M> SGTable<T, M>
+where
+    T: Borrow<bindings::sg_table>,
+    M: MappedState,
+{
+    /// Returns an immutable iterator over the scatter-gather table.
+    pub fn iter(&self) -> SGTableIter<'_> {
+        SGTableIter {
+            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
+            pos: Some(unsafe { SGEntry::as_ref(self.table.borrow().sgl) }),
+        }
+    }
+}
+
+/// Provides a list of pages that can be used to build a `SGTable`.
+pub trait SGTablePages {
+    /// Returns an iterator to the pages providing the backing memory of `self`.
+    ///
+    /// Implementers should return an iterator which provides information regarding each page entry to
+    /// build the `SGTable`. The first element in the tuple is a reference to the Page, the second element
+    /// as the offset into the page, and the third as the length of data. The fields correspond to the
+    /// first three fields of the C `struct scatterlist`.
+    fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)>;
+
+    /// Returns the number of pages in the list.
+    fn entries(&self) -> usize;
+}
+
+/// An iterator through `SGTable` entries.
+pub struct SGTableIter<'a> {
+    pos: Option<&'a SGEntry>,
+}
+
+impl<'a> Iterator for SGTableIter<'a> {
+    type Item = &'a SGEntry;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let entry = self.pos;
+        // SAFETY: `sg` is an immutable reference and is equivalent to `scatterlist` via its type
+        // invariants, so its safe to use with sg_next.
+        let next = unsafe { bindings::sg_next(self.pos?.as_raw()) };
+
+        // SAFETY: `sg_next` returns either a valid pointer to a `scatterlist`, or null if we
+        // are at the end of the scatterlist.
+        self.pos = (!next.is_null()).then(|| unsafe { SGEntry::as_ref(next) });
+        entry
+    }
+}
+
+impl<'a, T, M> IntoIterator for &'a SGTable<T, M>
+where
+    T: Borrow<bindings::sg_table>,
+    M: MappedState,
+{
+    type Item = &'a SGEntry;
+    type IntoIter = SGTableIter<'a>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<T> SGTable<T, Unmapped>
+where
+    T: BorrowMut<bindings::sg_table>,
+{
+    /// Map this scatter-gather table describing a buffer for DMA by the `Device`.
+    ///
+    /// To prevent the table from being mapped more than once, this call consumes `self` and transfers
+    /// ownership of resources to the new `SGTable<_, ManagedMapping>` object.
+    pub fn dma_map(
+        mut self,
+        dev: &Device<Bound>,
+        dir: DmaDataDirection,
+    ) -> Result<SGTable<T, ManagedMapping>> {
+        // SAFETY: Invariants on `Device<Bound>` and `SGTable` ensures that the pointers are valid.
+        let ret = unsafe {
+            bindings::dma_map_sgtable(
+                dev.as_raw(),
+                self.table.borrow_mut(),
+                dir as i32,
+                bindings::DMA_ATTR_NO_WARN as usize,
+            )
+        };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+
+        let sgl = self.table.borrow_mut().sgl;
+        let orig_nents = self.table.borrow().orig_nents;
+
+        Ok(SGTable {
+            table: self.table,
+            // INVARIANT:
+            // - `sgl` is valid by the type invariant of `OwnedSgt`.
+            // - `dev` is a reference to Device<Bound>.
+            _mapping: ManagedMapping {
+                dev: dev.into(),
+                dir,
+                sgl,
+                orig_nents,
+            },
+        })
+    }
+}
+
+/// An owned `struct sg_table`, which lifetime is tied to this object.
+///
+/// # Invariants
+///
+/// The `sg_table` is valid and initialized for the lifetime of an `OwnedSgt` instance.
+pub struct OwnedSgt<P: SGTablePages> {
+    sgt: bindings::sg_table,
+    /// Used to keep the memory pointed to by `sgt` alive.
+    _pages: P,
+}
+
+/// SAFETY: An `OwnedSgt` object is constructed internally by `SGTable` and no interface is exposed to
+/// the user to modify its state after construction, except [`SGTable::dma_map`] which transfers
+/// ownership of the object, hence should be safe to `Send` across threads.
+unsafe impl<P: SGTablePages> Send for OwnedSgt<P> {}
+
+impl<P> Drop for OwnedSgt<P>
+where
+    P: SGTablePages,
+{
+    fn drop(&mut self) {
+        // SAFETY: Invariant on `OwnedSgt` ensures that the sg_table is valid.
+        unsafe { bindings::sg_free_table(&mut self.sgt) };
+    }
+}
+
+impl<P> Borrow<bindings::sg_table> for OwnedSgt<P>
+where
+    P: SGTablePages,
+{
+    fn borrow(&self) -> &bindings::sg_table {
+        &self.sgt
+    }
+}
+
+// To allow mapping the state!
+impl<P> BorrowMut<bindings::sg_table> for OwnedSgt<P>
+where
+    P: SGTablePages,
+{
+    fn borrow_mut(&mut self) -> &mut bindings::sg_table {
+        &mut self.sgt
+    }
+}
+
+impl<P: SGTablePages> SGTable<OwnedSgt<P>, Unmapped> {
+    /// Allocate and build a new `SGTable` from an existing list of `pages`. This method moves the
+    /// ownership of `pages` to the table.
+    ///
+    /// To build a scatter-gather table, provide the `pages` object which must implement the
+    /// `SGTablePages` trait.
+    ///
+    ///# Examples
+    ///
+    /// ```
+    /// use kernel::{device::Device, scatterlist::*, page::*, prelude::*};
+    ///
+    /// struct PagesArray(KVec<Page>);
+    /// impl SGTablePages for PagesArray {
+    ///     fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)> {
+    ///         self.0.iter().map(|page| (page, kernel::page::PAGE_SIZE, 0))
+    ///     }
+    ///
+    ///     fn entries(&self) -> usize {
+    ///         self.0.len()
+    ///     }
+    /// }
+    ///
+    /// let mut pages = KVec::new();
+    /// let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
+    /// let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
+    /// let sgt = SGTable::new_owned(PagesArray(pages), GFP_KERNEL)?;
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn new_owned(pages: P, flags: kernel::alloc::Flags) -> Result<Self> {
+        // SAFETY: `sgt` is not a reference.
+        let mut sgt: bindings::sg_table = unsafe { core::mem::zeroed() };
+
+        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table` object hence is valid.
+        let ret =
+            unsafe { bindings::sg_alloc_table(&mut sgt, pages.entries() as u32, flags.as_raw()) };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+        // SAFETY: We just successfully allocated `sgt`, hence the pointer is valid and have sole access to
+        // it at this point.
+        let sgentries = unsafe { core::slice::from_raw_parts_mut(sgt.sgl, pages.entries()) };
+        for (entry, page) in sgentries
+            .iter_mut()
+            .map(|e|
+                 // SAFETY: `SGEntry::as_mut` is called on the pointer only once, which is valid and non-NULL
+                 // while inside the closure.
+                 unsafe { SGEntry::as_mut(e) })
+            .zip(pages.iter())
+        {
+            entry.set_page(page.0, page.1 as u32, page.2 as u32)
+        }
+
+        Ok(Self {
+            // INVARIANT: We just successfully allocated and built the table from the page entries.
+            table: OwnedSgt { sgt, _pages: pages },
+            _mapping: Unmapped,
+        })
+    }
+}
-- 
2.43.0


