Return-Path: <linux-kernel+bounces-802015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74AB44CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F751C274BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9F279357;
	Fri,  5 Sep 2025 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihhHLwTx"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58B274FEF;
	Fri,  5 Sep 2025 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047325; cv=none; b=AlTZtWFVEVV/wpCjUpWUE27mysQnPEKsnUQj9ebUuyAXeC+4qvS5Osw9vh7DZUXRm6KL8vkDxLcRvPkikJKbWKm0KX4PsD/1UTnKIavTcsFU0QgLOnTCSRgg2839CAJ7e49Pw04bRAVyUQ4UNJwPbZ6mPu093OF1kTRrcJwGLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047325; c=relaxed/simple;
	bh=zQamHJdlclfzJCS5fnsSE/oxkQRLFtzVSNOcmgKUm2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZTHHbgDCFfZHdfZlX667s4oUWen2BVuNh5NfJRYocqNbHykfKb7dHFsuRuoImJH9n1fASfkh+92SsUIImWGeoWJYfznqEWX9upLyBGIiOu9IY9euL5ZFEwgZPzTELERuILC5BKszU6TrJykPIeb45Lx3DRg8Sf1Sl2ZKyATyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihhHLwTx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-729c10746edso9995356d6.3;
        Thu, 04 Sep 2025 21:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047322; x=1757652122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9pUt6QL6shWxQnZqi47vRRgHRJwQTTOipX1hhULcvIA=;
        b=ihhHLwTxqp5aw1BbBY1/EnlHssgGAFSVeYLWZt+i7POaYQkHFy75M2Df7lnzDy3MzO
         2Qb4MQiZ6G3cFd7a5BpGr0fL2XPeLJ7xBbYcYStbW9vU8Vo0sEZy9UOjEDFXOS8EI9dG
         dPv7jOiWaaxAG0YoL+Dni/fP0ncbSRpF7oTumi8lO8+3D0PpNpzJx430vcoSstYnfT0x
         vr071F0qkXyc+cjJ2/OvqQ46XofO2AO4TJQpqXBD5apNYqw9F5V1/CCsgfo3Y5sblYsG
         cqeqrI2TSpRVVlQ8kPoZDT8FXeU37hl/x72TPYfHhmeH0Dq0v4PXkrDjsthNpxeHmM8b
         rqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047322; x=1757652122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pUt6QL6shWxQnZqi47vRRgHRJwQTTOipX1hhULcvIA=;
        b=V01FzYuSrRO4yRwaPcXb/fGvh8KLeMeeJ9ayt8tLt8LhXGEEQE0jWgPxMGHOIvays8
         hCQDA8+str3BGMqt/ceEPhJDGe70FAQU4UIgcHNv7HBWE+GrjL2qE1pnOl14GT28pf11
         cpuVh/QBy2o1/B6QhJFhacfTmnCc9fzGGPAVfj63X76d6kf6EEIfNa2UV28Z0UfFCT5m
         I+NOBTAF6z9A1AYO1gjMQ0bB14zhkoWTtIKh1zpLIXLawOELG2sR25yR0JUgYmbt2tzS
         AQ17xjTXZaScqw4UUykocAD/pF4HAOtsFiXDUDL4amMGh+TdnYIrZyJ6CAdqF5ThDy4R
         6RiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqRk49DH0T8aMU8JqhqG8R/eFCrCVSd9SimBuWPeZTUIsJt8mdGQh7rmYqtpt0QnB+Qo/uAgd+5E6lJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4yRoLiUqQru1JJrX5XTbhaY1NhKuEChs3TlviJaNskpvmlRl
	lK1ElcXH/eh6i/WZNoiRe87PQPQ/1Jnjaa+jSM+yRK4ZQ0undgJuPctF
