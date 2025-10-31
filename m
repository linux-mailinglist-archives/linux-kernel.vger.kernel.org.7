Return-Path: <linux-kernel+bounces-879977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48FEC248D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F632465F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD47346791;
	Fri, 31 Oct 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBj9iP6Z"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7A3446D9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907199; cv=none; b=HrKd0zCt1Em26Y1H1vTcvWoSs6dj97hmMR7tF75GVu76HktvnZCaJWs9O0JdJE9fKTARAhTIQT4ORjyzCtuStYQ211V6DhC1uWw2fJI51Ni3ykqyHWYV+lgRQO0OUlNaYBE4Aut63e5Ydkf9Zl1DRvW85MhTJFwnORRG99hlW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907199; c=relaxed/simple;
	bh=Mt817fVHl1ncEn/trrFurKYEXgvjGDzS5+4EPDmK7xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QIH+l71WjHxE+sTLscKVRSg5YQynDKbA/mq7RRdOMsefpl7LfejpQiUQP9dB7FBCd+clb9xPAmqsQ85WAqZhRgCihYTFZLtRewQWFzUCrMZq8tKfQ0Q4y1ybXUEs98iRMOxKQKrTl8i5zRoXxWLRqw5CGp0i8HZRSb07P5qtRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBj9iP6Z; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429be5aeea2so380984f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907196; x=1762511996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SwJrIr6U1+pVeLDI8b/Z90ePApGArR/MfORdKx+bA8=;
        b=WBj9iP6Z/aizR0R7QCX+5xx7Zs6sv4DCgzpczr3k/iiSK9tz48XqJGZ5IMc+DwmpWo
         12XkiVA+zdz5YlVsAhFZSSpQJNpqhAnDk5irTzc/domazh2DWV+A7kgZ2B5NeH0o4UQv
         11U5Q33Kk1qn8dADhOuNRFhuFg5v8sSPTZH/zus9vDn4UFX3pMzkTpnpHk0D+MrITcoT
         65yxXXdmgmkHSGBmDSes4MckRio1izuSEs4T7LxVLOWBCxOj9sM2938HQV0YDf4YIlmo
         5Ur6r3185g2HhhbJGh2XO+oYYv3tIQ0NegEulhW1A6gc2fwHpv0LJ4pKLKdEqUWt+Mvr
         SuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907196; x=1762511996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SwJrIr6U1+pVeLDI8b/Z90ePApGArR/MfORdKx+bA8=;
        b=Vn6xsMiDptwa9RQ9GEr9a1gCD/zg77jhLG6I0tshhgVIRb/hxsHKXsMyeCIETdnaTz
         8W11RChrJGdSZHfS4Jlz/EmGODT1wxWDEqKm3mYV3D+4GT3KvaoFotdiEX8KWqAIq9d3
         o2R8dB8axE7ZBNbokh+Kwn0nDH5daSHcJEL8T15in39npkx53YFDj/IOUNfKymGL7lQM
         UzzRs2kiwlyDbc9u4WCKxVZ0YmPuV2xisTx7Na+e9dLmvyJp4P6v9Ky4bAcWPXq1et96
         6Dkg9IMFZUadL3fQganefH5nY8agO4qNkgwbEt7fCFVNuQdlHoMM+JneH5v3kOK3YolP
         WBAQ==
X-Gm-Message-State: AOJu0Yze1ZkAnLBQzrDS9mF9599xJWno8/wBJuTcxVbXAif4mVgZE6Vx
	cD0QsK7Nc5FU9+/KFjtoS0fQGlbDxUVqbhF/fDNiiQ5KtdaZ4IyFnBYSKa4/XMPsudUwR/RYjQ=
	=
X-Google-Smtp-Source: AGHT+IFMY96nZKFh7zEZwtP6yze2D7QGtPE/U4QgTFRH0L770EQGt27hCpp9UjR+jUWQd0JcGD6pkpoY
X-Received: from wrbdz17.prod.google.com ([2002:a05:6000:e91:b0:429:8bd5:a979])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4382:b0:429:bd09:e7b6
 with SMTP id ffacd0b85a97d-429bd67245dmr2637319f8f.10.1761907195978; Fri, 31
 Oct 2025 03:39:55 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:09 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4882; i=ardb@kernel.org;
 h=from:subject; bh=vWH74Y94585NgOqf0h7A64VGzkAz8Q+4d31ezTbmH+c=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4kWG1Tv6ni+dXPjVf5pkyIGK7c4rL1vsmm+dyxXTa
 KDjEHyvo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWwIF6cATOS3MiPDj+roXWqWpraFilwP
 eON+TMnYP1Hi99MlH6tnMi+cf63/McMfjttR+uu+L2tYHTR989KnLsKr6/tUGZ/2V53O3Xvs7cM v3AA=
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-33-ardb+git@google.com>
Subject: [PATCH v4 10/21] crypto/arm64: aes-ccm - Switch to 'ksimd' scoped
 guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Switch to the more abstract 'scoped_ksimd()' API, which will be modified
in a future patch to transparently allocate a kernel mode FP/SIMD state
buffer on the stack, so that kernel mode FP/SIMD code remains
preemptible in principe, but without the memory overhead that adds 528
bytes to the size of struct task_struct.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-ce-ccm-glue.c | 135 ++++++++++----------
 1 file changed, 66 insertions(+), 69 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index 2eb4e76cabc3..c4fd648471f1 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -8,7 +8,6 @@
  * Author: Ard Biesheuvel <ardb@kernel.org>
  */
 
