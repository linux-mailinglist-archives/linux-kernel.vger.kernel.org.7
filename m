Return-Path: <linux-kernel+bounces-790709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8ACB3AC09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEF67ABCA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203C29DB73;
	Thu, 28 Aug 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bryn2ljn"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B9223DDD;
	Thu, 28 Aug 2025 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414394; cv=pass; b=isjCeQwo030cGwCuOWyn6nItzF4m24Omz/MotAAQcVvBYfNVAAdQzUIqzp7UQbY+Pe3lkHFbC8aQT9Qfz9ucxALbcDY0dEnfPkNIi4cbRsUxTIef1XYTfYR7+G82ptoYJHR8U06fCD86l1+nf3ESWyzbeA3gjtPHc0J4dAqD074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414394; c=relaxed/simple;
	bh=ml6FKS6NYtN5XzgKBC9OB62SYvKtyoW/Npz59dU9wDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pO9JT0eERMxbz5Ib2K3fb7HEjw6dog4JsOgzTuOSKCgbJMNtFC/nuAQBcKpeyEYkDy0E2N6qx/pUvq11GYfh0qqIBrn6swbngYdrhi79ebDltAmTCdZ68s2FUTqly18iJ1z+rRR6ndx9FVQNf3YcgSi/5D71XG77KaiAT1W3Yi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bryn2ljn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756414372; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JVp7avEZMEFFW8zvRIO/Jnp/uSAuYGbL3GZ0m0v9CtknFqh3Ffz5pwEuD8zuKEcR5vvlN5wjPV8HwZlNBzNPEJVwa+Y7SnGKK4bWpeMxDUKpjgtfD27+N1BnmZQ+k49DcFkts3eQ56CzY/djl7Z3c9RWbfuzwfFq5IUHDbKLAiM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756414372; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=avOuCwsXzd/3kp2rlCFI8ziT5ewR4e3wib7MI1JPpJA=; 
	b=GCFHAnAgzx22FudQ/rW5FSmnY9O8kuq8KWU+Vwktz1OF9I9iGX+3yBCa0ys/9okP598EkJ71xIEir/2HM6M4LSPHVhhBaxQTkXq61jjbTrP44l46dVthZzoFsHF4sOnwV6yXCWDPkOex5E1QjBpIEYje7S86E2YGbD+DpFWecNE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756414372;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=avOuCwsXzd/3kp2rlCFI8ziT5ewR4e3wib7MI1JPpJA=;
	b=bryn2ljncdcU0SQW1DQQlhdRsAOKvM8PspT6ykvbfPR9rfzSiYBt81RGlEPxvWQA
	T297lfstWd1LvXhGVELicQJX21xCKDyslSvdsd1xzLdLB2WnettlxU9aeLHPeRTM2AC
	R1YgDZSfq9tjqaf60KilJHYmnoFYvyEnXNH8cgkQ=
Received: by mx.zohomail.com with SMTPS id 1756414369613309.01930956826266;
	Thu, 28 Aug 2025 13:52:49 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 28 Aug 2025 17:52:17 -0300
Subject: [PATCH v2 1/3] rust: lock: guard: add T: Unpin bound to DerefMut
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-lock-t-when-t-is-pinned-v2-1-b067c4b93fd6@collabora.com>
References: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
In-Reply-To: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
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
X-ZohoMailClient: External

A core property of pinned types is not handing a mutable reference to the
inner data in safe code, as this trivially allows that data to be moved.

Enforce this condition by adding a bound on lock::Guard's DerefMut
implementation, so that it's only implemented for pinning-agnostic types.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/lock.rs        | 5 ++++-
 rust/kernel/sync/lock/global.rs | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c88dda13c58bbea9e8d4ce8d314de..b482f34bf0ce817e70f7a0da93443f77dd19ea79 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -251,7 +251,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
+impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B>
+where
+    T: Unpin,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
         unsafe { &mut *self.lock.data.get() }
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b5caf2668586088417323496629492932f..38b44803279986275616eef499fd40b8d4e97fdf 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -106,7 +106,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<B: GlobalLockBackend> core::ops::DerefMut for GlobalGuard<B> {
+impl<B: GlobalLockBackend> core::ops::DerefMut for GlobalGuard<B>
+where
+    B::Item: Unpin,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.inner
     }

-- 
2.50.1


