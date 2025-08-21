Return-Path: <linux-kernel+bounces-778907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29783B2EC93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4317BFD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA46283C87;
	Thu, 21 Aug 2025 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4muNqPI"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECD26E70D;
	Thu, 21 Aug 2025 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749058; cv=none; b=BmZVEXubY+S4mtoR416QOolKfCXaBJDgtY45StbSJ0yvuxi1JR01VO2wSL/hxM/E05c4nd/C9I+KrfdusaRiSjdlvSM8M+uhBZCQpP6T63qMyn4l1JOJwV0W4I2y2LmPxeTOC1glDz3Isxl5hoiIXIjcaj4ZHFoaH/8qTGJgUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749058; c=relaxed/simple;
	bh=oZrbey5yx5uEbRq203YjlNLnmKksdSRfJ5gsdDLrF5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDA40CNWJ5lxvhRnaWeMBDU7YqeguUVqJw8yPKYwc1o9/H6tZXenlIWOBzw4HR9qSTBHccIfjTQ43WiwEPKqFM+m1t8wWm4QKxWIl8UFxa3CbuuiP3j1P5edz5UEUpI0ypcmyAOHDVxYtADWJG7U9FzZSX2/BqbCWWD3KXG4y0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4muNqPI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e93370ab8so626450b3a.1;
        Wed, 20 Aug 2025 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755749056; x=1756353856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2CqWIv3qh+ScjnQTvA5REeLwnT0B8P9nNd5NsH69v4=;
        b=b4muNqPIOiBam3t7NzPnQmsOKm7WWFadI6Mo6FzNIKn0bRnW3BL2xr5wjMTLdTsiJg
         dkGiJTmMi7m9orbL5k1GU+qktsaJY7ffKzE49EYhs0ql3K4APeJji5RRjJIxIAG244Pe
         rM2Mqcg+8q6ifVa7u0qK3z9GBa+PRaC1HCmCRR6HYu4eQBv1KDJ+nTSxyCld7pGg05fm
         kjOnZTu6dqMx9oleVzGRtYY/yh8zPPTytcUKG7UkHjlDHoNVYoJhhNNUPjv0Bp8eDKL4
         x6EfmkNTymkO6e7nNY0gEu6HMKoiJQJJNGAACfGIfbHdMbAK1TvpjWNQ6Pi6Wga2EE4U
         OU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749056; x=1756353856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2CqWIv3qh+ScjnQTvA5REeLwnT0B8P9nNd5NsH69v4=;
        b=EccCnZbj0BVAo/ZTJR34EZ5eeFKlH2XtcHeWoIRCi/pOICb4vuUxweaFIgMjD8pnHu
         4/c/f/UrfEwg32VvJ13f81JL4tyAClIc43rJoTz73bAgeD29VPzSI5E+8zobygqjNYdB
         J6JiPpj+F88yusV+tihFlimRkveMiHp3ljkkp1c86MPZvvaicZlArhEaEQjnYx1tPa2s
         eNCL58LyUssZ5Vb5o0ixOY/fjUYurvZ2dSuthcI4sSpcswDEi0/bGkOHbz1TPgb5WhOW
         KpLiP4IXwDPnpumX+27acEaC7qBF+VsTVlrvTcxMzMXDovivhs09ZkPzRQxy2AkFfDN/
         HUTg==
X-Forwarded-Encrypted: i=1; AJvYcCVybRVEp+AQQFCgKmS6Op+uPhmSl/w794XXF72EUxVVi8tFXftrVhQgxSpiULL+DYXCneMhJLtRV4d/HWQ=@vger.kernel.org, AJvYcCX3gsBnlXwb++FP1K9bPiWzRCMbIO9IsszAGmDJao3wJRtFV70Dog99bQNeCOW9ldvx+O+CIjCrpCNlisrnLjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhAFMUEyr10v53IeOAdn4cP39Ineeuz/RSibYfcxTth7m07c6
	593/7ftkhV3HENcoGTBGNgdllct2acZ7BeFyzD3E2+QB3JS51tIK5mU6
