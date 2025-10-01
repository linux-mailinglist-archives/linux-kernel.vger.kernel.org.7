Return-Path: <linux-kernel+bounces-839502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF44BB1BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C98919C42D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54839310628;
	Wed,  1 Oct 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joWHD8d2"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A530FC06
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352640; cv=none; b=RUTbrrV3LhDZ7oh/YvTtqx4DZPHhq6okA5KI7fjz1NSfzMyUdHzri9QqIYtVszLhqugfzU5IUGKn1ZjyjDhgBSDIR8PzaP59llaN0lPjbkILBgX17/RYGnkAd1xVe/C5Oa1iNb1LGv8heck0dCfiZBx5wGBE+XxyYElchIYwWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352640; c=relaxed/simple;
	bh=y61+7VCzNMGSMbWtXfByDo69lK0ON+BCKh3sIOEFzkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HGt4baePm9N/ZAlUnlXtz8Ol7uoGlelS0H7yID3QyYBaxbe/SOecxSXSP88oQGg84xj9Zk909XFC/XQm0Yameo6/qJhWI7Mv3be9lIAPv6lOc6RcEz86RNWMMoEUEH6me93+5Ql7guhEWt0PxvXdWwvz4vC06i9bceGU2QfZHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joWHD8d2; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-634c48a0ce7so303866a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352636; x=1759957436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=acDSbPr0ckzlJYMJhQI+twxWM3EGvwpk6VEzCJHCwrY=;
        b=joWHD8d2x1bi8PXS+1tN+EACbQ+ehuWEkUIm2UjhZdyvaSfWJyM9aHbWWZLpPmzKOI
         crWV5ykV6rIDb+TuxPIySwlUyO9ERZwuhuFhisrd3Y0rj87eW+LMs4roJks0qBTFWAnr
         2nzrdjh8Oyg4eRHBPRTLmjiPfd99jO0B+GpBhQ7TcLNOivVxwnOYEihjteRYNDWtlwKY
         RuGb5GNjVNf8qECH6+QLpXzSNTrrr971qAmq/seTTOiY/Z+r76enGEr5xayrFKk+zkzj
         ys2BmS7b47dCx9bKIT9WMOPTlLa7KE0AB41BZM9Aum3sSBtUokAD4kAMNXzaeGhewLT4
         rB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352636; x=1759957436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acDSbPr0ckzlJYMJhQI+twxWM3EGvwpk6VEzCJHCwrY=;
        b=ikavJnVlmBIrtzmcKbau3mhup2pDFL1sWDCZw0ilvLNKptx3mcxLfx7cBDIzavgVtT
         ft8ppr1lWoogqhm50c7nK72830/ARpwY9Z7/xC05HghSo5IOjnwI3Ma8p7OzQS925LIz
         0pdZF6mMaaVpknrzCGujHO2zlLDXzZdYy3mAo8SnVsrcpdkIwD7Q+KzhGTUlsDHQVBUZ
         lVUrLI000jwEHB7dGVo6woou5GuMPR01tXJa9boCd6Het5xSCHBUMiwkZBhkEOyn5TWV
         qQ1/47tZbq6AfUHAjgRkwo8yiti/RjQftKSUva987LmB3diOY6LXEj8YswTWmziAaHC+
         Y9GA==
X-Forwarded-Encrypted: i=1; AJvYcCXvA3T8mNUQFS6IJCROgG1+d4bTn2VjZR+oOyYHobvtE0WhVr8QxF0YcNFv3055h1U9AS84S4vVYlbYb+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsEZvs6O/cvq87AZPqrAqiXbS7xXAddLc34ZVPnMEJlULCphK
	X+g96HTQz6ZaB6tM9N0inkG6C1REBA/VuL358KwCh7VgPKRhg9lVHn+N1h4CNA06Eg50B5RtYw=
	=
