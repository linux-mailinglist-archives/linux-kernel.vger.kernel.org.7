Return-Path: <linux-kernel+bounces-741084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92547B0DFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB95D3B7F15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88990273815;
	Tue, 22 Jul 2025 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTlZEkBr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51942ECE89;
	Tue, 22 Jul 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196487; cv=none; b=XSOJN52YsWtx6JpYSjdvc6rITWSYOihFrGq4OInMim+LmL8pH6+xrI55KFQ6o5FVnLI23UGIx7jp9+k5wNRCIWikXxf5ihJITjFuDhBOpHuy3vNn4Iw1g3b4fZG5zb6D00ChBdEBEpwS0AITCJAEzqBfSPQhtQhPRVLpI/Utdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196487; c=relaxed/simple;
	bh=y/u2dKefOvvJa3r/lkuSNuJJvDKeMjJ5Xk8vtaghlOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcXLuTW1/2tpUlOakND+EHm3vkPSupbEQl9j7WSJRST//hgVfwCMMzNwetxW7blv0KZO6N9Bpf8Zn+tS6SdAjFXwy44WziiN4fsLwb0orX+15+0uaZ/PgJyOoD/tnrQgT3G8HkQ2Zugm6r1Vyv65Ah7k/xXFVJHgcJ14iv+auMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTlZEkBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59300C4CEEB;
	Tue, 22 Jul 2025 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196487;
	bh=y/u2dKefOvvJa3r/lkuSNuJJvDKeMjJ5Xk8vtaghlOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTlZEkBr0B5DmXKpWTIa1jL2lvpO5odXosuLAB12tXZbDPJN6t9d70yZbYQO3MO/q
	 EDGWFy33TYI4JTg5H+35dDsoV91zHo5CNs15hTWMUgleTphmbgCkAKcoN3o5GLDBYf
	 fg1pcdZnFn0exu7fE31C4HNO2DqALAJ2WEtdrEtZIvoXvqiBMcndfUga1VxKp88Tr5
	 e5yvi3DuroC9e/9gNftErQEOSpTrC73rzkyt8e41gXewt1DICOx3YI2xuv8s8ps65B
	 8LiZD7GNE7VIqd1ZnG5juZL3ZwN7Naoebu2rQ4TVllmg4i57PlTpkN67njBEy1Vzc3
	 N1S+znwoptyeg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 2/3] device: rust: expand documentation for Device
Date: Tue, 22 Jul 2025 17:00:00 +0200
Message-ID: <20250722150110.23565-3-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722150110.23565-1-dakr@kernel.org>
References: <20250722150110.23565-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for the generic Device type is outdated and deserves
much more detail.

Hence, expand the documentation and cover topics such as device types,
device contexts, as well as information on how to use the generic device
infrastructure to implement bus and class specific device types.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 139 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 126 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index f5d1db568f00..9cc35ea6db98 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -15,23 +15,130 @@
 
 pub mod property;
 
-/// A reference-counted device.
+/// The core representation of a device in the kernel's driver model.
 ///
-/// This structure represents the Rust abstraction for a C `struct device`. This implementation
-/// abstracts the usage of an already existing C `struct device` within Rust code that we get
-/// passed from the C side.
+/// This structure represents the Rust abstraction for a C `struct device`. A [`Device`] can either
+/// exist as temporary reference (see also [`Device::from_raw`]), which is only valid within a
+/// certain scope or as [`ARef<Device>`], owning a dedicated reference count.
 ///
-/// An instance of this abstraction can be obtained temporarily or permanent.
+/// # Device Types
 ///
-/// A temporary one is bound to the lifetime of the C `struct device` pointer used for creation.
-/// A permanent instance is always reference-counted and hence not restricted by any lifetime
-/// boundaries.
+/// A [`Device`] can represent either a bus device or a class device.
 ///
