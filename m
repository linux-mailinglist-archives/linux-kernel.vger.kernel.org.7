Return-Path: <linux-kernel+bounces-845683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C69BC5D75
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A357119E4D64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81C2EBDF2;
	Wed,  8 Oct 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEwFH1Kx"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365429DB9A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938410; cv=none; b=sJ2rqAKrGcwRQvQ7XXyxuLX+RV0P1wX82M4NG14dNRp5tskdA6kRkM5+IT/JvRUTfZS67WP1ynnBMVjzep+OPNodh+vlBfFb+z+7mHQux1RysxHTfQrOdz6y00HTSmq+hM9YwtPgRonsTKpcB/tyrnPhqwwBJJvgA3bot5WH3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938410; c=relaxed/simple;
	bh=81RCAUhzxGVASsLN/Sj+xtc3cF0rIGFNTxe2ppMxs6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uptxwk250W/W1lj0Ej2qyIB9Oh+7mDSyEJ88+s+cydvQoNX/MOUTij9rgNEkyR5Jek0T7t2SEm2MoclTFDcNgOQy44zEmmFF8/UErcDeq31irHq46ID0rSeXNJursZfn7p3NBHpnkfqeubWpQE3oQ5tiHUU1T0CFY7hw7zAw5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEwFH1Kx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6232f49fc79so8748385a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938407; x=1760543207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0aOpjZgoFTagPU2U7+lhs7TWsUUBL3VjC18ylyP94Gs=;
        b=OEwFH1KxTvKNXc9bq+YswcwfENtIULETZ1TtiVs3cm+YpI895pHJ8rc6WCwYr5J5ts
         Xfr+cokOHdl61V7X9KujDAzdEN8NjLI8Jr1yfmdKbq9N5N6PmCFb31FxvcmX92b+Yh1A
         mo09X4Utq6DBsT/XTWpBDGXd9wbC/9TBhUcga9cgApie2B8c5ZdeGuG7tkeLzTcL5BM3
         8xRnwxAEhmC7VKA/Y0vvfZB/6a9DaUgoXeVJlw4ZZl6f1x5XEzWNGhM0BWLOl2XQCBIx
         rkEj0PLYfJ4NnbPVMBFByMQFORrMEuTNUMuU5OTIc9dYC2A2NNTApea1w++3swzuQphR
         b6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938407; x=1760543207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aOpjZgoFTagPU2U7+lhs7TWsUUBL3VjC18ylyP94Gs=;
        b=KQsXUQyQsNOjcZDzxaAnfYf7Cq6B0s4Ta4fAXDmuc6QOA/KHomAzGX3/qW4jiixlKs
         PZta6MWcOowNXYg+4jXh6sf7+LhXgW+ltrvzwjSdaVuWKrdto8nNXfBYmfQX1nWrjZG6
         Jas5/II/8Mbwc3j4l1bmPlshbvO2aChlJJHJzYBSJ6FDc2KNle7jOHNdI3p0tgb5fmpF
         xG2xahVlg6L3PRyRB68FiN0RPYI2W0DDYYvfCugFDIjtL1dtvC3MiUG3tQTOWiWdh9Mn
         5CV639J2Gczjk017ugoMiNmnsMVdiQ6co0cFQ2fN11IokzONAzCVAIYbP+0OoGaudUDK
         3ymQ==
X-Gm-Message-State: AOJu0YxiFzBzmhDwDpa0xh9N4RiHMVF/Ox5BWewxbn77GrxgOAnGd39Y
	bbQ8mpYPAcQ1DDhiDWLqexmGrd8tqr1JLnW7kCssuRVsVt8N87u8OEzb/IY+cYkfSYNH0yS9bA=
	=
X-Google-Smtp-Source: AGHT+IEjXfSRLqs1LdB6T1FDKUwIpLPy5cDnenPLXjF2fx7wJgZU+J3eEdql/LMEKYHPQ3roG7kHp6XU
X-Received: from edzh6.prod.google.com ([2002:a05:6402:946:b0:637:87fb:3b14])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:518a:b0:639:6bc8:c7bd
 with SMTP id 4fb4d7f45d1cf-639d5b89335mr3498965a12.15.1759938406837; Wed, 08
 Oct 2025 08:46:46 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:36 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=ardb@kernel.org;
 h=from:subject; bh=j9GSsyZWNvCHsZ+73xBchQmAL5ZAXeZZs4NWX80DqD8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeNZu8rfJAkfjdO/9vefY02Zc5ad2+qC2S4lbn8HkaMf6
 6Lv5f/qKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZbcXwz5j/pePnsrXLRIR8
 Hq0oNPfN4NuQPeX7guViSn0WLx5O92L4n2s8Y/Yhht5nll/sv2RFRi8UzXQ75xt2sXyZqpx+ilA yAwA=
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-25-ardb+git@google.com>
Subject: [PATCH v3 02/21] crypto/arm64: sm4-ce-ccm - Avoid pointless yield of
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

Acked-by: Eric Biggers <ebiggers@kernel.org>
[ardb: Simplify convoluted logic]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/sm4-ce-ccm-glue.c | 25 +++++---------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/crypto/sm4-ce-ccm-glue.c b/arch/arm64/crypto/sm4-ce-ccm-glue.c
index e9cc1c1364ec..e92cbdf1aaee 100644
--- a/arch/arm64/crypto/sm4-ce-ccm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-ccm-glue.c
@@ -172,35 +172,22 @@ static int ccm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 	if (req->assoclen)
 		ccm_calculate_auth_mac(req, mac);
 
-	while (walk->nbytes && walk->nbytes != walk->total) {
+	while (walk->nbytes) {
 		unsigned int tail = walk->nbytes % SM4_BLOCK_SIZE;
 
+		if (walk->nbytes == walk->total)
+			tail = 0;
+
 		sm4_ce_ccm_crypt(rkey_enc, walk->dst.virt.addr,
 				 walk->src.virt.addr, walk->iv,
 				 walk->nbytes - tail, mac);
 
-		kernel_neon_end();
-
 		err = skcipher_walk_done(walk, tail);
-
-		kernel_neon_begin();
 	}
 
-	if (walk->nbytes) {
-		sm4_ce_ccm_crypt(rkey_enc, walk->dst.virt.addr,
-				 walk->src.virt.addr, walk->iv,
-				 walk->nbytes, mac);
-
-		sm4_ce_ccm_final(rkey_enc, ctr0, mac);
+	sm4_ce_ccm_final(rkey_enc, ctr0, mac);
 
-		kernel_neon_end();
-
-		err = skcipher_walk_done(walk, 0);
-	} else {
-		sm4_ce_ccm_final(rkey_enc, ctr0, mac);
-
-		kernel_neon_end();
-	}
+	kernel_neon_end();
 
 	return err;
 }
-- 
2.51.0.710.ga91ca5db03-goog


