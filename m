Return-Path: <linux-kernel+bounces-741083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32341B0DFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36FA17C5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC732ECD24;
	Tue, 22 Jul 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8Z4wTCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4D2EBDE0;
	Tue, 22 Jul 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196484; cv=none; b=hV881vHPDqb/avgKcUCMzyKRaA9ngxtG6iwJIGxxpAk7AEQAfc48Bs/QDmy4Ftm7EsyLDqfwPWPUXL/FDna/z6vpfTHTyto+MdBLnOxwmNfsFsJnMj9yGNRx1Xp7WUQxnntTQxbCAmt0lUrAzuNtOEyI6vYv2HMw9DdlY851t10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196484; c=relaxed/simple;
	bh=kbZWRBa133EyVivWNfo1Ul3K7i+pBTVUEjE7NjH9MBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+uI6ibcxH8OL5YAzKRYEKfWx2dsr+JirGXoqqomsCJvRlffrGCLaxYLfirD7TG3GVBWF9zKkralgJkLwh0VcoRxF8mmNpCI93uGnng/PsW1VNXhy33M2u+3D1BhpEgNTwsCZF3u65o7lgqSyLbXA6oIzorgZDx5lj9z2UvBYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8Z4wTCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4B1C4CEF6;
	Tue, 22 Jul 2025 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196483;
	bh=kbZWRBa133EyVivWNfo1Ul3K7i+pBTVUEjE7NjH9MBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8Z4wTCf0+vYr2bTPcGLUdO4gDQBfhPmmiAfSstCLmqcGos4IavqLT3+le8QZ7wKJ
	 cbSnyAWGasW5aem4f/Cv9CWfB3AnQVwepNevQf3zrNTIoRis+hYDXx2qbrDL35f/fK
	 dEDnQSl1LsBnLbQgBEOZMKJvOsLpZv4x7XiKO2S55DrSxUfMzflwpNiC1vW8e4ttdL
	 spmFP8Lns9tpszA7e4AS1xfQDdUNfFLR1Atq2fOItNJ9zsn1QO0/5eFjSysxlCy4Mv
	 2uYC5Sbfv15kqdcgKSJZyffcFe2PiS2w4MjcfoCsK095PbZ8vPoR7jjRnMR8DiDe4/
	 +uC+rIl15wpcw==
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
Subject: [PATCH v2 1/3] device: rust: expand documentation for DeviceContext
Date: Tue, 22 Jul 2025 16:59:59 +0200
Message-ID: <20250722150110.23565-2-dakr@kernel.org>
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

Expand the documentation around DeviceContext states and types, in order
to provide detailed information about their purpose and relationship
with each other.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 69 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index ca82926fd67f..f5d1db568f00 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -311,28 +311,75 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
-/// Marker trait for the context of a bus specific device.
+/// Marker trait for the context or scope of a bus specific device.
 ///
-/// Some functions of a bus specific device should only be called from a certain context, i.e. bus
-/// callbacks, such as `probe()`.
+/// [`DeviceContext`] is a marker trait for types representing the context of a bus specific
+/// [`Device`].
 ///
-/// This is the marker trait for structures representing the context of a bus specific device.
+/// The specific device context types are: [`CoreInternal`], [`Core`], [`Bound`] and [`Normal`].
+///
+/// [`DeviceContext`] types are hierarchical, which means that there is a strict hierarchy that
+/// defines which [`DeviceContext`] type can be derived from another. For instance, any
+/// [`Device<Core>`] can dereference to a [`Device<Bound>`].
+///
+/// The following enunumeration illustrates the dereference hierarchy of [`DeviceContext`] types.
+///
+/// - [`CoreInternal`] => [`Core`] => [`Bound`] => [`Normal`]
+///
+/// Bus devices can automatically implement the dereference hierarchy by using
+/// [`impl_device_context_deref`].
+///
+/// Note that the guarantee for a [`Device`] reference to have a certain [`DeviceContext`] comes
+/// from the specific scope the [`Device`] reference is valid in.
+///
+/// [`impl_device_context_deref`]: kernel::impl_device_context_deref
 pub trait DeviceContext: private::Sealed {}
 
-/// The [`Normal`] context is the context of a bus specific device when it is not an argument of
-/// any bus callback.
+/// The [`Normal`] context is the default [`DeviceContext`] of any [`Device`].
+///
+/// The normal context does not indicate any specific context. Any `Device<Ctx>` is also a valid
+/// [`Device<Normal>`]. It is the only [`DeviceContext`] for which it is valid to implement
+/// [`AlwaysRefCounted`] for.
+///
+/// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
 pub struct Normal;
 
-/// The [`Core`] context is the context of a bus specific device when it is supplied as argument of
-/// any of the bus callbacks, such as `probe()`.
+/// The [`Core`] context is the context of a bus specific device when it appears as argument of
+/// any bus specific callback, such as `probe()`.
+///
+/// The core context indicates that the [`Device<Core>`] reference's scope is limited to the bus
+/// callback it appears in. It is intended to be used for synchronization purposes. Bus device
+/// implementations can implement methods for [`Device<Core>`], such that they can only be called
+/// from bus callbacks.
 pub struct Core;
 
-/// Semantically the same as [`Core`] but reserved for internal usage of the corresponding bus
+/// Semantically the same as [`Core`], but reserved for internal usage of the corresponding bus
+/// abstraction.
+///
+/// The internal core context is intended to be used in exactly the same way as the [Core] context,
+/// with the difference that this [`DeviceContext`] is internal to the corresponding bus
 /// abstraction.
+///
+/// This context mainly exists to share generic [`Device`] infrastructure that should only be called
+/// from bus callbacks with bus abstractions, but without making them accessible for drivers.
 pub struct CoreInternal;
 
-/// The [`Bound`] context is the context of a bus specific device reference when it is guaranteed to
-/// be bound for the duration of its lifetime.
+/// The [`Bound`] context is the [`DeviceContext`] of a bus specific device when it is guaranteed to
+/// be bound to a driver.
+///
+/// The bound context indicates that for the entire duration of the lifetime of a [`Device<Bound>`]
+/// reference, the [`Device`] is guaranteed to be bound to a driver.
+///
+/// Some APIs, such as [`dma::CoherentAllocation`] or [`Devres`] rely on the [`Device`] to be bound,
+/// which can be proven with the [`Bound`] device context.
+///
+/// Any abstraction that can guarantee a scope where the corresponding bus device is bound, should
+/// provide a [`Device<Bound>`] reference to its users for this scope. This allows users to benefit
+/// from optimizations for accessing device resources, see also [`Devres::access`].
+///
+/// [`Devres`]: kernel::devres::Devres
+/// [`Devres::access`]: kernel::devres::Devres::access
+/// [`dma::CoherentAllocation`]: kernel::dma::CoherentAllocation
 pub struct Bound;
 
 mod private {
-- 
2.50.0


