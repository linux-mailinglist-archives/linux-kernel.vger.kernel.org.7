Return-Path: <linux-kernel+bounces-802012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F7B44CC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59401A46516
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E9272E7E;
	Fri,  5 Sep 2025 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8jyaJqI"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D326FDA8;
	Fri,  5 Sep 2025 04:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047321; cv=none; b=OB6v0wpXNHEAFZ4KQAgMRr0VO/T8vlJDjQVdzP/XRQthg0kBVuoIAKEBh3QPpzzbEPHC3lnS+0W2TkW60V7X/V5ieH9QjPwH0qUpNbai2JjrlS8MQ3OSRch58+yfNEi+8q7cDoJcm9WP+OGwNVWsenYoYweEmqmdhTwQUOdXEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047321; c=relaxed/simple;
	bh=OP/y5Z2ItEpJO1pruM9YfefcbN4hnoJUmiqFq3KkuB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7pJfMFGK9MmbrWiMQh4Vscf2qiQkH2GMsrQBPOkVgVYZWixMfemDcylDQxe4DBjw4zLswxL2A3Zv7QXPbHtjE2z8plsJ4YGlonHWMx2QWVtlmWC54RdW0PeUYutZ9fbbAOgrYsHd8LpUSaSdGVq2/pXvEmq8rMmKEuM6/aHZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8jyaJqI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8112c7d196eso32507085a.3;
        Thu, 04 Sep 2025 21:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047317; x=1757652117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yB5wOWMdKGCxw2ekHEnxxlc/m+gPBxmksbRQB1jFry4=;
        b=L8jyaJqI4yqUKqlzjW+urOJ/oC57zgEvK53WQZGZZNbpK7tRvjmxSFea09zjDnTMbj
         m7jFhwx4F8L+AZ22K1mys4pbZtaWaDlpQrlMowPZvaPfguiva4vfFddiL0DcpMSLqLHO
         NV26mQw5He3Aenj6cFuxo7hYyPQw40R6EmR7un85Q+pc5CIQaMdfhmKIBDpryy/6gP87
         UNp31iPzARsrLgwfSdRubvUXJ5hgCtc6dEop3ZJY4e2pm6UisDlbWGnhzZd6PsGtV8tc
         +1f7HZ/q3nTMRS79IaZBUpbCXx7Mk47SDyHE1D+U75iat8xCuasytNc07qJlg0UhUKYT
         33tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047317; x=1757652117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yB5wOWMdKGCxw2ekHEnxxlc/m+gPBxmksbRQB1jFry4=;
        b=BEQ+SXeYiznH7mza+87LippmjVliDKSxqYFHEfLEvFdSJHqA0mmaCRAFHYGtgZaaGw
         WvVtE4KoOnc60eVK4X5ndiJDbEd8OqDTKU+DKsM6yDJVjjINW3iqZk8mopTjwCrhdE69
         oy23SNcPgqEtn/u6Sc/j1hciiKCbXbmVGWeYb3LQhZfG6upN597Glxfed1w8dKfgqazG
         Rf+WV3ALMnq+7dGzMG2do/7i7ppAGfu7ck8Yo7sGuHtjiQoHlBYP5LbbwmywgZJLuouP
         Xd9r/8TKN7KTZyX43A8HfQ7Qeik6TiyqZpgy1oi0YKJCYG/piVSdAdZo44lZETnNC3MG
         tudw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+z9V6eDVvL6UG66gYEroEPDvSF0tsdSx1qlveLNbeLhVBUJv/W7dwa2kCX/Vm69wMsaU2aDbW4pabck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lPDpDDjcZWjM8m+5luC7schOnqT8OAoDXfxkNqE7yZ6hlaDz
	Y4NFB0JVnZ+4LDVtuXXpnNFn6kP59EpA8qXec4yEVhI2VGTpFC7H6l33
