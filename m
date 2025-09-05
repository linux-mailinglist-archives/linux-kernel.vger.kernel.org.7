Return-Path: <linux-kernel+bounces-802019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65453B44CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E091C27632
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3542287501;
	Fri,  5 Sep 2025 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNb+5Hcl"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C928136C;
	Fri,  5 Sep 2025 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047332; cv=none; b=AUocjjudUN3BgTCd+wGVpM+7ucGEwA4Q5/KUni5552GUpwusQH9Ko/ZjOM8yAXPf7K5HUxapcHkuy785JWVkxyxykPOoRnUtdaQyMQALb7l2G4g/Qlv2aVRK2SrP1Xt16v6WfwniCMjpwbSE6dyyhG/ealQfZLspZY14D1dpx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047332; c=relaxed/simple;
	bh=lwCmmZzK2HnRc/ZHHeIEM0sjRrMvxyYb9pwdb4+oJL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJoqmfBNWjMK/lDLjh9B/3N1Qr8fbNcpPK+K30Dn4biw3jk990hIGNEGIyW9Eqi6SJP4wb/1Fbx2f/2mrwrQIFaYEDuYBLhTrtP1/yhtYyXw3kjugLlbVheAL4U6YOXXCZWOkY7Wlhr+HdDBVFKVYSE9GS2Y1iFRUOZYl0KzZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNb+5Hcl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70ddd2e61d9so20897416d6.1;
        Thu, 04 Sep 2025 21:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047329; x=1757652129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56aEvuw8HZ6ZMouX9lRTh2tr/a537bJJuIrcWGezh3s=;
        b=fNb+5HclOPgTRFk2rjmNgLIUUJKXYXM0OgY1XbwdJjXGNQ6D2RUCXvEdkQPqcgUvLC
         PX7tf+IerIgZVA++l9TxICxwz2TuoPyvuIrcSBgmLfDJysBXhTe6u0u1T86fXvyGYMnF
         cm9B+GkWVy5wczFDG3aEMn1XkLqE0AY5RzDtrMqMCQYPa8UFR9D+lbBA88qsRXE6n/mp
         QHnBTQGxJPUNICmGCY6EgvmKP6CJotsj4/JCS24zmRZADevjdDBfP3KL1vQwu1vDJssf
         Ug7ldevpo6fpR5ufnBJm8nMtLWTyPewJhKAoHTN5P28TjQ7kQ54L8CaGmue3UratF605
         ZcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047329; x=1757652129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56aEvuw8HZ6ZMouX9lRTh2tr/a537bJJuIrcWGezh3s=;
        b=No3/4UlKWuPfOyq5b5C/tHZRgl6CETpQBFoV8ce9dhScgTWpozXlXiLqxsYuyL9X0U
         L6wWKdnI6cU98GJs46O56a6fX8q/IKu+Tmm3Vl7thxgXn9Nid64I6V00ax0SzHp88XA1
         0wfNp6GJQ4gsjAtb6PpyOelFmpxmDYnShz9/znuiSZ2vCbvqeJOK8osajlDgNaslzeBV
         Kfbsof/FWFoC21xD2lDBWjs/AluhnotD/Ute9nYuQsNv/3GwPi56fcEeYi927ijID7w5
         /eGznyIToqs9oXeNdiXPH0s6uUgbd6fuD2eiMIJwqRW8IXFi2B/hvaiUcxsb1VNpyTAQ
         TUyw==
X-Forwarded-Encrypted: i=1; AJvYcCUIMXJZyk4QN2hx2TQDMVXeywKdYs8Ipd1ijRjPR7rJHIPIMYylfYKuS21dk+9ytJaISAMNi5fzq5E6yk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OyKYjTU8qmrXcbWpFsbALG3JWy3rmSX7Z8QpSZo9qtm0EV5o
	Wtd53+fhbN0ofOKrQeenBJOzeVMJlpUYk3uTm9uy945rQfXxiMSjnRyH
