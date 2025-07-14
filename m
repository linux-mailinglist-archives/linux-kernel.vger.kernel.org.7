Return-Path: <linux-kernel+bounces-729910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6BB03D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8187B3B78FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7B2459C5;
	Mon, 14 Jul 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc+hqI8E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECE23FC41;
	Mon, 14 Jul 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493045; cv=none; b=V67RZM3WBI2X4hIIAT0JyY4y6Hcfx+tamqVhEgFPgLZXHaJ5mJZ3N7gEjvBHS2aqBKfgdZEc3hLAlL+2qx5gdDdU8dGqNGKacqECUNvBhfirpNbBhR+ehG5OrKsiuCC2VaBeXM3tXO5Ap5BnksHzCLhvEhWnKUBIGRSU7BHl+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493045; c=relaxed/simple;
	bh=cuv+2cfr+Bldf9Y19PH2++tRWlIqk+8yZoZ4chK+j7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgvSJzWt31L1iEtwN3QoMfOz4qPr8SDolHDgdYVjc3iF7pt8Djyp/nldNAWWCTxAVrZHgs/W7ccSNi6vYWge27WAbZOla66E7cn6gbt+Id/8bBLoYCUl0A2wjBuUfOdgAUMyyZmLjEOfHnCM75vfQSiwTcLm7zCTaWoTaoY8DOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc+hqI8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCAAC4CEF9;
	Mon, 14 Jul 2025 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752493044;
	bh=cuv+2cfr+Bldf9Y19PH2++tRWlIqk+8yZoZ4chK+j7A=;
	h=From:To:Cc:Subject:Date:From;
	b=mc+hqI8EDkOr+1SWtcEvwLszJC5vLmZpDSzCGY/2qs/wV4RhJBFZ6jAeNqy1kw0i/
	 8ZoLXG1uOo+BIPk/zwEc5wJhBXE66hs7OgjzRx4eJN6rQKjF0tNVVahhl5jDOmrkxv
	 ZuiMKAep2PFd2aP2geJ2aHhy+cBXIku8TfMxED2x+m8Ny0oZfvGh/R6dDt9BFM3WrE
	 MANAUM0MNLKvZI7Lx9WAnJq9t9yS+y1gnVjDZH9pqx1GVwHFGNGGqhpmydS0OaH+Ad
	 VUhMW8IqLXWKTJaNdoUCrhR1QIXE1CAUsxEOOiNguLj3pLiDUKxroi8SmTAttC3hd/
	 TI7mgj6YukDIA==
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
Subject: [PATCH] rust: devres: initialize Devres::inner::data last
Date: Mon, 14 Jul 2025 13:32:35 +0200
Message-ID: <20250714113712.22158-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users may want to access the Devres object from callbacks registered
through the initialization of Devres::inner::data.

For those accesses to be valid, Devres::inner::data must be initialized
last [1].

Credit to Boqun for spotting this [2].

Link: https://lore.kernel.org/lkml/DBBPHO26CPBS.2OVI1OERCB2J5@kernel.org/ [1]
Link: https://lore.kernel.org/lkml/aHSmxWeIy3L-AKIV@Mac.home/ [2]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index a8a2d24cac24..152a89b78943 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -137,14 +137,10 @@ pub fn new<'a, E>(
         let callback = Self::devres_callback;
 
         try_pin_init!(&this in Self {
-            // INVARIANT: `inner` is properly initialized.
-            inner <- Opaque::pin_init(try_pin_init!(Inner {
-                data <- Revocable::new(data),
-                devm <- Completion::new(),
-                revoke <- Completion::new(),
-            })),
+            dev: dev.into(),
             callback,
-            dev: {
+            // INVARIANT: `inner` is properly initialized.
+            inner <- {
                 // SAFETY: `this` is a valid pointer to uninitialized memory.
                 let inner = unsafe { &raw mut (*this.as_ptr()).inner };
 
@@ -158,7 +154,11 @@ pub fn new<'a, E>(
                     bindings::devm_add_action(dev.as_raw(), Some(callback), inner.cast())
                 })?;
 
-                dev.into()
+                Opaque::pin_init(try_pin_init!(Inner {
+                    devm <- Completion::new(),
+                    revoke <- Completion::new(),
+                    data <- Revocable::new(data),
+                }))
             },
         })
     }

base-commit: 3964d07dd821efe9680e90c51c86661a98e60a0f
prerequisite-patch-id: 12a88f7c46bec668e4f71ec0d94b1782d9446d0b
-- 
2.50.0


