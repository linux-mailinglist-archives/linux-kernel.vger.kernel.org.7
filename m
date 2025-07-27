Return-Path: <linux-kernel+bounces-747190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F828B130D5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDFD17475E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9021C9F6;
	Sun, 27 Jul 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsjEv1a2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34070610D;
	Sun, 27 Jul 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753635763; cv=none; b=R81/tuaeTRvcpktzrI0B6CKdRtZ18IukQexYxeC1+NlrnzCfpMeWLhvTMJgqX9nqi0hBWQgumo9+I6Kog6Pe0VDX8ZXSd36bFU6uu8ihCta8umUU7VlpuEU4OxaR39H45ijaQiuH8g6hnF0h2ki46/EUcY4+p9I1T4811+8h2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753635763; c=relaxed/simple;
	bh=MGwnuNgMnpCB3HFgNR9y1CpU+sPZS9r4J955g8FJYbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KW2SEb7MUvi5jz8LAT967GoZvkvVlrRi0r8vUJcqxDrG37Xm48vVMUe32DV8p9FDb/zVKohVLqlUR5k0fQdBYs1OShj/zJgKtGV6eLMU8mRTsja37EVk2OfpSQlw/6AvNtdxJN/ba1HttYwABV7qNh2U+MJSkpKc5rSkffN/JMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsjEv1a2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24022261323so2169145ad.1;
        Sun, 27 Jul 2025 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753635761; x=1754240561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdX52KrqVBqheUlpk3q0tshHfWjwkzxFRFnw+JbO75w=;
        b=nsjEv1a2hz4L3ZTvJ+RH1npszeYnPGqIxpNYlqxwiJ10A+//RabEg67EgDDx0+gjgq
         AZ7pZaH8sKUgL9BgP0dg/p4YlUxHUemnpEVD8GTN6rCTeNOVyj3Aq1aBCQc7/PC+etJc
         eMmISW9RDr1Xgd1/YiPsYo0vk1VBGMsu32zj5D53xU52u3Q2VAXsJvgCktspt7QubvPa
         ziRtMZS8vTMdbZe6DguRNHYINvGUhnFrJr4Vhr0c6Oa/cYvB96AHpD/xj442ql3oo5i2
         qGEdbqUPuR9MIID8PSmu/wXdfxJH0ArdpswwPeMVvJFRKuVzgNn/MuTx9hgUzFe8iZnV
         mZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753635761; x=1754240561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdX52KrqVBqheUlpk3q0tshHfWjwkzxFRFnw+JbO75w=;
        b=aRCm1r2/kF8qFRNCQDB0NR9YKcZXx4ZXV3Ghc2so3j9yp1Jva+iI/ZGFrVg7VTsG2z
         xRtMSNYVDPkjlM+PN8JvtXDi2s7ZEtKMCral2+BwXsD1jrOCzfCEkuIb+XxxKG6EQOfW
         roOBLbt1YJU4dgLOHeFAZjEi/s6/Abk4efMpfCnT8YlEEOSNxx73o/yH4vA3R5ITw59C
         QFDI9jeKZN64tV9uxtwd4tA9UGKAjVoR8wFDyZoJcR5jhJkuLxiZ7J2YwUSg4YkGhsG5
         89g8A2tcQqu7WhKYE6neea3T4llWvp1dE9EVnj1pQboqQtCunGeYmcyWeFHyeGf9fIKf
         jFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5eFYO4f0fPz3dYJl9C/DNbM/kAurjJDmo2mbtAQwzajszrdWdR+wE7SpwYv0hmuy/bww3e57Jq5JLgIy05gE=@vger.kernel.org, AJvYcCW4HxVVztoaGwZfMcW9AXamsB0w320shTZQ0Ou5s99l3H/c9BRWwKFGWetK7vqnmQQyxDNMrpbFRrk3tqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39P8mE/ZOVuPirptAMPhDlOBPu+ahgd0n7yL9/2Ts4uF1taUA
	lodAKR4FJw848z1Pt2zdwRHHpS5EoV+4qoiJVWpoZMGyn2LnJ6DcpUmk
X-Gm-Gg: ASbGncvnMfMbYNC0p85ujMPBpwUnb3a6sAZFVSbfMehfaIMrX5XRjdXXQom1OvK2QlU
	ThNfbZv3dfNF4xyWPiQG9Jiq8BPCvOa7OGZVL+XjUOXStpPupbmudx10ZfqXvhAxykNM18tC2+m
	jw9WqrVnFocpsoxy+PnkCAFbgFN7siazVT7qIhAn+Zm73RnHYxEmxbFgKyBzGkNTpZ2hbGxqn6q
	NIEKYgrpSlT/424adcweFGVqlHyUAL2f4U40P43GHrDYGxGbKXkm9GuJeg2O/BebxEkbiau75YR
	6B9hhToNKbkFzPXDHh/KDvI05kCmqrkPhLsCaY4Q54MG7aewyvK4sg9FW9QeRZbQNyIXVF+/FLe
	ixlWKHRxK4wNZKlDgPhHetJclw90s+MY=
X-Google-Smtp-Source: AGHT+IHqm/J2SvIlgvt1S3np+aih5SP3n/FU/4D4MXeaiLrPLXXJeqOksquY8u12MW43rJxFyGb2cw==
X-Received: by 2002:a17:902:c950:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-23fb2a7b959mr122833325ad.1.1753635760923;
        Sun, 27 Jul 2025 10:02:40 -0700 (PDT)
Received: from archlinux ([205.254.163.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff1dbec8esm21709945ad.194.2025.07.27.10.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:02:40 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: lossin@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	me@kloenk.dev,
	chrisi.schrefl@gmail.com,
	rust-for-linux@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] rust/pin-init: remove workaround for type inference cycle
Date: Sun, 27 Jul 2025 22:32:17 +0530
Message-ID: <20250727170217.206794-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `cast_pin_init` and `cast_init` functions previously used an
intermediate `let` binding before returning the result expression to work
around a Rust compiler issue causing type inference cycles. With the
minimum Rust compiler version for the kernel now at 1.78.0, where this
issue is fixed, the workaround is no longer needed. This patch removes the
unnecessary `let` variables and returns the expressions directly.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 rust/pin-init/src/lib.rs | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 62e013a5cc20..cc244eeb19cd 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -1278,10 +1278,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> impl PinInit<U, E> {
     // SAFETY: initialization delegated to a valid initializer. Cast is valid by function safety
     // requirements.
-    let res = unsafe { pin_init_from_closure(|ptr: *mut U| init.__pinned_init(ptr.cast::<T>())) };
-    // FIXME: remove the let statement once the nightly-MSRV allows it (1.78 otherwise encounters a
-    // cycle when computing the type returned by this function)
-    res
+    unsafe { pin_init_from_closure(|ptr: *mut U| init.__pinned_init(ptr.cast::<T>())) }
 }
 
 /// Changes the to be initialized type.
@@ -1294,10 +1291,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
 pub const unsafe fn cast_init<T, U, E>(init: impl Init<T, E>) -> impl Init<U, E> {
     // SAFETY: initialization delegated to a valid initializer. Cast is valid by function safety
     // requirements.
-    let res = unsafe { init_from_closure(|ptr: *mut U| init.__init(ptr.cast::<T>())) };
-    // FIXME: remove the let statement once the nightly-MSRV allows it (1.78 otherwise encounters a
-    // cycle when computing the type returned by this function)
-    res
+    unsafe { init_from_closure(|ptr: *mut U| init.__init(ptr.cast::<T>())) }
 }
 
 /// An initializer that leaves the memory uninitialized.
-- 
2.50.1


