Return-Path: <linux-kernel+bounces-844036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8AEBC0E01
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E430B189F85B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63692D77F5;
	Tue,  7 Oct 2025 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJbNK7wx"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E32D7DE9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830004; cv=none; b=Zl5fSrHABHSHSV6IWn0ZUDVDzmihgsqWjUr02E16BadnN02yfCfwJxEtDcvkeKg9aT5Xl4lQMgz9KJtwCKdd26nOIGQ4GQUvxnShvQJlUn8TEnJiCs+R2ulc8xwOZXbgFlt0JDTCpFkyXBpHmUYFfWLftjngl0LBEqFEnKpOP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830004; c=relaxed/simple;
	bh=wdbJ05BZTStYhJongSuOJ1jxeXUODoRyJelh9iG99eQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UL891NBZCp2/XQ8IxGeb1sW6vXNr8LHun9cVSW4vbqgtNjOyrZVB90Vau1ZY388WlXDNI9YhId1NFkQbtbfgG10os5spdnHXApv+nuFWmwRRj1otwwd0R3K+b+fbrM9qdJKz0ePDjVSVSx4+a8+bH2PHWYte3xqGzgzD3VeJXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJbNK7wx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-639b879e1faso1428198a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759830000; x=1760434800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hS/HO3oIj9CsJ2+yda/U2TQDchHwBdMSLa/BS6MgVuI=;
        b=JJbNK7wxjQtE70lDWbGsaaQvo44TJJtq5gPzTPwv6yY7ldM4xfUjyuF67e4wU8zYtH
         hI/ltTV55mZ5buSp1lDCH2udUt4rCf3NS8K+GmkQKrSOqDAfVBtjwWPMkHV8h11eHitv
         4j6yWxGzBnnUVTDdHGDbdw6twoC0mUTLWKECkEh2ntLmlxFFMx8ceTVIUJfXpqKBJstp
         FnGgro93Ep+RT+TuhARRdE4HjoDRbCDcLUlWznuxXhhQfcrTAvWWaK8gjlwFsfS6ViE6
         ZSNDqS/QTNzHYuSVsIXPXGNula89s35kQNDDLuQouYx06Qul7JuSHs2oGVyQl1I/D9xb
         ceKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830000; x=1760434800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS/HO3oIj9CsJ2+yda/U2TQDchHwBdMSLa/BS6MgVuI=;
        b=sBPzUwlz6VHn+rn97XGw0m/f3qppbjN8FH5WYjK9Et8OSonK3QbCJnIhfBDfCi0l2i
         glf+wD9q2yjTu0yWKeIOeQZx3frg8eCHJToIHumitSS+5tC3VXEuCf/4fLiGtPc9fKpB
         xVt/YTVS/xRZXnkPdo+jhFfd5MeaTp9Z0PtViFILAJ+ZxeNK+jpbX0JUyKMo1zgHh4YQ
         PnIoo+iTqNSWEAWpStViZztgrGJ01gZlKUxLawOg+oF7P8yMCmyPbfYhIMwypeJJzxKJ
         dsslATX0snYp/7ump7uyKa1kycptJddKxQLkU6fZszgZrbw98wkwEH7RGMsdijmwGFpr
         pKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe7lV0cXsOo4FUoqn8r0bBmIlpSNP2DGDZzhjMluZDqYf8SEunhiWZivAfivECficj6GcOXt51NqjGd00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIwvi0ZW4hmW114Dksv8B0zvayVJMoi3RaFktW2XwaSi72z6FO
	lTN2iGy1doKxoXDdWyfJQmm/kA56JoVC/j3vfpl9QMrYM51UZcrt9EvJr5y0gQvc6d7mdc8G3uO
	cMIZbNT6UKOzQYQ+m8Q==
