Return-Path: <linux-kernel+bounces-780518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E1EB30301
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08EA18945E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE334F495;
	Thu, 21 Aug 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esR+Meiw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AD034F485
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804844; cv=none; b=OfrvQhOhsWfWLKK+jbKUUqRrvYS8RqZPXoVWc3GxBKi3yFLCZayB8g1pqDWyzYLeDGXfMRlBOSNbBTU+uW4nEsYY9QL73SOUHhCr/AO6I9+w1gaW0XlXTkXhpRaJ5u68S6QHk83qtsH+7vx43L8Jd+i4Wc6rjkHLRYcwGkjSF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804844; c=relaxed/simple;
	bh=K2qBsorQEBvmC0Ja7J3lU2rWa8SBiQv3NtEmDxn8U8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdoZbsN2QeOzgrpn2QhSwKCxLvBb8rNo69/ZHDYuhg7E6ce4dhERurV11HLi9ST4NVzy7ykCHzU6YhqPouyH5Y0EYKTlTlCMIFr4CiarqO1WOxcJUW+DCW3h8aAxVC0MPQxrs2ZS0eEe1QESoeRBA96v5tOvg/B+mPw4yvhUK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esR+Meiw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755804842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMX2qgtksfDBWFPpJzJWDTU+6VclykynBnjwOSTYNM4=;
	b=esR+Meiwcb0fAROdJk/frhcogqHr0Miou8LIy2QzWg6KJg2pAUohH1ftFIFkDujCc3Gh6F
	6zo7qw5C52IQA3ce8rnAR+F4ELFIF86Fzobp8iioj4Ic7Q6ttYdOAWxqgmKeAk5aG27fBW
	SBmw1I5hB3Wor1+tVeXyyK6rWk17UfI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-hgEenq9HOryXMqQ2m8SYZQ-1; Thu,
 21 Aug 2025 15:33:57 -0400
X-MC-Unique: hgEenq9HOryXMqQ2m8SYZQ-1
X-Mimecast-MFC-AGG-ID: hgEenq9HOryXMqQ2m8SYZQ_1755804830
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AB3A1956087;
	Thu, 21 Aug 2025 19:33:50 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.89.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB2D91955F24;
	Thu, 21 Aug 2025 19:33:46 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: 
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
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org (open list:DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 6/7] rust: time: Add Instant::from_ktime()
Date: Thu, 21 Aug 2025 15:32:46 -0400
Message-ID: <20250821193259.964504-7-lyude@redhat.com>
In-Reply-To: <20250821193259.964504-1-lyude@redhat.com>
References: <20250821193259.964504-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

For implementing Rust bindings which can return a point in time.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V4:
* Turn from_nanos() into an unsafe function in order to ensure that we
  uphold the invariants of Instant
V5:
* Add debug_assert!() to from_nanos
V8:
* Change name of function from Instant::from_nanos() to
  Instant::from_ktime()
V9:
* Fix outdated comments in from_ktime (nanos -> ktime)

 rust/kernel/time.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 64c8dcf548d63..874a1023dcdf9 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -200,6 +200,29 @@ pub fn elapsed(&self) -> Delta {
     pub(crate) fn as_nanos(&self) -> i64 {
         self.inner
     }
+
+    /// Create an [`Instant`] from a `ktime_t` without checking if it is non-negative.
+    ///
+    /// # Panics
+    ///
+    /// On debug builds, this function will panic if `ktime` is not in the range from 0 to
+    /// `KTIME_MAX`.
+    ///
+    /// # Safety
+    ///
+    /// The caller promises that `ktime` is in the range from 0 to `KTIME_MAX`.
+    #[expect(unused)]
+    #[inline]
+    pub(crate) unsafe fn from_ktime(ktime: bindings::ktime_t) -> Self {
+        debug_assert!(ktime >= 0);
+
+        // INVARIANT: Our safety contract ensures that `ktime` is in the range from 0 to
+        // `KTIME_MAX`.
+        Self {
+            inner: ktime,
+            _c: PhantomData,
+        }
+    }
 }
 
 impl<C: ClockSource> core::ops::Sub for Instant<C> {
-- 
2.50.0


