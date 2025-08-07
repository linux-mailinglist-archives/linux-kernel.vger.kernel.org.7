Return-Path: <linux-kernel+bounces-759419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41B0B1DD54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD01018C6EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08B223DEA;
	Thu,  7 Aug 2025 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GafaIMsl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA08F6E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593622; cv=none; b=ebmrEw1qxurycBrO3JHlnurmvsdreJE5nkNtxPI+wTBCGzct0YUZJN1lwMThget7+4hO0l4qgGdmRpCkBxbmet0nj7Zjii5tZE/YEIaorgQUUbtUtq8N6+66HX+p6clGvVaB32G+9W+vxg3leNziH1PaAv01MT/Oe6I9XkKMTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593622; c=relaxed/simple;
	bh=JRv4nrgdGhLehuyjTHexjywD6f3lkiNksui03JJIEOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzouXfF6QulApzU3xxJvR70DXxMaAFvZusY+tHlOK+RxOwQkwP1EANTXfNRRZ+P9oLg5Yed2XwD98+7oPwls7XfZnNOGAShN6W5mCUZpQXRX1A7w9HpVLcqSoI/D56KfycPkHp9nmiHDwurP1fQ46QkQY8/b1NFinTJ6thOZbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GafaIMsl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754593619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=udS+b8WaaKH5KyymGeMqR5JdvGQCZoEkiopIPJzS+2Y=;
	b=GafaIMsllCUp3mDrf084/GtfyG18ja4kaAERoQLISxx+ka20q4JT4ztPqHvTa+IMi9M2Oi
	HtD3dhB8EYF5sxMjWjKm4j5jV9KNMFLLTsSPUAOJagGUTHSghJ8/mlf3GUN2wvoPlYkVvo
	zz98s/vUTwXyq+E759qL6iLD5pVPbLU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-VtzuOwOmNaOOVLXvzHL4oQ-1; Thu,
 07 Aug 2025 15:06:57 -0400
X-MC-Unique: VtzuOwOmNaOOVLXvzHL4oQ-1
X-Mimecast-MFC-AGG-ID: VtzuOwOmNaOOVLXvzHL4oQ_1754593615
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFDD1195608A;
	Thu,  7 Aug 2025 19:06:54 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D54119560AD;
	Thu,  7 Aug 2025 19:06:51 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for Instant
Date: Thu,  7 Aug 2025 15:06:35 -0400
Message-ID: <20250807190649.3078875-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In order to maintain the invariants of Instant, we use saturating
addition/subtraction that is clamped to the valid value range for a
non-negative Ktime.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Change behavior in ops::{Add,Sub}<Delta> so that we panic on overflows
  under the same conditions that arithmetic operations in rust would panic
  by default.
---
 rust/kernel/time.rs | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 64c8dcf548d63..4bd7a8a009f3e 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -25,6 +25,7 @@
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
 use core::marker::PhantomData;
+use core::ops;
 
 pub mod delay;
 pub mod hrtimer;
@@ -202,7 +203,7 @@ pub(crate) fn as_nanos(&self) -> i64 {
     }
 }
 
-impl<C: ClockSource> core::ops::Sub for Instant<C> {
+impl<C: ClockSource> ops::Sub for Instant<C> {
     type Output = Delta;
 
     // By the type invariant, it never overflows.
@@ -214,6 +215,46 @@ fn sub(self, other: Instant<C>) -> Delta {
     }
 }
 
+impl<T: ClockSource> ops::Add<Delta> for Instant<T> {
+    type Output = Self;
+
+    #[inline]
+    fn add(self, rhs: Delta) -> Self::Output {
+        // INVARIANT: With arithmetic over/underflow checks enabled, this will panic if we overflow
+        // (e.g. go above `KTIME_MAX`)
+        let res = self.inner + rhs.nanos;
+
+        // INVARIANT: With overflow checks enabled, we verify here that the value is >= 0
+        #[cfg(CONFIG_RUST_OVERFLOW_CHECKS)]
+        assert!(res >= 0);
+
+        Self {
+            inner: res,
+            _c: PhantomData,
+        }
+    }
+}
+
+impl<T: ClockSource> ops::Sub<Delta> for Instant<T> {
+    type Output = Self;
+
+    #[inline]
+    fn sub(self, rhs: Delta) -> Self::Output {
+        // INVARIANT: With arithmetic over/underflow checks enabled, this will panic if we overflow
+        // (e.g. go above `KTIME_MAX`)
+        let res = self.inner - rhs.nanos;
+
+        // INVARIANT: With overflow checks enabled, we verify here that the value is >= 0
+        #[cfg(CONFIG_RUST_OVERFLOW_CHECKS)]
+        assert!(res >= 0);
+
+        Self {
+            inner: res,
+            _c: PhantomData,
+        }
+    }
+}
+
 /// A span of time.
 ///
 /// This struct represents a span of time, with its value stored as nanoseconds.

base-commit: 479058002c32b77acac43e883b92174e22c4be2d
-- 
2.50.0


