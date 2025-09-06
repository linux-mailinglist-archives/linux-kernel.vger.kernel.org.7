Return-Path: <linux-kernel+bounces-804036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E278BB468FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69061B603F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533F266EE7;
	Sat,  6 Sep 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="AWa26vFq"
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A225CC58;
	Sat,  6 Sep 2025 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132657; cv=none; b=UBm9Fn3MNCQGneaDjpnCClXRIn+G79p71uSM6Qx6Dsna+VGrmuhH9H3Q+HK3kw5j+O4NLLkdgcIze7udgza5PejSoU1J5Eod4hCU8vZGL5n9qgL2dzmaIiksa6wXIc8MYAcAkdnw+bg/DU2dr1gPkEkxg+DPB+mctylAfYAkcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132657; c=relaxed/simple;
	bh=SUnT0Sba8ufubA7q4C5z0YPzDqp7Us7MfDyidz4UNHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ+U+BLCEHLPhLXWU2+k3ej8bphSER20IpoHBRDHoYGyLjmr2EKCiBn/lg201OHzOvPVRFNocmog6vQiBw5pXLPvlEZ36TYgSTvvxrCVXieFA9ERLOw359Db37EocQ4tJdyY8dErie4efuVJ85HmU9Na16UTUFm6JepuQfNNoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=AWa26vFq; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132653; x=1757391853;
	bh=xZcINkmXBUOvdKQcVaewgf4Gi9PAEbS0774pYTjRT14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AWa26vFqEiGTqtlfdpBwzaAxCUpYBqlWTyJjrD3Nl2xNksyeiAAGFNpmR0CTYWjmW
	 /s4BRlpcQ8zGwYqxmiWVmVeE20U7IaTW6ytc2nLILSJAuW9ukI9DZG3+cqub1tFKXp
	 7qWXc1sYLVQHq+7C7/NP0fjygiUZ8did1cz2YYaIjMpW5ixEZImPqiqrZDyApWnji4
	 YhUIM3B7k3oCIHzl5vJ5oJ117jhQCu1K5iqgiDUiKtT3rJmuU4jVZL+CBRlYYEtBqI
	 RtpHoyYdXFAoM2BEdiFd4SHsLxoAIDJFURd/h1twvo4+PpEzLBrxBWOiOWidnSbmAx
	 5XHg70Qwqs7tQ==
X-Pm-Submission-Id: 4cJg8W5F23z1DDLV
Date: Sat, 6 Sep 2025 04:24:09 +0000
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
Subject: Re: [PATCH 07/14] rust: sync: atomic: Add Atomic<u{32,64}>
Message-ID: <aLu3aSdLwC8dInnh@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-8-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-8-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:34PM -0700, Boqun Feng wrote:
> Add generic atomic support for basic unsigned types that have an
> `AtomicImpl` with the same size and alignment.
> 
> Unit tests are added including Atomic<i32> and Atomic<i64>.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250719030827.61357-8-boqun.feng@gmail.com/
> ---
>  rust/kernel/sync/atomic/predefine.rs | 95 ++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
> index a6e5883be7cb..d0875812f6ad 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -27,3 +27,98 @@ fn rhs_into_delta(rhs: i64) -> i64 {
>          rhs
>      }
>  }
> +
> +// SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
> +// `i32`.
> +unsafe impl super::AtomicType for u32 {
> +    type Repr = i32;
> +}
> +
> +// SAFETY: The wrapping add result of two `i32`s is a valid `u32`.
> +unsafe impl super::AtomicAdd<u32> for u32 {
> +    fn rhs_into_delta(rhs: u32) -> i32 {
> +        rhs as i32
> +    }
> +}
> +
> +// SAFETY: `u64` and `i64` has the same size and alignment, and `u64` is round-trip transmutable to
> +// `i64`.
> +unsafe impl super::AtomicType for u64 {
> +    type Repr = i64;
> +}
> +
> +// SAFETY: The wrapping add result of two `i64`s is a valid `u64`.
> +unsafe impl super::AtomicAdd<u64> for u64 {
> +    fn rhs_into_delta(rhs: u64) -> i64 {
> +        rhs as i64
> +    }
> +}
> +
> +use crate::macros::kunit_tests;
> +
> +#[kunit_tests(rust_atomics)]
> +mod tests {
> +    use super::super::*;
> +
> +    // Call $fn($val) with each $type of $val.
> +    macro_rules! for_each_type {
> +        ($val:literal in [$($type:ty),*] $fn:expr) => {
> +            $({
> +                let v: $type = $val;
> +
> +                $fn(v);
> +            })*
> +        }
> +    }
> +
> +    #[test]
> +    fn atomic_basic_tests() {
> +        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +            let x = Atomic::new(v);
> +
> +            assert_eq!(v, x.load(Relaxed));
> +        });
> +    }
> +
> +    #[test]
> +    fn atomic_xchg_tests() {
> +        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +            let x = Atomic::new(v);
> +
> +            let old = v;
> +            let new = v + 1;
> +
> +            assert_eq!(old, x.xchg(new, Full));
> +            assert_eq!(new, x.load(Relaxed));
> +        });
> +    }
> +
> +    #[test]
> +    fn atomic_cmpxchg_tests() {
> +        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +            let x = Atomic::new(v);
> +
> +            let old = v;
> +            let new = v + 1;
> +
> +            assert_eq!(Err(old), x.cmpxchg(new, new, Full));
> +            assert_eq!(old, x.load(Relaxed));
> +            assert_eq!(Ok(old), x.cmpxchg(old, new, Relaxed));
> +            assert_eq!(new, x.load(Relaxed));
> +        });
> +    }
> +
> +    #[test]
> +    fn atomic_arithmetic_tests() {
> +        for_each_type!(42 in [i32, i64, u32, u64] |v| {
> +            let x = Atomic::new(v);
> +
> +            assert_eq!(v, x.fetch_add(12, Full));
> +            assert_eq!(v + 12, x.load(Relaxed));
> +
> +            x.add(13, Relaxed);
> +
> +            assert_eq!(v + 25, x.load(Relaxed));
> +        });
> +    }
> +}
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

