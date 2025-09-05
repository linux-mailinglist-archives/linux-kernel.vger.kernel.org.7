Return-Path: <linux-kernel+bounces-802017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12113B44CD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D544585DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5369202960;
	Fri,  5 Sep 2025 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0NZSrUd"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486D26C391;
	Fri,  5 Sep 2025 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047328; cv=none; b=Pzb6is7rHEvRcmyirxyEXgVdFVq4TUOtO2wFdoIpJDp3Mnyo80K/E9zHcWtlX959zEh+9mIl/lFmM5QcBLDt8r47kOLGl0bTcmVuNJqsJj2Z+wlBvSxrH5ZMTlhAppjwVj0jIveRTxRQTxXxLBhWIgAFEZ19omIs+S8SZHUUQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047328; c=relaxed/simple;
	bh=MFj734UHEc4mrv5vGKChrUUgs2IjOTEw9riI8z/uVVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvG8UbU7M6XbjExlbmEk6jiRF9EcAasl9vl/0GHzvfsISOVfSOF7TJ09K/K//Amf7NhqOdOjmChogQdisEbUHkWV/ANN+G3fj8wFqAZp+6sxoT1+JmR9em5BomHNh6DR6EfFB53VfFGMOfxJy7VViJ9pb8rD+982X4/8U0DnGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0NZSrUd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-72816012c5cso14886726d6.0;
        Thu, 04 Sep 2025 21:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047326; x=1757652126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMnDnVriN8OAFoEq3t7tKLFn2G8p60n2QFdWgNUyXAc=;
        b=l0NZSrUdp2iKtWQGAPg5BImlnvjnQVxbq6mRIF0COaOrJpbCLhfHhswZqngAO450xN
         ah2II+ikmcztARrV7X56UQMxsQdxe1KsEdJO5bKS2e7apXDN3P+ySkgSG4cgkpYlYGzG
         +Pk07KH2ECKqSYrjoP7MLZ6BOWLS3Y7Vfm7siIa8uTifJ0VrYW9y1ryQTQ8bSrtPWK3f
         yclC9TQNKZvdXzvJjf5mTyszUaR9ZB6jZNvXFVtOKn8yqII0pg/x33Sr/AKz+04ht1gt
         ucxiIJrkSltxoTGZJ5iJNCMHyNeNH42tJPNRy0WHVqFDIdGCUn5XwgXZoZuiaIc3z30B
         T2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047326; x=1757652126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMnDnVriN8OAFoEq3t7tKLFn2G8p60n2QFdWgNUyXAc=;
        b=crL51mfSVhfrexXVUkbQ0xda4AJHsMUj4usTR6rkEYMrqhoGvsJmR6JZLGzGF0aRNt
         HLSYmTuMBT0mhD8xCs7HXivJXhpNJOPXyP5IUfEhbMjXIOnRMmr0CQFp1C93yFIRt6UL
         J/e3qAlVkdzMUAEJgxXi+I5W5koVuFpWUIKyK53xMiLUES1oPmEWn12vvnZSMjisuCdS
         Bqnl3eBzQ2mPnEj8ZQS+K77ELkV+R3+8+SA3f4icVjEyKGb9FIi0qQ6hIcQJO03wMXyM
         lwByZ7QBnE4xtbGgG/9n9f5xzUuVB9WkpiSdLNgHcdaW614ovqXKCJSydtz0LQQPwQ9Q
         dVCw==
X-Forwarded-Encrypted: i=1; AJvYcCXImi0mRrts9XmaBng0zmWOJug8Qn7+Jp2dgHx46ucsqA9yapwhbPEXmkiv2ubYaBOwJLtiXKdoonwpRkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZ6T7HNuDiJU2xahJ6JSmjiJ+yA3NvAnA6cJz0x2W2D2YX+aw
	+seRMXHVveBpIWoe9QVltF/J3g4SMxKAzABeHcGJolkAOPFW211saw8g
X-Gm-Gg: ASbGncvAQTk0GX1VGWtzdqO4/UiyFlgACBA8lGsT1NvaONgu57/zJtgSeNWwvFU/Pdz
	eYG5FFvt1xqys9/um/Gs1vY1kc58tdYo7AXezCmWf+H22BpCan2GOvkuNA+f3Y57+QiG/t4f0L1
	22xr2RaId8+Jp30MHAccB0EckCKpZSKsfxDY3PCnbvp1TEjaQjNJK0DfA+bSNBgqfRDAfFcHTQd
	hlhxtWwDmd5MDI0dBjIOlbidm++Fdof7+25dL1TIFLGl4GMwU6d8owTtHnphQD9eB6FNNwK1v1k
	MppgSTfOO2O5yoQnGMrh74WZ3Ir6ey+vr9p2IsJNcLwLoGhQLzJ+PakqfS+K1B9a5vWB3e6Vyvl
	FNO+2ZZScp90J8cXJiZ6lEclPE52mGkMBefJximVUbOsIJquGefJv0OYKV85Nmjo/gKCY7HhEPr
	RENbPen7WKpnVyJ3ehyn7G1BaJ0RJ8R6BE7Q==
