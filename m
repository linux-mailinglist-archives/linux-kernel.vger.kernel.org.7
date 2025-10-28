Return-Path: <linux-kernel+bounces-874532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29830C16861
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84AF1B25BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396BB34B424;
	Tue, 28 Oct 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8PVxhrf"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48433C508
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676939; cv=none; b=PgroOchHM47Jh2wZybQd31zys5EBTbvpMElrK8Ih5molic+XKVROuI06WzHPVWZyMlOx1CIstfOBuytZIui1JXY4xwVquCAxGDM2yFRvp4qniP+Dg1mal8rHCvI0UXTrlGR8luJTc8jqVccWV32tysTwNvNG/MEzr2cqVCrtU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676939; c=relaxed/simple;
	bh=tCacBRzjsKwZvRFsSMRSacQ2Z3LTZten0W9yqG+MUKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZkNL21tM3LG9mfESbMDu3S11gdWLohw5CrqXD1cAf+iLCDST3glsneljZJcDQdMFArWux5PObipkDlv5x9ahAlJVmMTrCswje67TedqYlAYWYxJ6ArnDilZhwVXed1DWud1xmnq3i8GEE63L7OzGH99GkX1IdN95pay15GrxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8PVxhrf; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-88f239686f2so608279785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761676937; x=1762281737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zI8xfo23DXKdkAZWfysLvv7Qvo46Wn0x4mNLIIsmQI=;
        b=O8PVxhrfSk41qZNnkzgjMy15UjlW/li4UMx/LAchV4tUeMGaTOQMmRAabYEPm9Yhih
         6MhZcOcfsKLKiaAxVb5i5O1nkkCcXlWga4J8iyeiMzSbTP4MKm1X0syZasSZeVauDouS
         QO/wWoUpaIqs7zKOaLLRT98zxliWg8BXKvOJs32O8NAx25IdG/yzw3+LPE4Ew2ut8okp
         IKrIfbjM8AnYZa+n1OCyNpj6S4zFu7EnehE7f+f7BktCs2ACl8bOXOfgG1956fZiL3L9
         fazbkwYYBH0PRCs0Kxxu/cJYi94GnQSxMpvcH8q2V8B/I68D78fVwAjyk4ejQsjMBuJx
         gNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676937; x=1762281737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zI8xfo23DXKdkAZWfysLvv7Qvo46Wn0x4mNLIIsmQI=;
        b=eHTMlLq7hdn1FWK0ourKTyw5KBTqfdtueza65YVNmEcKH34rLBQz63MFic5DOaU6Xo
         kNIYCE5UgiEKaR+YxqclIGWHrINa0YA/7RSazpXRrkP4g2Id7pApgb2R4wo7Zhssw6q3
         N+V6mBcpjHUEBVveaXkKFz+aU/IM72Z3jSr3yj05ytl8yqG9N/+vKPyrg6T/aqm4e+46
         UxLra8/oHOl/nnJuMhgmQjlxALnGXe8jyTWeortlQAOtStZFXZANp/2+qUUluEIvECRz
         8B/ktjjZ92CUzJuIh5758TBadxlTyb6r9l261GRoU/gWaKU5sG45NTC/oGGUbZF2dVy9
         EsWg==
X-Forwarded-Encrypted: i=1; AJvYcCWBgsF35vjnAxLMHHtltZZdTNIytFOQJZ6bGD/AUmTO0C+nLPCZf+aORg/i1NDC+Aw0U7Kg/kipVrrQf2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4hvGdE3hFZhSW1BZNRYpIebhF8lPG+fWmzc3cCxhdi9Asoos
	9OfBfYgEsMLh4RbESnZ1vxtX6RGxV6F6L7lGA4iL1HIsg8Buwv+8LmXS
