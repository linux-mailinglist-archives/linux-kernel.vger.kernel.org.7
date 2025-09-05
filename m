Return-Path: <linux-kernel+bounces-802022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903DBB44CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BEEA46CAE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A03223DF6;
	Fri,  5 Sep 2025 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN9hJfNo"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038F28AB0B;
	Fri,  5 Sep 2025 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047338; cv=none; b=dlMq2D90ej/4XZubboYd3DriacGbSJbLsAMJIhKGgjh+2CfF/UbeosPwngPJ+7nHwAOob4fo1TCeVubi3py0X66OYKKbj8QkrEt2Q2FoW+nB/1rOWH8wGNE/Xr/UGh9NZm6Br6o/Nvc+l79couEhaO6zCz8X/Hdan8TkVT2Kqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047338; c=relaxed/simple;
	bh=j2YdN2DLnG73EP20qSXS3K/LaCj4A/LCua+ypuuynYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pajVErpg9Mc3l+0+rifg7z2wu8xL0ymAQGV4KUGc3zyxRQSetSvgim0Bf14ZuDvThWmqkuzV/jENqtXbVD1pwDPsESGSyHhkdRhg/qBNBuTHZJE2+6hCl+pA48nAxN58jsIWMSWPtlqFZX2MIL3D51RzYCWnVkXyDX8XQv5pwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN9hJfNo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8116af074e2so23837285a.0;
        Thu, 04 Sep 2025 21:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047334; x=1757652134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5GJOYi91DjBqstMJYjR/ItpKLOjz9cAZ2xl/jTvxcto=;
        b=EN9hJfNoXwitAOrWyUaW1RTj5/2htRxRHgR8jpFAncUQ23cGeE9n5cpSgsCf/0lgif
         zTG71rIqcQQUDJ0mnnIVacK/2pqBZlvgWgPKjd4kweb3rYYxFted5W3mzMfwf0Ki/zIp
         +wNNziTsDwm+51ZPK311eO/EWT6iLwwaHSQC2v58bXX730Sqjqmla9TbyxhRRvS21n+v
         jjz65nMpMsIrRz5O0Xv1xtvO4+jPBNydJc3sLytt78wDRp35vOeDteSPQasTl6zxwwuS
         w2kytLZBzQnGJl0pvZ/Nmm1u/SGGaB8JHewk0qcELkuaK/5vti6TCj/kekG/2Ge8tu85
         yjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047334; x=1757652134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GJOYi91DjBqstMJYjR/ItpKLOjz9cAZ2xl/jTvxcto=;
        b=JTdrOuwY4E9664cTP+AOKCCxTwkvfj0G9vqEMbtF9PNIOM0+zpG0QnKNaoFmI0T2el
         rTSpZEJ0E5+aZi4hZUwk0CCob1WEc7/nuikJOHwUcYw3GdnsZvLOAW7BM4LFYsjCu3me
         w2nZnXxqlLCp8ooUeZXLChd3rhJEpLOfBlcbojRIaR8SmC2gkIxArtsBW2Q1H+igNIga
         qT1bVE+YZL3OWXUkUENsg0DfIbfRkes89MAPKy36sRYkwsUctURMULI8sf2/VRX1u7/R
         JR0Zaa/0nJDrEmmdW864QDpAqFB1bda9202/A20lgiclY+TLMdPTuM9tJcjNiBL/44pi
         aeZA==
X-Forwarded-Encrypted: i=1; AJvYcCWeYA4Qx/mu/N2kBIDYPF1mDLbcOQ9X1G1eQ7j8HmhhPulTSRJd8PQLe58MyRlwIOyRpBX5MhKHUmbwBW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGypYQLzAYbXMcM2LKVESdYLs3KusNwuZ06xQv2w8SMOJ8ngV
	ph1Ne5v0Bsb00PCt9cO1OQyt9Yj/1NCLuLfYmv2vcKMFDUHWx/4UfAgF
X-Gm-Gg: ASbGncvC0MaiZbUU1mmMB8d7JEr18GABEYCAPraz5P5CSUIyorKnvUiPauu51s6/4KG
	qujRecmWFVO2UJzA964FQUFIxqJscQD0fe6RzxrD/SKiN0+wgdd/RwcQKTvUb+q6E0lpreruv0n
	TL8yzMcZa8x3eeBbB2biyq/8bEwWz4SCg3xB+izfpxxKRWDrXh778zBX4EiVHbd9y8IDGwxQ7xI
	qdrABticz6b5J66GhQslraSxQ/5XnISorzEj0MlgSjkrDngOVDEybJ29c4DWKcv0jqL4tjfKj0Z
	QfWmbfBvnsu6SBa5cXjnSLAja8rVZsDJTN+/JXSzVsv5l4/uCtNVzf/FbP7C0RQltlH6re0mhlV
	m48NCQH+w8OxQsiQ5zpfYfxeMtN5lKa+KZb8lE0yf4hzHJR+hB+lIAfJ7qMxf1As4slxzn4COqO
	D7RWOO1xknsgx+snfr7+B/E8SFik1I1C2Vkg==
