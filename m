Return-Path: <linux-kernel+bounces-751100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1587B1653E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F7B1AA1AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC772E11B8;
	Wed, 30 Jul 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QRzF/Fbh"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9122E0B4E;
	Wed, 30 Jul 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895717; cv=none; b=qP3oXw0uDvB4/nF08DuFIm4cDCZeXW74CAmNJ+pZbTmn3FVs7Qzp+/l3YR9vpI3GMh+10Retjhis8gong/ho++DPxLdzscr7kd02IdFB2wg4RE5c1VsqoOMwT3NXWPH5e6hs/MooVna1VpjiV5lJ6zaBrrewE5RWZo5MIBZAXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895717; c=relaxed/simple;
	bh=mTPBfKO4z4+W6J3cY3fLbZo21S5Y1PGCVi84PExWXcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+GrNkcy3iYUsWRfsVQO3H5T4vaUPG0O5Tw4pZNxr9aYQqM5sUlDd+xAPozs3O4IZCWxKzGZP2FTOnm1CbYf5xuCl39qSJbEhewWAy4gUIR8uYTZFeQpxGAtK3LzIBdvXwGb8IjKYuUF8RY32R1n4mfJUrDWd9IOTK+VchAIKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QRzF/Fbh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753895713;
	bh=mTPBfKO4z4+W6J3cY3fLbZo21S5Y1PGCVi84PExWXcQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QRzF/Fbh1UipAN19OrVb8tUoVGLk3DnLQXoCLm+6Mm4UTN4V0wAp0WDiI53s6Kgno
	 B90DIqI/jC6i4/5tneT8kjdMonyrwv+Qxe88wfQIUJFLMppAScyOpYQf6Ueg3iK0Oq
	 zcszsK65NkvXI78c0z+5aHYl+eozAp052mDsxLmW5Q4ndwFlxo06tce7pR481bR1jo
	 uAYzfreFEsppBXMNAKU3FzOClgSfz7lz+0KfIXCd8DkV6s/xYIZJg2dtZChrfOS3AL
	 gl2Z1REbU5oPYOKJ7q0RCpAC8JoomdPFVZlF2pu9pd4NCujjRziSHs0PBRbCA2Hejs
	 Ez+3di4shtr0A==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CFC6717E15D4;
	Wed, 30 Jul 2025 19:15:10 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 30 Jul 2025 14:14:46 -0300
Subject: [PATCH 3/3] rust: lock: add a Pin<&mut T> accessor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-lock-t-when-t-is-pinned-v1-3-1b97d5f28aa2@collabora.com>
References: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com>
In-Reply-To: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

In order for callers to be able to access the inner T safely if T: !Unpin,
there needs to be a way to get a Pin<&mut T>. Add this accessor and a
corresponding example to tell users how it works.

This is not useful on its own for now, because we do not support pin
projections yet. This means that the following is not going to compile:

    let mut data: MutexGuard<'_, Data> = mutex.lock();
    let mut data: Pin<&mut Data> = data.as_mut();
    let foo = &mut data.foo;

A future patch can enable the behavior above by implementing support for
pin projections.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/lock.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 087bc0391f92a73b9af18ca31461b513bb5a9bcd..27857659a7f1ba4a8b844bb18d009d037e0c5b03 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -243,6 +243,25 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
 
         cb()
     }
+
+    /// Returns a pinned mutable reference to the protected data.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    ///     # use kernel::sync::{Mutex, MutexGuard};
+    ///     # use core::pin::Pin;
+    ///     struct Data;
+    ///
+    ///     fn example(mutex: &Mutex<Data>) {
+    ///         let mut data: MutexGuard<'_, Data> = mutex.lock();
+    ///         let mut data: Pin<&mut Data> = data.as_mut();
+    ///     }
+    /// ```
+    pub fn as_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: `self.lock.data` is structurally pinned.
+        unsafe { Pin::new_unchecked(&mut *self.lock.data.get()) }
+    }
 }
 
 impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {

-- 
2.50.1


