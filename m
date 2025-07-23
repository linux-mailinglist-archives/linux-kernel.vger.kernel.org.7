Return-Path: <linux-kernel+bounces-742627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118EDB0F477
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64A9AA546A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D698E2E88A7;
	Wed, 23 Jul 2025 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l977/86n"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD52080C0;
	Wed, 23 Jul 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278559; cv=none; b=T2HtC9g+HkEaK2TBWH3F4TNjmVd8fmCTeKsk2+GDpt7r2OQ7b0+EiQ9tI4oJm4GczO2pGde8YNCxk9UxcY2782Ct696MThDgRy/KeQ2eaOjnKYCxO9WycrEOrz/Mti2CV65MtmIaYDQ5U6xwV3bWWK0qe74wwGVRkfCKIWBs4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278559; c=relaxed/simple;
	bh=OvzdjItbCyMCLx58RF4mV0Oh5gTHoCmhJNFDr7AmP5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAlM795PrpiyoeOkxkTe6++g+mSekUiOBKeABhZNZywgc2zCV1i31XvGBQ0LQNr6NEd07ZKRcHCT7Ap4crZaEIO5P+IagOghA3MIRLktogtHOmmRnW3snoX6lRmybBlj/7712MwvcHjxHAaNPaVqqgGGZUwL3HkK/ykBHh9hTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l977/86n; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fad79433bbso59520196d6.0;
        Wed, 23 Jul 2025 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753278556; x=1753883356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIqy9iYast2PqfIuxiOTQFHgavtUSoq9na/FH6QVJ2w=;
        b=l977/86n/lOEZttJPxq28+AQeuYbSZNhfW7CVn7e6fbB3YTMYpWVkEj1Fz1Eh25TCn
         Z0X4Y1eY/KKX63uZH+VqNkjBVUC+qkQVG94iFp/k/o7CARHNklqoHk2u3eIiknVVP7xz
         rIQI8x0XleRqNgSO7OaDlElXK6pMo9n6tE78lyj3laszvxxsYWyv4rYQ9hrTdpKFd2En
         eZBZXGMa7ija3NOBXQAnZA43aK6c2iKaWFaoujtXxP+4LDAJEB55PfO4jz6vk06k5sPv
         GmMLqDgVsonhlXeLPRJhK7Sd4D6wrHK6AoZTPQbgDIcCSZN18YBfs8RNsslU9acuckqL
         d55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278556; x=1753883356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIqy9iYast2PqfIuxiOTQFHgavtUSoq9na/FH6QVJ2w=;
        b=LGB6KZgeiSYnrRe8fegLGUK4hD5bWA8L0m8ImN6LhFk21WxYI6RSOMDPgvQ9gBBtgv
         202i3f8/7C9dKCAzeC8j/+CioE2EGnhVAVvlPUYJlSoC5Q36lZx0CDoLmOKCCHjSK4XY
         wZIqUmhoR7QKXfcoEH7s0ELGyNoL0MF1yq9QKT3rm4tXQYtqIHK828J7EtUwM7Qf8O6K
         91Hw9LEXDWjptLs/cfveOPraZCw6L7/rWFORYSIdbhiRaI20umvM7aMRoo0cYh2W9ytK
         NqZR4G+24Va++reGZsULzs2uxlFJBefCLtPRS6DXHURRF7pJHmgVFPkAqLFfFj+KJKXy
         ENNw==
X-Forwarded-Encrypted: i=1; AJvYcCUeBxz2cltQS0UbiCT3s5Ql041PTbBlsBoZJ3HbwLiPU6jaQ+PakRv1NOgA1UfyAjc5IGSjZZu9Fn7y5zY=@vger.kernel.org, AJvYcCVKtCsvMuU5iOGN+jVJOSiITUGBRr784aSr/PkqF/KW8ACWvmwK+9gHIaGdZYTn+heDY+dss+toQULlWoJ/qGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvwRIIIR/7ICyQn8anF0lnF69fiRijhFh3yJFnAU+jbMOQYyz
	Yq1vFUvwLRAvKWnqtO0g8/rXMN1Sbn+Jr5GizfIqjsDjjsBjK57cJcZf
