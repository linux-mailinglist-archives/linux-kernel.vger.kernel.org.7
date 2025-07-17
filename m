Return-Path: <linux-kernel+bounces-734843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8357B08719
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8F3BEC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B10A25A321;
	Thu, 17 Jul 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Faqv+Kz7"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF22571B9;
	Thu, 17 Jul 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737729; cv=none; b=EmpB5LRrmt1/7dk9sG/TpTB2lFrY45WXD11gZnhsliHGnUwnEkdxkFzY/4cj0FU8giWAnE0OQKyjC+KkvQTkbX0Coj+xH52gWs/MwCcnkC7C2mRVfSyK/kN4P3TtJnuZNn50+26iLHJ4bxXMQrO45SOzRXdQE+M8fBr+nmmsuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737729; c=relaxed/simple;
	bh=SHoALwTU6wMD9NfeL68JeFylLC7iOiPAZzitEgb85f8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ahNv2pM9492+UUrJog0MiJrHAkbvC2eqP0XEr+0Asv3g28k3X6vrjj0Dvzwj98aQ+q+/f1wpyfs34CA1itlYsQlIRGOqmZh/gsIDv/UChASh/rZRZpzFOULuFiQxt+cg42+BZKsFUKeitA72njXQ3rYRF0KFNTiwDEbkUWRZmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Faqv+Kz7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2363616a1a6so4842525ad.3;
        Thu, 17 Jul 2025 00:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752737727; x=1753342527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VzyD0G9iHNH6DAj9AaLgmjY1jRcgpDhhq0BLyKYeOjk=;
        b=Faqv+Kz7h2vlaUnNcVLUWRGAjIeAMurBzN0s/Of0+v7BIvA1ER1BJn9IWPdNErL7ao
         Fnfg1D2Au9YOHTP9+at9IZiX1kwKBgQ68AuxMQeea/aal0sZvUgWLG8PyzHRd7J7W6yf
         oSfmVkR/5iAtFRm8WURHmiLB/gh9AvjfbTmf7pdgdgbQRvCr3pFVBoP1iQRv93oTtZoG
         H4sYvlL4DRekiDq+MPwWdiRDDr5xMhlQq/saTfJuZA6gJbo6P6IzwxIKTFHQ7wUsBIA8
         s8IEu+HMAaYWb4Wpc/pMYTKQxdlmrPc+AvfM37uhTdSRT5A1WtyECtIPcpN4ZD23e5si
         0Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737727; x=1753342527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzyD0G9iHNH6DAj9AaLgmjY1jRcgpDhhq0BLyKYeOjk=;
        b=Fp5FRGzzgvs/rnqY47eKmiu85/xEh0j2jkoNwd1t+DhdxzIyqRWpt9gwr5jIqAP8VM
         Z2H8BoEHBW78xf/zEwTxqU1XPDc4ZiU1EoOFLWW10cpW88jetWwvQerJFtbmN4QNvUwk
         j6YR3Wt+B5e8DHEoHTbYawDlO9DIPdMBYxligWm8QKdVuCjTj2h11aj7EMbpWa2ENPHE
         ZV4gMBzdPHDsBdLl4n7Cabm14r+gCgdUS2zu7vrfrw1cNOWq1gdGHMeB3gtJKzswmG8S
         PxPy0XMqGaxzdwqzIWDqWdrr7HV79sEkRbjyANfa3qCjqOCdfsXg36x2GAkCfykbf+8H
         k55g==
X-Forwarded-Encrypted: i=1; AJvYcCXAVU3pIhBX2uAoz9/gFuVi4u08C98fZd/jDr7ShRcnm8zqTXAl4A7ELYT/EJqbTouXInhfKLGfUU8MmGk1lw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FyIE7oEfm+qZhdW0sMOgWMvkRLCxvR6fkMZ1yEtwhzVWc9B+
	RDZLTqjoGFDKoNJNfNSiNS7Ql28mm+iRJR3tN8m2d+5tHJQ1BQF/lj9wt15gT8Mo
