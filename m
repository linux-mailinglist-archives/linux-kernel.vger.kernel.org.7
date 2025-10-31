Return-Path: <linux-kernel+bounces-879871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5ACC244BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E0B3B67A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA594334395;
	Fri, 31 Oct 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMN9VW77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FD333455;
	Fri, 31 Oct 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904337; cv=none; b=BmpsWVfHmC94ZzdjfWaLLwT+Mm1Sfd5dTWwFDBQvQrfGS+P5wLS7RBW2efMMZhdnCd5vokrXM1liLfrtZH5aPtAsoS3WQoqBtGMOLC3Gw4cOVSsJSPAFzOHje6jr92oLoE0tiJQWDhBLFT2B7MgicQeG/Gd+w4n8RQPO0mhzX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904337; c=relaxed/simple;
	bh=HSkp7jDPDeQP9HFJEf48wH+0XtSGqoD1qmTPOJL9w5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DA5ULdceO3KorXsMe6XHZjRA8HLvVXHNcEQomDHxHAYdT15EXjFbiKiPMvjRlLd943jnpgpBmAaT4BWtCNoR/DztT4qEM/eZXEX/yfsjxRg7lSmBosh/Mz0MqUv3hnUlO1AeINTdIpngNiXCBkn79kMXYpT3ZqHWS7EY1gsMJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMN9VW77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87468C4CEE7;
	Fri, 31 Oct 2025 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761904334;
	bh=HSkp7jDPDeQP9HFJEf48wH+0XtSGqoD1qmTPOJL9w5Y=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gMN9VW77/ZfrX/TcZ4QdmnshcEs47rr1HukdvApfBak6tZ+35jYBavIJCxCtNkh5O
	 dYGjTKtL2ZNInBzTDujmmkJq/rpErNeIn0bWRzUmZ4rjytxg6azm0nP5rrlohYRIAl
	 a6XK8derUi+bE5qOglBuAC0VZbZJxJ0cFhLIh/RXtDt75Q5XgWUl45rkHVqi7ALAqH
	 TtQKrI/rsXOpycH9zQ1ky5T1wsuGHbPzH0/xeUb/YjXvE95DXG8q0nLxQRdqCvhBid
	 72oBjYbNAzBhHXHruY7pNh3Dn1zn4SD9kvM46cVjdfMVnYGYN8Y7WKh9UW4Il9n8Nn
	 qaEgBvrb3x5Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7862FCCF9F8;
	Fri, 31 Oct 2025 09:52:14 +0000 (UTC)
From: Moritz Zielke via B4 Relay <devnull+moritz.zielke.gmail.com@kernel.org>
Date: Fri, 31 Oct 2025 10:51:41 +0100
Subject: [PATCH v2] rust: of: replace `core::mem::zeroed` with
 `pin_init::zeroed`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-zeroed-of-rs-v2-1-f89ff71e943e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKyGBGkC/3WMzQrCMBCEX6Xs2ZX8aBVPvof0EJNtu2Ab2UhQS
 97dtHeZ0zfDfAskEqYEl2YBocyJ41zB7Brwo5sHQg6VwShz1Moq/JJEChh7lISupXvttfX2BPX
 yFOr5veluXeWR0yvKZ7NnvbZ/RFljjT+0YZ3Nma7D5Pix93GCrpTyA1wqvbyoAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761904321; l=1602;
 i=moritz.zielke@gmail.com; s=20251030; h=from:subject:message-id;
 bh=OnB3GPr22kqGecRkpj0YRj3co22bJtrQhNK1vieBomQ=;
 b=Tufu5yszhlo2brG2pyeFgV4tCFZzPlNkr6s0GwoPI8AGFxG3XMtjYWQHPa0vo82qs48v2pVfR
 FfQiIru0qadDaT+DakTg6GW4g6dhFxWCKILAYH/bdgswfukqVuONS4W
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

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Moritz Zielke <moritz.zielke@gmail.com>
---
Changes in v2:
- Rearrange tags and `---` so tags don't get lost when patch is applied
- Link to v1: https://lore.kernel.org/r/20251030-zeroed-of-rs-v1-1-1c46d025128e@gmail.com
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



