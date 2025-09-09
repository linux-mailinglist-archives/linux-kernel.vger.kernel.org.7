Return-Path: <linux-kernel+bounces-808169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4FB4FB6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01591C60399
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891FD33470A;
	Tue,  9 Sep 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="PzrijJde"
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3275304BB5;
	Tue,  9 Sep 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421548; cv=none; b=REz6lMgWlmDMHGwzgzYt8dj3FRyF4qCvy5ciuIKIeNIF9K77S5qxWFhrbIcnIj6YNXbIxMQ7u7xT/wYIoA9cfDmUu7Hvf2Umq4XgqwQK7K6pfCO4Ftu98tRcLSN6Frb84rD3ub8Mc+Dil1hGPMsr7E9yY1cipd5Emq2sdyTd6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421548; c=relaxed/simple;
	bh=2owVnM9T2ch2QOHSkKCCLGPL8B2GMtCZYv94bswQSFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JQQxWV22x/5lzSDHw+5PgduleGhdhl1za6/eQMrYCN+KYsLVtxPwh63wALi+xdTH+7h3/Mo3sZyaLVPl6GKqDys5U8CrfOxHsFBjadR/DJxK0I6SH7297QHW1njXt2bRyOX1kyMos1QY8d+Up/57tt+pMIJ7J8h0dOWlpGtbr2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=PzrijJde; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id 51306C47A2;
	Tue, 09 Sep 2025 15:33:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:4419:0:640:5be6:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 432EBC0107;
	Tue, 09 Sep 2025 15:33:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1XIUaq3MuSw0-RtwQoMEU;
	Tue, 09 Sep 2025 15:33:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757421195;
	bh=m3qbGzn73yAfuqNuP1WFEZRME95KM0396p1UpUOU0Oc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=PzrijJdeJB94GF+lxpIJnNXyW5rGxezLdWCGtdcWD2peX24zdAMAxYP0b8Ezupbzb
	 OxRoCG6ep4m+2WTivrtgr6H21wGPZ7ujKZQlU+cT8jOJ3jGtjDLBFpcCaQRW5ehs2o
	 eEqnF9J7rK8ADM+J7DQ00prCePxVe+0GkRK17ark=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	daniel@sedlak.dev,
	dirk.behme@de.bosch.com,
	felipe_life@live.com,
	tamird@gmail.com,
	dakr@kernel.org,
	tmgross@umich.edu,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	lossin@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	boqun.feng@gmail.com,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1] rust: refactor `to_result` to return the original value
Date: Tue,  9 Sep 2025 15:32:58 +0300
Message-ID: <20250909123258.29304-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Current `to_result` helper takes a `c_int` and returns `Ok(())` on
success and this has some issues like:

    - Callers lose the original return value and often have to store
	it in a temporary variable before calling `to_result`.

    - It only supports `c_int`, which makes callers to unnecessarily
	cast when working with other types (e.g. `u16` in phy
	abstractions). We even have some places that ignore to use
	`to_result` helper because the input doesn't fit in `c_int`
	(see [0]).

[0]: https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/

This patch changes `to_result` to be generic and also return the
original value on success.

So that the code that previously looked like:

    let ret = unsafe { bindings::some_ffi_call() };
    to_result(ret).map(|()| SomeType::new(ret))

can now be written more directly as:

    to_result(unsafe { bindings::some_ffi_call() })
	.map(|ret| SomeType::new(ret))

Similarly, code such as:

    let res: isize = $some_ffi_call();
    if res < 0 {
	return Err(Error::from_errno(res as i32));
    }

can now be used with `to_result` as:

    to_result($some_ffi_call())?;

Existing call sites that only care about success/failure are updated
to append `.map(|_| ())` to preserve their previous semantics. They
can also use the equivalent pattern:

    to_result($something)?;
    Ok(())

This patch only fixes the callers that broke after the changes on `to_result`.
I haven't included all the improvements made possible by the new design since
that could conflict with other ongoing patches [1]. Once this patch is approved
and applied, I am planning to follow up with creating a "good first issue" on [2]
for those additional changes.

[1]: https://lore.kernel.org/rust-for-linux/?q=to_result
[2]: https://github.com/Rust-for-Linux/linux

Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/536374456
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/auxiliary.rs        |  1 +
 rust/kernel/block/mq/tag_set.rs |  2 +-
 rust/kernel/cpufreq.rs          |  3 ++-
 rust/kernel/devres.rs           |  1 +
 rust/kernel/dma.rs              |  3 +++
 rust/kernel/error.rs            | 17 ++++++++++++-----
 rust/kernel/miscdevice.rs       |  2 +-
 rust/kernel/mm/virt.rs          |  1 +
 rust/kernel/pci.rs              |  3 ++-
 rust/kernel/platform.rs         |  2 +-
 rust/kernel/regulator.rs        |  5 +++--
 11 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4749fb6bffef..479c0ad2a572 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -43,6 +43,7 @@ unsafe fn register(
         to_result(unsafe {
             bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
         })
+        .map(|_| ())
     }

     unsafe fn unregister(adrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index c3cf56d52bee..0e7883163000 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -65,7 +65,7 @@ pub fn new(
                 // SAFETY: we do not move out of `tag_set`.
                 let tag_set: &mut Opaque<_> = unsafe { Pin::get_unchecked_mut(tag_set) };
                 // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
-                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
+                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())}).map(|_| ())
             }),
             _p: PhantomData,
         })
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index be2dffbdb546..c3fa20ce229a 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -157,6 +157,7 @@ pub fn as_raw(&self) -> *mut bindings::cpufreq_policy_data {
     pub fn generic_verify(&self) -> Result {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
         to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
+            .map(|_| ())
     }
 }