X-Gm-Gg: ASbGncsyGEkvhVU4T4PAkcgJ30CPJmYTEnC2ffUbVFUZd3VBApfr5lpjpoAGvHOHpJ/
	YoUsCZwS6kAV/B9D+jeEtmC6k4YvX3+7V5Q54N+2PpVJxn1feOiAymnATeaCKHxxlTYRxqRIxS6
	CTlVjIgeCM0am45RbS48LHJTuFAB448JzpWHGxdDl5p7Qb7qutLbtGFfqT00Ddu43dpCvjRKPF4
	xtE8fZqw8v5a6MHexCurGiQpJ5Vc9RTZVuUrW93gI+zICAsxaObGQvYs+1viWyUOousWxW5w2fp
	/IXPWJDQm9X+SHSjTKjIOH9xYImE2M1S69dkaGLwEV3HyYtO4EjM7lLzhhyQAaij4bx00nCwGym
	bbGtiwRAtLKaJ65BMWWCfePoo0IivTBGfYBIpg3bkN99IuNpd5tLIoLue1tEVVfo5EGOKnV4gna
	7wfgR/YHXmLPcbJ45sneVWtgjkn1VgB9+5Sg==
X-Google-Smtp-Source: AGHT+IFWhvy6OHeykezuP+PzIMnH5qeCycW/7D2Uv3kr2KyPfxxzOIU6KjC0gGsvtHT73ySPM4LZJg==
X-Received: by 2002:a05:620a:3906:b0:811:f742:c75d with SMTP id af79cd13be357-811f742dd4emr7952385a.48.1757047317280;
        Thu, 04 Sep 2025 21:41:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa62c789esm409133785a.11.2025.09.04.21.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:41:56 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6572BF40066;
	Fri,  5 Sep 2025 00:41:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 05 Sep 2025 00:41:56 -0400
X-ME-Sender: <xms:FGq6aPZpwQfkT-oqH2FdOngKjhnrSMVL4r-x-U9b2NvUAZ8FPo565g>
    <xme:FGq6aMEIaR6Rty0bW_Ay11by4CYzh3wSeao4HoQYkq5JRX0w0oB-c_VcVl97ZQfnK
    Gf5h57ZFf-tBySG9g>
X-ME-Received: <xmr:FGq6aDsK9RNG1R3JuZeS0_H-ec3bijDYQLmGg3qxRpwwqXWD24WGNrE_5gn7I6lg3mi_H0SCu192GGqS1GhqGo8ZQRMVuc9m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:FGq6aCIWVro-yqpmuUV3W851nbR7l4RrSklZkga84VcFF_posrnmJg>
    <xmx:FGq6aBOPPVK1bPySNvXgOYxcNP4fDamTc0D_3MzBAM3k_bXluNaz1g>
    <xmx:FGq6aKYeD7xsk5dVpdb6XY2_6uefJp1zLRR26fa3IfJlFI-wPChrGA>
    <xmx:FGq6aNzkD6c8OPQJtW2ioxAmAYnOJ3oex4pUa92SLHL7AbxbkrqidA>
    <xmx:FGq6aGEn7Kq5KCECRKSahHrbtbV26Xy6kCU6iiJY0PnKPHXBGPBb9dtR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:41:55 -0400 (EDT)
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
Subject: [PATCH 03/14] rust: sync: atomic: Add ordering annotation types
Date: Thu,  4 Sep 2025 21:41:30 -0700
Message-ID: <20250905044141.77868-4-boqun.feng@gmail.com>
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

Preparation for atomic primitives. Instead of a suffix like _acquire, a
method parameter along with the corresponding generic parameter will be
used to specify the ordering of an atomic operations. For example,
atomic load() can be defined as:

	impl<T: ...> Atomic<T> {
	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
	}

and acquire users would do:

	let r = x.load(Acquire);

relaxed users:

	let r = x.load(Relaxed);

doing the following:

	let r = x.load(Release);

will cause a compiler error.