-#include <asm/neon.h>
 #include <linux/unaligned.h>
 #include <crypto/aes.h>
 #include <crypto/scatterwalk.h>
@@ -16,6 +15,8 @@
 #include <crypto/internal/skcipher.h>
 #include <linux/module.h>
 
+#include <asm/simd.h>
+
 #include "aes-ce-setkey.h"
 
 MODULE_IMPORT_NS("CRYPTO_INTERNAL");
@@ -184,40 +185,38 @@ static int ccm_encrypt(struct aead_request *req)
 	if (unlikely(err))
 		return err;
 
-	kernel_neon_begin();
-
-	if (req->assoclen)
-		ccm_calculate_auth_mac(req, mac);
-
-	do {
-		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
-		const u8 *src = walk.src.virt.addr;
-		u8 *dst = walk.dst.virt.addr;
-		u8 buf[AES_BLOCK_SIZE];
-		u8 *final_iv = NULL;
-
-		if (walk.nbytes == walk.total) {
-			tail = 0;
-			final_iv = orig_iv;
-		}
-
-		if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
-			src = dst = memcpy(&buf[sizeof(buf) - walk.nbytes],
-					   src, walk.nbytes);
-
-		ce_aes_ccm_encrypt(dst, src, walk.nbytes - tail,
-				   ctx->key_enc, num_rounds(ctx),
-				   mac, walk.iv, final_iv);
-
-		if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
-			memcpy(walk.dst.virt.addr, dst, walk.nbytes);
-
-		if (walk.nbytes) {
-			err = skcipher_walk_done(&walk, tail);
-		}
-	} while (walk.nbytes);
-
-	kernel_neon_end();
+	scoped_ksimd() {
+		if (req->assoclen)
+			ccm_calculate_auth_mac(req, mac);
+
+		do {
+			u32 tail = walk.nbytes % AES_BLOCK_SIZE;
+			const u8 *src = walk.src.virt.addr;
+			u8 *dst = walk.dst.virt.addr;
+			u8 buf[AES_BLOCK_SIZE];
+			u8 *final_iv = NULL;
+
+			if (walk.nbytes == walk.total) {
+				tail = 0;
+				final_iv = orig_iv;
+			}
+
+			if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
+				src = dst = memcpy(&buf[sizeof(buf) - walk.nbytes],
+						   src, walk.nbytes);
+
+			ce_aes_ccm_encrypt(dst, src, walk.nbytes - tail,
+					   ctx->key_enc, num_rounds(ctx),
+					   mac, walk.iv, final_iv);
+
+			if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
+				memcpy(walk.dst.virt.addr, dst, walk.nbytes);
+
+			if (walk.nbytes) {
+				err = skcipher_walk_done(&walk, tail);
+			}
+		} while (walk.nbytes);
+	}
 
 	if (unlikely(err))
 		return err;
@@ -251,40 +250,38 @@ static int ccm_decrypt(struct aead_request *req)
 	if (unlikely(err))
 		return err;
 
-	kernel_neon_begin();
-
-	if (req->assoclen)
-		ccm_calculate_auth_mac(req, mac);
-
-	do {
-		u32 tail = walk.nbytes % AES_BLOCK_SIZE;
-		const u8 *src = walk.src.virt.addr;
-		u8 *dst = walk.dst.virt.addr;
-		u8 buf[AES_BLOCK_SIZE];
-		u8 *final_iv = NULL;
-
-		if (walk.nbytes == walk.total) {
-			tail = 0;
-			final_iv = orig_iv;
-		}
-
-		if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
-			src = dst = memcpy(&buf[sizeof(buf) - walk.nbytes],
-					   src, walk.nbytes);
-
-		ce_aes_ccm_decrypt(dst, src, walk.nbytes - tail,
-				   ctx->key_enc, num_rounds(ctx),
-				   mac, walk.iv, final_iv);
-
-		if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
-			memcpy(walk.dst.virt.addr, dst, walk.nbytes);
-
-		if (walk.nbytes) {
-			err = skcipher_walk_done(&walk, tail);
-		}
-	} while (walk.nbytes);
-
-	kernel_neon_end();
+	scoped_ksimd() {
+		if (req->assoclen)
+			ccm_calculate_auth_mac(req, mac);
+
+		do {
+			u32 tail = walk.nbytes % AES_BLOCK_SIZE;
+			const u8 *src = walk.src.virt.addr;
+			u8 *dst = walk.dst.virt.addr;
+			u8 buf[AES_BLOCK_SIZE];
+			u8 *final_iv = NULL;
+
+			if (walk.nbytes == walk.total) {
+				tail = 0;
+				final_iv = orig_iv;
+			}
+
+			if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
+				src = dst = memcpy(&buf[sizeof(buf) - walk.nbytes],
+						   src, walk.nbytes);
+
+			ce_aes_ccm_decrypt(dst, src, walk.nbytes - tail,
+					   ctx->key_enc, num_rounds(ctx),
+					   mac, walk.iv, final_iv);
+
+			if (unlikely(walk.nbytes < AES_BLOCK_SIZE))
+				memcpy(walk.dst.virt.addr, dst, walk.nbytes);
+
+			if (walk.nbytes) {
+				err = skcipher_walk_done(&walk, tail);
+			}
+		} while (walk.nbytes);
+	}
 
 	if (unlikely(err))
 		return err;
-- 
2.51.1.930.gacf6e81ea2-goog


