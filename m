Return-Path: <linux-kernel+bounces-661812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2322AC311F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 21:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E161892A6A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 19:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446281F4C8C;
	Sat, 24 May 2025 19:23:04 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98561F2BA4;
	Sat, 24 May 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114583; cv=none; b=m1UjjFZItWA7JsNFojawX6UCKVSebYYdUZ4H4FidvVLetonc6ypItBcA6vZFqOZOsdCin6zo/tPPyZ8kR3/LQbZ3ZzaQhM59ocaHAsGJBqQnBAfW7g9kZAkJU6b630OZWlZOAJkUfD50T8Ol2tHfpQ7wyf610zsQYh8CjcRNbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114583; c=relaxed/simple;
	bh=4kDGoizj1P/M0IQMgBKf8XjIKoVsd8BHgb3eY67qhUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWdKfwuXnH3EkCiEXpVjqTkMKLuA5ivZapoHmLi6lrA8x5C9xupdBvIiVW5M7Y7ftAGaUT3FuQkOITI5dbcPiE/E3evLEqZgecxOVt5lxmttuZ5AQREHMpYwHhT1QxEXn4B1tKAw5XMT/TBaW8G0ulFvEeQqRT49bXROOQOVD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b4X421J5Dz9snp;
	Sat, 24 May 2025 21:22:58 +0200 (CEST)
From: Remo Senekowitsch <remo@buenzli.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Remo Senekowitsch <remo@buenzli.dev>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v6 5/9] rust: device: Introduce PropertyGuard
Date: Sat, 24 May 2025 21:22:28 +0200
Message-ID: <20250524192232.705860-6-remo@buenzli.dev>
In-Reply-To: <20250524192232.705860-1-remo@buenzli.dev>
References: <20250524192232.705860-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4b4X421J5Dz9snp

This abstraction is a way to force users to specify whether a property
is supposed to be required or not. This allows us to move error
logging of missing required properties into core, preventing a lot of
boilerplate in drivers.

It will be used by upcoming methods for reading device properties.

Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 rust/kernel/device/property.rs | 59 ++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 09c38775b2354..7b1116daae3aa 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -128,3 +128,62 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         unsafe { bindings::fwnode_handle_put(obj.cast().as_ptr()) }
     }
 }
+
+/// A helper for reading device properties.
+///
+/// Use [`Self::required_by`] if a missing property is considered a bug and
+/// [`Self::optional`] otherwise.
+///
+/// For convenience, [`Self::or`] and [`Self::or_default`] are provided.
+pub struct PropertyGuard<'fwnode, 'name, T> {
+    /// The result of reading the property.
+    inner: Result<T>,
+    /// The fwnode of the property, used for logging in the "required" case.
+    fwnode: &'fwnode FwNode,
+    /// The name of the property, used for logging in the "required" case.
+    name: &'name CStr,
+}
+
+impl<T> PropertyGuard<'_, '_, T> {
+    /// Access the property, indicating it is required.
+    ///
+    /// If the property is not present, the error is automatically logged. If a
+    /// missing property is not an error, use [`Self::optional`] instead. The
+    /// device is required to associate the log with it.
+    pub fn required_by(self, dev: &super::Device) -> Result<T> {
+        if self.inner.is_err() {
+            dev_err!(
+                dev,
+                "{}: property '{}' is missing\n",
+                self.fwnode.display_path(),
+                self.name
+            );
+        }
+        self.inner
+    }
+
+    /// Access the property, indicating it is optional.
+    ///
+    /// In contrast to [`Self::required_by`], no error message is logged if
+    /// the property is not present.
+    pub fn optional(self) -> Option<T> {
+        self.inner.ok()
+    }
+
+    /// Access the property or the specified default value.
+    ///
+    /// Do not pass a sentinel value as default to detect a missing property.
+    /// Use [`Self::required_by`] or [`Self::optional`] instead.
+    pub fn or(self, default: T) -> T {
+        self.inner.unwrap_or(default)
+    }
+}
+
+impl<T: Default> PropertyGuard<'_, '_, T> {
+    /// Access the property or a default value.
+    ///
+    /// Use [`Self::or`] to specify a custom default value.
+    pub fn or_default(self) -> T {
+        self.inner.unwrap_or_default()
+    }
+}
-- 
2.49.0


