Return-Path: <linux-kernel+bounces-802018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA7B44CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B125B5854AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558F28506C;
	Fri,  5 Sep 2025 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7flKTJL"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A427E07F;
	Fri,  5 Sep 2025 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047331; cv=none; b=jNmGROk7VGy7ZIuuPJC1LHAlEy/nXKaTO6ZYM8SkxBGGr7hNwsAORPTEFLKpwi/Oh0YygFy1mqtXBS7nOfNtGOQsQgjQTvbaZz2A6O2H1evg8LVEuzFGMJENXu8qmdAPeNYFNlcAl00Bu5Cjij5HDEwITO4C0oJn04lAakTOsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047331; c=relaxed/simple;
	bh=MjjRLGXaXKWnDN3Y+iZ9hxKqosHun5TiO6t6DTgkt9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efRoaolXLLttaqKcfo475CZlmnTmOhpjuQLAYLGApQXt8uTpmJBcXLyklyRVLoYabn3937P6LIsLfc1RiYUvOdHh3lKfGsvUjG7f+v7KC2/naGdQ4n9wDjcVkwRs7BxJ8O+VzZmlXHW0wzNUPmbq+0w73zUh1kG4lm98qHO4DEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7flKTJL; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70ba7aa131fso19967786d6.2;
        Thu, 04 Sep 2025 21:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047327; x=1757652127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z62qnMU5mjIwTXCgyuKsR71Jw7Lr+dHd+ICuGmGo6xE=;
        b=k7flKTJLfduR7NOMi9C8kTkcpITcKJx72iAVplhhzV1cJ7nqWI+Vv5tav96gS/oFDA
         EGDtLzEVmcGfLrdXHj9ek3XXvsU0mvc7n9+p5KO715trdHbu36IHrt+CO9DCHlLQ/7Pq
         B+nY44Az24SkQ7Yiey+AJ2i4xa7/uG4HIUAc2vbBCh6kAl/3HFR3ADDsvNJedGjLFTR+
         siPhS9tqRxlrVlUGrfnGnDIP7V08Ohlh5ngfnyjVIQqmM/HZal+COSPla1aEX7QcSL+v
         quGelzPQbumVaUMuBNcrBNYDRjWOATrkk7xVaX2M3mby+ljmKL2GbI42X8GBY2iPJMEZ
         5XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047327; x=1757652127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z62qnMU5mjIwTXCgyuKsR71Jw7Lr+dHd+ICuGmGo6xE=;
        b=sVLux+DcQSaTj9GPJvgKKxCFOg1+7VIETtPuPyZ22cm2h/+XEHxscBb1Toh40vAAWG
         fmb3nunM8c0fbe4z8ppI74HKLZzJQr6IXkmHRz6OBeqTlwdjIPHyhoL9EXzkIvBlduuO
         q7MSliF2SR6NX1HRlX0bxXlKi/ol+GZ6RMswwy6Af7C9GHyv7Azzz9J5xxeeLY9UXYn3
         gWLi8xpq0lRjzOWHtylDHOP1tG0nNV4e0F4lEdOsYeEWyjqQ5kpK1ppk+7qwWBr2IDYS
         FMPC6dz+ZZ/2r4s05CDwJM4VAdCDoGyhShb9grZaDyVu1jiwcRlf2dXxdW7TXBZ4Zd2r
         6DuA==
X-Forwarded-Encrypted: i=1; AJvYcCUUxUWAmRehUxx+CfJJiKRGtd9m1S+4+rmesew2wfnhIXlyqRWjWgRUkIS961T0Jzo8KcuhDQ7vfIyhH68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DooDddk/Y5ddCDdr/GhIhGyZ4KRMk0EuhE9jAAS4cISQj7Rs
	mFbgghPi/DIYb6zCtyE8a3iNHfeuiVcHpML7VaNkR73oDnQ5bu0SBvra
X-Gm-Gg: ASbGncvGvbSbHrgFbJXdZOdZBsoUDJqlgBTASBKB9ZL83dwcWnOevurQo6nRGWqpzWP
	QsMDbl9VpXrEFnGyJrC+Z3dTpAtDOkrA1Rw20a+kr6l5UtAAyZ/6xdHupFml3X0bnTJfk3jyV0n
	TreKKpaHjIzhEaSDGCVeLyWGl4zYTuF2RNpuiNzsNscT8IEvFFDKiCUbdn3O1R3VPABV8LqeKnf
	dCNERM9u54qUGDLffTcMj/ZzuaEpdGYLXpk710KkGWW89Jtw/sFQoEvrKG0vP0iNxcl9nDPItUl
	NI+dZm5OXoyGSNP+zrc+BSouTiFwlBarLQogcFPRsSdFH62a7Uf78lCrlJ3wiWy+txMvZdP1Xon
	hjDvJ2mb4Qn9AdyuVJhFm8fGInvR9y5ogo4WkBpIUB0fmx0AVdHD5oLwfieJ1kPU4eQ4wcidaMq
	9lW3cTXMpBM5hOtmirhDTmgiA=
