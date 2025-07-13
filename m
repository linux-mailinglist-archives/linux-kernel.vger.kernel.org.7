Return-Path: <linux-kernel+bounces-729163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1AEB032A2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A518983C1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C32288C2C;
	Sun, 13 Jul 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alL94msN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21092A48;
	Sun, 13 Jul 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752431273; cv=none; b=ACnGdDwfisJo1UwiXYvmTWtfb77EcppT7wpTIjgbK+N9tsgPiTM2TtmIESrU/zjFrlHlzuExF8ru0JDnEEoJWJONBpwJicq3+BmRyfml5RWxHwNCrX9DcXbkFNDSKatUl2ITnPrj5iVlq+aGkY7YWuPYB14eXZFLQT4RG+L1vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752431273; c=relaxed/simple;
	bh=OzlpZJZALrlo5WBtjzNdgTc/k+OR1AFYyuUcJrfeK1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S565UNQgAr8CO58PiUh7fYT/dx3smp7fEOBt5H5LazgasPVR3nLPPvwThWrTBpc0jqlacszYk0OIyZMS3PVBo6IkMfECsLfBg0bLUupVz9zls2VjtzrgfddtTwzkPVSQ8xSi0gIDcQX8dRJa9owfoMYYSRy6sD2vBN93iYeHCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alL94msN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92321C4CEE3;
	Sun, 13 Jul 2025 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752431272;
	bh=OzlpZJZALrlo5WBtjzNdgTc/k+OR1AFYyuUcJrfeK1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alL94msNyukggaAR3fwKW0bqEKbuXrPtGtQYJETCfm85BZoYg5+chig2N7sJGhvpg
	 HBSGB3quymTPB3OJRMPemuLpkx9zVnvvkki3x/M8ykr+vxNv9hDPNkUQnsSlrFObuK
	 C95MHmgz48nq6ENz8XlLp/qCatshTxtr5RuYkHnYq0SmgWtnfORAtemVM7NkN7klnm
	 ZvCiU9eRYPFQ4KbDUdJ/E4sqmkXa+Q2TinA27SlYmVItpKdx9fJnkG+xJfDE8x+VFm
	 ALWRISMlLgj8OAHmi3UREOq/pOy/dg0NyaixpjqHva6qSTRSEfQiET46iH7rIwH+e/
	 +qGb9YIgUEECw==
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
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	m.wilczynski@samsung.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/2] rust: device: implement Device::as_bound()
Date: Sun, 13 Jul 2025 20:26:54 +0200
Message-ID: <20250713182737.64448-2-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250713182737.64448-1-dakr@kernel.org>
References: <20250713182737.64448-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an unsafe functions for abstractions to convert a regular
&Device to a &Device<Bound>.

This is useful for registrations that provide certain guarantees for the
scope of their callbacks, such as IRQs or certain class device
registrations (e.g. PWM, miscdevice).

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index d527ceef829e..4d9b052afe92 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -60,6 +60,25 @@ pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
         // SAFETY: By the safety requirements ptr is valid
         unsafe { Self::as_ref(ptr) }.into()
     }
+
+    /// Convert a [`&Device`](Device) into a [`&Device<Bound>`](Device<Bound>).
+    ///
+    /// # Safety
+    ///
+    /// The caller is responsible to ensure that the returned [`&Device<Bound>`](Device<Bound>)
+    /// only lives as long as it can be guaranteed that the [`Device`] is actually bound.
+    pub unsafe fn as_bound(&self) -> &Device<Bound> {
+        let ptr = core::ptr::from_ref(self);
+
+        // CAST: By the safety requirements the caller is responsible to guarantee that the
+        // returned reference only lives as long as the device is actually bound.
+        let ptr = ptr.cast::<Device<Bound>>();
+
+        // SAFETY:
+        // - `ptr` comes from `from_ref(self)` above, hence it's guaranteed to be valid.
+        // - Any valid `Device` pointer is also a valid pointer for `Device<Bound>`.
+        unsafe { &*ptr.cast() }
+    }
 }
 
 impl Device<CoreInternal> {
-- 
2.50.0


