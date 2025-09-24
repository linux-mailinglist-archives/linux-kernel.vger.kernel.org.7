Return-Path: <linux-kernel+bounces-830980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1CDB9B11B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A36F380D30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A4314B9F;
	Wed, 24 Sep 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQOt0A/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F142AA3;
	Wed, 24 Sep 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735141; cv=none; b=N0w/3DbJF8sL2zWNHQadP8vVFdaZmZbUjzkRQPT7tCUZj0TIBJnEEZFPI/GburN1BsIDBhQcVkRCuUtxoTAARJTIX0Lpy5GqvLAHqe4o51krYVRWkU44dUHL7pGpeu06LyoDXSAUIIspEFac+dtFcb7wBgLhFQDtMA8UMvS0wRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735141; c=relaxed/simple;
	bh=7neJW/+itEtF24CBCCO+KjjLR04b7QVlDQ5ms8x6mus=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X3KUoKv++FEXgLfJtRnV2e/nhAllrWqNlTIg8k6YOWOkvgFsUu3PAc8PFAiiogpZy6FPYfNNbCLYIn/LHmD3fbfFO2aqJRHaaOBBsnMF5c8Pd5RZ2gWo67IEIJY7etwUVGAghEAxz5acThyaWrDudvL0gkbSc/dkjp+ix/q+EE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQOt0A/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9902C4CEE7;
	Wed, 24 Sep 2025 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758735141;
	bh=7neJW/+itEtF24CBCCO+KjjLR04b7QVlDQ5ms8x6mus=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FQOt0A/BLP/DYLs08e7nBrJsziUvQEgsNkWBqlg0sJ/7IgWQVIAxWePXMbL/4AVWZ
	 4sTGYDJ79bYFIMz3rFnku58IxrBGETMecrNg4zr2XCessVmlSnrQIr8EEoPFlCJXCk
	 dXBq/rNWeFor0za26rOiO9zrD7Qdc7elUJvyiQI4f6gcMK36L54xIIFHqUqSD6puma
	 jbNfHj4sPw9d0X21rX3X0ql7m0Fxw+REYMTW7yj3jA4IRhZF0mYcO1SX6KyaEeJ07U
	 k2LStN+9hA99d54Bu5LdsJn56ZID5vmu7rqg36Aj/NrXvP18X3aCuruFLIgjDOysNw
	 paCkvnN2nZTLw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Sep 2025 19:32:13 +0200
Message-Id: <DD17KMJW3EK0.20WYF7WFYA7K7@kernel.org>
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
To: "Vitaly Wool" <vitaly.wool@konsulko.se>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20250923102547.2545992-1-vitaly.wool@konsulko.se>
 <20250923102702.2552392-1-vitaly.wool@konsulko.se>
 <DD0IEU4DSZVI.32SU7U5B4AOGE@kernel.org>
 <d01074e3-600c-4ceb-95b6-d10fd9c253a4@konsulko.se>
In-Reply-To: <d01074e3-600c-4ceb-95b6-d10fd9c253a4@konsulko.se>

On Wed Sep 24, 2025 at 11:23 AM CEST, Vitaly Wool wrote:
> On 9/23/25 23:49, Benno Lossin wrote:
>> On Tue Sep 23, 2025 at 12:27 PM CEST, Vitaly Wool wrote:
>>> diff --git a/rust/kernel/zpool.rs b/rust/kernel/zpool.rs
>>> new file mode 100644
>>> index 000000000000..53a0dc0607e6
>>> --- /dev/null
>>> +++ b/rust/kernel/zpool.rs
>>> @@ -0,0 +1,366 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Implementation of Rust interface towards zpool API.
>>> +
>>> +use crate::{error::Result, kernel::alloc::Flags, str::CString, types::=
ForeignOwnable};
>>> +use core::ptr::NonNull;
>>> +use kernel::alloc::NumaNode;
>>> +
>>> +/// The Rust representation of zpool handle.
>>=20
>> Would be great to explain what this means, what's the handle used for?
>
> Sorry, do you mean explaining it here or in the code?

Yeah give a short summary what this means. So something like:

    /// Zpool handle
    ///
    /// Used to represent an allocation on a [`ZPool`].

Doesn't need to be detailed.