X-Gm-Gg: ASbGnculXm1k6ywreRO3tydbE39W9FtDwzSAOGajiwKMb2FQ/M8ObjKnkgjyexUni8H
	jr+ICUQPQLpcMlWdk4GtlXMxlj++5BROV1jwdPWFnG5SoGcm0r7yJIQ2TsYOS9APuXw3F6SGXdC
	CBA/fTZcvYKDUpqFKLHZqc6qPHdabL2r3tjdy76BFrbtb0ge9Yybp5Ak10nHLIOKAc5BkVKeB/d
	aN0P3IyDOUsgjCh+7ykSnftSv7xgWvTPBgLwGCXPwa9cub2DvNHS15I4jTS/vC7TemJxfUy7Yxw
	eNMlMuPRDvTqVwZ7sBeT6vXmQXWRjssEWXcDcdAzyFMXdPutKLxdEuQcNVGx+WGH5eeF1lkMTSq
	Mi75eOifSQfBz9E2a+FnS1f65h0sZXOXqwKlc1G/zegbtGxpILYDKA1L1fTSK6qZZbnPmJwud
X-Google-Smtp-Source: AGHT+IEg7Mq735wL5t+CMOqtpgy8vO9otE7lMN+JW91xqffpJH8NVRJuKTKpDMxIJrV87mte4Pl4AQ==
X-Received: by 2002:a05:620a:3723:b0:89e:e5d9:f434 with SMTP id af79cd13be357-8a8e4e010d3mr61187485a.51.1761676936668;
        Tue, 28 Oct 2025 11:42:16 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fe594sm873446885a.16.2025.10.28.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:42:15 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:42:13 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] rust: id_pool: do not immediately acquire new ids
Message-ID: <aQEOhS8VVrAgae3C@yury>
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-4-32822d4b3207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-binder-bitmap-v3-4-32822d4b3207@google.com>

On Tue, Oct 28, 2025 at 10:55:17AM +0000, Alice Ryhl wrote:
> When Rust Binder assigns a new ID, it performs various fallible
> operations before it "commits" to actually using the new ID. To support
> this pattern, change acquire_next_id() so that it does not immediately
> call set_bit(), but instead returns an object that may be used to call
> set_bit() later.
> 
> The UnusedId type holds a exclusive reference to the IdPool, so it's
> guaranteed that nobody else can call find_unused_id() while the UnusedId
> object is live.

Hi Alice,

I'm not sure about this change, but it looks like a lock wrapping
acquire_next_id().

If so, we don't protect functions with locks, we protect data
structures.

If the above is wrong, and this new UnusedId type serializes all
accesses to a bitmap (lock-like), or write-accesses (rw-lock like),
then this is still questionable.

Bitmaps are widely adopted as a lockless data structure among the
kernel. If you modify bitmaps with set_bit() and clear_bit() only,
with some precautions you are running race-proof. The kernel lacks
for atomic bit-aquire function, but you can implement it youself.

I actually proposed atomic acquire API, but it was rejected:

https://lore.kernel.org/all/20240620175703.605111-2-yury.norov@gmail.com/

You can check the above series for a number of examples.

Bitmaps are widely used because they allow to implement lockless data
access so cheap with just set_bit() and clear_bit(). There's nothing
wrong to allocate a bit and release it shortly in case of some error
just because it's really cheap.

So, with all the above said, I've nothing against this UnusedId,
but if you need it to only serialize the access to an underlying
bitmap, can you explain in more details what's wrong with the existing
pattern? If you have a performance impact in mind, can you show any
numbers?

