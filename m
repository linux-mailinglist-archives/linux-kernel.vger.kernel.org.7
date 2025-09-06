Return-Path: <linux-kernel+bounces-804032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20399B468F6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA86C7C890C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB182676E9;
	Sat,  6 Sep 2025 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="j+TA8WbM"
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF8260575
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132577; cv=none; b=p1BvJ1D/ASILSXfR2PjLbM2j9gO4ObBNS5UzsCw9TqYa0VN7L59i+Xa6dEuFMWxk4A9Yzeyq/ZZgMpUMVQvDYPZJZrtkyXCGIadAuFBVHkeWV0uuyqGK6bBbOwqAoMZJZGHfetE7OBkIrR7p77/4YcJeJCdDARZS7GmPgt1Rk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132577; c=relaxed/simple;
	bh=6eRZF/CQ0O8CeccFELaYao6+yE1EFCNWv56N43dXglc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7i3KhrhXWhkQcuaDbGz39iJ4SrWX9l07j/3DNMJzYHIX6+SIp3yrjfJimtmV1jVAd3Ohz4+xDUjNCWlqUma6TNOmJxQMszlAQw+ec+bn5UTcLxI06OO/ho8E/r6sduxRGzlKJ0E9IOxfxeoX+eEKXjW2hekMD9ltSeriNuplwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=j+TA8WbM; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132571; x=1757391771;
	bh=EFlbXVB4vdVlYg9Ly4AtR3fPfzVPHhadCX9gywfTwvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=j+TA8WbMfWQfQoZBAtkyOxINIbuQQA17N4IFvNT61ykNT/pk6SkfmpofR8csIEAr7
	 /Q5WsIwlESQ5mQ4dvOl3OVnVBPsMdaZ2rSJWtu4Qqyx46NSLroNKTFSLBAcoFVvfL/
	 wsfK7EdOFZf/Ugu3Ces6rzKUJPv1mLC3fcr2xHlN6yjTtbJH74s+CvqgrM0ivFMnln
	 UGXE3ZzA/8VXtxZ3uzVBxUE0+9RiBhJko82cxWFVYSogP62jOy3qp4i46BhIPI1r8P
	 0591aPHHF/07PuEKXYUyeOKiTJA80dvW2Ifa3+NEc9o8G0cmjKlgD+qVRDr/cWfsXA
	 VvRfLEUn9cRSA==