X-Gm-Gg: ASbGncsWCtyhWhGEhzwVY7t5N5/Z0Iowp4/Jd2jKVGRX1ruiMnwYUtaq2euyhFhSgXs
	Se7+kGVXDENLecN6nKlJMcM+9uyorFf+kUHmz1xoWudgvU6bh8A6celOjUIrGKMDTVHtx4Qu13V
	8SbFPXT9J0ycqynHZzbkp0LGY994q+1OacD5BQp5H8fB05Q+uVdfwh3Smgtfis5Q1WgYbsQdKf1
	fbqw3EIxr3obyvMyaGfbi3mFHZFPhjh4DEQIkSeylhY9IWO0HyGCWsoJnd3KVYiWArAsmOt0pXJ
	bwqixROhsJiJsMZQ40raA0d/XasZdjiYJiZm82a1u5s0rxrXgjcmw5bEZb/9QXrWYvMbPXC/2eQ
	1mLVy+ZzU86g6pyYRYFyQf/3oZXiO2SPuRp0uagdOdA==
X-Google-Smtp-Source: AGHT+IFjBbBlXN1aEJDb/YpI8/Owhdf59rkQJBBR2jxj2vK8rhJbmtmTmNAVro2ed/pfB0aK4/iuzA==
X-Received: by 2002:a17:903:3c23:b0:237:d486:706a with SMTP id d9443c01a7336-23e25778025mr86500585ad.48.1752737726356;
        Thu, 17 Jul 2025 00:35:26 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:e0f:ae0a:ee10:e231:d467:2ec0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7e88e4sm929307a91.21.2025.07.17.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:35:25 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 17 Jul 2025 13:04:50 +0530