X-Gm-Gg: ASbGnctuAPCkhKpbLtdDL4L593JtSFlY7cO91WIhrOd5xBN5piCn1tvNnzJID2gvxpz
	S6lOU3RyrO3A6Mmgwle0gr82ECBxxUYu3FCBrTkVDUDG3Q63GHVHPO7ulQCUKGZQ9y7I8M6Bdmo
	hxH7fSq2NnW2Nz2bWN6FdE4dUk5ScuWldFPDcfWivTuGhE9Tdo5h/opJAROLvgwUrztnDZ+ZME/
	sK2hNt5ex6End7PZd9nvbhRq20IRpXpnTvMiOObNGrigjg3VADnfBhttPCPxSoH/9jXHtKr8nid
	XkYCqcF27fVSXIfPETeq21RIbZ7z3Dm1RXZVqu6pQCndJNYl7Gk4h5F4vmzUfzpn3C3WsiPgKmi
	9eAQ3pVa0FdqChdXrk+EG9weAmU5oun/3CHliAcqBTeVeEf0iRP1fKb9FooGAnWkNxYLDeHfFp1
	yBabQn2D2asYrbrkDSWP0Mc2U=
X-Google-Smtp-Source: AGHT+IHVSpMSo66zVScyuFD1Z3iW93HSQXyMmz1zQcisit57Dtl8aCUPtP/QpA/hf6MOKs+Kat+dNw==
X-Received: by 2002:ad4:5ce2:0:b0:71a:5b14:3cbe with SMTP id 6a1803df08f44-71a5b143fe4mr202087746d6.27.1757047329019;
        Thu, 04 Sep 2025 21:42:09 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72925b87571sm23102486d6.6.2025.09.04.21.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:08 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 06427F40066;
	Fri,  5 Sep 2025 00:42:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Sep 2025 00:42:08 -0400
X-ME-Sender: <xms:H2q6aO4RnVOgt7aLZf_mx7VB7njQmym3pv9brZeKHBdlqNzgUyDRuA>
    <xme:H2q6aAuEHiIIoZm1nTVDc6QX2TXjMHJKQ2Ptm-dK6H7_vqQDaK-nln04duiwLdXXL
    SGDrwCJkX6xzJpjsA>
X-ME-Received: <xmr:H2q6aOzLldP_d2T09ehX5Hid2W9wJ3xz6ZGNTkdrgfyA0_RWJZuFhFaxeadEUAAo1J7oSRrTt31VU50wzHpKMQ9ymUHU8cTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehieffheeffeegjefftdeggfelvefgffffudegtdffueetjeduleetfedvleekgeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeifihhllhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurd
    horhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghp
    thhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlih
    hnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:H2q6aAbgvOyb2St_q-jY5oglfkEyPwojfQrQETNymA_UnHjNkU8rJw>
    <xmx:H2q6aF5u9OGmWTKC_JIX1ThTOtkmbXIJ_CmEypbQ_2yACUznUyCNUw>
    <xmx:H2q6aH4PCVmvlfiQdn7cWhddGjubNVYV4xM7nIwTNj3Nr5l9IlDyhQ>
    <xmx:H2q6aNWTW7Ss6WzzUuQ83X8_pGzCzY8U0mPTpQvNesgxZbJqH7ybHg>
    <xmx:IGq6aD6T6eSl7rH9oUgJLd6MDEkvEBlmQMC-bhXgd-BqHKCg2JIVUjLs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:07 -0400 (EDT)
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
	Boqun Feng <boqun.feng@gmail.com>,
	Fiona Behrens <me@kloenk.dev>
Subject: [PATCH 10/14] rust: implement `kernel::sync::Refcount`
Date: Thu,  4 Sep 2025 21:41:37 -0700
Message-ID: <20250905044141.77868-11-boqun.feng@gmail.com>
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

From: Gary Guo <gary@garyguo.net>

