Return-Path: <linux-kernel+bounces-744800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCFB11122
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407DC17D52C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9F2116F6;
	Thu, 24 Jul 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSoH6YMw"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794A19EEC2;
	Thu, 24 Jul 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382770; cv=none; b=PyeXko5ieOaDXLnDS5VVNpqwkgVkDET1VlBqTwRlcIV6XWviO4oxwG2zURTno9EOuSfjcqljItys9DdOaJqxgTzYQ5wQDLR/aNClBBAYmWTZ/qWqIc1mRTUiIUrLu1Up6+X9EuQvqQODU23kwY7VFCg/IO9PYhPpUyZm6YH4zp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382770; c=relaxed/simple;
	bh=wH9M30MQ6Ek6D6wdrxkq2YOAtOv94V1HjI+k/NK8xrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDHwUnawy6uI/eenvyeMUwEcj2tEP+pK/kSn4xMy0drU6gin1Ca8ZwBf/9mvP1AyzVw5NyBUYfR5X/nQoUii9/tB+o9ukM0Al533or6wxO1hOF+BvcdAI5/7wNAvChcmTgwHEKTZWWRXLfLrERcltsiEf5jQbG3TW+UMSXZJTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSoH6YMw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e34493ecb4so140651085a.1;
        Thu, 24 Jul 2025 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753382767; x=1753987567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aXwiOJgvu9rzcCn1joevP1lAGaOzSWz69bswl1fKxE0=;
        b=ZSoH6YMwlMp1V9fCoOKnt9EHMnZ2PhioOfO+1pdNPeb6ySgV9eH19FCR1D6xLe8vkS
         ArrKLkxlHSUnG4uQX78jfjNoTZEHNmCXZ+XTUNJes35mOInkBUK3wnDbiqO2eq/y3/he
         NcON165WvW7RMRFPrl/oyGsatsKIOaRA064N0uAEsucY8RT2xxaGzmnKchloYFrze29l
         6NIYsEUGhS+UbJVohSsCkJG7RdfWj2WHW2zCxirfFGWfoo/X2DFNnrhqKj5e5gOMGSwh
         LKHVQa1rlyqQhkmFYET/V1KMCK+Nh2D2dphAa9xglGcjrCE95m/LvxfvNk6T9V8fosRf
         5Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382767; x=1753987567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXwiOJgvu9rzcCn1joevP1lAGaOzSWz69bswl1fKxE0=;
        b=VKC6UnPaNunVggLuZXLasEWzZQX8pDmMbDGJlLBLC65SQeJ7HPzJe8sAhOs33QHib3
         Eszzxp6EILcZi70rKEILMuMWpzNliCzZF64tlnmJfPd6gBhUxsIk6MTb2ae5VI/73bph
         SGmUhYwGF2bi1CzRWo+V3IpEPqIX1e9CfokUb9BGdEGHgeUubUG7el6LNS9ncU4tUIuM
         t+k00xOyHj4LYQNN5BIEzC4PyL2U+HgLNnS3lcpgXHSE9rLKN3foHJVAKbipHb2W2nfA
         duC+1ehgSLKSkW60QzttdteCKKEOWQkNGap7WlfiLWC0ndY5MpNNpIoX5/wLCc1ArIOZ
         WSvw==
X-Forwarded-Encrypted: i=1; AJvYcCVrMrM3LbOKP573ix492FDzkf1mWRjQLgXRomSdSNuoHoQyuBvskJr1SXj0jkSu7/z2qZHSt9p1Bf/ZNZ8=@vger.kernel.org, AJvYcCXkEjZB6zyoB8IQzbYHYoYKSLZp/kofMBOXc1zpV0VBH4tym9zuyLICrvwGLXemR5aCXWpJ7+NJB/YD8ObmqhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVBX147ga4KGaIP1HuI8RYRRqNJGUVe4p54gv6b3ot3iM+je1S
	nVjq6fOBhl0Y0Lw2je+BnpM4i+0cTFYZK0/iTtNERd42PLfDZE+CWJDx
X-Gm-Gg: ASbGncsTv7P7xnnM99o6xeN0mWVO3rQ2pKo1026U8lHC40ZrEvPFbKQiq82r988Rwah
	jYgo63B249Qu2NmN8/Gac121lL1Z3L+FiLQYoNcgH9d1/8ek1X81EC2quq6/bzEj0WEK8pE7lh1
	XWGe68Zue04b4hC73mEs1v7btuhQ6WTgOrbCR3o2JA5UHiru6pr4iW/zebXIx4X223CBruMwfQs
	vH8vD50ZmVa1TnO+r+I9yIncCDfUA8PK3U0hdcw8c0dpN0wdWy7LzpcNnhCEd/KnNf9yDxid+VT
	11NL5N8pD1wvRv5q6cTm+O6WdsWnb0n8S0Oy6+tyxMteeZMgK5rCWfAOOTimqWFajwjEVhRFbvj
	CjUmtxN3GDKUYC5cS5ZzGUiahTRkqsLOyVaVcCvdABEqN+DUyzCaLGeZUNDlQ3h4o2gGQLCOS92
	MXuTHFmAzR4BWq5PrzJSOcrz8=