X-Google-Smtp-Source: AGHT+IEnx5RXeiL9kmHFg/RRSgpRtVYIAVUq2zDXnriSjY4GRqOqm0pZKleynTYr8BnmTOEPCHcJAcWB
X-Received: from edwn19.prod.google.com ([2002:a05:6402:4d3:b0:636:7d5e:f1f0])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:42c2:b0:634:b4cb:c892
 with SMTP id 4fb4d7f45d1cf-63678c998cdmr5701808a12.32.1759352635997; Wed, 01
 Oct 2025 14:03:55 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:06 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459; i=ardb@kernel.org;
 h=from:subject; bh=cjwJWt4i7jKdiITTdNRuozrMElZ3Ow1rsFcjCp41v6I=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePutDtRV62tdzTOWvv8H6N85apP8zU+pHE0XX+8dkfc+
 XknPnrM6ShlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATMdZk+F87y/Ne5BfOHc8/
 3mZY2B+3Pdrzc9G9588Cp8dLvpx1WsObkWHnjJRdwZa9pbmFmr8/W8ztFJOJlbz35bApq+W96/U ajMwA
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-26-ardb+git@google.com>
Subject: [PATCH v2 04/20] crypto: aegis128-neon - Move to more abstract
 'ksimd' guard API
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

Move away from calling kernel_neon_begin() and kernel_neon_end()
directly, and instead, use the newly introduced scoped_ksimd() API. This
permits arm64 to modify the kernel mode NEON API without affecting code
that is shared between ARM and arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/aegis128-neon.c | 33 +++++++-------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/crypto/aegis128-neon.c b/crypto/aegis128-neon.c
index 9ee50549e823..b41807e63bd3 100644
--- a/crypto/aegis128-neon.c
+++ b/crypto/aegis128-neon.c
@@ -4,7 +4,7 @@
  */
 
 #include <asm/cpufeature.h>
-#include <asm/neon.h>
+#include <asm/simd.h>
 
 #include "aegis.h"
 #include "aegis-neon.h"
@@ -24,32 +24,28 @@ void crypto_aegis128_init_simd(struct aegis_state *state,
 			       const union aegis_block *key,
 			       const u8 *iv)
 {
-	kernel_neon_begin();
-	crypto_aegis128_init_neon(state, key, iv);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_init_neon(state, key, iv);
 }
 
 void crypto_aegis128_update_simd(struct aegis_state *state, const void *msg)
 {
-	kernel_neon_begin();
-	crypto_aegis128_update_neon(state, msg);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_update_neon(state, msg);
 }
 
 void crypto_aegis128_encrypt_chunk_simd(struct aegis_state *state, u8 *dst,
 					const u8 *src, unsigned int size)
 {
-	kernel_neon_begin();
-	crypto_aegis128_encrypt_chunk_neon(state, dst, src, size);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_encrypt_chunk_neon(state, dst, src, size);
 }
 
 void crypto_aegis128_decrypt_chunk_simd(struct aegis_state *state, u8 *dst,
 					const u8 *src, unsigned int size)
 {
-	kernel_neon_begin();
-	crypto_aegis128_decrypt_chunk_neon(state, dst, src, size);
-	kernel_neon_end();
+	scoped_ksimd()
+		crypto_aegis128_decrypt_chunk_neon(state, dst, src, size);
 }
 
 int crypto_aegis128_final_simd(struct aegis_state *state,
@@ -58,12 +54,7 @@ int crypto_aegis128_final_simd(struct aegis_state *state,
 			       unsigned int cryptlen,
 			       unsigned int authsize)
 {
-	int ret;
-
-	kernel_neon_begin();
-	ret = crypto_aegis128_final_neon(state, tag_xor, assoclen, cryptlen,
-					 authsize);
-	kernel_neon_end();
-
-	return ret;
+	scoped_ksimd()
+		return crypto_aegis128_final_neon(state, tag_xor, assoclen,
+						  cryptlen, authsize);
 }
-- 
2.51.0.618.g983fd99d29-goog