X-Google-Smtp-Source: AGHT+IFUm6CVMf4M6thjgwo80R/yZkT69buZd62jJH8NnU3M/qf3KbPbTMONXGp53zdLJ5fTL/sS5O6HFZv/Y9I=
X-Received: from edra16.prod.google.com ([2002:aa7:d910:0:b0:634:4a04:b8ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ecc:b0:61c:db49:aec0 with SMTP id 4fb4d7f45d1cf-639baf1bbc5mr3200437a12.5.1759829999724;
 Tue, 07 Oct 2025 02:39:59 -0700 (PDT)
Date: Tue, 07 Oct 2025 09:39:53 +0000
In-Reply-To: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007-binder-freeze-v2-0-5376bd64fb59@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8162; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wdbJ05BZTStYhJongSuOJ1jxeXUODoRyJelh9iG99eQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo5N/r8Ok87S1Nl3CTrlWaPq8znlNJ71/fN69za
 FJ3iRbyBoKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaOTf6wAKCRAEWL7uWMY5
 Rlx3D/9p4CPhqeLRPvy0jrZnoqqkQNs8pWFn6zY5aZ5IL5cXTMUHSfTqjMp5+kwsxXC5yFvp6NH
 d6NArekmLArWzU81hQDisWaiCd9Mu01nYijDrFHhuZFduaGnbse9lnKXjc1MbJeXOwr0dXHGXv/
 xMa8k01rojEY84Rqu3aWmTY48j+f5/FadempunwF7u2rfmS/kygXldCx6/qpNYM6ERdmcOpjk38
 dPvK7YS+eqbLrJyL20cHTTtr37mnorMl88nFgjtQI34bagSc8qAcr8XTyNkZ1RcrJhDDECfOnyH
 tvztda8u3qvVNXGEJ9y88dZ3VRw2TWjXUT4GoHUawIcqF28yOrR1z+YnvexRe8TjCfMqnWlM3h8
 NSv9GZzSoZBI/39AFE7WZCge1iBSbzu+PePQ2pYgoVBFFqJmLLe8jFrqkSnxMAAUNhX63LSrp+d
 kaWd07e4vFaft4zXJ6r0+DDN7wswa9lN4L39VUCDw+FcPegZaRNioDSNnYfjEk3SeJFM6LwCiQK
 X31V5kLv8WMQq/K7kEZRaTDyGsxr3AulKCiGzFhE8+erDWNxAfxcyhmq0Z66qh1HZrkS4jsYyxH
 rdtTJ94ldLrQSYSJTmAAj0rQi3YzqGAjH1BD4+Qdoq17u8micQo5PBNwv2toDtlW2zkF3Mer6Xy mhqCbf8ZN4nfGyw==
X-Mailer: b4 0.14.2
Message-ID: <20251007-binder-freeze-v2-3-5376bd64fb59@google.com>
Subject: [PATCH v2 3/3] rust_binder: report freeze notification only when
 fully frozen
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Binder only sends out freeze notifications when ioctl_freeze() completes
and the process has become fully frozen. However, if a freeze
notification is registered during the freeze operation, then it
registers an initial state of 'frozen'. This is a problem because if
the freeze operation fails, then the listener is not told about that
state change, leading to lost updates.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This is also an issue in C Binder. A fix for that will be sent
separately.
---
 drivers/android/binder/freeze.rs      |  4 +--
 drivers/android/binder/process.rs     | 46 ++++++++++++++++++++++++++++-------
 drivers/android/binder/transaction.rs |  6 ++---
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/android/binder/freeze.rs b/drivers/android/binder/freeze.rs
index e304aceca7f31c15444cf67bb13488cd144345e6..220de35ae85ac8de2af717129011e0ace0677b7d 100644
--- a/drivers/android/binder/freeze.rs
+++ b/drivers/android/binder/freeze.rs
@@ -121,7 +121,7 @@ fn do_work(
             writer.write_payload(&self.cookie.0)?;
             Ok(true)
         } else {
-            let is_frozen = freeze.node.owner.inner.lock().is_frozen;
+            let is_frozen = freeze.node.owner.inner.lock().is_frozen.is_fully_frozen();
             if freeze.last_is_frozen == Some(is_frozen) {
                 return Ok(true);
             }
@@ -254,7 +254,7 @@ pub(crate) fn freeze_notif_done(self: &Arc<Self>, reader: &mut UserSliceReader)
                 );
                 return Err(EINVAL);
             }
-            let is_frozen = freeze.node.owner.inner.lock().is_frozen;
+            let is_frozen = freeze.node.owner.inner.lock().is_frozen.is_fully_frozen();
             if freeze.is_clearing || freeze.last_is_frozen != Some(is_frozen) {
                 // Immediately send another FreezeMessage.
                 clear_msg = Some(FreezeMessage::init(alloc, cookie));
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..2da9344397506a3f6d6b13411c45d5ded92d6db1 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -72,6 +72,33 @@ fn new(address: usize, size: usize) -> Self {
 const PROC_DEFER_FLUSH: u8 = 1;
 const PROC_DEFER_RELEASE: u8 = 2;
 
+#[derive(Copy, Clone)]
+pub(crate) enum IsFrozen {
+    Yes,
+    No,
+    InProgress,
+}
+
+impl IsFrozen {
+    /// Whether incoming transactions should be rejected due to freeze.
+    pub(crate) fn is_frozen(self) -> bool {
+        match self {
+            IsFrozen::Yes => true,
+            IsFrozen::No => false,
+            IsFrozen::InProgress => true,
+        }
+    }
+
+    /// Whether freeze notifications consider this process frozen.
+    pub(crate) fn is_fully_frozen(self) -> bool {
+        match self {
+            IsFrozen::Yes => true,
+            IsFrozen::No => false,
+            IsFrozen::InProgress => false,
+        }
+    }
+}
+
 /// The fields of `Process` protected by the spinlock.
 pub(crate) struct ProcessInner {
     is_manager: bool,
@@ -98,7 +125,7 @@ pub(crate) struct ProcessInner {
     /// are woken up.
     outstanding_txns: u32,
     /// Process is frozen and unable to service binder transactions.
-    pub(crate) is_frozen: bool,
+    pub(crate) is_frozen: IsFrozen,
     /// Process received sync transactions since last frozen.
     pub(crate) sync_recv: bool,
     /// Process received async transactions since last frozen.
@@ -124,7 +151,7 @@ fn new() -> Self {
             started_thread_count: 0,
             defer_work: 0,
             outstanding_txns: 0,
-            is_frozen: false,
+            is_frozen: IsFrozen::No,
             sync_recv: false,
             async_recv: false,
             binderfs_file: None,
@@ -1260,7 +1287,7 @@ fn deferred_release(self: Arc<Self>) {
         let is_manager = {
             let mut inner = self.inner.lock();
             inner.is_dead = true;
-            inner.is_frozen = false;
+            inner.is_frozen = IsFrozen::No;
             inner.sync_recv = false;
             inner.async_recv = false;
             inner.is_manager
@@ -1371,7 +1398,7 @@ pub(crate) fn drop_outstanding_txn(&self) {
                 return;
             }
             inner.outstanding_txns -= 1;
-            inner.is_frozen && inner.outstanding_txns == 0
+            inner.is_frozen.is_frozen() && inner.outstanding_txns == 0
         };
 
         if wake {
@@ -1385,7 +1412,7 @@ pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
             let mut inner = self.inner.lock();
             inner.sync_recv = false;
             inner.async_recv = false;
-            inner.is_frozen = false;
+            inner.is_frozen = IsFrozen::No;
             drop(inner);
             msgs.send_messages();
             return Ok(());
@@ -1394,7 +1421,7 @@ pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
         let mut inner = self.inner.lock();
         inner.sync_recv = false;
         inner.async_recv = false;
-        inner.is_frozen = true;
+        inner.is_frozen = IsFrozen::InProgress;
 
         if info.timeout_ms > 0 {
             let mut jiffies = kernel::time::msecs_to_jiffies(info.timeout_ms);
@@ -1408,7 +1435,7 @@ pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
                     .wait_interruptible_timeout(&mut inner, jiffies)
                 {
                     CondVarTimeoutResult::Signal { .. } => {
-                        inner.is_frozen = false;
+                        inner.is_frozen = IsFrozen::No;
                         return Err(ERESTARTSYS);
                     }
                     CondVarTimeoutResult::Woken { jiffies: remaining } => {
@@ -1422,17 +1449,18 @@ pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
         }
 
         if inner.txns_pending_locked() {
-            inner.is_frozen = false;
+            inner.is_frozen = IsFrozen::No;
             Err(EAGAIN)
         } else {
             drop(inner);
             match self.prepare_freeze_messages() {
                 Ok(batch) => {
+                    self.inner.lock().is_frozen = IsFrozen::Yes;
                     batch.send_messages();
                     Ok(())
                 }
                 Err(kernel::alloc::AllocError) => {
-                    self.inner.lock().is_frozen = false;
+                    self.inner.lock().is_frozen = IsFrozen::No;
                     Err(ENOMEM)
                 }
             }
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 02512175d6229535373f2d3e543ba8c91ecd72f0..4bd3c0e417eb93d5d62d9c20daadde1fb0e4990f 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -249,7 +249,7 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
 
         if oneway {
             if let Some(target_node) = self.target_node.clone() {
-                if process_inner.is_frozen {
+                if process_inner.is_frozen.is_frozen() {
                     process_inner.async_recv = true;
                     if self.flags & TF_UPDATE_TXN != 0 {
                         if let Some(t_outdated) =
@@ -270,7 +270,7 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
                     }
                 }
 
-                if process_inner.is_frozen {
+                if process_inner.is_frozen.is_frozen() {
                     return Err(BinderError::new_frozen_oneway());
                 } else {
                     return Ok(());
@@ -280,7 +280,7 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
             }
         }
 
-        if process_inner.is_frozen {
+        if process_inner.is_frozen.is_frozen() {
             process_inner.sync_recv = true;
             return Err(BinderError::new_frozen());
         }

-- 
2.51.0.618.g983fd99d29-goog


