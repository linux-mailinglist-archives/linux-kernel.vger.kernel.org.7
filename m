Return-Path: <linux-kernel+bounces-688684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86202ADB5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 17:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53F57A60D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DF280A2F;
	Mon, 16 Jun 2025 15:45:28 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02927F73D;
	Mon, 16 Jun 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088728; cv=none; b=ndB3VwcMs0q7NW/ODgLxNWC6mou3FrrTriZ2Rf5C2hCgnckD8b4J3iiD+gm1ngJoc7lYifA6ymAY64XCYEHuHSlkF7pbJHlLANgvjP9TbD9AFHe2OaohfLzvaTspIRYTpAKDPhIctFIxmJSuWtlq+cEjM+6AyE8G7uxq5iKuj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088728; c=relaxed/simple;
	bh=2DcCEW5A+fitd6ayjyNNQC+WlEKDFwvkCcCfv+9L59g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSlVzZJ68R2/pw7hHaaoJFzbcj+XwcnIxLMUa3oGdhG1hhf2nFPq0dgTHbIMbwG+sebrQqUbzWVFbfT0mrigPDzJEjBP8YupqmMKA9RKm9fmqHRMC8zHfPLzrqSkfqNstnWP8Br6R6WMQ53bTYPRGwzAcf3e7vxqVGyYMtaJVnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bLZ8L4Qhyz9sxH;
	Mon, 16 Jun 2025 17:45:22 +0200 (CEST)
From: Remo Senekowitsch <remo@buenzli.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Mark Brown <broonie@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Remo Senekowitsch <remo@buenzli.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v1 1/3] rust: device: Add child accessor and iterator
Date: Mon, 16 Jun 2025 17:45:09 +0200
Message-ID: <20250616154511.1862909-2-remo@buenzli.dev>
In-Reply-To: <20250616154511.1862909-1-remo@buenzli.dev>
References: <20250616154511.1862909-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bLZ8L4Qhyz9sxH

Allow Rust drivers to access children of a fwnode either by name or by
iterating over all of them.

In C, there is the function `fwnode_get_next_child_node` for iteration
and the macro `fwnode_for_each_child_node` that helps with handling the
pointers. Instead of a macro, a native iterator is used in Rust such
that regular for-loops can be used.

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/device/property.rs | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 838509111e57..04a13d05785a 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -190,6 +190,62 @@ pub fn property_read<'fwnode, 'name, T: Property>(
             name,
         }
     }
+
+    /// Returns first matching named child node handle.
+    pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<Self>> {
+        // SAFETY: `self` and `name` are valid by their type invariants.
+        let child =
+            unsafe { bindings::fwnode_get_named_child_node(self.as_raw(), name.as_char_ptr()) };
+        if child.is_null() {
+            return None;
+        }
+        // SAFETY:
+        // - `fwnode_get_named_child_node` returns a pointer with its refcount
+        //   incremented.
+        // - That increment is relinquished, i.e. the underlying object is not
+        //   used anymore except via the newly created `ARef`.
+        Some(unsafe { Self::from_raw(child) })
+    }
+
+    /// Returns an iterator over a node's children.
+    pub fn children<'a>(&'a self) -> impl Iterator<Item = ARef<FwNode>> + 'a {
+        let mut prev: Option<ARef<FwNode>> = None;
+
+        core::iter::from_fn(move || {
+            let prev_ptr = match prev.take() {
+                None => ptr::null_mut(),
+                Some(prev) => {
+                    // We will pass `prev` to `fwnode_get_next_child_node`,
+                    // which decrements its refcount, so we use
+                    // `ARef::into_raw` to avoid decrementing the refcount
+                    // twice.
+                    let prev = ARef::into_raw(prev);
+                    prev.as_ptr().cast()
+                }
+            };
+            // SAFETY:
+            // - `self.as_raw()` is valid by its type invariant.
+            // - `prev_ptr` may be null, which is allowed and corresponds to
+            //   getting the first child. Otherwise, `prev_ptr` is valid, as it
+            //   is the stored return value from the previous invocation.
+            // - `prev_ptr` has its refount incremented.
+            // - The increment of `prev_ptr` is relinquished, i.e. the
+            //   underlying object won't be used anymore.
+            let next = unsafe { bindings::fwnode_get_next_child_node(self.as_raw(), prev_ptr) };
+            if next.is_null() {
+                return None;
+            }
+            // SAFETY:
+            // - `next` is valid because `fwnode_get_next_child_node` returns a
+            //   pointer with its refcount incremented.
+            // - That increment is relinquished, i.e. the underlying object
+            //   won't be used anymore, except via the newly created
+            //   `ARef<Self>`.
+            let next = unsafe { FwNode::from_raw(next) };
+            prev = Some(next.clone());
+            Some(next)
+        })
+    }
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
-- 
2.49.0


