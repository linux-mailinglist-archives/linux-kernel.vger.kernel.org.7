Return-Path: <linux-kernel+bounces-721123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C34AFC501
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9DA7A430C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F90C29B8E2;
	Tue,  8 Jul 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Wz9rjR/r"
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DF28724C;
	Tue,  8 Jul 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961947; cv=none; b=j3NZQMmmkfLHQhax/7FVkvdjHmGA6hQWx9GbAupbN9IAa78zxywQBOuWP1HLuh9fbNzrPLmE66hb+s2UR4cYcbM6Y8RpkjYk1igC2E4qX5NPFyKqr7gArPjFdiztWk9s4r0qGn8TgaK/HiZEMynGMi/In3VJ0QgS813FgCy85D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961947; c=relaxed/simple;
	bh=B9g4G0fmY0TM8gPgXVh0P51IjPxPoN5B1QUDLCyNUbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hYWDB2hJ6BEJxUcF4ies55thoJkYGKHT8Ht6T09kXQzw0yjWjOIdp7Pk+18YnjGYA1aqepBLaCAKVPUsMVlkiINmPrkl1dt/wuiEGluZh7Jn7M3Vqvr20y9Y+SQeFc+yfDxkjy8hc7b9qxfKfU/zBgftkhfJWG4jre6Pw1QYCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Wz9rjR/r; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id C57B16571A;
	Tue,  8 Jul 2025 10:59:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bc97:0:640:ee90:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id DE2606094D;
	Tue,  8 Jul 2025 10:59:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qwbJulRMP0U0-RRg8OCpJ;
	Tue, 08 Jul 2025 10:59:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751961549;
	bh=HZ89twN1G4Cm9f2TIXMWWBwShVSIJsgKl5vc8RLmyvg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Wz9rjR/r7aBSM/7V5wHASnCAA1N08PXykrvUMRt+YjCZwh5sSOIt+7VQiIrGTKEgf
	 JUN7978exZ59oG3Z8YsE6ChjnGeXpld/HJf1Mz4z/qMyWjOMrMV4UlkCqE/gXeLjxy
	 HYjlDZ0dHwPPR7Ij8OVV5AKaMuqJn1ZqoGGFcgbk=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	mattgilbride@google.com,
	wedsonaf@gmail.com,
	daniel@sedlak.dev,
	tamird@gmail.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2] rust: rbtree: simplify finding `current` in `remove_current`
Date: Tue,  8 Jul 2025 10:58:50 +0300
Message-ID: <20250708075850.25789-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous version used a verbose `match` to get
`current`, which may be slightly confusing at first
glance.

This change makes it shorter and more clearly expresses
the intent: prefer `next` if available, otherwise fall
back to `prev`.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/rbtree.rs | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 8d978c896747..58ad52a07c92 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -769,23 +769,14 @@ pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
         // the tree cannot change. By the tree invariant, all nodes are valid.
         unsafe { bindings::rb_erase(&mut (*this).links, addr_of_mut!(self.tree.root)) };

-        let current = match (prev, next) {
-            (_, Some(next)) => next,
-            (Some(prev), None) => prev,
-            (None, None) => {
-                return (None, node);
-            }
-        };
+        // INVARIANT:
+        // - `current` is a valid node in the [`RBTree`] pointed to by `self.tree`.
+        let cursor = next.or(prev).map(|current| Self {
+            current,
+            tree: self.tree,
+        });

-        (
-            // INVARIANT:
-            // - `current` is a valid node in the [`RBTree`] pointed to by `self.tree`.
-            Some(Self {
-                current,
-                tree: self.tree,
-            }),
-            node,
-        )
+        (cursor, node)
     }

     /// Remove the previous node, returning it if it exists.
--
2.50.0


