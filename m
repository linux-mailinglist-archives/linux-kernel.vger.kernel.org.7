Return-Path: <linux-kernel+bounces-644160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7309DAB37D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F52B18858C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FEE2949F2;
	Mon, 12 May 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OML1S5/x"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0D2949FE;
	Mon, 12 May 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054284; cv=pass; b=uMP8oFsFAUQpUxjt5FAYdcKA3y5vKaeae+bRuL0tDG2Xi1Ov2jvE9d4J+YCvIjRS0QQ9Ew1BCz9PPxva+YGI01Ha3bjgPAP3s6ePQwGvLZ21bqacJX18xORVWXxoGqfDh2h88WxTjET5S8OFjcyYh+/3SJ4TkVhz9le6N7QNRtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054284; c=relaxed/simple;
	bh=9Mhnkx3DyFrIbQFKM8U8vkZ7A1KEHiJzhMf+0QMyZxc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HW8XD5DnO2w7wQncl9sjDtrifBf6ln3UOBfygdzpLti+uXY+a5e7XN1+sCe/5LWruGhYj5Ipy67xLJ94/oFr2PdO3BMoJ52f7w12D21Bd66sEi3RJ60GrvHDEUvCX8LAeZeypoJkHgdMi+xkSju/lbXasx1vanocofe3mYSlAW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=OML1S5/x; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747054234; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L6+plNJpH7nLiSVIkILTnWdj1RZioizrnsK7kJ15c1xne11QIKzXyRXGReqw+HIB1UBm0sDC7YnDEDMM6O/K0HJ7JJHgFUYO2teI1w/TI+k7tAleLYOrUJzXvz31xQxA9uJHzfapWI1uwZea4uUVfD5/qRNiBNSTgfSsVjc6BhI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747054234; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VOoGdNsKErCXCQgNogQk+2VVDS3t16kIIGMJjkmyiQs=; 
	b=FSPr/LestwJTmnsg6RGrJgNzbCiEWFSgqMaasLV3vUMTdikD51K9PfNGx6KevlF9C51fu4h9hxdZX2EoxGjldFpFJ4fdFYhIUtiiCBz+aC04YG6XJIOhFjefAnp7zEB6OEAfDv4xa0DAynxhU11nFV1WIOTU/JRzeqx+V/fpk2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747054234;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=VOoGdNsKErCXCQgNogQk+2VVDS3t16kIIGMJjkmyiQs=;
	b=OML1S5/xFb21Wla6/XWCdOAkMgfGadiWd0L/VTwItPjLgDgTHSAUGKJIIEaMjsqV
	k/5MZu24K4KxF373UnGgzXMmyMMBu0DFu1OLYyBSRpQZe7YBFggdZ0G3N9whHp9iK4H
	46RlVZ9/2qynwD9zqSuyLRVHjjR503gdX1Yrvh1M=
Received: by mx.zohomail.com with SMTPS id 1747054231404322.5806783932501;
	Mon, 12 May 2025 05:50:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [RFC v3 02/33] rust: drm: Add traits for registering KMS devices
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250305230406.567126-3-lyude@redhat.com>
Date: Mon, 12 May 2025 09:50:14 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 mcanal@igalia.com,
 Alice Ryhl <aliceryhl@google.com>,
 Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <sima@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina@asahilina.net>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF4D1CB0-BD91-47B2-90E8-9963687F9FF8@collabora.com>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-3-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-ZohoMailClient: External

Hi Lyude,

> On 5 Mar 2025, at 19:59, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This commit adds some traits for registering DRM devices with KMS =
support,
> implemented through the kernel::drm::kms::KmsDriver trait. Devices =
which
> don't have KMS support can simply use PhantomData<Self>.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
>=20
> V3:
> * Get rid of Kms, long live KmsDriver
>  After Daniel pointed out that we should just make KmsDriver a =
supertrait
>  of Driver, it immediately occurred to me that there's no actual need =
for
>  Kms to be a separate trait at all. So, drop Kms entirely and move its
>  requirements over to KmsDriver.
> * Drop fbdev module entirely and move fbdev related setup into =
AllocImpl
>  (Daniel)
> * Rebase to use drm_client_setup()
>=20
> TODO:
> * Generate feature flags automatically, these shouldn't need to be
>  specified by the user
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/bindings/bindings_helper.h |   6 ++
> rust/kernel/drm/device.rs       |  10 +-
> rust/kernel/drm/drv.rs          |  56 ++++++++--
> rust/kernel/drm/gem/mod.rs      |   4 +
> rust/kernel/drm/gem/shmem.rs    |   4 +
> rust/kernel/drm/kms.rs          | 186 ++++++++++++++++++++++++++++++++
> rust/kernel/drm/mod.rs          |   1 +
> 7 files changed, 258 insertions(+), 9 deletions(-)
> create mode 100644 rust/kernel/drm/kms.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index ca857fb00b1a5..e1ed4f40c8e89 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,10 +6,16 @@
>  * Sorted alphabetically.
>  */
>=20
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/clients/drm_client_setup.h>
> #include <drm/drm_device.h>
> #include <drm/drm_drv.h>
> #include <drm/drm_file.h>
> +#include <drm/drm_fbdev_dma.h>
> +#include <drm/drm_fbdev_shmem.h>
> #include <drm/drm_gem.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> #include <drm/drm_gem_shmem_helper.h>
> #include <drm/drm_ioctl.h>
> #include <kunit/test.h>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 5b4db2dfe87f5..cf063de387329 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -5,8 +5,8 @@
> //! C header: =
[`include/linux/drm/drm_device.h`](srctree/include/linux/drm/drm_device.h)=