>>> +pub struct ZpoolHandle(usize);
>>> +
>>> +impl ZpoolHandle {
>>> +    /// Create `ZpoolHandle` from the raw representation.
>>> +    pub fn from_raw(h: usize) -> Self {
>>> +        Self(h)
>>> +    }
>>> +
>>> +    /// Get the raw representation of the handle.
>>> +    pub fn as_raw(self) -> usize {
>>> +        self.0
>>> +    }
>>=20
>> Hmm this seems a bit weird, because now users of Zpools can manufacture
>> their own handles? Not sure as to how we could still allow Zpool
>> implementers to create these while preventing other users from doing
>> creating them though...
>
> This is a good question indeed. The thing is, an allocation backend=20
> (these implementing zpool api) is to provide an opaque handle which is=20
> usize, and since it has the best knowledge how to compose it, we need to=
=20
> let it do that. OTOH I am not too happy with this straightforward=20
> approach (from_raw()/as_raw()) either.
>
> Would making ZpoolHandle opaque here and defining a trait that a backend=
=20
> must implement for ZpoolHandle work better? The example backend would=20
> then do something like
>
> struct MyZpoolHandle {
>      ptr: *mut u8,
>      pow: usize,
> }
> type ZpoolHandle =3D MyZpoolHandle;
>
> trait AsRawHandle {
>      fn as_raw_handle(&self) -> usize;
> }
>
> impl AsRawHandle for ZpoolHandle {
>      fn as_raw_handle(&self) -> usize {
>          (self.ptr as usize) | self.pow
>      }
> }
>
> Would that make sense?

You don't need the trait. You can just add an associated type to
`ZpoolDriver` called `Handle` and then use that instead of this concrete
type.

Implementers of `ZpoolDriver` need to then provide their own handle &
they can ensure nobody except they are able to construct one.

Or do some other functions need access to the raw usize representation?

>>> +
>>> +/// Zpool API.
>>> +///
>>> +/// The [`ZpoolDriver`] trait serves as an interface for Zpool drivers=
 implemented in Rust.
>>> +/// Such drivers implement memory storage pools in accordance with the=
 zpool API.
>>> +///
>>> +/// # Example
>>> +///
>>> +/// A zpool driver implementation which uses KVec of 2**n sizes, n =3D=
 6, 7, ..., PAGE_SHIFT.
>>> +/// Every zpool object is packed into a KVec that is sufficiently larg=
e, and n (the
>>> +/// denominator) is saved in the least significant bits of the handle,=
 which is guaranteed
>>> +/// to be at least 2**6 aligned by kmalloc.
>>> +///
>>> +/// ```
>>> +/// use core::ptr::{NonNull, copy_nonoverlapping};
>>> +/// use core::sync::atomic::{AtomicU64, Ordering};
>>> +/// use kernel::alloc::{Flags, flags, KBox, KVec, NumaNode};
>>> +/// use kernel::page::PAGE_SHIFT;
>>> +/// use kernel::prelude::EINVAL;
>>> +/// use kernel::str::CString;
>>> +/// use kernel::zpool::*;
>>> +///
>>> +/// struct MyZpool {
>>> +///     name: CString,
>>> +///     bytes_used: AtomicU64,
>>> +/// }
>>> +///
>>> +/// struct MyZpoolDriver;
>>> +///
>>> +/// impl ZpoolDriver for MyZpoolDriver {
>>> +///     type Pool =3D KBox<MyZpool>;
>>> +///
>>> +///     fn create(name: CString, gfp: Flags) -> Result<KBox<MyZpool>> =
{
>>> +///         let my_pool =3D MyZpool { name, bytes_used: AtomicU64::new=
(0) };
>>> +///         let pool =3D KBox::new(my_pool, gfp)?;
>>> +///
>>> +///         pr_debug!("Pool {:?} created\n", pool.name);
>>> +///         Ok(pool)
>>> +///     }
>>> +///
>>> +///     fn malloc(pool: &MyZpool, size: usize, _gfp: Flags, _nid: Numa=
Node) -> Result<ZpoolHandle> {
>>> +///         let pow =3D size.next_power_of_two().trailing_zeros().max(=
6);
>>> +///         match pow {
>>> +///             0 =3D> Err(EINVAL),
>>> +///             m if m > PAGE_SHIFT as u32 =3D> Err(ENOSPC),
>>> +///             _ =3D> {
>>> +///                 let vec =3D KVec::<u8>::with_capacity(1 << pow, GF=
P_KERNEL)?;
>>> +///                 let (ptr, _len, _cap) =3D vec.into_raw_parts();
>>> +///
>>> +///                 // We assume that kmalloc-64, kmalloc-128 etc. kme=
m caches will be used for
>>> +///                 // our allocations, so it's actually `1 << pow` by=
tes that we have consumed.
>>> +///                 pool.bytes_used.fetch_add(1 << pow, Ordering::Rela=
xed);
>>> +///
>>> +///                 // `kmalloc` guarantees that an allocation of size=
 x*2^n is 2^n aligned.