X-Google-Smtp-Source: AGHT+IFjfaD9905yscYWLVswKCOSnwJBtSvmjutZmVVqmICXEjg8GdLTi/1Ibn8LVaDbLjLknLHX3A==
X-Received: by 2002:a05:620a:1a0a:b0:80a:eb17:6385 with SMTP id af79cd13be357-80aeb176498mr888323185a.74.1757047334142;
        Thu, 04 Sep 2025 21:42:14 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aaacff0f0sm408185085a.43.2025.09.04.21.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:13 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4B06BF40067;
	Fri,  5 Sep 2025 00:42:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 05 Sep 2025 00:42:13 -0400
X-ME-Sender: <xms:JWq6aPg1EnLwOaxckofTAzm44MQJmljHYW8hD2YQ21qkLWKePqPwag>
    <xme:JWq6aE3Ylz1PZYBeAZRhotLosr5eOz9jskd8Dcw9JE6g_EdKTK4_zAo-4a_p0d-yT
    IqHhEhWmm7T1hQupQ>
X-ME-Received: <xmr:JWq6aAb4yXDy22TfpZbTlVn2YWBTfvI93Peq3XA7IOI8A6tV2BWC_r1F0iz3MZVtg9S26jaoz5oQ2WJJ_J-zmWpOaZ8eo38v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeugfehieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehmihhnghhosehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JWq6aBgDi-9N11eTll7HFCM61RN7uL8jPyTpYDkY9lEeoVCHqPIbAg>
    <xmx:JWq6aAiJ0zcwRijKLV2OL2PuQqcKrtETwTD9JfGWS9i3VYTmt9HcSw>
    <xmx:JWq6aOAltFsh1YdbkBx5-wLcTaaREm602gvRIDSvSU7WgkJMmvZOTQ>
    <xmx:JWq6aI8nqCtfJKORbsuLfY7f0EgV8VX9leun5_VFivUevhKPwlbTkQ>
    <xmx:JWq6aHCVtfh32TetgdwU8Xat9IHn7viFOO2ODXdiy2eZCLJV-G1NxhlP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:11 -0400 (EDT)
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
	David Gow <davidgow@google.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 13/14] rust: block: convert `block::mq` to use `Refcount`
Date: Thu,  4 Sep 2025 21:41:40 -0700
Message-ID: <20250905044141.77868-14-boqun.feng@gmail.com>
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

Currently there's a custom reference counting in `block::mq`, which uses
`AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
architectures. We cannot just change it to use 32-bit atomics, because
doing so will make it vulnerable to refcount overflow. So switch it to
use the kernel refcount `kernel::sync::Refcount` instead.

There is an operation needed by `block::mq`, atomically decreasing
refcount from 2 to 0, which is not available through refcount.h, so
I exposed `Refcount::as_atomic` which allows accessing the refcount
directly.

Tested-by: David Gow <davidgow@google.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Benno Lossin <lossin@kernel.org>
[boqun: Adopt the LKMM atomic API]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-5-gary@kernel.org
---
 rust/kernel/block/mq/operations.rs |  7 +--
 rust/kernel/block/mq/request.rs    | 73 +++++++++---------------------
 rust/kernel/sync/refcount.rs       | 15 ++++++
 3 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index c2b98f507bcb..c0f95a9419c4 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -10,9 +10,10 @@
     block::mq::Request,
     error::{from_result, Result},
     prelude::*,
+    sync::Refcount,
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+use core::marker::PhantomData;
 
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
         let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
 
         // One refcount for the ARef, one for being in flight
-        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
+        request.wrapper_ref().refcount().set(2);
 
         // SAFETY:
         //  - We own a refcount that we took above. We pass that to `ARef`.
@@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
 
             // SAFETY: The refcount field is allocated but not initialized, so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Refcount::new(0)) };
 
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index fefd394f064a..f62a376dc313 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,13 +8,10 @@
     bindings,
     block::mq::Operations,
     error::Result,
+    sync::{atomic::Relaxed, Refcount},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{
-    marker::PhantomData,
-    ptr::NonNull,
-    sync::atomic::{AtomicU64, Ordering},
-};
+use core::{marker::PhantomData, ptr::NonNull};
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
@@ -37,6 +34,9 @@
 /// We need to track 3 and 4 to ensure that it is safe to end the request and hand
 /// back ownership to the block layer.
 ///
+/// Note that the driver can still obtain new `ARef` even if there is no `ARef`s in existence by
+/// using `tag_to_rq`, hence the need to distinguish B and C.
+///
 /// The states are tracked through the private `refcount` field of
 /// `RequestDataWrapper`. This structure lives in the private data area of the C
 /// [`struct request`].
@@ -98,13 +98,16 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
     ///
     /// [`struct request`]: srctree/include/linux/blk-mq.h
     fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
-        // We can race with `TagSet::tag_to_rq`
-        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
-            2,
-            0,
-            Ordering::Relaxed,
-            Ordering::Relaxed,
-        ) {
+        // To hand back the ownership, we need the current refcount to be 2.
+        // Since we can race with `TagSet::tag_to_rq`, this needs to atomically reduce
+        // refcount to 0. `Refcount` does not provide a way to do this, so use the underlying
+        // atomics directly.
+        if let Err(_old) = this
+            .wrapper_ref()
+            .refcount()
+            .as_atomic()
+            .cmpxchg(2, 0, Relaxed)
+        {
             return Err(this);
         }
 
@@ -173,13 +176,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
     /// - 2+: There are [`ARef`] references to the request.
-    refcount: AtomicU64,
+    refcount: Refcount,
 }
 
 impl RequestDataWrapper {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
-    pub(crate) fn refcount(&self) -> &AtomicU64 {
+    pub(crate) fn refcount(&self) -> &Refcount {
         &self.refcount
     }
 
@@ -189,7 +192,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Self`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { &raw mut (*this).refcount }
@@ -205,47 +208,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
 // mutate `self` are internally synchronized`
 unsafe impl<T: Operations> Sync for Request<T> {}
 
