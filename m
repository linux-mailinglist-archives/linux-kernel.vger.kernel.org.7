Return-Path: <linux-kernel+bounces-879834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E4AC242AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9583B7A13
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14A3314DA;
	Fri, 31 Oct 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PB7UMxvn"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5F331A4F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902735; cv=none; b=rF+qgsOYcn/drxwpu61Co1/zGZUNME5620MOBsoPh27dJyyf2vVq4Mshey2kn6UmmCRJE5OIuUQQWrFp0OltKl2tLlQbkJrZ1D2K/ggYdFWi9msAFw+9eX4xRKFlPt2husZLTUyCaVUNUJ/RTRxhV0q5DK9B5kyVrOwp7inHmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902735; c=relaxed/simple;
	bh=H+SwOtgpEfwAC8rV16otcbCN6D24hcLmmwyZaBXnIBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dUC69SrGVhwKKLzUeFQmk4leDw8pNS2uNpdUtUvd/IWXhto/mNTUfFWRA/ixHpkg7jfPp0cW6fElp+p8VY9k1qeoZXDfOEvt232grRr5GpTEZFf+jldF8nXf8QLBI2RXetDbW1kdbMi/9jDFU/bc7+S1uQw8BZk3ENiBbOSlzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PB7UMxvn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e39567579so12388275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761902731; x=1762507531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WlKnCisB9ct9qmD6vE7Q32WOqH6ypUITAGfg5cFitw=;
        b=PB7UMxvnQuO/mpa3FrAHsrKyI7NkEA40faxdqZChOtcJX3yXnGLKj9L9Yn2CY9soV5
         eY/RKHr54Vfmjt29W68Ek+jRjzZPmQ9H1mJWBvuv2uWuVIJX6R8DDRQH2HVVHl4Mvq1T
         g9WVox7xidpYSsjrRD6uwmK10ByJYSGW2Zer1LEThcwDrzJR6L1SYOhR/+iAYUhJQINF
         E0xPqwYlsZzTRotw4YuOPrUBAGXqJKR/AtIt6TtTL8VHmogVF0peRU5ySnI5ew3DP+j5
         e6oszF+wWOejNNhq8ZEknq7JM2nHw/Fz/IaPkP8ufGDL9tf/KvMwGaodQYWrevdRhHxO
         cieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902731; x=1762507531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WlKnCisB9ct9qmD6vE7Q32WOqH6ypUITAGfg5cFitw=;
        b=YBYawf7qKEN7eU3KmUaVj0mlWuPHmvNXZnIsRxTEZX+XbrexJYOCrR91E98EwPPP4c
         24NlXGOgQC3EpK+P6KIqmMt4GS9GJmC9DbnZKdWn0TahDc25XLdnLhvhk/bcD+WdiMwG
         Qg+mie+iIPVrHbSuhKJVWxQDrwaFBbOCHGD0kyNFzK/U8jrHVEHqUFN7WxFw7afxdcJ3
         /GSw8Oz3DlEV9BjpF3cd50jpTzasg+5Mg9u7Bd5zL/1bzak0up9QDl20MjMneRORmsUM
         9nGuIg1ve8GewpuaULiT0F2V3mNtS8a6Y3RPcYfujs6gMGDiZNpRUhSzD3dfYW4IdGjs
         oKLA==
X-Gm-Message-State: AOJu0Yzm4wrq9LGAuaY3GcX2xb4Um67L/X5wzyS2VAkfyKvMvVPpfJ/j
	OhVoDi3kMXs6EW/tDOhwBJP0mD8bzr3B+ZrLM8VBDcm7E/q+txi2tvqz1uznyhscRLcSvk4qSKZ
	Uyzb4Bhzuh2ns95NyQQ==
