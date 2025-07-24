Return-Path: <linux-kernel+bounces-744728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220FBB11055
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE79B1CE571D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C92EB5D7;
	Thu, 24 Jul 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xn5iagdg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870714286
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377990; cv=none; b=csBGO9+W168xS55iLl1LBRvHxwal23ojgzxFRhbs2CYoKfZvlxHaWFcRXjziDEYCVtLri06SOpVe190BMAcbulqGJu/oTdNYbg1jl0OO3W8NkE34BV71cYRT7+Tpan7T/r7rddH6bo2qEAzRWoEd8a1vSFh1CzHdu7rbqEVfQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377990; c=relaxed/simple;
	bh=RlGbLmiNog8cWFHNbPKc7Ueq04LKxYJ9kEZFBWUJts8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnTRxpDZvP+44+WmnpbfPKSylIDqd/pnycYD3MJeGxv3oxp/0ZzFFPPyX8h6f71EI0fyHWVyRyVndAx6q8meUFWpOmqpSQnoMRfKBR8t1o6RodPA77tB+JFLKvij5Xt9QeMYspvKQTk22JYcAV3fI1uSruG27MD8S5q0zZmT7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xn5iagdg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753377988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a9KFreOIoEfdmP377fh6fXKglMWYPDoj87FLjXMtoPQ=;
	b=Xn5iagdgz4kSQHVKoqnJJBoHiLOihEU4SZMqEcyUT08VIPUizFCd/t0nGYnBuYKpL6Tc/m
	QNcOv6+9FK1msWVViysftLT2hQBMxNerJwglwYWA1WNVFdWsjaYlCHG4fGP49lqyVQ+nol
	xqcHSDPOrUo7Gzt4zpI6SKQYZhmDqK0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-qTTgBXR_OHS3rJSWHLkTFQ-1; Thu,
 24 Jul 2025 13:26:25 -0400
X-MC-Unique: qTTgBXR_OHS3rJSWHLkTFQ-1
X-Mimecast-MFC-AGG-ID: qTTgBXR_OHS3rJSWHLkTFQ_1753377983
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9F82180036D;
	Thu, 24 Jul 2025 17:26:22 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09D31195608D;
	Thu, 24 Jul 2025 17:26:17 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] rust: lock: Export Guard::do_unlocked()
Date: Thu, 24 Jul 2025 13:25:00 -0400
Message-ID: <20250724172615.436901-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In RVKMS, I discovered a silly issue where as a result of our HrTimer for
vblank emulation and our vblank enable/disable callbacks sharing a
spinlock, it was possible to deadlock while trying to disable the vblank
timer.

The solution for this ended up being simple: keep track of when the HrTimer
could potentially acquire the shared spinlock, and simply drop the spinlock
temporarily from our vblank enable/disable callbacks when stopping the
timer. And do_unlocked() ended up being perfect for this.

Since this seems like it's useful, let's export this for use by the rest of
the world and write short documentation for it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
You can find an example usage of this here:

  https://gitlab.freedesktop.org/lyudess/linux/-/blob/rvkms-slim/drivers/gpu/drm/rvkms/crtc.rs

 rust/kernel/sync/lock.rs | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5be289c1..60eb98805a489 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -228,7 +228,13 @@ pub fn lock_ref(&self) -> &'a Lock<T, B> {
         self.lock
     }
 
-    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
+    /// Unlock this [`Guard`]'s lock temporarily, execute `cb`, and then re-lock it.
+    ///
+    /// This can be useful for situations where you may need to do a temporary unlock dance to avoid
+    /// issues like circular locking dependencies.
+    ///
+    /// If the closure returns a value, it will be returned by this function.
+    pub fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 

base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
-- 
2.50.0


