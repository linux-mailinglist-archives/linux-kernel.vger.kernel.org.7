Return-Path: <linux-kernel+bounces-808713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C639B503EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1363C5433B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6C246BB0;
	Tue,  9 Sep 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="UzqAItoH"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AA31D393;
	Tue,  9 Sep 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437281; cv=none; b=SbGf+IElf8T8yk724Pu2zZprIJiZmEKwDl46NdLWJ18CIeYB1fIfiLSbNyu/6lpvjkI3bi5bFEC/3Lb1RrVcg800Ii/ZfzvUfPgMm64WR4VT43ChGxTiLmhMcJBze8LD29C2bXgfE3PIblU+aey8XGwcVXsVYc76IeQduJ4B3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437281; c=relaxed/simple;
	bh=YblYGC+W97HSFOOr7BT5YAnf4Zo8fFjmTbR0W2+lsHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvMuA5C735uykYwAI2N92KdgYX/kUsZQMhQjESNhoPGFh9UOmo1BFN6XZh4lUY+VieBzgvTLqjBc4RNSfATMKC3/Sf6/dwcHVt7NxDY5PzpSETzM+DYgMhurQcOeI0I9Ke1+mHdvJkBU8DRww/uLgRQOBK5WmX54GJsPRQgoWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=UzqAItoH; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:149a:0:640:77a6:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id DC89D80CA4;
	Tue, 09 Sep 2025 20:01:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id F0NUYT4M44Y0-332VttFn;
	Tue, 09 Sep 2025 20:01:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757437269;
	bh=AAWJ05zT6fItPUdAyppkEMkc7ybpVNFCRRssKDo3VHc=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=UzqAItoHIxG6v1+6os5elridsQ/dC9JjMPegPC2UDi1TrdcqRPBgeKfG/hs0rKyfU
	 bgKKmncRBu0PvUQoFJEQsp9JOcB6gnnEBnSBFPYwejmjAtK971B6a9UfcAUXIlD4Zm
	 ghQv6GBrJT07K8yUrcfXL6S7t8A4SHtJ+yPBMiFM=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH v2 1/1] rust: refactor to_result to return the original value
Date: Tue,  9 Sep 2025 20:00:13 +0300
Message-ID: <20250909170013.16025-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250909170013.16025-1-work@onurozkan.dev>
References: <20250909170013.16025-1-work@onurozkan.dev>
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
 rust/kernel/auxiliary.rs        |  3 ++-
 rust/kernel/block/mq/tag_set.rs |  3 ++-
 rust/kernel/cpufreq.rs          |  6 ++++--
 rust/kernel/devres.rs           |  3 ++-
 rust/kernel/dma.rs              | 11 ++++++++---
 rust/kernel/error.rs            | 17 ++++++++++++-----
 rust/kernel/miscdevice.rs       |  2 +-
 rust/kernel/mm/virt.rs          |  3 ++-
 rust/kernel/pci.rs              |  6 ++++--
 rust/kernel/platform.rs         |  3 ++-
 rust/kernel/regulator.rs        | 14 ++++++++------
 11 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4749fb6bffef..74b4da1192e1 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -42,7 +42,8 @@ unsafe fn register(
         // SAFETY: `adrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
             bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
-        })
+        })?;
+        Ok(())
     }

     unsafe fn unregister(adrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index c3cf56d52bee..e8adb9d72475 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -65,7 +65,8 @@ pub fn new(
                 // SAFETY: we do not move out of `tag_set`.
                 let tag_set: &mut Opaque<_> = unsafe { Pin::get_unchecked_mut(tag_set) };
                 // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
-                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
+                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})?;
+                Ok(())
             }),
             _p: PhantomData,
         })
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index afc15e72a7c3..b9db81aea5c6 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -157,7 +157,8 @@ pub fn as_raw(&self) -> *mut bindings::cpufreq_policy_data {
     #[inline]
     pub fn generic_verify(&self) -> Result {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
-        to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
+        to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })?;
+        Ok(())
     }
 }

