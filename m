Return-Path: <linux-kernel+bounces-862516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 649CDBF5809
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C97A4FED11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DCC32ABD6;
	Tue, 21 Oct 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiUJk9Mo"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D832ABFF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038880; cv=none; b=C7XYTRAOupNsf3LPky9S8xMOsY5PMGt5M7/AaemjyJEljMXXISPfFn8BICLzQ89g2jdE3i/596/IyxEYbCssOXug6MiRumFvMjH+BV5kkGrNCH7COwmI03PKAlKhZYXT1hJRehecHKhOofQDJYBE/T+LH+XVOaTtJHELYUmxL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038880; c=relaxed/simple;
	bh=3/K3GDSMOD+085rTVXVIBdxxT7kof4c6WZKbETezSt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egq0jnj26XtLBgS9RuAWXxL7AF2shutWcnzLyGW58HS9NWzXNbouD4Y9prE22FBNj290+2INAY8LhMCig0pB0L8qK6Zhah939tjWWKM8jAqtXeV3ws0YdVE44Nn96XVpemCZcbaNHxbrOiYBNnUK39vfj3g+sAv++hCtGB9eXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiUJk9Mo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f67ba775aso6948566b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038877; x=1761643677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2NlzGd5x98kMuQNMDYXrVfdPQkIyShWAfGfbxPh7uc=;
        b=QiUJk9MobWfmTaOyNULUITKOfyQNOg6x+qroulBGq+kwGEiCtYPNrq+PQ5b2jW8Wdh
         NxSoffCoXsDlKoK6/FNxczJ9WEshR8U4zvCeGz5Vh/RSMyFyocWKkhDnynfSEZt5Dpj2
         GhaCwxK2wF7tykBzxsvxfM3+ALfLNE3fQj/jmUAiyfXLLQLHvPDu9dyhYMEtW9fE9YB7
         KHcvy1VdkSAuUtemccCVEOzZoE8Z0N+64Pf/hAuRXLmjiHaerXKZHU02/gdVAd/zKpF2
         e5x5vndYRl2MxwiDOGagfakDN9ZNFuqwIarMRAj3fe5USi2flg2vDldYI0gMv2d+NQEC
         2G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038877; x=1761643677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2NlzGd5x98kMuQNMDYXrVfdPQkIyShWAfGfbxPh7uc=;
        b=qG85QXc42RjG0yuLOzzUm5UEf+90nIYk2elTjzcNKgJ9CcCpQCiTOmWfOqnEthqPTW
         zDRbRPXfiW9D80+EGUf9OG8LnRRO4v3TuorQc1pInbaCpgncdNM/flHOVIExLWWXOs0g
         AEQO/+PpY7vC32HNrTzJrYs7b5lS1DwBlNflib3NVqXs7KCDKWhnQS1hhVjXmhyHByiR
         oHFKtmpS3tgx+oDVm/0du0GNqKX5X1+If9YSttFb1JFSzHI1TIT5+Al2alULitVZz8Ii
         Xv2Nz+kEY5b8bROxIozTA4c3J0Xth1S+TwF5hyhvGGVKzaKNqmG4V5OoktwLy1/lUFz2
         7xKw==
X-Forwarded-Encrypted: i=1; AJvYcCXYydSdeY9WpqUVTvXqEx9/ukZVxrBSpkiSzEJtxMiMqumKgcRdXv3hLO/+FrkEmYE6EWGTjTxPq2fnn3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkeR5pC5M5gmxFnl7LU1d8x/Onf+EV+xfcaqumKeIuSb0TuHFE
	OHFeXJMocTQXSoOEIJ86Y7tVaAmW45EH1+UO6apq4lwHYF7z9jrD/g+m
X-Gm-Gg: ASbGncu6Rv+cxp2QL8UHif4hqSEJ50zowOjNaZQ3FiuFbExk8EkY23nmJj1gA/DEHSK
	jZ6o713aFAtgI1Lj8cXWtTfZqdxj03FIEFjkLDoQ2lPgw/MfGLTrHVA9LQ5th4KACooRskWQ8Ir
	c5V/5GotyMsJqa1u3OFgDj4hzHrpdEjSN1ZJOvoAiMPhZe7zHSOQ2oFVFG7qgOdHqcF1Vrq7v/G
	cERMgW7dK7JrPxE3E51be00gGNIY7aDScf2PMNvLyqWQll4XE5H3tG4WTlkKTDkjMlD059wZRw6
	jz6TrzdYGr8+wwf4giTsxC/s0XNCTU5jj9vjPTPP33SKV/XYGGOTwPCOCzxwwbkknQMr33QVwb3
	dbAs+1i0Ki5rIld6/IyLt0Ad1NbGkr8nGW06bZMKFGw9uIZLmLEKDsQwFG0HoTCFfiJzxz9zfri
	VNo7q+mPtcDlbn6tRm/iICtUwNziBxHV1X2UNd3TbYSIE48gTgrzci67VBZYk02h06MW9yhg==
X-Google-Smtp-Source: AGHT+IG84QcMXftLvNN2/W5AZW4r3LF5ogTWd+gpV80sFCmWfCriH0heSVLuZ3TAujgYHHi+0lrA+w==
X-Received: by 2002:a05:6a00:182a:b0:781:556:f41 with SMTP id d2e1a72fcca58-7a220b07183mr18510234b3a.19.1761038877219;
        Tue, 21 Oct 2025 02:27:57 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25f41ad15sm493996b3a.41.2025.10.21.02.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:27:56 -0700 (PDT)
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
Subject: [PATCH v2 1/2] rust: add udelay() function
Date: Tue, 21 Oct 2025 16:11:45 +0900
Message-ID: <20251021071146.2357069-2-fujita.tomonori@gmail.com>
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

Add udelay() function, inserts a delay based on microseconds with busy
waiting, in preparation for supporting read_poll_count_atomic().

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/time.c       |  5 +++++
 rust/kernel/time/delay.rs | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index eb8838da62bc..fb7c15dfe186 100644
--- a/rust/kernel/time/delay.rs
+++ b/rust/kernel/time/delay.rs
@@ -47,3 +47,40 @@ pub fn fsleep(delta: Delta) {
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
+    // Note that the kernel is compiled with `-fno-strict-overflow`
+    // so any out-of-range value could lead to unexpected behavior
+    // but won't lead to undefined behavior.
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


