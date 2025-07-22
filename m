Return-Path: <linux-kernel+bounces-741085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA898B0DFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2974188E5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0E2ECEB9;
	Tue, 22 Jul 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMb1KFi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E402ECEAB;
	Tue, 22 Jul 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196491; cv=none; b=aOqOXiEFyrrtbZqJEPZgvM5iGnhuF5JTsH5hJZA/dFKLIbsLPLtC0V7PGaXQpRu2CTiYMgnqfaWki/dmiKRqfl+e1vQ9/BxlnBEXU74oK4J8AxnMUj5B+ZFBUU21jL/r1b7hJ42xw4MN2uMQvKN+R4n1tELEX2WrPmSs5wn2Z70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196491; c=relaxed/simple;
	bh=cZJQooCjCy4KF7VmqkC4rIymUInoRT314LZ1r8AK4Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffHzuqhKcVLEH7Ftau+HNZI/2A/rWu+5rBWaP6AH73YqdQ6VzO6sL0ZwyUHe28ayWju1CHalGPe9COY0uqlszj8DTt6epFhot50dcKpLbiXPEKqhihXOW8NbCpgTqxbkoZgzkyScMG02XujstAIMLfaMo7/fTQ+2jYoOvjum/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMb1KFi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43BFC4CEF6;
	Tue, 22 Jul 2025 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196490;
	bh=cZJQooCjCy4KF7VmqkC4rIymUInoRT314LZ1r8AK4Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MMb1KFi6BiYCo6N3hjauUkvLKcJosMdskKRmTkIuWX+Dbkn0AjwXdXMkSLcx6Wd0+
	 hKJ01sQATRlzNAmmHRsyc/QIM9oQ2NzsvAxbbAHnQlVugdGVCFHb6xr+Kk/OXUGn70
	 HeSGCfLiT2f2G/xwdX87FrNnMyZMsWZZKMqS7QzHhLU3hNvN4VVRxDmFMG8VG5QACP
	 FDMnVFYU0NncsgmSJWl0UsI7KhxE+PigBXRh0AwtCFSHd6vSRbp6/qPEnvb0XtATN3
	 RLndET21iwi5K4KKnRlvQ7yaUfEos4Ex/XfvkLB1p6aVrSQclMXMSpb9/MSmailo9z
	 +iOygu3Gpr7VQ==
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
Subject: [PATCH v2 3/3] driver: rust: expand documentation for driver infrastructure
Date: Tue, 22 Jul 2025 17:00:01 +0200
Message-ID: <20250722150110.23565-4-dakr@kernel.org>
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

Add documentation about generic driver infrastructure, representing a
guideline on how the generic driver infrastructure is intended to be
used to implement bus specific driver APIs.

This covers aspects such as the bus specific driver trait, adapter
implementation, driver registration and custom device ID types.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/driver.rs | 89 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index a8f2675ba7a7..279e3af20682 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -2,8 +2,93 @@
 
 //! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
 //!
-//! Each bus / subsystem is expected to implement [`RegistrationOps`], which allows drivers to
-//! register using the [`Registration`] class.
+//! This documentation describes how to implement a bus specific driver API and how to align it with
+//! the design of (bus specific) devices.
+//!
+//! Note: Readers are expected to know the content of the documentation of [`Device`] and
+//! [`DeviceContext`].
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
+//! For specific examples see [`auxiliary::Driver`], [`pci::Driver`] and [`platform::Driver`].
+//!
+//! The `probe()` callback should return a `Result<Pin<KBox<Self>>>`, i.e. the driver's private
+//! data. The bus abstraction should store the pointer in the corresponding bus device. The generic
+//! [`Device`] infrastructure provides common helpers for this purpose on its
+//! [`Device<CoreInternal>`] implementation.
+//!
+//! All driver callbacks should provide a reference to the driver's private data. Once the driver
+//! is unbound from the device, the bus abstraction should take back the ownership of the driver's
+//! private data from the corresponding [`Device`] and [`drop`] it.
+//!
+//! All driver callbacks should provide a [`Device<Core>`] reference (see also [`device::Core`]).
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
+//! The generic driver infrastructure provides a helper for this with the [`module_driver`] macro.
+//!
+//! # Device IDs
+//!
+//! Besides the common device ID types, such as [`of::DeviceId`] and [`acpi::DeviceId`], most buses
+//! may need to implement their own device ID types.
+//!
+//! For this purpose the generic infrastructure in [`device_id`] should be used.
+//!
+//! [`auxiliary::Driver`]: kernel::auxiliary::Driver
+//! [`Core`]: device::Core
+//! [`Device`]: device::Device
+//! [`Device<Core>`]: device::Device<device::Core>
+//! [`Device<CoreInternal>`]: device::Device<device::CoreInternal>
+//! [`DeviceContext`]: device::DeviceContext
+//! [`device_id`]: kernel::device_id
+//! [`module_driver`]: kernel::module_driver
+//! [`pci::Driver`]: kernel::pci::Driver
+//! [`platform::Driver`]: kernel::platform::Driver
 
 use crate::error::{Error, Result};
 use crate::{acpi, device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
-- 
2.50.0


