Return-Path: <linux-kernel+bounces-776466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258DB2CDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9391C40418
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCA341AC5;
	Tue, 19 Aug 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf0cFcSA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D3341AAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634472; cv=none; b=oaAFWqmemJC2wPQqU1jnokYiPwZQptEazeettqFCybLNruYpSVyaKifd/vb4S9S3wtoNLktFysvLbrCCvaCTTNt5rkr91ebDT2Nn+xlirWnBpzoXdjMBRrq0v023dUb4tJhe/RVYbhPILfo4LQ3JQWv3BmQGaCvFmrjqZRFwwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634472; c=relaxed/simple;
	bh=tG2lfCHLE8ygsJSIY3ueBGnk3/tzTKsqBPW8KH5mg8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjChS97ehulSPGWstkWVEfnzf3Bo+jr+HtuLhdpsAsYQSZY5pfR3Qz4SwaAHfwO77y25QJLBPPjWXuUxc6TmsEMpsVSSSfK67vPteJdqRvEhTurJoFU5HwG8I8DrLX/YKMEMHkWq80RDx4T+F+OFv/AhfnRIR5KBYKWVCoaDQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf0cFcSA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755634469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJQRnLhxJvgIUuT5kaM/ex8erJ3gbHp4ky93mdCcTI8=;
	b=Hf0cFcSAk/keTvIIZqs4DtUYNsVrsOJcQAKzCtdbY29sar3CRH04jEomoPpTnuZLiuqcs5
	FDvxzV8QIFn0/HlDy6g1dc+DUpEcq6qDYoURdxOpE5OICAp0PvBKS39vXxUCNEluRItZnx
	Qd3/n/gelWqwxNfLDsY82j7XRR4efEU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-D206bQRpNWWyQE_HTr6LpQ-1; Tue,
 19 Aug 2025 16:14:26 -0400
X-MC-Unique: D206bQRpNWWyQE_HTr6LpQ-1
X-Mimecast-MFC-AGG-ID: D206bQRpNWWyQE_HTr6LpQ_1755634464
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50177180048E;
	Tue, 19 Aug 2025 20:14:24 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.81.238])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E196A19560B0;
	Tue, 19 Aug 2025 20:14:20 +0000 (UTC)
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
Subject: [PATCH v8 7/7] rust: hrtimer: Add HrTimer::expires()
Date: Tue, 19 Aug 2025 16:05:58 -0400
Message-ID: <20250819201334.545001-8-lyude@redhat.com>
In-Reply-To: <20250819201334.545001-1-lyude@redhat.com>
References: <20250819201334.545001-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a simple callback for retrieving the current expiry time for an
HrTimer. In rvkms, we use the HrTimer expiry value in order to calculate
the approximate vblank timestamp during each emulated vblank interrupt.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V8:
* Fix bogus safety comment I noticed after Fujita's comments. In expires()
  we're not guaranteed to get a non-negative ktime_t because of ktime_t
  itself, we're guaranteed to get one because a negative expiration time
  for a timer doesn't make sense.

 rust/kernel/time.rs         |  1 -
 rust/kernel/time/hrtimer.rs | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 5c40ebe096357..30f0086c2408f 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -211,7 +211,6 @@ pub(crate) fn as_nanos(&self) -> i64 {
     /// # Safety
     ///
     /// The caller promises that `nanos` is in the range from 0 to `KTIME_MAX`.
-    #[expect(unused)]
     #[inline]
     pub(crate) unsafe fn from_ktime(ktime: bindings::ktime_t) -> Self {
         debug_assert!(ktime >= 0);
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index e0d78a8859903..856d2d929a008 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -223,6 +223,29 @@ pub fn forward_now(self: Pin<&mut Self>, interval: Delta) -> u64
     {
         self.forward(HrTimerInstant::<T>::now(), interval)
     }
+
+    /// Return the time expiry for this [`HrTimer`].
+    ///
+    /// This value should only be used as a snapshot, as the actual expiry time could change after
+    /// this function is called.
+    pub fn expires(&self) -> HrTimerInstant<T>
+    where
+        T: HasHrTimer<T>,
+    {
+        // SAFETY: `self` is an immutable reference and thus always points to a valid `HrTimer`.
+        let c_timer_ptr = unsafe { HrTimer::raw_get(self) };
+
+        // SAFETY:
+        // - Timers cannot have negative ktime_t values as their expiration time.
+        // - There's no actual locking here, a racy read is fine and expected
+        unsafe {
+            Instant::from_ktime(
+                // This `read_volatile` is intended to correspond to a READ_ONCE call.
+                // FIXME(read_once): Replace with `read_once` when available on the Rust side.
+                core::ptr::read_volatile(&raw const ((*c_timer_ptr).node.expires)),
+            )
+        }
+    }
 }
 
 /// Implemented by pointer types that point to structs that contain a [`HrTimer`].
-- 
2.50.0


