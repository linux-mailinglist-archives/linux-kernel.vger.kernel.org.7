Return-Path: <linux-kernel+bounces-751099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCDB1653C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962E91AA12C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C32E093F;
	Wed, 30 Jul 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZlQGVQFp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524A2DFF18;
	Wed, 30 Jul 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895714; cv=none; b=qCzRS7x3QFQVwShJ3Kh9bhgWcVdvvXACrBYnAejYfhl/B0mGJjYy1VRtK7/uefw8c4BeAlJ4GNLga8u09a2Lh/M6QzejfrZw4K10XVUEKTluN23gSJPMEjR0Mix+FXJE8iZXFZu8Oo7SoAZG5vus6vruLfHLC2RwMTChMZ8cv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895714; c=relaxed/simple;
	bh=AXjI2AESniRBTjvjKjfF5GSYUGIK6NML1d8W4I6I+8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqqd5naZJuqlpjY/cyyGHCXECTSXg3Hjia27T0oOxdBPG7TcxTXHDiaHHTTbeYRdtYq3sPtgie3UoNpECFWaz/VQCCWHcYfMfyFVqwSeIPP0/b4svoYWenNUl5MvHi644AXt+PY0Fk4rSHuapl1LfGxiQCHZb5ArteBotKNtgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZlQGVQFp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753895710;
	bh=AXjI2AESniRBTjvjKjfF5GSYUGIK6NML1d8W4I6I+8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZlQGVQFp0lzmDaYSLyVTwGVCmoQn2TIh2anogkMxsO3FG0J6nKhFOU0xR0XuPlRTd
	 UjxrjQHySUW60JUrq3tyUPc6Y1jpGNN6fT9NDa4Kis9a+nxOVmO014OD1/5TITUel9
	 E6VrrRQ8ogrl/MuRO5lSi6DFvWMvYkhfcw+mF+gJ3gd8HYvXhStgPB4JGyd9xgyHxJ
	 8Ik6vaOR8iCcsBBPh1bPN9c3lIXhcoZJ36iS9pAlTsv5iqxZRYoOvhknkrhtmGNrFr
	 J6LRlgms0dH5bmgmuer21UPp+fu+68VOLC0KPHjEUZZGCYbXArw+Zh3B+6hO2fbz6C
	 L6ZQPi8nngLLQ==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DCA8B17E1572;
	Wed, 30 Jul 2025 19:15:07 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 30 Jul 2025 14:14:45 -0300
Subject: [PATCH 2/3] rust: lock: guard: add T: Unpin bound to DerefMut
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-lock-t-when-t-is-pinned-v1-2-1b97d5f28aa2@collabora.com>
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

A core property of pinned types is not handing a mutable reference to the
inner data in safe code, as this trivially allows that data to be moved.

Enforce this condition by adding a bound on lock::Guard's DerefMut
implementation, so that it's only implemented for pinning-agnostic types.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/lock.rs        | 5 ++++-
 rust/kernel/sync/lock/global.rs | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 9715463cbab867a2cf59e75f03001d75e91bd7b6..087bc0391f92a73b9af18ca31461b513bb5a9bcd 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -254,7 +254,10 @@ fn deref(&self) -> &Self::Target {
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