Compared to suffixes, it's easier to tell what ordering variants an
operation has, and it also make it easier to unify the implementation of
all ordering variants in one method via generic. The `TYPE` associate
const is for generic function to pick up the particular implementation
specified by an ordering annotation.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-4-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic.rs          |   2 +
 rust/kernel/sync/atomic/ordering.rs | 104 ++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/ordering.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index b9f2f4780073..2302e6d51fe2 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -18,5 +18,7 @@
 
 #[allow(dead_code, unreachable_pub)]
 mod internal;
+pub mod ordering;
 
 pub use internal::AtomicImpl;
+pub use ordering::{Acquire, Full, Relaxed, Release};
diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
new file mode 100644
index 000000000000..3f103aa8db99
--- /dev/null
+++ b/rust/kernel/sync/atomic/ordering.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory orderings.
+//!
+//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
+//!
+//! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
+//!   following memory accesses, and if there is a store part, the store part has the [`Relaxed`]
+//!   ordering.
+//! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
+//!   the annotated operation, and if there is a load part, the load part has the [`Relaxed`]
+//!   ordering.
+//! - [`Full`] means "fully-ordered", that is:
+//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
+//!   - It provides ordering between the annotated operation and all the following memory accesses.
+//!   - It provides ordering between all the preceding memory accesses and all the following memory
+//!     accesses.
+//!   - All the orderings are the same strength as a full memory barrier (i.e. `smp_mb()`).
+//! - [`Relaxed`] provides no ordering except the dependency orderings. Dependency orderings are
+//!   described in "DEPENDENCY RELATIONS" in [`LKMM`]'s [`explanation`].
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
+
+/// The annotation type for relaxed memory ordering, for the description of relaxed memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Relaxed;
+
+/// The annotation type for acquire memory ordering, for the description of acquire memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Acquire;
+
+/// The annotation type for release memory ordering, for the description of release memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Release;
+
+/// The annotation type for fully-ordered memory ordering, for the description fully-ordered memory
+/// ordering, see [module-level documentation].
+///
+/// [module-level documentation]: crate::sync::atomic::ordering
+pub struct Full;
+
+/// Describes the exact memory ordering.
+#[doc(hidden)]
+pub enum OrderingType {
+    /// Relaxed ordering.
+    Relaxed,
+    /// Acquire ordering.
+    Acquire,
+    /// Release ordering.
+    Release,
+    /// Fully-ordered.
+    Full,
+}
+
+mod internal {
+    /// Sealed trait, can be only implemented inside atomic mod.
+    pub trait Sealed {}
+
+    impl Sealed for super::Relaxed {}
+    impl Sealed for super::Acquire {}
+    impl Sealed for super::Release {}
+    impl Sealed for super::Full {}
+}
+
+/// The trait bound for annotating operations that support any ordering.
+pub trait Ordering: internal::Sealed {
+    /// Describes the exact memory ordering.
+    const TYPE: OrderingType;
+}
+
+impl Ordering for Relaxed {
+    const TYPE: OrderingType = OrderingType::Relaxed;
+}
+
+impl Ordering for Acquire {
+    const TYPE: OrderingType = OrderingType::Acquire;
+}
+
+impl Ordering for Release {
+    const TYPE: OrderingType = OrderingType::Release;
+}
+
+impl Ordering for Full {
+    const TYPE: OrderingType = OrderingType::Full;
+}
+
+/// The trait bound for operations that only support acquire or relaxed ordering.
+pub trait AcquireOrRelaxed: Ordering {}
+
+impl AcquireOrRelaxed for Acquire {}
+impl AcquireOrRelaxed for Relaxed {}
+
+/// The trait bound for operations that only support release or relaxed ordering.
+pub trait ReleaseOrRelaxed: Ordering {}
+
+impl ReleaseOrRelaxed for Release {}
+impl ReleaseOrRelaxed for Relaxed {}
-- 
2.51.0


