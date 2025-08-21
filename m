Return-Path: <linux-kernel+bounces-778905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145AFB2EC90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1448A17DF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D1261B8A;
	Thu, 21 Aug 2025 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgL9uLpz"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43D213E6D;
	Thu, 21 Aug 2025 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749053; cv=none; b=kIIFfEYcFQqccaYP2fyalVQ3FNrkAoiWv6RgAfsdDdKtrjFJaN8hvO2XFsZhD/L5HHO8/Lc3hY6gY+YYMvRWAAjZscutTvqgogWq8uED4Ms8sBcxfbEH1AM4QTf/Cmy27WOv8ESPSPvJEY3OmIQZPMd9hlmbQjSCzmHAucHz0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749053; c=relaxed/simple;
	bh=z5IPIVFJ5P4uauSXsspK8uJ9CpGbYRCkm1eFW6FH/Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eswX2LWU2YxHFizIRLgZmaXNr2RbHjYu0AHhU+Hu96S7k1adMPmbn+io2c15B0WGGbHZnthW+u9NA6DDIPJPxCN2siqa8ERZJ+y6Z3RhBbeycGW6MnVNPj7SDNb6uoNLoywESM4wR+Wlw0IHd657/bDgbYDvPUZN7gEcouLtjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgL9uLpz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32326e71c31so473480a91.3;
        Wed, 20 Aug 2025 21:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755749051; x=1756353851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aow/wVVK5zyGepx6G6zDTJH4x3+PA9yxQeTlb+kbXW8=;
        b=QgL9uLpzKbk90ge1gCe0p/HW2BEQngSRI2j41PHmlcjR7544V5vL22PGuo4y4c7gPH
         cTDl+ZUEFgmfaR0gJcjZmnjtlF/p8RgRAr7Slfwx7icBVJutGrZPFz2xduOuAsf7qLJH
         l7H6A0pKsI/B6jSNV7/Hdx5jAmifJKXouUfVfQMeOPvjR3HAczxcdCH/DoTpBjpjVk0r
         wepzt/erd3jl93f0t8b8VzDlOhlPFZM2aP4dGb7PvLjccSSapQmxasKKNzbKMVhUuX5f
         sNCJmmGguXq1hv3tNsPVGX8/d0R6jUh082PYK0WDUyjh82MeXzryIvaFqMyfbJNU4atY
         ri2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749051; x=1756353851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aow/wVVK5zyGepx6G6zDTJH4x3+PA9yxQeTlb+kbXW8=;
        b=YgDGWYFJCtJ9AfoeuTNqH4HOs1ZG+zt99apep/Ss3VytguwLT8uF73pKv/gj3y4w4N
         azI4/KDsAaFLU1n3cQFr6slPIgwknZtUSemyBnMnkVASx/tWQ7dwOZ6w1bJIt0Sz/BUn
         9y5EjJ6+Pp+vAGnD06ZWY/zDNLVjSTEueMB7NKxQSPr4e8U2ibPKC3w741GmqslaSCIk
         gBcHHpQeekEleo653X/zMgYS58ZscI5hDtHsmm+98EvR4+rOSh9Jkek7njnOzZUgLC70
         DzAc44VF1YyKNofpBN7zh7Zd5hYN9VZV/F0cZHan+vV/lfwnHSG2d86kRzZRa3eEaW5r
         EgsA==
X-Forwarded-Encrypted: i=1; AJvYcCVQhe6/wT+TQunP51zZc2zkJy33lfwK280FNqg61xSVtQPtDVrLfOAUodKYW2C8XJNdVWlhvTYHdchPHN+bF9o=@vger.kernel.org, AJvYcCVYjz4gDOQ3+gtLQ7eqgGRDtc/2VAhoVhAks6DFjv5wR3uHfLMBgzBUnMB346QmtGywZOsiUxDr1QRCMKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDUw4D3USFnzuxGTyUehB3N9I5IjX4aEHzhvQZE9a+dYUr0yz
	TRIGOTniIq7gpweFtb9L9lXbtpQP7i580eRERqNH5pHdV1Zhh7FLs2kS