X-Google-Smtp-Source: AGHT+IHWugTxsig5fzodator7/hQMt08rOx6g1kN5VIX3Mbwa2C/APlNWSpe6c8n/O0bzJQw4pl8iXtD8Cfg3gA=
X-Received: from wmdd17.prod.google.com ([2002:a05:600c:a211:b0:475:da28:9004])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4591:b0:46f:d897:516f with SMTP id 5b1f17b1804b1-477308b51c3mr30708325e9.34.1761902731125;
 Fri, 31 Oct 2025 02:25:31 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:25:30 +0000
In-Reply-To: <20251030190613.1224287-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com> <20251030190613.1224287-4-joelagnelf@nvidia.com>
Message-ID: <aQSAijFQ6kBqI5f3@google.com>
Subject: Re: [PATCH RFC 3/4] rust: drm: Add DRM buddy allocator bindings
From: Alice Ryhl <aliceryhl@google.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	David Airlie <airlied@gmail.com>, acourbot@nvidia.com, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Andrea Righi <arighi@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 30, 2025 at 03:06:12PM -0400, Joel Fernandes wrote:
> Add safe Rust abstractions over the Linux kernel's DRM buddy
> allocator for physical memory management. The DRM buddy allocator
> implements a binary buddy system for useful for GPU physical memory
> allocation. nova-core will use it for physical memory allocation.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  rust/bindings/bindings_helper.h |  11 +
>  rust/helpers/drm.c              |  23 +-
>  rust/kernel/drm/buddy.rs        | 357 ++++++++++++++++++++++++++++++++
>  rust/kernel/drm/mod.rs          |   1 +
>  4 files changed, 391 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/drm/buddy.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 6b973589a546..747d4c7ef935 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -29,6 +29,7 @@
>  #include <linux/hrtimer_types.h>
>  
>  #include <linux/acpi.h>
> +#include <drm/drm_buddy.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> @@ -112,6 +113,16 @@ const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
>  const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
>  
> +#if IS_ENABLED(CONFIG_DRM_BUDDY)
> +const unsigned long RUST_CONST_HELPER_DRM_BUDDY_RANGE_ALLOCATION = DRM_BUDDY_RANGE_ALLOCATION;
> +const unsigned long RUST_CONST_HELPER_DRM_BUDDY_TOPDOWN_ALLOCATION = DRM_BUDDY_TOPDOWN_ALLOCATION;
> +const unsigned long RUST_CONST_HELPER_DRM_BUDDY_CONTIGUOUS_ALLOCATION =
> +								DRM_BUDDY_CONTIGUOUS_ALLOCATION;
> +const unsigned long RUST_CONST_HELPER_DRM_BUDDY_CLEAR_ALLOCATION = DRM_BUDDY_CLEAR_ALLOCATION;
> +const unsigned long RUST_CONST_HELPER_DRM_BUDDY_CLEARED = DRM_BUDDY_CLEARED;
> +const unsigned long RUST_CONST_HELPER_DRM_BUDDY_TRIM_DISABLE = DRM_BUDDY_TRIM_DISABLE;
> +#endif
> +
>  #if IS_ENABLED(CONFIG_ANDROID_BINDER_IPC_RUST)
>  #include "../../drivers/android/binder/rust_binder.h"
>  #include "../../drivers/android/binder/rust_binder_events.h"
> diff --git a/rust/helpers/drm.c b/rust/helpers/drm.c
> index 450b406c6f27..bd8748ade3f5 100644
> --- a/rust/helpers/drm.c
> +++ b/rust/helpers/drm.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <drm/drm_buddy.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_vma_manager.h>
>  
> @@ -20,4 +21,24 @@ __u64 rust_helper_drm_vma_node_offset_addr(struct drm_vma_offset_node *node)
>  	return drm_vma_node_offset_addr(node);
>  }
>  
> -#endif
> +#ifdef CONFIG_DRM_BUDDY
> +
> +u64 rust_helper_drm_buddy_block_offset(const struct drm_buddy_block *block)
> +{
> +	return drm_buddy_block_offset(block);
> +}
> +
> +unsigned int rust_helper_drm_buddy_block_order(struct drm_buddy_block *block)
> +{
> +	return drm_buddy_block_order(block);
> +}
> +
> +u64 rust_helper_drm_buddy_block_size(struct drm_buddy *mm,
> +				     struct drm_buddy_block *block)
> +{
> +	return drm_buddy_block_size(mm, block);
> +}
> +
> +#endif /* CONFIG_DRM_BUDDY */
> +
> +#endif /* CONFIG_DRM */
> diff --git a/rust/kernel/drm/buddy.rs b/rust/kernel/drm/buddy.rs
> new file mode 100644
> index 000000000000..b1cd23f81838
> --- /dev/null
> +++ b/rust/kernel/drm/buddy.rs
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! DRM buddy allocator bindings.
> +//!
> +//! C header: [`include/drm/drm_buddy.h`](srctree/include/drm/drm_buddy.h)
> +//!
> +//! This module provides Rust abstractions over the Linux kernel's DRM buddy
> +//! allocator, which implements a binary buddy memory allocation system.
> +//!
> +//! The buddy allocator manages a contiguous address space and allocates blocks
> +//! in power-of-two sizes. It's commonly used for physical memory management.
> +//!
> +//! # Examples
> +//!
> +//! ```ignore
> +//! use kernel::{
> +//!     drm::buddy::{BuddyFlags, DrmBuddy},
> +//!     prelude::*,
> +//!     sizes::*, //
> +//! };
> +//!
> +//! let buddy = DrmBuddy::new(SZ_1G, SZ_4K)?;
> +//! let allocated = buddy.alloc_blocks(
> +//!     0, 0, SZ_16M, SZ_4K,
> +//!     BuddyFlags::RANGE_ALLOCATION,
> +//!     GFP_KERNEL,
> +//! )?;
> +//!
> +//! for block in &allocated {
> +//!     // Use block.
> +//! }
> +//! // Blocks are automatically freed when `allocated` goes out of scope.
> +//! ```
> +
> +use crate::{
> +    alloc::Flags,
> +    bindings,
> +    clist,
> +    container_of,
> +    error::{
> +        to_result,
> +        Result, //
> +    },
> +    prelude::KBox,
> +    types::Opaque, //
> +};
> +use core::ptr::NonNull;
> +
> +/// Flags for DRM buddy allocator operations.
> +///
> +/// These flags control the allocation behavior of the buddy allocator.
> +#[derive(Clone, Copy, PartialEq)]
> +pub struct BuddyFlags(u64);
> +
> +impl BuddyFlags {
> +    /// Range-based allocation from start to end addresses.
> +    pub const RANGE_ALLOCATION: BuddyFlags =
> +        BuddyFlags(bindings::DRM_BUDDY_RANGE_ALLOCATION as u64);
> +
> +    /// Allocate from top of address space downward.
> +    pub const TOPDOWN_ALLOCATION: BuddyFlags =
> +        BuddyFlags(bindings::DRM_BUDDY_TOPDOWN_ALLOCATION as u64);
> +
> +    /// Allocate physically contiguous blocks.
> +    pub const CONTIGUOUS_ALLOCATION: BuddyFlags =
> +        BuddyFlags(bindings::DRM_BUDDY_CONTIGUOUS_ALLOCATION as u64);
> +
> +    /// Clear allocated blocks (zero them).
> +    pub const CLEAR_ALLOCATION: BuddyFlags =
> +        BuddyFlags(bindings::DRM_BUDDY_CLEAR_ALLOCATION as u64);
> +
> +    /// Block has been cleared - internal flag.
> +    pub const CLEARED: BuddyFlags = BuddyFlags(bindings::DRM_BUDDY_CLEARED as u64);
> +
> +    /// Disable trimming of partially used blocks.
> +    pub const TRIM_DISABLE: BuddyFlags = BuddyFlags(bindings::DRM_BUDDY_TRIM_DISABLE as u64);
> +
> +    /// Get raw value for FFI.
> +    pub(crate) fn as_raw(self) -> u64 {
> +        self.0
> +    }
> +}
> +
> +impl core::ops::BitOr for BuddyFlags {
> +    type Output = Self;
> +
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +/// DRM buddy allocator instance.
> +///
> +/// This structure wraps the C `drm_buddy` allocator.
> +///
> +/// # Safety
> +///
> +/// Not thread-safe. Concurrent alloc/free operations require external
> +/// synchronization (e.g., wrapping in `Arc<Mutex<DrmBuddy>>`).
> +///
> +/// # Invariants
> +///
> +/// - `mm` is initialized via `drm_buddy_init()` and remains valid until Drop.

Usually an invariant is a statement about the present rather than about
the past. I would say that `mm` is a valid buddy allocator.

> +pub struct DrmBuddy {
> +    mm: Opaque<bindings::drm_buddy>,
> +}
> +
> +impl DrmBuddy {
> +    /// Create a new buddy allocator.
> +    ///
> +    /// Creates a buddy allocator that manages a contiguous address space of the given
> +    /// size, with the specified minimum allocation unit (chunk_size must be at least 4KB).
> +    ///
> +    /// # Examples
> +    ///
> +    /// See the complete example in the documentation comments for [`AllocatedBlocks`].
> +    pub fn new(size: usize, chunk_size: usize) -> Result<Self> {
> +        // Create buddy allocator with zeroed memory.
> +        let buddy = Self {
> +            mm: Opaque::zeroed(),
> +        };
> +
> +        // Initialize the C buddy structure.
> +        // SAFETY: buddy.mm points to valid, zeroed memory.
> +        unsafe {
> +            to_result(bindings::drm_buddy_init(
> +                buddy.mm.get(),

After this call to drm_buddy_init, you return it which moves the struct.
Is the struct safe to move from one location to another?

Also I usually put the to_result outside of the unsafe block.

> +                size as u64,
> +                chunk_size as u64,
> +            ))?;
> +        }
> +
> +        Ok(buddy)
> +    }
> +
> +    /// Get a raw pointer to the underlying C drm_buddy structure.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller must ensure the returned pointer is not used after this
> +    /// structure is dropped.
> +    pub unsafe fn as_raw(&self) -> *mut bindings::drm_buddy {
> +        self.mm.get()
> +    }
> +
> +    /// Get the chunk size (minimum allocation unit).
> +    pub fn chunk_size(&self) -> u64 {
> +        // SAFETY: mm is initialized and valid per struct invariant.
> +        unsafe { (*self.as_raw()).chunk_size }
> +    }
> +
> +    /// Get the total managed size.
> +    pub fn size(&self) -> u64 {
> +        // SAFETY: mm is initialized and valid per struct invariant.
> +        unsafe { (*self.as_raw()).size }
> +    }
> +
> +    /// Get the available (free) memory.
> +    pub fn avail(&self) -> u64 {
> +        // SAFETY: mm is initialized and valid per struct invariant.
> +        unsafe { (*self.as_raw()).avail }
> +    }
> +
> +    /// Allocate blocks from the buddy allocator.
> +    ///
> +    /// Returns an [`AllocatedBlocks`] structure that owns the allocated blocks and automatically
> +    /// frees them when dropped. Allocation of `list_head` uses the `gfp` flags passed.
> +    pub fn alloc_blocks(
> +        &self,
> +        start: usize,
> +        end: usize,
> +        size: usize,
> +        min_block_size: usize,
> +        flags: BuddyFlags,
> +        gfp: Flags,
> +    ) -> Result<AllocatedBlocks<'_>> {
> +        // Allocate list_head on the heap.
> +        let mut list_head = KBox::new(bindings::list_head::default(), gfp)?;
> +
> +        // SAFETY: list_head is valid and heap-allocated.
> +        unsafe {
> +            bindings::INIT_LIST_HEAD(&mut *list_head as *mut _);
> +        }
> +
> +        // SAFETY: mm is a valid DrmBuddy object per the type's invariants.
> +        unsafe {
> +            to_result(bindings::drm_buddy_alloc_blocks(
> +                self.as_raw(),
> +                start as u64,
> +                end as u64,
> +                size as u64,
> +                min_block_size as u64,
> +                &mut *list_head as *mut _,
> +                flags.as_raw() as usize,
> +            ))?;
> +        }
> +
> +        // `list_head` is now the head of a list that contains allocated blocks
> +        // from C code. The allocated blocks will be automatically freed when
> +        // `AllocatedBlocks` is dropped.
> +        Ok(AllocatedBlocks {
> +            list_head,
> +            buddy: self,
> +        })
> +    }
> +}
> +
> +impl Drop for DrmBuddy {
> +    fn drop(&mut self) {
> +        // SAFETY: self.mm is initialized and valid. drm_buddy_fini properly
> +        // cleans up all resources. This is called exactly once during Drop.
> +        unsafe {
> +            bindings::drm_buddy_fini(self.as_raw());
> +        }
> +    }
> +}
> +
> +// SAFETY: DrmBuddy can be sent between threads. Caller is responsible for
> +// ensuring thread-safe access if needed (e.g., via Mutex).
> +unsafe impl Send for DrmBuddy {}

