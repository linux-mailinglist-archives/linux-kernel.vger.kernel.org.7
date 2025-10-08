Return-Path: <linux-kernel+bounces-845687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD96BC5DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0186B4FAB37
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442F2EBB87;
	Wed,  8 Oct 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8EuFrW9"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD692F8BC3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938415; cv=none; b=dBMQCdsQkItiC4BpYhYTz88vK3lHuQIqdBNkvFUoncQhe6gdC+kCealy3JB5F5MaCVW6Kzq0p7qpnmyYwXyQ1wKjNGsIxCHLKmunU621i0nGGktkdP4w5uSyjfcESX6KWeUQgU/iPDe/Njb98iTYziOb+qk01aLpkyZGrX+dZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938415; c=relaxed/simple;
	bh=DzdKmNybBzIYfFee5bWkHzTZXIhZDSbQmeTIrng6jjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Be02QvMRr0UOLo7HbtJgvbDRl9AtUZW6Os0eBJeajZd2dYUIAI3yQvkae4++1uzmEtd49r3X3LWP7VoZ8VdQmSPlTDsM7jm+WrUmfv36CPIj8WiJvIylG+Xx8Rk8m7hKUYrIGvq6c962IZ7zd04ZeS+ArYbkVaNR48kKIDBtquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8EuFrW9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e38bd6680so26784235e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938411; x=1760543211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwsGC9QKQTLtCs75FaDogWhQBHMqAIsOgOtZEqdLRzo=;
        b=W8EuFrW98OBGgB2R4aGNd3zikw79LhOTgUkAhquV+3aL/L5J5O6Y7rnISX4BleZNwS
         UtHHqjJXp1Iwv0kRWewJcQLGLzypz0xXbb9yvnvLX/JgMPpI1dMwhpGw61rPG0mVLr1c
         OHulCdEf5ZaHH/CiFHrWH6viLuuiSx2KhtaeTOZyuV6RYtT4FaPSAwhYprcM+gXPc9lc
         xhhEIGy1d/PTj+T2abzPnftJ+mNmIHHxoykpcbJ5lS20BS9jDK3TSXltJ+5s2lM7tGsu
         vSelEfVCg3hK3ssXkUx1j7xJhPwobmgFmkW6CiyHbIoVUzEm9rl+vc7h8dkDy9thcNf0
         4gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938411; x=1760543211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwsGC9QKQTLtCs75FaDogWhQBHMqAIsOgOtZEqdLRzo=;
        b=jPS6Zzl4uhOMNzlHse1fhRZq4xfDEg0dGd9MiM2CUmTubCOSc85pzmIEZJ+0BY5+K1
         ej6G3Zhe4DfsQ8sghwg+ZJh3iXzEUXgGIkMOGSxnxCPurnCkKVISRKF1mfiRc2LK4z32
         vaTHTpUWSA2wLBRt13fX8f8JHlsP1r2bMGREN6kUekIEzd+vztxjLQe1qxoWIbh0/4uq
         /9fxBJh+wI/FRBGn/3DItUnXiAsZYAr6//9jdBjTsmePOnNVYhgi4gdOH4hbpG5iej7v
         Vj/2r9belFNHJ8rfqz69WI2ISxRQGbWgWSkV5JX29GJmEOBD84vDH5sGHwzPwGyyecjw
         Qzxg==
X-Gm-Message-State: AOJu0Yw4hNn9tSwnoe4XID7l5YcEUznI517nmF0U8tc2ydGG6nFbrPDY
	FisvIJGHqkQaxCoiMeuXFuIPl+vEyKcBZ++/o1A8RmjCDbydalmGl5FgKuV+W5M38gpIR6jgog=
	=
X-Google-Smtp-Source: AGHT+IEOgrgEpk6rF4pwgydWRRxFmyjFZR66yjaGox58gQWW/rEuccbEtdMOOvaxvGbVBzuauWSm+SmC
X-Received: from wmbd24.prod.google.com ([2002:a05:600c:58d8:b0:46e:4943:289b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e86:b0:46e:4784:cdf5
 with SMTP id 5b1f17b1804b1-46fa9a9f254mr31390415e9.15.1759938411713; Wed, 08
 Oct 2025 08:46:51 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:40 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=ardb@kernel.org;
 h=from:subject; bh=F7nm70Zr8k/vjaUwWeyRiRk62Pm6f7C9Vg0TLVgfN6E=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeNZu/6Ovtba/KtFh7eWac/6dvG0Vb6kQLLduz69rw3NT
 pfS+6w7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQ2XmT4K99b9HVftbJii5ZR
 c4K5hGTNl4tpiZ/2z5q7WVjz134VPoZfzAWPtm382KB1uL7+b8/u0pMrj5oeOh0rknX4Tqj5v2Q 3BgA=
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-29-ardb+git@google.com>
Subject: [PATCH v3 06/21] crypto: aegis128-neon - Move to more abstract
 'ksimd' guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move away from calling kernel_neon_begin() and kernel_neon_end()
directly, and instead, use the newly introduced scoped_ksimd() API. This
permits arm64 to modify the kernel mode NEON API without affecting code
that is shared between ARM and arm64.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
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
2.51.0.710.ga91ca5db03-goog


