Return-Path: <linux-kernel+bounces-767628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8276EB256EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE751C84D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9543002CD;
	Wed, 13 Aug 2025 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkjWjh/h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA02FE06F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125011; cv=none; b=TYQjpF6df0FUXymGHs9VSO1+ExNxztbDF9OBEk1xoFmx+liirjy8kwLDugAZL1qombKHfhwcqLP3MX/GbLwBXO1VOHvPhJ2vtXowK5xo/m1EaqIP+U2X1s/r2rEPyALwJYK9DGvBKNGDb+XSu36TWNSlfOLqw91OXq31rtrbll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125011; c=relaxed/simple;
	bh=9FWtx64Gf/D0FDEiQ1Oftbt3euOjkM+z0PSCApFccVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxQrEPIIJadi+YKOgo7nhBainP966f/qN6ncEA+8DeUBhP9lm321DXoMDevloo5DnGI5I0UnXWmdNOFOxbdzsccrrFRZQTgasOewD1AK8M9wW9Aop+ARP64H4+xMdXkzYP0xRc4PpsZfMXzFg+CwA/3DKQEk6Sd1tGsAcgAED6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkjWjh/h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755125007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oejlMLAAfPv/LBX4eO/QzEdA8WEyxlkO8EudoL3ZCiY=;
	b=AkjWjh/hJZxxe0zV+nGY1spIPQ+T2j5FeBxd73Vl1in0CBvOATdJC5dCnyQLb+JrgLCZq2
	t64IJ+KY9YkfdsCEem+3Ui1EvJKO4MSCaU0hJn5AHAjXESgSYHdSSGuUMl9C6/JA8SRct2
	gSyC548+9+5JRn8IrurGsLP3I+yVeaM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-nFI4v9ifP-6qbwAMz9hmsQ-1; Wed,
 13 Aug 2025 18:43:24 -0400
X-MC-Unique: nFI4v9ifP-6qbwAMz9hmsQ-1
X-Mimecast-MFC-AGG-ID: nFI4v9ifP-6qbwAMz9hmsQ_1755125002
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAA31195608F;
	Wed, 13 Aug 2025 22:43:21 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B72430001A1;
	Wed, 13 Aug 2025 22:43:18 +0000 (UTC)
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
Subject: [PATCH v7 5/7] rust: hrtimer: Add forward_now() to HrTimer and HrTimerCallbackContext
Date: Wed, 13 Aug 2025 18:42:20 -0400
Message-ID: <20250813224240.3799325-6-lyude@redhat.com>
In-Reply-To: <20250813224240.3799325-1-lyude@redhat.com>
References: <20250813224240.3799325-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


