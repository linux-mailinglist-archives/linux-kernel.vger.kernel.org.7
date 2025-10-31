Return-Path: <linux-kernel+bounces-879983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B78C248E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F26A4028AA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0D348444;
	Fri, 31 Oct 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5/zcSqb"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F37346FD3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907206; cv=none; b=Tm7HmzkxvtlusPleUhEIJpe/CjDhkpBT7O8+011UnKzDDvMLt61UVtdsRBo0VOxk12bAeaGxZTMFiupwHnn5Is7XF1nlXXmxcOrNw+bZqY8m2+D8kGX9z4dDxvFXXxe16y9THomtw7sxbS6ynC5G2Y4DRRvd99W6DL1ag9zEdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907206; c=relaxed/simple;
	bh=DWK9Vv9/mhwHlh+oHiA0jTxszZXG3zdb9vfDxzgDObw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7Nsh2FUM9FDNbSBE1ZbynX68ztNWg5wAoSne2H0FtVMpocD6H8UGQChUkO5tGCcUobyFKJmjcwB6C0rysvlMtvlu+qLgr2eaB130SxpCgNd7890pq6bVIChvxNZnHHKf/7LjXokYEv0T0Zp2j13XX6pyNRcmmBedhpU/R3RzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5/zcSqb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4770e0910e4so14170815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907201; x=1762512001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E137w2jyBQdKQzJ2QNCPA5foha+2UsFo+5XbWLAP07E=;
        b=F5/zcSqbsBx++a/QC6IolSWe+wqrCCJ3luySCoqPBX/RRqufX9LXserCjLij2dcC0H
         GPylAbrtYRygl8+LBTUtJuBi8M3RToAI/Sd9NJppYQYd8oWxOlHqu3rB9BaJhjozz/Qf
         IU9wnpEwCuhgbpw52oMUTcW/s/1AIC0i0qOPnAIxbcPhxX5S1Rhb3TYMV7mT0rftB9JK
         JhuKuo1NUvVvjO+JB8rRFNQTBzVpS2275Z8uorgZFK1A47fc1P0EJRhh54A+7N+7RSVF
         8OfRj0gAz4vg/bQxDyZ1VBYf9sVqFRkC2VwRlw3C1VIjrdXDGbsGbpRSB3BYLtN+zmdS
         433w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907201; x=1762512001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E137w2jyBQdKQzJ2QNCPA5foha+2UsFo+5XbWLAP07E=;
        b=cyzc3urQYMK1zNQ7VOKMgmV4Vciq6fITdd3eQt5O3gZA6n41N69UhnXlEwbV6kcGMb
         jaEPpc0W0q/sNhJtiRYbObzKoiMjs7wVPD4XTQqXT5TEMW830q4CgFDOd0FezaPGG3+s
         AcYviwD/0lYntvphkSnaGdblL6K7qDbc5Es/6MEJ5bmMs6Jpc3nkZ4Ur0DWDbaSD+E34
         IVE6tonLqXPFjr3DdNjRBgkZGreCkFigy98FSj9O4WN6Zb1GvOOYYJbPajIO5o01pD0l
         she2K/eZObYPGtzhw1XjhkCdRc46quJQwTir4AxGfy9GjGJJaVY9BcDY+JALLDDMOmLE
         mR4Q==
X-Gm-Message-State: AOJu0YyPGrDt2ykggotfhBp9oE2aPtBFBP6zLakkXNL0GiDLgUEs9x3I
	P6p97Ww3I8Gs7sciG7gQs2FtmBe6qAY2etLKSB4rU2NRRsAw5+T1hlZaw+NKV3BpwWrYwn8AZQ=
	=
