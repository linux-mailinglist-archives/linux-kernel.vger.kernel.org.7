Return-Path: <linux-kernel+bounces-839507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD52BB1C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7BA188C439
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D7C311973;
	Wed,  1 Oct 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxrhPPOm"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D443112BC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352645; cv=none; b=kxbhFRL5ZE2brVevN94WNZm6mC/geNkEaaBEh/ZssIwnCF8LmpFSsrkfYtjxwat1yuPy1RiE8tB9vs2fwleN1hsXJ1Fa9VpyM/dOFMBa28l13Gae3kgtZGNHYkEVjhMC4mu7jJAV1IjLXwzwTL3yjwAMr/AeAko5ERDn1Mf2qTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352645; c=relaxed/simple;
	bh=DRYUDExVWqLdJx9CQihH/WVn5tjIj8wKdtaKatPJHTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mqPOSZGPxvo8thyorxBjoRNCigFPEPlh7SjWAZyH399TziyhDq93MoKI1Rrt6cfJRfNOtTdpssyyY9CtGdXCofyvc45hfp68XoLAnB4jDcqfhTy08KrnWC+6PFzzgs61Fq09ms0vHqipt1d/oBZW1QJlMSBoFX1e6QRosgQFN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxrhPPOm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so86937f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352641; x=1759957441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vE8eXwwbGKy5p5WbHU/i1dMObS51JLHu730fwFC+Odw=;
        b=oxrhPPOmXUBYITnhFzHIpIkkoeKNcX23Rmm02DLrZknKOLSK2ftkw4aeZhxBYYxy23
         vWpX081AFeTDbokDVj/qfqtNfEnn/Wv2fdo+a1SHwLPK0yH5gXP6KYxRXgT1yKWNGw3Z
         wIUIE8rLdXtZg/omEhGoRJa+TMtYeWzgNJbFSIArN3BGjYkZMdYH4nJBPMMEJfWgVvlL
         nF5DHWb3fATaz83kIf5sPFc/oHY86MgNusqGAkAsFjpMGrKeqIjAQxiDzZ/RBpj08n4D
         z3Z9NdmIH+lin1O+CQ+CHWnvu1QqwIJMGRtN5HkF/NAF/Q0ylXijI59T28V9z9+KIFj3
         17qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352641; x=1759957441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE8eXwwbGKy5p5WbHU/i1dMObS51JLHu730fwFC+Odw=;
        b=eEdZMSuCiyo5GeRL2wAdya7Eueh9HyOamVGgJcpLcOmSsLZq8kUfHCJQmCiDSfqRUL
         WinDoFPlbrcLwcL/T/8arbAiVFDaCUxG9qYx6NrjKhQoAoxln+OPZ5WnpOvoAN1lQ7br
         0TiR9uYwJ22ZT0Y86iJ0X4Qc2FPk7f5DEIzeD9zFv7fIxjrN/vm3MY11LLiDfK6JVgUq
         +DM8nFATGsv8cmtO9sA739DiU89Z29kLrh1pf+SB3fP6TKshQdAa3kTUhT4vAGdIGxRT
         KOY1QYG2/JnPF/pM2CHWb8/lLebfsd13RNrkPoiAu8Z8/Qd6Din2F43KFERvY7OEEWa7
         20eA==
X-Forwarded-Encrypted: i=1; AJvYcCUvMFgCI36YNrPiykOXzl8wep8FZ8nxzBo0iAp1KNA+zZ/4QHDkjAomRMmc4GQi9TsFh9kj1O7BLyNJ3DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcpfcaE46Hp5JH6Vu6BrscUV6/lTGL4W3Nh8BGV6ImDQbxU/i
	9n+Fvl/tS7cWGZzagkh5+uoKrKAKlIg/uOs3xhn6/aPoE8Fy7alXCXc66dYEeAzkxlw3Oq1myg=
	=
