Return-Path: <linux-kernel+bounces-778515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC23B2E6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EFF7A4BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B828BAB1;
	Wed, 20 Aug 2025 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BooksOVZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18882D372A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722248; cv=none; b=Ly2bWlgXDjVzj8cYYpGLwuRNlHUpim3kPbsgPR5ApFcdlnr+DXGu03Oim1eLdKGhkKd+alw+PMTm1y9bw1LK6LxNRoFIYQ3JvIcFZR3qtD4jncFDji6VyGoO85m5Fy2GSQYnoTpR7oCnIZ95TguaKvAQGjQMKol/aqjIn+UYVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722248; c=relaxed/simple;
	bh=Y88gS618ooHfwSEeQ/x1FVp6qCHn0OyxAAhi8dccVfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S97qSf9MSfD9hlEzY93A7GhpdOeB6rNF4wOGJBknwW3nQyy+t118ZH4AlzUcE7K7OLAYLbBRHqhT/7fSTnlpuExx4BdJT/RgDjEx0KYXvDaOHYT59vHl1bo4HolezYlG18EXuvZnNg+lO0v5GXU4x8myYBWsAUdy3+jWG9At6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BooksOVZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755722245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPGI7YO0+Ykjlr33gJ/vmqFT7fgdrtVLz3J06wkC9Ys=;
	b=BooksOVZvlauiGvleMrRnk83Jt+3ktCRvPkf5xd06lovccawjr8uCvJXVIYN9bboXN0uBg
	uWwkYDOVEFpdB0S4m9KpBS2GVlVP4LDA0Yc9joCxNmuz3KFR33fA9hXt82sm/GdbL9IuGl
	TnLby3u9YEk8aa/EBtMfgCAq8WEX2fM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-1Hv_GtGINrm6MbjSZlx32A-1; Wed,
 20 Aug 2025 16:37:22 -0400
X-MC-Unique: 1Hv_GtGINrm6MbjSZlx32A-1
X-Mimecast-MFC-AGG-ID: 1Hv_GtGINrm6MbjSZlx32A_1755722239
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BEE91956089;
	Wed, 20 Aug 2025 20:37:19 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.81.238])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7F9C19A4C99;
	Wed, 20 Aug 2025 20:37:15 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
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
Subject: [PATCH v3 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for Instant
Date: Wed, 20 Aug 2025 16:26:43 -0400
Message-ID: <20250820203704.731588-2-lyude@redhat.com>
In-Reply-To: <20250820203704.731588-1-lyude@redhat.com>
References: <20250820203704.731588-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In order to copy the behavior rust currently follows for basic arithmetic
operations and panic if the result of an addition or subtraction results in
a value that would violate the invariants of Instant, but only if the
kernel has overflow checking for rust enabled.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V2:
* Change behavior in ops::{Add,Sub}<Delta> so that we panic on overflows
  under the same conditions that arithmetic operations in rust would panic
  by default.
V3:
* Don't forget to update the commit message this time!

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
-- 
2.50.0