This is a wrapping layer of `include/linux/refcount.h`. Currently the
kernel refcount has already been used in `Arc`, however it calls into
FFI directly.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Benno Lossin <lossin@kernel.org>
[boqun: Add the missing <> for the link in comment]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-2-gary@kernel.org
---
 rust/helpers/refcount.c      | 10 ++++
 rust/kernel/sync.rs          |  2 +
 rust/kernel/sync/refcount.rs | 98 ++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 rust/kernel/sync/refcount.rs

diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d6adbd2e45a1..d175898ad7b8 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -7,11 +7,21 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 	return (refcount_t)REFCOUNT_INIT(n);
 }
 
+void rust_helper_refcount_set(refcount_t *r, int n)
+{
+	refcount_set(r, n);
+}
+
 void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
 
+void rust_helper_refcount_dec(refcount_t *r)
+{
+	refcount_dec(r);
+}
+
 bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index bf8943c88a89..cf5b638a097d 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -19,6 +19,7 @@
 mod locked_by;
 pub mod poll;
 pub mod rcu;
+mod refcount;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use completion::Completion;
@@ -27,6 +28,7 @@
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
+pub use refcount::Refcount;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
new file mode 100644
index 000000000000..cc1a80ae7ae9
--- /dev/null
+++ b/rust/kernel/sync/refcount.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic reference counting.
+//!
+//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
+
+use crate::build_assert;
+use crate::types::Opaque;
+
+/// Atomic reference counter.
+///
+/// This type is conceptually an atomic integer, but provides saturation semantics compared to
+/// normal atomic integers. Values in the negative range when viewed as a signed integer are
+/// saturation (bad) values. For details about the saturation semantics, please refer to top of
+/// [`include/linux/refcount.h`](srctree/include/linux/refcount.h).
+///
+/// Wraps the kernel's C `refcount_t`.
+#[repr(transparent)]
+pub struct Refcount(Opaque<bindings::refcount_t>);
+
+impl Refcount {
+    /// Construct a new [`Refcount`] from an initial value.
+    ///
+    /// The initial value should be non-saturated.
+    #[inline]
+    pub fn new(value: i32) -> Self {
+        build_assert!(value >= 0, "initial value saturated");
+        // SAFETY: There are no safety requirements for this FFI call.
+        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
+    }
+
+    #[inline]
+    fn as_ptr(&self) -> *mut bindings::refcount_t {
+        self.0.get()
+    }
+
+    /// Set a refcount's value.
+    #[inline]
+    pub fn set(&self, value: i32) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_set(self.as_ptr(), value) }
+    }
+
+    /// Increment a refcount.
+    ///
+    /// It will saturate if overflows and `WARN`. It will also `WARN` if the refcount is 0, as this
+    /// represents a possible use-after-free condition.
+    ///
+    /// Provides no memory ordering, it is assumed that caller already has a reference on the
+    /// object.
+    #[inline]
+    pub fn inc(&self) {
+        // SAFETY: self is valid.
+        unsafe { bindings::refcount_inc(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before.
+    #[inline]
+    pub fn dec(&self) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount and test if it is 0.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before, and provides an acquire ordering on success such that memory deallocation
+    /// must come after.
+    ///
+    /// Returns true if the resulting refcount is 0, false otherwise.
+    ///
+    /// # Notes
+    ///
+    /// A common pattern of using `Refcount` is to free memory when the reference count reaches
+    /// zero. This means that the reference to `Refcount` could become invalid after calling this
+    /// function. This is fine as long as the reference to `Refcount` is no longer used when this
+    /// function returns `false`. It is not necessary to use raw pointers in this scenario, see
+    /// <https://github.com/rust-lang/rust/issues/55005>.
+    #[inline]
+    #[must_use = "use `dec` instead if you do not need to test if it is 0"]
+    pub fn dec_and_test(&self) -> bool {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
+    }
+}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Send for Refcount {}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Sync for Refcount {}
-- 
2.51.0


