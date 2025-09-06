Return-Path: <linux-kernel+bounces-804030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDDEB468F3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB21C84097
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F4111BF;
	Sat,  6 Sep 2025 04:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="Xr64v1aF"
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56C25CC58
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132534; cv=none; b=fC3/U9KzQcgK8CIjNKIoKjcW4XRybymefbKS9vocLoKZNMhjQAe2PYUqP6O566TtgB3Dagt3NoOs/ChkMCQrMmQXHqf9rS2S0hQuQAmyCxHCO8giOKZurycLy7zq9ADaW7e+KbXDgIWTr+Ft60d8M/obT0v06q++xkmh8mhA5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132534; c=relaxed/simple;
	bh=VF9q7/7bt27aufpi6MG9x5Kv2mEt7Dl337VJYIY3L00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQmQroq+GH7qa5LqxsdetosJ45zWDLra3uACcJDdZ6vcTd8v1c772GE3leA4wdHk5MIkwa0UYanKdNhQM8HZKbuXypCfyj+CKGocKDOQgohto5hE2z77kb0qu2PL2ir3ISIIwL+uAQN39tqgWO08CZBWUMa7Aa8ZveHePniK/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=Xr64v1aF; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132527; x=1757391727;
	bh=SOEE/kbFgxG0R86/Qa2C5GTSjGZS1f+B2yw8iOB1U0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xr64v1aFqGHVHrrEnfYogjHuiAYVwRLd7LEPJDLse5YMP4CO03MSuZnbbXBDBDvOu
	 1FBw2Cyj8EWckGI0Cgi9Oe8HdZWTe7kYhJLR1s8bd9wM/vTusO2R2K6YqZD0ThAnYb
	 I4UStLTjYlPNBwJTVTzvZF/+szUm3RvdvS857hUHfGeMZdpp0+3618fnclVO7e1Kfk
	 j7bzoz6+27u469HvdjKv9o3HyEblmQbHmjDjkCv2oYh4uW58VInPmbwl8iFbO27yIC
	 Qj5QeplpE3nwYf8OeP6jlYaCtNlSIfkRb/GtdbOC3UjjWGyu7AVB8PQZdaZ63ESOPp
	 Vha37OM2wL6hQ==
