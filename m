Return-Path: <linux-kernel+bounces-831944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C94B9DF58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9101D3AED5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D052E8DFC;
	Thu, 25 Sep 2025 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNWpu5Mv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD22D837E;
	Thu, 25 Sep 2025 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787311; cv=none; b=FpN5Iv8ydBfPnpDK8wOntuwPj1gkiS9PoKeq3T3RwHv4igDuyc/W4N5KPWh2xYu9an/9qNYcHbEB7vpnIWo64SvaGP4ZUQoR6kJtvUNJ9et75Rzt/DJV5smSiD/oZRrqzA9eBTv+3IQhIFALwA/D9yzpevfMw47bm8awX85U7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787311; c=relaxed/simple;
	bh=iAU0uiNoQj5hhOwkGdRtu/4eZ7nc3wdX4SxiskKYSOs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=DSpIJPOR19/aSe7It6AbQMASuDQl6pHytJIrQ+O+k6J5/YHX7eTyH6o0pbniYH9q8yaD6cMAlrJkuS8pqoGSsgQIaCAty/BkRfXkgJ0PaIEfYL7MCda/UzwhHsllB6OhfB2GHo9Dy1k2ekTMgHHryDc6OI3qbqva3cb04JrH6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNWpu5Mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03781C4CEF0;
	Thu, 25 Sep 2025 08:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758787311;
	bh=iAU0uiNoQj5hhOwkGdRtu/4eZ7nc3wdX4SxiskKYSOs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=cNWpu5MvVrEZCA45YXVbDt771uQbxc+xJ9ME4qLjqM9wS97gfUfzLLF+eaWWPMX+u
	 4IXDoUfN2nk98vFpzgO7M5OdZPYI9oxPLD8gckzaw7tOA9d1KhJ4dhBKcyczesRENF
	 3suREGqCnNtNB1Q8UIuwj4NYe29YF5gDytCTGpISmjqpH+2w07yDDQlIGr8mPlfUzo
	 R0++KY0dTlbwLA5PKafFNBfmSXi+e2ctDVBQ5qijyL3te1epCaoXQIAkspb1HopDYe
	 fS8AwHlWUab8BNlTqh3V9KM2aFuRLfuuUytJBb0+NSaB4Ag2xOKO3JG2W+GurTTUHK
	 5Pt6Jz668mU6Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 10:01:43 +0200
Message-Id: <DD1Q2D6DJXZQ.34HUUS27GNI2Y@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Elijah Wright" <git@elijahs.space>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
X-Mailer: aerc 0.21.0
References: <20250924193643.4001-1-git@elijahs.space>
In-Reply-To: <20250924193643.4001-1-git@elijahs.space>

On Wed Sep 24, 2025 at 9:36 PM CEST, Elijah Wright wrote:
> this patch adds a basic slab module for kmem_cache, primarily wrapping
> kmem_cache_create, kmem_cache_alloc, kmem_cache_free, and kmem_cache_dest=
roy.

IIRC, Alice had an idea for how to use our allocator API to create
idiomatic kmem_cache abstractions. So we might want to explore that too?

