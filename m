Return-Path: <linux-kernel+bounces-768609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBAB2632F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154C79E4B05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6D2F83BE;
	Thu, 14 Aug 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNcIJ8DN"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFD28724D;
	Thu, 14 Aug 2025 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168393; cv=none; b=H6G9aDlNcOuF0fJVn0wHAXBUgQN5VPxu345IGtyYQBm+5c9wxNSld3TjB4HhtVY0PB93bYZ+JBV2QOOAUOIATN27OefYPaIlJ8j45bLRT8JtPXNXIi6o8LAQHjBBp3Cri7UvqB77JjeiqDKpFA8BycX78mtiFWOpRBlQ3nRMPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168393; c=relaxed/simple;
	bh=9VjPhpkG31XsNvAy3oEQ6ai0rrumEGX6BoJKRDxARgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oqNeiR/6c0/MJKf3Dy+AUcnDYzoZtt+BTEw+mvQ7MBa7o8lskuiUvUqlQ3akWObUav0zzsut2GdGmyOUH3ZILCqpDNgWc4EQh32TjTeIdZwzHCEZ39eO1PwwtkjqYFgDcO1QXaYcbCyqBBAQ257v4odGmcuIDsqv3xR5IrahkzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNcIJ8DN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso1215195b3a.2;
        Thu, 14 Aug 2025 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168391; x=1755773191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y21EAJKk09TeTY4oNrlpb8XfLwThF6yfFAYybJQLDII=;
        b=CNcIJ8DN7BcuR+IvT4F4aD675tIktuaE18y7V/A4oZVd6TYsHvV0hhxZ3kKsjQ5MRt
         +HlAzuoGxMOhCyAJF51/eUi/JPfyjHCOnJCVdCJ1Q6ZP024oB8SKWYTd4YoN4OXgpg7v
         hcd4RNRNoI6xftHpt8jCEYWAXZBh2gIYua8ii7rxCNiRxBrn8HnZfxAo8lvNJvbD8p/v
         iHILs3g1JWlXkuksW+sF8Datwg8BACDBG4BPdw//yM8imfEG1FcTt9ruKFKm1/Lf0Mg3
         OiD/s023C0wjpfuhX445nCgOg3RU8Xb0/16spnXLdhXXPHlRZieBwyI19nF2xlf6v/NA
         OCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168391; x=1755773191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y21EAJKk09TeTY4oNrlpb8XfLwThF6yfFAYybJQLDII=;
        b=o4bSWCcm0L4UX0wgBq11c10YFHQgR4OMqH97XlYdtutIhT/uGgxG5Tt/RtwWkW0DfH
         opLv87A3D0L249mq0qAkNwoyid7MR+V72NvxoY5GU1f//k0HmeWgVfV3w9mPJVawS7aK
         O2FhSpqMBYLEnth6rA63FMyJ/nW+51T+WpkPZ45XR+I4IS1BuR6eV6aouIJ38xqXCM/7
         X7vT4ZZX6K1LlN5xpIj4U/HR0l9WO9MU0yqwgM8YcJyjY92ccuqXdMPCoJaqaNi2VV0K
         uEGVeQVQQwkI1KAuW2SZUdoi4pVL2zp7z2MtAmS7Ub6s8AU1HphfA4vRPD/50yoaIjxS
         Hr9g==
X-Forwarded-Encrypted: i=1; AJvYcCV8FHLJq78qw1xZE20dModO7zr5ACI5voh1ASaDivKTBwKDH3J4FOVyIPD82K5BpSG4sIiTaUV8qRhEYsQ=@vger.kernel.org, AJvYcCXQrVOeyo16Wsvc/c6hsomIugaQF+DP349YQwYO7v+QLa0TO5IUAprh8WOEOzSgiprtmXMTN+VrVTTmU4GUPus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwidfUarL5iovrIAAXhSXBwuVWYHv5H+cGI2tVP8WwxLQxNCILq
	dCXHFevR1SE3neN3OncJRoO7z1ZEB9lL/Hd/Pn3xrDpMc3Gi27RBINDLZclEi+DSA4s=
