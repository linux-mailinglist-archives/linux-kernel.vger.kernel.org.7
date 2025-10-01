Return-Path: <linux-kernel+bounces-839513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A2BB1C44
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923B82A3C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95533128DA;
	Wed,  1 Oct 2025 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikrOlFDd"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743443126C4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352652; cv=none; b=qde8ummD3tGO65d26uNgI5RS5bdHoNT2f7Z3KD+pIL8N1M7aW6MfIdjT9kLYOVFwSNPNfVFvNpQRjD2jEmmQD4WZ+nRtyEUf6bYhttXm7QUm0YXGaLNI9oj6QDXJ/Z+dt1H9aQ5qfB2k1npV2vmDg8J4VWysfSFzpjpaKHYKHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352652; c=relaxed/simple;
	bh=MPr5IH6hojKeJ31wXvFwJFkUG92wHTMjnSLiOjsIPw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qJRbciBNeyYypIPwx0Rba8BlkouIYxagmczag8FwtP+QsxmwNcWzT+bvMWzh1ubfsJO3KqdYByWAHfVxWlbCYVm6VuCGp9nguSATqKP8VSG60h4GemrbjlwdYmW3PzEmhVf8/7NWwOuJCvCJjtYS2uQnla2BcY1W3yqp408+gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikrOlFDd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e303235e8so8464955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352649; x=1759957449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAysdzbuIX1TDGcwfJh6CQYboY2P1WuMxFJMLAt4CBc=;
        b=ikrOlFDdpfhLEtn5BivOx3inGLaHthDnL8TphQ1GbcqQ8WZq/6MawcOtaNrz5mrODZ
         2ySpr7D6cpTo+XPTkTpEwobGPxYUgcgr2drxFbOOxPYdmkKa+Q3yvXihs818xRMlTNNk
         fCoDDazS5ah9R7z8cDhnyE5nfGjtw7ovbtYTQX+Yfe/x5amsWCoWmELzFKV6JbRM2kDr
         IYtasZPwtXi3wbLEhgCWH9hw3I0vdJvnNdmwdt76+5m8knM+GAyGAQLWnW4wR2DY5tdF
         jvLqaXfa14TV2H1HZVhKN0eRYhAS8+4zKwiNZP58E60btFUdbo80TgvB2nFpgnnp94wf
         ZS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352649; x=1759957449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAysdzbuIX1TDGcwfJh6CQYboY2P1WuMxFJMLAt4CBc=;
        b=dw4om5MPD2anaxvoJEHOi9PQ4XFfiqPdNB+QnXMqPE58+gTEoSZD2jLYvMMLHNkByc
         MVXTLFFz9SYXfVH6T+lRiX5MifPc54TbXXP2gHRnMBjoJeCTuUnunkXPBA5Ns0k+ZW0X
         hadUtd4yeC8cla+97seFCeMcVOxmwgmHX9EYjO0jVFFLKy9kFCdhofqlXBiYM9LjNi80
         h/hsIwnAGFIsEuO5HzGya6x3vWCCPOZi4rBnulqG8yLmFcsNErIUSgYtp/LctkJbQWEq
         j8qBpGtmDm4suqbFk77Nhnso9s3i553A6RI427298j6zTjBwtp19HcGNTnAUEmxlOmMb
         pIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtBqf7JTQ17n8kYNvKRbW0HeqE5vRYYpRKF3tTGwAbrUkCB6dbZu2y5Q2DLhyn6FhO+roKs28DFgjxk7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTfFNhlgel+eLj+SkJuxWCwYjsHoz0FHHdU2KE+GvVUaekR4n
	nxN9jt2R8fODtQtvz+tkiT2ISLaNHV7msKnAAeUX3WWXfzn0wv3Ahce0Tg9SrDZ/JnUyjDd/2g=
	=
X-Google-Smtp-Source: AGHT+IEjk9J1kTCvnc61ywnt8CFYyxydvdrcsVW9hi2dTiTnWEC79fQZ8w6UNQavQPI1A42BSC/bbmAm
X-Received: from wmbz18.prod.google.com ([2002:a05:600c:c092:b0:45d:cfa4:ce19])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d1a:b0:45d:cfee:7058
 with SMTP id 5b1f17b1804b1-46e612be155mr35926215e9.22.1759352648678; Wed, 01
 Oct 2025 14:04:08 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:17 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=ardb@kernel.org;
 h=from:subject; bh=BbTS+F2Hc8gpl9Sr4HMF4TFtbcI93GDZQRNcqkbkuTA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePudC6Lped/zOCRfMt7unjXmYQ+kcVzAvhS/eemiCUfz
 t6g+T+so5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk4SGG//GN1sFvpTfVrWH9
 f3uiyOZP6mo2vN0rTN9+FCjYZLt+6SRGhtdlH6cWzU+SZXQ/xhwiOKOJ4/bkx6xftlrdcBX3Pf5 7KwsA
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-37-ardb+git@google.com>
Subject: [PATCH v2 15/20] crypto/arm64: polyval - Switch to 'ksimd' scoped
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/polyval-ce-glue.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/crypto/polyval-ce-glue.c b/arch/arm64/crypto/polyval-ce-glue.c
index c4e653688ea0..51eefbe97885 100644
--- a/arch/arm64/crypto/polyval-ce-glue.c
+++ b/arch/arm64/crypto/polyval-ce-glue.c
@@ -15,7 +15,7 @@
  * ARMv8 Crypto Extensions instructions to implement the finite field operations.
  */
 
-#include <asm/neon.h>
+#include <asm/simd.h>
 #include <crypto/internal/hash.h>
 #include <crypto/polyval.h>
 #include <crypto/utils.h>
@@ -45,16 +45,14 @@ asmlinkage void pmull_polyval_mul(u8 *op1, const u8 *op2);
 static void internal_polyval_update(const struct polyval_tfm_ctx *keys,
 	const u8 *in, size_t nblocks, u8 *accumulator)
 {
-	kernel_neon_begin();
-	pmull_polyval_update(keys, in, nblocks, accumulator);
-	kernel_neon_end();
+	scoped_ksimd()
+		pmull_polyval_update(keys, in, nblocks, accumulator);
 }
 
 static void internal_polyval_mul(u8 *op1, const u8 *op2)
 {
-	kernel_neon_begin();
-	pmull_polyval_mul(op1, op2);
-	kernel_neon_end();
+	scoped_ksimd()
+		pmull_polyval_mul(op1, op2);
 }
 
 static int polyval_arm64_setkey(struct crypto_shash *tfm,
-- 
2.51.0.618.g983fd99d29-goog