X-Google-Smtp-Source: AGHT+IGSC7lpglLVQXDhc+qETrFDrUbREN63HeHWglrMlVHBvofBu6xBm//uDsp9EQNcouOaMC5P8NO+
X-Received: from wmbgx15.prod.google.com ([2002:a05:600c:858f:b0:477:e0a:f99e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35cc:b0:475:d8f3:71c1
 with SMTP id 5b1f17b1804b1-477308be6f1mr25615455e9.27.1761907201250; Fri, 31
 Oct 2025 03:40:01 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:15 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235; i=ardb@kernel.org;
 h=from:subject; bh=BmcyRj2En4D2bqTYOu3u59S/hVwg5l7rSd12ZpuUTBI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4i3DFR/fNq1Xakt8FWTJdOhpvVsDwyGJ7E3WhxY8W
 eL7YfO/jlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAREXVGhnVfdl04dOv5V9/U
 g4f3qN4+xbZ6/aX0qa92dd2dOcdIdd4bRoYprzoDmf2F1r7MzJdLrtM6/3EWn+/hW98LH/u82rz 40ixWAA==
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-39-ardb+git@google.com>
Subject: [PATCH v4 16/21] crypto/arm64: sm3 - Switch to 'ksimd' scoped guard API
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
 arch/arm64/crypto/sm3-ce-glue.c   | 15 ++++++++-------
 arch/arm64/crypto/sm3-neon-glue.c | 16 ++++++----------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/crypto/sm3-ce-glue.c b/arch/arm64/crypto/sm3-ce-glue.c
index eac6f5fa0abe..24c1fcfae072 100644
--- a/arch/arm64/crypto/sm3-ce-glue.c
+++ b/arch/arm64/crypto/sm3-ce-glue.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
  */
 
-#include <asm/neon.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sm3.h>
 #include <crypto/sm3_base.h>
@@ -13,6 +12,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#include <asm/simd.h>
+
 MODULE_DESCRIPTION("SM3 secure hash using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
@@ -25,18 +26,18 @@ static int sm3_ce_update(struct shash_desc *desc, const u8 *data,
 {
 	int remain;
 
-	kernel_neon_begin();
-	remain = sm3_base_do_update_blocks(desc, data, len, sm3_ce_transform);
-	kernel_neon_end();
+	scoped_ksimd() {
+		remain = sm3_base_do_update_blocks(desc, data, len, sm3_ce_transform);
+	}
 	return remain;
 }
 
 static int sm3_ce_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *out)
 {
-	kernel_neon_begin();
-	sm3_base_do_finup(desc, data, len, sm3_ce_transform);
-	kernel_neon_end();
+	scoped_ksimd() {
+		sm3_base_do_finup(desc, data, len, sm3_ce_transform);
+	}
 	return sm3_base_finish(desc, out);
 }
 
diff --git a/arch/arm64/crypto/sm3-neon-glue.c b/arch/arm64/crypto/sm3-neon-glue.c
index 6c4611a503a3..15f30cc24f32 100644
--- a/arch/arm64/crypto/sm3-neon-glue.c
+++ b/arch/arm64/crypto/sm3-neon-glue.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
  */
 
-#include <asm/neon.h>
+#include <asm/simd.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sm3.h>
 #include <crypto/sm3_base.h>
@@ -20,20 +20,16 @@ asmlinkage void sm3_neon_transform(struct sm3_state *sst, u8 const *src,
 static int sm3_neon_update(struct shash_desc *desc, const u8 *data,
 			   unsigned int len)
 {
-	int remain;
-
-	kernel_neon_begin();
-	remain = sm3_base_do_update_blocks(desc, data, len, sm3_neon_transform);
-	kernel_neon_end();
-	return remain;
+	scoped_ksimd()
+		return sm3_base_do_update_blocks(desc, data, len,
+						 sm3_neon_transform);
 }
 
 static int sm3_neon_finup(struct shash_desc *desc, const u8 *data,
 			  unsigned int len, u8 *out)
 {
-	kernel_neon_begin();
-	sm3_base_do_finup(desc, data, len, sm3_neon_transform);
-	kernel_neon_end();
+	scoped_ksimd()
+		sm3_base_do_finup(desc, data, len, sm3_neon_transform);
 	return sm3_base_finish(desc, out);
 }
 
-- 
2.51.1.930.gacf6e81ea2-goog