Generally, we should implement both Send and Sync unless we really can't
do so. If methods require external synchronization, then those methods
should be marked &mut self and then you implement Sync.

If you instead omit Sync and make the methods &self, then the caller is
severely restricted and can't e.g. store it in an Arc.

> +/// Allocated blocks from the buddy allocator with automatic cleanup.
> +///
> +/// This structure owns a list of allocated blocks and ensures they are
> +/// automatically freed when dropped. Blocks may be iterated over and are
> +/// read-only after allocation (iteration via [`IntoIterator`] and
> +/// automatic cleanup via [`Drop`] only). To share across threads, wrap
> +/// in `Arc<AllocatedBlocks>`. Rust owns the head list head of the
> +/// allocated blocks; C allocates blocks and links them to the head
> +/// list head. Clean up of the allocated blocks is handled by C code.
> +///
> +/// # Invariants
> +///
> +/// - `list_head` is an owned, valid, initialized list_head.
> +/// - `buddy` points to a valid, initialized [`DrmBuddy`].
> +pub struct AllocatedBlocks<'a> {
> +    list_head: KBox<bindings::list_head>,
> +    buddy: &'a DrmBuddy,
> +}
> +
> +impl Drop for AllocatedBlocks<'_> {
> +    fn drop(&mut self) {
> +        // Free all blocks automatically when dropped.
> +        // SAFETY: list_head is a valid list of blocks per the type's invariants.
> +        unsafe {
> +            bindings::drm_buddy_free_list(self.buddy.as_raw(), &mut *self.list_head as *mut _, 0);
> +        }
> +    }
> +}
> +
> +impl<'a> AllocatedBlocks<'a> {
> +    /// Check if the block list is empty.
> +    pub fn is_empty(&self) -> bool {
> +        // SAFETY: list_head is a valid list of blocks per the type's invariants.
> +        unsafe { clist::list_empty(&*self.list_head as *const _) }
> +    }
> +
> +    /// Iterate over allocated blocks.
> +    pub fn iter(&self) -> clist::ClistIter<'_, Block> {
> +        // SAFETY: list_head is a valid list of blocks per the type's invariants.
> +        clist::iter_list_head::<Block>(&*self.list_head)
> +    }
> +}
> +
> +/// Iteration support for allocated blocks.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// for block in &allocated_blocks {
> +///     // Use block.
> +/// }
> +/// ```
> +impl<'a> IntoIterator for &'a AllocatedBlocks<'_> {
> +    type Item = Block;
> +    type IntoIter = clist::ClistIter<'a, Block>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +/// A DRM buddy block.
> +///
> +/// Wraps a pointer to a C `drm_buddy_block` structure. This is returned
> +/// from allocation operations and used to free blocks.
> +///
> +/// # Invariants
> +///
> +/// `drm_buddy_block_ptr` points to a valid `drm_buddy_block` managed by the buddy allocator.
> +pub struct Block {
> +    drm_buddy_block_ptr: NonNull<bindings::drm_buddy_block>,
> +}

