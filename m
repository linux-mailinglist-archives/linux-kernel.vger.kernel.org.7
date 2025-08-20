Return-Path: <linux-kernel+bounces-778565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712AB2E773
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE1D5E6EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E892D9496;
	Wed, 20 Aug 2025 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="mf/R3nKQ"
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8B29DB6E;
	Wed, 20 Aug 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725022; cv=none; b=iT6eNLuNfoyV6q1tF5FD6CU3pL1FArY9HlIG2u+/FiOo+JJ5oJNlOqGfn8cSxF0SnTrK3dkZSacTjiRAtj+2E3UurlHbWx4JqQNoghnt5mYJyb8avzhRFZAtxzeK1SJmU/Alq2XNId+5YV7fFSstgQWH1m39TGj5rPorM/QYAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725022; c=relaxed/simple;
	bh=TNzUA72+0K4ggUJ3oJk0Ogn+ATHZ/56byJs1ANSG/jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB51h2uVSSJhqf2hp671/YNzDhf/W6Bv6VvVBjZ801ySWvL/A4QE3WD1p/oX2kz2EEbyk2UbT78N73g8GsBZzhNIrDAW9oqSlBl5yjMJ0AJzEXGHY8KmTTtGf3DQ99K8kKqKWibVqed5B+mDQu5y/Mbw5JYQ8N/6cG0SUgGjkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=mf/R3nKQ; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1755725016; x=1755984216;
	bh=L2lmMiCxz3z9eulaWrPb4mQAD1x3ljhwt9NkaF9b+Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mf/R3nKQZI2mPzyjYexMBO1WjpPYu8Ev1dvQvwEeIYNHO6zGIDnwxtUNaEdIzTK24
	 hL0/FCXiJoyJIA/rjysJji75pmFjWcrQ4ESMvjo1ICGI1J6qhknFLq7UU//ANbohrM
	 fh34H/E8GvHijMXhNR6gQThWIFz4mVYrmX5XSv+xYy5tbe4KQnJoS66scV7Wsm+a9S
	 AHGR/hg6ob3dARXKjKl26pxmizmUrhQTfK8rZgCOKz+SPL8miBvcyOOyxb4OEtxULz
	 cFGXyERFZtfo1LuFyFwVhFxrmqe4LtfhwJnm/fdPsV+fEWz1TX6Sva9TVedsu8GQdA
	 i1X7tqtGJtXMA==
X-Pm-Submission-Id: 4c6fZY6bN4z1DDrn
Date: Wed, 20 Aug 2025 21:23:30 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH] rust: zpool: add abstraction for zpool drivers
Message-ID: <aKY80tcyQ8WHog1q@archiso>
References: <20250820091543.4165305-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820091543.4165305-1-vitaly.wool@konsulko.se>

