Return-Path: <linux-kernel+bounces-804038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A5B46900
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E4588BC9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA7261594;
	Sat,  6 Sep 2025 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="MewIHMS9"
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE5207DF3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132713; cv=none; b=pQ73XEdV8cetQzg7mZ70OEXvKC3k1iNZvKW033qWvTvkf0GP8vZm7KsGFysTyu/e2CdzekmtR/a1uf8KnY9jAEQS7ZVdj2Dq99ww0DjEMnci2TAF1lznX1572rbWI/9geXrIAXFmWI7o17gPSjAX94n3EfRUZO1N31ZJ3lHYwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132713; c=relaxed/simple;
	bh=m+g8BYlez7IWWawMWcATZFDSQzz6aV8RTde+Kh3uKoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL4R8VGWpDHp7uPrM9ZASk18sZMJURDn6Rt9UML9AXKmbYTHFXb3gZky4y/SNNYKH0L7gTrSM3/u3UtIEKKgx6vkJG7zdUDiIlUszfhz2ZCbeuJb/WD83soTBsGkC9s1AU4xZlq9hiNjXfwKJ5kCf5Tp0FHkEeKZgSHC5LVHYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=MewIHMS9; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132709; x=1757391909;
	bh=rNzVhKmsciCMw2LmxSTOaBTkqUon5XjsC9y0zaCRqZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MewIHMS9FrDRgEpUQ8VznZ3+qivQMx3zYW+70G0moAvevzpMTTmUgK4SZBcI4CSyp
	 bh5qFOq48xUkmBfHVGoC/rQXeoz54fVkxciDPDajWWhy5hrVM1UJeUGYRpN2CT+wqd
	 o2TC71bu25DSyUvgf+RXRHFlVpLdfUogL2HcBw5KAISQzAb/+KjODYBOHmIpQya2Hg
	 SwNqUJYroLAd8gM+VtnWY/jARg1fCY0aZT2eXCcVtZ8jICzucTaWhWOmCAvlUC7KsI
	 xaEjopb/j1Ecd476+8X6+wJQ4yAeUeJ3XYMjZBPcKr7xhi+EsJERjhnugEZmo4eZTY
	 fEb/DFZazwJdw==
X-Pm-Submission-Id: 4cJg9b2yqmz2ScWn
Date: Sat, 6 Sep 2025 04:25:04 +0000
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
Subject: Re: [PATCH 09/14] rust: sync: Add memory barriers
Message-ID: <aLu3oL1pPH8dXRfT@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-10-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-10-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:36PM -0700, Boqun Feng wrote:
> Memory barriers are building blocks for concurrent code, hence provide
> a minimal set of them.
> 
> The compiler barrier, barrier(), is implemented in inline asm instead of
> using core::sync::atomic::compiler_fence() because memory models are
> different: kernel's atomics are implemented in inline asm therefore the
> compiler barrier should be implemented in inline asm as well. Also it's
> currently only public to the kernel crate until there's a reasonable
> driver usage.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-10-boqun.feng@gmail.com/
> ---
>  rust/helpers/barrier.c      | 18 +++++++++++
>  rust/helpers/helpers.c      |  1 +
>  rust/kernel/sync.rs         |  1 +
>  rust/kernel/sync/barrier.rs | 61 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 rust/helpers/barrier.c
>  create mode 100644 rust/kernel/sync/barrier.rs
> 
> diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
> new file mode 100644
> index 000000000000..cdf28ce8e511
> --- /dev/null
> +++ b/rust/helpers/barrier.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <asm/barrier.h>
> +
> +void rust_helper_smp_mb(void)
> +{
> +	smp_mb();
> +}
> +
> +void rust_helper_smp_wmb(void)
> +{
> +	smp_wmb();
> +}
> +
> +void rust_helper_smp_rmb(void)
> +{
> +	smp_rmb();
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7053f9245759..85ad14b81925 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -9,6 +9,7 @@
>  
>  #include "atomic.c"
>  #include "auxiliary.c"
> +#include "barrier.c"
>  #include "blk.c"
>  #include "bug.c"
>  #include "build_assert.c"
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 7e962e5429d2..bf8943c88a89 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -12,6 +12,7 @@
>  mod arc;
>  pub mod aref;
>  pub mod atomic;
> +pub mod barrier;
>  pub mod completion;
>  mod condvar;
>  pub mod lock;
> diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
> new file mode 100644
> index 000000000000..8f2d435fcd94
> --- /dev/null
> +++ b/rust/kernel/sync/barrier.rs
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory barriers.
> +//!
> +//! These primitives have the same semantics as their C counterparts: and the precise definitions
> +//! of semantics can be found at [`LKMM`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +
> +/// A compiler barrier.
> +///
> +/// A barrier that prevents compiler from reordering memory accesses across the barrier.
> +#[inline(always)]
> +pub(crate) fn barrier() {
> +    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
> +    // it suffices as a compiler barrier.
> +    //
> +    // SAFETY: An empty asm block.
> +    unsafe { core::arch::asm!("") };
> +}
> +
> +/// A full memory barrier.
> +///
> +/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
> +#[inline(always)]
> +pub fn smp_mb() {
> +    if cfg!(CONFIG_SMP) {
> +        // SAFETY: `smp_mb()` is safe to call.
> +        unsafe { bindings::smp_mb() };
> +    } else {
> +        barrier();
> +    }
> +}
> +
> +/// A write-write memory barrier.
> +///
> +/// A barrier that prevents compiler and CPU from reordering memory write accesses across the
> +/// barrier.
> +#[inline(always)]
> +pub fn smp_wmb() {
> +    if cfg!(CONFIG_SMP) {
> +        // SAFETY: `smp_wmb()` is safe to call.
> +        unsafe { bindings::smp_wmb() };
> +    } else {
> +        barrier();
> +    }
> +}
> +
> +/// A read-read memory barrier.
> +///
> +/// A barrier that prevents compiler and CPU from reordering memory read accesses across the
> +/// barrier.
> +#[inline(always)]
> +pub fn smp_rmb() {
> +    if cfg!(CONFIG_SMP) {
> +        // SAFETY: `smp_rmb()` is safe to call.
> +        unsafe { bindings::smp_rmb() };
> +    } else {
> +        barrier();
> +    }
> +}
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

