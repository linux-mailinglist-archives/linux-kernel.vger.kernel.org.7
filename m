Return-Path: <linux-kernel+bounces-790711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6DB3AC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FD66827E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514092C236D;
	Thu, 28 Aug 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="isl68s1V"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32A2BF000;
	Thu, 28 Aug 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414398; cv=pass; b=q+UtJkfPTWlDvXJ3JTGNamJxkwa9ZpZ/LxlXdLEAnfBMfkkIMcN52tqGzhWkvQ5M2KF93RTPg79xDkH0b848iCgbYu9VRoXvwbRmBAhJdRlgWImJU/6CU1m3jt3VghPp9dliprBgfLAL9+0AaDLk5GN9PIIE7LlOaLUqRrG8pPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414398; c=relaxed/simple;
	bh=GTVuonu0/uE2rIWB+P+bMJZTKdHKPh2gT6A2Rhl0a/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlm2WAkswU2PuzRLnNvruqNkiZ60HrgD7Xq2B5WQUxSCddiXZeoVibBGXQQCeIp39CYmilDpFUJ8hz6vWQACj0QUY3YZWJS4KwzqgFNLAedWqFQjWXQFww9RIU9TpT9VkPjP8iy48pjuJ3UBJ22Zx2gnovHRtN5pr8vrvSJl4BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=isl68s1V; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756414380; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R40GSdGmB3SzvxgafPwPNlHufS5jrO0hltIGELYl0aIA85yALWxm78OOO3IisRbHWtmIwUe6iV+OIsh3ts8WksBRzD0avd5aOo//VZCl8wD6gaHTHSTEhz9mttiX1V9Mxq2bSMPHqrSCgiowMhad6bxoSGP34fAshGXH6FYoovQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756414380; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z4SAoqxRMjjOfknNP5rCeR0jEaPb2gogwRcBkklwXRs=; 
	b=jNiX7y78xR815pcI1c2c1R+hy4OiTyOm81hJ7FEYHmalSeomVX/067C8BrDRz4xz621tZGW9xsAq1IYkLqRxG/rAm/LAoNHx32MWFuFwk6SeHGY5I5Uf5XkytGtCisO1T8b1AyTLqP3S8mionmjSrea+xxHE4I9qknlOArGpF2M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756414380;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Z4SAoqxRMjjOfknNP5rCeR0jEaPb2gogwRcBkklwXRs=;
	b=isl68s1VfEPGznUqx9LvUWD6Pd7C4R4lBSV0m5j40c1ozTCOXebcUfI7qgswHWfk
	BDDwcXPOpTADUXW+gd07WxdcvlZfcmgT0QClE4Sd9VlFLq933CCu3EyMAc+MlLAjsqZ
	OJUciCmm8AsAsZs2zc+z+kzoRSBD1wzUh+di3o1Y=
Received: by mx.zohomail.com with SMTPS id 1756414378215841.1326014020718;
	Thu, 28 Aug 2025 13:52:58 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 28 Aug 2025 17:52:19 -0300
Subject: [PATCH v2 3/3] rust: lock: add a Pin<&mut T> accessor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com>
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

In order for callers to be able to access the inner T safely if T: !Unpin,
there needs to be a way to get a Pin<&mut T>. Add this accessor and a
corresponding example to tell users how it works.

This is not useful on its own for now, because we do not support pin
projections yet. This means that the following is not going to compile:

    let mut data: MutexGuard<'_, Data> = mutex.lock();
    let mut data: Pin<&mut Data> = data.as_mut();
    let foo = &mut data.foo;

A future patch can enable the behavior above by implementing support for
pin projections. Said patch is in the works already and will possibly
land on 6.18.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/lock.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 9242790d15dbf65d66518d060a8a777aac558cfc..7191804a244da05db74294fdec598f1a4732682c 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -245,6 +245,31 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
 
         cb()
     }
+
+    /// Returns a pinned mutable reference to the protected data.
+    ///
+    /// The guard implements [`DerefMut`] when `T: Unpin`, so for [`Unpin`]
+    /// types [`DerefMut`] should be used instead of this function.
+    ///
+    /// [`DerefMut`]: core::ops::DerefMut
+    /// [`Unpin`]: core::marker::Unpin
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::sync::{Mutex, MutexGuard};
+    /// # use core::pin::Pin;
+    /// struct Data;
+    ///
+    /// fn example(mutex: &Mutex<Data>) {
+    ///   let mut data: MutexGuard<'_, Data> = mutex.lock();
+    ///   let mut data: Pin<&mut Data> = data.as_mut();
+    ///  }
+    /// ```
+    pub fn as_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: `self.lock.data` is structurally pinned.
+        unsafe { Pin::new_unchecked(&mut *self.lock.data.get()) }
+    }
 }
 
 impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {

-- 
2.50.1


