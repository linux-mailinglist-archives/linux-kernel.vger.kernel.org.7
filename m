Return-Path: <linux-kernel+bounces-829686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E901BB97A16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE18F1AE0B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5CA30F937;
	Tue, 23 Sep 2025 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1Bc81Rr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1FB30BF4F;
	Tue, 23 Sep 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664160; cv=none; b=C7/B8uLM9ycCaSjN8hkXeeB9xZ6KDgCcetGFOqLzBgs6wQcZljUsaW4Bw3yj/ekfcodZ2/k3J+086KUoaJaRmZjctAk+PUsMDZQMnnmWojOmEbE3RoM4ni+jt4Bgefmbr3hyjC6uO2MrG+FYSkUxgucFSthiVBd44BH4qntx28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664160; c=relaxed/simple;
	bh=ChC2KyA/fTMtoZzgrq/SqK8d2afgq+qtJhPKhNHFHPA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=h4MvvlIShxkATql7Wa5y6iSN0E5TYQm6qNCZ01EP7OokKVHh8HDygVh35IPPLw6b2Ma5JEtBro3ld9a3H3iVy5FhkXlI4dBL8FCrzuSadX5WNK1n514gpSYjOAl/jci73gKR8gv7ooxwB8BzTXXRQREQZVfr9XOg93i6DCSXztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1Bc81Rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A22DC4CEF5;
	Tue, 23 Sep 2025 21:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758664159;
	bh=ChC2KyA/fTMtoZzgrq/SqK8d2afgq+qtJhPKhNHFHPA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=i1Bc81Rr06gPzhN9y4o/1NNIbA4355xnTa+x2feID+WbvCJV5t+HYgXFGEhzixl3v
	 yp/sHNmIe6mSqhzzHqa9kdsoy0OPi6/edqmt35fhONGsdMXHkghBPvaHGVUFZO2Zdv
	 MO+QS3608yxxGVXu8qR6+OHqmFWBv33WobLvAGgVLU4Zwf8H9llyRo4k7Z4WivscNu
	 QXD5g1RDWOwbacPRheJz1xPMTDKuWlbRepOzajhRdDeLuZQRPeo0gk50/8mL3tBLdo
	 E4pHovwkn7hDKGaQL/x2IbhiROiuJouCcOcgM4sJ9Vd8zSCFpvcuKTR1yS1QQIWz61
	 0Gw7R8gp74nBA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 23:49:12 +0200
Message-Id: <DD0IEU4DSZVI.32SU7U5B4AOGE@kernel.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed"
 <yosry.ahmed@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>, "Chengming Zhou"
 <chengming.zhou@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "David Hildenbrand" <david@redhat.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Minchan Kim" <minchan@kernel.org>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] rust: zpool: add abstraction for zpool drivers
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250923102547.2545992-1-vitaly.wool@konsulko.se>
 <20250923102702.2552392-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250923102702.2552392-1-vitaly.wool@konsulko.se>

On Tue Sep 23, 2025 at 12:27 PM CEST, Vitaly Wool wrote:
> diff --git a/rust/kernel/zpool.rs b/rust/kernel/zpool.rs
> new file mode 100644
> index 000000000000..53a0dc0607e6
> --- /dev/null
> +++ b/rust/kernel/zpool.rs
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of Rust interface towards zpool API.
> +
> +use crate::{error::Result, kernel::alloc::Flags, str::CString, types::Fo=
reignOwnable};
> +use core::ptr::NonNull;
> +use kernel::alloc::NumaNode;
> +
> +/// The Rust representation of zpool handle.

Would be great to explain what this means, what's the handle used for?