X-Gm-Gg: ASbGncuDpMdVCFimcp8kyCeiH97f+hLQO7csbbYUtQefkKKP81JrK5Cuf+RjiwGhsCS
	FKwbTofcCO7BmyP3Agmp+DwFZxKe/gD/ma4zSL6yaBdWpTuikipicreYLfTKTeTVqxBJfPmym5o
	mGrfgWDtOzRtKSbJBiIFpxo5b3xfixF4xrLhXbzvmU+arg9McCC89cY23YXpHAi1mEA6NV8Yrli
	VivFrUBbUdOWveRANTdOmdCG7LKD2UAOcMcOmC0RCHQ3q7guuNJl2sVaJP2fvwMwxuoxVeLDTRT
	Fnw19/lreVyhlc1r6FW1qZs/GHbZpry7PehJOg87fzl85cacgBa9slGf9SKOEy0nJNCVFTS/TMl
	6CQyudpb/rANVnG3t33OhD3OxdDvXrjLgeEpJq3w5MQL5s032AAtJG23FNqjOi/9JV2uQkVQTbU
	RHqKDmDMTi1Fruybx/FtYs5Ig=
X-Google-Smtp-Source: AGHT+IFu86ZzUsajkRJABiWj6gCvEZ057iRVFhb5HsRQuF1AgZ0geiuF4S0KN1FyRQoem/UgY097gg==
X-Received: by 2002:a05:6214:21cd:b0:727:b235:cfa with SMTP id 6a1803df08f44-727b2350e1amr73574316d6.47.1757047321898;
        Thu, 04 Sep 2025 21:42:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-728d6f8b338sm25185046d6.0.2025.09.04.21.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:01 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 17370F40066;
	Fri,  5 Sep 2025 00:42:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 05 Sep 2025 00:42:01 -0400
X-ME-Sender: <xms:GGq6aE39XDcWJPyMMuct83NZoxEvIgvW3HTFyIO54LSGL1ktAHxYIg>
    <xme:GGq6aMzuOnDX8VIwORyViZgcmFxVg1hiGZjp-kDdnJZDSpijueNC66LLP9DvPRLTo
    H0UX29IKiItBH1_zQ>
X-ME-Received: <xmr:GGq6aOreJRttD0pij9aQKRH2fUrF_Brt9pyh-mRgwjzbevndJWmJwceT7Bw8TLpciJqt7gCKuKD1X7rhM2n96308Jr_L9f3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeugfehieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehmihhnghhosehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GGq6aKXeiXxEJJEH6Ga3AjTxm6rVVi4smcmGt8BSkawJ1w8D95XJuQ>
    <xmx:GWq6aNqgM_uaulBC-dnfqAexD8HsLMIr1_xCYU8U7dwoqKrfLeNZhA>
    <xmx:GWq6aGF6QbbBu4MfPObhWoj_IWsX_0HDt6dHnJpdbwdpk3gIgep5XQ>
    <xmx:GWq6aHv1TieBtvTFiQakWcXjsUNZwY2alij77JsHDWQYhUDx93-Z_Q>
    <xmx:GWq6aBQVSSOUXpHAKQvatQZzvRbfy4TTcmNtLOEw-VIxRLuOjz-uz-ZD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:00 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: "Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stern@rowland.harvard.edu,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 06/14] rust: sync: atomic: Add the framework of arithmetic operations
Date: Thu,  4 Sep 2025 21:41:33 -0700
Message-ID: <20250905044141.77868-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One important set of atomic operations is the arithmetic operations,
i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
make senses for all the types that `AtomicType` to have arithmetic
operations, for example a `Foo(u32)` may not have a reasonable add() or
sub(), plus subword types (`u8` and `u16`) currently don't have
atomic arithmetic operations even on C side and might not have them in
the future in Rust (because they are usually suboptimal on a few
architecures). Therefore the plan is to add a few subtraits of
`AtomicType` describing which types have and can do atomic arithemtic
operations.

