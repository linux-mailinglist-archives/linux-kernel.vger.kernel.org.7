Return-Path: <linux-kernel+bounces-878702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC3C2145D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCE51887683
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F52DC76E;
	Thu, 30 Oct 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9vG+i0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A001EB9E3;
	Thu, 30 Oct 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842722; cv=none; b=jCUyT3RMftXX7tDytPovxHzrjs8LVdSLPLCGlPMoF0qvLIYqhCjhFuao0CyyU0P2Fb4qtEsjjU8O59HZv4nuw1SFmOMPsAgiaMQX6TdV6z4MuSqMB0b4DYqNzR3SsH39bsnWG79eJBvdRToJ+lBLL8MeEjmWR3wyZuxHSMbPzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842722; c=relaxed/simple;
	bh=xzlnOd+BDMQZpVnDvoR3rOJ0bk8ts5A2qYar3yNZMM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f5TUe66d9e2aB12ztSdhKeZFi9n5kCse5UFuJs8XGAkQ2fC+X0kLgDI+SPirdrqe7eU+bD+QP/pQOrZUAhsBnsvjV9EcIATqHxe/MyM54HeTDCYQM4qmcadv7kDrujjBV4mcjKlA+vBFJYste/txSB1cw8gz/rnY+zYuPkkXKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9vG+i0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B51E8C4CEF8;
	Thu, 30 Oct 2025 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842720;
	bh=xzlnOd+BDMQZpVnDvoR3rOJ0bk8ts5A2qYar3yNZMM0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=S9vG+i0V6SsaPUMBmAf5yz4lQ2C8fFu4IwF+6IYe7IEMz6w9/0Wx2NrESLqwOAbf6
	 ZTeqYcimVnd+CmPKa6JpnMwBVLJP8pH8kjTcYKJT4qu0YkCbNR2/lfeDoSxoc6FicF
	 Auht/rI5J0iG0D6BXShZ9o5QzfoLMCuit5MS4KXEWuV/qq6O7pXvpT7vRJlT5K4De1
	 l00QUWEDUggKpYdm7Rip3ve90V0aDaYl09IXrFxpgDG4J9t+FSWNO+Y1xd+/LKpNxC
	 85LZUKW31NKmpnrzBDxD72lRbvBS4MVdStc1uRQcavvXPTGprMd3iLAF73BVbKC1HL
	 Vez61YoSlf0ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED6CCF9F0;
	Thu, 30 Oct 2025 16:45:20 +0000 (UTC)
From: Moritz Zielke via B4 Relay <devnull+moritz.zielke.gmail.com@kernel.org>
Date: Thu, 30 Oct 2025 17:44:31 +0100
Subject: [PATCH] rust: of: replace `core::mem::zeroed` with
 `pin_init::zeroed`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-zeroed-of-rs-v1-1-1c46d025128e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO6VA2kC/x2MSQqAMAwAvyI5G+iCCn5FPGibai5WUhCx+HeDx
 xmYqVBImAqMTQWhiwvnQ8G2DYR9OTZCjsrgjOus8QYfkkwRc0IpuPS0qrc++AE0OYUS3/9umt/
 3A1BRE05eAAAA
X-Change-ID: 20251030-zeroed-of-rs-a6eb25113c37
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, devicetree@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Moritz Zielke <moritz.zielke@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761842708; l=1541;
 i=moritz.zielke@gmail.com; s=20251030; h=from:subject:message-id;
 bh=oIbp+tyuhn5HEWfpBG4m5GYtbBRXvFJksWeRXP7Pve8=;
 b=nVSJxWlhTP77ybCN9R8/EXC779jPXMDH3CHQznrpLng3wflemW1OpE5FHX1dszUuUZPcvV7ls
 7MUgAXipLVRBqnYWafoFPWmnacrNmYI5nTBq92cthKH57XvAS0Vo+Q9
X-Developer-Key: i=moritz.zielke@gmail.com; a=ed25519;
 pk=TFwYpZ0YPwD8idGzvlafpvAW4DDA0FrkMEjcfZVXkN0=
X-Endpoint-Received: by B4 Relay for moritz.zielke@gmail.com/20251030 with
 auth_id=558
X-Original-From: Moritz Zielke <moritz.zielke@gmail.com>
Reply-To: moritz.zielke@gmail.com

From: Moritz Zielke <moritz.zielke@gmail.com>

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

---
This patch was suggested in the linked issue. It's my first attempt
of sending a patch to the kernel mailing list.

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Moritz Zielke <moritz.zielke@gmail.com>
---
 rust/kernel/of.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 58b20c367..cfcfbb1fd 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -35,9 +35,7 @@ impl DeviceId {
     /// Create a new device id from an OF 'compatible' string.
     pub const fn new(compatible: &'static CStr) -> Self {
         let src = compatible.to_bytes_with_nul();
-        // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
-        // SAFETY: FFI type is valid to be zero-initialized.
-        let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };
+        let mut of: bindings::of_device_id = pin_init::zeroed();
 
         // TODO: Use `copy_from_slice` once stabilized for `const`.
         let mut i = 0;

---
base-commit: 3b1728b74a52e8489f0c7bfd3d682572dd9901de
change-id: 20251030-zeroed-of-rs-a6eb25113c37

Best regards,
-- 
Moritz Zielke <moritz.zielke@gmail.com>



