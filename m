Return-Path: <linux-kernel+bounces-683313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61631AD6BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 11:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFA61BC4BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B191224244;
	Thu, 12 Jun 2025 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NlncjVE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A522248BE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719357; cv=none; b=gzti05X2Pn+C/T3podX090R5w41iSzicmSnYSHn28ldI7fWfIkXrteVtXCuhVehxLb/JJERLb89YrAQplW44Sj3DYJ9EcIeckAd/IaqkQnqqYFdEGnTf8y4TdA1yO19gT6On1kojJpUCgCmIY6gNxg8FeqJJEU2gnr/WAeJDFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719357; c=relaxed/simple;
	bh=gog6DBhmhoEtQ8knE1qGre2y0sdnMi4nf7TMIU8/Z4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9ELKFSdYDtAHCMZaKJZDGE6IrrWUXTFoK+pHsnT7mXDwDdmLR3U4LyXfMDYWlOTw+ASHyzt5q/8+oFp05vuDk6JYhj3ilPumsNAxkuC28G3lpTuVKJpZrsUdr/lMCSHLs9s5gyAceb/liS3AUlnJCTbdMRICE4ihD13nEQ7QMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NlncjVE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d5600a54so5031755e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749719354; x=1750324154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib4i4sRsAX1oUdyl6MkSm11d0n+TCYoOiqCp98LCyo8=;
        b=2NlncjVE6BWowmXXAi17iBb635OpHHhxYM63VosX41dp0UuqinMWgeyAxCjWDJbQvq
         8GuYeh9kK48IHshxLAjTOozuPp2GErAeBpvMNeo/6mX14BO8yjsQjUhdUu5ZbtzjOaWu
         6QfnHdWDLd6PFJoXxW2nt7CSLGuNIgGwC11EY+4EOjM1tRLvYicmJpCtxCmxvD3MxBA4
         DFqXrxKnBMpsJzDj+FBLv6FNx5yT4ZSZfsd7/VSZNRTcycoi83MH0HtorWoiaz1QOjFX
         pk/1nCmnt6Vj8FToszteKYDi7qQQfipX4e3IreK1BMtMvSdMa8u8u1rxPpsPXWXaVIeD
         MwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749719354; x=1750324154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ib4i4sRsAX1oUdyl6MkSm11d0n+TCYoOiqCp98LCyo8=;
        b=B4sHPaS5xYVYdcoFP1q/p0iw/J1ekGOJ7ZqonhqWL7ikbKFt4hHDfmOmJO3BSQRBsO
         307qpLNe4AZriZIgCdeAirW7OysLKbbLKH6RdzdPFdjTb0FflyuiVgtspbtmrxpzW+WQ
         35DivmLsGyBO6GvCJxt0xyOCx04FqEDQ5qlBWdwLwmPXqyc1QSuSIZB1s8qiG8QwvrxJ
         psBDBLzl01vtNfLkTnEKpe3DOK/LgoXvltSWtL96Xm4D4tA+qzeyvn9zW8UjTn7G8oJI
         xFkqAGNr85VO8+Je6dX1cyGiFDahuzyP676dtXjsnM2zM9mrtY+H0dyTwT5qkFB2a7YL
         kZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCVEf+rk1RnmloUyCL1/YRntfZSXy1Sk700lEQFXG3CsDntjtrRCjXwK21beDsP7Yc4HT2llL7AsZot0jg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuM5BbxwMWoxZD9IIzf9qU5I1qgAr8Vre+tkq/y/bIIYg3i8k6
	siU+rx18oGkBcCHeoO0R/iubKIJPtmD1gtszI7HnZQDqXhJS9GUEzRW84LB0Ctgyy23foOeJY2B
	cpiMB82p4e5RMn9HrbA==
