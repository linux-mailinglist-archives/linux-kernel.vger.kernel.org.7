Return-Path: <linux-kernel+bounces-899536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1DC58331
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B39421805
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3F2D6620;
	Thu, 13 Nov 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="mbRnPLWx"
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A61EE7DC;
	Thu, 13 Nov 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045642; cv=none; b=dIJFM6WBC49lxwGx1XHxGI7kkcpVJDScLgSNpuesQ9UJ9xxtuOaBhpdFPkcFxnjiUVbvR4SBbHnp1ZfWeGLxnUtvY/8EaP8q79ksWlvqgu8lnv2frrCr3V9yTWk/HeymurFoT8t9VJv37JdyKk5q66TIzoSSfvx1a0Xiymj86Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045642; c=relaxed/simple;
	bh=Oq9zBjtc9LiLqXOLAhgqm2wsPTFMjlFzMqtbE1osZTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdgY/gNVZLDb4kB3oUwVrqTR9rRf4o7nVE+T/aGlSBqEkdAe3VYHbVnnieX9oxUvQDr83sGgEqBChC1MKiVzJRFbZs2i9WY6yN0FLEGOBiynsx+sQZ9fvcVVRwJfwkuKXEipM0N3jh65J2kgTe2myNeYHyVajKPA/4m5tci4nGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=mbRnPLWx; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 3B5CD87380;
	Thu, 13 Nov 2025 17:46:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1507:0:640:8803:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 69C63C0091;
	Thu, 13 Nov 2025 17:46:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AkRsKD1L04Y0-dkH2KxvI;
	Thu, 13 Nov 2025 17:46:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1763045180;
	bh=pqMtmNSs14Nm8CD/WmsJeS7HwoDN7nCveH+O5OEE+Kw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=mbRnPLWxdzq6bVFYhl9opLBoQneIIqlK269Tl0k8R6MjrDJrCUpsSjpv1Wi+BmB8n
	 EPX9Aes2gIhwyGOsKjghkOFB4F/apwoC9bgoF2WOSs96SelzAQMCQ1xJJHTUJDu5Bg
	 UgbcuusY8jcsg5qVOK7nqDnHCmLch6TNBLSGCEHg=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	yutaro.ono.418@gmail.com,
	charmitro@posteo.net,
	borys.tyran@protonmail.com,
	daniel@sedlak.dev,
	tamird@gmail.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1] rbtree: reduce unsafe blocks on pointer derefs
Date: Thu, 13 Nov 2025 17:45:47 +0300
Message-ID: <20251113144547.502-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactors parts of the get() and cursor_lower_bound()
traversal logic to minimize the scope of unsafe blocks
and avoid duplicating same safety comments.

One of the removed comments was also misleading:

    // SAFETY: `node` is a non-null node...
    Ordering::Equal => return Some(unsafe { &(*this).value }),

as `node` should have been `this`.

No functional changes intended; this is purely a safety
improvement that reduces the amount of unsafe blocks
while keeping all invariants intact.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/rbtree.rs | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index b8fe6be6fcc4..d44f305e5161 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -384,14 +384,17 @@ pub fn get(&self, key: &K) -> Option<&V> {
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
             let this = unsafe { container_of!(node, Node<K, V>, links) };
+
             // SAFETY: `this` is a non-null node so it is valid by the type invariants.
-            node = match key.cmp(unsafe { &(*this).key }) {
-                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
-                Ordering::Less => unsafe { (*node).rb_left },
-                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
-                Ordering::Greater => unsafe { (*node).rb_right },
-                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
-                Ordering::Equal => return Some(unsafe { &(*this).value }),
+            let this_ref = unsafe { &*this };
+
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            let node_ref = unsafe { &*node };
+
+            node = match key.cmp(&this_ref.key) {
+                Ordering::Less => node_ref.rb_left,
+                Ordering::Greater => node_ref.rb_right,
+                Ordering::Equal => return Some(&this_ref.value),
             }
         }
         None
@@ -433,17 +436,17 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
             let this = unsafe { container_of!(node, Node<K, V>, links) };
             // SAFETY: `this` is a non-null node so it is valid by the type invariants.
             let this_key = unsafe { &(*this).key };
+
             // SAFETY: `node` is a non-null node so it is valid by the type invariants.
-            let left_child = unsafe { (*node).rb_left };
-            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
-            let right_child = unsafe { (*node).rb_right };
+            let node_ref = unsafe { &*node };
+
             match key.cmp(this_key) {
                 Ordering::Equal => {
                     best_match = NonNull::new(this);
                     break;
                 }
                 Ordering::Greater => {
-                    node = right_child;
+                    node = node_ref.rb_right;
                 }
                 Ordering::Less => {
                     let is_better_match = match best_match {
@@ -457,7 +460,7 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
                     if is_better_match {
                         best_match = NonNull::new(this);
                     }
-                    node = left_child;
+                    node = node_ref.rb_left;
                 }
             };
         }
-- 
2.51.2