X-Gm-Gg: ASbGncuZwyaYvXThahZ81Yj3nXDBs79E0aazERyeijI/KLsuraxAH9cCjWLiACPN0SG
	cAB0pE1Cxg3Fjawlccp/oJ1foG4rDhEZVMYDGrQMRQ1RaiuJn8cAaREsCKZymam8q827X0mWVyb
	WeCrmfkprH/q9r3+g+5/NZqMX5WYM8a6cUyMFwUlD2vpQzSgBmweAht+MC5/oI9PKEygEKQ+42p
	DhckTNLrco7AWxE76PYH2t/Xs+bzm5Y/GEJfAc2txftqx7tdvN1LYE6ZeIqzxOehpEud6CQWQsJ
	f0gR96fDysWbP1e3MPWLYEhLTWTmcenN8HhNWvGpK0h9WjlSEu2WeNtQaI7W3TL9SIgIUrjx5hv
	doBCgHN83jV2rA7kGKJwsQ77lIGnaTdSK0uV91uH1KhuAU1RfkRNGGArI4z3KSJm3r8CnAAW++y
	Yu1TIyNuNd8gq39b6fHA7Ax1s=
X-Google-Smtp-Source: AGHT+IFCjhx1mcaWSHxWhMLvbKxO1l0JWx83g5PVc8IvLseHezQRGPIJeG49kueWw6wy22cC9//ukg==
X-Received: by 2002:a05:6214:2aa7:b0:705:2799:caa6 with SMTP id 6a1803df08f44-70700588ff3mr36261476d6.15.1753278555875;
        Wed, 23 Jul 2025 06:49:15 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070c497a9fsm432436d6.29.2025.07.23.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:49:15 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id E3AACF40066;
	Wed, 23 Jul 2025 09:49:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 23 Jul 2025 09:49:14 -0400
X-ME-Sender: <xms:WuiAaOPHOgU5xkdFC2276kUM8e40f2xxUc4VB-jN9GMtFLOUjaH14w>
    <xme:WuiAaCeka2-YjrqwunXysi7nQR88OzOHcYuLJFfKP7kZuBdOOSft1jsonD3veCUfH
    swanFBRfIvbILb_HQ>
X-ME-Received: <xmr:WuiAaEXAQncSLdzpaRDM15EWsd20jQPGbIIasm_4M_-6mCnRNLuxiYHhF-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfeuudekfeekfeeffeekvddvlefhffejheetgeeltdegffehtdekueektdegvdff
    necuffhomhgrihhnpehinhhfohhrmhgrthhiohhnrdhsrghfvghthienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgs
    pghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhitg
    gvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtth
    hopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehl
    ohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
    pdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsth
    dqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WuiAaDDpXp9u8NVQ9qphxs5Mb6w5ScCpB6IkQieOD3HsbVTnEAFr2A>
    <xmx:WuiAaP7nlAvxDTrz-bext7cmdnn07160uTlyUxEczv0mUx7yMkNy5Q>
    <xmx:WuiAaK0c7VXxvu8qaR-tnL-eBVLekHW3Pjaw59wZ8nxj4tOUJMbE6Q>
    <xmx:WuiAaDlDonjS7mDWN-5s0ogeyNgXzcuDy957eSYrg7kmMZMyhhUjVA>
    <xmx:WuiAaA7g8SSESZu8SFnTbNMEWx46ctfdo1dpJpKAvHE9ktAyc1CLPhsx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 09:49:14 -0400 (EDT)
Date: Wed, 23 Jul 2025 06:49:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: clean up LockClassKey and its docs
Message-ID: <aIDn8OFzUbVXQVTF@tardis.local>
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-2-85fa506b8ca4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-lock-class-key-cleanup-v1-2-85fa506b8ca4@google.com>

On Wed, Jul 23, 2025 at 11:49:34AM +0000, Alice Ryhl wrote:
> Several aspects of the code and documentation for this type is
> incomplete. Also several things are hidden from the docs. Thus, clean it
> up and make it easier to read the rendered html docs.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

This looks good to me. One thing below:

>  rust/kernel/sync.rs | 55 ++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 9545bedf47b67976ab8c22d8368991cf1f382e42..5019a0bc95446fe30bad02ce040a1cbbe6d9ad5b 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -26,7 +26,9 @@
>  pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
>  pub use locked_by::LockedBy;
>  
> -/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> +/// Represents a lockdep class.
> +///
> +/// Wraps the kernel's `struct lock_class_key`.
>  #[repr(transparent)]
>  #[pin_data(PinnedDrop)]
>  pub struct LockClassKey {
> @@ -34,6 +36,10 @@ pub struct LockClassKey {
>      inner: Opaque<bindings::lock_class_key>,
>  }
>  
> +// SAFETY: Unregistering a lock class key from a different thread than where it was registered is
> +// allowed.
> +unsafe impl Send for LockClassKey {}
> +
>  // SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
>  // provides its own synchronization.
>  unsafe impl Sync for LockClassKey {}
> @@ -41,28 +47,30 @@ unsafe impl Sync for LockClassKey {}
>  impl LockClassKey {
>      /// Initializes a statically allocated lock class key.
>      ///
> -    /// This is usually used indirectly through the [`static_lock_class!`] macro.
> +    /// This is usually used indirectly through the [`static_lock_class!`] macro. See its
> +    /// documentation for more information.
>      ///
>      /// # Safety
>      ///
>      /// The destructor must never run on the returned `LockClassKey`.
> -    #[doc(hidden)]
>      pub const unsafe fn new_static() -> Self {
>          LockClassKey {
>              inner: Opaque::uninit(),
>          }
>      }
>  
> -    /// Initializes a dynamically allocated lock class key. In the common case of using a
> -    /// statically allocated lock class key, the static_lock_class! macro should be used instead.
> +    /// Initializes a dynamically allocated lock class key.
> +    ///
> +    /// In the common case of using a statically allocated lock class key, the
> +    /// [`static_lock_class!`] macro should be used instead.
>      ///
>      /// # Examples
> +    ///
>      /// ```
> -    /// # use kernel::c_str;
> -    /// # use kernel::alloc::KBox;
> -    /// # use kernel::types::ForeignOwnable;
> -    /// # use kernel::sync::{LockClassKey, SpinLock};
> -    /// # use pin_init::stack_pin_init;
> +    /// use kernel::c_str;

We can probably change the use `optional_name!()` to make
core::ffi::CStr -> kernel::str::CStr more smooth.

> +    /// use kernel::types::ForeignOwnable;
> +    /// use kernel::sync::{LockClassKey, SpinLock};
> +    /// use pin_init::stack_pin_init;
>      ///
>      /// let key = KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
>      /// let key_ptr = key.into_foreign();
> @@ -80,7 +88,6 @@ impl LockClassKey {
>      /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
>      /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
>      /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
> -    ///
>      /// # Ok::<(), Error>(())
>      /// ```
>      pub fn new_dynamic() -> impl PinInit<Self> {
> @@ -90,7 +97,10 @@ pub fn new_dynamic() -> impl PinInit<Self> {
>          })
>      }
>  
> -    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> +    /// Returns a raw pointer to the inner C struct.
> +    ///
> +    /// It is up to the caller to use the raw pointer correctly.
> +    pub fn as_ptr(&self) -> *mut bindings::lock_class_key {
>          self.inner.get()
>      }
>  }
> @@ -98,14 +108,28 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>  #[pinned_drop]
>  impl PinnedDrop for LockClassKey {
>      fn drop(self: Pin<&mut Self>) {
> -        // SAFETY: self.as_ptr was registered with lockdep and self is pinned, so the address
> -        // hasn't changed. Thus, it's safe to pass to unregister.
> +        // SAFETY: `self.as_ptr()` was registered with lockdep and `self` is pinned, so the address
> +        // hasn't changed. Thus, it's safe to pass it to unregister.
>          unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
>      }
>  }
>  
>  /// Defines a new static lock class and returns a pointer to it.
> -#[doc(hidden)]
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::c_str;
> +/// use kernel::sync::{static_lock_class, Arc, SpinLock};
> +///
> +/// fn new_locked_int() -> Result<Arc<SpinLock<u32>>> {
> +///     Arc::pin_init(SpinLock::new(
> +///         42,
> +///         c_str!("new_locked_int"),

We could use `optional_name!()` here to avoid another usage of
`c_str!()`.

That said, I'm not sure whether we should replace `c_str!()` in the
example of `new_dynamic()` right now in this series, I think that
depends on two things: 1) whether this series goes into tip or rust-next
for 6.18 and 2) when we are expecting to land the replacement of
`c_str!()`.

Miguel and Tamir, any thought?

Regards,
Boqun

> +///         static_lock_class!(),
> +///     ), GFP_KERNEL)
> +/// }
> +/// ```
>  #[macro_export]
>  macro_rules! static_lock_class {
>      () => {{
> @@ -117,6 +141,7 @@ macro_rules! static_lock_class {
>          $crate::prelude::Pin::static_ref(&CLASS)
>      }};
>  }
> +pub use static_lock_class;
>  
>  /// Returns the given string, if one is provided, otherwise generates one based on the source code
>  /// location.
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