Message-Id: <20250717073450.15090-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in the core kernel files to import `ARef`
and `AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
Its part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here:
https://lore.kernel.org/rust-for-linux/DBCLH4WXYTJL.FDZ9B39OO3TY@kernel.org/T/#mb67fbddcd894665d6ec6b0854e37930dedab468b

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/auxiliary.rs     |  2 +-
 rust/kernel/cred.rs          |  6 +-----
 rust/kernel/device.rs        | 10 +++-------
 rust/kernel/devres.rs        |  3 +--
 rust/kernel/dma.rs           |  2 +-
 rust/kernel/opp.rs           | 13 +++++++------
 rust/kernel/pci.rs           |  5 +++--
 rust/kernel/pid_namespace.rs |  5 +----
 rust/kernel/platform.rs      |  2 +-
 rust/kernel/task.rs          |  7 ++++---
 10 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..776c63387832 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -250,7 +250,7 @@ extern "C" fn release(dev: *mut bindings::device) {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 2599f01e8b28..4a2229542fb7 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,11 +8,7 @@
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
 
-use crate::{
-    bindings,
-    task::Kuid,
-    types::{AlwaysRefCounted, Opaque},
-};
+use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
 
 /// Wraps the kernel's `struct cred`.
 ///
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5c946af3a4d5..8b965b82163c 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -4,11 +4,7 @@
 //!
 //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
 
-use crate::{
-    bindings,
-    str::CStr,
-    types::{ARef, Opaque},
-};
+use crate::{bindings, str::CStr, sync::aref::ARef, types::Opaque};
 use core::{fmt, marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
@@ -216,7 +212,7 @@ pub fn property_present(&self, name: &CStr) -> bool {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -322,7 +318,7 @@ macro_rules! impl_device_context_deref {
 #[macro_export]
 macro_rules! __impl_device_context_into_aref {
     ($src:ty, $device:tt) => {
-        impl ::core::convert::From<&$device<$src>> for $crate::types::ARef<$device> {
+        impl ::core::convert::From<&$device<$src>> for $crate::sync::aref::ARef<$device> {
             fn from(dev: &$device<$src>) -> Self {
                 (&**dev).into()
             }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d0e6c6e162c2..7a1e2f2721b8 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -13,8 +13,7 @@
     ffi::c_void,
     prelude::*,
     revocable::{Revocable, RevocableGuard},
-    sync::{rcu, Arc, Completion},
-    types::ARef,
+    sync::{aref::ARef, rcu, Arc, Completion},
 };
 
 #[pin_data]
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 1f7bae643416..6339e1e22e08 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -9,8 +9,8 @@
     device::{Bound, Device},
     error::code::*,
     error::Result,
+    sync::aref::ARef,
     transmute::{AsBytes, FromBytes},
-    types::ARef,
 };
 
 /// Possible attributes associated with a DMA mapping.
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 0e94cb2703ec..de1fea9964f3 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,7 +16,8 @@
     ffi::c_ulong,
     prelude::*,
     str::CString,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::Opaque,
 };
 
 #[cfg(CONFIG_CPU_FREQ)]
@@ -162,7 +163,7 @@ fn from(power: MicroWatt) -> Self {
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::{Data, MicroVolt, Token};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
 ///     let data = Data::new(freq, volt, level, false);
@@ -211,7 +212,7 @@ fn drop(&mut self) {
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::{Data, MicroVolt, Token};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
 ///     let data = Data::new(freq, volt, level, false);
@@ -262,7 +263,7 @@ fn freq(&self) -> Hertz {
 /// use kernel::clk::Hertz;
 /// use kernel::error::Result;
 /// use kernel::opp::{OPP, SearchType, Table};
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
 ///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
@@ -335,7 +336,7 @@ fn drop(&mut self) {
 /// use kernel::error::Result;
 /// use kernel::opp::{Config, ConfigOps, ConfigToken};
 /// use kernel::str::CString;
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 /// use kernel::macros::vtable;
 ///
 /// #[derive(Default)]
@@ -581,7 +582,7 @@ extern "C" fn config_regulators(
 /// use kernel::device::Device;
 /// use kernel::error::Result;
 /// use kernel::opp::Table;
-/// use kernel::types::ARef;
+/// use kernel::sync::aref::ARef;
 ///
 /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
 ///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5ce07999168e..7c17c937de59 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -14,7 +14,8 @@
     io::Io,
     io::IoRaw,
     str::CStr,
-    types::{ARef, ForeignOwnable, Opaque},
+    sync::aref::ARef,
+    types::{ForeignOwnable, Opaque},
     ThisModule,
 };
 use core::{
@@ -438,7 +439,7 @@ pub fn set_master(&self) {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::pci_dev_get(self.as_raw()) };
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 0e93808e4639..979a9718f153 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -7,10 +7,7 @@
 //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
 //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
 
-use crate::{
-    bindings,
-    types::{AlwaysRefCounted, Opaque},
-};
+use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
 use core::ptr;
 
 /// Wraps the kernel's `struct pid_namespace`. Thread safe.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index e894790c510c..1c136341b670 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -198,7 +198,7 @@ fn as_raw(&self) -> *mut bindings::platform_device {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 927413d85484..b46488f6d1a8 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -9,7 +9,8 @@
     ffi::{c_int, c_long, c_uint},
     mm::MmWithUser,
     pid_namespace::PidNamespace,
-    types::{ARef, NotThreadSafe, Opaque},
+    sync::aref::ARef,
+    types::{NotThreadSafe, Opaque},
 };
 use core::{
     cmp::{Eq, PartialEq},
@@ -76,7 +77,7 @@ macro_rules! current {
 /// incremented when creating `State` and decremented when it is dropped:
 ///
 /// ```
-/// use kernel::{task::Task, types::ARef};
+/// use kernel::{task::Task, sync::aref::ARef};
 ///
 /// struct State {
 ///     creator: ARef<Task>,
@@ -340,7 +341,7 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
 }
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
-unsafe impl crate::types::AlwaysRefCounted for Task {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::get_task_struct(self.as_ptr()) };

base-commit: 8ecb65b7b68ea48350833ba59c1257718e859768
-- 
2.34.1


