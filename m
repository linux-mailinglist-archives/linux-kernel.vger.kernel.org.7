Return-Path: <linux-kernel+bounces-743373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB7DB0FDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C8F16758C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301C32741DA;
	Thu, 24 Jul 2025 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlAdODo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3F258CD9;
	Thu, 24 Jul 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315214; cv=none; b=BrVSM14sV1BJqdmDvLrskcLQ1y9MEZaTyA9vlqbiAdiT5akF+jwtgtc1QczIfomqxAFmERsaA+W08+6AbYOitEWz4tyZkCeHSP5BhGLpZviDRe0OwddhLDWiqJkyAVmPo58RLROEtlUHrEPAQFjsFDtmaxtKnA7fJq7nrrQY160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315214; c=relaxed/simple;
	bh=AKAbS84gY9dQXK7Kck1l0OWH2nxfXnqOEWKnlLaSrLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/eNIx4XpjuY9Gn3Wzp4cEkhk+NrblH58BkFzv8kgHwiM4HBGi2t2XeQPVWKwsVGFVFVFVYOZZnJXptbZP6B5puivtWs43LhLZ20XBqzkLd9oJ/ClYixlmSe8seWpZj9lEV51Wqk38POUsMY0Okuq0XY5/oNSrHrHdgyRFiJ5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlAdODo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FB1C4CEF4;
	Thu, 24 Jul 2025 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753315214;
	bh=AKAbS84gY9dQXK7Kck1l0OWH2nxfXnqOEWKnlLaSrLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlAdODo2cRl2kGQJlIOYP4S0jZ/R3cWNEkedJmZJKtZTe41eaNspg0ogTmwlyT9R2
	 xjXYpaXltPfGUCwck3jh9SOErGAygFr2xXAEnHbYPG/5+0nIdBx9ENS6poztjR7If9
	 RL3HCKt6rI8SrRPrmLpCxmfCfJukYCagvlfc5UAdrsNWPRh+ZjYuZfvezT4iukEDj7
	 qnIY/T7BEvm9z7J5oDokIToTWnaXMUYjFtp1ZUQ4cv0RgmDB5Dt8E+8NztbVaPXiCU
	 SaZFCpPQkaEVsCL5VjNW8bfRSdptLgmd320ejwi4fItm66iw4HmjtXvn5bcQpdbujF
	 FWK/hAuZA7nCw==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alex Mantel <alexmantel93@mailbox.org>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] rust: make `Arc::into_unique_or_drop` associated function
Date: Thu, 24 Jul 2025 00:32:55 +0100
Message-ID: <20250723233312.3304339-3-gary@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723233312.3304339-1-gary@kernel.org>
References: <20250723233312.3304339-1-gary@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

Make `Arc::into_unique_or_drop` to become a mere associated function
instead of a method (i.e. removing the `self` receiver).

It's a general convention for Rust smart pointers to avoid having
methods defined on them, because if the pointee type has a method of the
same name, then it is shadowed. This is normally for avoiding semver
breakage, which isn't an issue for kernel codebase, but it's still
generally a good practice to follow this rule, so that `ptr.foo()` would
always be calling a method on the pointee type.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/arc.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 63a66761d0c7d..4ee155b43b2dc 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -321,7 +321,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// use kernel::sync::{Arc, UniqueArc};
     ///
     /// let arc = Arc::new(42, GFP_KERNEL)?;
-    /// let unique_arc = arc.into_unique_or_drop();
+    /// let unique_arc = Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should succeed since refcount of `arc` is 1.
     /// assert!(unique_arc.is_some());
@@ -337,18 +337,18 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// let arc = Arc::new(42, GFP_KERNEL)?;
     /// let another = arc.clone();
     ///
-    /// let unique_arc = arc.into_unique_or_drop();
+    /// let unique_arc = Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should fail since refcount of `arc` is >1.
     /// assert!(unique_arc.is_none());
     ///
     /// # Ok::<(), Error>(())
     /// ```
-    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
+    pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
         // We will manually manage the refcount in this method, so we disable the destructor.
-        let me = ManuallyDrop::new(self);
+        let this = ManuallyDrop::new(this);
         // SAFETY: We own a refcount, so the pointer is still valid.
-        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
+        let refcount = unsafe { this.ptr.as_ref() }.refcount.get();
 
         // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
         // return without further touching the `Arc`. If the refcount reaches zero, then there are
@@ -365,7 +365,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
             // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
             // their values.
             Some(Pin::from(UniqueArc {
-                inner: ManuallyDrop::into_inner(me),
+                inner: ManuallyDrop::into_inner(this),
             }))
         } else {
             None
-- 
2.49.0