X-Pm-Submission-Id: 4cJg6w4fDXz2ScD6
Date: Sat, 6 Sep 2025 04:22:45 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>, stern@rowland.harvard.edu,
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 03/14] rust: sync: atomic: Add ordering annotation types
Message-ID: <aLu3Ffw5r7pWQBYl@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-4-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:30PM -0700, Boqun Feng wrote:
> Preparation for atomic primitives. Instead of a suffix like _acquire, a
> method parameter along with the corresponding generic parameter will be
> used to specify the ordering of an atomic operations. For example,
> atomic load() can be defined as:
> 
> 	impl<T: ...> Atomic<T> {
> 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
> 	}
> 
> and acquire users would do:
> 
> 	let r = x.load(Acquire);
> 
> relaxed users:
> 
> 	let r = x.load(Relaxed);
> 
> doing the following:
> 
> 	let r = x.load(Release);
> 
> will cause a compiler error.
> 
> Compared to suffixes, it's easier to tell what ordering variants an
> operation has, and it also make it easier to unify the implementation of
> all ordering variants in one method via generic. The `TYPE` associate
> const is for generic function to pick up the particular implementation
> specified by an ordering annotation.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-4-boqun.feng@gmail.com/
> ---
>  rust/kernel/sync/atomic.rs          |   2 +
>  rust/kernel/sync/atomic/ordering.rs | 104 ++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/ordering.rs
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index b9f2f4780073..2302e6d51fe2 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -18,5 +18,7 @@
>  
>  #[allow(dead_code, unreachable_pub)]
>  mod internal;
> +pub mod ordering;
>  
>  pub use internal::AtomicImpl;
> +pub use ordering::{Acquire, Full, Relaxed, Release};
> diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
> new file mode 100644
> index 000000000000..3f103aa8db99
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/ordering.rs
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory orderings.
> +//!
> +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> +//!
> +//! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
> +//!   following memory accesses, and if there is a store part, the store part has the [`Relaxed`]
> +//!   ordering.
> +//! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
> +//!   the annotated operation, and if there is a load part, the load part has the [`Relaxed`]
> +//!   ordering.
> +//! - [`Full`] means "fully-ordered", that is:
> +//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
> +//!   - It provides ordering between the annotated operation and all the following memory accesses.
> +//!   - It provides ordering between all the preceding memory accesses and all the following memory
> +//!     accesses.
> +//!   - All the orderings are the same strength as a full memory barrier (i.e. `smp_mb()`).
> +//! - [`Relaxed`] provides no ordering except the dependency orderings. Dependency orderings are
> +//!   described in "DEPENDENCY RELATIONS" in [`LKMM`]'s [`explanation`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
> +
> +/// The annotation type for relaxed memory ordering, for the description of relaxed memory
> +/// ordering, see [module-level documentation].
> +///
> +/// [module-level documentation]: crate::sync::atomic::ordering
> +pub struct Relaxed;
> +
> +/// The annotation type for acquire memory ordering, for the description of acquire memory
> +/// ordering, see [module-level documentation].
> +///
> +/// [module-level documentation]: crate::sync::atomic::ordering
> +pub struct Acquire;
> +
> +/// The annotation type for release memory ordering, for the description of release memory
> +/// ordering, see [module-level documentation].
> +///
> +/// [module-level documentation]: crate::sync::atomic::ordering
> +pub struct Release;
> +
> +/// The annotation type for fully-ordered memory ordering, for the description fully-ordered memory
> +/// ordering, see [module-level documentation].
> +///
> +/// [module-level documentation]: crate::sync::atomic::ordering
> +pub struct Full;
> +
> +/// Describes the exact memory ordering.
> +#[doc(hidden)]
> +pub enum OrderingType {
> +    /// Relaxed ordering.
> +    Relaxed,
> +    /// Acquire ordering.
> +    Acquire,
> +    /// Release ordering.
> +    Release,
> +    /// Fully-ordered.
> +    Full,
> +}
> +
> +mod internal {
> +    /// Sealed trait, can be only implemented inside atomic mod.
> +    pub trait Sealed {}
> +
> +    impl Sealed for super::Relaxed {}
> +    impl Sealed for super::Acquire {}
> +    impl Sealed for super::Release {}
> +    impl Sealed for super::Full {}
> +}
> +
> +/// The trait bound for annotating operations that support any ordering.
> +pub trait Ordering: internal::Sealed {
> +    /// Describes the exact memory ordering.
> +    const TYPE: OrderingType;
> +}
> +
> +impl Ordering for Relaxed {
> +    const TYPE: OrderingType = OrderingType::Relaxed;
> +}
> +
> +impl Ordering for Acquire {
> +    const TYPE: OrderingType = OrderingType::Acquire;
> +}
> +
> +impl Ordering for Release {
> +    const TYPE: OrderingType = OrderingType::Release;
> +}
> +
> +impl Ordering for Full {
> +    const TYPE: OrderingType = OrderingType::Full;
> +}
> +
> +/// The trait bound for operations that only support acquire or relaxed ordering.
> +pub trait AcquireOrRelaxed: Ordering {}
> +
> +impl AcquireOrRelaxed for Acquire {}
> +impl AcquireOrRelaxed for Relaxed {}
> +
> +/// The trait bound for operations that only support release or relaxed ordering.
> +pub trait ReleaseOrRelaxed: Ordering {}
> +
> +impl ReleaseOrRelaxed for Release {}
> +impl ReleaseOrRelaxed for Relaxed {}
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

