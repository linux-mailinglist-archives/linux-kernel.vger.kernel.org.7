Return-Path: <linux-kernel+bounces-841825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D226BB854B
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EBE4C3CEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DC2F1FEC;
	Fri,  3 Oct 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM2scPTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343E2882D3;
	Fri,  3 Oct 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530484; cv=none; b=WPjq4B20E1HiyRWvHbBAnZNz49RYNPuwOQ89CuL1WxKie/L37LzQVMHGKvoGxAyI7qBUiRVKG6L4uiEuamL9amu720RiSMZnzBnrgqVcW5sFNNDWk8/0Em0AiDZMvhpnSDV8HrzLMg3AV9VTJRO1t3dPssXs2Yclfkhk74Jydwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530484; c=relaxed/simple;
	bh=aDaaWLZWxHoJ8yRtUHn3xfnO38OT1PRhYVazKvf9Jn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpMr4yQkahRxDSsb1X2nnDzNh+ceNUc9IxNJ3wfrjetI3Erf4dulWlz3dWapKkhZ5Lx8x02R7QFcUx8xjvj9Oz9sL5Q2CNSjG+SOKxH5OD4K0dJOatjD4v/2IWD+SPfSD2nFDBDkP8gkTbI8pna+lRAH/bicg7FDVlJmS5jOztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM2scPTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6D8C4CEF5;
	Fri,  3 Oct 2025 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759530484;
	bh=aDaaWLZWxHoJ8yRtUHn3xfnO38OT1PRhYVazKvf9Jn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PM2scPTpX4mPaC4KOPuJqno8K3q8PjltayT6nBnwIv+jZa5NSAUp2/fEZHF/sImTo
	 i76YsL0apNCONjEnGpISCH8Fzv9KoLk1u8jzATZS14e0U0gz8hiFJsVQCxWw9iXM5g
	 tB5H8r5bLSDRBhAfpPnhhWNYhmAf2jeqYZsJXWyuh8VjW3RFTWFPlad+vgrVBjNSX2
	 A2STlFQqdr/RspvxUEIyl7ZVDI3zcsllBdxYoCfXs+b2m3vkXWZ8VjrHMWkvn4z1lc
	 /76f9urGJ4kOh3GuiU1A0cq+TdQjXGuTJQDyUOZ5/bqx9x7soEEVpco0e2vJfTY2C2
	 7GTdMUST73oog==
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
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 7/7] samples: rust: debugfs_scoped: add example for blobs
Date: Sat,  4 Oct 2025 00:26:44 +0200
Message-ID: <20251003222729.322059-8-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003222729.322059-1-dakr@kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the rust_debugfs_scoped sample to demonstrate how to export a
large binary object through a ScopedDir.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_debugfs_scoped.rs | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/samples/rust/rust_debugfs_scoped.rs b/samples/rust/rust_debugfs_scoped.rs
index b0c4e76b123e..c80312cf168d 100644
--- a/samples/rust/rust_debugfs_scoped.rs
+++ b/samples/rust/rust_debugfs_scoped.rs
@@ -9,6 +9,7 @@
 use core::sync::atomic::AtomicUsize;
 use kernel::debugfs::{Dir, Scope};
 use kernel::prelude::*;
+use kernel::sizes::*;
 use kernel::sync::Mutex;
 use kernel::{c_str, new_mutex, str::CString};
 
@@ -66,18 +67,22 @@ fn create_file_write(
             GFP_KERNEL,
         )?;
     }
+    let blob = KBox::pin_init(new_mutex!([0x42; SZ_4K]), GFP_KERNEL)?;
 
     let scope = KBox::pin_init(
-        mod_data
-            .device_dir
-            .scope(DeviceData { name, nums }, &file_name, |dev_data, dir| {
+        mod_data.device_dir.scope(
+            DeviceData { name, nums, blob },
+            &file_name,
+            |dev_data, dir| {
                 for (idx, val) in dev_data.nums.iter().enumerate() {
                     let Ok(name) = CString::try_from_fmt(fmt!("{idx}")) else {
                         return;
                     };
                     dir.read_write_file(&name, val);
                 }
-            }),
+                dir.read_write_binary_file(c_str!("blob"), &dev_data.blob);
+            },
+        ),
         GFP_KERNEL,
     )?;
     (*mod_data.devices.lock()).push(scope, GFP_KERNEL)?;
@@ -110,6 +115,7 @@ fn init(device_dir: Dir) -> impl PinInit<Self> {
 struct DeviceData {
     name: CString,
     nums: KVec<AtomicUsize>,
+    blob: Pin<KBox<Mutex<[u8; SZ_4K]>>>,
 }
 
 fn init_control(base_dir: &Dir, dyn_dirs: Dir) -> impl PinInit<Scope<ModuleData>> + '_ {
-- 
2.51.0


