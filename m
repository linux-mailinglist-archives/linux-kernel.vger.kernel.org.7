Return-Path: <linux-kernel+bounces-744838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54976B11172
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB1EAA04F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917A2E8DED;
	Thu, 24 Jul 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOScjBE7"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D61EF39F;
	Thu, 24 Jul 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384341; cv=none; b=g3R+zJi1wZ2N02nkfppw7HuiESiBQmvK4f0Gzx0Vx07+130kqkyItCuOzcdZUBUlElrooqlBLiQknNmurK5RKCD64jATfv+Bh9MZEv1CTE+rDtrJHsoIdwynJTddI8pBkhmJsbrzehxwhSCT/L3++3sl3z9TnhLX2QmPyoswnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384341; c=relaxed/simple;
	bh=aMRcn5rJXp7J681Kc0p+uw6+VKakCm4py3S8T/uEAC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDHwE7k9f1YyepTGsPbw4LkTIpnWA50LpGM0nQOkcpAmJHlADxqey2QoyvpxMqGSfgzLDXUIY9MZ8AJr6mGlgnr5VqYi30VEfvuudRPSUpvfmBzYZHoryQ6L335kAlqpMSDlWr9oqX0SW0ETAs7DYCsvELw9bfeo8qot9Cekfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOScjBE7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32f3ef6178bso11338351fa.1;
        Thu, 24 Jul 2025 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753384338; x=1753989138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ/9/s8x4NtBPfpvcC8a0KX2n85o7HUfI6XdDdIAsIM=;
        b=SOScjBE75dbtLD5zTgWlqhclv1y/MDe7UazaNjfqFX+D0DR6wVoKbL5EgY8+9yEUSX
         HXzj1KWrKIgzDoIU98ET+dwAhPpacBcn6HfGAlgA7qqkXcEvElvqtEDf7VrKHZfb4s4x
         7BfsFzpw4j5/H/dD2OOCXODIOzv+1A0tPCkIT/xViYYx0Q7XlBri21soLsbC2kJCxuy+
         ySuEYrxSTqSWtsQw8sSOv6p27Ly4224wfSD+TQCyPKuPe3He3VEL2vBivYQoHnpbl3EK
         05laXy+J3a9OrsK/25ed1hHz7KVXcI5Rd9hHzzHwUbbT2/U7POQeTixOkmxBfMSSd4ad
         k85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753384338; x=1753989138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ/9/s8x4NtBPfpvcC8a0KX2n85o7HUfI6XdDdIAsIM=;
        b=ZnImEUAIu1SudARS32DUP4VzJ5Ua+BZmUfcV2SiRmoxW48i0jPPtJNxEFfAIbVWYWA
         1qtjevjQUDgxTkd8fvuK+n2prkom/ctuGlQhNopkAsR//E0KQUhmQCieHNm3kegTV4ld
         b1UfGicVcrSWdklNBYdHTLEL2RzxoQ7zcEKsCQ3cFHkYyh+s8/9uqVb2fASuGS4JaJxa
         +TxpXjC8dw7NSd6WRrHG7vdKw3mMKEd6H6Lyl1dpoPRb3FUBk4YYFPxK79KrTEp/DBsh
         Ca8sldppU6ysvtomtY3ak+jE4GiEucG1o2FxSmfAwaC2B2DDSYXFqEP/C/tL8zUZO7We
         eTEA==
X-Forwarded-Encrypted: i=1; AJvYcCWz17xsl5jBxWhxQNl0DADXnskktC5R0C5xR82jxNPRsGA9uZoitnmc939+QllFd3yaxVLYRYv/LgVQQyAEgZc=@vger.kernel.org, AJvYcCXSyDf8SXvRcUs3VK4ys9hJUHAmBNVeuezgo+TTSkYdQe+xwid/Z/JtyuSsYCSG/cspZ8E8+mBXh5OfCGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5iJUFx6nHQsnnENQ4SaF/Gk9t74yCQ8vGKSc85yVnes5DSGY
	zdYHgdp0maJqpf7P3SWtuQWbjDoMOcWs19OWHg5KEDljywmfDG3WhiDqSBMPCAAXtlNFn2qV/fn
	n4TDIdlhaQad0dHSkXPJp2i6JKZTR554=
X-Gm-Gg: ASbGncs+TSSA2yiYbCu7DuAbld/HLeMteolzG4J9isreRfP4QJJdzo4so5UZo7Ed+7u
	DHerC5WWo/+oRIziuXZqjsranj18m4R/xbypf3NGeH9tV35JuAbA5wNc8/GO0mOAvx2cn/Ar1en
	JAnrA9QkgwkrqPkm23UMDzlWFvgv5XfGOc82T3le/+USoBbgnzjxWtQ+TgfaXQoPhpgaMmOBcOl
	K4B9yeJ