X-Gm-Gg: ASbGnct6Ox/ZXKweG9h0CMWMQlubG7nkPNvwv5LTcTQiYNbJnQmSYHZxF/CiN6yddYd
	+5kt8xmbUDoofMOgiwmILFp9o8mu4mNQac5a+2bP3ur2mtGR/lRLqYLD6IEvjA5HulnAtIN+bSZ
	MdJ1pRhXClOSsgmUdjnz+3XxIXJM4yZfk9KxsMDgZlkewL0mH3xHv0Z0sLkJjGx2QUVjQD09NtH
	C/NKatIMQ5BuKkO9kQplETVSF4cJ5sQhbDAgM9da2ijGt5VkWNZTxAJEwfHuGEW21IHJpA673Kv
	u/d5DXazo5/KTBj+CNox2AJ9GXi86OWFKOrWGqsgO4E3vbpe7gJwY9xvLhvXTKKlXGXV4/SuSvx
	S+tgiJLtNtxwRh86pDwsI5vhqAOGzpgPjTcNm
X-Google-Smtp-Source: AGHT+IGQsx+0VKtIsXrcwIrlDVaIvLwJ4FShg9+W65gJti3oWQfttxGPubd6v0RwCnSOD2VMgGMY+w==
X-Received: by 2002:a05:6a00:2d9d:b0:76b:ca98:faae with SMTP id d2e1a72fcca58-76e2fc290b2mr4487901b3a.8.1755168390809;
        Thu, 14 Aug 2025 03:46:30 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcdd40f63sm34331201b3a.87.2025.08.14.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:46:30 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: driver-core: Update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 14 Aug 2025 16:16:15 +0530
Message-Id: <20250814104615.355106-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in the driver-core files and its related samples
to import `ARef` and `AlwaysRefCounted` from `sync::aref`
instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here: (commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/auxiliary.rs             | 2 +-
 rust/kernel/device.rs                | 7 ++++---
 rust/kernel/devres.rs                | 4 ++--
 rust/kernel/pci.rs                   | 5 +++--
 rust/kernel/platform.rs              | 2 +-
 samples/rust/rust_driver_pci.rs      | 2 +-
 samples/rust/rust_driver_platform.rs | 2 +-
 7 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4749fb6bffef..0cefe36ca4b5 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -245,7 +245,7 @@ extern "C" fn release(dev: *mut bindings::device) {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index b8613289de8e..b860ab389f18 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,7 +6,8 @@
 
 use crate::{
     bindings,
-    types::{ARef, ForeignOwnable, Opaque},
+    sync::aref::ARef,
+    types::{ForeignOwnable, Opaque},
 };
 use core::{fmt, marker::PhantomData, ptr};
 
@@ -292,7 +293,7 @@ pub fn fwnode(&self) -> Option<&property::FwNode> {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -411,7 +412,7 @@ macro_rules! impl_device_context_deref {
 #[macro_export]
 macro_rules! __impl_device_context_into_aref {
     ($src:ty, $device:tt) => {
-        impl ::core::convert::From<&$device<$src>> for $crate::types::ARef<$device> {
+        impl ::core::convert::From<&$device<$src>> for $crate::sync::aref::ARef<$device> {
             fn from(dev: &$device<$src>) -> Self {
                 (&**dev).into()
             }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index da18091143a6..99b7520019f0 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -13,8 +13,8 @@
     ffi::c_void,
     prelude::*,
     revocable::{Revocable, RevocableGuard},
-    sync::{rcu, Completion},
-    types::{ARef, ForeignOwnable, Opaque, ScopeGuard},
+    sync::{aref::ARef, rcu, Completion},
+    types::{ForeignOwnable, Opaque, ScopeGuard},
 };
 
 use pin_init::Wrapper;
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..cfd00d4f0cfc 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -13,7 +13,8 @@
     io::Io,
     io::IoRaw,
     str::CStr,
-    types::{ARef, Opaque},
+    sync::aref::ARef,
+    types::Opaque,
     ThisModule,
 };
 use core::{
@@ -455,7 +456,7 @@ pub fn set_master(&self) {
 impl crate::dma::Device for Device<device::Core> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::pci_dev_get(self.as_raw()) };
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa..032fd455b838 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -292,7 +292,7 @@ pub fn io_request_by_name(&self, name: &CStr) -> Option<IoRequest<'_>> {
 impl crate::dma::Device for Device<device::Core> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::types::AlwaysRefCounted for Device {
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..0798019014cd 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
 
 struct Regs;
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 69ed55b7b0fa..6473baf4f120 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -72,7 +72,7 @@
     of, platform,
     prelude::*,
     str::CString,
-    types::ARef,
+    sync::aref::ARef,
 };
 
 struct SampleDriver {

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


