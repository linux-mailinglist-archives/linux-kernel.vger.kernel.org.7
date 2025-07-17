Return-Path: <linux-kernel+bounces-736035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E132B09704
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A28567648
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820072417C2;
	Thu, 17 Jul 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGHsz+tV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3223E34C;
	Thu, 17 Jul 2025 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792500; cv=none; b=I3wJ2BUaLUJXOOhSRsxwBlrPJcDf5MBjeYuvka846BzrTQZmuhOMovK0x6aDIj+SMZTbrIFBiJC7AWdlUOJ2n/mSAQvGLXHnQumKsMLP2+/UOl3T9Ow02ByIpfEcLORKmOKR/Vpmqi4qC0rneDRaCVGAqnJnHPo6qK6DWu9iq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792500; c=relaxed/simple;
	bh=NSomQBe9GsxuecBlz9tHDynvoC2dGHK58amK9Fm823s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcvYc76hterUw5F0MBRbX5D1EjcD2wM3PCziyBfE4ST5ThcFvaxG66A/9hG6i/vJy1CXBUyXl3UXQgE56jTUzf+4nu3Fxs9BrkatOAUp6tAPeJBW/OwcK5OOlAQgjkXMvpTEQ3Hbc/XOnXe76mOg60tqR8F4iJvEpqVzbhC5U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGHsz+tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BAFC4CEEB;
	Thu, 17 Jul 2025 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752792500;
	bh=NSomQBe9GsxuecBlz9tHDynvoC2dGHK58amK9Fm823s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGHsz+tVPYdLfAclOygHZ9kC16UypYZ+dhDHjQVv/mGFz1YvotwRE5miTK+xUTF77
	 uMkBfag8qLryEBxHTH9cHUp/CLUah/CDJ4cuLBN97KY71W8M9eJYEQqmnhxKLkDO9R
	 YTO3dEbSD+G+hHCbBNwnDfcXgyuxa/NOWkMRVFfMUzhK3aHIZpJFoxlEM8BijKEgGq
	 PVn20sL0BxyYhTTjBIENEflrrAvKjWXtFDqcvUc4rXDQ0cjAoyM+CerBAcGvUq/gH1
	 J7a4VSrqhMtjucGsq5/M945JAvdmQkeMo9pevVbx2wyjTNoOx9NmZuZXtdqh6V/KZw
	 pxfPvKEvBOp4A==
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
Subject: [PATCH 1/3] device: rust: documentation for DeviceContext
Date: Fri, 18 Jul 2025 00:45:37 +0200
Message-ID: <20250717224806.54763-2-dakr@kernel.org>
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

Expand the documentation around DeviceContext states and types, in order
to provide detailed information about their purpose and relationship
with each other.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 63 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index ca82926fd67f..d7ac56628fe5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -311,28 +311,69 @@ unsafe impl Send for Device {}
 // synchronization in `struct device`.
 unsafe impl Sync for Device {}
 
-/// Marker trait for the context of a bus specific device.
+/// Marker trait for the context or scope of a bus specific device.
 ///
-/// Some functions of a bus specific device should only be called from a certain context, i.e. bus
-/// callbacks, such as `probe()`.
+/// [`DeviceContext`] is a marker trait for structures representing the context of a bus specific
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
+/// - [`Core`] => [`Bound`] => [`Normal`]
+/// - [`Bound`] => [`Normal`]
+/// - [`Normal`]
+///
+/// Bus devices can automatically implement the dereference hierarchy by using
+/// [`impl_device_context_deref`](kernel::impl_device_context_deref).
 pub trait DeviceContext: private::Sealed {}
 
-/// The [`Normal`] context is the context of a bus specific device when it is not an argument of
-/// any bus callback.
+/// The [`Normal`] context is the default [`DeviceContext`] of any [`Device`].
+///
+/// The normal context does not indicate any specific scope. Any `Device<Ctx>` is also a valid
+/// [`Device<Normal>`]. It is the only [`DeviceContext`] for which it is valid to implement
+/// [`AlwaysRefCounted`](kernel::types::AlwaysRefCounted) for.
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
 /// abstraction.
+///
+/// The internal core context is intended to be used in exactly the same way as the [Core] context,
+/// with the difference that this [`DeviceContext`] is internal to the corresponding bus
+/// abstraction.
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
+/// Some APIs, such as [`dma::CoherentAllocation`](kernel::dma::CoherentAllocation) or
+/// [`Devres`](kernel::devres::Devres) rely on the [`Device`] to be bound, which can be proven with
+/// the [`Bound`] device context.
+///
+/// Any abstraction that can guarantee a scope where the corresponding bus device is bound, should
+/// provide a [`Device<Bound>`] reference to its users for this scope. This allows users to benefit
+/// from optimizations for accessing device resources, see also
+/// [Devres::access](kernel::devres::Devres::access).
 pub struct Bound;
 
 mod private {
-- 
2.50.0


