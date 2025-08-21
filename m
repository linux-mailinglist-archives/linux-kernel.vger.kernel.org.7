Return-Path: <linux-kernel+bounces-780514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB9B302F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F246C4E5229
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C934DCE9;
	Thu, 21 Aug 2025 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnKNVs7r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9C1A9FAB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804819; cv=none; b=EWiHQ5jGnGzXRByOaanmj537Qx/SRp9/NbwD5dapB9dfzpOh+RckM8UJwCJA4wpADCNPrIDCHZBRUFpzxdDY+GGGvDe0InTY8fs9Ar7eivFu9ehA36NEwyeC13N78Q1Qk9zG/glwA0NMpfZkPhrQcsx7xYiLSVb5dPjdTUOYSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804819; c=relaxed/simple;
	bh=1namyJhBXNTlgxWA4Sts203ok2F3Onjou2+vIHGaWMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWw+OjkaIcqFY0NvyJswwALo+y/0CCcnmzVgysiYPSW9uwsjZhhuTyOFLzD/JY/6TgnlhzhAZgmTiGOttfFGua8iBwZdUE4wQP6EJFzhb9lNVonhxeJHaNEazNI3lvIW6EQYD2uckRUGYrqG4bis6DqJJMayPvt50JKOuYyMEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnKNVs7r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755804817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdZatwK7YZ40vNNmIn9rSFrBBk7bYVx1796BmwT3dbI=;
	b=EnKNVs7rO2jpadmUh+494tikqWGjUOR3jiuEmt7+r72q2tR4DeSQZ+9eXHma8Pxshi0cbF
	ynVhgcqG2k9IGaA/Nk1m0YyLkw+U64F36LyxYaZvVwHcfCC0uF8ehyGSj41bFK/FyEtwg5
	im6Imh3leGSzqDJwr9vGbXp6GJVAYc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-aHDaGrXrOeS9cJjhdq6Mxg-1; Thu,
 21 Aug 2025 15:33:34 -0400
X-MC-Unique: aHDaGrXrOeS9cJjhdq6Mxg-1
X-Mimecast-MFC-AGG-ID: aHDaGrXrOeS9cJjhdq6Mxg_1755804810
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 114871956080;
	Thu, 21 Aug 2025 19:33:30 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.89.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2146197768A;
	Thu, 21 Aug 2025 19:33:25 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: 
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
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
Subject: [PATCH v9 3/7] rust: hrtimer: Add HrTimer::raw_forward() and forward()
Date: Thu, 21 Aug 2025 15:32:43 -0400
Message-ID: <20250821193259.964504-4-lyude@redhat.com>
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

Within the hrtimer API there are quite a number of functions that can only
be safely called from one of two contexts:

* When we have exclusive access to the hrtimer and the timer is not active.
* When we're within the hrtimer's callback context as it is being executed.

This commit adds bindings for hrtimer_forward() for the first such context,
along with HrTimer::raw_forward() for later use in implementing the
hrtimer_forward() in the latter context.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

---
V4:
* Fix the safety contract for raw_forward()
* Require Pin<&mut Self>, not &mut self
* Drop incorrect UniquePin example
* Rewrite documentation a bit (re: Andreas)
V6:
* Remove the reference to HrTimerCallbackContext::forward() until this
  function gets added.
V7
* Split up Timer::forward() a bit, apply Andreas's SAFETY comment
  recommendations

 rust/kernel/time/hrtimer.rs | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index be1bad4aacaad..79fed14b2d98e 100644
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
+        // SAFETY: `raw_forward` does not move `Self`
+        let this = unsafe { self.get_unchecked_mut() };
+
+        // SAFETY: By existence of `Pin<&mut Self>`, the pointer passed to `raw_forward` points to a
+        // valid `Self` that we have exclusive access to.
+        unsafe { Self::raw_forward(this, now, interval) }
+    }
 }
 
 /// Implemented by pointer types that point to structs that contain a [`HrTimer`].
-- 
2.50.0


