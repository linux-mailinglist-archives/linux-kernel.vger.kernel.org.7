Return-Path: <linux-kernel+bounces-879970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BEC2488F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346AC464417
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8134214C;
	Fri, 31 Oct 2025 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmJOF90J"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB1322B8B6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907192; cv=none; b=fi+fTzMGDm0hSBsXJiZN+09H0V3YDyw/fCf+qQSP3ITF5Q/qCYTnF3rExgNhdSF676waPwIAzPXsfqP6vbhpRi3T9SxLUukBXspCo5TLurbZQ3jYMCaLh3JONRAbhnpAYaKaN4dnCvmx0+jQHBFabowWbQ2sfA425OFoyO9Te08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907192; c=relaxed/simple;
	bh=BJMZI7b2vwwoob2+Y/C61N/aS3PcsU16KD7zSWRIv08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i0jEJJFmKuGvNraUj4kL5ftdbmOAzDc03fukFX67+6pDaevamBYGLIJSbot6AvlDBKEvGPChcxixrsTne4QActBFg36pjF/ea3MmBGhrUz5FNd5mz5PTWTwI70g9bmQsWXoM8boIjuHxcdgO1JRyM0tIah9RHxz9zlcMzA0qmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmJOF90J; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b704635310aso198045866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907189; x=1762511989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwX5OSigI0JdbJe/ghC6Nz1Hun3Gyl+7nBcMkOknwv4=;
        b=zmJOF90J+kw76CagWPYlBFYUmEIXeEdDoZwtr5NZT8gS3XkzXcXH17rcFsR1GRGKIz
         LJGZfGEVH6vjL0OeuOGsY/eaNlP1TJhTiFU4snMFVQL3HebGhLNaJ/9aHJbKLupuVsW9
         Y7ksQ36QYxjL5ST8jaRaTujbeVLWBMDtXIcqhqZOZ0CckiSk8Jy9naU2ESl+4OGlBP5c
         T99OdxY5MDwQbGQb+W0QNt1+zfz5s/sNS5yw2pJV7WB0WJR30pXI7PO6ohFH90Vaiemk
         L4qb34g7EXyj0kfID+iM2KgFXz1DGkzTLR7QYzFtLTO8k/1oJzaCr0qi/Eg9VuIlXnJv
         lGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907189; x=1762511989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwX5OSigI0JdbJe/ghC6Nz1Hun3Gyl+7nBcMkOknwv4=;
        b=UTUOfb5YFuhZ9CmFW3f1Qchug4L1qgBUlTNlGC63MbEijIjIZHr+D0WWLMvaNwf2hD
         JBsEIymBBqVZkDeijpkB/Z47FaKu3Hp7gUtonAx73aMl96XWwGqkBCAsoprAnlqQoeIt
         i1J+aMWctqoHsUVKAAECqrv3Mx0v5LuCmbj721/MbKpvnJRxhMnScBNTVz2775IxPuI5
         jqAVGwJvHfOhnj42TMXJ8maMIJAjVcSLb15OG+8X+60gO/bHy7eBopU9CsfV2iwEKEUC
         0Dy6xloJryHw3okvEB++fw16651WdwXoq5aKNMjoAuG9UTir3KdMuAJftBAveYyUrktR
         0kBg==
X-Gm-Message-State: AOJu0Yxo+JGjPqkwLqjRkyUddJzYxzcaq8CCrwJP5V4XL0XFINyAK428
	e6VsrJk2niWFmHsb5gTnRVQr5aF3zh5dOJZwe5KRlpl7UprSD1sHHTXEPZH/zhVdtBpB4RN+mg=
	=
X-Google-Smtp-Source: AGHT+IG2w9Vi0qrSdd2t9CIYM3Jx8PEua5OuP5pZQSuAoghiP0ZDJ01QHeEVRbAeOEHa+k//Ah65fYrH
X-Received: from ejbmd20.prod.google.com ([2002:a17:906:ae94:b0:b6d:5fc2:65ea])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7241:b0:b40:e7ee:b5ec
 with SMTP id a640c23a62f3a-b7070845975mr319361266b.59.1761907189198; Fri, 31
 Oct 2025 03:39:49 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:02 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=ardb@kernel.org;
 h=from:subject; bh=HLMA/w9qPUHfG22juJFC8tVZVVYrXXnkL8gtOvgDLHg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4vGA/peW+wtXBbVv7Dpsf1jj5lGGQqNs5jdprn94z
 b5wBnzsKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPJnMnI8LL7+4pN6kEvdOb1
 bjocqLR//fHEVdcE4yWCrAU2iy2Yp8zIsCdvqadSueE7XuVPQucX/n3y1+LMi9Bv9y+1n33y/2X KbEYA
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-26-ardb+git@google.com>
Subject: [PATCH v4 03/21] crypto/arm64: sm4-ce-gcm - Avoid pointless yield of
 the NEON unit
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Kernel mode NEON sections are now preemptible on arm64, and so there is
no need to yield it when calling APIs that may sleep.

Also, move the calls to kernel_neon_end() to the same scope as
kernel_neon_begin(). This is needed for a subsequent change where a
stack buffer is allocated transparently and passed to
kernel_neon_begin().

While at it, simplify the logic.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/sm4-ce-gcm-glue.c | 25 +++++---------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
index c2ea3d5f690b..8f6fc8c33c3f 100644
--- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
@@ -154,36 +154,23 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 	if (req->assoclen)
 		gcm_calculate_auth_mac(req, ghash);
 
-	while (walk->nbytes) {
+	do {
 		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
 		const u8 *src = walk->src.virt.addr;
 		u8 *dst = walk->dst.virt.addr;
+		const u8 *l = NULL;
 
 		if (walk->nbytes == walk->total) {
-			sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
-					       walk->nbytes, ghash,
-					       ctx->ghash_table,
-					       (const u8 *)&lengths);
-
-			kernel_neon_end();
-
-			return skcipher_walk_done(walk, 0);
+			l = (const u8 *)&lengths;
+			tail = 0;
 		}
 
 		sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
 				       walk->nbytes - tail, ghash,
-				       ctx->ghash_table, NULL);
-
-		kernel_neon_end();
+				       ctx->ghash_table, l);
 
 		err = skcipher_walk_done(walk, tail);
-
-		kernel_neon_begin();
-	}
-
-	sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, NULL, NULL, iv,
-			       walk->nbytes, ghash, ctx->ghash_table,
-			       (const u8 *)&lengths);
+	} while (walk->nbytes);
 
 	kernel_neon_end();
 
-- 
2.51.1.930.gacf6e81ea2-goog