>>> +///                 // Therefore the 6 lower bits are zeros and we can=
 use these to store `pow`.
>>> +///                 Ok(ZpoolHandle::from_raw(ptr as usize | (pow as us=
ize - 6)))
>>> +///             }
>>> +///         }
>>> +///     }
>>> +///
>>> +///     unsafe fn free(pool: &MyZpool, handle: ZpoolHandle) {
>>> +///         let h =3D handle.as_raw();
>>> +///         let n =3D (h & 0x3F) + 6;
>>> +///         let uptr =3D h & !0x3F;
>>> +///
>>> +///         // SAFETY:
>>> +///         // - we derive `uptr` from handle by zeroing 6 lower bits =
where we store the power
>>> +///         //   denominator for the vector capacity. As noted above, =
the result will be exactly the
>>> +///         //   pointer to the area allocated by `KVec`. Thus, uptr i=
s a valid pointer pointing to
>>> +///         //   the vector allocated by `alloc` function above.
>>> +///         // - 1 << n =3D=3D capacity and is coming from the first 6=
 bits of handle.
>>> +///         let vec =3D unsafe { KVec::<u8>::from_raw_parts(uptr as *m=
ut u8, 0, 1 << n) };
>>> +///         drop(vec);
>>> +///         pool.bytes_used.fetch_sub(1 << n, Ordering::Relaxed);
>>> +///     }
>>> +///
>>> +///     unsafe fn read_begin(_pool: &MyZpool, handle: ZpoolHandle) -> =
NonNull<u8> {
>>> +///         let uptr =3D handle.as_raw() & !0x3F;
>>> +///         // SAFETY:
>>> +///         // - we derive `uptr` from handle by zeroing 6 lower bits =
where we store the power
>>> +///         //   denominator for the vector capacity. As noted above, =
the result will be exactly the
>>> +///         //   pointer to the area allocated by `KVec`. Thus, uptr i=
s a valid pointer pointing to
>>> +///         //   the vector allocated by `alloc` function above.
>>> +///         unsafe { NonNull::new_unchecked(uptr as *mut u8) }
>>> +///     }
>>> +///
>>> +///     unsafe fn read_end(_pool: &MyZpool, _handle: ZpoolHandle, _han=
dle_mem: NonNull<u8>) {}
>>> +///
>>> +///     unsafe fn write(_p: &MyZpool, handle: ZpoolHandle, h_mem: NonN=
ull<u8>, mem_len: usize) {
>>> +///         let uptr =3D handle.as_raw() & !0x3F;
>>> +///         // SAFETY:
>>> +///         // - `h_mem` is a valid non-null pointer provided by zswap=
.
>>> +///         // - `uptr` is derived from handle by zeroing 6 lower bits=
 where we store the power
>>> +///         //   denominator for the vector capacity. As noted above, =
the result will be exactly the
>>> +///         //   pointer to the area allocated by `KVec`. Thus, uptr i=
s a valid pointer pointing to
>>> +///         //   the vector allocated by `alloc` function above.
>>> +///         unsafe {
>>> +///             copy_nonoverlapping(h_mem.as_ptr().cast(), uptr as *mu=
t c_void, mem_len)
>>> +///         };
>>> +///     }
>>> +///
>>> +///     fn total_pages(pool: &MyZpool) -> u64 {
>>> +///         pool.bytes_used.load(Ordering::Relaxed) >> PAGE_SHIFT
>>> +///     }
>>> +/// }
>>> +///
>>> +/// // Uncomment this for compile time registration (disabled to avoid=
 build error when KUNIT
