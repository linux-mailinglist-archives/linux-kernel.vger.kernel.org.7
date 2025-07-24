Return-Path: <linux-kernel+bounces-744814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1192B11138
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6A8AE3A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1D82ECEAE;
	Thu, 24 Jul 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vmev+ZRS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2872EE263
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383201; cv=none; b=gorKV1PY8dSaZ2dcQOu5+GKOPevK3bpVC9cCdOjTbuJtXn4+UhK34mkC9itnGh5WzpkEc+9ZlEG7si7wk9SCZ8CkN4fz3ckxHVGlA77FYfUiH4AAkC4NDfCpTg/vpoWsGQavKz4o6RgzPigV04ZWofrNtwDeZ7zECn8nzs321tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383201; c=relaxed/simple;
	bh=YKRbPoAK3fgOTSCkr0VL0uVTvX7QyTPZdBAwEBeHOP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLa+abhLwH+oie6udnsosstocgPOdwDijHlpArNq7Yl4LtwW1oOVamejAtMbQrMlOfRSnQ1AM9Wur0Vtbuer6pJuPuU8Va01G45yLpv/lxR+2Xcyk7pqgHKGiD6NXDXIxzAI4r3nqtXXOn00UNs6r/dC6MV3sOr/tL7Q8ePQPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vmev+ZRS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753383199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K692SAsepPxZfbndfFazUHoePE2ffj8dBBSNIklQ0qY=;
	b=Vmev+ZRSRCmRGIEapD+xcBqKP+83ajrGBRf6QKPRlOIp2GbNoEmYuxmhgyYOSJpRT6PhCj
	bXyZt3cnDj02a4/nDbz7OB5PWP+wEav6H092oOX1eOQYXL90GyHIfPkL+JbIlRa2aCX+K2
	wnEj0aO7J5tgwB2uIK1qzp+ozLRRKvg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-8szsOUW7Nr-eNbV5lGKWEA-1; Thu,
 24 Jul 2025 14:53:15 -0400
X-MC-Unique: 8szsOUW7Nr-eNbV5lGKWEA-1
X-Mimecast-MFC-AGG-ID: 8szsOUW7Nr-eNbV5lGKWEA_1753383193
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3FB2195FD06;
	Thu, 24 Jul 2025 18:53:12 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C43C2195608D;
	Thu, 24 Jul 2025 18:53:08 +0000 (UTC)
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
Subject: [PATCH v6 5/7] rust: hrtimer: Add forward_now() to HrTimer and HrTimerCallbackContext
Date: Thu, 24 Jul 2025 14:49:31 -0400
Message-ID: <20250724185236.556482-6-lyude@redhat.com>
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

Using the HrTimer::raw_time_cb() function, we can now add an equivalent to
hrtimer_forward_now() to both HrTimer and HrTimerCallbackContext.

Signed-off-by: Lyude Paul <lyude@redhat.com>

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

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/time/hrtimer.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index a8fb176e599e8..fa5a3ae81723b 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -212,6 +212,17 @@ pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interval: Delta) ->
         //   exclusive access to it - fulfilling the requirements of the C API.
         unsafe { Self::raw_forward(self.get_unchecked_mut(), now, interval) }
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


