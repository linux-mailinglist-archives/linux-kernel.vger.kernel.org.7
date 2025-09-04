Return-Path: <linux-kernel+bounces-800282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE9B435C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD8854E54BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E872C11EC;
	Thu,  4 Sep 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="SW0zoAYZ"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D562BE65B;
	Thu,  4 Sep 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974590; cv=none; b=NbRzV9lItI2QxH8aiXNjuymASFO0s/zRZ78kvv/3YUVOb0xDp9WiNRsgOAjmi1Y9/cifk4eWavHg1Gz/wcZ26JlSZW8UPfoxJPgU2C9uY3jkDWcu2kWN5zOG+UJrpAgYw9KCFj2uZi5/hvN4vJ5lzZhjSW6/9ov/d5HToeRab/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974590; c=relaxed/simple;
	bh=QNtfTlAH6DI4T1zY3ES9S9NLB82uklHXRFVHEC7qN3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBgjyK72+KaMFydvrQCHXYuRxsDV5DZ46SNImKnjD7QXvw+DVf0KJunnGmMr78gAQBGRpx41X8qRSNa8rRn2lNev6NFCBpSPAo37iHHX0EGhO06qck56OvkSxIOQLOSWGrCSRTPclSRYssfXlLfD3r8EfhJc26Q6sX4HbmJmIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=SW0zoAYZ; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bc97:0:640:ee90:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 2E8D680D65;
	Thu, 04 Sep 2025 11:23:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JNcTFoOMp8c0-OsCcU95U;
	Thu, 04 Sep 2025 11:23:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756974204;
	bh=V9WvHvEbx2gLOiXH9zZov+GXvO0ue22G7wOiU8UeFpg=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=SW0zoAYZDP3JwsmhCtorY+AhIILYpnQLGYIaUj2lT1o1hxhIMTV/45RpbtkgEvH7O
	 cBnGDgR5SU2o3QZ0J2SYoYBC9m4b5IPUu/iElOzzvA3Fy8jKp4/lte9icERWeT0sVN
	 GSGEwH8/kH57nSDvBGL7r3TET3Hn/z0dTuXTxoqM=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 4 Sep 2025 11:23:16 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v6 2/7] rust: implement `WwClass` for ww_mutex support
Message-ID: <20250904112316.3fc88712@nimda.home>
In-Reply-To: <aLhna_Xj6W88F6Wp@tardis-2.local>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-3-work@onurozkan.dev>
	<aLhna_Xj6W88F6Wp@tardis-2.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Sep 2025 09:06:03 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Wed, Sep 03, 2025 at 04:13:08PM +0300, Onur =C3=96zkan wrote:
> > Adds the `WwClass` type, the first step in supporting
> > `ww_mutex` in Rust. `WwClass` represents a class of ww
> > mutexes used for deadlock avoidance for supporting both
> > wait-die and wound-wait semantics.
> >=20
> > Also adds the `define_ww_class!` macro for safely declaring
> > static instances.
> >=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/sync/lock.rs          |   1 +
> >  rust/kernel/sync/lock/ww_mutex.rs | 136
> > ++++++++++++++++++++++++++++++ 2 files changed, 137 insertions(+)
> >  create mode 100644 rust/kernel/sync/lock/ww_mutex.rs
> >=20
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index 27202beef90c..5b320c2b28c1 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -15,6 +15,7 @@
> >=20
> >  pub mod mutex;
> >  pub mod spinlock;
> > +pub mod ww_mutex;
> >=20
> >  pub(super) mod global;
> >  pub use global::{GlobalGuard, GlobalLock, GlobalLockBackend,
> > GlobalLockedBy}; diff --git a/rust/kernel/sync/lock/ww_mutex.rs
> > b/rust/kernel/sync/lock/ww_mutex.rs new file mode 100644
> > index 000000000000..ca5b4525ace6
> > --- /dev/null
> > +++ b/rust/kernel/sync/lock/ww_mutex.rs
> > @@ -0,0 +1,136 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! A kernel Wound/Wait Mutex.
> > +//!
> > +//! This module provides Rust abstractions for the Linux kernel's
> > `ww_mutex` implementation, +//! which provides deadlock avoidance
> > through a wait-wound or wait-die algorithm. +//!
> > +//! C header:
> > [`include/linux/ww_mutex.h`](srctree/include/linux/ww_mutex.h) +//!
> > +//! For more information:
> > <https://docs.kernel.org/locking/ww-mutex-design.html> +
> > +use crate::bindings;
> > +use crate::prelude::*;
> > +use crate::types::Opaque;
> > +
> > +/// Create static [`WwClass`] instances.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::{c_str, define_ww_class};
> > +///
> > +/// define_ww_class!(WOUND_WAIT_GLOBAL_CLASS, wound_wait,
> > c_str!("wound_wait_global_class")); +///
> > define_ww_class!(WAIT_DIE_GLOBAL_CLASS, wait_die,
> > c_str!("wait_die_global_class")); +/// ``` +#[macro_export]
> > +macro_rules! define_ww_class {
> > +    ($name:ident, wound_wait, $class_name:expr) =3D> {
> > +        static $name: $crate::sync::lock::ww_mutex::WwClass =3D
> > +            // SAFETY: This is `static`, so address is fixed and
> > won't move.
> > +            unsafe {
> > $crate::sync::lock::ww_mutex::WwClass::unpinned_new($class_name,
> > false) };
> > +    };
> > +    ($name:ident, wait_die, $class_name:expr) =3D> {
> > +        static $name: $crate::sync::lock::ww_mutex::WwClass =3D
> > +            // SAFETY: This is `static`, so address is fixed and
> > won't move.
> > +            unsafe {
> > $crate::sync::lock::ww_mutex::WwClass::unpinned_new($class_name,
> > true) };
> > +    };
> > +}
> > +
> > +/// A class used to group mutexes together for deadlock avoidance.
> > +///
> > +/// All mutexes that might be acquired together should use the
> > same class. +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::sync::lock::ww_mutex::WwClass;
> > +/// use kernel::c_str;
> > +/// use pin_init::stack_pin_init;
> > +///
> > +/// stack_pin_init!(let _wait_die_class =3D
> > WwClass::new_wait_die(c_str!("graphics_buffers"))); +///
> > stack_pin_init!(let _wound_wait_class =3D
> > WwClass::new_wound_wait(c_str!("memory_pools"))); +/// +/// #
> > Ok::<(), Error>(()) +/// ```
> > +#[pin_data]
> > +pub struct WwClass {
> > +    #[pin]
> > +    inner: Opaque<bindings::ww_class>,
> > +}
> > +
> > +// SAFETY: [`WwClass`] is set up once and never modified. It's
> > fine to share it across threads. +unsafe impl Sync for WwClass {}
> > +// SAFETY: Doesn't hold anything thread-specific. It's safe to
> > send to other threads. +unsafe impl Send for WwClass {}
> > +
> > +impl WwClass {
> > +    /// Creates an unpinned [`WwClass`].
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Caller must guarantee that the returned value is not moved
> > after creation.
> > +    pub const unsafe fn unpinned_new(name: &'static CStr,
> > is_wait_die: bool) -> Self {
> > +        WwClass {
> > +            inner: Opaque::new(bindings::ww_class {
> > +                stamp: bindings::atomic_long_t { counter: 0 },
> > +                acquire_name: name.as_char_ptr(),
> > +                mutex_name: name.as_char_ptr(),
> > +                is_wait_die: is_wait_die as u32,
> > +                // TODO: Replace with
> > `bindings::lock_class_key::default()` once stabilized for `const`.
> > +                //
> > +                // SAFETY: This is always zero-initialized when
> > defined with `DEFINE_WD_CLASS`
> > +                // globally on C side.
> > +                //
> > +                // Ref:
> > <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/include/linux/ww_mutex.h?h=3Dv6.16-rc2#n85>
>=20
> Please don't use internet to reference the code in the same repo ;-)
> You can just say "see __WW_CLASS_INITIALIZER() in
> include/linux/ww_mutex.h".
>=20

I don't know why I did that tbh :D I guess I wanted to have a permament
ref, but it doesn't make much sense yeah.

> > +                acquire_key: unsafe { core::mem::zeroed() },
> > +                // TODO: Replace with
> > `bindings::lock_class_key::default()` once stabilized for `const`.
> > +                //
> > +                // SAFETY: This is always zero-initialized when
> > defined with `DEFINE_WD_CLASS`
> > +                // globally on C side.
> > +                //
> > +                // Ref:
> > <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/include/linux/ww_mutex.h?h=3Dv6.16-rc2#n85>
> > +                mutex_key: unsafe { core::mem::zeroed() },
> > +            }),
> > +        }
> > +    }
> > +
> > +    /// Creates a [`WwClass`].
> > +    ///
> > +    /// You should not use this function directly. Use the
> > [`define_ww_class!`]
> > +    /// macro or call [`WwClass::new_wait_die`] or
> > [`WwClass::new_wound_wait`] instead.
> > +    const fn new(name: &'static CStr, is_wait_die: bool) -> Self {
> > +        WwClass {
> > +            inner: Opaque::new(bindings::ww_class {
>=20
> You cannot use Opaque::new() here, it'll move the object when new()
> returns. You should change the function signature to a `... ->
> PinInit<Self>`, and use pin_init!() macro + Opaque::ffi_init(), like:
>=20
>     const fn new(...) -> PinInit<Self> {
>         pin_init!{
> 	    Self {
> 	        inner <- Opaque::ffi_init(|class| {
> 		    ...
> 		});
> 	    }
> 	}
>     }
>=20
> Regards,
> Boqun

I didn't know that, will do that in the following patch.

Thanks,
Onur