> +pub struct ZpoolHandle(usize);
> +
> +impl ZpoolHandle {
> +    /// Create `ZpoolHandle` from the raw representation.
> +    pub fn from_raw(h: usize) -> Self {
> +        Self(h)
> +    }
> +
> +    /// Get the raw representation of the handle.
> +    pub fn as_raw(self) -> usize {
> +        self.0
> +    }

Hmm this seems a bit weird, because now users of Zpools can manufacture
their own handles? Not sure as to how we could still allow Zpool
implementers to create these while preventing other users from doing
creating them though...

> +}
> +
> +/// Zpool API.
> +///
> +/// The [`ZpoolDriver`] trait serves as an interface for Zpool drivers i=
mplemented in Rust.
> +/// Such drivers implement memory storage pools in accordance with the z=
pool API.
> +///
> +/// # Example
> +///
> +/// A zpool driver implementation which uses KVec of 2**n sizes, n =3D 6=
, 7, ..., PAGE_SHIFT.
> +/// Every zpool object is packed into a KVec that is sufficiently large,=
 and n (the
> +/// denominator) is saved in the least significant bits of the handle, w=
hich is guaranteed
> +/// to be at least 2**6 aligned by kmalloc.
> +///
> +/// ```
> +/// use core::ptr::{NonNull, copy_nonoverlapping};
> +/// use core::sync::atomic::{AtomicU64, Ordering};
> +/// use kernel::alloc::{Flags, flags, KBox, KVec, NumaNode};
> +/// use kernel::page::PAGE_SHIFT;
> +/// use kernel::prelude::EINVAL;
> +/// use kernel::str::CString;
> +/// use kernel::zpool::*;
> +///
> +/// struct MyZpool {
> +///     name: CString,
> +///     bytes_used: AtomicU64,
> +/// }
> +///
> +/// struct MyZpoolDriver;
> +///
> +/// impl ZpoolDriver for MyZpoolDriver {
> +///     type Pool =3D KBox<MyZpool>;
> +///
> +///     fn create(name: CString, gfp: Flags) -> Result<KBox<MyZpool>> {
> +///         let my_pool =3D MyZpool { name, bytes_used: AtomicU64::new(0=
) };
> +///         let pool =3D KBox::new(my_pool, gfp)?;
> +///
> +///         pr_debug!("Pool {:?} created\n", pool.name);
> +///         Ok(pool)
> +///     }
> +///
> +///     fn malloc(pool: &MyZpool, size: usize, _gfp: Flags, _nid: NumaNo=
de) -> Result<ZpoolHandle> {
> +///         let pow =3D size.next_power_of_two().trailing_zeros().max(6)=
;
> +///         match pow {
> +///             0 =3D> Err(EINVAL),
> +///             m if m > PAGE_SHIFT as u32 =3D> Err(ENOSPC),
> +///             _ =3D> {
> +///                 let vec =3D KVec::<u8>::with_capacity(1 << pow, GFP_=
KERNEL)?;
> +///                 let (ptr, _len, _cap) =3D vec.into_raw_parts();
> +///
> +///                 // We assume that kmalloc-64, kmalloc-128 etc. kmem =
caches will be used for
> +///                 // our allocations, so it's actually `1 << pow` byte=
s that we have consumed.
> +///                 pool.bytes_used.fetch_add(1 << pow, Ordering::Relaxe=
d);
> +///
> +///                 // `kmalloc` guarantees that an allocation of size x=
*2^n is 2^n aligned.
> +///                 // Therefore the 6 lower bits are zeros and we can u=
se these to store `pow`.
> +///                 Ok(ZpoolHandle::from_raw(ptr as usize | (pow as usiz=
e - 6)))
> +///             }
> +///         }
> +///     }
> +///
> +///     unsafe fn free(pool: &MyZpool, handle: ZpoolHandle) {
> +///         let h =3D handle.as_raw();
> +///         let n =3D (h & 0x3F) + 6;
> +///         let uptr =3D h & !0x3F;
> +///
> +///         // SAFETY:
> +///         // - we derive `uptr` from handle by zeroing 6 lower bits wh=
ere we store the power
> +///         //   denominator for the vector capacity. As noted above, th=
e result will be exactly the
> +///         //   pointer to the area allocated by `KVec`. Thus, uptr is =
a valid pointer pointing to
> +///         //   the vector allocated by `alloc` function above.
> +///         // - 1 << n =3D=3D capacity and is coming from the first 6 b=
its of handle.
> +///         let vec =3D unsafe { KVec::<u8>::from_raw_parts(uptr as *mut=
 u8, 0, 1 << n) };