>>> +/// // tests and zsmalloc are enabled):
>>> +/// // kernel::DECLARE_ZPOOL!(MyZpoolDriver);
>>> +/// ```
>>> +///
>>> +pub trait ZpoolDriver {
>>> +    /// Opaque Rust representation of `struct zpool`.
>>> +    type Pool: ForeignOwnable;
>>=20
>> Also what happened to my comment on v4 of this patchset?
>>=20
>> https://lore.kernel.org/all/DCLK1YG1L5TZ.1VMGX131LII9V@kernel.org:
>>=20
>>>> It can indeed but then the ZpoolDriver trait will have to be extended
>>>> with functions like into_raw() and from_raw(), because zpool expects
>>>> *mut c_void, so on the Adapter side it will look like
>>>>
>>>>       extern "C" fn create_(name: *const c_uchar, gfp: u32) -> *mut c_=
void {
>>>>           // SAFETY: the memory pointed to by name is guaranteed by zp=
ool
>>>> to be a valid string
>>>>           let pool =3D unsafe { T::create(CStr::from_char_ptr(name),
>>>> Flags::from_raw(gfp)) };
>>>>           match pool {
>>>>               Err(_) =3D> null_mut(),
>>>>               Ok(p) =3D> T::into_raw(p).cast(),
>>>>           }
>>>>       }
>>>>
>>>> The question is, why does this make it better?
>>>
>>> No, thanks for sharing that function. Then the question becomes, do you
>>> really need `ForeignOwnable`? Or is `KBox` enough? Do you really want
>>> people to use `Arc<MyZPool>`? Because `BorrowedMut` of `Arc` is the sam=
e
>>> as it's `Borrowed` variant (it's read-only after all).
>>>
>>> If you can get away with just `Box` (you might want people to choose
>>> their allocator, which is fine IMO), then I'd do so.
>>=20
>> I still think that if you can use `Box<Self>` the trait is going to be
>> much easier to understand.
>
> Okay, thanks, I'll work on that.

If you do need `Arc` support, then I'd keep it this way, but I don't
know if you do need it.

>>> +
>>> +    /// Create a pool.
>>> +    fn create(name: CString, gfp: Flags) -> Result<Self::Pool>;
>>> +
>>> +    /// Allocate an object of `size` bytes from `pool`, with the alloc=
ation flags `gfp` and
>>> +    /// preferred NUMA node `nid`. If the allocation is successful, an=
 opaque handle is returned.
>>> +    fn malloc(
>>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>>> +        size: usize,
>>> +        gfp: Flags,
>>> +        nid: NumaNode,
>>> +    ) -> Result<ZpoolHandle>;
>>> +
>>> +    /// Free an object previously allocated from the `pool`, represent=
ed by `handle`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - `handle` must be a valid handle previously returned by `mall=
oc`.
>>> +    /// - `handle` must not be used any more after the call to `free`.
>>> +    unsafe fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,=
 handle: ZpoolHandle);
