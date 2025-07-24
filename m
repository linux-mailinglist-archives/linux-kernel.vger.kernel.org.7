Return-Path: <linux-kernel+bounces-744819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263ADB1113E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC973AFF30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342252E3394;
	Thu, 24 Jul 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFMaz58M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D3205E02
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383442; cv=none; b=N6rPZt/UPnQAvSmkDuHgygagM/AuFMwdZIxINdVmO8y231ZP8qxZp3dlryuJQDRF4lBCh5xweY7GLJ+2/VnUTgraJUhRBRTkIthOX9gKMWHJV90U2T6hteR2B/ceep7E5gv8zMFzO8jYim5uCJDMpo6hRVMHEocATVUMdEd7CCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383442; c=relaxed/simple;
	bh=WiRKoW3jEqRtZjwGPjsFDVXe43IHCEGeVUZFIvWIvuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjB20Q4J6QeKbU4CtETyXVncuAYQL8a4r6y54D1M6D1FJgQ8tcw+xPzHKFIsfnV82mrYyRUpxaFIDBdOjucqC89ZKD2vf7WvBIf1em5zsk4eU4Kr/ZtSgG2W0XrJXoQV7xqb2vNxl51IB7TixUmPWpeUN/V6a4sEgaAMDkerVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFMaz58M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753383440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JYSxMYzK9rXZpTAuUNhhgT+UnDZ1iR5Hu7L994nIeI=;
	b=NFMaz58MOtcdIhYVtw4f6FAVftopYiwdXQubVJEX8vlhU1X7QufK6Sy3WyJGYt5jlVN7Pr
	uWbldzsxfBCl4VP7u5ppmvPXHgc5x9pTVlJ0bfwC5nuvUJfmIOSxgbpz56FkdZitwpE1en
	YDqup/GqcRdQfBGy+Xhft+8VufOyYQY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-0CFra9ivPg-qFj64AQlijw-1; Thu,
 24 Jul 2025 14:57:17 -0400
X-MC-Unique: 0CFra9ivPg-qFj64AQlijw-1
X-Mimecast-MFC-AGG-ID: 0CFra9ivPg-qFj64AQlijw_1753383435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2724F1800359;
	Thu, 24 Jul 2025 18:57:15 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 148CE195608D;
	Thu, 24 Jul 2025 18:57:10 +0000 (UTC)
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
Subject: [PATCH 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for Instant
Date: Thu, 24 Jul 2025 14:54:06 -0400
Message-ID: <20250724185700.557505-2-lyude@redhat.com>
In-Reply-To: <20250724185700.557505-1-lyude@redhat.com>
References: <20250724185700.557505-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In order to maintain the invariants of Instant, we use saturating
addition/subtraction that is clamped to the valid value range for a
non-negative Ktime.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/time.rs | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 64c8dcf548d63..ac5cab62070c6 100644
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
@@ -214,6 +215,32 @@ fn sub(self, other: Instant<C>) -> Delta {
     }
 }
 
+impl<T: ClockSource> ops::Add<Delta> for Instant<T> {
+    type Output = Self;
+
+    #[inline]
+    fn add(self, rhs: Delta) -> Self::Output {
+        // INVARIANT: We clamp the resulting value to be between `0` and `KTIME_MAX`.
+        Self {
+            inner: self.inner.saturating_add(rhs.nanos).clamp(0, i64::MAX),
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
+        // INVARIANT: We clamp the resulting value to be between `0` and `KTIME_MAX`.
+        Self {
+            inner: self.inner.saturating_sub(rhs.nanos).clamp(0, i64::MAX),
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


