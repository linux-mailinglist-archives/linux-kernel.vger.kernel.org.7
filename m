Return-Path: <linux-kernel+bounces-744953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A5B112E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00991CE32DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C318B239E6E;
	Thu, 24 Jul 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0I9HWZA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3661D5ADE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391810; cv=none; b=WmqL+/+GIOQD+6MxDC6eRP7ypb2+XYLsWl0s+BkVUmrwaPsoCkJq2VnkTEBDYHRZEj4t15J8s7Gu+X/lfoNItev2jbty53j/N2BQc07TtRI9N3OlOijQ3dpfQBfAGADha4fAzw3j7bNpgT1wFPGpWLiF29M1srNroNncUeqS2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391810; c=relaxed/simple;
	bh=tmQ7sXnK4M8nff+6s4Cfcmwg8OnUqaKS60lASLQsmUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdwcREJugL9OvXkAHz745ZA/eEsz1FcIlbM7y8KXWMmoajejWDSvhCDELGd+oT9wH7Ep+NoEGjJY8AHffaLtH2pGi68aakwaRbOdVUVkbDiHW6AvJb+ZmJaMeQ5sBSRRna0G1IHSYpvmJXhRpysK7pQPqzgSxI8Akow28Xd3PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0I9HWZA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753391807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SFSZSHt4zByYrLjimXTP8gr8XqydI2M7OnLWTmtzRSc=;
	b=R0I9HWZAty++4r8KJEmFI8K4nhHVaJbDMNgrobB+q1N/FeOK0hSUJNXMbKDga2S1T56K9h
	TdZwVHJjWL95K2xlPkigUU5zenSZATJ7shAZicuTPC867nhih4RcuB6ITSmZyv1tarVe5e
	/q6rNPAdMF6RjiRR4HoEy81bPc5Jkx4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-CzUhNK1yORq9B5cs7wEBMw-1; Thu,
 24 Jul 2025 17:16:44 -0400
X-MC-Unique: CzUhNK1yORq9B5cs7wEBMw-1
X-Mimecast-MFC-AGG-ID: CzUhNK1yORq9B5cs7wEBMw_1753391802
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4261180045C;
	Thu, 24 Jul 2025 21:16:41 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABED119560AA;
	Thu, 24 Jul 2025 21:16:37 +0000 (UTC)
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
Subject: [PATCH v3] rust: lock: Export Guard::do_unlocked()
Date: Thu, 24 Jul 2025 17:15:56 -0400
Message-ID: <20250724211634.586808-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
V2:
* Fix documentation for do_unlocked
* Add an example
V3:
* Documentation changes from Miguel

 rust/kernel/sync/lock.rs | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5be289c1..800cdd16dce6e 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -228,7 +228,40 @@ pub fn lock_ref(&self) -> &'a Lock<T, B> {
         self.lock
     }
 
-    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
+    /// Releases this [`Guard`]'s lock temporarily, executes `cb` and then re-acquires it.
+    ///
+    /// This can be useful for situations where you may need to do a temporary unlock dance to avoid
+    /// issues like circular locking dependencies.
+    ///
+    /// It returns the value returned by the closure.
+    ///
+    /// # Examples
+    ///
+    /// The following example shows how to use [`Guard::do_unlocked`] to temporarily release a lock,
+    /// do some work, then re-lock it.
+    ///
+    /// ```
+    /// # use kernel::{new_spinlock, sync::lock::{Backend, Guard, Lock}};
+    /// # use pin_init::stack_pin_init;
+    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
+    ///     // Address-equal means the same lock.
+    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
+    /// }
+    ///
+    /// stack_pin_init! {
+    ///     let l = new_spinlock!(42)
+    /// }
+    ///
+    /// let mut g = l.lock();
+    /// let val = *g;
+    ///
+    /// // The lock will be released, but only temporarily
+    /// g.do_unlocked(|| assert_eq!(val, 42));
+    ///
+    /// // `g` originates from `l` and should be relocked now.
+    /// assert_held(&g, &l);
+    /// ```
+    pub fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 

base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
-- 
2.50.0


