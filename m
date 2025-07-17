Return-Path: <linux-kernel+bounces-735886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614EB094DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D23A3FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C11306DB2;
	Thu, 17 Jul 2025 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIxUXaKr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01E303DFE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779945; cv=none; b=lhpzXzUEPfg4KxhFnfqsDcNeAdeTy1CoTRGtDgunMYvg+2u2/tiknSF+ly7RYp88tvV+4lMyIzlhP2STG7gXNGWkarScOZSbMoHU77senZtUsfwyHY3Fg+dsg/XsWJ3EZcHauDWStx1K/YnrKcv6W1MyXa7O5bpgH0ENv7yfbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779945; c=relaxed/simple;
	bh=VC8WDukeh9OwMNpoeQiJvdW7sRso+KzAfeZjCg3qyWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjd3VYN5MyUSh3p6O3kuRZQLucJoDz8Ut86MxIKFrExTofTrFEFIjclhceR/02++d/Ep/5Bf1Hak0e2G+0H9PVacPLIF1MNB4JldDP5kcnDdi+K1AkMFz5kF9gx2dXVWMepjvyNp3VWUHx1jJer+6Q48C7xgdVeHdPOa8+TTaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIxUXaKr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752779942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Etkjz+aUp4PF+9X5O/5ljNHVpe734yWQe/o9GjeX31I=;
	b=eIxUXaKr9q59oMuyMynATlmbFm818qVSbhgXABdr6hnjpKijjz+JJias/YgporWho0xJUw
	3H0ayZGMLov6vstRRwMP539NthU6YMslsHthabd9eUgbpTNgU3ENwXNUVa0rN9ky6qMQKx
	IU+Ri29SsqfULLjXM20eeya8EaZW/Qo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-GSGJw9D6N6OETmW7MjaH0Q-1; Thu,
 17 Jul 2025 15:18:58 -0400
X-MC-Unique: GSGJw9D6N6OETmW7MjaH0Q-1
X-Mimecast-MFC-AGG-ID: GSGJw9D6N6OETmW7MjaH0Q_1752779935
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91B5719560B3;
	Thu, 17 Jul 2025 19:18:55 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.66.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 162FA1966650;
	Thu, 17 Jul 2025 19:18:52 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
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
Subject: [PATCH v12 14/15] rust: sync: lock/global: Add BackendInContext support to GlobalLock
Date: Thu, 17 Jul 2025 15:15:53 -0400
Message-ID: <20250717191719.2076270-15-lyude@redhat.com>
In-Reply-To: <20250717191719.2076270-1-lyude@redhat.com>
References: <20250717191719.2076270-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Now that we have the ability to provide an explicit lifetime for a
GlobalGuard and an explicit Backend for a GlobalGuard, we can finally
implement lock_with() and try_lock_with().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock/global.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index f9a9c4bdc46b0..1f28bf5fc8851 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -89,6 +89,34 @@ pub fn try_lock(&'static self) -> Option<GlobalGuard<'static, G, G::Backend>> {
             inner: self.inner.try_lock()?,
         })
     }
+
+    /// Lock this global lock with the provided `context`.
+    pub fn lock_with<'a, B>(
+        &'static self,
+        context: <G::Backend as Backend>::Context<'a>,
+    ) -> GlobalGuard<'a, G, B>
+    where
+        G::Backend: Backend<BackendInContext = B>,
+        B: Backend,
+    {
+        GlobalGuard {
+            inner: self.inner.lock_with(context),
+        }
+    }
+
+    /// Try to lock this global lock with the provided `context`.
+    pub fn try_lock_with<'a, B>(
+        &'static self,
+        context: <G::Backend as Backend>::Context<'a>,
+    ) -> Option<GlobalGuard<'a, G, B>>
+    where
+        G::Backend: Backend<BackendInContext = B>,
+        B: Backend,
+    {
+        Some(GlobalGuard {
+            inner: self.inner.try_lock_with(context)?,
+        })
+    }
 }
 
 /// A guard for a [`GlobalLock`].
-- 
2.50.0


