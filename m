Return-Path: <linux-kernel+bounces-888447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8DC3AD41
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1242A1A46971
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1D330318;
	Thu,  6 Nov 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvbGdzwg"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303532863F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430959; cv=none; b=bHZdGW1/0bYmFQs+c3wbaNO0CMO+mN6GdNtHcQgQ/dfSfWUmSsN2MwytigSpDe/bIpNugxk4ln4eTfyYS3vOB95Md1L+1XTAup4spfcjbHEM5TXo5BBEzmIeF8cSuqx1u9la9WZh3p0q9lZx2+Djgl6dr6mycabgIUwpn1Ap9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430959; c=relaxed/simple;
	bh=N05CdPPb9ETL4l1CnNbsvW0DFUOjIo2ix3kfvkTeeCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k4Qn/SyjJ0fRKhuJSqTDEpP/ndZVGG5KzgWMwj5SR2lUUbC8KmyeODkVwJvs5yCh2fiYWiLWwCQQTF0LDZjfGCnUwTyDPdaycKKya6ZQ9zwcsIb6djUtcmw20GrjGQ2j6k3YgYU6WO29YGNlug2F4EeMJXTWyvzi8RMDakZSX9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvbGdzwg; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b70be4f20e0so73287466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762430956; x=1763035756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLAnUrDI2pvarEVlAqbKGGVmDyTWyIE6rE0vKb5WBQQ=;
        b=DvbGdzwg/eyyHFEm8BYHxpsKo01dfzH46NjjEIAF4ZNuU9IMcB9GyhgAbWBTFhI2mi
         LTQ0/2f+14CVf8X0mLBENM4ezqsrWYKz8eaZSZYkSMxIDj0/wmGR7eG3jSu6eJ5bnTPy
         m5li7XNcwJ6fSP9jm+LYBrHU7cu6bvVf+J/cK9liKVn1yESfQ6lDs14vy+zXnEVd4l+F
         rG9VkqW8C0vbLnMk/8bVx3CoxWiEZ6Zn4dIJ3svdBJ5Kk/sj5aRJ1YItGrN39+OjZkel
         Iltd7XHNJZBOWlAcrefRRYciL6JtA4EE3A5YNnMCMpMvgPlm9Lbmg16cSIMmHU17BGs7
         WNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430956; x=1763035756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLAnUrDI2pvarEVlAqbKGGVmDyTWyIE6rE0vKb5WBQQ=;
        b=Lra98hKp1XwPSGZBeBoUbaclDrso0KPaw5a4ieI4ZLpUu2P8oX9y0pNVO+5n5bdFK1
         sKWJKPxQD71/RgVkVTJWZQYmzcSLDtj9AlujuXyHtzIWylrRf2KiV3Ex2iqtJ7vFRVvO
         tMdm62Dtuw3KLXn2PEiqIkTUALNCGBaZGIUnGcdC7nap97ZVhubYaZgDlAScjRH8PDeZ
         XLxK5NR5MO5Cws4WMVUrkynQpQg4992fJ47swbRr4Ex4prdJmE1zX3ozWJhkM8zUfx86
         mWuC7ZIXeyGsRbbanLOmQQcN7Yv6Ixvmdz4aR32k6Df1RunY5YCzut1yBiZnZGxYATNl
         ctLw==
X-Forwarded-Encrypted: i=1; AJvYcCV/bdPg1fhEqi1EPscCMUOSV7BY9Kt30Guo7kFW/GwajvV38w1J3XI7ZYeeUJ9mSwPs7GXVW/FRNWVpCtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySFLXAfwTFt6ihWPDla7SjCq/XvIuKEnaSzorzLX2LEHc7PUT6
	sK59Fnxvw0AdhVjZbsZnAOYGBw6lIDVBt5HFiqhVeYkJGPejLutjEk7NdtxE7Bpv+3A6m4Z+s4Q
	tLieBLy3e8vbSMffrDg==
