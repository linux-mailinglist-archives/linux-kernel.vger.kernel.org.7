Return-Path: <linux-kernel+bounces-776463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91791B2CDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F418837D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6B322DAA;
	Tue, 19 Aug 2025 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSZNTckq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E83101D2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634464; cv=none; b=UG/Ju/bvlwVYpx0R4JqZNXRXuGxaBF/4OZz5k3ArvUhBDECE9zs1ljJdFDNXNbf+lYjpQN63fwc+mfykmgEgXF4lfaeRhSrEzIc+7xBBnxhDCNCRMVQ+lOmeGPfvOmCVhu6ktNCjflBl6tlUDhpwiGByaNlA53CQV/67jlmBOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634464; c=relaxed/simple;
	bh=9FWtx64Gf/D0FDEiQ1Oftbt3euOjkM+z0PSCApFccVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjFKIdJw9WoQ4dNLJFHPJ5xKzP5daoRTcPA0F3j9LJTrITJNl2Licz0zaIPxwgVfR2HP4jK456Uzn7bIoSAu36biKfzrGIsB8rvnykpyGg8YBZEgkdJjqkKXfEmccD0f2e0Hcl/JqxAgNHWDDdtGsf+SGbadA6YjpYSRtsNGUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSZNTckq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755634462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oejlMLAAfPv/LBX4eO/QzEdA8WEyxlkO8EudoL3ZCiY=;
	b=MSZNTckq5vJAlqMQbZPziicQ0qwJHFay6PoGLpYJN6pE/CNKXPaiT+h/Z+/39OGO8A+PcM
	m9z8vbSuBa0ilG4qeNieDLkwb41NTZBa3F0+T49VtfI3MK5k0hZmSJKP2sJRUlvXWgEqX/
	95oQGRZ8dNG6nd72bbquDZFmnhm90rs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-0ZDiksbAMmm1rCkLVD7O4Q-1; Tue,
 19 Aug 2025 16:14:19 -0400
X-MC-Unique: 0ZDiksbAMmm1rCkLVD7O4Q-1
X-Mimecast-MFC-AGG-ID: 0ZDiksbAMmm1rCkLVD7O4Q_1755634456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A6AC18002CC;
	Tue, 19 Aug 2025 20:14:16 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.81.238])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF4EF19560B2;
	Tue, 19 Aug 2025 20:14:12 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>,
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
Subject: [PATCH v8 5/7] rust: hrtimer: Add forward_now() to HrTimer and HrTimerCallbackContext
Date: Tue, 19 Aug 2025 16:05:56 -0400
Message-ID: <20250819201334.545001-6-lyude@redhat.com>
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

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

---
V2:
* Change from Ktime to Delta
* Make sure that forward_now() takes a mutable reference to the timer
  struct
* Reword this to point out that we're adding forward_now() to both callback
  context and mutable timer reference
* Rename interval to duration
V4:
* Fix rust documentation for HrTimerCallbackContext (forgot to update both
  forward_now() declarations)
* Use Pin<&mut Self> for context-less forward.
V6:
* Drop raw_cb_time(), use Instant::now() instead
* Split out expires() from this patch, at some point it seems I mistakenly
  combined it with this patch
V7:
* Remove leftover comment about raw_cb_time from patch description

 rust/kernel/time/hrtimer.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 1e8839d277292..e0d78a8859903 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -212,6 +212,17 @@ pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interval: Delta) ->
         // valid `Self` that we have exclusive access to.
         unsafe { Self::raw_forward(this, now, interval) }
     }
+
+    /// Conditionally forward the timer.
+    ///
+    /// This is a variant of [`forward()`](Self::forward) that uses an interval after the current
+    /// time of the base clock for the [`HrTimer`].
+    pub fn forward_now(self: Pin<&mut Self>, interval: Delta) -> u64
+    where
+        T: HasHrTimer<T>,
+    {
+        self.forward(HrTimerInstant::<T>::now(), interval)
+    }
 }
 
 /// Implemented by pointer types that point to structs that contain a [`HrTimer`].
@@ -687,6 +698,14 @@ pub fn forward(&mut self, now: HrTimerInstant<T>, interval: Delta) -> u64 {
         // - By our type invariants, `self.0` always points to a valid `HrTimer<T>`
         unsafe { HrTimer::<T>::raw_forward(self.0.as_ptr(), now, interval) }
     }
+
+    /// Conditionally forward the timer.
+    ///
+    /// This is a variant of [`HrTimerCallbackContext::forward()`] that uses an interval after the
+    /// current time of the base clock for the [`HrTimer`].
+    pub fn forward_now(&mut self, duration: Delta) -> u64 {
+        self.forward(HrTimerInstant::<T>::now(), duration)
+    }
 }
 
 /// Use to implement the [`HasHrTimer<T>`] trait.
-- 
2.50.0


