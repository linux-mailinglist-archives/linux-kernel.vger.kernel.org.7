Return-Path: <linux-kernel+bounces-744775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D830DB110B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B255586F81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE302ECD0A;
	Thu, 24 Jul 2025 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0rLGBNG"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15802E9728;
	Thu, 24 Jul 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380940; cv=none; b=mDKzT/eD44GnztCJ6Qr9mUk0+uClPdtuaSTsQg1zgnpRCCyS+OcyMVny61EQHLanj54W3WMH5QdE1MXH/XE+937XpuSB6hey/p4L9fI2RIsNZAVBciRi4gzq3y2aVMVWnSN8Y5cSsMcMMTG2I0AHOSnzQM3vK+0lNJW0TxYFfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380940; c=relaxed/simple;
	bh=ed2YNaYrOCo6zmuYoA2XtMW6sFsIJraaNm7yPtxfH8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X60oEoK9ohLr7yz9u1BT34B4cWR27EiTxoSW7fzBvsApbQN5HBmGR0OZQvPZgKqbbmT9a6VqTmzvcIeGyelH3KHjVBwpwZstb5Zb2uWHI4qgB3XMfF5NN32LFjnWTPZTK5s0t8cZWIMpmwrqSvIyKu3y8HViLLb3trT7PFrDfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0rLGBNG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32f2947ab0bso10487531fa.3;
        Thu, 24 Jul 2025 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753380936; x=1753985736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kh00RZW4bz0bQrExQnvNGV+vIhXj01vFWScu+jCpYQM=;
        b=c0rLGBNGnWeftmr2Z9U5rngTMOgGn8tW9+NDfSPVL4BzfCXqsOzYuKWb5Ch6MYKUkz
         nmdDe9STrCwITlJTSyruRDOYn8KwS18avwUJQba4Q3cU4bswHGm1QpB3ToNMbCoTzFhl
         USciSkjpCODNhXMLrgCvglr+ZihQ/XerAoiyHMB725rw/qz9+Z885mC32557kxvRQuAi
         I6MKVKoszWpNvKZpQtjLGBLx5dXHixaVSIwyh+A6sgwvTY/zYmZI4/OcD4cen/zoVkLi
         lGVciBgtD2GEQSlRLgTKwp7qcU0we8yADP19iIvBA/MAoUMxrnZKWIi6C2xXRHIAEaLp
         rn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753380936; x=1753985736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kh00RZW4bz0bQrExQnvNGV+vIhXj01vFWScu+jCpYQM=;
        b=gVltYRTyA0PELOeTAbTlX4b+WE61tt5gxFL1tALg2JThJ5p1wNH9MwCzMkRxw7gz4P
         fL2e/d3MXtmgmJkGkIncxqzOUl49vU5BPllgKIb8/2tPuX07Yg04y+DpoqNzu0Jlq9Sc
         lUr2lN17c7eZBwCcNCxY7xfEaRbdYCTckMcG+rcMF2HYcOuT8nfFmUMooIDt9n2P9wGa
         vFgkURD4si53HNGvCXPVRDFAi0HaFQsa3/VYoVg3lpYDXFVOK77JrbnO+Xm0T84IIGuP
         jdYwO5Rq3wx1Bwt7ge/wVwryu/G2wcXovPq2QMiXrE+LajXFLmLWh4bLfDf35GZ+6Yfx
         nlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl4ISu7ul8fDJwDkaszJq3UUE6s2DsykRfZM5OoQU/MJx3lcPV706klI3apvjqmjKRjCPCpjDPQBCNE5tT1YM=@vger.kernel.org, AJvYcCWb+zCPBjqXm73XpeXASKEps9GcnCpYG/fUw3JbwG/ENP+eS+iePxgtnPOsWCXaDxW4QRCV2jCMBrHVI0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbWJDJ2OEzJ+qOj6j7cAw9QJs+LINGFN32l9H8+4z8X6siogu
	i2vABb4Izye0caCSa8Ud4bZlvl17h/wm2WYuCuIoUdiKnMNmkP9ZSnMqbrG9UioSrVYU4QRmzxu
	l0h+CFmBApqwlbexM5UzPMv6FoX+HB5A00FnsTcw=
