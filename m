Return-Path: <linux-kernel+bounces-767630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8AB256F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCB3A24FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3002FE06C;
	Wed, 13 Aug 2025 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDNCxygj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056232E9EAF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125023; cv=none; b=CRq4eyXSb7ftIOxDPpb1jGXPPJYCnwqLwGfN06DhKWOc+S4Z9vhXO7eepH69TbSia4ho4K4XAxIwsp6n2LKLkMi92yK5CMcUu/DhPrJQAzbny+qwzniZ7AXbUwUMx+M6bCeYgaEUVFh4Mq88oKgpn5C6M1TMhgpkQ66E7Mx7Igs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125023; c=relaxed/simple;
	bh=kw9aKeOPm+kK2NtplyKqg/lcu6lHjVJFBGPczsehNto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUK55Agti5BtLCsvedkIp+weBBItjWHO+Iba4NvsN1/FGqIte/0JKk3Vn5VkAyTFpTQQfuD32QkOHAD660i+EIYl/0QbBNGSFWzL+U+rgSPaH53kjkjacOJ98lQidIZAl7DIHjwuoGM1VldybFYytoImkbNYkstd6Hf8Kd/lEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDNCxygj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755125020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFKyJpyWxav4iF539g8SRnmzrL3AOgHfE3g3GrGyBb0=;
	b=WDNCxygjs/OM30fkiOoO5cjT7mRbvufaJuyCkan1jgww4Af+B26OH084dBx/BZdrkbmZ6z
	Koj4euVfp8x47YYrUd0dfTAbJ4FT8Tq1F3B16f4uwKk/VdcAGJbmUU/RcX47a1jVrSHq+s
	FlDCBK7sVA4x8W0S8cF5WbLsllgZVgw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-DRXOyBYnPq2d5oz_HQzM4w-1; Wed,
 13 Aug 2025 18:43:36 -0400
X-MC-Unique: DRXOyBYnPq2d5oz_HQzM4w-1
X-Mimecast-MFC-AGG-ID: DRXOyBYnPq2d5oz_HQzM4w_1755125010
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 893651956089;
	Wed, 13 Aug 2025 22:43:30 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A487E30001A1;
	Wed, 13 Aug 2025 22:43:26 +0000 (UTC)
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
Subject: [PATCH v7 7/7] rust: hrtimer: Add HrTimer::expires()
Date: Wed, 13 Aug 2025 18:42:22 -0400
Message-ID: <20250813224240.3799325-8-lyude@redhat.com>
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

Add a simple callback for retrieving the current expiry time for an
HrTimer. In rvkms, we use the HrTimer expiry value in order to calculate
the approximate vblank timestamp during each emulated vblank interrupt.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time.rs         |  1 -
 rust/kernel/time/hrtimer.rs | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 75088d080b834..6d6e71710ebdc 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -211,7 +211,6 @@ pub(crate) fn as_nanos(&self) -> i64 {
     /// # Safety
     ///
     /// The caller promises that `nanos` is in the range from 0 to `KTIME_MAX`.
-    #[expect(unused)]
     #[inline]
     pub(crate) unsafe fn from_nanos(nanos: i64) -> Self {
         debug_assert!(nanos >= 0);
diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index e0d78a8859903..cdf583f870376 100644
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
+        // - `node.expires` is a ktime_t, so it must be within the range of `0` to `KTIME_MAX`.
+        // - There's no actual locking here, a racy read is fine and expected
+        unsafe {
+            Instant::from_nanos(
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