> Signed-off-by: Elijah Wright <git@elijahs.space>
> ---
>  rust/helpers/slab.c | 10 ++++++
>  rust/kernel/lib.rs  |  1 +
>  rust/kernel/slab.rs | 85 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 rust/kernel/slab.rs
>
> diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
> index a842bfbddcba..799de7bc1405 100644
> --- a/rust/helpers/slab.c
> +++ b/rust/helpers/slab.c
> @@ -13,3 +13,13 @@ rust_helper_kvrealloc(const void *p, size_t size, gfp_=
t flags)
>  {
>  	return kvrealloc(p, size, flags);
>  }
> +
> +struct kmem_cache * rust_helper_kmem_cache_create(const char *name, unsi=
gned int size, unsigned int align, gfp_t flags, void (*ctor)(void *))
> +{
> +	return kmem_cache_create(name, size, align, flags, NULL);
> +}
> +
> +void * rust_helper_kmem_cache_alloc(struct kmem_cache *cachep, gfp_t fla=
gs)
> +{
> +	return kmem_cache_alloc(cachep, flags);
> +}
> \ No newline at end of file
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fef97f2a5098..bd76eadbe297 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -116,6 +116,7 @@
>  pub mod security;
>  pub mod seq_file;
>  pub mod sizes;
> +pub mod slab;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/slab.rs b/rust/kernel/slab.rs
> new file mode 100644
> index 000000000000..8b418f9db7cb
> --- /dev/null
> +++ b/rust/kernel/slab.rs
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Slab bindings.
> +//!
> +//! C header: [`include/linux/slab.h`](srctree/include/linux/slab.h)
> +
> +use core::{marker::PhantomData, mem, ptr::NonNull};
> +
> +use crate::{
> +    alloc::Flags,
> +    bindings,
> +    error::{code::ENOMEM, Result},
> +    str::CStr,
> +};
> +
> +/// A wrapper for kmem_cache that allocates objects of type `T`.
> +#[repr(transparent)]
> +pub struct Slab<T> {
> +    cache: NonNull<bindings::kmem_cache>,

You need an invariant for this pointer to point at a valid
kmem_cache for values of layout `T`.

> +    _p: PhantomData<T>,
> +}
> +
> +impl<T> Slab<T> {
> +    /// Creates a cache for objects of type `T`.
> +    pub fn try_new(name: &CStr, flags: Flags) -> Result<Self> {
> +        let size =3D mem::size_of::<T>();
> +        let align =3D mem::align_of::<T>();
> +        debug_assert!(size <=3D usize::MAX);
> +        debug_assert!(align <=3D usize::MAX);

These are always true? Did you mean to use `u32::MAX`?

> +
> +        // SAFETY: `flags` is a valid impl, `name` is a valid C string, =
and
> +        // other arguments are plain values.

But you also care about them being correct for the invariant I mentioned
above.

> +        let cache =3D unsafe {
> +            bindings::kmem_cache_create(
> +                name.as_char_ptr(),
> +                size as u32,
> +                align as u32,

What do you do if they don't fit in u32? This will just produce wrong
code? I think you should return `EINVAL`. (maybe use `TryFrom` & then
convert the error)

> +                flags.as_raw(),
> +                None,
> +            )
> +        };
> +
> +        NonNull::new(cache)
> +            .map(|c| Slab {
> +                cache: c,
> +                _p: PhantomData,
> +            })
> +            .ok_or(ENOMEM)
> +    }
> +
> +    /// Allocates one object from the cache with the given gfp flags.
> +    #[inline]
> +    pub fn alloc(&self, flags: Flags) -> Result<NonNull<T>> {
> +        // SAFETY: `self.cache` is a valid pointer obtained from
> +        // `kmem_cache_create` and still alive because `self` is borrowe=
d.
> +        let ptr =3D unsafe { bindings::kmem_cache_alloc(self.cache.as_pt=
r(), flags.as_raw()) };
> +        NonNull::new(ptr.cast()).ok_or(ENOMEM)
> +    }

I don't like that this API makes the user handle `NonNull` directly...

> +
> +    /// Frees an object previously returned by `alloc()`.
> +    ///
> +    /// # Safety
> +    /// The caller must guarantee that `obj` was allocated from this cac=
he and
> +    /// is no longer accessed afterwards.
> +    #[inline]
> +    pub unsafe fn free(&self, obj: NonNull<T>) {
> +        // SAFETY: By the safety contract the pointer is valid and uniqu=
e at
> +        // this point.
> +        unsafe { bindings::kmem_cache_free(self.cache.as_ptr(), obj.cast=
().as_ptr()) };
> +    }

This similarly looks bad, we should have some kind of `KmemCacheBox` or
use the approach that Alice had in mind.

---
Cheers,
Benno

> +
> +    /// Returns the raw mutable pointer to the cache
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::kmem_cache {
> +        self.cache.as_ptr()
> +    }
> +}
> +
> +impl<T> Drop for Slab<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.cache` is valid and we are the final owner beca=
use
> +        // of ownership rules.
> +        unsafe { bindings::kmem_cache_destroy(self.cache.as_ptr()) };
> +    }
> +}