X-Google-Smtp-Source: AGHT+IGkcn6WsVs6jtJHHvIKRrTqCGlTFncCosgAu/hF5HlEcl4UN50vzB5cs1Y2tKM5po6culwl1w==
X-Received: by 2002:a05:620a:5787:b0:7e3:4ad9:4885 with SMTP id af79cd13be357-7e62a193a01mr757515985a.38.1753382766896;
        Thu, 24 Jul 2025 11:46:06 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e39b85sm153339385a.78.2025.07.24.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 11:46:06 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBA66F40066;
	Thu, 24 Jul 2025 14:46:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 14:46:05 -0400
X-ME-Sender: <xms:bX-CaGHntVt2kabs5hleEZt1E-W2513nnj0IKkUinFDrfMaAH5R6Cg>
    <xme:bX-CaM1ASyxM0wkmkCAc449MgkOT54kFf0wDz-ZsVFbw6_69HaDyoU6gbevlmnxRj
    Th3r83OmJzFqhDthg>
X-ME-Received: <xmr:bX-CaPOWPSZF2rBPNtfTVK8tyPFfu3-TYjLcExLVh8-yJ_4ckA6_ccn67bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeduveegveelteejveejteduveeiudetveefkeffkedvgefhgffhgeelledukefg
    ueenucffohhmrghinhepihhnfhhorhhmrghtihhonhdrshgrfhgvthihpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhi
    tggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    hlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhg
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvug
    hupdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bX-CaEaldElD4bFckTVxcZYKATV3hHcqPY23A90CO17vGHXxCYH1Tg>
    <xmx:bX-CaFzBGXZmuYKTnouv5zf4Eeadbg1O6ZJt53wLHg0DiKUknv74qA>
    <xmx:bX-CaLMdcPJlW96zx4bqvAgjRtdSkBD9RyvDPsZxQxAip0SDNaN6Rw>
    <xmx:bX-CaMcW3fSw15NdeOL4AwKCi-xJ1Lq9C0_YkdFAh8yM7ArzVthZcw>
    <xmx:bX-CaISH9w7SJkD3k8iaIRNm3z6uNhABNAxOcfWn3_1YrmdzqVCJzG_Y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 14:46:05 -0400 (EDT)
Date: Thu, 24 Jul 2025 11:46:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: sync: clean up LockClassKey and its docs
Message-ID: <aIJ_bJ5khAivH4kH@tardis-2.local>
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-2-85fa506b8ca4@google.com>
 <aIDn8OFzUbVXQVTF@tardis.local>
 <CAJ-ks9mQJ5Ed-zd_p9aNAxACn7m-DhcacEpSCwtyixdjtG3gxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mQJ5Ed-zd_p9aNAxACn7m-DhcacEpSCwtyixdjtG3gxg@mail.gmail.com>