-/// For subsystems it is recommended to create a permanent instance to wrap into a subsystem
-/// specific device structure (e.g. `pci::Device`). This is useful for passing it to drivers in
-/// `T::probe()`, such that a driver can store the `ARef<Device>` (equivalent to storing a
-/// `struct device` pointer in a C driver) for arbitrary purposes, e.g. allocating DMA coherent
-/// memory.
+/// ## Bus Devices
+///
+/// A bus device is a [`Device`] that is associated with a physical or virtual bus. Examples of
+/// buses include PCI, USB, I2C, and SPI. Devices attached to a bus are registered with a specific
+/// bus type, which facilitates matching devices with appropriate drivers based on IDs or other
+/// identifying information. Bus devices are visible in sysfs under `/sys/bus/<bus-name>/devices/`.
+///
+/// ## Class Devices
+///
+/// A class device is a [`Device`] that is associated with a logical category of functionality
+/// rather than a physical bus. Examples of classes include block devices, network interfaces, sound
+/// cards, and input devices. Class devices are grouped under a common class and exposed to
+/// userspace via entries in `/sys/class/<class-name>/`.
+///
+/// # Device Context
+///
+/// [`Device`] references are generic over a [`DeviceContext`], which represents the type state of
+/// a [`Device`].
+///
+/// As the name indicates, this type state represents the context of the scope the [`Device`]
+/// reference is valid in. For instance, the [`Bound`] context guarantees that the [`Device`] is
+/// bound to a driver for the entire duration of the existence of a [`Device<Bound>`] reference.
+///
+/// Other [`DeviceContext`] types besides [`Bound`] are [`Normal`], [`Core`] and [`CoreInternal`].
+///
+/// Unless selected otherwise [`Device`] defaults to the [`Normal`] [`DeviceContext`], which by
+/// itself has no additional requirements.
+///
+/// It is always up to the caller of [`Device::from_raw`] to select the correct [`DeviceContext`]
+/// type for the corresponding scope the [`Device`] reference is created in.
+///
+/// All [`DeviceContext`] types other than [`Normal`] are intended to be used with
+/// [bus devices](#bus-devices) only.
+///
+/// # Implementing Bus Devices
+///
+/// This section provides a guideline to implement bus specific devices, such as [`pci::Device`] or
+/// [`platform::Device`].
+///
+/// A bus specific device should be defined as follows.
+///
+/// ```ignore
+/// #[repr(transparent)]
+/// pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+///     Opaque<bindings::bus_device_type>,
+///     PhantomData<Ctx>,
+/// );
+/// ```
+///
+/// Since devices are reference counted, [`AlwaysRefCounted`] should be implemented for `Device`
+/// (i.e. `Device<Normal>`). Note that [`AlwaysRefCounted`] must not be implemented for any other
+/// [`DeviceContext`], since all other device context types are only valid in a certain scope.
+///
+/// In order to be able to implement the [`DeviceContext`] dereference hierarchy, bus device
+/// implementations should call the [`impl_device_context_deref`] macro as shown below.
+///
+/// ```ignore
+/// // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s
+/// // generic argument.
+/// kernel::impl_device_context_deref!(unsafe { Device });
+/// ```
+/// In order to convert from a any [`Device<Ctx>`] to [`ARef<Device>`], bus devices can implement
+/// the following macro call.
+///
+/// ```ignore
+/// kernel::impl_device_context_into_aref!(Device);
+/// ```
+/// Bus devices should also implement the following [`AsRef`] implementation, such that users can
+/// easily derive a generic [`Device`] reference.
+///
+/// ```ignore
+/// impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+///     fn as_ref(&self) -> &device::Device<Ctx> {
+///         ...
+///     }
+/// }
+/// ```
+///
+/// # Implementing Class Devices
+///
+/// Class device implementations require less infrastructure and depend slightly more on the
+/// specific subsystem.
+///
+/// An example implementation for a class device could look like this.
+///
+/// ```ignore
+/// #[repr(C)]
+/// #[pin_data]
+/// pub struct Device<T: class::Driver> {
+///     dev: Opaque<bindings::class_device_type>,
+///     #[pin]
+///     data: T::Data,
+/// }
+/// ```
+///
+/// This class device uses the sub-classing pattern to embed the driver's private data within the
+/// allocation of the class device. For this to be possible the class device is generic over the
+/// class specific `Driver` trait implementation.
+///
+/// Just like any device, class devices are reference counted and should hence implement
+/// [`AlwaysRefCounted`] for `Device`.
+///
+/// Class devices should also implement the following [`AsRef`] implementation, such that users can
+/// easily derive a generic [`Device`] reference.
+///
+/// ```ignore
+/// impl<T: class::Driver> AsRef<device::Device> for Device<T> {
+///     fn as_ref(&self) -> &device::Device {
+///         ...
+///     }
+/// }
+/// ```
+///
+/// An example for a class device implementation is [`drm::Device`].
 ///
 /// # Invariants
 ///
@@ -42,6 +149,12 @@
 ///
 /// `bindings::device::release` is valid to be called from any thread, hence `ARef<Device>` can be
 /// dropped from any thread.
+///
+/// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
+/// [`drm::Device`]: kernel::drm::Device
+/// [`impl_device_context_deref`]: kernel::impl_device_context_deref
+/// [`pci::Device`]: kernel::pci::Device
+/// [`platform::Device`]: kernel::platform::Device
 #[repr(transparent)]
 pub struct Device<Ctx: DeviceContext = Normal>(Opaque<bindings::device>, PhantomData<Ctx>);
 
-- 
2.50.0