Thanks,
Yury

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/id_pool.rs | 67 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 16 deletions(-)
> 
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index d53628a357ed84a6e00ef9dfd03a75e85a87532c..e5651162db084f5dc7c16a493aa69ee253fe4885 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -25,24 +25,24 @@
>  /// Basic usage
>  ///
>  /// ```
> -/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> -/// use kernel::id_pool::IdPool;
> +/// use kernel::alloc::AllocError;
> +/// use kernel::id_pool::{IdPool, UnusedId};
>  ///
>  /// let mut pool = IdPool::new();
>  /// let cap = pool.capacity();
>  ///
>  /// for i in 0..cap {
> -///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
> +///     assert_eq!(i, pool.find_unused_id(i).ok_or(ENOSPC)?.acquire());
>  /// }
>  ///
>  /// pool.release_id(5);
> -/// assert_eq!(5, pool.acquire_next_id(0).ok_or(ENOSPC)?);
> +/// assert_eq!(5, pool.find_unused_id(0).ok_or(ENOSPC)?.acquire());
>  ///
> -/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
> +/// assert!(pool.find_unused_id(0).is_none());  // time to realloc.
>  /// let resizer = pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNEL)?;
>  /// pool.grow(resizer);
>  ///
> -/// assert_eq!(pool.acquire_next_id(0), Some(cap));
> +/// assert_eq!(pool.find_unused_id(0).ok_or(ENOSPC)?.acquire(), cap);
>  /// # Ok::<(), Error>(())
>  /// ```
>  ///
> @@ -56,8 +56,8 @@
>  /// fn get_id_maybe_realloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
>  ///     let mut pool = guarded_pool.lock();
>  ///     loop {
> -///         match pool.acquire_next_id(0) {
> -///             Some(index) => return Ok(index),
> +///         match pool.find_unused_id(0) {
> +///             Some(index) => return Ok(index.acquire()),
>  ///             None => {
>  ///                 let alloc_request = pool.grow_request();
>  ///                 drop(pool);
> @@ -187,18 +187,17 @@ pub fn grow(&mut self, mut resizer: PoolResizer) {
>          self.map = resizer.new;
>      }
>  
> -    /// Acquires a new ID by finding and setting the next zero bit in the
> -    /// bitmap.
> +    /// Finds an unused ID in the bitmap.
>      ///
>      /// Upon success, returns its index. Otherwise, returns [`None`]
>      /// to indicate that a [`Self::grow_request`] is needed.
>      #[inline]
> -    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
> -        let next_zero_bit = self.map.next_zero_bit(offset);
> -        if let Some(nr) = next_zero_bit {
> -            self.map.set_bit(nr);
> -        }
> -        next_zero_bit
> +    #[must_use]
> +    pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
> +        Some(UnusedId {
> +            id: self.map.next_zero_bit(offset)?,
> +            pool: self,
> +        })
>      }
>  
>      /// Releases an ID.
> @@ -208,6 +207,42 @@ pub fn release_id(&mut self, id: usize) {
>      }
>  }
>  
> +/// Represents an unused id in an [`IdPool`].
> +pub struct UnusedId<'pool> {
> +    id: usize,
> +    pool: &'pool mut IdPool,
> +}
> +
> +impl<'pool> UnusedId<'pool> {
> +    /// Get the unused id as an usize.
> +    ///
> +    /// Be aware that the id has not yet been acquired in the pool. The
> +    /// [`acquire`] method must be called to prevent others from taking the id.
> +    #[inline]
> +    #[must_use]
> +    pub fn as_usize(&self) -> usize {
> +        self.id
> +    }
> +
> +    /// Get the unused id as an u32.
> +    ///
> +    /// Be aware that the id has not yet been acquired in the pool. The
> +    /// [`acquire`] method must be called to prevent others from taking the id.
> +    #[inline]
> +    #[must_use]
> +    pub fn as_u32(&self) -> u32 {
> +        // CAST: The maximum possible value in an IdPool is i32::MAX.
> +        self.id as u32
> +    }
> +
> +    /// Acquire the unused id.
> +    #[inline]
> +    pub fn acquire(self) -> usize {
> +        self.pool.map.set_bit(self.id);
> +        self.id
> +    }
> +}
> +
>  impl Default for IdPool {
>      #[inline]
>      fn default() -> Self {
> 
> -- 
> 2.51.1.838.g19442a804e-goog