On Thu, Jul 24, 2025 at 02:14:59PM -0400, Tamir Duberstein wrote:
> On Wed, Jul 23, 2025 at 9:49 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Wed, Jul 23, 2025 at 11:49:34AM +0000, Alice Ryhl wrote:
> > > Several aspects of the code and documentation for this type is
> > > incomplete. Also several things are hidden from the docs. Thus, clean it
> > > up and make it easier to read the rendered html docs.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> >
> > This looks good to me. One thing below:
> >
> > >  rust/kernel/sync.rs | 55 ++++++++++++++++++++++++++++++++++++++---------------
> > >  1 file changed, 40 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > > index 9545bedf47b67976ab8c22d8368991cf1f382e42..5019a0bc95446fe30bad02ce040a1cbbe6d9ad5b 100644
> > > --- a/rust/kernel/sync.rs
> > > +++ b/rust/kernel/sync.rs
> > > @@ -26,7 +26,9 @@
> > >  pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
> > >  pub use locked_by::LockedBy;
> > >
> > > -/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> > > +/// Represents a lockdep class.
> > > +///
> > > +/// Wraps the kernel's `struct lock_class_key`.
> > >  #[repr(transparent)]
> > >  #[pin_data(PinnedDrop)]
> > >  pub struct LockClassKey {
> > > @@ -34,6 +36,10 @@ pub struct LockClassKey {
> > >      inner: Opaque<bindings::lock_class_key>,
> > >  }
> > >
> > > +// SAFETY: Unregistering a lock class key from a different thread than where it was registered is
> > > +// allowed.
> > > +unsafe impl Send for LockClassKey {}
> > > +
> > >  // SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
> > >  // provides its own synchronization.
> > >  unsafe impl Sync for LockClassKey {}
> > > @@ -41,28 +47,30 @@ unsafe impl Sync for LockClassKey {}
> > >  impl LockClassKey {
> > >      /// Initializes a statically allocated lock class key.
> > >      ///
> > > -    /// This is usually used indirectly through the [`static_lock_class!`] macro.
> > > +    /// This is usually used indirectly through the [`static_lock_class!`] macro. See its
> > > +    /// documentation for more information.
> > >      ///
> > >      /// # Safety
> > >      ///
> > >      /// The destructor must never run on the returned `LockClassKey`.
> > > -    #[doc(hidden)]
> > >      pub const unsafe fn new_static() -> Self {
> > >          LockClassKey {
> > >              inner: Opaque::uninit(),
> > >          }
> > >      }
> > >
> > > -    /// Initializes a dynamically allocated lock class key. In the common case of using a
> > > -    /// statically allocated lock class key, the static_lock_class! macro should be used instead.
> > > +    /// Initializes a dynamically allocated lock class key.
> > > +    ///
> > > +    /// In the common case of using a statically allocated lock class key, the
> > > +    /// [`static_lock_class!`] macro should be used instead.
> > >      ///
> > >      /// # Examples
> > > +    ///
> > >      /// ```
> > > -    /// # use kernel::c_str;
> > > -    /// # use kernel::alloc::KBox;
> > > -    /// # use kernel::types::ForeignOwnable;
> > > -    /// # use kernel::sync::{LockClassKey, SpinLock};
> > > -    /// # use pin_init::stack_pin_init;
> > > +    /// use kernel::c_str;
> >
> > We can probably change the use `optional_name!()` to make
> > core::ffi::CStr -> kernel::str::CStr more smooth.
> >
> > > +    /// use kernel::types::ForeignOwnable;
> > > +    /// use kernel::sync::{LockClassKey, SpinLock};
> > > +    /// use pin_init::stack_pin_init;
> > >      ///
> > >      /// let key = KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
> > >      /// let key_ptr = key.into_foreign();
> > > @@ -80,7 +88,6 @@ impl LockClassKey {
> > >      /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
> > >      /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
> > >      /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
> > > -    ///
> > >      /// # Ok::<(), Error>(())
> > >      /// ```
> > >      pub fn new_dynamic() -> impl PinInit<Self> {
> > > @@ -90,7 +97,10 @@ pub fn new_dynamic() -> impl PinInit<Self> {
> > >          })
> > >      }
> > >
> > > -    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> > > +    /// Returns a raw pointer to the inner C struct.
> > > +    ///
> > > +    /// It is up to the caller to use the raw pointer correctly.
> > > +    pub fn as_ptr(&self) -> *mut bindings::lock_class_key {
> > >          self.inner.get()
> > >      }
> > >  }
> > > @@ -98,14 +108,28 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> > >  #[pinned_drop]
> > >  impl PinnedDrop for LockClassKey {
> > >      fn drop(self: Pin<&mut Self>) {
> > > -        // SAFETY: self.as_ptr was registered with lockdep and self is pinned, so the address
> > > -        // hasn't changed. Thus, it's safe to pass to unregister.
> > > +        // SAFETY: `self.as_ptr()` was registered with lockdep and `self` is pinned, so the address
> > > +        // hasn't changed. Thus, it's safe to pass it to unregister.
> > >          unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
> > >      }
> > >  }
> > >
> > >  /// Defines a new static lock class and returns a pointer to it.
> > > -#[doc(hidden)]
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```
> > > +/// use kernel::c_str;
> > > +/// use kernel::sync::{static_lock_class, Arc, SpinLock};
> > > +///
> > > +/// fn new_locked_int() -> Result<Arc<SpinLock<u32>>> {
> > > +///     Arc::pin_init(SpinLock::new(
> > > +///         42,
> > > +///         c_str!("new_locked_int"),
> >
> > We could use `optional_name!()` here to avoid another usage of
> > `c_str!()`.
> >
> > That said, I'm not sure whether we should replace `c_str!()` in the
> > example of `new_dynamic()` right now in this series, I think that
> > depends on two things: 1) whether this series goes into tip or rust-next
> > for 6.18 and 2) when we are expecting to land the replacement of
> > `c_str!()`.
> >
> > Miguel and Tamir, any thought?
> >
> > Regards,
> > Boqun
> 
> I don't think this patch meaningfully changes the complexity of the
> cstr migration. The changes are just a few tokens.
> 

Ok, so you're fine if I or someone else take this patch as it is
(including the new user of `c_str!()`), and get it merged via the tip
tree [1] in v6.18 merge window? That means if we remove `c_str!()` in
v6.18 merge window, there would be a non-trivial merge resolution to do.

Of course, it'll be less problematic if this goes into rust tree instead
of tip.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/

Regards,
Boqun

> >
> > > +///         static_lock_class!(),
> > > +///     ), GFP_KERNEL)
> > > +/// }
> > > +/// ```
> > >  #[macro_export]
> > >  macro_rules! static_lock_class {
> > >      () => {{
> > > @@ -117,6 +141,7 @@ macro_rules! static_lock_class {
> > >          $crate::prelude::Pin::static_ref(&CLASS)
> > >      }};
> > >  }
> > > +pub use static_lock_class;
> > >
> > >  /// Returns the given string, if one is provided, otherwise generates one based on the source code
> > >  /// location.
> > >
> > > --
> > > 2.50.0.727.gbf7dc18ff4-goog
> > >

