Return-Path: <linux-kernel+bounces-879969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F06C2487E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B61463E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED85340DB2;
	Fri, 31 Oct 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vcX0loCr"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C433890A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907191; cv=none; b=kBEV3IH57lasTdwk6Mh9GQuOsgBjr5Rs0RY3y0s+ZNzBKW4CvvVWpVlbi8n7vplqiqvMqOXNftoFNCVKlimwHz3W1LaXBr3RK/mvkT+6bBlCxoLdIbvsKcPmdKv6ZlVdY+cGuLbDtOaM8vWfrNVdNKmTxwzQEgksO2T59d0mGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907191; c=relaxed/simple;
	bh=YgxDh8WWdIzSNRNYvsvKvpMfpn793r2yiLb1h9a45as=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJPCNYh+Qj0TXFnJ3KeZjzeZ9wXEdvJlw61lkz2Q5E/gDv0eoUulyPr4/bRS8qXw6s+K7uvIh9POcIbzMCZAFYEcARDD3kejrcx2d/zUsVfT8QyxLyYYdL9c61pzRk11stoo6K7xJs7DR7GHbXWx/Ft/ZiBsv4gq/aeyB9tqjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vcX0loCr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475de1afec6so9779945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761907188; x=1762511988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HN/+IzS5796w6R+9DpNyrnH5kTzGCEYUE8OX1y/TT0c=;
        b=vcX0loCrubb98yyHl/WY0Qc4yplD0zlAWkivbi2UVP0Nm3IcJN7itPNpwkXSurdTJi
         1D0alpfN2qkKKINGWF+iiX9Ajp1mVUXb2yZolkHGCw9x6XEQXrC8KPdOKIJrUMnDeGK+
         Ft+uVRsxGicrdB4fQHSGu6IOZCLCZbd4QB7tPopuec9FeiPpoHVxkmT0248yeWsWfNJF
         B1+8h1bLmsg9WihGRw10tDhJ2r1wxgf5D7XAdUw2yj6++pnnw4fbfkw56KVVZzGNHY65
         YodUy/+oXPS97lqCu64RZs6MP2wuh2lu6+wxc2mzDKbXgeWw6aDgMgdbbDcgYWV0BLaH
         P1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907188; x=1762511988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HN/+IzS5796w6R+9DpNyrnH5kTzGCEYUE8OX1y/TT0c=;
        b=FhxF3PSUVe4QwzRHb0579XXTZNqo4uk0NqPbeu7vgiuqn/7obWlWroTRasIsUvKb4g
         0NmJqM26jOSubzygSBK0Kl55PALcSeCy5TRVGuFw40yE+kogzrKw6wnpJkfH6yeh7ynK
         K9pQj/gFS67SpU7VJgVT3YEqLLIw5MXee2fi3YmsCzIrxECl2pwT84ic7KQEnp2Iu3zt
         fUrM0Jkbk+NCVvBVyUv2yDJTUzFDSHrUp/JOsTVZSHE/Zw6Si50RgZLPLmkdIyXvhp5Z
         M/tJ8xid5VrUYjKPLHaV2K9Xe+IjKbqCx0VhRAzaFXU+XGPIfmDgQw6MaLdJRO7Lb2Dr
         b7Og==
X-Gm-Message-State: AOJu0Yx9gk1H2Eh0+zzW8ogOxyvMJk8uytjSRfIcR3vwuN73evW2YCci
	o+nUeJmUQR4/R5FpV8+EyhUAed1Lf2aPU2SEbs+x5jn8EFP1+LWcRXzFnBDQZzbNRPOjfTMgkQ=
	=
X-Google-Smtp-Source: AGHT+IHlmFXxc1C8TcZ+HXf8DCZ7hZ6snCdGJ0O89HH9mn+babxzm78NbK82txSCG6oBizn12pHWQ7nS
X-Received: from wma8.prod.google.com ([2002:a05:600c:8908:b0:46e:4c7c:5162])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a7b:ca54:0:b0:475:dc32:5600
 with SMTP id 5b1f17b1804b1-477262e8fd6mr49406465e9.19.1761907188374; Fri, 31
 Oct 2025 03:39:48 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:39:01 +0100
In-Reply-To: <20251031103858.529530-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031103858.529530-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=ardb@kernel.org;
 h=from:subject; bh=yjdixCt9NaDfY8u4Fm681ZNm+FKMZ22mvY7LIiuXs68=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNl4rFLr9lSCrOW7tixbpb2jXSBA2sFQ/zV59hqMJ4UW
 BvJV8HVUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYy7wHD/+A1+gVed6+eSP31
 oeHEnZUKayoiHTn2rFzct9j7W+9xWxeGP3y15UmKR/Odrh3eEr7Iwj51X+TpI87ad6Rlf32r4mF fwQEA
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031103858.529530-25-ardb+git@google.com>
Subject: [PATCH v4 02/21] crypto/arm64: sm4-ce-ccm - Avoid pointless yield of
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

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
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
2.51.1.930.gacf6e81ea2-goog