One trait `AtomicAdd` is added, and only add() and fetch_add() are
added. The rest will be added in the future.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-7-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic.rs           | 94 +++++++++++++++++++++++++++-
 rust/kernel/sync/atomic/predefine.rs | 14 +++++
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 4c32d12dc61e..016a6bcaf080 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -16,7 +16,6 @@
 //!
 //! [`LKMM`]: srctree/tools/memory-model/
 
-#[allow(dead_code, unreachable_pub)]
 mod internal;
 pub mod ordering;
 mod predefine;
@@ -25,7 +24,7 @@
 pub use ordering::{Acquire, Full, Relaxed, Release};
 
 use crate::build_error;
-use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
+use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
 use ordering::OrderingType;
 
 /// A memory location which can be safely modified from multiple execution contexts.
@@ -112,6 +111,19 @@ pub unsafe trait AtomicType: Sized + Send + Copy {
     type Repr: AtomicImpl;
 }
 
+/// Types that support atomic add operations.
+///
+/// # Safety
+///
+// TODO: Properly defines `wrapping_add` in the following comment.
+/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
+/// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
+/// yield a value with a bit pattern also valid for `Self`.
+pub unsafe trait AtomicAdd<Rhs = Self>: AtomicType {
+    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
+    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
+}
+
 #[inline(always)]
 const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
     // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
@@ -459,3 +471,81 @@ fn try_cmpxchg<Ordering: ordering::Ordering>(&self, old: &mut T, new: T, _: Orde
         ret
     }
 }
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicArithmeticOps,
+{
+    /// Atomic add.
+    ///
+    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.add(12, Relaxed);
+    ///
+    /// assert_eq!(54, x.load(Relaxed));
+    /// ```
+    #[inline(always)]
+    pub fn add<Rhs>(&self, v: Rhs, _: ordering::Relaxed)
+    where
+        T: AtomicAdd<Rhs>,
+    {
+        let v = T::rhs_into_delta(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_add()` due to safety requirement of
+        // `AtomicAdd`.
+        T::Repr::atomic_add(&self.0, v);
+    }
+
+    /// Atomic fetch and add.
+    ///
+    /// Atomically updates `*self` to `(*self).wrapping_add(v)`, and returns the value of `*self`
+    /// before the update.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Acquire, Full, Relaxed};
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Acquire); x.load(Relaxed) });
+    ///
+    /// let x = Atomic::new(42);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// assert_eq!(54, { x.fetch_add(12, Full); x.load(Relaxed) } );
+    /// ```
+    #[inline(always)]
+    pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering) -> T
+    where
+        T: AtomicAdd<Rhs>,
+    {
+        let v = T::rhs_into_delta(v);
+
+        // INVARIANT: `self.0` is a valid `T` after `atomic_fetch_add*()` due to safety requirement
+        // of `AtomicAdd`.
+        let ret = {
+            match Ordering::TYPE {
+                OrderingType::Full => T::Repr::atomic_fetch_add(&self.0, v),
+                OrderingType::Acquire => T::Repr::atomic_fetch_add_acquire(&self.0, v),
+                OrderingType::Release => T::Repr::atomic_fetch_add_release(&self.0, v),
+                OrderingType::Relaxed => T::Repr::atomic_fetch_add_relaxed(&self.0, v),
+            }
+        };
+
+        // SAFETY: `ret` comes from reading `self.0`, which is a valid `T` per type invariants.
+        unsafe { from_repr(ret) }
+    }
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 33356deee952..a6e5883be7cb 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -8,8 +8,22 @@ unsafe impl super::AtomicType for i32 {
     type Repr = i32;
 }
 
+// SAFETY: The wrapping add result of two `i32`s is a valid `i32`.
+unsafe impl super::AtomicAdd<i32> for i32 {
+    fn rhs_into_delta(rhs: i32) -> i32 {
+        rhs
+    }
+}
+
 // SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i64 {
     type Repr = i64;
 }
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `i64`.
+unsafe impl super::AtomicAdd<i64> for i64 {
+    fn rhs_into_delta(rhs: i64) -> i64 {
+        rhs
+    }
+}
-- 
2.51.0