-/// Store the result of `op(target.load())` in target, returning new value of
-/// target.
-fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
-    let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
-
-    // SAFETY: Because the operation passed to `fetch_update` above always
-    // return `Some`, `old` will always be `Ok`.
-    let old = unsafe { old.unwrap_unchecked() };
-
-    op(old)
-}
-
-/// Store the result of `op(target.load)` in `target` if `target.load() !=
-/// pred`, returning [`true`] if the target was updated.
-fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
-    target
-        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
-            if x == pred {
-                None
-            } else {
-                Some(op(x))
-            }
-        })
-        .is_ok()
-}
-
 // SAFETY: All instances of `Request<T>` are reference counted. This
 // implementation of `AlwaysRefCounted` ensure that increments to the ref count
 // keeps the object alive in memory at least until a matching reference count
 // decrement is executed.
 unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
     fn inc_ref(&self) {
-        let refcount = &self.wrapper_ref().refcount();
-
-        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
-
-        #[cfg(CONFIG_DEBUG_MISC)]
-        if !updated {
-            panic!("Request refcount zero on clone")
-        }
+        self.wrapper_ref().refcount().inc();
     }
 
     unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
@@ -257,10 +226,10 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         let refcount = unsafe { &*RequestDataWrapper::refcount_ptr(wrapper_ptr) };
 
         #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
-        let new_refcount = atomic_relaxed_op_return(refcount, |x| x - 1);
+        let is_zero = refcount.dec_and_test();
 
         #[cfg(CONFIG_DEBUG_MISC)]
-        if new_refcount == 0 {
+        if is_zero {
             panic!("Request reached refcount zero in Rust abstractions");
         }
     }
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
index cc1a80ae7ae9..19236a5bccde 100644
--- a/rust/kernel/sync/refcount.rs
+++ b/rust/kernel/sync/refcount.rs
@@ -5,6 +5,7 @@
 //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
 
 use crate::build_assert;
+use crate::sync::atomic::Atomic;
 use crate::types::Opaque;
 
 /// Atomic reference counter.
@@ -34,6 +35,20 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
         self.0.get()
     }
 
+    /// Get the underlying atomic counter that backs the refcount.
+    ///
+    /// NOTE: Usage of this function is discouraged as it can circumvent the protections offered by
+    /// `refcount.h`. If there is no way to achieve the result using APIs in `refcount.h`, then
+    /// this function can be used. Otherwise consider adding a binding for the required API.
+    #[inline]
+    pub fn as_atomic(&self) -> &Atomic<i32> {
+        let ptr = self.0.get().cast();
+        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, which is an atomic 32-bit
+        // integer that is layout-wise compatible with `Atomic<i32>`. All values are valid for
+        // `refcount_t`, despite some of the values being considered saturated and "bad".
+        unsafe { &*ptr }
+    }
+
     /// Set a refcount's value.
     #[inline]
     pub fn set(&self, value: i32) {
-- 
2.51.0