X-Gm-Gg: ASbGncsPhld+QCTbqL2mgUii0be0GSCNi3ulEHyEyI2LY7mXjjcFurwsQcpetNcYLLj
	Oe/cccS++PCTyejIVH1155T1BPE1tfhTTgg7pvrLJCM33w+osqEBRlVEHS6QnB1SGMwmKn3Lk2/
	YUnPN5sS1zjusEbekba7qFHkWJxopFtkY9GJDkl0GGkrE0wIXmBUqamAxwCBrPW0pOE5qv2Gy9q
	scGEikAIv+iy3rFxa5sP+pqSoeYJrDLvfMabJyDgHtf9OuLxnCBxR4P9VIZX652Mnfob42De5xg
	mBbvooJ9OiirwqCRwSDEWEdFYdn+s+oqKhlw3oojpdGI4zWEhjCxwMBNBtPVX4584yGXWYkcwR8
	XATW+J2cPEUTura19uSYpykUdJDlgF2CCwFuaFGh9csSaR7a1G1tLBSzatfl+Ha45EepV3WRrZ8
	AqdL1I/g==
X-Google-Smtp-Source: AGHT+IEBfOJPnqgYMjq415no3AtOarEE5p+Rcwd8wZf+szgzK1jEJbd2gn6h5ZkuPh7tbclLp/2K/w==
X-Received: by 2002:a05:6a00:1302:b0:76b:d746:733a with SMTP id d2e1a72fcca58-76ea31e3adbmr1412349b3a.21.1755749055698;
        Wed, 20 Aug 2025 21:04:15 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4f0esm6538714b3a.90.2025.08.20.21.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 21:04:15 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: aliceryhl@google.com,
	anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	daniel.almeida@collabora.com
Subject: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
Date: Thu, 21 Aug 2025 12:57:10 +0900
Message-ID: <20250821035710.3692455-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout_atomic function which polls periodically until a
condition is met, an error occurs, or the timeout is reached.

The C's read_poll_timeout_atomic (include/linux/iopoll.h) is a
complicated macro and a simple wrapper for Rust doesn't work. So this
implements the same functionality in Rust.

The delay_before_read argument isn't supported since there is no user
for now. It's rarely used in the C version.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/io/poll.rs | 90 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 7af1934e397a..71c2c0e0d8b4 100644
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
@@ -102,3 +105,88 @@ pub fn read_poll_timeout<Op, Cond, T>(
         cpu_relax();
     }
 }
+
+/// Polls periodically until a condition is met, an error occurs,
+/// or the timeout is reached.
+///
+/// The function repeatedly executes the given operation `op` closure and
+/// checks its result using the condition closure `cond`.
+///
+/// If `cond` returns `true`, the function returns successfully with the result of `op`.
+/// Otherwise, it performs a busy wait for a duration specified by `delay_delta`
+/// before executing `op` again.
+///
+/// This process continues until either `op` returns an error, `cond`
+/// returns `true`, or the timeout specified by `timeout_delta` is
+/// reached.
+///
+/// # Errors
+///
+/// If `op` returns an error, then that error is returned directly.
+///
+/// If the timeout specified by `timeout_delta` is reached, then
+/// `Err(ETIMEDOUT)` is returned.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::io::{Io, poll::read_poll_timeout_atomic};
+/// use kernel::time::Delta;
+///
+/// const HW_READY: u16 = 0x01;
+///
+/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
+///     match read_poll_timeout_atomic(
+///         // The `op` closure reads the value of a specific status register.
+///         || io.try_read16(0x1000),
+///         // The `cond` closure takes a reference to the value returned by `op`
+///         // and checks whether the hardware is ready.
+///         |val: &u16| *val == HW_READY,
+///         Delta::from_micros(50),
+///         Delta::from_micros(300),
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
+pub fn read_poll_timeout_atomic<Op, Cond, T>(
+    mut op: Op,
+    mut cond: Cond,
+    delay_delta: Delta,
+    timeout_delta: Delta,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    let mut left_ns = timeout_delta.as_nanos();
+    let delay_ns = delay_delta.as_nanos();
+
+    loop {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+
+        if left_ns < 0 {
+            // Unlike the C version, we immediately return.
+            // We have just called `op()` so we don't need to call it again.
+            return Err(ETIMEDOUT);
+        }
+
+        if !delay_delta.is_zero() {
+            udelay(delay_delta);
+            left_ns -= delay_ns;
+        }
+
+        cpu_relax();
+        left_ns -= 1;
+    }
+}
-- 
2.43.0


