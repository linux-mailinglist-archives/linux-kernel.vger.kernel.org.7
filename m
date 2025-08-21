Return-Path: <linux-kernel+bounces-780517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C0B302F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A40C7B81A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F834F481;
	Thu, 21 Aug 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A28yBVwt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270134DCDF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804842; cv=none; b=Dx/mXA03nj0GDBBYxOoUtN/0HciN0t8HRlMyhxNNEakYnFyWdFm2K3y4Muq5XswIeP0C5E/kMdJK85bWrpbD8AJIdKnLtc51y9MgE74b8NmyaPdBjATnugQ2gfqEeM1VnkN1V2YKLR4u4lleEVEf2Ws7JS4zrtkqCN3W9JTyiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804842; c=relaxed/simple;
	bh=w7KymYTGQibyigOB3LtRQvGqUCYv8LIg5NrXeJyZ5Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCRLv5/hcplV3PIwO63UsY7rrpFkSAV0zyaz6wVgL0YNxSi0KQ9AY+fiOQbWAfEIgn7LQt4GdU3d3ahzx8w/SKwVIwONxegZV0tFgdr5TqJa9YcXh4Xb4tu20qyfaIneXNzxIDT+bKIsx4rert6YoepP7gGk8exfyVShK/NV9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A28yBVwt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755804839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nerOTYRWFdtdmAMjyNhutLUfO/Rx0qGyC8/8HVBIbbk=;
	b=A28yBVwtx9Ls13ynaiD+Bm/62NztCrYnbgCgpzGbebMeBkGjwynhT5dZEQHkOaaRUDvdLY
	5O1JcN3wEdiq6eaWLz3yCxkcUTlRYwu7EXn5Ii5E61skfMLqduL4BhNR3jWAlriMT0ZYT2
	0dJWr6Xojt9EIElNkSQikC8jVO/EZ+E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-PadaENquOyOP4_8iqBM2GQ-1; Thu,
 21 Aug 2025 15:33:58 -0400
X-MC-Unique: PadaENquOyOP4_8iqBM2GQ-1
X-Mimecast-MFC-AGG-ID: PadaENquOyOP4_8iqBM2GQ_1755804834
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02E03180028E;
	Thu, 21 Aug 2025 19:33:54 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.89.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 042241955F24;
	Thu, 21 Aug 2025 19:33:50 +0000 (UTC)
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
Subject: [PATCH v9 7/7] rust: hrtimer: Add HrTimer::expires()
Date: Thu, 21 Aug 2025 15:32:47 -0400
Message-ID: <20250821193259.964504-8-lyude@redhat.com>
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
index 874a1023dcdf9..7320d8715bcc2 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -211,7 +211,6 @@ pub(crate) fn as_nanos(&self) -> i64 {
     /// # Safety
     ///
     /// The caller promises that `ktime` is in the range from 0 to `KTIME_MAX`.
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


