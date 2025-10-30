Return-Path: <linux-kernel+bounces-878705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C666C214F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8133A85A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1F2EC55B;
	Thu, 30 Oct 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeRW0Y8R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AED2C3277;
	Thu, 30 Oct 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842854; cv=none; b=lV26Qq96BUrjSLZCDGiO5EQ5ThJgWeAjWBP2ScxDQ3yO3zDP3WSBeenKbmwU5hCo2LNJH9NeDPv7zr59RuKFReMo+YOKWpruI4KVatMOP3IehCCJcHDWZTZ7y5whWOVSULvkiEPibPgEZlgpV1c5KJrM1GhOE8pIKcH+RhvhUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842854; c=relaxed/simple;
	bh=ncPoNoYluH4Wu/5wuDmHoF/MvRw9SMmpIpaF+/jh+rw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YK0qbGlCy37fBr6UwmBIfPKLJcL6GZztA+5ik8JFjOqWhBjuGwLlb7F9k3UianugC0wkGLhdheG0NKuBQIFHHnMHdQWXDJrBIctChT1doDwtAlR3FGwbdEVYLtP4BjsnfQDTLXBndsg2CbsFFfXS8pwXJjsR/dK8GZqg/BoJEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeRW0Y8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD5AC4CEF8;
	Thu, 30 Oct 2025 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842853;
	bh=ncPoNoYluH4Wu/5wuDmHoF/MvRw9SMmpIpaF+/jh+rw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YeRW0Y8R6fL3R1loD4tka+jJ7MHqp8+INj4T3Bmu8hew5WILurw/p8vfU/Q8X7MqO
	 3VP8HXCJkVnusMPLOhr1ilBURZ+vHR5VhoOx2EAR16MK1E+a8P96r2+bFqMw1Zjjen
	 m6N2RWpClpuskLpEvYwjwTWE2pP/MqxmAngNXGUCJMh1s1MkRl7m8V6wM4xTjgb2UV
	 v1QWlc1wjAF/uUMuQvP7UKa/blDCSFZZdE11ViZw5mFi5clflIbOz+DFakPM/RUT5l
	 HmtXJOZg9H6+rJLJ88vhYCC/DpaiqE8dmh8hDQUB8d9+F2KYmHLC7L95FsQui08sFM
	 cLYTFyPvXDnSQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 17:47:26 +0100
Message-Id: <DDVT5YA564C6.3HN9WCMQX49PC@kernel.org>
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <zhiwang@kernel.org>,
 <alwilliamson@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <jgg@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
In-Reply-To: <20251030160315.451841-2-zhiw@nvidia.com>

On Thu Oct 30, 2025 at 5:03 PM CET, Zhi Wang wrote:
> diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
> new file mode 100644
> index 000000000000..21f8f7d11d6f
> --- /dev/null
> +++ b/rust/kernel/fwctl.rs
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +//! Abstractions for the fwctl.
> +//!
> +//! This module provides bindings for working with fwctl devices in kern=
el modules.
> +//!
> +//! C header: [`include/linux/fwctl.h`]
> +
> +use crate::device::Device;
> +use crate::types::ARef;
> +use crate::{bindings, container_of, device, error::code::*, prelude::*};
> +
> +use core::marker::PhantomData;
> +use core::ptr::NonNull;
> +use core::slice;

Please use the import scheme as documented in [1].

[1] https://docs.kernel.org/rust/coding-guidelines.html#imports