X-Gm-Gg: ASbGncvNjAU2CaS5Ntmu2L7auzUt058R7syAjuHsG9N0vkdVAhILKSCHavwAipCjWdx
	tsOsAeqd8YNPrQnTwxephdOftUAlNoV9Lu1IHkY9gXl8jp25qj8n4sJTCzb8xyKxK1NsKd8/CZ0
	l/woKQzXWOsoNpLCf1Rl7PZV5UyAOHaYDq0wG3Pe6+6lRj+W1fy4Hi75++QSwij0BOcYnkn02M6
	6xrj7xf
X-Google-Smtp-Source: AGHT+IGQo5ZRoXqf8/1duG3i2vvlZGxGhWUgslLWVR8nz8h0t2ZuMQ8tS3eP/eS6kOj4I3xTwLYTNZRGjtBwhwZIiYQ=
X-Received: by 2002:a2e:bc28:0:b0:32b:7ddd:279e with SMTP id
 38308e7fff4ca-330dfcf9b59mr21242851fa.14.1753380935533; Thu, 24 Jul 2025
 11:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-2-85fa506b8ca4@google.com> <aIDn8OFzUbVXQVTF@tardis.local>
In-Reply-To: <aIDn8OFzUbVXQVTF@tardis.local>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 24 Jul 2025 14:14:59 -0400
X-Gm-Features: Ac12FXzBjXoJcGsrmHKYnZUSb1oVHPLcl_B1ZDlVrMauZ900Uh8s_b53SLXMYVI
Message-ID: <CAJ-ks9mQJ5Ed-zd_p9aNAxACn7m-DhcacEpSCwtyixdjtG3gxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: clean up LockClassKey and its docs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 9:49=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Jul 23, 2025 at 11:49:34AM +0000, Alice Ryhl wrote:
> > Several aspects of the code and documentation for this type is
> > incomplete. Also several things are hidden from the docs. Thus, clean i=
t
> > up and make it easier to read the rendered html docs.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
>
> This looks good to me. One thing below:
>
> >  rust/kernel/sync.rs | 55 ++++++++++++++++++++++++++++++++++++++-------=
--------
> >  1 file changed, 40 insertions(+), 15 deletions(-)
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 9545bedf47b67976ab8c22d8368991cf1f382e42..5019a0bc95446fe30bad02c=
e040a1cbbe6d9ad5b 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -26,7 +26,9 @@
> >  pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
> >  pub use locked_by::LockedBy;
> >
> > -/// Represents a lockdep class. It's a wrapper around C's `lock_class_=
key`.
> > +/// Represents a lockdep class.
> > +///
> > +/// Wraps the kernel's `struct lock_class_key`.
> >  #[repr(transparent)]
> >  #[pin_data(PinnedDrop)]
> >  pub struct LockClassKey {
> > @@ -34,6 +36,10 @@ pub struct LockClassKey {
> >      inner: Opaque<bindings::lock_class_key>,
> >  }
> >
> > +// SAFETY: Unregistering a lock class key from a different thread than=
 where it was registered is
> > +// allowed.
> > +unsafe impl Send for LockClassKey {}
> > +
> >  // SAFETY: `bindings::lock_class_key` is designed to be used concurren=
tly from multiple threads and
> >  // provides its own synchronization.
> >  unsafe impl Sync for LockClassKey {}
> > @@ -41,28 +47,30 @@ unsafe impl Sync for LockClassKey {}
> >  impl LockClassKey {
> >      /// Initializes a statically allocated lock class key.
> >      ///
> > -    /// This is usually used indirectly through the [`static_lock_clas=
s!`] macro.
> > +    /// This is usually used indirectly through the [`static_lock_clas=
s!`] macro. See its
> > +    /// documentation for more information.
> >      ///
> >      /// # Safety
> >      ///
> >      /// The destructor must never run on the returned `LockClassKey`.
> > -    #[doc(hidden)]
> >      pub const unsafe fn new_static() -> Self {
> >          LockClassKey {
> >              inner: Opaque::uninit(),
> >          }
> >      }
> >
> > -    /// Initializes a dynamically allocated lock class key. In the com=
mon case of using a
> > -    /// statically allocated lock class key, the static_lock_class! ma=
cro should be used instead.
> > +    /// Initializes a dynamically allocated lock class key.
> > +    ///
> > +    /// In the common case of using a statically allocated lock class =
key, the
> > +    /// [`static_lock_class!`] macro should be used instead.
> >      ///
> >      /// # Examples
> > +    ///
> >      /// ```
> > -    /// # use kernel::c_str;
> > -    /// # use kernel::alloc::KBox;
> > -    /// # use kernel::types::ForeignOwnable;
> > -    /// # use kernel::sync::{LockClassKey, SpinLock};
> > -    /// # use pin_init::stack_pin_init;
> > +    /// use kernel::c_str;
>
> We can probably change the use `optional_name!()` to make
> core::ffi::CStr -> kernel::str::CStr more smooth.
>
> > +    /// use kernel::types::ForeignOwnable;
> > +    /// use kernel::sync::{LockClassKey, SpinLock};
> > +    /// use pin_init::stack_pin_init;
> >      ///
> >      /// let key =3D KBox::pin_init(LockClassKey::new_dynamic(), GFP_KE=
RNEL)?;
> >      /// let key_ptr =3D key.into_foreign();
> > @@ -80,7 +88,6 @@ impl LockClassKey {
> >      /// // SAFETY: We dropped `num`, the only use of the key, so the r=
esult of the previous
> >      /// // `borrow` has also been dropped. Thus, it's safe to use from=
_foreign.
> >      /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::fro=
m_foreign(key_ptr)) };
> > -    ///
> >      /// # Ok::<(), Error>(())
> >      /// ```
> >      pub fn new_dynamic() -> impl PinInit<Self> {
> > @@ -90,7 +97,10 @@ pub fn new_dynamic() -> impl PinInit<Self> {
> >          })
> >      }
> >
> > -    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> > +    /// Returns a raw pointer to the inner C struct.
> > +    ///
> > +    /// It is up to the caller to use the raw pointer correctly.
> > +    pub fn as_ptr(&self) -> *mut bindings::lock_class_key {
> >          self.inner.get()
> >      }
> >  }
> > @@ -98,14 +108,28 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock=
_class_key {
> >  #[pinned_drop]
> >  impl PinnedDrop for LockClassKey {
> >      fn drop(self: Pin<&mut Self>) {
> > -        // SAFETY: self.as_ptr was registered with lockdep and self is=
 pinned, so the address
> > -        // hasn't changed. Thus, it's safe to pass to unregister.
> > +        // SAFETY: `self.as_ptr()` was registered with lockdep and `se=
lf` is pinned, so the address
> > +        // hasn't changed. Thus, it's safe to pass it to unregister.
> >          unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
> >      }
> >  }
> >
> >  /// Defines a new static lock class and returns a pointer to it.
> > -#[doc(hidden)]
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::c_str;
> > +/// use kernel::sync::{static_lock_class, Arc, SpinLock};
> > +///
> > +/// fn new_locked_int() -> Result<Arc<SpinLock<u32>>> {
> > +///     Arc::pin_init(SpinLock::new(
> > +///         42,
> > +///         c_str!("new_locked_int"),
>
> We could use `optional_name!()` here to avoid another usage of
> `c_str!()`.
>
> That said, I'm not sure whether we should replace `c_str!()` in the
> example of `new_dynamic()` right now in this series, I think that
> depends on two things: 1) whether this series goes into tip or rust-next
> for 6.18 and 2) when we are expecting to land the replacement of
> `c_str!()`.
>
> Miguel and Tamir, any thought?
>
> Regards,
> Boqun

I don't think this patch meaningfully changes the complexity of the
cstr migration. The changes are just a few tokens.

>
> > +///         static_lock_class!(),
> > +///     ), GFP_KERNEL)
> > +/// }
> > +/// ```
> >  #[macro_export]
> >  macro_rules! static_lock_class {
> >      () =3D> {{
> > @@ -117,6 +141,7 @@ macro_rules! static_lock_class {
> >          $crate::prelude::Pin::static_ref(&CLASS)
> >      }};
> >  }
> > +pub use static_lock_class;
> >
> >  /// Returns the given string, if one is provided, otherwise generates =
one based on the source code
> >  /// location.
> >
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >

