Return-Path: <linux-kernel+bounces-677985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C233AD2291
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 17:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80ED83A829F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442A20F093;
	Mon,  9 Jun 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DO1qxVD8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77917CA5A;
	Mon,  9 Jun 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483257; cv=pass; b=A2qSQKJ7CPW/YtVYqWFnn9qzmqUJsHqcuKbOKIs4BG3OHtZ+BxaXvr+M7qfGPl1vUA528gJ29suXrpYIJicxWzmAcGNoJfsGeRMBvGUORLAYLzld7jNi9Jb/rnYezRIs/mX+a/iyEA24Rj5tib9k6qiRhFY9QQ8leGVJ8ycUEQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483257; c=relaxed/simple;
	bh=1BqzNPxMt9/gkbcje/zlXSLeq4wK6DFQDIBKbIQdUmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mllQfL3FrXj75dRPheKHSLLOWHqW+zkni7Gw6JZHQrU99YUlYWzfRfGhFzps1wNAY7I2lvN3er6zCIKSKbeG6OgNa05RLIcLTx8uf/+DAYR/ycxPYxKboZbxfdn0u9b/MJgDSAi1etzHUBWcxziRNrMCSz1Fszs+OUBsyjaEEgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DO1qxVD8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749483222; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aFnVZlnK3FbmJfw0XCCibnWYty2xX0+jqlOI5Hrhn23NvteJBeFBOr5XPlhgACpEsNdEMh93D0zfJArzePlesx/VrhXw4O5kzQcFC+pynJIgTTsRuOv2pdeO5ssSz/KSSqS2Qmv0tWeMr0fv6KJt0sxE879Wa7RUHzI8/VsKYno=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749483222; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5jEa0sa6+DP0Fzqbkr5XEmDbgA41/sJSoK2RJXNgpno=; 
	b=Cb7BSSXPpgY5LbTxneXLHjequA0vT4jRjHCTA2yyowRmAObII/RPQDW+r0y3igjOLj53YBw4YrkO5+/CEvDZ/45QFXh//ktUo5B5Uv4cAQe0gpTdZsCzyFQ23ep8tXbGnCkWocxY+ukOkmuI0s5h3F1vZgDdnq4kgu0+Fw2dw7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749483222;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=5jEa0sa6+DP0Fzqbkr5XEmDbgA41/sJSoK2RJXNgpno=;
	b=DO1qxVD83qSG7gY02yxUIRQXVwZm7KATcmvCQU17K/rQRdLFENcpfDbSOxrBKC4j
	wxPHMUlDq7AgF6tQqlJuujWQO7KP07Dd1e0gtl33EBFnLxQy6zxo8MIEPLsMHHi5+1t
	cA0LttMGtmVKwoDGZqDmO9yayrXsq+yX9vjJpP1s=
Received: by mx.zohomail.com with SMTPS id 174948322052335.94351856109415;
	Mon, 9 Jun 2025 08:33:40 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 09 Jun 2025 12:32:38 -0300
Subject: [PATCH v4] rust: regulator: add a bare minimum regulator
 abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-topics-tyr-regulator-v4-1-b4fdcf1385a7@collabora.com>
X-B4-Tracking: v=1; b=H4sIAJX+RmgC/4XOQW7DIBCF4atErIsFg41JV71H1cUYxjESNtHgW
 o0i3704m0itqi7fYr7576IQRyri9XQXTFssMS91tC8n4SdcLiRjqFuAgk4ZsHLN1+iLXG8smS6
 fCdfMktxwdqN1VoVe1NMr0xi/Huz7R90j51muExM+MdBnbaHTfQO9MxaklgGXSKnBNFMM+OZzS
 jhkxsbn+WCnWOq32yN2gwP/p2s7VK8ILTqrB7I/zKNtM0+o0+YPyFSo9R561YaR/C9o3/dvx9p
 yR0wBAAA=