> +/// The registration of a fwctl device.
> +///
> +/// This type represents the registration of a [`struct fwctl_device`]. =
When an instance of this
> +/// type is dropped, its respective fwctl device will be unregistered an=
d freed.
> +///
> +/// [`struct fwctl_device`]: srctree/include/linux/device/fwctl.h
> +pub struct Registration<T: FwCtlOps> {
> +    fwctl_dev: NonNull<bindings::fwctl_device>,

Given that this structure has to keep a reference count of the fwctl_device=
, I'd
prefer to have an abstraction of struct fwctl_device (fwctl::Device) which
implements AlwaysRefCounted.

This way the Registration can store an ARef<fwctl::Device> rather than a ra=
w
pointer.

However, I wonder if we really need a reference count? Does fwctl_register(=
) not
take a reference count itself?

> +    _marker: PhantomData<T>,
> +}
> +
> +impl<T: FwCtlOps> Registration<T> {
> +    /// Allocate and register a new fwctl device under the given parent =
device.
> +    pub fn new(parent: &device::Device) -> Result<Self> {

AFAIK, fwctl_unregister() is synchronized against IOCTLs. Hence, if we guar=
antee
that a fwctl::Registration can not out-live parent device unbind, we can pr=
ovide
a &Device<Bound> in the FwCtlOps callbacks, which allows us to do zero-cost
accesses of device resources with Devres::access().

In order to provide this guarantee, this function should return
impl PinInit<Devres<Self>, Error>.

> +        let ops =3D &FwCtlVTable::<T>::VTABLE as *const _ as *mut _;

Please use cast() and cast_mut() when possible.

> +
> +        // SAFETY: `_fwctl_alloc_device()` allocates a new `fwctl_device=
`
> +        // and initializes its embedded `struct device`.

This safety comment should justify how you guarantee that the arguments you=
 pass
in are valid, instead of describing what the called function does.

> +        let dev =3D unsafe {
> +            bindings::_fwctl_alloc_device(
> +                parent.as_raw(),
> +                ops,
> +                core::mem::size_of::<bindings::fwctl_device>(),
> +            )
> +        };
> +
> +        let dev =3D NonNull::new(dev).ok_or(ENOMEM)?;
> +
> +        // SAFETY: `fwctl_register()` expects a valid device from `_fwct=
l_alloc_device()`.
> +        let ret =3D unsafe { bindings::fwctl_register(dev.as_ptr()) };
> +        if ret !=3D 0 {
> +            // SAFETY: If registration fails, release the allocated fwct=
l_device().
> +            unsafe {
> +                bindings::put_device(core::ptr::addr_of_mut!((*dev.as_pt=
r()).dev));
> +            }
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        Ok(Self {
> +            fwctl_dev: dev,
> +            _marker: PhantomData,
> +        })
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::fwctl_device {
> +        self.fwctl_dev.as_ptr()
> +    }
> +}
> +
> +impl<T: FwCtlOps> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `fwctl_unregister()` expects a valid device from `_fw=
ctl_alloc_device()`.
> +        unsafe {
> +            bindings::fwctl_unregister(self.as_raw());
> +            bindings::put_device(core::ptr::addr_of_mut!((*self.as_raw()=
).dev));
> +        }
> +    }
> +}
> +
> +// SAFETY: The only action allowed in a `Registration` instance is dropp=
ing it, which is safe to do
> +// from any thread because `fwctl_unregister()/put_device()` can be call=
ed from any sleepible
> +// context.
> +unsafe impl<T: FwCtlOps> Send for Registration<T> {}
> +
> +/// Trait implemented by each Rust driver that integrates with the fwctl=
 subsystem.
> +///
> +/// Each implementation corresponds to a specific device type and provid=
es
> +/// the vtable used by the core `fwctl` layer to manage per-FD user cont=
exts
> +/// and handle RPC requests.
> +pub trait FwCtlOps: Sized {
> +    /// Driver UCtx type.
> +    type UCtx;
> +
> +    /// fwctl device type, matching the C enum `fwctl_device_type`.
> +    const DEVICE_TYPE: u32;
> +
> +    /// Called when a new user context is opened by userspace.
> +    fn open_uctx(uctx: &mut FwCtlUCtx<Self::UCtx>) -> Result<(), Error>;
> +
> +    /// Called when the user context is being closed.
> +    fn close_uctx(uctx: &mut FwCtlUCtx<Self::UCtx>);

Why not just open() and close()?

> +    /// Return device or context information to userspace.
> +    fn info(uctx: &mut FwCtlUCtx<Self::UCtx>) -> Result<KVec<u8>, Error>=
;
> +
> +    /// Called when a userspace RPC request is received.
> +    fn fw_rpc(
> +        uctx: &mut FwCtlUCtx<Self::UCtx>,
> +        scope: u32,
> +        rpc_in: &mut [u8],
> +        out_len: *mut usize,
> +    ) -> Result<Option<KVec<u8>>, Error>;

As mentioned above, if we ensure that a fwctl::Registration cannot out-live=
 the
parent device being bound, we can provide a &Device<Bound> in those callbac=
ks
for zero-cost accesses of device resources with Devres::access().

> +}
> +
> +/// Represents a per-FD user context (`struct fwctl_uctx`).
> +///
> +/// Each driver embeds `struct fwctl_uctx` as the first field of its own
> +/// context type and uses this wrapper to access driver-specific data.
> +#[repr(C)]
> +#[pin_data]
> +pub struct FwCtlUCtx<T> {
> +    /// The core fwctl user context shared with the C implementation.
> +    #[pin]
> +    pub fwctl_uctx: bindings::fwctl_uctx,

This should be Opaque<bindings::fwctl_uctx> and should not be a public fiel=
d.

> +    /// Driver-specific data associated with this user context.
> +    pub uctx: T,

I'd rather provide a Deref and DerefMut implementation for this.

> +}
> +
> +impl<T> FwCtlUCtx<T> {
> +    /// Converts a raw C pointer to `struct fwctl_uctx` into a reference=
 to the
> +    /// enclosing `FwCtlUCtx<T>`.
> +    ///
> +    /// # Safety
> +    /// * `ptr` must be a valid pointer to a `fwctl_uctx` that is embedd=
ed
> +    ///   inside an existing `FwCtlUCtx<T>` instance.
> +    /// * The caller must ensure that the lifetime of the returned refer=
ence
> +    ///   does not outlive the underlying object managed on the C side.
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a mu=
t Self {

Why does this need to be public?

> +        // SAFETY: `ptr` was originally created from a valid `FwCtlUCtx<=
T>`.
> +        unsafe { &mut *container_of!(ptr, FwCtlUCtx<T>, fwctl_uctx) }
> +    }
> +
> +    /// Returns the parent device of this user context.
> +    ///
> +    /// # Safety
> +    /// The `fwctl_device` pointer inside `fwctl_uctx` must be valid.
> +    pub fn get_parent_device(&self) -> ARef<Device> {

We the fwctl::Registration changes suggested above, this should return a
&Device<Bound>.

Regardless of this, it's better to return a &Device than an ARef<Device>. T=
he
caller can always obtain a reference count, i.e. ARef<Device> from a &Devic=
e (or
a &Device<Bound>).

> +        // SAFETY: `self.fwctl_uctx.fwctl` is initialized by the fwctl s=
ubsystem and guaranteed
> +        // to remain valid for the lifetime of this `FwCtlUCtx`.
> +        let raw_dev =3D
> +            unsafe { (*(self.fwctl_uctx.fwctl)).dev.parent as *mut kerne=
l::bindings::device };
> +        // SAFETY: `raw_dev` points to a live device object.
> +        unsafe { Device::get_device(raw_dev) }
> +    }
> +
> +    /// Returns a mutable reference to the driver-specific context.
> +    pub fn to_driver_uctx_mut(&mut self) -> &mut T {
> +        &mut self.uctx
> +    }

As mentioned, I think Deref and DerefMut are a better fit for this.

> +}
> +
> +/// Static vtable mapping Rust trait methods to C callbacks.
> +pub struct FwCtlVTable<T: FwCtlOps>(PhantomData<T>);
> +
> +impl<T: FwCtlOps> FwCtlVTable<T> {
> +    /// Static instance of `fwctl_ops` used by the C core to call into R=
ust.
> +    pub const VTABLE: bindings::fwctl_ops =3D bindings::fwctl_ops {
> +        device_type: T::DEVICE_TYPE,
> +        uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>(),
> +        open_uctx: Some(Self::open_uctx_callback),
> +        close_uctx: Some(Self::close_uctx_callback),
> +        info: Some(Self::info_callback),
> +        fw_rpc: Some(Self::fw_rpc_callback),
> +    };
> +
> +    /// Called when a new user context is opened by userspace.
> +    unsafe extern "C" fn open_uctx_callback(uctx: *mut bindings::fwctl_u=
ctx) -> ffi::c_int {
> +        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a v=
alid pointer.
> +        let ctx =3D unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
> +        match T::open_uctx(ctx) {
> +            Ok(()) =3D> 0,
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +
> +    /// Called when the user context is being closed.
> +    unsafe extern "C" fn close_uctx_callback(uctx: *mut bindings::fwctl_=
uctx) {
> +        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a v=
alid pointer.
> +        let ctx =3D unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
> +        T::close_uctx(ctx);
> +    }
> +
> +    /// Returns device or context information.
> +    unsafe extern "C" fn info_callback(
> +        uctx: *mut bindings::fwctl_uctx,
> +        length: *mut usize,
> +    ) -> *mut ffi::c_void {
> +        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a v=
alid pointer.
> +        let ctx =3D unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
> +
> +        match T::info(ctx) {
> +            Ok(kvec) =3D> {
> +                // The ownership of the buffer is now transferred to the=
 foreign
> +                // caller. It must eventually be released by fwctl frame=
work.
> +                let (ptr, len, _cap) =3D kvec.into_raw_parts();
> +
> +                // SAFETY: `length` is a valid out-parameter provided by=
 the C
> +                // caller. Write the number of bytes in the returned buf=
fer.
> +                unsafe {
> +                    *length =3D len;
> +                }
> +
> +                ptr.cast::<ffi::c_void>()
> +            }
> +
> +            Err(e) =3D> Error::to_ptr(e),
> +        }
> +    }
> +
> +    /// Called when a user-space RPC request is received.
> +    unsafe extern "C" fn fw_rpc_callback(
> +        uctx: *mut bindings::fwctl_uctx,
> +        scope: u32,
> +        rpc_in: *mut ffi::c_void,
> +        in_len: usize,
> +        out_len: *mut usize,
> +    ) -> *mut ffi::c_void {
> +        // SAFETY: `uctx` is guaranteed by the fwctl framework to be a v=
alid pointer.
> +        let ctx =3D unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
> +
> +        // SAFETY: `rpc_in` points to a valid input buffer of size `in_l=
en`
> +        // provided by fwctl subsystem.

Please see the safety requirements of slice::from_raw_parts_mut() and justi=
fy
all of them.

> +        let rpc_in_slice: &mut [u8] =3D
> +            unsafe { slice::from_raw_parts_mut(rpc_in as *mut u8, in_len=
) };
> +
> +        match T::fw_rpc(ctx, scope, rpc_in_slice, out_len) {
> +            // Driver allocates a new output buffer.
> +            Ok(Some(kvec)) =3D> {
> +                // The ownership of the buffer is now transferred to the=
 foreign
> +                // caller. It must eventually be released by fwctl subsy=
stem.
> +                let (ptr, len, _cap) =3D kvec.into_raw_parts();
> +
> +                // SAFETY: `out_len` is a valid writable pointer provide=
d by the C caller.
> +                unsafe {
> +                    *out_len =3D len;
> +                }

NIT: If you move the semicolon at the end of the unsafe block, this is form=
atted
in a single line.

> +
> +                ptr.cast::<ffi::c_void>()
> +            }
> +
> +            // Driver re-uses the existing input buffer and writes the o=
ut_len.
> +            Ok(None) =3D> rpc_in,
> +
> +            // Return an ERR_PTR-style encoded error pointer.
> +            Err(e) =3D> Error::to_ptr(e),
> +        }
> +    }
> +}