X-Google-Smtp-Source: AGHT+IHWGPwGtPYiAZg8AM6Wt/5qiuYqsUpzah7cVw8Saj4YNowV/zqQ65a60VBO+cYV8TS/LkkohQ==
X-Received: by 2002:a05:6214:76b:b0:717:4378:b604 with SMTP id 6a1803df08f44-7174378d2c8mr231227846d6.58.1757047325880;
        Thu, 04 Sep 2025 21:42:05 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b6c07573sm59727786d6.71.2025.09.04.21.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:05 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1A734F40066;
	Fri,  5 Sep 2025 00:42:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 00:42:05 -0400
X-ME-Sender: <xms:HGq6aLi7wTHa5enCTg1s_T9Oonbm2n66DJ9zblGir0w7Xbp4YJJiLA>
    <xme:HGq6aFsk2OQlg4ECP166IoXbm0a_kgG_CcZOjfHogifd3fV9tOli41XxbzR-elOrE
    ijWwMhXxZKu5Hfn1Q>
X-ME-Received: <xmr:HGq6aM0mCGKewZLMvmNnesfVhWXJEBNDoSaxA1mrW8UvTgR14aadO792BGiVGHQvn2wrYb-wfcN6_n-KZwXZkAXOlg-QLTT2>
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
X-ME-Proxy: <xmx:HWq6aExsvBYwCajNrtyP8C1dT0uTul20oI636BE2OsHgi8gvs0SykA>
    <xmx:HWq6aPX68XX4dR3KJuNEU0zxqBIEbj64O1BOSnqgFhr6Gh-WR8V2KA>
    <xmx:HWq6aOAZJnliUPq9QFE8qyOLScJ5TfQ740fcn3Opb6bgVL7fRUlTwA>
    <xmx:HWq6aI74BrU7LtPvuhS_HAJEOqEo4NUoksQmFMri-JoP7DdW4HMLcQ>
    <xmx:HWq6aCt26RxH5PVAdiMYISerVh7No_mRXC7uJJJ9wNBElW7tFbVmW5pd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:03 -0400 (EDT)
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
Subject: [PATCH 08/14] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Thu,  4 Sep 2025 21:41:35 -0700
Message-ID: <20250905044141.77868-9-boqun.feng@gmail.com>
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

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AtomicType::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available. To do so,
an internal type `isize_atomic_repr` is defined, it's `i32` in 32bit
kernel and `i64` in 64bit kernel.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-9-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic/predefine.rs | 53 +++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index d0875812f6ad..45a17985cda4 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -2,6 +2,9 @@
 
 //! Pre-defined atomic types
 
+use crate::static_assert;
+use core::mem::{align_of, size_of};
+
 // SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i32 {
@@ -28,6 +31,35 @@ fn rhs_into_delta(rhs: i64) -> i64 {
     }
 }
 
+// Defines an internal type that always maps to the integer type which has the same size alignment
+// as `isize` and `usize`, and `isize` and `usize` are always bi-directional transmutable to
+// `isize_atomic_repr`, which also always implements `AtomicImpl`.
+#[allow(non_camel_case_types)]
+#[cfg(not(CONFIG_64BIT))]
+type isize_atomic_repr = i32;
+#[allow(non_camel_case_types)]
+#[cfg(CONFIG_64BIT)]
+type isize_atomic_repr = i64;
+
+// Ensure size and alignment requirements are checked.
+static_assert!(size_of::<isize>() == size_of::<isize_atomic_repr>());
+static_assert!(align_of::<isize>() == align_of::<isize_atomic_repr>());
+static_assert!(size_of::<usize>() == size_of::<isize_atomic_repr>());
+static_assert!(align_of::<usize>() == align_of::<isize_atomic_repr>());
+
+// SAFETY: `isize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl super::AtomicType for isize {
+    type Repr = isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
+unsafe impl super::AtomicAdd<isize> for isize {
+    fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
 // SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
 // `i32`.
 unsafe impl super::AtomicType for u32 {
@@ -54,6 +86,19 @@ fn rhs_into_delta(rhs: u64) -> i64 {
     }
 }
 
+// SAFETY: `usize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl super::AtomicType for usize {
+    type Repr = isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
+unsafe impl super::AtomicAdd<usize> for usize {
+    fn rhs_into_delta(rhs: usize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
 use crate::macros::kunit_tests;
 
 #[kunit_tests(rust_atomics)]
@@ -73,7 +118,7 @@ macro_rules! for_each_type {
 
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.load(Relaxed));
@@ -82,7 +127,7 @@ fn atomic_basic_tests() {
 
     #[test]
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -95,7 +140,7 @@ fn atomic_xchg_tests() {
 
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -110,7 +155,7 @@ fn atomic_cmpxchg_tests() {
 
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.fetch_add(12, Full));
-- 
2.51.0


