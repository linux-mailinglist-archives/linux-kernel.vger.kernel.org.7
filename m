Return-Path: <linux-kernel+bounces-862517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF3BF580C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 086694FEE13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C132C329;
	Tue, 21 Oct 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8gmg47j"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F7329C4B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038884; cv=none; b=dQyLy1YPGSU1509E1BHPJ8cl6ZHYoQKlOiuJwkO++eyWhdEcmuYmhhsqd0Va1k+xZCGBxbGLKJs01hCATjTs01oHGTSE61Oq4RvPIRrGRaM8pCDEeRi1tp7G/yCBRkFFAoTtTPu0+1w1p2IVJI/kIyefL6o74Ci1RQ5Wsqpmjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038884; c=relaxed/simple;
	bh=FFUbOLmpWiVq/OQnGPHbAXC9NvVSCCzyQElac8PiRN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpIDS5dzAsKvJUrr5JpMSx+J3UoNrIvzCr1d47MwmGGypWe+PGXzPlp4NjTAQSbNmc6n+QYUl8qPip0BTKIhkpnipjk5EZIB8q8H4QpJrNcy4KCWAJrqHDgsBSV5TbHuiAw/xv5cZ88BV8wW2o07qowaX7/PzqCnd/lINVNGp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8gmg47j; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-791c287c10dso4125961b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038881; x=1761643681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP4fvZf3pq9SY9bqxcQGVH+sQa4EzI3l8Fc79jvogJY=;
        b=R8gmg47j1dWzGxsUhgK9IPgq67xahELp36WghPwP/648ej/hEVRigPP43HyFlrgZqS
         7vN0HJ5AKzqxvhgSAiqy67oVLECDp4qtHHTNbsnTWoeHzxwC3RwYtHxcGu7UmsXSiAbI
         S2nW30YOS2UZsw9+KGoybv+w4Kwb6OPuS0pdrDdOjlNMuH3Ibo2OWWW314OxmNJxp2Ez
         sktid0ks1BgNsp9Kto+FRm9zDeGIEXdOXn3515QlLTX4Aj7YDRJ0Ag3XtdUZLaxCYN0K
         3f18YkfIlbYvEnMAKlND8Ib+Tm8no61jCm/Bi/DmxgtDksrEC19JfoJFsrUS7uaM/MpY
         q/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038881; x=1761643681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP4fvZf3pq9SY9bqxcQGVH+sQa4EzI3l8Fc79jvogJY=;
        b=IUVoLZ+bKnfGO1UDSqA5FCi2cL4uyuN5bmvmGCSct46G5JUZ5fBOHKJZfDcI0Mpcuu
         es6Uc2eNq4yufSidsHZXEBsOftkL2rvvwvqv+5MTJYLO/6Yw3Q+mWyfm4Mt1U1NlEmc5
         FKfQm1netjqn58sjKSlb/XXT/JETc5bgxXInXJZfur9+RP/GQMeI7en0T2NU18v55qlp
         EmLAzyPBfrUE4RqKEHX2QRPduu6daVD5ingpN6ZcnNbEC2rNi7BCli2EBh+rUpM44F8O
         kd7c8XcF9n2cW/eNZCQXS8fe2h9ez1tfEcAzDYJpfg1x1ISZK03hd3IbqMU2ZEKeQto6
         POyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRPVUOy6vggWKSUexOEGa3V0+v41iUCwL3qhHyHg37KFE0DOaLH7A9kaXVvKXN3DGRp9mLHgDMAR8KtJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqD8xnOTVRylpMcvNmNhbpFN0zuAmWmh9PncYENLLW6SPksbcL
	BXU5V85hapWyM4DdHI+uEiZu6qv84R5/nvYxE3auLarn1wzLGUCOEGzW