X-Change-ID: 20250326-topics-tyr-regulator-e8b98f6860d7
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Add a bare minimum regulator abstraction to be used by Rust drivers.
This abstraction adds a small subset of the regulator API, which is
thought to be sufficient for the drivers we have now.

Regulators provide the power needed by many hardware blocks and thus are
likely to be needed by a lot of drivers.

It was tested on rk3588, where it was used to power up the "mali"
regulator in order to power up the GPU.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Changes in v4:
- Rewrote the abstraction to use typestates as per the suggestions by
  Benno and Alex.
- Introduced the `Dynamic` state.
- Added more examples.
- Fixed some broken docs.
- Link to v3: https://lore.kernel.org/r/20250513-topics-tyr-regulator-v3-1-4cc2704dfec6@collabora.com

Changes in v3:
- Rebased on rust-next
- Added examples to showcase the API
- Fixed some rendering issues in the docs
- Exposed {get|set}_voltage for both Regulator and EnabledRegulator
- Derived Clone, Copy, PartialEq and Eq for Microvolt
- Link to v2: https://lore.kernel.org/r/20250326-topics-tyr-regulator-v2-1-c0ea6a861be6@collabora.com

Resend v2:
  - cc Regulator maintainers
Changes from v1:
  - Rebased on rust-next
  - Split the design into two types as suggested by Alice Ryhl.
  - Modify the docs to highlight how users can use kernel::types::Either
    or an enum to enable and disable the regulator at runtime.
  - Link to v1: https://lore.kernel.org/rust-for-linux/20250219162517.278362-1-daniel.almeida@collabora.com/
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/regulator.rs        | 385 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70d52e69b754bf855bc19911d156d8..e14cce03338ef5f6a09a23fd41ca47b8c913fa65 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,6 +31,7 @@
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/slab.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 28007be98fbad0e875d7e5345e164e2af2c5da32..c8fd7e4e036e9e5b6958acf0dcfa952b916a3d48 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -86,6 +86,8 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+#[cfg(CONFIG_REGULATOR)]
+pub mod regulator;
 pub mod revocable;
 pub mod security;
 pub mod seq_file;
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
new file mode 100644
index 0000000000000000000000000000000000000000..338fc653c32b49e630ecb6a320ac26aea973cd64
--- /dev/null
+++ b/rust/kernel/regulator.rs
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Regulator abstractions, providing a standard kernel interface to control
+//! voltage and current regulators.
+//!
+//! The intention is to allow systems to dynamically control regulator power
+//! output in order to save power and prolong battery life. This applies to both
+//! voltage regulators (where voltage output is controllable) and current sinks
+//! (where current limit is controllable).
+//!
+//! C header: [`include/linux/regulator/consumer.h`](srctree/include/linux/regulator/consumer.h)
+//!
+//! Regulators are modeled in Rust with a collection of states. Each state may
+//! enforce a given invariant, and they may convert between each other where applicable.
+//!
+//! See [`Voltage and current regulator API`]("https://docs.kernel.org/driver-api/regulator.html")
+//! for more information.
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    prelude::*,
+};
+
+use core::{marker::PhantomData, ptr::NonNull};
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Enabled {}
+    impl Sealed for super::Disabled {}
+    impl Sealed for super::Dynamic {}
+}
+
+/// A trait representing the different states a [`Regulator`] can be in.
+pub trait RegulatorState: private::Sealed {}
+
+/// A state where the [`Regulator`] is known to be enabled.
+pub struct Enabled;
+
+/// A state where this [`Regulator`] handle has not specifically asked for the
+/// underlying regulator to be enabled. This means that this reference does not
+/// own an `enable` reference count, but the regulator may still be on.
+pub struct Disabled;
+
+/// A state that models the C API. The [`Regulator`] can be either enabled or
+/// disabled, and the user is in control of the reference count. This is also
+/// the default state.
+///
+/// Use [`Regulator::is_enabled`] to check the regulator's current state.
+pub struct Dynamic;
+
+impl RegulatorState for Enabled {}
+impl RegulatorState for Disabled {}
+impl RegulatorState for Dynamic {}
+
+/// A trait that abstracts the conversion of a [`Regulator`] to an enabled state.
+pub trait TryIntoEnabled: RegulatorState {}
+impl TryIntoEnabled for Disabled {}
+
+/// A trait that abstracts the conversion of a [`Regulator`] to a disabled state.
+pub trait TryIntoDisabled: RegulatorState {}
+impl TryIntoDisabled for Enabled {}
+
+/// A trait that abstracts the ability to check if a [`Regulator`] is enabled.
+pub trait IsEnabled: RegulatorState {}
+impl IsEnabled for Disabled {}
+impl IsEnabled for Dynamic {}
+
+/// An error that can occur when trying to convert a [`Regulator`] between states.
+pub struct Error<State: RegulatorState + 'static> {
+    /// The error that occurred.
+    pub error: kernel::error::Error,
+    /// The regulator that caused the error, so that the operation may be retried.
+    pub regulator: Regulator<State>,
+}
+
+/// A `struct regulator` abstraction.
+///
+/// # Examples
+///
+/// Enabling a regulator:
+///
+/// This example uses [`Regulator<Enabled>`], which is suitable for drivers that
+/// enable a regulator at probe time and leave them on until the device is
+/// removed or otherwise shutdown.
+///
+/// These users can store [`Regulator<Enabled>`] directly in their driver's
+/// private data struct.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::c_str;
+/// # use kernel::device::Device;
+/// # use kernel::regulator::{Microvolt, Regulator, Disabled, Enabled};
+/// fn enable(dev: &Device, min_uv: Microvolt, max_uv: Microvolt) -> Result {
+///    // Obtain a reference to a (fictitious) regulator.
+///    let regulator: Regulator<Disabled> = Regulator::<Disabled>::get(dev, c_str!("vcc"))?;
+///
+///    // The voltage can be set before enabling the regulator if needed, e.g.:
+///    regulator.set_voltage(min_uv, max_uv)?;
+///
+///    // The same applies for `get_voltage()`, i.e.:
+///    let voltage: Microvolt = regulator.get_voltage()?;
+///
+///    // Enables the regulator, consuming the previous value.
+///    //
+///    // From now on, the regulator is known to be enabled because of the type
+///    // `Enabled`.
+///    //
+///    // If this operation fails, the `Error` will contain the regulator
+///    // reference, so that the operation may be retried.
+///    let regulator: Regulator<Enabled> = regulator.try_into_enabled().map_err(|error| error.error)?;
+///
+///    // The voltage can also be set after enabling the regulator, e.g.:
+///    regulator.set_voltage(min_uv, max_uv)?;
+///
+///    // The same applies for `get_voltage()`, i.e.:
+///    let voltage: Microvolt = regulator.get_voltage()?;
+///
+///    // Dropping an enabled regulator will disable it. The refcount will be
+///    // decremented.
+///    drop(regulator);
+///    // ...
+///    # Ok::<(), Error>(())
+/// }
+///```
+///
+/// A more concise shortcut is available for enabling a regulator. This is
+/// equivalent to `regulator_get_enable()`:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::c_str;
+/// # use kernel::device::Device;
+/// # use kernel::regulator::{Microvolt, Regulator, Enabled};
+/// fn enable(dev: &Device, min_uv: Microvolt, max_uv: Microvolt) -> Result {
+///    // Obtain a reference to a (fictitious) regulator and enable it.
+///    let regulator: Regulator<Enabled> = Regulator::<Enabled>::get(dev, c_str!("vcc"))?;
+///
+///    // Dropping an enabled regulator will disable it. The refcount will be
+///    // decremented.
+///    drop(regulator);
+///    // ...
+///    # Ok::<(), Error>(())
+/// }
+/// ```
+///
+/// Disabling a regulator:
+///
+///```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+/// # use kernel::regulator::{Regulator, Enabled, Disabled};
+/// fn disable(dev: &Device, regulator: Regulator<Enabled>) -> Result {
+///    // We can also disable an enabled regulator without reliquinshing our
+///    // refcount:
+///    //
+///    // If this operation fails, the `Error` will contain the regulator
+///    // reference, so that the operation may be retried.
+///    let regulator: Regulator<Disabled> = regulator.try_into_disabled().map_err(|error| error.error)?;
+///
+///    // The refcount will be decremented when `regulator` is dropped.
+///    drop(regulator);
+///    // ...
+///    # Ok::<(), Error>(())
+/// }
+/// ```
+///
+///
+/// Using `Regulator<Dynamic>`:
+///
+/// This example mimics the behavior of the C API, where the user is in
+/// control of the enabled reference count. This is useful for drivers that
+/// might call enable and disable to manage the `enable` reference count at
+/// runtime, perhaps as a result of `open()` and `close()` calls or whatever
+/// other driver-specific or subsystem-specific hooks.
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::c_str;
+/// # use kernel::device::Device;
+/// # use kernel::regulator::{Regulator, Dynamic};
+///
+/// struct PrivateData {
+///     regulator: Regulator<Dynamic>,
+/// }
+///
+/// // A fictictious probe function that obtains a regulator and sets it up.
+/// fn probe(dev: &Device, data: &mut PrivateData) -> Result<PrivateData> {
+///    // Obtain a reference to a (fictitious) regulator.
+///    let mut regulator = Regulator::<Dynamic>::get(dev, c_str!("vcc"))?;
+///    // Enable the regulator. The type is still `Regulator<Dynamic>`.
+///    regulator.enable()?;
+///
+///   Ok(PrivateData {
+///       regulator,
+///   })
+/// }
+///
+/// // A fictictious function that indicates that the device is going to be used.
+/// fn open(dev: &Device, data: &mut PrivateData) -> Result {
+///     // Increase the `enabled` reference count.
+///     data.regulator.enable()?;
+///     Ok(())
+/// }
+///
+/// fn close(dev: &Device, data: &mut PrivateData) -> Result {
+///    // Decrease the `enabled` reference count.
+///    data.regulator.disable()?;
+///     Ok(())
+/// }
+///
+/// fn remove(dev: &Device, data: PrivateData) -> Result {
+///     // `PrivateData` is dropped here, which will drop the
+///     // `Regulator<Dynamic>` in turn.
+///     //
+///     // The reference that was obtained by `regulator_get()` will be
+///     // released, but it is up to the user to make sure that the number of calls
+///     // to `enable()` and `disabled()` are balanced before this point.
+///     Ok(())
+/// }
+///
+///
+/// ```
+/// # Invariants
+///
+/// - `inner` is a non-null wrapper over a pointer to a `struct
+///   regulator` obtained from [`regulator_get()`](https://docs.kernel.org/driver-api/regulator.html#c.regulator_get).
+pub struct Regulator<State = Dynamic>
+where
+    State: RegulatorState + 'static,
+{
+    inner: NonNull<bindings::regulator>,
+    _phantom: PhantomData<State>,
+}
+
+impl<T: RegulatorState + 'static> Regulator<T> {
+    /// Sets the voltage for the regulator.
+    ///
+    /// This can be used to ensure that the device powers up cleanly.
+    pub fn set_voltage(&self, min_uv: Microvolt, max_uv: Microvolt) -> Result {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        to_result(unsafe {
+            bindings::regulator_set_voltage(self.inner.as_ptr(), min_uv.0, max_uv.0)
+        })
+    }
+
+    /// Gets the current voltage of the regulator.
+    pub fn get_voltage(&self) -> Result<Microvolt> {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        let voltage = unsafe { bindings::regulator_get_voltage(self.inner.as_ptr()) };
+        if voltage < 0 {
+            Err(kernel::error::Error::from_errno(voltage))
+        } else {
+            Ok(Microvolt(voltage))
+        }
+    }
+
+    fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
+        // SAFETY: It is safe to call `regulator_get()`, on a device pointer
+        // received from the C code.
+        let inner = from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_ptr()) })?;
+
+        // SAFETY: We can safely trust `inner` to be a pointer to a valid
+        // regulator if `ERR_PTR` was not returned.
+        let inner = unsafe { NonNull::new_unchecked(inner) };
+
+        Ok(Self {
+            inner,
+            _phantom: PhantomData,
+        })
+    }
+
+    fn enable_internal(&mut self) -> Result {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) })
+    }
+
+    fn disable_internal(&mut self) -> Result {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) })
+    }
+}
+
+impl Regulator<Disabled> {
+    /// Obtains a [`Regulator`] instance from the system.
+    pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
+        Regulator::get_internal(dev, name)
+    }
+}
+
+impl Regulator<Enabled> {
+    /// Obtains a [`Regulator`] instance from the system and enables it.
+    ///
+    /// This is equivalent to calling `regulator_get_enable()` in the C API.
+    pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
+        Regulator::<Disabled>::get_internal(dev, name)?
+            .try_into_enabled()
+            .map_err(|error| error.error)
+    }
+}
+
+impl Regulator<Dynamic> {
+    /// Obtains a [`Regulator`] instance from the system. The current state of
+    /// the regulator is unknown and it is up to the user to manage the enabled
+    /// reference count.
+    ///
+    /// This closely mimics the behavior of the C API and can be used to
+    /// dynamically manage the enabled reference count at runtime.
+    pub fn get(dev: &Device, name: &CStr) -> Result<Self> {
+        Regulator::get_internal(dev, name)
+    }
+
+    /// Increases the `enabled` reference count.
+    pub fn enable(&mut self) -> Result {
+        self.enable_internal()
+    }
+
+    /// Decreases the `enabled` reference count.
+    pub fn disable(&mut self) -> Result {
+        self.disable_internal()
+    }
+}
+
+impl<T: TryIntoEnabled> Regulator<T> {
+    /// Attempts to convert the regulator to an enabled state.
+    pub fn try_into_enabled(mut self) -> Result<Regulator<Enabled>, Error<T>> {
+        self.enable_internal()
+            .map(|()| Regulator {
+                inner: self.inner,
+                _phantom: PhantomData,
+            })
+            .map_err(|error| Error {
+                error,
+                regulator: self,
+            })
+    }
+}
+
+impl<T: TryIntoDisabled> Regulator<T> {
+    /// Attempts to convert the regulator to a disabled state.
+    pub fn try_into_disabled(mut self) -> Result<Regulator<Disabled>, Error<T>> {
+        self.disable_internal()
+            .map(|()| Regulator {
+                inner: self.inner,
+                _phantom: PhantomData,
+            })
+            .map_err(|error| Error {
+                error,
+                regulator: self,
+            })
+    }
+}
+
+impl<T: IsEnabled> Regulator<T> {
+    /// Checks if the regulator is enabled.
+    pub fn is_enabled(&self) -> bool {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        unsafe { bindings::regulator_is_enabled(self.inner.as_ptr()) != 0 }
+    }
+}
+
+impl<T: RegulatorState + 'static> Drop for Regulator<T> {
+    fn drop(&mut self) {
+        if core::any::TypeId::of::<T>() == core::any::TypeId::of::<Enabled>() {
+            // SAFETY: By the type invariants, we know that `self` owns a
+            // reference on the enabled refcount, so it is safe to relinquish it
+            // now.
+            unsafe { bindings::regulator_disable(self.inner.as_ptr()) };
+        }
+        // SAFETY: By the type invariants, we know that `self` owns a reference,
+        // so it is safe to relinquish it now.
+        unsafe { bindings::regulator_put(self.inner.as_ptr()) };
+    }
+}
+
+/// A voltage in microvolts.
+///
+/// The explicit type is used to avoid confusion with other multiples of the
+/// volt, which can be desastrous.
+#[repr(transparent)]
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub struct Microvolt(pub i32);

---
base-commit: edc5e6e019c99b529b3d1f2801d5cce9924ae79b
change-id: 20250326-topics-tyr-regulator-e8b98f6860d7

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