>=20
> use crate::{
> -    bindings, device, drm,
> -    drm::drv::AllocImpl,
> +    bindings, device,
> +    drm::{self, drv::AllocImpl, kms::private::KmsImpl as =
KmsImplPrivate},
>     error::code::*,
>     error::from_err_ptr,
>     error::Result,
> @@ -73,7 +73,7 @@ impl<T: drm::drv::Driver> Device<T> {
>         dumb_create: T::Object::ALLOC_OPS.dumb_create,
>         dumb_map_offset: T::Object::ALLOC_OPS.dumb_map_offset,
>         show_fdinfo: None,
> -        fbdev_probe: None,
> +        fbdev_probe: T::Object::ALLOC_OPS.fbdev_probe,
>=20
>         major: T::INFO.major,
>         minor: T::INFO.minor,
> @@ -153,6 +153,10 @@ pub fn data(&self) -> <T::Data as =
ForeignOwnable>::Borrowed<'_> {
>         // SAFETY: `Self::data` is always converted and set on device =
creation.
>         unsafe { <T::Data as =
ForeignOwnable>::from_foreign(drm.raw_data()) };
>     }
> +
> +    pub(crate) const fn has_kms() -> bool {
> +        <T::Kms as KmsImplPrivate>::MODE_CONFIG_OPS.is_some()
> +    }

This is what the PhantomData / NoKms idea turned into, right?

> }
>=20
> // SAFETY: DRM device objects are always reference counted and the =
get/put functions
> diff --git a/rust/kernel/drm/drv.rs b/rust/kernel/drm/drv.rs
> index e42e266bdd0da..3e09e130730f6 100644
> --- a/rust/kernel/drm/drv.rs
> +++ b/rust/kernel/drm/drv.rs
> @@ -6,14 +6,15 @@
>=20
> use crate::{
>     alloc::flags::*,
> -    bindings,
> +    bindings, device,
>     devres::Devres,
> -    drm,
> +    drm::{self, kms::private::KmsImpl as KmsImplPrivate},
>     error::{Error, Result},
>     private::Sealed,
>     str::CStr,
>     types::{ARef, ForeignOwnable},
> };
> +use core::ptr::null;
> use macros::vtable;
>=20
> /// Driver use the GEM memory manager. This should be set for all =
modern drivers.
> @@ -115,6 +116,12 @@ pub struct AllocOps {
>             offset: *mut u64,
>         ) -> core::ffi::c_int,
>> ,
> +    pub(crate) fbdev_probe: Option<
> +        unsafe extern "C" fn(
> +            fbdev_helper: *mut bindings::drm_fb_helper,
> +            sizes: *mut bindings::drm_fb_helper_surface_size,
> +        ) -> core::ffi::c_int,
> +    >,
> }
>=20
> /// Trait for memory manager implementations. Implemented internally.
> @@ -142,6 +149,14 @@ pub trait Driver {
>     /// The type used to represent a DRM File (client)
>     type File: drm::file::DriverFile;
>=20
> +    /// The KMS implementation for this driver.
> +    ///
> +    /// Drivers that wish to support KMS should pass their =
implementation of `drm::kms::KmsDriver`
> +    /// here. Drivers which do not have KMS support can simply pass =
`drm::kms::NoKms` here.

Apparently not? Where is this `NoKms` type?

> +    type Kms: drm::kms::KmsImpl<Driver =3D Self>
> +    where
> +        Self: Sized;
> +

Can=E2=80=99t we default this to `NoKms` then?

>     /// Driver metadata
>     const INFO: DriverInfo;
>=20
> @@ -159,21 +174,44 @@ pub trait Driver {
>=20
> impl<T: Driver> Registration<T> {
>     /// Creates a new [`Registration`] and registers it.
> -    pub fn new(drm: ARef<drm::device::Device<T>>, flags: usize) -> =
Result<Self> {
> +    pub fn new(dev: &device::Device, data: T::Data, flags: usize) -> =
Result<Self> {
> +        let drm =3D drm::device::Device::<T>::new(dev, data)?;
> +        let has_kms =3D drm::device::Device::<T>::has_kms();
> +
> +        let mode_config_info =3D if has_kms {

We should probably error out if we find `NoKms` here?

> +            // SAFETY: We have yet to register this device
> +            Some(unsafe { T::Kms::setup_kms(&drm)? })
> +        } else {
> +            None
> +        };
> +
>         // SAFETY: Safe by the invariants of `drm::device::Device`.
>         let ret =3D unsafe { bindings::drm_dev_register(drm.as_raw(), =
flags) };
>         if ret < 0 {
>             return Err(Error::from_errno(ret));
>         }
>=20
> +        #[cfg(CONFIG_DRM_CLIENT =3D "y")]
> +        if has_kms {
> +            if let Some(ref info) =3D mode_config_info {
> +                if let Some(fourcc) =3D info.preferred_fourcc {
> +                    // SAFETY: We just registered `drm` above, =
fulfilling the C API requirements
> +                    unsafe { =
bindings::drm_client_setup_with_fourcc(drm.as_raw(), fourcc) }
> +                } else {
> +                    // SAFETY: We just registered `drm` above, =
fulfilling the C API requirements
> +                    unsafe { bindings::drm_client_setup(drm.as_raw(), =
null()) }
> +                }
> +            }
> +        }
> +
>         Ok(Self(drm))
>     }
>     /// Same as [`Registration::new`}, but transfers ownership of the =
[`Registration`] to `Devres`.
> -    pub fn new_foreign_owned(drm: ARef<drm::device::Device<T>>, =
flags: usize) -> Result {
> -        let reg =3D Registration::<T>::new(drm.clone(), flags)?;
> +    pub fn new_foreign_owned(dev: &device::Device, data: T::Data, =
flags: usize) -> Result {
> +        let reg =3D Registration::<T>::new(dev, data, flags)?;
>=20
> -        Devres::new_foreign_owned(drm.as_ref(), reg, GFP_KERNEL)
> +        Devres::new_foreign_owned(dev, reg, GFP_KERNEL)
>     }
>=20
>     /// Returns a reference to the `Device` instance for this =
registration.
> @@ -195,5 +233,11 @@ fn drop(&mut self) {
>         // SAFETY: Safe by the invariant of =
`ARef<drm::device::Device<T>>`. The existance of this
>         // `Registration` also guarantees the this =
`drm::device::Device` is actually registered.
>         unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> +
> +        if drm::device::Device::<T>::has_kms() {
> +            // SAFETY: We just checked above that KMS was setup for =
this device, so this is safe to
> +            // call
> +            unsafe { =
bindings::drm_atomic_helper_shutdown(self.0.as_raw()) }
> +        }
>     }
> }
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 3fcab497cc2a5..605b0a22ac08b 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -300,6 +300,10 @@ impl<T: DriverObject> drv::AllocImpl for =
Object<T> {
>         gem_prime_import_sg_table: None,
>         dumb_create: None,
>         dumb_map_offset: None,
> +        #[cfg(CONFIG_DRM_FBDEV_EMULATION =3D "y")]
> +        fbdev_probe: =
Some(bindings::drm_fbdev_dma_driver_fbdev_probe),
> +        #[cfg(CONFIG_DRM_FBDEV_EMULATION =3D "n")]
> +        fbdev_probe: None,
>     };
> }
>=20
> diff --git a/rust/kernel/drm/gem/shmem.rs =
b/rust/kernel/drm/gem/shmem.rs
> index 92da0d7d59912..9c0162b268aa8 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -279,6 +279,10 @@ impl<T: DriverObject> drv::AllocImpl for =
Object<T> {
>         gem_prime_import_sg_table: =
Some(bindings::drm_gem_shmem_prime_import_sg_table),
>         dumb_create: Some(bindings::drm_gem_shmem_dumb_create),
>         dumb_map_offset: None,
> +        #[cfg(CONFIG_DRM_FBDEV_EMULATION =3D "y")]
> +        fbdev_probe: =
Some(bindings::drm_fbdev_shmem_driver_fbdev_probe),
> +        #[cfg(CONFIG_DRM_FBDEV_EMULATION =3D "n")]
> +        fbdev_probe: None,
>     };
> }
>=20
> diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
> new file mode 100644
> index 0000000000000..78970c69f4cda
> --- /dev/null
> +++ b/rust/kernel/drm/kms.rs
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! KMS driver abstractions for rust.
> +
> +use crate::{
> +    device,
> +    drm::{device::Device, drv::Driver},
> +    error::to_result,
> +    prelude::*,
> +    types::*,
> +};
> +use bindings;
> +use core::{marker::PhantomData, ops::Deref};
> +
> +/// The C vtable for a [`Device`].
> +///
> +/// This is created internally by DRM.
> +pub struct ModeConfigOps {
> +    pub(crate) kms_vtable: bindings::drm_mode_config_funcs,
> +    pub(crate) kms_helper_vtable: =
bindings::drm_mode_config_helper_funcs,
> +}
> +
> +/// A trait representing a type that can be used for setting up KMS, =
or a stub.
> +///
> +/// For drivers which don't have KMS support, the methods provided by =
this trait may be stubs. It is
> +/// implemented internally by DRM.
> +pub trait KmsImpl: private::KmsImpl {}
> +
> +pub(crate) mod private {
> +    use super::*;
> +
> +    /// Private callback implemented internally by DRM for setting up =
KMS on a device, or stubbing
> +    /// the KMS setup for devices which don't have KMS support.
> +    #[allow(unreachable_pub)]
> +    pub trait KmsImpl {
> +        /// The parent driver for this KMS implementation
> +        type Driver: Driver;
> +
> +        /// The optional KMS callback operations for this driver.
> +        const MODE_CONFIG_OPS: Option<ModeConfigOps>;
> +
> +        /// The callback for setting up KMS on a device
> +        ///
> +        /// # Safety
> +        ///
> +        /// `drm` must be unregistered.
> +        unsafe fn setup_kms(_drm: &Device<Self::Driver>) -> =
Result<ModeConfigInfo> {
> +            build_error::build_error("This should never be =
reachable")
> +        }
> +    }
> +}
> +
> +/// A [`Device`] with KMS initialized that has not been registered =
with userspace.
> +///
> +/// This type is identical to [`Device`], except that it is able to =
create new static KMS resources.
> +/// It represents a KMS device that is not yet visible to userspace, =
and also contains miscellaneous
> +/// state required during the initialization process of a [`Device`].
> +pub struct UnregisteredKmsDevice<'a, T: Driver> {
> +    drm: &'a Device<T>,
> +}

Can you expand the commit message with how you plan to use this type in =
the
future? For now it's merely a wrapper that exposes the wrapped type =
through
deref, so if you planned to disable some features while the device is in =
the
"unregistered" state, then this does not do it.

IOW: why can't create_objects() take the DRM device directly? IMHO that =
should
appear in the commit message.

> +
> +impl<'a, T: Driver> Deref for UnregisteredKmsDevice<'a, T> {
> +    type Target =3D Device<T>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.drm
> +    }
> +}
> +
> +impl<'a, T: Driver> UnregisteredKmsDevice<'a, T> {
> +    /// Construct a new [`UnregisteredKmsDevice`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller promises that `drm` is an unregistered [`Device`].
> +    pub(crate) unsafe fn new(drm: &'a Device<T>) -> Self {
> +        Self { drm }
> +    }
> +}
> +
> +/// A trait which must be implemented by drivers that wish to support =
KMS
> +///
> +/// It should be implemented for the same type that implements =
[`Driver`]. Drivers which don't
> +/// support KMS should use [`PhantomData<Self>`].
> +///
> +/// [`PhantomData<Self>`]: PhantomData

Ok we still have both the PhantomData and the NoKms thing going on at =
the same
time :/

> +#[vtable]
> +pub trait KmsDriver: Driver {
> +    /// Return a [`ModeConfigInfo`] structure for this =
[`device::Device`].
> +    fn mode_config_info(
> +        dev: &device::Device,
> +        drm_data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
> +    ) -> Result<ModeConfigInfo>;
> +
> +    /// Create mode objects like [`crtc::Crtc`], [`plane::Plane`], =
etc. for this device
> +    fn create_objects(drm: &UnregisteredKmsDevice<'_, Self>) -> =
Result
> +    where
> +        Self: Sized;
> +}

Same comment as last time, this function needs better docs. It says =
`create
mode objects [..]` but nothing is returned. What exactly should happen?

The fact that I don't know much about KMS is actually a bonus in this
particular case, because it highlights that you probably depend on some
previous knowledge that is not stated explicitly in the docs.

At the very least you should tell drivers how to attach the objects to =
the drm
device (if that is how it works) and also point to the relevant C docs.

> +
> +impl<T: KmsDriver> private::KmsImpl for T {
> +    type Driver =3D Self;
> +
> +    const MODE_CONFIG_OPS: Option<ModeConfigOps> =3D =
Some(ModeConfigOps {
> +        kms_vtable: bindings::drm_mode_config_funcs {
> +            atomic_check: Some(bindings::drm_atomic_helper_check),
> +            fb_create: Some(bindings::drm_gem_fb_create),
> +            mode_valid: None,
> +            atomic_commit: Some(bindings::drm_atomic_helper_commit),
> +            get_format_info: None,
> +            atomic_state_free: None,
> +            atomic_state_alloc: None,
> +            atomic_state_clear: None,
> +        },
> +
> +        kms_helper_vtable: bindings::drm_mode_config_helper_funcs {
> +            atomic_commit_setup: None,
> +            atomic_commit_tail: None,
> +        },
> +    });
> +
> +    unsafe fn setup_kms(drm: &Device<Self::Driver>) -> =
Result<ModeConfigInfo> {
> +        let mode_config_info =3D T::mode_config_info(drm.as_ref(), =
drm.data())?;
> +
> +        // SAFETY: `MODE_CONFIG_OPS` is always Some() in this =
implementation
> +        let ops =3D unsafe { =
T::MODE_CONFIG_OPS.as_ref().unwrap_unchecked() };
> +
> +        // SAFETY:
> +        // - This function can only be called before registration via =
our safety contract.
> +        // - Before registration, we are the only ones with access to =
this device.
> +        unsafe {
> +            (*drm.as_raw()).mode_config =3D bindings::drm_mode_config =
{
> +                funcs: &ops.kms_vtable,
> +                helper_private: &ops.kms_helper_vtable,
> +                min_width: mode_config_info.min_resolution.0,
> +                min_height: mode_config_info.min_resolution.1,
> +                max_width: mode_config_info.max_resolution.0,
> +                max_height: mode_config_info.max_resolution.1,
> +                cursor_width: mode_config_info.max_cursor.0,
> +                cursor_height: mode_config_info.max_cursor.1,
> +                preferred_depth: mode_config_info.preferred_depth,
> +                ..Default::default()
> +            };
> +        }
> +
> +        // SAFETY: We just setup all of the required info this =
function needs in `drm_device`
> +        to_result(unsafe { =
bindings::drmm_mode_config_init(drm.as_raw()) })?;
> +
> +        // SAFETY: `drm` is guaranteed to be unregistered via our =
safety contract.
> +        let drm =3D unsafe { UnregisteredKmsDevice::new(drm) };
> +
> +        T::create_objects(&drm)?;
> +
> +        // TODO: Eventually add a hook to customize how state =
readback happens, for now just reset
> +        // SAFETY: Since all static modesetting objects were created =
in `T::create_objects()`, and
> +        // that is the only place they can be created, this fulfills =
the C API requirements.
> +        unsafe { bindings::drm_mode_config_reset(drm.as_raw()) };
> +
> +        Ok(mode_config_info)
> +    }
> +}
> +
> +impl<T: KmsDriver> KmsImpl for T {}
> +
> +impl<T: Driver> private::KmsImpl for PhantomData<T> {
> +    type Driver =3D T;
> +
> +    const MODE_CONFIG_OPS: Option<ModeConfigOps> =3D None;
> +}
> +
> +impl<T: Driver> KmsImpl for PhantomData<T> {}
> +
> +/// Various device-wide information for a [`Device`] that is provided =
during initialization.
> +#[derive(Copy, Clone)]
> +pub struct ModeConfigInfo {
> +    /// The minimum (w, h) resolution this driver can support
> +    pub min_resolution: (i32, i32),
> +    /// The maximum (w, h) resolution this driver can support
> +    pub max_resolution: (i32, i32),
> +    /// The maximum (w, h) cursor size this driver can support
> +    pub max_cursor: (u32, u32),
> +    /// The preferred depth for dumb ioctls
> +    pub preferred_depth: u32,
> +    /// An optional default fourcc format code to be preferred for =
clients.
> +    pub preferred_fourcc: Option<u32>,
> +}
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> index 2c12dbd181997..049ae675cb9b1 100644
> --- a/rust/kernel/drm/mod.rs
> +++ b/rust/kernel/drm/mod.rs
> @@ -8,3 +8,4 @@
> pub mod fourcc;
> pub mod gem;
> pub mod ioctl;
> +pub mod kms;
> --=20
> 2.48.1
>=20
>=20

=E2=80=94 Daniel


