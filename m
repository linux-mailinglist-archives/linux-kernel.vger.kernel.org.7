Return-Path: <linux-kernel+bounces-804037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B09B468FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24BC58893B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB14266F00;
	Sat,  6 Sep 2025 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="RR5Fpng8"
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338F4C85
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132685; cv=none; b=UIDoiaacfAs0rJkDZcVtDrMpqXpwaEdQ8OGHs0ZleHMksAth/NfCb6CqzISXVar3SJUgH22nSJ8ulwSc7Cvg8+g5Ai/D21AWPblPdafSOIaznDD5HmE6lCbgnWuknW3mEaXHNL2d+fl7J+fNqSyeRD3FID6Uv6fCYXbwjd5szJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132685; c=relaxed/simple;
	bh=1+JmRgiHFS1ezt51/fFuKvE0QIEzvTYAmM/8M+6nV18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHZYrPSxS2WNh9CD7ZOST45l7xHCrxNxoAaV3WJ7KboNgD9vow4SOX5JEz2O4koI316V2L9+LxNwRwxCKrTj4JOd9ep9ZFN9rVLSFQ9lXHGe/HoRMf0ZNSS1a363vXMA+0LLOi5K3AqMPabHzodRenD2L3b9z/286jOMPQwa5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=RR5Fpng8; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132680; x=1757391880;
	bh=3Zvijpa631V7wubkvOkhifvYtNgcD58VRn+gcruW1ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RR5Fpng8ItQbwbROaALvqQcghtUm9h28a4E0vbmXp1R5Tb8zLlK8TO2jwDhT3RLYZ
	 tuwb1o2gh+hv7VU5cfXSV3vCGl/TPClaSW+VDGatAu5M0rrSJM12xWvb8A5dAM/SZg
	 k6YBrhXdx0Qafvp8EjAIc1g2SXi8wmLBxi9pwH6vNPSbYIGM5I0Xb5ab/KQkssTopZ
	 zX+DWyXl2AdpWioM0CabI7ASJ17oeDXrIi9WtS1pHEnEtaXdLcc9vq1XKyJ99EaeYm
	 5kxHJXd3Dkh9gGE1pZ4CY1WLkaMUl3b9ua60bfb9thKPsgswONXPAC1Zg3ssMxjxoq
	 viXLwFuAqsF0g==
X-Pm-Submission-Id: 4cJg915dVdz1DF4V
Date: Sat, 6 Sep 2025 04:24:31 +0000
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
Subject: Re: [PATCH 08/14] rust: sync: atomic: Add Atomic<{usize,isize}>
Message-ID: <aLu3f8t53ei4LOLj@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-9-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-9-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:35PM -0700, Boqun Feng wrote:
> Add generic atomic support for `usize` and `isize`. Note that instead of
> mapping directly to `atomic_long_t`, the represention type
> (`AtomicType::Repr`) is selected based on CONFIG_64BIT. This reduces
> the necessity of creating `atomic_long_*` helpers, which could save
> the binary size of kernel if inline helpers are not available. To do so,
> an internal type `isize_atomic_repr` is defined, it's `i32` in 32bit
> kernel and `i64` in 64bit kernel.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-9-boqun.feng@gmail.com/
> ---
>  rust/kernel/sync/atomic/predefine.rs | 53 +++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
> index d0875812f6ad..45a17985cda4 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -2,6 +2,9 @@
>  
>  //! Pre-defined atomic types
>  
> +use crate::static_assert;
> +use core::mem::{align_of, size_of};
> +
>  // SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
>  // itself.
>  unsafe impl super::AtomicType for i32 {
> @@ -28,6 +31,35 @@ fn rhs_into_delta(rhs: i64) -> i64 {
>      }
>  }
>  
> +// Defines an internal type that always maps to the integer type which has the same size alignment
> +// as `isize` and `usize`, and `isize` and `usize` are always bi-directional transmutable to
> +// `isize_atomic_repr`, which also always implements `AtomicImpl`.
> +#[allow(non_camel_case_types)]
> +#[cfg(not(CONFIG_64BIT))]
> +type isize_atomic_repr = i32;
> +#[allow(non_camel_case_types)]
> +#[cfg(CONFIG_64BIT)]
> +type isize_atomic_repr = i64;
> +
> +// Ensure size and alignment requirements are checked.
> +static_assert!(size_of::<isize>() == size_of::<isize_atomic_repr>());
> +static_assert!(align_of::<isize>() == align_of::<isize_atomic_repr>());
> +static_assert!(size_of::<usize>() == size_of::<isize_atomic_repr>());
> +static_assert!(align_of::<usize>() == align_of::<isize_atomic_repr>());
> +
> +// SAFETY: `isize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
> +// transmutable to `isize_atomic_repr`.
> +unsafe impl super::AtomicType for isize {
> +    type Repr = isize_atomic_repr;
> +}
> +
> +// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
> +unsafe impl super::AtomicAdd<isize> for isize {
> +    fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
> +        rhs as isize_atomic_repr
> +    }
> +}
> +
>  // SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
>  // `i32`.
>  unsafe impl super::AtomicType for u32 {
> @@ -54,6 +86,19 @@ fn rhs_into_delta(rhs: u64) -> i64 {
>      }
>  }
>  
> +// SAFETY: `usize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
> +// transmutable to `isize_atomic_repr`.
> +unsafe impl super::AtomicType for usize {
> +    type Repr = isize_atomic_repr;
> +}
> +
> +// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
> +unsafe impl super::AtomicAdd<usize> for usize {
> +    fn rhs_into_delta(rhs: usize) -> isize_atomic_repr {
> +        rhs as isize_atomic_repr
> +    }
> +}
> +
>  use crate::macros::kunit_tests;
>  
>  #[kunit_tests(rust_atomics)]
> @@ -73,7 +118,7 @@ macro_rules! for_each_type {
>  
>      #[test]
>      fn atomic_basic_tests() {
> -        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
>              let x = Atomic::new(v);
>  
>              assert_eq!(v, x.load(Relaxed));
> @@ -82,7 +127,7 @@ fn atomic_basic_tests() {
>  
>      #[test]
>      fn atomic_xchg_tests() {
> -        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
>              let x = Atomic::new(v);
>  
>              let old = v;
> @@ -95,7 +140,7 @@ fn atomic_xchg_tests() {
>  
>      #[test]
>      fn atomic_cmpxchg_tests() {
> -        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
>              let x = Atomic::new(v);
>  
>              let old = v;
> @@ -110,7 +155,7 @@ fn atomic_cmpxchg_tests() {
>  
>      #[test]
>      fn atomic_arithmetic_tests() {
> -        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
>              let x = Atomic::new(v);
>  
>              assert_eq!(v, x.fetch_add(12, Full));
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

