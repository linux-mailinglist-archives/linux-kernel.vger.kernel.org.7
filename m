Return-Path: <linux-kernel+bounces-804040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2FCB46902
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7432CAA4052
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F746266EEA;
	Sat,  6 Sep 2025 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="l+3LD8jE"
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B4261594
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132748; cv=none; b=piQyfJ4nsl6/nCOLygX8gHFGZhsTQC8/YWjyeBXoiluxtqNyiRFDldqVw7MkANj2a3/Hqn6s64H++ZLrhFyX5cMvw1YmbJY2tO7JZ26nhG8n9+KyaF06OOuDpbcBw/xjvvga5J7vURpS97dYrzmByRnu2pZ0TzzKZfwGAr5wZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132748; c=relaxed/simple;
	bh=aFiHOT2N3x862LwImeQcGRwJigmPXJ5Y1d3NRFis4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJxLrxG5ILQyDnfOxcaEV3rhMLBoTuTR9JabXUO+eEMPybdpIa6aHNujFQ11/H1sb9iPbFprpAOPqiV/qd/jJOVaWNIOZIB6PEXfZmP/t/9vH+hno9MF1dSmnWJrxKjXhOd6zLABB117cWdB14aaIztnZxjmTr14Q/Yj3irO+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=l+3LD8jE; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757132744; x=1757391944;
	bh=B/IlGHXa/C4Z4Q1Cy9giG+EL76xGZc/bXMPQj4Egy/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=l+3LD8jEAy9Jzf2aEI0BOsqTN91v1FhXUBuCS2l9c6BfPCoxQtWgKibVNb6ERobq3
	 9GlIz0VSkpCJ1V/2mv4tmm8or+KjRq5MP5cdutbnj04PFNTsXwNGcJbDBPv1Rgfuy6
	 DgyJ0x9nBUNXl6j0Hbi7dOAd63rVhbeZBDJi++Ge7Ce9OiNKETTWHx0li7dZeB8PZZ
	 wj81m08tmrfxn1l9X7jqZz89JiwvkEr2ko5i6Eb/dMEWBRkNND/Jit7VgCs/H+jiCk
	 SWRLz1x2ZqBiWBHavKStM5jJ0IqTZ8wvwmpLA0f8VNwuLoCNcum1v1h1gDiHO33oj6
	 ETUPWXoZnZMWg==
X-Pm-Submission-Id: 4cJgBF68lWz1DDBs
Date: Sat, 6 Sep 2025 04:25:38 +0000
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
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH 11/14] rust: make `Arc::into_unique_or_drop` associated
 function
Message-ID: <aLu3woBof86sNuIx@archiso>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
 <20250905044141.77868-12-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-12-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:38PM -0700, Boqun Feng wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Make `Arc::into_unique_or_drop` to become a mere associated function
> instead of a method (i.e. removing the `self` receiver).
> 
> It's a general convention for Rust smart pointers to avoid having
> methods defined on them, because if the pointee type has a method of the
> same name, then it is shadowed. This is normally for avoiding semver
> breakage, which isn't an issue for kernel codebase, but it's still
> generally a good practice to follow this rule, so that `ptr.foo()` would
> always be calling a method on the pointee type.
> 
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/r/20250723233312.3304339-3-gary@kernel.org
> ---
>  rust/kernel/sync/arc.rs | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 63a66761d0c7..4ee155b43b2d 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -321,7 +321,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>      /// use kernel::sync::{Arc, UniqueArc};
>      ///
>      /// let arc = Arc::new(42, GFP_KERNEL)?;
> -    /// let unique_arc = arc.into_unique_or_drop();
> +    /// let unique_arc = Arc::into_unique_or_drop(arc);
>      ///
>      /// // The above conversion should succeed since refcount of `arc` is 1.
>      /// assert!(unique_arc.is_some());
> @@ -337,18 +337,18 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>      /// let arc = Arc::new(42, GFP_KERNEL)?;
>      /// let another = arc.clone();
>      ///
> -    /// let unique_arc = arc.into_unique_or_drop();
> +    /// let unique_arc = Arc::into_unique_or_drop(arc);
>      ///
>      /// // The above conversion should fail since refcount of `arc` is >1.
>      /// assert!(unique_arc.is_none());
>      ///
>      /// # Ok::<(), Error>(())
>      /// ```
> -    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
> +    pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
>          // We will manually manage the refcount in this method, so we disable the destructor.
> -        let me = ManuallyDrop::new(self);
> +        let this = ManuallyDrop::new(this);
>          // SAFETY: We own a refcount, so the pointer is still valid.
> -        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
> +        let refcount = unsafe { this.ptr.as_ref() }.refcount.get();
>  
>          // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
>          // return without further touching the `Arc`. If the refcount reaches zero, then there are
> @@ -365,7 +365,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
>              // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
>              // their values.
>              Some(Pin::from(UniqueArc {
> -                inner: ManuallyDrop::into_inner(me),
> +                inner: ManuallyDrop::into_inner(this),
>              }))
>          } else {
>              None
> -- 
> 2.51.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