X-Google-Smtp-Source: AGHT+IGiF45rj+Ek5+FHIkgbM6tLNkxXmHBe9Cz6I1wAeoH/JeMJfGu6iL+bfz5EVJ2hOnhbP5i9S4u4qBpsY9A=
X-Received: from wmbhe6.prod.google.com ([2002:a05:600c:5406:b0:453:f28:e99f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d87:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-453248c08e4mr62416515e9.17.1749719354324;
 Thu, 12 Jun 2025 02:09:14 -0700 (PDT)
Date: Thu, 12 Jun 2025 09:09:12 +0000
In-Reply-To: <20250611194840.877308-6-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611194840.877308-1-bqe@google.com> <20250611194840.877308-6-bqe@google.com>
Message-ID: <aEqZOOfx-tP5FYio@google.com>
Subject: Re: [PATCH v12 5/5] rust: add dynamic ID pool abstraction for bitmap
From: Alice Ryhl <aliceryhl@google.com>
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Jun 11, 2025 at 07:48:38PM +0000, Burak Emir wrote:
> This is a port of the Binder data structure introduced in commit
> 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> Rust.
> 
> Like drivers/android/dbitmap.h, the ID pool abstraction lets
> clients acquire and release IDs. The implementation uses a bitmap to
> know what IDs are in use, and gives clients fine-grained control over
> the time of allocation. This fine-grained control is needed in the
> Android Binder. We provide an example that release a spinlock for
> allocation and unit tests (rustdoc examples).
> 
> The implementation does not permit shrinking below capacity below
> BITS_PER_LONG.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Burak Emir <bqe@google.com>
> ---
>  MAINTAINERS            |   1 +
>  rust/kernel/id_pool.rs | 223 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  3 files changed, 225 insertions(+)
>  create mode 100644 rust/kernel/id_pool.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 943d85ed1876..bc95d98f266b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4134,6 +4134,7 @@ R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
>  F:	lib/find_bit_benchmark_rust.rs
>  F:	rust/kernel/bitmap.rs
> +F:	rust/kernel/id_pool.rs
>  
>  BITOPS API
>  M:	Yury Norov <yury.norov@gmail.com>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> new file mode 100644
> index 000000000000..355a8ae93268
> --- /dev/null
> +++ b/rust/kernel/id_pool.rs
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Rust API for an ID pool backed by a [`Bitmap`].
> +
> +use crate::alloc::{AllocError, Flags};
> +use crate::bitmap::Bitmap;
> +
> +/// Represents a dynamic ID pool backed by a [`Bitmap`].
> +///
> +/// Clients acquire and release IDs from unset bits in a bitmap.
> +///
> +/// The capacity of the ID pool may be adjusted by users as
> +/// needed. The API supports the scenario where users need precise control
> +/// over the time of allocation of a new backing bitmap, which may require
> +/// release of spinlock.
> +/// Due to concurrent updates, all operations are re-verified to determine
> +/// if the grow or shrink is sill valid.
> +///
> +/// # Examples
> +///
> +/// Basic usage
> +///
> +/// ```
> +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +/// use kernel::id_pool::IdPool;
> +///
> +/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
> +/// for i in 0..64 {
> +///   assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
> +/// }
> +///
> +/// pool.release_id(23);
> +/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
> +///
> +/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
> +/// let resizer = pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNEL)?;
> +/// pool.grow(resizer);
> +///
> +/// assert_eq!(pool.acquire_next_id(0), Some(64));
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// Releasing spinlock to grow the pool
> +///
> +/// ```no_run
> +/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +/// use kernel::sync::{new_spinlock, SpinLock};
> +/// use kernel::id_pool::IdPool;
> +///
> +/// fn get_id_maybe_realloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
> +///   let mut pool = guarded_pool.lock();
> +///   loop {
> +///     match pool.acquire_next_id(0) {
> +///       Some(index) => return Ok(index),
> +///       None => {
> +///         let alloc_request = pool.grow_request();
> +///         drop(pool);
> +///         let resizer = alloc_request.ok_or(AllocError)?.realloc(GFP_KERNEL)?;
> +///         pool = guarded_pool.lock();
> +///         pool.grow(resizer)
> +///       }
> +///     }
> +///   }
> +/// }
> +/// ```

These examples use two spaces for indentation, but in Rust we use four
spaces.

> +pub struct IdPool {
> +    map: Bitmap,
> +}
> +
> +/// Indicates that an [`IdPool`] should change to a new target size.
> +pub struct ReallocRequest {
> +    num_ids: usize,
> +}
> +
> +/// Contains a [`Bitmap`] of a size suitable for reallocating [`IdPool`].
> +pub struct PoolResizer {
> +    new: Bitmap,
> +}
> +
> +impl ReallocRequest {
> +    /// Allocates a new backing [`Bitmap`] for [`IdPool`].
> +    ///
> +    /// This method only prepares reallocation and does not complete it.
> +    /// Reallocation will complete after passing the [`PoolResizer`] to the
> +    /// [`IdPool::grow`] or [`IdPool::shrink`] operation, which will check
> +    /// that reallocation still makes sense.
> +    pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
> +        let new = Bitmap::new(self.num_ids, flags)?;
> +        Ok(PoolResizer { new })
> +    }
> +}
> +
> +impl IdPool {
> +    /// Constructs a new [`IdPool`].
> +    ///
> +    /// [BITS_PER_LONG]: srctree/include/asm-generic/bitsperlong.h
> +    /// A capacity below [`BITS_PER_LONG`][BITS_PER_LONG] is adjusted to
> +    /// [`BITS_PER_LONG`][BITS_PER_LONG].

I'm concerned that this might not render correctly in the html docs.
Markdown links are usually written below the text and with an empty
line:

/// A capacity below [`BITS_PER_LONG`][BITS_PER_LONG] is adjusted to
/// [`BITS_PER_LONG`][BITS_PER_LONG].
///
/// [BITS_PER_LONG]: srctree/include/asm-generic/bitsperlong.h

which can be further simplified to

/// A capacity below [`BITS_PER_LONG`] is adjusted to [`BITS_PER_LONG`].
///
/// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h

Furthermore, if you declare a public BITS_PER_LONG constant on the Rust
side like I suggested in my reply to one of the other patches, then it
will automatically link to that if you've imported it with `use` and
don't specify a link target:

use kernel::bitmap::BITS_PER_LONG;

/// A capacity below [`BITS_PER_LONG`] is adjusted to [`BITS_PER_LONG`].

Same applies to other docs that link to this constant.

> +    #[inline]
> +    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
> +        let num_ids = core::cmp::max(num_ids, bindings::BITS_PER_LONG as usize);

Nit: I like to write usize::max(...) instead of core::cmp::max(...),
which I think reads better.

> +        let map = Bitmap::new(num_ids, flags)?;
> +        Ok(Self { map })
> +    }
> +
> +    /// Returns how many IDs this pool can currently have.
> +    #[expect(clippy::len_without_is_empty)]
> +    #[inline]
> +    pub fn len(&self) -> usize {

Maybe this should be called capacity() instead? Or maybe we just don't
have this method at all.

Alice

