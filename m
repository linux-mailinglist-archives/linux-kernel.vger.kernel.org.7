Return-Path: <linux-kernel+bounces-736037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7075B09706
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4495718814D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A371246793;
	Thu, 17 Jul 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqvnImvn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288A246761;
	Thu, 17 Jul 2025 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792507; cv=none; b=gP2OHWHqC3FWiXN8nGFBQLX6GTTDNSdjFmGGiV7B0ORWkCW0AiwEF37jHCBNJp8zTKvvCl+H3Abzvh21LobGrIE8fWL6PJ2O+KG/tejPsQCi6Fm3b8YqCj9tuvFlpgEPlmEeJgt9TG+pT858nTJTc68eNxSi0I0vcGTOZ5Wl4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792507; c=relaxed/simple;
	bh=Psy3Z91cjDmHHJS7M86ndvJxDQH2Gx0mX4Zz1cgIEcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAzQ5QU+GsUO8k4K52u0H/1kIFZDKrSdbKt7AoMowq5yJMtvZjgiyXzCUufuQ/Znt7PRtP3OXnCKn73XbS70AFGGrHbXGaD8coDjb98F1D772DS++Zt7Oe1sb9SRDnDcvrz8O/ZzpfVmp/amQ69DTGdmGhfQKRWtppxTZfPpmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqvnImvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C164C4CEE3;
	Thu, 17 Jul 2025 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752792507;
	bh=Psy3Z91cjDmHHJS7M86ndvJxDQH2Gx0mX4Zz1cgIEcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqvnImvnSer1Gge6lQzqMDGq8GzgNy5m1m0ykGAR9OwsR+dOGP3K/IKZoNFMsnsco
	 9suPF5g80A7LwFlq857f8rNCl/nJ0lbUOZQDNGtxIkSojG88Zl5MS4HK2x+GZBL+FF
	 +REFhPtdTDpkl3cQc7TnKlKRa/fWsNyqWMyDpMghmF6BZ+0VfTdRbhkoqn/RYlUvNR
	 c9rpUe8XKcrCo5JMa/AN+pqgAJF0NLjGN5D7ewIEWZd4T1bc1+5lQTGgc2muRSWxVX
	 3UG1KmgyXNqbeLT3LyfqujUg2rFXCvuwTuDi4qmzy6igag+u3ZTgTlAGXRwpUilPla
	 /w/IhPz0gIdpg==
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/3] driver: rust: expand documentation for driver infrastructure
Date: Fri, 18 Jul 2025 00:45:39 +0200
Message-ID: <20250717224806.54763-4-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717224806.54763-1-dakr@kernel.org>
References: <20250717224806.54763-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation about generic driver infrastructure, representing a
guideline on how the generic driver infrastructure is intended to be
used to implement bus specific driver APIs.

This covers aspects such as the bus specific driver trait, adapter
implementation, driver registration and custom device ID types.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 82 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index a8f2675ba7a7..0bb80ad7aea4 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -2,8 +2,86 @@
 
 //! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
 //!
-//! Each bus / subsystem is expected to implement [`RegistrationOps`], which allows drivers to
-//! register using the [`Registration`] class.
+//! This documentation describes how to implement a bus specific driver API and how to align it with
+//! the design of (bus specific) devices.
+//!
+//! Note: Readers are expected to know the content of the documentation of
+//! [`Device`](device::Device) and [`device::DeviceContext`].
+//!
+//! # Driver Trait
+//!
+//! The main driver interface is defined by a bus specific driver trait. For instance:
+//!
+//! ```ignore
+//! pub trait Driver: Send {
+//!     /// The type holding information about each device ID supported by the driver.
+//!     type IdInfo: 'static;
+//!
+//!     /// The table of OF device ids supported by the driver.
+//!     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+//!
+//!     /// The table of ACPI device ids supported by the driver.
+//!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
+//!
+//!     /// Driver probe.
+//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>;
+//!
+//!     /// Driver unbind (optional).
+//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+//!         let _ = (dev, this);
+//!     }
+//! }
+//! ```
+//!
+//! For specific examples see [`pci::Driver`](kernel::pci::Driver),
+//! [`platform::Driver`](kernel::platform::Driver) and
+//! [`auxiliary::Driver`](kernel::auxiliary::Driver).
+//!
+//! The `probe()` callback should return a `Result<Pin<KBox<Self>>>`, i.e. the driver's private
+//! data. The bus abstraction should store the pointer in the corresponding bus device. The generic
+//! [`Device`](device::Device) infrastructure provides common helpers for this purpose on its
+//! [`Device<CoreInternal>`](device::Device<device::CoreInternal>) implementation.
+//!
+//! All driver callbacks should provide a reference to the driver's private data. Once the driver
+//! is unbound from the device, the bus abstraction should take back the ownership of the driver's
+//! private data from the corresponding [`Device`](device::Device) and [`drop`] it.
+//!
+//! All driver callbacks should provide a [`Device<Core>`](device::Device<device::Core>) reference
+//! (see also [`device::Core`]).
+//!
+//! # Adapter
+//!
+//! The adapter implementation of a bus represents the abstraction layer between the C bus
+//! callbacks and the Rust bus callbacks. It therefore has to be generic over an implementation of
+//! the [driver trait](#driver-trait).
+//!
+//! ```ignore
+//! pub struct Adapter<T: Driver>;
+//! ```
+//!
+//! There's a common [`Adapter`] trait that can be implemented to inherit common driver
+//! infrastructure, such as finding the ID info from an [`of::IdTable`] or [`acpi::IdTable`].
+//!
+//! # Driver Registration
+//!
+//! In order to register C driver types (such as `struct platform_driver`) the [adapter](#adapter)
+//! should implement the [`RegistrationOps`] trait.
+//!
+//! This trait implementation can be used to create the actual registration with the common
+//! [`Registration`] type.
+//!
+//! Typically, bus abstractions want to provide a bus specific `module_bus_driver!` macro, which
+//! creates a kernel module with exactly one [`Registration`] for the bus specific adapter.
+//!
+//! The generic driver infrastructure provides a helper for this with the
+//! [`module_driver`](kernel::module_driver) macro.
+//!
+//! # Device IDs
+//!
+//! Besides the common device ID types, such as [`of::DeviceId`] and [`acpi::DeviceId`], most buses
+//! may need to implement their own device ID types.
+//!
+//! For this purpose the generic infrastructure in [`device_id`](kernel::device_id) should be used.
 
 use crate::error::{Error, Result};
 use crate::{acpi, device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
-- 
2.50.0