X-Gm-Gg: ASbGncubahJlUtc8YNAput3Vpb1p5vhQSkv/soN3huZ/8MTjciK8Txvkh4imVPdqvS4
	td983vjAlkiVM5JyTRvhJWzXfkXcbdjBj7126Tw2s80JUg+5LfcjpjEgrxrQp9T7ddACnN93png
	s3AGEoY6gEmY+y5sGtsqXecg73VVA22W34cGQ38F9UjG5e/UkpLwrf8/3XQfRG6hqcH8QX1ff9b
	UKskijL5Trfq0+BWCJIQpApt3RN0k2J0L9nhaZQcCPDAy5e5R1axngO53OfLi7Im0LmqniUCoeY
	SRxrid0Uh3tcOL2C1TTAwNWBWA+kkkFwj7nBHXEOZKsvZU3vNwGwjdLBtUZ5aMCgmIvN8oSsdBi
	xUQDgtjZCs8aJJlZmh2r3pmjeOTQ6RJeP3TwnF30nf3ECEPn17btGg0x7XIolZKMFoziNHYM=
X-Google-Smtp-Source: AGHT+IG17sK4ZqV0+USpIV/Pp4EDCs3ugaJowmwsoe/CxEoiT+0xsA2J9l75V34kShYyIYG1a2SOWQ==
X-Received: by 2002:a17:90b:314a:b0:31e:ec02:2297 with SMTP id 98e67ed59e1d1-324ed10b558mr1582339a91.19.1755749051259;
        Wed, 20 Aug 2025 21:04:11 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4f0esm6538714b3a.90.2025.08.20.21.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 21:04:10 -0700 (PDT)
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
Subject: [PATCH v1 1/2] rust: add udelay() function
Date: Thu, 21 Aug 2025 12:57:09 +0900
Message-ID: <20250821035710.3692455-2-fujita.tomonori@gmail.com>
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

Add udelay() function, inserts a delay based on microseconds with busy
waiting, in preparation for supporting read_poll_timeout_atomic().

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/time.c       |  5 +++++
 rust/kernel/time/delay.rs | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/rust/helpers/time.c b/rust/helpers/time.c
index a318e9fa4408..67a36ccc3ec4 100644
--- a/rust/helpers/time.c
+++ b/rust/helpers/time.c
@@ -33,3 +33,8 @@ s64 rust_helper_ktime_to_ms(const ktime_t kt)
 {
 	return ktime_to_ms(kt);
 }
+
+void rust_helper_udelay(unsigned long usec)
+{
+	udelay(usec);
+}
diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
index eb8838da62bc..baae3238d419 100644
--- a/rust/kernel/time/delay.rs
+++ b/rust/kernel/time/delay.rs
@@ -47,3 +47,37 @@ pub fn fsleep(delta: Delta) {
         bindings::fsleep(delta.as_micros_ceil() as c_ulong)
     }
 }
+
+/// Inserts a delay based on microseconds with busy waiting.
+///
+/// Equivalent to the C side [`udelay()`], which delays in microseconds.
+///
+/// `delta` must be within `[0, `MAX_UDELAY_MS`]` in milliseconds;
+/// otherwise, it is erroneous behavior. That is, it is considered a bug to
+/// call this function with an out-of-range value, in which case the function
+/// will insert a delay for at least the maximum value in the range and
+/// may warn in the future.
+///
+/// The behavior above differs from the C side [`udelay()`] for which out-of-range
+/// values could lead to an overflow and unexpected behavior.
+///
+/// [`udelay()`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.udelay
+pub fn udelay(delta: Delta) {
+    const MAX_UDELAY_DELTA: Delta = Delta::from_millis(bindings::MAX_UDELAY_MS as i64);
+
+    let delta = if (Delta::ZERO..=MAX_UDELAY_DELTA).contains(&delta) {
+        delta
+    } else {
+        // TODO: Add WARN_ONCE() when it's supported.
+        MAX_UDELAY_DELTA
+    };
+
+    // SAFETY: It is always safe to call `udelay()` with any duration.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; `udelay()` inserts a delay for at least
+        // the provided duration, but that it may delay for longer
+        // under some circumstances.
+        bindings::udelay(delta.as_micros_ceil() as c_ulong)
+    }
+}
-- 
2.43.0