X-Google-Smtp-Source: AGHT+IHZKqqI2XUnv1NqDn2nFtMCabo5jj2vf8iQOxGK0AI5f769IUV6PRuiKrcsKGUscO20SxePO1gXrhAmLq8=
X-Received: from ejcre5.prod.google.com ([2002:a17:907:a2c5:b0:b70:b6ce:57a8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:26ce:b0:b70:4757:eb01 with SMTP id a640c23a62f3a-b72654ce415mr682874866b.32.1762430955652;
 Thu, 06 Nov 2025 04:09:15 -0800 (PST)
Date: Thu, 06 Nov 2025 12:09:02 +0000
In-Reply-To: <20251106-resource-phys-typedefs-v1-0-0c0edc7301ce@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106-resource-phys-typedefs-v1-0-0c0edc7301ce@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4638; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=N05CdPPb9ETL4l1CnNbsvW0DFUOjIo2ix3kfvkTeeCc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpDI/mVsDWdH65xZZn0wJf/1RF4wWgKuZEvMdiG
 VquKb2PwfmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQyP5gAKCRAEWL7uWMY5
 RumYD/sHpobC8Tj/jMQH5LPcsb9Ubds4RBkAdtKQxvMttfZPvjXUyzmfZce14LgEWE4V1kLRDsU
 gZrbGW4u2mb0IpcRpkKDZz3DowMuh1tX0Nn/+2xJ0Dn+oov3553j5cXBO3fPoThhWvxaJ4zlb4t
 wcxfBYCmyK/NyvfHOun6F+Mu4FhFAmMcY51vTglSyHOJ54VyOvBLeiVTUpf8joPwnQRuH5slaAb
 sXOO82yccX1CU3aKF5GchQGG1C/Af+u0BePT3rER1zbv5yaLZ/PWDyjuRZOQZwHZ2NalV3gcj20
 WIqK1zowXfOYofFQ9qhNIlQDV/ZCpMB/YQdBd2kl85ztjseJtREj0tC12oLfmbG0V+TYTeh9qFY
 YnDuK7bJdOco2m8jtnfW6DiqI7IdZ/4FZeXrrd5anxCKIhaV4GkqYu+qNC/qVb/3raInEXAcjtP
 ntuxDtK5wGoFwzrK6P18BrMQqKuqihJ4ywflxLhoea2hWaGT28Q2AOZ8gRE/9RhPZytbNJEZGpZ
 lkxVsRzqDDi1L0ex9Y/An/CnW2HFqVBB/ZBfV7IUq9XShkgvuepUu0E+0WJVl/+E42nWAh3+LyM
 Q0176J+kGY3TY/sJuBritWrTYWG+CmB26jzhYQ5AVzC4OBgYj252mkGGxTNXAvCQgR35pzIzDyp 3drIolvaqL9X9KQ==
X-Mailer: b4 0.14.2
Message-ID: <20251106-resource-phys-typedefs-v1-4-0c0edc7301ce@google.com>
Subject: [PATCH 4/4] rust: io: add typedef for phys_addr_t
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The C typedef phys_addr_t is missing an analogue in Rust, meaning that
we end up using bindings::phys_addr_t or ResourceSize as a replacement
in various places throughout the kernel. Fix that by introducing a new
typedef on the Rust side. Place it next to the existing ResourceSize
typedef since they're quite related to each other.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/devres.rs      | 18 +++++++++++++++---
 rust/kernel/io.rs          | 20 +++++++++++++++++---
 rust/kernel/io/resource.rs |  9 ++++++---
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 10a6a17898541d4a0f01af41f68e3ab3d6bb0aca..e01e0d36702d38e9530a2fa4be884c935c6b5d0c 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -52,8 +52,20 @@ struct Inner<T: Send> {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
-/// # use core::ops::Deref;
+/// use kernel::{
+///     bindings,
+///     device::{
+///         Bound,
+///         Device,
+///     },
+///     devres::Devres,
+///     io::{
+///         Io,
+///         IoRaw,
+///         PhysAddr,
+///     },
+/// };
+/// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
 /// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
@@ -66,7 +78,7 @@ struct Inner<T: Send> {
 ///     unsafe fn new(paddr: usize) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };
+///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 6465ea94e85d689aef1f9031a4a5cc9505b9af6e..56a435eb14e3a1ce72dd58b88cbf296041f1703e 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -13,6 +13,12 @@
 
 pub use resource::Resource;
 
+/// Physical address type.
+///
+/// This is a type alias to either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
+pub type PhysAddr = bindings::phys_addr_t;
+
 /// Resource Size type.
 ///
 /// This is a type alias to either `u32` or `u64` depending on the config option
@@ -68,8 +74,16 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
-/// # use core::ops::Deref;
+/// use kernel::{
+///     bindings,
+///     ffi::c_void,
+///     io::{
+///         Io,
+///         IoRaw,
+///         PhysAddr,
+///     },
+/// };
+/// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
 /// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
@@ -82,7 +96,7 @@ pub fn maxsize(&self) -> usize {
 ///     unsafe fn new(paddr: usize) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };
+///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index 7fed41fc20307fa7ce230da4b7841743631c965e..5d9d9f01d91c3b8b13e4837d4fb19a786d7720c8 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -12,7 +12,10 @@
 use crate::str::{CStr, CString};
 use crate::types::Opaque;
 
-pub use super::ResourceSize;
+pub use super::{
+    PhysAddr,
+    ResourceSize, \\
+};
 
 /// A region allocated from a parent [`Resource`].
 ///
@@ -93,7 +96,7 @@ impl Resource {
     /// the region, or a part of it, is already in use.
     pub fn request_region(
         &self,
-        start: ResourceSize,
+        start: PhysAddr,
         size: ResourceSize,
         name: CString,
         flags: Flags,
@@ -127,7 +130,7 @@ pub fn size(&self) -> ResourceSize {
     }
 
     /// Returns the start address of the resource.
-    pub fn start(&self) -> ResourceSize {
+    pub fn start(&self) -> PhysAddr {
         let inner = self.0.get();
         // SAFETY: Safe as per the invariants of `Resource`.
         unsafe { (*inner).start }

-- 
2.51.2.1026.g39e6a42477-goog


