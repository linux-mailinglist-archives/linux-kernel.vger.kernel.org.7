Return-Path: <linux-kernel+bounces-744812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A365B11135
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ADC5608C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A22ED87D;
	Thu, 24 Jul 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jB6qC5jG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916B2ED854
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383185; cv=none; b=a2zneyer1qftOmlfQZoBYUeniQRAq6LMMrxrFxd8LBvslMwsxzTUwdbntSmKLEMAa3ZawshPksKeRx5K4mxnEE7+/a2PEK+SOhx7VIV+aB36d7HvGhtuNIz8W02LAUrx3FUbPn5OJiVJqT3Rh+D80ufAxYF+gc4S9wEtOskFdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383185; c=relaxed/simple;
	bh=I6r/hVojm9kPsiME3lDLV24WqEKZE1S6dw/IIfQTPIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqjXxeigJMDS+dFla16JeL4Xf7nfRwf8QgEvm90jJgcSgq34gNNnRuLSwdcS6KCiAu8EBxzoVAn1ojChpOWXRkE9+EuAFqh7SlQ5lz6vlY3N1N6n5POOgrEAIqnzSIR4T4cQ7VD5fw1s0cC0/NlUqzKM9e4yQl4vVjENMlwhnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jB6qC5jG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753383183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIvhLLPtzfNF63KacAB5y6ueD7cnnwqEnQG82pg+xts=;
	b=jB6qC5jGJOkRQrizoXt+lrdY+u+A+5nteIqfpHnl3z2yk/QeO+4CH6XaAxUHC4x7pJLNJr
	eWu23/dlIuoxX0miltq1OzrFefAvonZ3JMQE5jOgB6848YEY3FMMzqeLKNX4EUM4Wb6m1J
	Y0DAFJMw14zCgJaOxXGyf1xcT981amU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-WA3DVNVAPbi3ox1JdACujA-1; Thu,
 24 Jul 2025 14:52:59 -0400
X-MC-Unique: WA3DVNVAPbi3ox1JdACujA-1
X-Mimecast-MFC-AGG-ID: WA3DVNVAPbi3ox1JdACujA_1753383175
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6CDC180098E;
	Thu, 24 Jul 2025 18:52:55 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76AA21956096;
	Thu, 24 Jul 2025 18:52:51 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
Subject: [PATCH v6 3/7] rust: hrtimer: Add HrTimer::raw_forward() and forward()
Date: Thu, 24 Jul 2025 14:49:29 -0400
Message-ID: <20250724185236.556482-4-lyude@redhat.com>
In-Reply-To: <20250724185236.556482-1-lyude@redhat.com>
References: <20250724185236.556482-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Within the hrtimer API there are quite a number of functions that can only
be safely called from one of two contexts:

* When we have exclusive access to the hrtimer and the timer is not active.
* When we're within the hrtimer's callback context as it is being executed.

This commit adds bindings for hrtimer_forward() for the first such context,
along with HrTimer::raw_forward() for later use in implementing the
hrtimer_forward() in the latter context.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V4:
* Fix the safety contract for raw_forward()
* Require Pin<&mut Self>, not &mut self
* Drop incorrect UniquePin example
* Rewrite documentation a bit (re: Andreas)
V6:
* Remove the reference to HrTimerCallbackContext::forward() until this
  function gets added.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/time/hrtimer.rs | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index be1bad4aacaad..5ccdd1b0b8021 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -168,6 +168,46 @@ pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
         // handled on the C side.
         unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
     }
+
+    /// Forward the timer expiry for a given timer pointer.
+    ///
+    /// # Safety
+    ///
+    /// - `self_ptr` must point to a valid `Self`.
+    /// - The caller must either have exclusive access to the data pointed at by `self_ptr`, or be
+    ///   within the context of the timer callback.
+    #[inline]
+    unsafe fn raw_forward(self_ptr: *mut Self, now: HrTimerInstant<T>, interval: Delta) -> u64
+    where
+        T: HasHrTimer<T>,
+    {
+        // SAFETY:
+        // * The C API requirements for this function are fulfilled by our safety contract.
+        // * `self_ptr` is guaranteed to point to a valid `Self` via our safety contract
+        unsafe {
+            bindings::hrtimer_forward(Self::raw_get(self_ptr), now.as_nanos(), interval.as_nanos())
+        }
+    }
+
+    /// Conditionally forward the timer.
+    ///
+    /// If the timer expires after `now`, this function does nothing and returns 0. If the timer
+    /// expired at or before `now`, this function forwards the timer by `interval` until the timer
+    /// expires after `now` and then returns the number of times the timer was forwarded by
+    /// `interval`.
+    ///
+    /// Returns the number of overruns that occurred as a result of the timer expiry change.
+    pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interval: Delta) -> u64
+    where
+        T: HasHrTimer<T>,
+    {
+        // SAFETY:
+        // - `raw_forward` does not move `self`.
+        // - Self is a mutable reference and thus always points to a valid `HrTimer`
+        // - The only way that we could hold a mutable reference to `HrTimer<T>` is if we have
+        //   exclusive access to it - fulfilling the requirements of the C API.
+        unsafe { Self::raw_forward(self.get_unchecked_mut(), now, interval) }
+    }
 }
 
 /// Implemented by pointer types that point to structs that contain a [`HrTimer`].
-- 
2.50.0