This type is exposed to the user by ownership (as opposed to being
exposed behind a reference), and has no lifetime annotation. This
implies that the caller is allowed to keep it alive for arbitrary
amounts of time.

However, it looks like dropping AllocatedBlock would also free this
Block object. That is a problem.

The ownership of Block should probably be tied to AllocatedBlock so that
the borrow-checker prevents dropping AllocatedBlock while Block objects
exist. Or this code should be changed so that Block keeps the underlying
AllocatedBlock alive using a refcount. Or similar. It depends on how it
will be used - if Block is stored long-term in structs, then you should
avoid lifetimes, but if it's a view into AllocatedBlock that is not
stored long-term, then lifetimes are the right choice.

> +impl Block {
> +    /// Get the block's offset in the address space.
> +    pub fn offset(&self) -> u64 {
> +        // SAFETY: drm_buddy_block_ptr is valid per the type's invariants.
> +        unsafe { bindings::drm_buddy_block_offset(self.drm_buddy_block_ptr.as_ptr()) }
> +    }
> +
> +    /// Get the block order (size = chunk_size << order).
> +    pub fn order(&self) -> u32 {
> +        // SAFETY: drm_buddy_block_ptr is valid per the type's invariants.
> +        unsafe { bindings::drm_buddy_block_order(self.drm_buddy_block_ptr.as_ptr()) }
> +    }
> +
> +    /// Get the block's size in bytes.
> +    ///
> +    /// Requires the buddy allocator to calculate size from order.
> +    pub fn size(&self, buddy: &DrmBuddy) -> u64 {
> +        // SAFETY: Both pointers are valid per the type's invariants.
> +        unsafe { bindings::drm_buddy_block_size(buddy.as_raw(), self.drm_buddy_block_ptr.as_ptr()) }
> +    }
> +
> +    /// Get a raw pointer to the underlying C block.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller must ensure the pointer is not used after the block is freed.
> +    pub unsafe fn as_ptr(&self) -> *mut bindings::drm_buddy_block {
> +        self.drm_buddy_block_ptr.as_ptr()
> +    }
> +}
> +
> +impl clist::FromListHead for Block {
> +    unsafe fn from_list_head(link: *const bindings::list_head) -> Self {
> +        // SAFETY: link points to a valid list_head embedded in drm_buddy_block.
> +        // The container_of macro calculates the containing struct pointer.
> +        // We need to account for the union field __bindgen_anon_1.link.
> +        //
> +        // The link is embedded in a union within drm_buddy_block:
> +        //     struct drm_buddy_block {
> +        //         [...]
> +        //         union {
> +        //             struct rb_node rb;
> +        //             struct list_head link;
> +        //         };
> +        //     }
> +        //
> +        // This is why we perform a double container_of calculation: first to get
> +        // to the union, then to get to the containing drm_buddy_block.
> +        unsafe {
> +            // First get to the union.
> +            let union_ptr = container_of!(link, bindings::drm_buddy_block__bindgen_ty_1, link);
> +            // Then get to the containing drm_buddy_block.
> +            let block_ptr =
> +                container_of!(union_ptr, bindings::drm_buddy_block, __bindgen_anon_1) as *mut _;
> +            Block {
> +                drm_buddy_block_ptr: NonNull::new_unchecked(block_ptr),
> +            }
> +        }
> +    }
> +}
> +
> +// SAFETY: Block is just a pointer wrapper and can be safely sent between threads.
> +unsafe impl Send for Block {}
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> index 1b82b6945edf..ee173729eac5 100644
> --- a/rust/kernel/drm/mod.rs
> +++ b/rust/kernel/drm/mod.rs
> @@ -2,6 +2,7 @@
>  
>  //! DRM subsystem abstractions.
>  
> +pub mod buddy;
>  pub mod device;
>  pub mod driver;
>  pub mod file;
> -- 
> 2.34.1
> 