X-Google-Smtp-Source: AGHT+IEsR6vmJrmL1/mS07dilwjZjcLcZ0cV5rOniLcV8/5upI9i24wgAvLK4fDsKHx4HoJ5HVF+0w==
X-Received: by 2002:a05:6214:d8b:b0:72b:205c:aad5 with SMTP id 6a1803df08f44-72b205cac27mr40375116d6.2.1757047327444;
        Thu, 04 Sep 2025 21:42:07 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-728a860bdebsm24972856d6.69.2025.09.04.21.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:07 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 918FDF40066;
	Fri,  5 Sep 2025 00:42:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 00:42:06 -0400
X-ME-Sender: <xms:Hmq6aGM3TXyRkjQNs1hi4I9JbqJKWSHJmlQtS-vc2-NTzrZq39nQ1A>
    <xme:Hmq6aCpu-z4ocUeS4JRtkdYNAp29eKw4dUpNhue6bY-eF3_ZyUo21WLgH4RCrl8WZ
    a-fePL0YdUvMjVAYw>
X-ME-Received: <xmr:Hmq6aPCNMgRMwsN07VIhCNePUVdzrENIg45MEZsiXu6vAjrqE9iRC-Jh5ZWV-FiiPT9XdwlVNYG4EXh2ftCwiEvYHwiwm8_G>
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
X-ME-Proxy: <xmx:Hmq6aDPIt6kheJK8BXXjrKrNS7HnZINnsR12DzsE7b-llqVscGvQhA>
    <xmx:Hmq6aFCmfeqtyO1VHV6HDeZL1ENzFkbNTXJzIksOqfAP1h6nW2fP_Q>
    <xmx:Hmq6aJ_RdXa5aD4cjdfLzzHsno8S1686E3WfiCupiIIOaE3f-gt-Ew>
    <xmx:Hmq6aOHOITUODxTFQRD0A3Y1ZYmcTvGJL6Hu3fHuqJxYa-CgN1kS4w>
    <xmx:Hmq6aIJJaVMovLYw6Seyv3FISUjCV6BQa6JJ87fvCu3GPHxX5L4cNadX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:05 -0400 (EDT)
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
Subject: [PATCH 09/14] rust: sync: Add memory barriers
Date: Thu,  4 Sep 2025 21:41:36 -0700
Message-ID: <20250905044141.77868-10-boqun.feng@gmail.com>
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

Memory barriers are building blocks for concurrent code, hence provide
a minimal set of them.

The compiler barrier, barrier(), is implemented in inline asm instead of
using core::sync::atomic::compiler_fence() because memory models are
different: kernel's atomics are implemented in inline asm therefore the
compiler barrier should be implemented in inline asm as well. Also it's
currently only public to the kernel crate until there's a reasonable
driver usage.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-10-boqun.feng@gmail.com/
---
 rust/helpers/barrier.c      | 18 +++++++++++
 rust/helpers/helpers.c      |  1 +
 rust/kernel/sync.rs         |  1 +
 rust/kernel/sync/barrier.rs | 61 +++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/barrier.rs

diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
new file mode 100644
index 000000000000..cdf28ce8e511
--- /dev/null
+++ b/rust/helpers/barrier.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/barrier.h>
+
+void rust_helper_smp_mb(void)
+{
+	smp_mb();
+}
+
+void rust_helper_smp_wmb(void)
+{
+	smp_wmb();
+}
+
+void rust_helper_smp_rmb(void)
+{
+	smp_rmb();
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7053f9245759..85ad14b81925 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,6 +9,7 @@
 
 #include "atomic.c"
 #include "auxiliary.c"
+#include "barrier.c"
 #include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 7e962e5429d2..bf8943c88a89 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -12,6 +12,7 @@
 mod arc;
 pub mod aref;
 pub mod atomic;
+pub mod barrier;
 pub mod completion;
 mod condvar;
 pub mod lock;
diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
new file mode 100644
index 000000000000..8f2d435fcd94
--- /dev/null
+++ b/rust/kernel/sync/barrier.rs
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory barriers.
+//!
+//! These primitives have the same semantics as their C counterparts: and the precise definitions
+//! of semantics can be found at [`LKMM`].
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+
+/// A compiler barrier.
+///
+/// A barrier that prevents compiler from reordering memory accesses across the barrier.
+#[inline(always)]
+pub(crate) fn barrier() {
+    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
+    // it suffices as a compiler barrier.
+    //
+    // SAFETY: An empty asm block.
+    unsafe { core::arch::asm!("") };
+}
+
+/// A full memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
+#[inline(always)]
+pub fn smp_mb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_mb()` is safe to call.
+        unsafe { bindings::smp_mb() };
+    } else {
+        barrier();
+    }
+}
+
+/// A write-write memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory write accesses across the
+/// barrier.
+#[inline(always)]
+pub fn smp_wmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_wmb()` is safe to call.
+        unsafe { bindings::smp_wmb() };
+    } else {
+        barrier();
+    }
+}
+
+/// A read-read memory barrier.
+///
+/// A barrier that prevents compiler and CPU from reordering memory read accesses across the
+/// barrier.
+#[inline(always)]
+pub fn smp_rmb() {
+    if cfg!(CONFIG_SMP) {
+        // SAFETY: `smp_rmb()` is safe to call.
+        unsafe { bindings::smp_rmb() };
+    } else {
+        barrier();
+    }
+}
-- 
2.51.0