@@ -519,7 +520,7 @@ pub fn set_suspend_freq(&mut self, freq: Hertz) -> &mut Self {
     #[inline]
     pub fn generic_suspend(&mut self) -> Result {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
-        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut_ref()) })
+        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut_ref()) }).map(|_| ())
     }

     /// Provides a wrapper to the generic get routine.
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d04e3fcebafb..214cd9a0ebe0 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -328,6 +328,7 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
         // `ForeignOwnable` is released eventually.
         bindings::devm_add_action_or_reset(dev.as_raw(), Some(callback::<P>), ptr.cast())
     })
+    .map(|_| ())
 }

 /// Encapsulate `data` in a [`KBox`] and [`Drop::drop`] `data` once `dev` is unbound.
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 68fe67624424..f614453ddb7d 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -34,6 +34,7 @@ unsafe fn dma_set_mask(&self, mask: DmaMask) -> Result {
         // - The safety requirement of this function guarantees that there are no concurrent calls
         //   to DMA allocation and mapping primitives using this mask.
         to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask.value()) })
+            .map(|_| ())
     }

     /// Set up the device's DMA coherent addressing capabilities.
@@ -51,6 +52,7 @@ unsafe fn dma_set_coherent_mask(&self, mask: DmaMask) -> Result {
         // - The safety requirement of this function guarantees that there are no concurrent calls
         //   to DMA allocation and mapping primitives using this mask.
         to_result(unsafe { bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask.value()) })
+            .map(|_| ())
     }

     /// Set up the device's DMA addressing capabilities.
@@ -72,6 +74,7 @@ unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMask) -> Result {
         to_result(unsafe {
             bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask.value())
         })
+        .map(|_| ())
     }
 }

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index db14da976722..f76afa4b7ec1 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -378,12 +378,19 @@ fn from(e: core::convert::Infallible) -> Error {
 pub type Result<T = (), E = Error> = core::result::Result<T, E>;

 /// Converts an integer as returned by a C kernel function to an error if it's negative, and
-/// `Ok(())` otherwise.
-pub fn to_result(err: crate::ffi::c_int) -> Result {
-    if err < 0 {
-        Err(Error::from_errno(err))
+/// returns the original value otherwise.
+pub fn to_result<T>(code: T) -> Result<T>
+where
+    T: Copy + TryInto<i32>,
+{
+    // Try casting into `i32`.
+    let casted: crate::ffi::c_int = code.try_into().unwrap_or(0);
+
+    if casted < 0 {
+        Err(Error::from_errno(casted))
     } else {
-        Ok(())
+        // Return the original input value.
+        Ok(code)
     }
 }

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b27..22b72ae84c03 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -79,7 +79,7 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
                 // the destructor of this type deallocates the memory.
                 // INVARIANT: If this returns `Ok(())`, then the `slot` will contain a registered
                 // misc device.
-                to_result(unsafe { bindings::misc_register(slot) })
+                to_result(unsafe { bindings::misc_register(slot) }).map(|_| ())
             }),
             _t: PhantomData,
         })
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index a1bfa4e19293..5494f96e91b0 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -195,6 +195,7 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
         // SAFETY: By the type invariant of `Self` caller has read access and has verified that
         // `VM_MIXEDMAP` is set. By invariant on `Page` the page has order 0.
         to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address, page.as_ptr()) })
+            .map(|_| ())
     }
 }

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..6e917752cb89 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -48,6 +48,7 @@ unsafe fn register(
         to_result(unsafe {
             bindings::__pci_register_driver(pdrv.get(), module.0, name.as_char_ptr())
         })
+        .map(|_| ())
     }

     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
@@ -437,7 +438,7 @@ impl Device<device::Core> {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
+        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) }).map(|_| ())
     }

     /// Enable bus-mastering for this device.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa..5a5561c7326e 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -54,7 +54,7 @@ unsafe fn register(
         }

         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
-        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
+        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) }).map(|_| ())
     }

     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 65f3a125348f..e17ae6e9a990 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -261,6 +261,7 @@ pub fn set_voltage(&self, min_voltage: Voltage, max_voltage: Voltage) -> Result
                 max_voltage.as_microvolts(),
             )
         })
+        .map(|_| ())
     }

     /// Gets the current voltage of the regulator.
@@ -291,12 +292,12 @@ fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {

     fn enable_internal(&mut self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) })
+        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) }).map(|_| ())
     }

     fn disable_internal(&mut self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) })
+        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) }).map(|_| ())
     }
 }

--
2.50.0