>>> +
>>> +    /// Make all the necessary preparations for the caller to be able =
to read from the object
>>> +    /// represented by `handle` and return a valid pointer to that obj=
ect's memory to be read.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - `handle` must be a valid handle previously returned by `mall=
oc`.
>>> +    /// - `read_end` with the same `handle` must be called for each `r=
ead_begin`.
>>> +    unsafe fn read_begin(
>>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>>> +        handle: ZpoolHandle,
>>> +    ) -> NonNull<u8>;
>>> +
>>> +    /// Finish reading from a previously allocated `handle`. `handle_m=
em` must be the pointer
>>> +    /// previously returned by `read_begin`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - `handle` must be a valid handle previously returned by `mall=
oc`.
>>> +    /// - `handle_mem` must be the pointer previously returned by `rea=
d_begin`.
>>> +    unsafe fn read_end(
>>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>>> +        handle: ZpoolHandle,
>>> +        handle_mem: NonNull<u8>,
>>> +    );
>>> +
>>> +    /// Write to the object represented by a previously allocated `han=
dle`. `handle_mem` points
>>> +    /// to the memory to copy data from, and `mem_len` defines the len=
gth of the data block to
>>> +    /// be copied.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - `handle` must be a valid handle previously returned by `mall=
oc`.
>>> +    /// - `handle_mem` must be a valid pointer into the allocated memo=
ry aread represented by
>>> +    ///   `handle`.
>>> +    /// - `handle_mem + mem_len - 1` must not point outside the alloca=
ted memory area.
>>> +    unsafe fn write(
>>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>>> +        handle: ZpoolHandle,
>>> +        handle_mem: NonNull<u8>,
>>> +        mem_len: usize,
>>> +    );
>>> +
>>> +    /// Get the number of pages used by the `pool`.
>>> +    fn total_pages(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>)=
 -> u64;
>>> +}
>>> +
>>> +/// Provide a zpool allocator to zswap
>>> +#[macro_export]
>>> +macro_rules! DECLARE_ZPOOL {
>>=20
>> Why all caps and not snake case?
>
> C style, sorry :) Will fix.
>
>>> +    ($t: ident) =3D> {
>>> +        use core::ptr::null_mut;
>>> +        use kernel::error::from_result;
>>> +        use kernel::types::ForeignOwnable;
>>=20
>> Macros shouldn't have `use` statements in a non-local area (so inside
>> `const` bodies and modules is fine).
>>=20
>>> +
>>> +        const __LOG_PREFIX: &[u8] =3D b"zpool_rust\0";
>>=20
>> This seems wrong. Why do you need to generate this? Shouldn't the user
>> still invoke `module!` or a similar macro?
>
> Unfortunately not. As we have discussed at Kangrejos, the zpool=20
> implementation as a driver is on its way out [1] and there has to be=20
> more voices against that for it to be stopped. If we now are dealing=20
> with the build time API (i. e. a wrapper over zsmalloc functions) then=20
> we have to define a build time macro, be that DECLARE_ZPOOL or=20
> DeclareZpool :)

But this macro shouldn't declare the `__LOG_PREFIX` const? What if I
want to have a zpool driver in addition to having a module? Or is that
impossible to begin with?

>>> +
>>> +        fn handle_from_result<T, F>(f: F) -> T
>>> +        where
>>> +            T: From<usize>,
>>> +            F: FnOnce() -> Result<T>,
>>> +        {
>>> +            match f() {
>>> +                Ok(v) =3D> v,
>>> +                Err(e) =3D> T::from(0),
>>> +            }
>>> +        }
>>=20
>> Why is this function inside the macro?
>
> Doesn't seem to be needed elsewhere. I could put it in a separate patch=
=20
> for error.rs as a complement to from_result() but I thought no one was=20
> interested in this case.

Now that I look more closely at this function, why does it even exist?
You only have a single usage here and since this is a macro, you could
just perform the match there...

>>> +
>>> +        /// Create a pool.
>>> +        #[no_mangle]
>>> +        pub unsafe extern "C" fn zpool_create_pool(name: *const c_ucha=
r) -> *mut c_void {
>>=20
>> Missing safety docs.
>>=20
>>> +            match (|| -> Result<<$t as ZpoolDriver>::Pool> {
>>> +                // SAFETY: the memory pointed to by name is guaranteed=
 by `zpool` to be a valid
>>> +                // string.
>>> +                let name_r =3D unsafe { CStr::from_char_ptr(name).to_c=
string() }?;
>>> +                $t::create(name_r, flags::GFP_KERNEL)
>>> +            })() {
>>> +                Err(_) =3D> null_mut(),
>>> +                Ok(pool) =3D> <$t as ZpoolDriver>::Pool::into_foreign(=
pool),
>>> +            }
>>> +        }
>>> +
>>> +        /// Destroy the pool.
>>> +        #[no_mangle]
>>> +        pub unsafe extern "C" fn zpool_destroy_pool(pool: *mut c_void)=
 {
>>> +            // SAFETY: The pointer originates from an `into_foreign` c=
all.
>>> +            drop(unsafe { <$t as ZpoolDriver>::Pool::from_foreign(pool=
) })
>>> +        }
>>=20
>> Have you tried to use the same pattern that we use for the many
>> different `Registration` types in the kernel? For example take a look at
>> `Adapter<T>` from `rust/kernel/net/phy.rs`. That way you don't need a
>> macro and can make the registration a function that takes a generic `T:
>> ZpoolDriver`.
>
> That's what was in the previous version. Unfortunately it won't work any=
=20
> more for the reason described above, see also [1].

I see. But this API design is a bit weird IMO, since now you can't have
two Zpool drivers at the same time (even if only one of them is used at
runtime)? Or is that something that you wouldn't do in the first place?

I also dislike that we have to generate these `no_mangle` functions from
within a macro...

---
Cheers,
Benno

> [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/mm?h=
=3Dmm-stable&id=3D2ccd9fecd9163f168761d4398564c81554f636ef