On Wed, Aug 20, 2025 at 11:15:43AM +0200, Vitaly Wool wrote:
> Zpool is a common frontend for memory storage pool implementations.
> These pools are typically used to store compressed memory objects,
> e. g. for Zswap, the lightweight compressed cache for swap pages.
> 
> This patch provides the interface to use Zpool in Rust kernel code,
> thus enabling Rust implementations of Zpool allocators for Zswap.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/zpool.c            |   6 +
>  rust/kernel/alloc.rs            |   5 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/zpool.rs            | 269 ++++++++++++++++++++++++++++++++
>  6 files changed, 284 insertions(+)
>  create mode 100644 rust/helpers/zpool.c
>  create mode 100644 rust/kernel/zpool.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 84d60635e8a9..f0c4c454882b 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -75,6 +75,7 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <linux/xarray.h>
> +#include <linux/zpool.h>
>  #include <trace/events/rust_sample.h>
>  
>  #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..e1a7556cc700 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -51,3 +51,4 @@
>  #include "wait.c"
>  #include "workqueue.c"
>  #include "xarray.c"
> +#include "zpool.c"
> diff --git a/rust/helpers/zpool.c b/rust/helpers/zpool.c
> new file mode 100644
> index 000000000000..71ba173f917a
> --- /dev/null
> +++ b/rust/helpers/zpool.c
> @@ -0,0 +1,6 @@
> +#include <linux/zpool.h>
> +
> +void rust_helper_zpool_register_driver(struct zpool_driver *driver)
> +{
> +	zpool_register_driver(driver);
> +}
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index b39c279236f5..0fec5337908c 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -41,6 +41,11 @@
>  pub struct Flags(u32);
>  
>  impl Flags {
> +    /// Create from the raw representation
> +    pub fn new(f: u32) -> Self {
> +        Self(f)
> +    }
> +
>      /// Get the raw representation of this flag.
>      pub(crate) fn as_raw(self) -> u32 {
>          self.0
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..165d52feeea4 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -129,6 +129,8 @@
>  pub mod uaccess;
>  pub mod workqueue;
>  pub mod xarray;
> +#[cfg(CONFIG_ZPOOL)]
> +pub mod zpool;
>  
>  #[doc(hidden)]
>  pub use bindings;
> diff --git a/rust/kernel/zpool.rs b/rust/kernel/zpool.rs
> new file mode 100644
> index 000000000000..91926c2e99e8
> --- /dev/null
> +++ b/rust/kernel/zpool.rs
> @@ -0,0 +1,269 @@
> +use crate::{
> +    bindings,
> +    error::Result,
> +    kernel::alloc::Flags,
> +    str::CStr,
> +    types::{ForeignOwnable, Opaque},
> +};
> +use core::ffi::{c_int, c_uchar, c_void};
> +use core::ptr::null_mut;
> +use kernel::alloc::NumaNode;
> +use kernel::ThisModule;
> +
> +/// zpool API
> +pub trait Zpool {
> +    /// Opaque Rust representation of `struct zpool`.
> +    type Pool: ForeignOwnable;
> +
> +    /// Create a pool.
> +    fn create(name: *const c_uchar, gfp: Flags) -> Result<Self::Pool>;
> +
> +    /// Destroy the pool.
> +    fn destroy(pool: Self::Pool);
> +
> +    /// Allocate an object of size `size` using GFP flags `gfp` from the pool `pool`, wuth the
> +    /// preferred NUMA node `nid`. If the allocation is successful, an opaque handle is returned.
> +    fn malloc(
> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
> +        size: usize,
> +        gfp: Flags,
> +        nid: NumaNode,
> +    ) -> Result<usize>;
> +
> +    /// Free a previously allocated from the `pool` object, represented by `handle`.
> +    fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle: usize);
> +
> +    /// Make all the necessary preparations for the caller to be able to read from the object
> +    /// represented by `handle` and return a valid pointer to the `handle` memory to be read.
> +    fn read_begin(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, handle: usize)
> +        -> *mut c_void;
> +
> +    /// Finish reading from a previously allocated `handle`. `handle_mem` must be the pointer
> +    /// previously returned by `read_begin`.
> +    fn read_end(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: usize,
> +        handle_mem: *mut c_void,
> +    );
> +
> +    /// Write to the object represented by a previously allocated `handle`. `handle_mem` points
> +    /// to the memory to copy data from, and `mem_len` defines the length of the data block to
> +    /// be copied.
> +    fn write(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: usize,
> +        handle_mem: *mut c_void,
> +        mem_len: usize,
> +    );
> +
> +    /// Get the number of pages used by the `pool`.
> +    fn total_pages(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>) -> u64;
> +}
> +
> +/// Zpool driver registration trait.
> +pub trait Registration {
> +    /// Register a zpool driver.
> +    fn register(&self, name: &'static CStr, module: &'static ThisModule) -> Result;
> +
> +    /// Pool creation callback.
> +    extern "C" fn _create(name: *const c_uchar, gfp: u32) -> *mut c_void;
> +
> +    /// Pool destruction callback.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct zpool`.
> +    unsafe extern "C" fn _destroy(pool: *mut c_void);
> +
> +    /// Callback for object allocation in the pool.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct zpool` and that `handle`
> +    /// is a valid pointer to usize.
> +    unsafe extern "C" fn _malloc(
> +        pool: *mut c_void,
> +        size: usize,
> +        gfp: u32,
> +        handle: *mut usize,
> +        nid: c_int,
> +    ) -> c_int;
> +
> +    /// Callback for object release.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct zpool`.
> +    unsafe extern "C" fn _free(pool: *mut c_void, handle: usize);
> +
> +    /// Callback to prepare the object for reading.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct zpool`.
> +    unsafe extern "C" fn _obj_read_begin(
> +        pool: *mut c_void,
> +        handle: usize,
> +        local_copy: *mut c_void,
> +    ) -> *mut c_void;
> +
> +    /// Callback to signal the end of reading from an object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct zpool`.
> +    unsafe extern "C" fn _obj_read_end(pool: *mut c_void, handle: usize, handle_mem: *mut c_void);
> +
> +    /// Callback for writing to an object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct zpool`.
> +    unsafe extern "C" fn _obj_write(
> +        pool: *mut c_void,
> +        handle: usize,
> +        handle_mem: *mut c_void,
> +        mem_len: usize,
> +    );
> +
> +    /// Callback to return the number of pages in the pool.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `pool` is a valid pointer to `struct zpool`.
> +    unsafe extern "C" fn _total_pages(pool: *mut c_void) -> u64;
> +}
> +
> +/// Zpool driver structure.
> +pub struct ZpoolDriver<T: Zpool> {
> +    inner: Opaque<bindings::zpool_driver>,
> +
> +    /// Zpool callback functions that a zpool driver must provide
> +    pub callbacks: T,
> +}
> +
> +impl<T: Zpool> Clone for ZpoolDriver<T> {
> +    fn clone(&self) -> Self {
> +        todo!()
> +    }
> +}
> +
> +// SAFETY: zpool driver must ensure that ZpoolDriver's `callbacks` are thread safe
> +unsafe impl<T: Zpool> Sync for ZpoolDriver<T> {}
> +
> +impl<T: Zpool> ZpoolDriver<T> {
> +    /// create an instance of a zpool driver
> +    pub const fn new(t: T) -> Self {
> +        Self {
> +            inner: Opaque::uninit(),
> +            callbacks: t,
> +        }
> +    }
> +}
> +
> +impl<T: Zpool> Registration for ZpoolDriver<T> {
> +    extern "C" fn _create(name: *const c_uchar, gfp: u32) -> *mut c_void {
> +        let pool = T::create(name, Flags::new(gfp));
> +        match pool {
> +            Err(_) => null_mut(),
> +            Ok(p) => T::Pool::into_foreign(p),
> +        }
> +    }
> +    unsafe extern "C" fn _destroy(pool: *mut c_void) {
> +        // SAFETY: The pointer originates from an `into_foreign` call.
> +        T::destroy(unsafe { T::Pool::from_foreign(pool) })
> +    }
> +    unsafe extern "C" fn _malloc(
> +        pool: *mut c_void,
> +        size: usize,
> +        gfp: u32,
> +        handle: *mut usize,
> +        nid: c_int,
> +    ) -> c_int {
> +        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
> +        // `from_foreign`, then that happens in `_destroy` which will not be called during this
> +        // method.
> +        let pool = unsafe { T::Pool::borrow_mut(pool) };
> +        let real_nid = match nid {
> +            bindings::NUMA_NO_NODE => Ok(NumaNode::NO_NODE),
> +            _ => NumaNode::new(nid),
> +        };
> +        if real_nid.is_err() {
> +            return -(bindings::EINVAL as i32);
> +        }
> +
> +        let result = T::malloc(pool, size, Flags::new(gfp), real_nid.unwrap());
> +        match result {
> +            Err(_) => -(bindings::ENOMEM as i32),
> +            Ok(h) => {
> +                // SAFETY: handle is guaranteed to be a valid pointer by zpool
> +                unsafe { *handle = h };
> +                0
> +            }
> +        }
> +    }
> +    unsafe extern "C" fn _free(pool: *mut c_void, handle: usize) {
> +        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
> +        // `from_foreign`, then that happens in `_destroy` which will not be called during this
> +        // method.
> +        let pool = unsafe { T::Pool::borrow(pool) };
> +        T::free(pool, handle)
> +    }
> +    unsafe extern "C" fn _obj_read_begin(
> +        pool: *mut c_void,
> +        handle: usize,
> +        _local_copy: *mut c_void,
> +    ) -> *mut c_void {
> +        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
> +        // `from_foreign`, then that happens in `_destroy` which will not be called during this
> +        // method.
> +        let pool = unsafe { T::Pool::borrow(pool) };
> +        T::read_begin(pool, handle)
> +    }
> +    unsafe extern "C" fn _obj_read_end(pool: *mut c_void, handle: usize, handle_mem: *mut c_void) {
> +        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
> +        // `from_foreign`, then that happens in `_destroy` which will not be called during this
> +        // method.
> +        let pool = unsafe { T::Pool::borrow(pool) };
> +        T::read_end(pool, handle, handle_mem)
> +    }
> +    unsafe extern "C" fn _obj_write(
> +        pool: *mut c_void,
> +        handle: usize,
> +        handle_mem: *mut c_void,
> +        mem_len: usize,
> +    ) {
> +        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
> +        // `from_foreign`, then that happens in `_destroy` which will not be called during this
> +        // method.
> +        let pool = unsafe { T::Pool::borrow(pool) };
> +        T::write(pool, handle, handle_mem, mem_len);
> +    }
> +    unsafe extern "C" fn _total_pages(pool: *mut c_void) -> u64 {
> +        // SAFETY: The pointer originates from an `into_foreign` call. If `pool` is passed to
> +        // `from_foreign`, then that happens in `_destroy` which will not be called during this
> +        // method.
> +        let pool = unsafe { T::Pool::borrow(pool) };
> +        T::total_pages(pool)
> +    }
> +
> +    fn register(&self, name: &'static CStr, module: &'static ThisModule) -> Result {
> +        // SAFETY: `ZpoolDriver::new()` ensures that `self.inner` is a valid pointer
> +        unsafe {
> +            (*(self.inner.get())).create = Some(Self::_create);
> +            (*(self.inner.get())).destroy = Some(Self::_destroy);
> +            (*(self.inner.get())).malloc = Some(Self::_malloc);
> +            (*(self.inner.get())).free = Some(Self::_free);
> +            (*(self.inner.get())).obj_read_begin = Some(Self::_obj_read_begin);
> +            (*(self.inner.get())).obj_read_end = Some(Self::_obj_read_end);
> +            (*(self.inner.get())).obj_write = Some(Self::_obj_write);
> +            (*(self.inner.get())).total_pages = Some(Self::_total_pages);
> +
> +            (*(self.inner.get())).owner = module.0;
> +            (*(self.inner.get())).type_ = name.as_char_ptr().cast_mut();
> +
> +            bindings::zpool_register_driver(self.inner.get());
> +        }
> +        Ok(())
> +    }
> +}
> -- 
> 2.39.2

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