> +///         drop(vec);
> +///         pool.bytes_used.fetch_sub(1 << n, Ordering::Relaxed);
> +///     }
> +///
> +///     unsafe fn read_begin(_pool: &MyZpool, handle: ZpoolHandle) -> No=
nNull<u8> {
> +///         let uptr =3D handle.as_raw() & !0x3F;
> +///         // SAFETY:
> +///         // - we derive `uptr` from handle by zeroing 6 lower bits wh=
ere we store the power
> +///         //   denominator for the vector capacity. As noted above, th=
e result will be exactly the
> +///         //   pointer to the area allocated by `KVec`. Thus, uptr is =
a valid pointer pointing to
> +///         //   the vector allocated by `alloc` function above.
> +///         unsafe { NonNull::new_unchecked(uptr as *mut u8) }
> +///     }
> +///
> +///     unsafe fn read_end(_pool: &MyZpool, _handle: ZpoolHandle, _handl=
e_mem: NonNull<u8>) {}
> +///
> +///     unsafe fn write(_p: &MyZpool, handle: ZpoolHandle, h_mem: NonNul=
l<u8>, mem_len: usize) {
> +///         let uptr =3D handle.as_raw() & !0x3F;
> +///         // SAFETY:
> +///         // - `h_mem` is a valid non-null pointer provided by zswap.
> +///         // - `uptr` is derived from handle by zeroing 6 lower bits w=
here we store the power
> +///         //   denominator for the vector capacity. As noted above, th=
e result will be exactly the
> +///         //   pointer to the area allocated by `KVec`. Thus, uptr is =
a valid pointer pointing to
> +///         //   the vector allocated by `alloc` function above.
> +///         unsafe {
> +///             copy_nonoverlapping(h_mem.as_ptr().cast(), uptr as *mut =
c_void, mem_len)
> +///         };
> +///     }
> +///
> +///     fn total_pages(pool: &MyZpool) -> u64 {
> +///         pool.bytes_used.load(Ordering::Relaxed) >> PAGE_SHIFT
> +///     }
> +/// }
> +///
> +/// // Uncomment this for compile time registration (disabled to avoid b=
uild error when KUNIT
> +/// // tests and zsmalloc are enabled):
> +/// // kernel::DECLARE_ZPOOL!(MyZpoolDriver);
> +/// ```
> +///
> +pub trait ZpoolDriver {
> +    /// Opaque Rust representation of `struct zpool`.
> +    type Pool: ForeignOwnable;

Also what happened to my comment on v4 of this patchset?

https://lore.kernel.org/all/DCLK1YG1L5TZ.1VMGX131LII9V@kernel.org:

>> It can indeed but then the ZpoolDriver trait will have to be extended=20
>> with functions like into_raw() and from_raw(), because zpool expects=20
>> *mut c_void, so on the Adapter side it will look like
>>
>>      extern "C" fn create_(name: *const c_uchar, gfp: u32) -> *mut c_voi=
d {
>>          // SAFETY: the memory pointed to by name is guaranteed by zpool=
=20
>> to be a valid string
>>          let pool =3D unsafe { T::create(CStr::from_char_ptr(name),=20
>> Flags::from_raw(gfp)) };
>>          match pool {
>>              Err(_) =3D> null_mut(),
>>              Ok(p) =3D> T::into_raw(p).cast(),
>>          }
>>      }
>>
>> The question is, why does this make it better?
>
> No, thanks for sharing that function. Then the question becomes, do you
> really need `ForeignOwnable`? Or is `KBox` enough? Do you really want
> people to use `Arc<MyZPool>`? Because `BorrowedMut` of `Arc` is the same
> as it's `Borrowed` variant (it's read-only after all).
>
> If you can get away with just `Box` (you might want people to choose
> their allocator, which is fine IMO), then I'd do so.

I still think that if you can use `Box<Self>` the trait is going to be
much easier to understand.

> +
> +    /// Create a pool.
> +    fn create(name: CString, gfp: Flags) -> Result<Self::Pool>;
> +
> +    /// Allocate an object of `size` bytes from `pool`, with the allocat=
ion flags `gfp` and
> +    /// preferred NUMA node `nid`. If the allocation is successful, an o=
paque handle is returned.
> +    fn malloc(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        size: usize,
> +        gfp: Flags,
> +        nid: NumaNode,
> +    ) -> Result<ZpoolHandle>;
> +
> +    /// Free an object previously allocated from the `pool`, represented=
 by `handle`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `handle` must be a valid handle previously returned by `malloc=
`.
> +    /// - `handle` must not be used any more after the call to `free`.
> +    unsafe fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, h=
andle: ZpoolHandle);
> +
> +    /// Make all the necessary preparations for the caller to be able to=
 read from the object