X-Google-Smtp-Source: AGHT+IH7ZtZzU237M2m1tNwTXmJBPEEEg2ifHIsvYzIIZQnXlN2lH+rAVb8JyGkAh+fVohPUM/1C32AM
X-Received: from wmlv6.prod.google.com ([2002:a05:600c:2146:b0:46e:19f9:cfe9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8414:b0:46e:206a:78cc
 with SMTP id 5b1f17b1804b1-46e612c9042mr40692505e9.28.1759352641678; Wed, 01
 Oct 2025 14:04:01 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:11 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5792; i=ardb@kernel.org;
 h=from:subject; bh=u6utO88LPPilhPgrmOnUNkYpCEnFY27X7HNtZdaOtj0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePutA9cXKLzKkytjZfvzuMw27rm9IWJmorzmss7FggGd
 Tm/kFjfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaiYsLwv25T0T8WyXkR2rOy
 xBgyucWuPZu+c35P51XpqCxjrQq1xQz/3Zkj9jtHHaqsdJ52+exfZmlp3ycpykUPWr0XWZw6cje DHwA=
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-31-ardb+git@google.com>
Subject: [PATCH v2 09/20] lib/crc: Switch ARM and arm64 to 'ksimd' scoped
 guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Before modifying the prototypes of kernel_neon_begin() and
kernel_neon_end() to accommodate kernel mode FP/SIMD state buffers
allocated on the stack, move arm64 to the new 'ksimd' scoped guard API,
which encapsulates the calls to those functions.

For symmetry, do the same for 32-bit ARM too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 lib/crc/arm/crc-t10dif.h   | 16 +++++-----------
 lib/crc/arm/crc32.h        | 11 ++++-------
 lib/crc/arm64/crc-t10dif.h | 16 +++++-----------
 lib/crc/arm64/crc32.h      | 16 ++++++----------
 4 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/lib/crc/arm/crc-t10dif.h b/lib/crc/arm/crc-t10dif.h
index 2edf7e9681d0..133a773b8248 100644
--- a/lib/crc/arm/crc-t10dif.h
+++ b/lib/crc/arm/crc-t10dif.h
@@ -7,7 +7,6 @@
 
 #include <crypto/internal/simd.h>
 
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
@@ -22,21 +21,16 @@ asmlinkage void crc_t10dif_pmull8(u16 init_crc, const u8 *buf, size_t len,
 static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 {
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
-		if (static_branch_likely(&have_pmull)) {
-			if (crypto_simd_usable()) {
-				kernel_neon_begin();
-				crc = crc_t10dif_pmull64(crc, data, length);
-				kernel_neon_end();
-				return crc;
-			}
+		if (static_branch_likely(&have_pmull) && crypto_simd_usable()) {
+			scoped_ksimd()
+				return crc_t10dif_pmull64(crc, data, length);
 		} else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
 			   static_branch_likely(&have_neon) &&
 			   crypto_simd_usable()) {
 			u8 buf[16] __aligned(16);
 
-			kernel_neon_begin();
-			crc_t10dif_pmull8(crc, data, length, buf);
-			kernel_neon_end();
+			scoped_ksimd()
+				crc_t10dif_pmull8(crc, data, length, buf);
 
 			return crc_t10dif_generic(0, buf, sizeof(buf));
 		}
diff --git a/lib/crc/arm/crc32.h b/lib/crc/arm/crc32.h
index 018007e162a2..32ad299319cd 100644
--- a/lib/crc/arm/crc32.h
+++ b/lib/crc/arm/crc32.h
@@ -10,7 +10,6 @@
 #include <crypto/internal/simd.h>
 
 #include <asm/hwcap.h>
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_crc32);
@@ -44,9 +43,8 @@ static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 			len -= n;
 		}
 		n = round_down(len, 16);
-		kernel_neon_begin();
-		crc = crc32_pmull_le(p, n, crc);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32_pmull_le(p, n, crc);
 		p += n;
 		len -= n;
 	}
@@ -73,9 +71,8 @@ static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 			len -= n;
 		}
 		n = round_down(len, 16);
-		kernel_neon_begin();
-		crc = crc32c_pmull_le(p, n, crc);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32c_pmull_le(p, n, crc);
 		p += n;
 		len -= n;
 	}
diff --git a/lib/crc/arm64/crc-t10dif.h b/lib/crc/arm64/crc-t10dif.h
index c4521a7f1ee9..dcbee08801d6 100644
--- a/lib/crc/arm64/crc-t10dif.h
+++ b/lib/crc/arm64/crc-t10dif.h
@@ -9,7 +9,6 @@
 
 #include <crypto/internal/simd.h>
 
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_asimd);
@@ -24,21 +23,16 @@ asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 *buf, size_t len);
 static inline u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t length)
 {
 	if (length >= CRC_T10DIF_PMULL_CHUNK_SIZE) {
-		if (static_branch_likely(&have_pmull)) {
-			if (crypto_simd_usable()) {
-				kernel_neon_begin();
-				crc = crc_t10dif_pmull_p64(crc, data, length);
-				kernel_neon_end();
-				return crc;
-			}
+		if (static_branch_likely(&have_pmull) && crypto_simd_usable()) {
+			scoped_ksimd()
+				return crc_t10dif_pmull_p64(crc, data, length);
 		} else if (length > CRC_T10DIF_PMULL_CHUNK_SIZE &&
 			   static_branch_likely(&have_asimd) &&
 			   crypto_simd_usable()) {
 			u8 buf[16];
 
-			kernel_neon_begin();
-			crc_t10dif_pmull_p8(crc, data, length, buf);
-			kernel_neon_end();
+			scoped_ksimd()
+				crc_t10dif_pmull_p8(crc, data, length, buf);
 
 			return crc_t10dif_generic(0, buf, sizeof(buf));
 		}
diff --git a/lib/crc/arm64/crc32.h b/lib/crc/arm64/crc32.h
index 6e5dec45f05d..2b5cbb686a13 100644
--- a/lib/crc/arm64/crc32.h
+++ b/lib/crc/arm64/crc32.h
@@ -2,7 +2,6 @@
 
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
-#include <asm/neon.h>
 #include <asm/simd.h>
 
 #include <crypto/internal/simd.h>
@@ -24,9 +23,8 @@ static inline u32 crc32_le_arch(u32 crc, const u8 *p, size_t len)
 		return crc32_le_base(crc, p, len);
 
 	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
-		kernel_neon_begin();
-		crc = crc32_le_arm64_4way(crc, p, len);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32_le_arm64_4way(crc, p, len);
 
 		p += round_down(len, 64);
 		len %= 64;
@@ -44,9 +42,8 @@ static inline u32 crc32c_arch(u32 crc, const u8 *p, size_t len)
 		return crc32c_base(crc, p, len);
 
 	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
-		kernel_neon_begin();
-		crc = crc32c_le_arm64_4way(crc, p, len);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32c_le_arm64_4way(crc, p, len);
 
 		p += round_down(len, 64);
 		len %= 64;
@@ -64,9 +61,8 @@ static inline u32 crc32_be_arch(u32 crc, const u8 *p, size_t len)
 		return crc32_be_base(crc, p, len);
 
 	if (len >= min_len && cpu_have_named_feature(PMULL) && crypto_simd_usable()) {
-		kernel_neon_begin();
-		crc = crc32_be_arm64_4way(crc, p, len);
-		kernel_neon_end();
+		scoped_ksimd()
+			crc = crc32_be_arm64_4way(crc, p, len);
 
 		p += round_down(len, 64);
 		len %= 64;
-- 
2.51.0.618.g983fd99d29-goog