X-Google-Smtp-Source: AGHT+IFLjSXgwd25t6/wqaoeOIAS4JZGWuCqqlOU7EZvZlrScf2D5sOOXKFeVrAIS+Dy3rATsWnRw+X6PI9GquwIkpI=
X-Received: by 2002:a2e:a552:0:b0:330:d981:1755 with SMTP id
 38308e7fff4ca-330dfbfc4c0mr24318931fa.6.1753384337413; Thu, 24 Jul 2025
 12:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-2-85fa506b8ca4@google.com>
 <aIDn8OFzUbVXQVTF@tardis.local> <CAJ-ks9mQJ5Ed-zd_p9aNAxACn7m-DhcacEpSCwtyixdjtG3gxg@mail.gmail.com>
 <aIJ_bJ5khAivH4kH@tardis-2.local>
In-Reply-To: <aIJ_bJ5khAivH4kH@tardis-2.local>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 24 Jul 2025 15:11:41 -0400
X-Gm-Features: Ac12FXzVvjNIxX-GP9eqHh0SKGv8wcb8H5EC5qbKpllb5WTFCUA3rZyZWRjOxXw
Message-ID: <CAJ-ks9k-bJ7ENDXcj++KHzeefGjZAKLvn1QsbpDU-p=M-XtJ7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: clean up LockClassKey and its docs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 2:46=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Jul 24, 2025 at 02:14:59PM -0400, Tamir Duberstein wrote:
> > On Wed, Jul 23, 2025 at 9:49=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Wed, Jul 23, 2025 at 11:49:34AM +0000, Alice Ryhl wrote:
> > > > Several aspects of the code and documentation for this type is
> > > > incomplete. Also several things are hidden from the docs. Thus, cle=
an it
> > > > up and make it easier to read the rendered html docs.
> > > >
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > ---
> > >
> > > This looks good to me. One thing below:
> > >
> > > >  rust/kernel/sync.rs | 55 ++++++++++++++++++++++++++++++++++++++---=
------------
> > > >  1 file changed, 40 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > > > index 9545bedf47b67976ab8c22d8368991cf1f382e42..5019a0bc95446fe30ba=
d02ce040a1cbbe6d9ad5b 100644
> > > > --- a/rust/kernel/sync.rs
> > > > +++ b/rust/kernel/sync.rs
> > > > @@ -26,7 +26,9 @@
> > > >  pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
> > > >  pub use locked_by::LockedBy;
> > > >
> > > > -/// Represents a lockdep class. It's a wrapper around C's `lock_cl=
ass_key`.
> > > > +/// Represents a lockdep class.
> > > > +///
> > > > +/// Wraps the kernel's `struct lock_class_key`.
> > > >  #[repr(transparent)]
> > > >  #[pin_data(PinnedDrop)]
> > > >  pub struct LockClassKey {
> > > > @@ -34,6 +36,10 @@ pub struct LockClassKey {
> > > >      inner: Opaque<bindings::lock_class_key>,
> > > >  }
> > > >
> > > > +// SAFETY: Unregistering a lock class key from a different thread =
than where it was registered is
> > > > +// allowed.
> > > > +unsafe impl Send for LockClassKey {}
> > > > +
> > > >  // SAFETY: `bindings::lock_class_key` is designed to be used concu=
rrently from multiple threads and
> > > >  // provides its own synchronization.
> > > >  unsafe impl Sync for LockClassKey {}
> > > > @@ -41,28 +47,30 @@ unsafe impl Sync for LockClassKey {}
> > > >  impl LockClassKey {
> > > >      /// Initializes a statically allocated lock class key.
> > > >      ///
> > > > -    /// This is usually used indirectly through the [`static_lock_=
class!`] macro.
> > > > +    /// This is usually used indirectly through the [`static_lock_=
class!`] macro. See its
> > > > +    /// documentation for more information.
> > > >      ///
> > > >      /// # Safety
> > > >      ///
> > > >      /// The destructor must never run on the returned `LockClassKe=
y`.
> > > > -    #[doc(hidden)]
> > > >      pub const unsafe fn new_static() -> Self {
> > > >          LockClassKey {
> > > >              inner: Opaque::uninit(),
> > > >          }
> > > >      }
> > > >
> > > > -    /// Initializes a dynamically allocated lock class key. In the=
 common case of using a
> > > > -    /// statically allocated lock class key, the static_lock_class=
! macro should be used instead.
> > > > +    /// Initializes a dynamically allocated lock class key.
> > > > +    ///
> > > > +    /// In the common case of using a statically allocated lock cl=
ass key, the
> > > > +    /// [`static_lock_class!`] macro should be used instead.
> > > >      ///
> > > >      /// # Examples
> > > > +    ///
> > > >      /// ```
> > > > -    /// # use kernel::c_str;
> > > > -    /// # use kernel::alloc::KBox;
> > > > -    /// # use kernel::types::ForeignOwnable;
> > > > -    /// # use kernel::sync::{LockClassKey, SpinLock};
> > > > -    /// # use pin_init::stack_pin_init;
> > > > +    /// use kernel::c_str;
> > >
> > > We can probably change the use `optional_name!()` to make
> > > core::ffi::CStr -> kernel::str::CStr more smooth.
> > >
> > > > +    /// use kernel::types::ForeignOwnable;
> > > > +    /// use kernel::sync::{LockClassKey, SpinLock};
> > > > +    /// use pin_init::stack_pin_init;
> > > >      ///
> > > >      /// let key =3D KBox::pin_init(LockClassKey::new_dynamic(), GF=
P_KERNEL)?;
> > > >      /// let key_ptr =3D key.into_foreign();
> > > > @@ -80,7 +88,6 @@ impl LockClassKey {
> > > >      /// // SAFETY: We dropped `num`, the only use of the key, so t=
he result of the previous
> > > >      /// // `borrow` has also been dropped. Thus, it's safe to use =
from_foreign.
> > > >      /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>:=
:from_foreign(key_ptr)) };
> > > > -    ///
> > > >      /// # Ok::<(), Error>(())
> > > >      /// ```
> > > >      pub fn new_dynamic() -> impl PinInit<Self> {
> > > > @@ -90,7 +97,10 @@ pub fn new_dynamic() -> impl PinInit<Self> {
> > > >          })
> > > >      }
> > > >
> > > > -    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> > > > +    /// Returns a raw pointer to the inner C struct.
> > > > +    ///
> > > > +    /// It is up to the caller to use the raw pointer correctly.
> > > > +    pub fn as_ptr(&self) -> *mut bindings::lock_class_key {
> > > >          self.inner.get()
> > > >      }
> > > >  }
> > > > @@ -98,14 +108,28 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::=
lock_class_key {
> > > >  #[pinned_drop]
> > > >  impl PinnedDrop for LockClassKey {
> > > >      fn drop(self: Pin<&mut Self>) {
> > > > -        // SAFETY: self.as_ptr was registered with lockdep and sel=
f is pinned, so the address
> > > > -        // hasn't changed. Thus, it's safe to pass to unregister.
> > > > +        // SAFETY: `self.as_ptr()` was registered with lockdep and=
 `self` is pinned, so the address
> > > > +        // hasn't changed. Thus, it's safe to pass it to unregiste=
r.
> > > >          unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
> > > >      }
> > > >  }
> > > >
> > > >  /// Defines a new static lock class and returns a pointer to it.
> > > > -#[doc(hidden)]
> > > > +///
> > > > +/// # Examples
> > > > +///
> > > > +/// ```
> > > > +/// use kernel::c_str;
> > > > +/// use kernel::sync::{static_lock_class, Arc, SpinLock};
> > > > +///
> > > > +/// fn new_locked_int() -> Result<Arc<SpinLock<u32>>> {
> > > > +///     Arc::pin_init(SpinLock::new(
> > > > +///         42,
> > > > +///         c_str!("new_locked_int"),
> > >
> > > We could use `optional_name!()` here to avoid another usage of
> > > `c_str!()`.
> > >
> > > That said, I'm not sure whether we should replace `c_str!()` in the
> > > example of `new_dynamic()` right now in this series, I think that
> > > depends on two things: 1) whether this series goes into tip or rust-n=
ext
> > > for 6.18 and 2) when we are expecting to land the replacement of
> > > `c_str!()`.
> > >
> > > Miguel and Tamir, any thought?
> > >
> > > Regards,
> > > Boqun
> >
> > I don't think this patch meaningfully changes the complexity of the
> > cstr migration. The changes are just a few tokens.
> >
>
> Ok, so you're fine if I or someone else take this patch as it is
> (including the new user of `c_str!()`), and get it merged via the tip
> tree [1] in v6.18 merge window? That means if we remove `c_str!()` in
> v6.18 merge window, there would be a non-trivial merge resolution to do.

The merge conflict would only arise at the very end of the migration,
when we're using C-string literals everywhere *and* the macro has been
renamed. I haven't even sent that final series yet. Regardless, the
resolution would be quite trivial, I think:
- remove the import that doesn't exist
- replace `c_str!("new_locked_int")` with `c"new_locked_int"`

In other words: yep, I'm fine with however this is taken.

>
> Of course, it'll be less problematic if this goes into rust tree instead
> of tip.

This would be ideal, yep.

>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/
>
> Regards,
> Boqun
>
> > >
> > > > +///         static_lock_class!(),
> > > > +///     ), GFP_KERNEL)
> > > > +/// }
> > > > +/// ```
> > > >  #[macro_export]
> > > >  macro_rules! static_lock_class {
> > > >      () =3D> {{
> > > > @@ -117,6 +141,7 @@ macro_rules! static_lock_class {
> > > >          $crate::prelude::Pin::static_ref(&CLASS)
> > > >      }};
> > > >  }
> > > > +pub use static_lock_class;
> > > >
> > > >  /// Returns the given string, if one is provided, otherwise genera=
tes one based on the source code
> > > >  /// location.
> > > >
> > > > --
> > > > 2.50.0.727.gbf7dc18ff4-goog
> > > >