X-Pm-Submission-Id: 4cJg650Ybpz1DDLV
Date: Sat, 6 Sep 2025 04:22:01 +0000
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
Subject: Re: [PATCH 01/14] rust: Introduce atomic API helpers
Message-ID: <aLu26SHGNG_05Hdd@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-2-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:28PM -0700, Boqun Feng wrote:
> In order to support LKMM atomics in Rust, add rust_helper_* for atomic
> APIs. These helpers ensure the implementation of LKMM atomics in Rust is
> the same as in C. This could save the maintenance burden of having two
> similar atomic implementations in asm.
> 
> Originally-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-2-boqun.feng@gmail.com/
> ---
>  rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
>  rust/helpers/helpers.c                    |    1 +
>  scripts/atomic/gen-atomics.sh             |    1 +
>  scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
>  4 files changed, 1109 insertions(+)
>  create mode 100644 rust/helpers/atomic.c
>  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh
> 
> diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
> new file mode 100644
> index 000000000000..cf06b7ef9a1c
> --- /dev/null
> +++ b/rust/helpers/atomic.c
> @@ -0,0 +1,1040 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> +// DO NOT MODIFY THIS FILE DIRECTLY
> +
> +/*
> + * This file provides helpers for the various atomic functions for Rust.
> + */
> +#ifndef _RUST_ATOMIC_API_H
> +#define _RUST_ATOMIC_API_H
> +
> +#include <linux/atomic.h>
> +
> +// TODO: Remove this after INLINE_HELPERS support is added.
> +#ifndef __rust_helper
> +#define __rust_helper
> +#endif
> +
> +__rust_helper int
> +rust_helper_atomic_read(const atomic_t *v)
> +{
> +	return atomic_read(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_read_acquire(const atomic_t *v)
> +{
> +	return atomic_read_acquire(v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_set(atomic_t *v, int i)
> +{
> +	atomic_set(v, i);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_set_release(atomic_t *v, int i)
> +{
> +	atomic_set_release(v, i);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_add(int i, atomic_t *v)
> +{
> +	atomic_add(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_add_return(int i, atomic_t *v)
> +{
> +	return atomic_add_return(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_add_return_acquire(int i, atomic_t *v)
> +{
> +	return atomic_add_return_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_add_return_release(int i, atomic_t *v)
> +{
> +	return atomic_add_return_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_add_return_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_add_return_relaxed(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_add(int i, atomic_t *v)
> +{
> +	return atomic_fetch_add(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_add_acquire(int i, atomic_t *v)
> +{
> +	return atomic_fetch_add_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_add_release(int i, atomic_t *v)
> +{
> +	return atomic_fetch_add_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_add_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_fetch_add_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_sub(int i, atomic_t *v)
> +{
> +	atomic_sub(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_sub_return(int i, atomic_t *v)
> +{
> +	return atomic_sub_return(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_sub_return_acquire(int i, atomic_t *v)
> +{
> +	return atomic_sub_return_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_sub_return_release(int i, atomic_t *v)
> +{
> +	return atomic_sub_return_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_sub_return_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_sub_return_relaxed(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_sub(int i, atomic_t *v)
> +{
> +	return atomic_fetch_sub(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_sub_acquire(int i, atomic_t *v)
> +{
> +	return atomic_fetch_sub_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_sub_release(int i, atomic_t *v)
> +{
> +	return atomic_fetch_sub_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_sub_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_fetch_sub_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_inc(atomic_t *v)
> +{
> +	atomic_inc(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_inc_return(atomic_t *v)
> +{
> +	return atomic_inc_return(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_inc_return_acquire(atomic_t *v)
> +{
> +	return atomic_inc_return_acquire(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_inc_return_release(atomic_t *v)
> +{
> +	return atomic_inc_return_release(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_inc_return_relaxed(atomic_t *v)
> +{
> +	return atomic_inc_return_relaxed(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_inc(atomic_t *v)
> +{
> +	return atomic_fetch_inc(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_inc_acquire(atomic_t *v)
> +{
> +	return atomic_fetch_inc_acquire(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_inc_release(atomic_t *v)
> +{
> +	return atomic_fetch_inc_release(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_inc_relaxed(atomic_t *v)
> +{
> +	return atomic_fetch_inc_relaxed(v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_dec(atomic_t *v)
> +{
> +	atomic_dec(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_dec_return(atomic_t *v)
> +{
> +	return atomic_dec_return(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_dec_return_acquire(atomic_t *v)
> +{
> +	return atomic_dec_return_acquire(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_dec_return_release(atomic_t *v)
> +{
> +	return atomic_dec_return_release(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_dec_return_relaxed(atomic_t *v)
> +{
> +	return atomic_dec_return_relaxed(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_dec(atomic_t *v)
> +{
> +	return atomic_fetch_dec(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_dec_acquire(atomic_t *v)
> +{
> +	return atomic_fetch_dec_acquire(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_dec_release(atomic_t *v)
> +{
> +	return atomic_fetch_dec_release(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_dec_relaxed(atomic_t *v)
> +{
> +	return atomic_fetch_dec_relaxed(v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_and(int i, atomic_t *v)
> +{
> +	atomic_and(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_and(int i, atomic_t *v)
> +{
> +	return atomic_fetch_and(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_and_acquire(int i, atomic_t *v)
> +{
> +	return atomic_fetch_and_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_and_release(int i, atomic_t *v)
> +{
> +	return atomic_fetch_and_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_and_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_fetch_and_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_andnot(int i, atomic_t *v)
> +{
> +	atomic_andnot(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_andnot(int i, atomic_t *v)
> +{
> +	return atomic_fetch_andnot(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_andnot_acquire(int i, atomic_t *v)
> +{
> +	return atomic_fetch_andnot_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_andnot_release(int i, atomic_t *v)
> +{
> +	return atomic_fetch_andnot_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_fetch_andnot_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_or(int i, atomic_t *v)
> +{
> +	atomic_or(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_or(int i, atomic_t *v)
> +{
> +	return atomic_fetch_or(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_or_acquire(int i, atomic_t *v)
> +{
> +	return atomic_fetch_or_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_or_release(int i, atomic_t *v)
> +{
> +	return atomic_fetch_or_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_or_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_fetch_or_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic_xor(int i, atomic_t *v)
> +{
> +	atomic_xor(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_xor(int i, atomic_t *v)
> +{
> +	return atomic_fetch_xor(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_xor_acquire(int i, atomic_t *v)
> +{
> +	return atomic_fetch_xor_acquire(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_xor_release(int i, atomic_t *v)
> +{
> +	return atomic_fetch_xor_release(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_xor_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_fetch_xor_relaxed(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_xchg(atomic_t *v, int new)
> +{
> +	return atomic_xchg(v, new);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_xchg_acquire(atomic_t *v, int new)
> +{
> +	return atomic_xchg_acquire(v, new);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_xchg_release(atomic_t *v, int new)
> +{
> +	return atomic_xchg_release(v, new);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_xchg_relaxed(atomic_t *v, int new)
> +{
> +	return atomic_xchg_relaxed(v, new);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_cmpxchg(atomic_t *v, int old, int new)
> +{
> +	return atomic_cmpxchg(v, old, new);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
> +{
> +	return atomic_cmpxchg_acquire(v, old, new);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_cmpxchg_release(atomic_t *v, int old, int new)
> +{
> +	return atomic_cmpxchg_release(v, old, new);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
> +{
> +	return atomic_cmpxchg_relaxed(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
> +{
> +	return atomic_try_cmpxchg(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
> +{
> +	return atomic_try_cmpxchg_acquire(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
> +{
> +	return atomic_try_cmpxchg_release(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
> +{
> +	return atomic_try_cmpxchg_relaxed(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_sub_and_test(int i, atomic_t *v)
> +{
> +	return atomic_sub_and_test(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_dec_and_test(atomic_t *v)
> +{
> +	return atomic_dec_and_test(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_inc_and_test(atomic_t *v)
> +{
> +	return atomic_inc_and_test(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_add_negative(int i, atomic_t *v)
> +{
> +	return atomic_add_negative(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_add_negative_acquire(int i, atomic_t *v)
> +{
> +	return atomic_add_negative_acquire(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_add_negative_release(int i, atomic_t *v)
> +{
> +	return atomic_add_negative_release(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_add_negative_relaxed(int i, atomic_t *v)
> +{
> +	return atomic_add_negative_relaxed(i, v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_fetch_add_unless(atomic_t *v, int a, int u)
> +{
> +	return atomic_fetch_add_unless(v, a, u);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_add_unless(atomic_t *v, int a, int u)
> +{
> +	return atomic_add_unless(v, a, u);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_inc_not_zero(atomic_t *v)
> +{
> +	return atomic_inc_not_zero(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_inc_unless_negative(atomic_t *v)
> +{
> +	return atomic_inc_unless_negative(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic_dec_unless_positive(atomic_t *v)
> +{
> +	return atomic_dec_unless_positive(v);
> +}
> +
> +__rust_helper int
> +rust_helper_atomic_dec_if_positive(atomic_t *v)
> +{
> +	return atomic_dec_if_positive(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_read(const atomic64_t *v)
> +{
> +	return atomic64_read(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_read_acquire(const atomic64_t *v)
> +{
> +	return atomic64_read_acquire(v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_set(atomic64_t *v, s64 i)
> +{
> +	atomic64_set(v, i);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_set_release(atomic64_t *v, s64 i)
> +{
> +	atomic64_set_release(v, i);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_add(s64 i, atomic64_t *v)
> +{
> +	atomic64_add(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_add_return(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_return(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_add_return_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_return_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_add_return_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_return_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_return_relaxed(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_add(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_add(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_add_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_add_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_add_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_add_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_sub(s64 i, atomic64_t *v)
> +{
> +	atomic64_sub(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_sub_return(s64 i, atomic64_t *v)
> +{
> +	return atomic64_sub_return(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_sub_return_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_sub_return_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_sub_return_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_sub_return_relaxed(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_sub(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_sub(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_sub_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_sub_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_sub_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_inc(atomic64_t *v)
> +{
> +	atomic64_inc(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_inc_return(atomic64_t *v)
> +{
> +	return atomic64_inc_return(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_inc_return_acquire(atomic64_t *v)
> +{
> +	return atomic64_inc_return_acquire(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_inc_return_release(atomic64_t *v)
> +{
> +	return atomic64_inc_return_release(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_inc_return_relaxed(atomic64_t *v)
> +{
> +	return atomic64_inc_return_relaxed(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_inc(atomic64_t *v)
> +{
> +	return atomic64_fetch_inc(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_inc_acquire(atomic64_t *v)
> +{
> +	return atomic64_fetch_inc_acquire(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_inc_release(atomic64_t *v)
> +{
> +	return atomic64_fetch_inc_release(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_inc_relaxed(atomic64_t *v)
> +{
> +	return atomic64_fetch_inc_relaxed(v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_dec(atomic64_t *v)
> +{
> +	atomic64_dec(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_dec_return(atomic64_t *v)
> +{
> +	return atomic64_dec_return(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_dec_return_acquire(atomic64_t *v)
> +{
> +	return atomic64_dec_return_acquire(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_dec_return_release(atomic64_t *v)
> +{
> +	return atomic64_dec_return_release(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_dec_return_relaxed(atomic64_t *v)
> +{
> +	return atomic64_dec_return_relaxed(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_dec(atomic64_t *v)
> +{
> +	return atomic64_fetch_dec(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_dec_acquire(atomic64_t *v)
> +{
> +	return atomic64_fetch_dec_acquire(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_dec_release(atomic64_t *v)
> +{
> +	return atomic64_fetch_dec_release(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_dec_relaxed(atomic64_t *v)
> +{
> +	return atomic64_fetch_dec_relaxed(v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_and(s64 i, atomic64_t *v)
> +{
> +	atomic64_and(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_and(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_and(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_and_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_and_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_and_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_and_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_andnot(s64 i, atomic64_t *v)
> +{
> +	atomic64_andnot(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_andnot(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_andnot(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_andnot_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_andnot_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_andnot_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_or(s64 i, atomic64_t *v)
> +{
> +	atomic64_or(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_or(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_or(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_or_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_or_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_or_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_or_relaxed(i, v);
> +}
> +
> +__rust_helper void
> +rust_helper_atomic64_xor(s64 i, atomic64_t *v)
> +{
> +	atomic64_xor(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_xor(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_xor(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_xor_acquire(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_xor_release(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_fetch_xor_relaxed(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_xchg(atomic64_t *v, s64 new)
> +{
> +	return atomic64_xchg(v, new);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_xchg_acquire(atomic64_t *v, s64 new)
> +{
> +	return atomic64_xchg_acquire(v, new);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_xchg_release(atomic64_t *v, s64 new)
> +{
> +	return atomic64_xchg_release(v, new);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
> +{
> +	return atomic64_xchg_relaxed(v, new);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
> +{
> +	return atomic64_cmpxchg(v, old, new);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
> +{
> +	return atomic64_cmpxchg_acquire(v, old, new);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
> +{
> +	return atomic64_cmpxchg_release(v, old, new);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
> +{
> +	return atomic64_cmpxchg_relaxed(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
> +{
> +	return atomic64_try_cmpxchg(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
> +{
> +	return atomic64_try_cmpxchg_acquire(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
> +{
> +	return atomic64_try_cmpxchg_release(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
> +{
> +	return atomic64_try_cmpxchg_relaxed(v, old, new);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_sub_and_test(s64 i, atomic64_t *v)
> +{
> +	return atomic64_sub_and_test(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_dec_and_test(atomic64_t *v)
> +{
> +	return atomic64_dec_and_test(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_inc_and_test(atomic64_t *v)
> +{
> +	return atomic64_inc_and_test(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_add_negative(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_negative(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_negative_acquire(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_add_negative_release(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_negative_release(i, v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
> +{
> +	return atomic64_add_negative_relaxed(i, v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
> +{
> +	return atomic64_fetch_add_unless(v, a, u);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
> +{
> +	return atomic64_add_unless(v, a, u);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_inc_not_zero(atomic64_t *v)
> +{
> +	return atomic64_inc_not_zero(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_inc_unless_negative(atomic64_t *v)
> +{
> +	return atomic64_inc_unless_negative(v);
> +}
> +
> +__rust_helper bool
> +rust_helper_atomic64_dec_unless_positive(atomic64_t *v)
> +{
> +	return atomic64_dec_unless_positive(v);
> +}
> +
> +__rust_helper s64
> +rust_helper_atomic64_dec_if_positive(atomic64_t *v)
> +{
> +	return atomic64_dec_if_positive(v);
> +}
> +
> +#endif /* _RUST_ATOMIC_API_H */
> +// 615a0e0c98b5973a47fe4fa65e92935051ca00ed
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..7053f9245759 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -7,6 +7,7 @@
>   * Sorted alphabetically.
>   */
>  
> +#include "atomic.c"
>  #include "auxiliary.c"
>  #include "blk.c"
>  #include "bug.c"
> diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
> index 5b98a8307693..02508d0d6fe4 100755
> --- a/scripts/atomic/gen-atomics.sh
> +++ b/scripts/atomic/gen-atomics.sh
> @@ -11,6 +11,7 @@ cat <<EOF |
>  gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
>  gen-atomic-long.sh              linux/atomic/atomic-long.h
>  gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
> +gen-rust-atomic-helpers.sh      ../rust/helpers/atomic.c
>  EOF
>  while read script header args; do
>  	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
> diff --git a/scripts/atomic/gen-rust-atomic-helpers.sh b/scripts/atomic/gen-rust-atomic-helpers.sh
> new file mode 100755
> index 000000000000..45b1e100ed7c
> --- /dev/null
> +++ b/scripts/atomic/gen-rust-atomic-helpers.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ATOMICDIR=$(dirname $0)
> +
> +. ${ATOMICDIR}/atomic-tbl.sh
> +
> +#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
> +gen_proto_order_variant()
> +{
> +	local meta="$1"; shift
> +	local pfx="$1"; shift
> +	local name="$1"; shift
> +	local sfx="$1"; shift
> +	local order="$1"; shift
> +	local atomic="$1"; shift
> +	local int="$1"; shift
> +
> +	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
> +
> +	local ret="$(gen_ret_type "${meta}" "${int}")"
> +	local params="$(gen_params "${int}" "${atomic}" "$@")"
> +	local args="$(gen_args "$@")"
> +	local retstmt="$(gen_ret_stmt "${meta}")"
> +
> +cat <<EOF
> +__rust_helper ${ret}
> +rust_helper_${atomicname}(${params})
> +{
> +	${retstmt}${atomicname}(${args});
> +}
> +
> +EOF
> +}
> +
> +cat << EOF
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Generated by $0
> +// DO NOT MODIFY THIS FILE DIRECTLY
> +
> +/*
> + * This file provides helpers for the various atomic functions for Rust.
> + */
> +#ifndef _RUST_ATOMIC_API_H
> +#define _RUST_ATOMIC_API_H
> +
> +#include <linux/atomic.h>
> +
> +// TODO: Remove this after INLINE_HELPERS support is added.
> +#ifndef __rust_helper
> +#define __rust_helper
> +#endif
> +
> +EOF
> +
> +grep '^[a-z]' "$1" | while read name meta args; do
> +	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
> +done
> +
> +grep '^[a-z]' "$1" | while read name meta args; do
> +	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
> +done
> +
> +cat <<EOF
> +#endif /* _RUST_ATOMIC_API_H */
> +EOF
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

