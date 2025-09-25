Return-Path: <linux-kernel+bounces-833062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED769BA11DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF221C25928
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF2631B13A;
	Thu, 25 Sep 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+a5CRLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E090433AD;
	Thu, 25 Sep 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827052; cv=none; b=moiHec+m1huaxo3QOXgS71L/T5hl+6pbFUKXIqIMLvnAr4wx26Hxn7brHCdFJbWHxSvrTc9Khgd4u139jAybTECkekuu7Fk5UfxyKnoOTSaY1s4DrruzjhHJp8Vx/nW2N6Y7F/ZjtxjL8KywOwTkiaPZJv4Km8av9+xkQJNkx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827052; c=relaxed/simple;
	bh=N6v2jkTUHnCqmnp1COA6psS3T3ctdEwwXHagC9u+U8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQP0heKJB+onuXxAnuCsH3bdtT5LRzJmv0QHmUneHcK+UO21drLVQWm1py2jo318RHTaoHehP3kmlGqMZH31kSDrMiEU5zpbwzlO0sWSVufGV2sPutIW7W1f2S1OfpS3Hxz6Hau0hbli1kzueX8exMx+fnh9tJ2kliALMVt1T24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+a5CRLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658EAC4CEF0;
	Thu, 25 Sep 2025 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758827051;
	bh=N6v2jkTUHnCqmnp1COA6psS3T3ctdEwwXHagC9u+U8M=;
	h=From:To:Cc:Subject:Date:From;
	b=S+a5CRLt92ql5PQkxlj49nDNMPkR2Lbv52Y9MV2jfoxYK3FhS9cCDkMOrUuUpGCLV
	 fwiIsv4bT15pCZDup/hDGJcEW2gf0pSFI/esHjGe74iM/5q9qo+XFidQhx/zqmBx3P
	 KYmPu/ME+Ut21F6DfAyYd7c/e6GtRNG4s80+VGXuXr49px7wdIHvzYURwsWSdTjVJK
	 kAOhhxuyud9mAcn7QGogIYwbNrwwGdXmCjxYQo+qMB9MmnTFjlqujOkCxzuzi78D4w
	 R20TFmcQBexNiXPgtP4SWl16dR1b3723z4nWKrXXKJfiz5bOfamU79F5AiU8/r0P4C
	 SKadjKOfH0hFQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/2] rust: usb: don't retain device context for the interface parent
Date: Thu, 25 Sep 2025 20:59:26 +0200
Message-ID: <20250925190400.144699-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deriving the parent USB device (struct usb_device) from a USB
interface (struct usb_interface), do not retain the device context.

For the Bound context, as pointed out by Alan in [1], it is not
guaranteed that the parent USB device is always bound when the interface
is bound.

The bigger problem, however, is that we can't infer the Core context,
since eventually it indicates that the device lock is held. However,
there is no guarantee that if the device lock of the interface is held,
also the device lock of the parent USB device is held.

Hence, fix this by not inferring any device context information; while
at it, fix up the (affected) safety comments.

Link: https://lore.kernel.org/all/0ff2a825-1115-426a-a6f9-df544cd0c5fc@rowland.harvard.edu/ [1]
Fixes: e7e2296b0ecf ("rust: usb: add basic USB abstractions")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Deriving the parent device will be needed (at least from within the
abstraction), hence I kept the AsRef implementation and only dropped the
inferred device context information.

Regardless, I'm not sure AsRef is really what we want here. A simple
Interface::parent() method seems more appropriate to me, but this patch focuses
on fixing the bug, hence I kept AsRef.
---
 rust/kernel/usb.rs | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 8899e7520b58..955fd93b6f52 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -340,14 +340,13 @@ fn as_ref(&self) -> &device::Device<Ctx> {
     }
 }
 
-impl<Ctx: device::DeviceContext> AsRef<Device<Ctx>> for Interface<Ctx> {
-    fn as_ref(&self) -> &Device<Ctx> {
-        // SAFETY: `self.as_raw()` is valid by the type invariants. For a valid interface,
-        // the helper should always return a valid USB device pointer.
+impl<Ctx: device::DeviceContext> AsRef<Device> for Interface<Ctx> {
+    fn as_ref(&self) -> &Device {
+        // SAFETY: `self.as_raw()` is valid by the type invariants.
         let usb_dev = unsafe { bindings::interface_to_usbdev(self.as_raw()) };
 
-        // SAFETY: The helper returns a valid interface pointer that shares the
-        // same `DeviceContext`.
+        // SAFETY: For a valid `struct usb_interface` pointer, the above call to
+        // `interface_to_usbdev()` guarantees to return a valid pointer to a `struct usb_device`.
         unsafe { &*(usb_dev.cast()) }
     }
 }

base-commit: c584a1c7c8a192c13637bc51c7b63a9f15fe6474
-- 
2.51.0