@@ -520,7 +521,8 @@ pub fn set_suspend_freq(&mut self, freq: Hertz) -> &mut Self {
     #[inline]
     pub fn generic_suspend(&mut self) -> Result {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
-        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut_ref()) })
+        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut_ref()) })?;
+        Ok(())
     }

     /// Provides a wrapper to the generic get routine.
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d04e3fcebafb..487e194f7d96 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -327,7 +327,8 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
         // `devm_add_action_or_reset()` also calls `callback` on failure, such that the
         // `ForeignOwnable` is released eventually.
         bindings::devm_add_action_or_reset(dev.as_raw(), Some(callback::<P>), ptr.cast())
-    })
+    })?;
+    Ok(())
 }

 /// Encapsulate `data` in a [`KBox`] and [`Drop::drop`] `data` once `dev` is unbound.
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2bc8ab51ec28..04ca70f6f684 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -33,7 +33,8 @@ unsafe fn dma_set_mask(&self, mask: DmaMask) -> Result {
         // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
         // - The safety requirement of this function guarantees that there are no concurrent calls
         //   to DMA allocation and mapping primitives using this mask.
-        to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask.value()) })
+        to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask.value()) })?;
+        Ok(())
     }

     /// Set up the device's DMA coherent addressing capabilities.
@@ -50,7 +51,10 @@ unsafe fn dma_set_coherent_mask(&self, mask: DmaMask) -> Result {
         // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
         // - The safety requirement of this function guarantees that there are no concurrent calls
         //   to DMA allocation and mapping primitives using this mask.
-        to_result(unsafe { bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask.value()) })
+        to_result(unsafe {
+            bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask.value())
+        })?;
+        Ok(())
     }

     /// Set up the device's DMA addressing capabilities.
@@ -71,7 +75,8 @@ unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMask) -> Result {
         //   to DMA allocation and mapping primitives using this mask.
         to_result(unsafe {
             bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask.value())
-        })
+        })?;
+        Ok(())
     }
 }

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index a41de293dcd1..6563ea71e203 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -376,12 +376,19 @@ fn from(e: core::convert::Infallible) -> Error {
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
index 6086ca981b06..62c00dcdb5e1 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -194,7 +194,8 @@ pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
     pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
         // SAFETY: By the type invariant of `Self` caller has read access and has verified that
         // `VM_MIXEDMAP` is set. By invariant on `Page` the page has order 0.
-        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address, page.as_ptr()) })
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address, page.as_ptr()) })?;
+        Ok(())
     }
 }

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..b52a7be488d0 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -47,7 +47,8 @@ unsafe fn register(
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
         to_result(unsafe {
             bindings::__pci_register_driver(pdrv.get(), module.0, name.as_char_ptr())
-        })
+        })?;
+        Ok(())
     }

     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
@@ -437,7 +438,8 @@ impl Device<device::Core> {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
+        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })?;
+        Ok(())
     }

     /// Enable bus-mastering for this device.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa..751b65bfc357 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -54,7 +54,8 @@ unsafe fn register(
         }

         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
-        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
+        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })?;
+        Ok(())
     }

     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 34bb24ec8d4d..a5f357bda6e9 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -260,15 +260,15 @@ pub fn set_voltage(&self, min_voltage: Voltage, max_voltage: Voltage) -> Result
                 min_voltage.as_microvolts(),
                 max_voltage.as_microvolts(),
             )
-        })
+        })?;
+        Ok(())
     }

     /// Gets the current voltage of the regulator.
     pub fn get_voltage(&self) -> Result<Voltage> {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        let voltage = unsafe { bindings::regulator_get_voltage(self.inner.as_ptr()) };
-
-        to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
+        to_result(unsafe { bindings::regulator_get_voltage(self.inner.as_ptr()) })
+            .map(Voltage::from_microvolts)
     }

     fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
@@ -288,12 +288,14 @@ fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {

     fn enable_internal(&self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) })
+        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr()) })?;
+        Ok(())
     }

     fn disable_internal(&self) -> Result {
         // SAFETY: Safe as per the type invariants of `Regulator`.
-        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) })
+        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr()) })?;
+        Ok(())
     }
 }

--
2.50.0