X-Gm-Gg: ASbGnctub6t3C+49nT1zRw0zGWK4OcA0EUev6UWdqVMsM6DLUFmNJ2l22MhkNWluImX
	28TuBdlV3ygZSUfFfHgbKEN+v5AYxevrXsF191Sm/Ltb+kuqAqiy/N7R408ZirQEJiiUffso5sI
	tmxJKv/O4a/FG2hqj3m4TZBlPU0fqUCV29vGj194ffoTVG79LQ85wS4Bib1CqWKd4QiuK+iegIo
	hezmV2CH5ooK9LpW7uPkxrdHnr7huUNoFEddj/rhR8SAAh/ZX1DyawC3oliriLY17aCJBdlI4Fb
	yWBtz1xTW1zqNj484SD/K4ENH2YpcxPluZaXyMSjCYBUbA8RYOX8B2L7wnRLEKXb/LEg8XaeE4O
	XoIt2sEcEtp21EHDYkPoLx9mgS2mGFIhWHW7zwytCU+FR+KBap2vNp4KDbXdKMkr/7ERxVswGm9
	+fjarjFOsDGcJbTYBzUKUfLRl3a+57DT9Ug+CdZRSryMdkvVoy
X-Google-Smtp-Source: AGHT+IF7uNQlQx60VxuY/4vkMJx5kQH2Fl9qR73hXhH6ml9SwS2D1kJVI4vEX9WnryxiBax6hS4PCg==
X-Received: by 2002:a05:6a20:918d:b0:32b:7001:6601 with SMTP id adf61e73a8af0-334a8585a44mr22213945637.25.1761038881302;
        Tue, 21 Oct 2025 02:28:01 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25f41ad15sm493996b3a.41.2025.10.21.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:28:01 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: dakr@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu
Subject: [PATCH v2 2/2] rust: Add read_poll_count_atomic function
Date: Tue, 21 Oct 2025 16:11:46 +0900
Message-ID: <20251021071146.2357069-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_count_atomic function which polls periodically until a
condition is met, an error occurs, or the attempt limit is reached.

The C's read_poll_timeout_atomic() is used for the similar purpose.
In atomic context the timekeeping infrastructure is unavailable, so
reliable time-based timeouts cannot be implemented. So instead, the
helper accepts a maximum number of attempts and busy-waits (udelay +
cpu_relax) between tries.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/io/poll.rs | 80 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 613eb25047ef..c7dd0816205f 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -8,7 +8,10 @@
     error::{code::*, Result},
     processor::cpu_relax,
     task::might_sleep,
-    time::{delay::fsleep, Delta, Instant, Monotonic},
+    time::{
+        delay::{fsleep, udelay},
+        Delta, Instant, Monotonic,
+    },
 };
 
 /// Polls periodically until a condition is met, an error occurs,
@@ -102,3 +105,78 @@ pub fn read_poll_timeout<Op, Cond, T>(
         cpu_relax();
     }
 }
+
+/// Polls periodically until a condition is met, an error occurs,
+/// or the attempt limit is reached.
+///
+/// The function repeatedly executes the given operation `op` closure and
+/// checks its result using the condition closure `cond`.
+///
+/// If `cond` returns `true`, the function returns successfully with the result of `op`.
+/// Otherwise, it performs a busy wait for a duration specified by `delay_delta`
+/// before executing `op` again.
+///
+/// This process continues until either `op` returns an error, `cond`
+/// returns `true`, or the attempt limit specified by `count` is reached.
+///
+/// # Errors
+///
+/// If `op` returns an error, then that error is returned directly.
+///
+/// If the attempt limit specified by `count` is reached, then
+/// `Err(ETIMEDOUT)` is returned.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::io::{Io, poll::read_poll_count_atomic};
+/// use kernel::time::Delta;
+///
+/// const HW_READY: u16 = 0x01;
+///
+/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
+///     match read_poll_count_atomic(
+///         // The `op` closure reads the value of a specific status register.
+///         || io.try_read16(0x1000),
+///         // The `cond` closure takes a reference to the value returned by `op`
+///         // and checks whether the hardware is ready.
+///         |val: &u16| *val == HW_READY,
+///         Delta::from_micros(50),
+///         1000,
+///     ) {
+///         Ok(_) => {
+///             // The hardware is ready. The returned value of the `op` closure
+///             // isn't used.
+///             Ok(())
+///         }
+///         Err(e) => Err(e),
+///     }
+/// }
+/// ```
+pub fn read_poll_count_atomic<Op, Cond, T>(
+    mut op: Op,
+    mut cond: Cond,
+    delay_delta: Delta,
+    count: usize,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    for _ in 0..count {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+
+        if !delay_delta.is_zero() {
+            udelay(delay_delta);
+        }
+
+        cpu_relax();
+    }
+
+    Err(ETIMEDOUT)
+}
-- 
2.43.0


