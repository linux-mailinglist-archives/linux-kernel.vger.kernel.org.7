Return-Path: <linux-kernel+bounces-744783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE548B110DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF091CE1A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFEA2ECD0A;
	Thu, 24 Jul 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+8kGjCm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9C1DA23
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381688; cv=none; b=Qer/PLJd1AcIuiSPsC7ZVykXettzljD8CzT0ikn3KRKjsd9OeWmjFNWRb0MgM/mqxiW29ucxsfvELRlXHFKKHrU8PYUbScbuvlfAYtiToG/i6Z1H7VZ3fZEkLjGxTh6VaxRiTCU9hstJERY7DJIlYoeYLsMC8K8luPF5mUgVzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381688; c=relaxed/simple;
	bh=UiEmd3XmX4QQfkOmFQm6Q0KYqOc0JXWHqr44DKyO5ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2fIQ0wjiIZzUGQ5DhkNsTtNwpI+en3nQzJWve5w3P0TK5l+jZ0O0URci1FTp9cneY0UYenkIQ3hapRXczR9xfmiN93LJ9eFqk13iTB9ECkoX7EsDMISDjqokuDF3Gn22Be6rzVNLd8ugcYp1Ku2JfW+TEY8u6z+3zlEahRzRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+8kGjCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753381685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J5I5SK+Y5zDIrC/mG42eswNPXScwy6ArRLIIL/8+Cv4=;
	b=e+8kGjCmZSsY9rHy0ep5wslHoUPGwrBdhf8vUrXy2K7mEJZtsG/pTrKRQmRrRZb1/ScU+s
	yud7PeIc+4OoOXJx5JTVPwCDYwuhDgUllkP4cwuSx8V/xvffoofiL7l5s/6o52/kY920yQ
	rykOXCURVBeMpmb1Guc7DwnsAYNfWaU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-5gec1t6HPZOrO1T6LlFsZg-1; Thu,
 24 Jul 2025 14:28:04 -0400
X-MC-Unique: 5gec1t6HPZOrO1T6LlFsZg-1
X-Mimecast-MFC-AGG-ID: 5gec1t6HPZOrO1T6LlFsZg_1753381682
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D95CB19560A3;
	Thu, 24 Jul 2025 18:28:01 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7488300018D;
	Thu, 24 Jul 2025 18:27:56 +0000 (UTC)
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
Subject: [PATCH v2] rust: lock: Export Guard::do_unlocked()
Date: Thu, 24 Jul 2025 14:27:16 -0400
Message-ID: <20250724182754.549489-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

You can find an example usage of this here:

https://gitlab.freedesktop.org/lyudess/linux/-/blob/rvkms-slim/drivers/gpu/drm/rvkms/crtc.rs

 rust/kernel/sync/lock.rs | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5be289c1..e43ee5e2e4b9f 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -228,7 +228,41 @@ pub fn lock_ref(&self) -> &'a Lock<T, B> {
         self.lock
     }
 
-    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
+    /// Releases this [`Guard`]'s lock temporary, executes `cb` and then re-acquires it.
+    ///
+    /// This can be useful for situations where you may need to do a temporary unlock dance to avoid
+    /// issues like circular locking dependencies.
+    ///
+    /// If the closure returns a value, it will be returned by this function.
+    ///
+    /// # Examples
+    ///
+    /// The following example shows how to use [`Guard::do_unlocked`] to temporarily release a lock,
+    /// do some work, then re-lock it.
+    ///
+    /// ```
+    /// # use kernel::{new_spinlock, sync::lock::{Backend, Guard, Lock}};
+    /// # use pin_init::stack_pin_init;
+    ///
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