> +    /// represented by `handle` and return a valid pointer to that objec=
t's memory to be read.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `handle` must be a valid handle previously returned by `malloc=
`.
> +    /// - `read_end` with the same `handle` must be called for each `rea=
d_begin`.
> +    unsafe fn read_begin(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: ZpoolHandle,
> +    ) -> NonNull<u8>;
> +
> +    /// Finish reading from a previously allocated `handle`. `handle_mem=
` must be the pointer
> +    /// previously returned by `read_begin`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `handle` must be a valid handle previously returned by `malloc=
`.
> +    /// - `handle_mem` must be the pointer previously returned by `read_=
begin`.
> +    unsafe fn read_end(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: ZpoolHandle,
> +        handle_mem: NonNull<u8>,
> +    );
> +
> +    /// Write to the object represented by a previously allocated `handl=
e`. `handle_mem` points
> +    /// to the memory to copy data from, and `mem_len` defines the lengt=
h of the data block to
> +    /// be copied.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `handle` must be a valid handle previously returned by `malloc=
`.
> +    /// - `handle_mem` must be a valid pointer into the allocated memory=
 aread represented by
> +    ///   `handle`.
> +    /// - `handle_mem + mem_len - 1` must not point outside the allocate=
d memory area.
> +    unsafe fn write(
> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
> +        handle: ZpoolHandle,
> +        handle_mem: NonNull<u8>,
> +        mem_len: usize,
> +    );
> +
> +    /// Get the number of pages used by the `pool`.
> +    fn total_pages(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>) -=
> u64;
> +}
> +
> +/// Provide a zpool allocator to zswap
> +#[macro_export]
> +macro_rules! DECLARE_ZPOOL {

Why all caps and not snake case?

> +    ($t: ident) =3D> {
> +        use core::ptr::null_mut;
> +        use kernel::error::from_result;
> +        use kernel::types::ForeignOwnable;

Macros shouldn't have `use` statements in a non-local area (so inside
`const` bodies and modules is fine).

> +
> +        const __LOG_PREFIX: &[u8] =3D b"zpool_rust\0";

This seems wrong. Why do you need to generate this? Shouldn't the user
still invoke `module!` or a similar macro?

> +
> +        fn handle_from_result<T, F>(f: F) -> T
> +        where
> +            T: From<usize>,
> +            F: FnOnce() -> Result<T>,
> +        {
> +            match f() {
> +                Ok(v) =3D> v,
> +                Err(e) =3D> T::from(0),
> +            }
> +        }

Why is this function inside the macro?

> +
> +        /// Create a pool.
> +        #[no_mangle]
> +        pub unsafe extern "C" fn zpool_create_pool(name: *const c_uchar)=
 -> *mut c_void {

Missing safety docs.

> +            match (|| -> Result<<$t as ZpoolDriver>::Pool> {
> +                // SAFETY: the memory pointed to by name is guaranteed b=
y `zpool` to be a valid
> +                // string.
> +                let name_r =3D unsafe { CStr::from_char_ptr(name).to_cst=
ring() }?;
> +                $t::create(name_r, flags::GFP_KERNEL)
> +            })() {
> +                Err(_) =3D> null_mut(),
> +                Ok(pool) =3D> <$t as ZpoolDriver>::Pool::into_foreign(po=
ol),
> +            }
> +        }
> +
> +        /// Destroy the pool.
> +        #[no_mangle]
> +        pub unsafe extern "C" fn zpool_destroy_pool(pool: *mut c_void) {
> +            // SAFETY: The pointer originates from an `into_foreign` cal=
l.
> +            drop(unsafe { <$t as ZpoolDriver>::Pool::from_foreign(pool) =
})
> +        }

Have you tried to use the same pattern that we use for the many
different `Registration` types in the kernel? For example take a look at
`Adapter<T>` from `rust/kernel/net/phy.rs`. That way you don't need a
macro and can make the registration a function that takes a generic `T:
ZpoolDriver`.

---
Cheers,
Benno

