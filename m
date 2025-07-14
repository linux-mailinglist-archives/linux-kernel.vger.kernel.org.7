Return-Path: <linux-kernel+bounces-730644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED3B0478A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8895D1AA019B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507AA2777F3;
	Mon, 14 Jul 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xvgvd5CM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D21275105;
	Mon, 14 Jul 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519149; cv=none; b=WboYcX04UK5o6kZOnl2o0BFkgV4CYwFdhNE2V4ND7uUDyE1lim90g+f73QkxBYRih91s0VFJWVWnoHEvUKn3ULUp6GF5hLy1sr+uOIZvL1vIMW3vHnyJOrp5Ce4vjm9vTxvOZPDzC7GNonYRxSwgeK904MDSczd7JXBWCdTqRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519149; c=relaxed/simple;
	bh=1RHsgAYVlIg7XVoj2giw1rF7sAC18GqMsK302F7oCOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSM8ZV93I6VAZycOR/zowGSiQ1LNeQcb0m/vCGyNf9uoa7eBzGEMVSNo3UqYUJ16/KDbBlrwfzy39SuGrmj22pRsLNbOdTcBFqHqD3zsJqnUiLU8FjCwzdS28Vn2kcKBHDcGQLTHrPRC37KbrZXN77FsgNVi6FXjKe3qUpJja6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xvgvd5CM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752519144;
	bh=1RHsgAYVlIg7XVoj2giw1rF7sAC18GqMsK302F7oCOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xvgvd5CMhP2g93mRNpXizgnWEL4Mtu8tqbt0U6lX/0k6k10S3E1QclUzwjVbachfE
	 Ip2e4lSLbsPgEI31YnWZiUIdP79WYBpeOjdApjdXkhA1fFpejzpnkJ81aMboLX5VKo
	 nfIK79Df+brn55znW9p4xez04d9OJGIbShhGl/7iRwI1x9x9W1KG6NcmXJkxonguQx
	 +Ao/cJMW8/58ncyPcdjVsWJeM5zW8AeWh7XJXY58MNmPLL3CWmRSrq5XDig9tlVB82
	 tOnsf0599OUqCS0QUP57O4Uc6E/Pdgpis6QKB5uIEgBY1AxSebZYixhCOfev/dD4pc
	 2YFevQ4jDVwzA==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5396717E128A;
	Mon, 14 Jul 2025 20:52:22 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 14 Jul 2025 15:52:04 -0300
Subject: [PATCH v8 1/2] rust: regulator: add a bare minimum regulator
 abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-topics-tyr-regulator2-v8-1-c7ab3955d524@collabora.com>
References: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
In-Reply-To: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Add a bare minimum regulator abstraction to be used by Rust drivers.
This abstraction adds a small subset of the regulator API, which is
thought to be sufficient for the drivers we have now.

Regulators provide the power needed by many hardware blocks and thus are
likely to be needed by a lot of drivers.

It was tested on rk3588, where it was used to power up the "mali"
regulator in order to power up the GPU.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/regulator.c        |  43 +++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/regulator.rs        | 418 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 464 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index bc494745f67b82e7a3a6f53055ece0fc3acf6e0d..109b9987091b96a8f5bdc6d4dc2c89cb4bdcdcce 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -64,6 +64,7 @@
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/refcount.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/slab.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 16fa9bca5949b85e8d4cdcfe8e6886124f72d8d8..68e1ee9388aa4a5390132ec0549f84f7aad9fef1 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -32,6 +32,7 @@
 #include "pci.c"
 #include "pid_namespace.c"
 #include "rbtree.c"
+#include "regulator.c"
 #include "rcu.c"
 #include "refcount.c"
 #include "security.c"
diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..cd8b7ba648ee33dd14326c9242fb6c96ab8e32a7
--- /dev/null
+++ b/rust/helpers/regulator.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/regulator/consumer.h>
+
+#ifndef CONFIG_REGULATOR
+
+void rust_helper_regulator_put(struct regulator *regulator)
+{
+	regulator_put(regulator);
+}
+
+int rust_helper_regulator_set_voltage(struct regulator *regulator, int min_uV,
+				      int max_uV)
+{
+	return regulator_set_voltage(regulator, min_uV, max_uV);
+}
+
+int rust_helper_regulator_get_voltage(struct regulator *regulator)
+{
+	return regulator_get_voltage(regulator);
+}
+
+struct regulator *rust_helper_regulator_get(struct device *dev, const char *id)
+{
+	return regulator_get(dev, id);
+}
+
+int rust_helper_regulator_enable(struct regulator *regulator)
+{
+	return regulator_enable(regulator);
+}
+
+int rust_helper_regulator_disable(struct regulator *regulator)
+{
+	return regulator_disable(regulator);
+}
+
+int rust_helper_regulator_is_enabled(struct regulator *regulator)
+{
+	return regulator_is_enabled(regulator);
+}
+
+#endif
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c37f4da1866e993be6230bc6715841..5e4cd8c5e6ff1c4af52a5b1be4c4c32b5104e233 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -100,6 +100,7 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+pub mod regulator;
 pub mod revocable;
 pub mod security;
 pub mod seq_file;
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
new file mode 100644
index 0000000000000000000000000000000000000000..65f3a125348f2d821898188b4ac6a0b593f18bf2
--- /dev/null
+++ b/rust/kernel/regulator.rs
@@ -0,0 +1,418 @@
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
+//! See [Voltage and current regulator API](https://docs.kernel.org/driver-api/regulator.html)
+//! for more information.
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    prelude::*,
+};
+
+use core::{marker::PhantomData, mem::ManuallyDrop, ptr::NonNull};
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
+pub trait RegulatorState: private::Sealed + 'static {
+    /// Whether the regulator should be disabled when dropped.
+    const DISABLE_ON_DROP: bool;
+}
+
+/// A state where the [`Regulator`] is known to be enabled.
+///
+/// The `enable` reference count held by this state is decremented when it is
+/// dropped.
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
+impl RegulatorState for Enabled {
+    const DISABLE_ON_DROP: bool = true;
+}
+
+impl RegulatorState for Disabled {
+    const DISABLE_ON_DROP: bool = false;
+}
+
+impl RegulatorState for Dynamic {
+    const DISABLE_ON_DROP: bool = false;
+}
+
+/// A trait that abstracts the ability to check if a [`Regulator`] is enabled.
+pub trait IsEnabled: RegulatorState {}
+impl IsEnabled for Disabled {}
+impl IsEnabled for Dynamic {}
+
+/// An error that can occur when trying to convert a [`Regulator`] between states.
+pub struct Error<State: RegulatorState> {
+    /// The error that occurred.
+    pub error: kernel::error::Error,
+
+    /// The regulator that caused the error, so that the operation may be retried.
+    pub regulator: Regulator<State>,
+}
+
+/// A `struct regulator` abstraction.
+///
+/// # Examples
+///
+/// ## Enabling a regulator
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
+/// # use kernel::regulator::{Voltage, Regulator, Disabled, Enabled};
+/// fn enable(dev: &Device, min_voltage: Voltage, max_voltage: Voltage) -> Result {
+///     // Obtain a reference to a (fictitious) regulator.
+///     let regulator: Regulator<Disabled> = Regulator::<Disabled>::get(dev, c_str!("vcc"))?;
+///
+///     // The voltage can be set before enabling the regulator if needed, e.g.:
+///     regulator.set_voltage(min_voltage, max_voltage)?;
+///
+///     // The same applies for `get_voltage()`, i.e.:
+///     let voltage: Voltage = regulator.get_voltage()?;
+///
+///     // Enables the regulator, consuming the previous value.
+///     //
+///     // From now on, the regulator is known to be enabled because of the type
+///     // `Enabled`.
+///     //
+///     // If this operation fails, the `Error` will contain the regulator
+///     // reference, so that the operation may be retried.
+///     let regulator: Regulator<Enabled> =
+///         regulator.try_into_enabled().map_err(|error| error.error)?;
+///
+///     // The voltage can also be set after enabling the regulator, e.g.:
+///     regulator.set_voltage(min_voltage, max_voltage)?;
+///
+///     // The same applies for `get_voltage()`, i.e.:
+///     let voltage: Voltage = regulator.get_voltage()?;
+///
+///     // Dropping an enabled regulator will disable it. The refcount will be
+///     // decremented.
+///     drop(regulator);
+///
+///     // ...
+///
+///     Ok(())
+/// }
+/// ```
+///
+/// A more concise shortcut is available for enabling a regulator. This is
+/// equivalent to `regulator_get_enable()`:
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::c_str;
+/// # use kernel::device::Device;
+/// # use kernel::regulator::{Voltage, Regulator, Enabled};
+/// fn enable(dev: &Device) -> Result {
+///     // Obtain a reference to a (fictitious) regulator and enable it.
+///     let regulator: Regulator<Enabled> = Regulator::<Enabled>::get(dev, c_str!("vcc"))?;
+///
+///     // Dropping an enabled regulator will disable it. The refcount will be
+///     // decremented.
+///     drop(regulator);
+///
+///     // ...
+///
+///     Ok(())
+/// }
+/// ```
+///
+/// ## Disabling a regulator
+///
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::device::Device;
+/// # use kernel::regulator::{Regulator, Enabled, Disabled};
+/// fn disable(dev: &Device, regulator: Regulator<Enabled>) -> Result {
+///     // We can also disable an enabled regulator without reliquinshing our
+///     // refcount:
+///     //
+///     // If this operation fails, the `Error` will contain the regulator
+///     // reference, so that the operation may be retried.
+///     let regulator: Regulator<Disabled> =
+///         regulator.try_into_disabled().map_err(|error| error.error)?;
+///
+///     // The refcount will be decremented when `regulator` is dropped.
+///     drop(regulator);
+///
+///     // ...
+///
+///     Ok(())
+/// }
+/// ```
+///
+/// ## Using [`Regulator<Dynamic>`]
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
+/// struct PrivateData {
+///     regulator: Regulator<Dynamic>,
+/// }
+///
+/// // A fictictious probe function that obtains a regulator and sets it up.
+/// fn probe(dev: &Device) -> Result<PrivateData> {
+///     // Obtain a reference to a (fictitious) regulator.
+///     let mut regulator = Regulator::<Dynamic>::get(dev, c_str!("vcc"))?;
+///
+///     Ok(PrivateData { regulator })
+/// }
+///
+/// // A fictictious function that indicates that the device is going to be used.
+/// fn open(dev: &Device, data: &mut PrivateData) -> Result {
+///     // Increase the `enabled` reference count.
+///     data.regulator.enable()?;
+///
+///     Ok(())
+/// }
+///
+/// fn close(dev: &Device, data: &mut PrivateData) -> Result {
+///     // Decrease the `enabled` reference count.
+///     data.regulator.disable()?;
+///
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
+/// ```
+///
+/// # Invariants
+///
+/// - `inner` is a non-null wrapper over a pointer to a `struct
+///   regulator` obtained from [`regulator_get()`].
+///
+/// [`regulator_get()`]: https://docs.kernel.org/driver-api/regulator.html#c.regulator_get
+pub struct Regulator<State = Dynamic>
+where
+    State: RegulatorState,
+{
+    inner: NonNull<bindings::regulator>,
+    _phantom: PhantomData<State>,
+}
+
+impl<T: RegulatorState> Regulator<T> {
+    /// Sets the voltage for the regulator.
+    ///
+    /// This can be used to ensure that the device powers up cleanly.
+    pub fn set_voltage(&self, min_voltage: Voltage, max_voltage: Voltage) -> Result {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        to_result(unsafe {
+            bindings::regulator_set_voltage(
+                self.inner.as_ptr(),
+                min_voltage.as_microvolts(),
+                max_voltage.as_microvolts(),
+            )
+        })
+    }
+
+    /// Gets the current voltage of the regulator.
+    pub fn get_voltage(&self) -> Result<Voltage> {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        let voltage = unsafe { bindings::regulator_get_voltage(self.inner.as_ptr()) };
+        if voltage < 0 {
+            Err(kernel::error::Error::from_errno(voltage))
+        } else {
+            Ok(Voltage::from_microvolts(voltage))
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
+
+    /// Attempts to convert the regulator to an enabled state.
+    pub fn try_into_enabled(self) -> Result<Regulator<Enabled>, Error<Disabled>> {
+        // We will be transferring the ownership of our `regulator_get()` count to
+        // `Regulator<Enabled>`.
+        let mut regulator = ManuallyDrop::new(self);
+
+        regulator
+            .enable_internal()
+            .map(|()| Regulator {
+                inner: regulator.inner,
+                _phantom: PhantomData,
+            })
+            .map_err(|error| Error {
+                error,
+                regulator: ManuallyDrop::into_inner(regulator),
+            })
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
+
+    /// Attempts to convert the regulator to a disabled state.
+    pub fn try_into_disabled(self) -> Result<Regulator<Disabled>, Error<Enabled>> {
+        // We will be transferring the ownership of our `regulator_get()` count
+        // to `Regulator<Disabled>`.
+        let mut regulator = ManuallyDrop::new(self);
+
+        regulator
+            .disable_internal()
+            .map(|()| Regulator {
+                inner: regulator.inner,
+                _phantom: PhantomData,
+            })
+            .map_err(|error| Error {
+                error,
+                regulator: ManuallyDrop::into_inner(regulator),
+            })
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
+impl<T: IsEnabled> Regulator<T> {
+    /// Checks if the regulator is enabled.
+    pub fn is_enabled(&self) -> bool {
+        // SAFETY: Safe as per the type invariants of `Regulator`.
+        unsafe { bindings::regulator_is_enabled(self.inner.as_ptr()) != 0 }
+    }
+}
+
+impl<T: RegulatorState> Drop for Regulator<T> {
+    fn drop(&mut self) {
+        if T::DISABLE_ON_DROP {
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
+/// A voltage.
+///
+/// This type represents a voltage value in microvolts.
+#[repr(transparent)]
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub struct Voltage(i32);
+
+impl Voltage {
+    /// Creates a new `Voltage` from a value in microvolts.
+    pub fn from_microvolts(uv: i32) -> Self {
+        Self(uv)
+    }
+
+    /// Returns the value of the voltage in microvolts as an [`i32`].
+    pub fn as_microvolts(self) -> i32 {
+        self.0
+    }
+}

-- 
2.50.0


