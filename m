Return-Path: <linux-kernel+bounces-876929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE023C1CCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC33189DA24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C53570A1;
	Wed, 29 Oct 2025 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWM7+EOs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA263563DD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762958; cv=none; b=fsWBM1eOnWWXkkeBjqG6165IiVWWNuOddYq2gpDO1idYnuuvbU0KKV6VZLn99q/54wqTI4kvadfDs0JEsO6ta2rdU52ApqH6y0i1cs/M/NeoOyKoaBzHUPrPv2yO9OC3jKOiCRbvKR0rO8uYY/m0RIVhEsIsKSRqcbAycyjgYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762958; c=relaxed/simple;
	bh=udIh2bGtuLNE6rEEqLIOSosK6IG9nhYY4jrIrv0IDZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnrWYjnR4tkEJpAgUrC9p6DxiP0K+OR+fBF8a7FvS+rhTFifv0sdoljRlc7qdNwWd5vrSm12PA4f1PQ+AkwuCzpK1fddgmcO1bnDnt1ktbAI5P2X0So2HGCNhQynWXjbgw2ZCpNeqaPebl9FVIkZA8Z9pAc6yWFTWSEPoCcEomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWM7+EOs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761762956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8f1g362cqWO6k2T0sE2qqCCKSx99lIgktzJDMD+ggRc=;
	b=TWM7+EOsy7IvWghD+68cYmHg9QEJw7rT5M6W0Pq732OxsBfNumG4AFq0sA1i/9X+vjqWB3
	+ayApwCh6LhRti1Imb64B3OHZMRRgZBHBk4Gar5D1xpHpyMTrkg/bQ9/VFwpgQMOYMKndO
	y4/R7aG3Vq5zTfs+Jn0F+Ugbzhzh69U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-G76yMnHtP6GMvUjdf2GQhw-1; Wed,
 29 Oct 2025 14:35:52 -0400
X-MC-Unique: G76yMnHtP6GMvUjdf2GQhw-1
X-Mimecast-MFC-AGG-ID: G76yMnHtP6GMvUjdf2GQhw_1761762950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7353C1800D86;
	Wed, 29 Oct 2025 18:35:50 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.88.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A41121800353;
	Wed, 29 Oct 2025 18:35:46 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Benno Lossin <lossin@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v4] rust: lock: Export Guard::do_unlocked()
Date: Wed, 29 Oct 2025 14:35:38 -0400
Message-ID: <20251029183538.226257-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
V4:
* Improve the example to actually demonstrate a situation where
  do_unlocked() would be useful.
* Remove unneeded sentence above example in do_unlocked()

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs | 71 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 5d7991e6d3736..c5f049a115d09 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -230,7 +230,76 @@ pub fn lock_ref(&self) -> &'a Lock<T, B> {
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
+    /// ```
+    /// # use kernel::{
+    /// #     new_mutex,
+    /// #     sync::{lock::{Backend, Guard, Lock}, Arc, Mutex, Completion},
+    /// #     workqueue::{self, impl_has_work, new_work, Work, WorkItem},
+    /// # };
+    /// #[pin_data]
+    /// struct ExampleWork {
+    ///     #[pin]
+    ///     work: Work<Self>,
+    ///
+    ///     #[pin]
+    ///     lock: Mutex<i32>,
+    ///
+    ///     #[pin]
+    ///     done: Completion,
+    /// }
+    ///
+    /// impl_has_work! {
+    ///     impl HasWork<Self> for ExampleWork { self.work }
+    /// }
+    ///
+    /// impl WorkItem for ExampleWork {
+    ///     type Pointer = Arc<ExampleWork>;
+    ///
+    ///     fn run(this: Arc<ExampleWork>) {
+    ///         let mut g = this.lock.lock();
+    ///
+    ///         assert_eq!(*g, 41);
+    ///         *g += 1;
+    ///
+    ///         this.done.complete_all();
+    ///     }
+    /// }
+    ///
+    /// impl ExampleWork {
+    ///     pub(crate) fn new() -> Result<Arc<Self>> {
+    ///         Arc::pin_init(pin_init!(Self {
+    ///             work <- new_work!(),
+    ///             lock <- new_mutex!(41),
+    ///             done <- Completion::new(),
+    ///         }), GFP_KERNEL)
+    ///     }
+    /// }
+    ///
+    /// let work = ExampleWork::new().unwrap();
+    /// let mut g = work.lock.lock();
+    ///
+    /// let _ = workqueue::system().enqueue(work.clone());
+    ///
+    /// // This would deadlock:
+    /// //
+    /// //     work.done.wait_for_completion()
+    /// //
+    /// // Since we hold work.lock, which work will also try to acquire in WorkItem::run. Dropping
+    /// // the lock temporarily while we wait for completion works around this.
+    /// g.do_unlocked(|| work.done.wait_for_completion());
+    ///
+    /// assert_eq!(*g, 42);
+    /// ```
+    pub fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 

base-commit: 3b83f5d5e78ac5cddd811a5e431af73959864390
-- 
2.51.0


