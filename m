Return-Path: <linux-kernel+bounces-839505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81358BB1C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D36019C4550
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD63112D0;
	Wed,  1 Oct 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8VIrNJ/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED7310620
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352642; cv=none; b=AY4+lFiPUKr+Ruu1k1hio0BBKHBsg4nzg1323M2ZiCFHrZgV2AicRp8Ax1iJJNXqjz30qA7EQiVo94yFQECAActAfh1Bd+YAEoQsE+U7Ea+jvc7pSP0Lcs7ZK7myspcL3gE5OaVzRv5C28PtNZINR+NI/38/pZylcNadAD8mlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352642; c=relaxed/simple;
	bh=JgomGjz8a4MC2QvV0Ypiia/XgnueJCeB/ViBoqFjfsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sRQwqFveNfASmDKi0RRfJYecxBP0OPKmGtuXlJSW2Z3UFGbc0dopI0vYrt1ONu7VL60jvm8nbrVqEGFAdZoTDPrx6TD0PS9IxbQ5Vp1v/led4Wfvu3el7yKsA77X4aa2dyqqbtTeu8GpvFLWhewKtgM576RUIF5zn42LKqIwRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8VIrNJ/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e4fa584e7so1075565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352639; x=1759957439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9XPXiALrIFv+t8yA8FOCyMwqSyC0AWzcr+6NOSN1Gk=;
        b=h8VIrNJ/VmrYYsz/GtcOwpi0Og8JENmIMPHy4XbGbP86tSCo7qB8KkI4Fy8gK3ugaW
         VUogwLnpXyQOWJnXnYYGqKdHwONZMyR7ZLDkEbXuafu2efcEcfGjsvvmJa/vBx96DyYO
         Ab22Dy0ITwtUeDBd1DFcvVOSpxnyNY1mL2OuoNVkCCYWl7aIbU/VYrGMi7l6lq6viwMV
         VaonQoAENqWA7/dJvKS3Lq3jZ02xVoJjZ1DGNcOKGZ9JFomWsuWCtD5ZYM7MV9YN2ZPp
         el8zId77cvrTOVKeb0pQ5a/0LUK6QFGeBslOl2OPoitw5vMGpzRDg02oOltrvlZ1xYpe
         mUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352639; x=1759957439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9XPXiALrIFv+t8yA8FOCyMwqSyC0AWzcr+6NOSN1Gk=;
        b=e4MhjWLR/CnsMcCkMO3o4Wt61A8mfBHlesuTDU2iDHWKDCzJDvjtmM4yYAq9U6eX8g
         gEVTY4BRZvBG/2QVmn50HWI9aZaYOFksiYRHCAhzS6+3V1zd7HVz7SmHo4IikbnwM9Js
         yXlTIDiMfVEyXCSatp2S8CncUIrPMkBoNzGrkVVNRsbocVlCZTD9gpWsHCGZEDSbV4uJ
         uIDZx4UL1lAKhYtBqLYjIpHutYmz1q/TwoJ0kZnuLLq16zxI/HG3iTYK5aNdFJPCSWSL
         d2jJjLKs5CzeqVN9AyNpXBPMlmQZ7oFQ+ng5DORi0tStRem6co5MrDKI/e+0AK6CUYt3
         471w==
X-Forwarded-Encrypted: i=1; AJvYcCXyItP+BCCcFk4+8BpelLorGXwHcOxSibSTzmJoheYi0o1/aENpfKH6/GQtofS3laemVgMdVDWXAjLVTVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBMZAilikqwX6H/hUvJ0IxmCxaKQoVFYaHkH2qKs8AKSgfqfF
	aBXt8xV1iVKI2dGGK50doZBkKAi9pRP/zr3gvjh8nVDd9J1uqtqOt37SPBW9EoyElZyiFc3hEw=
	=
X-Google-Smtp-Source: AGHT+IHiZKFz0FRSgxw7esbxI8PZwcXr45UkMRXq0q8oyZAHd/2cmjG7u/BqIWintM4Gmbm+ulYQB/Ip
X-Received: from wmcu7.prod.google.com ([2002:a7b:c047:0:b0:46e:3190:9ce])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b85:b0:46e:41b0:f0cb
 with SMTP id 5b1f17b1804b1-46e612cb765mr41091005e9.25.1759352639460; Wed, 01
 Oct 2025 14:03:59 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:09 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=ardb@kernel.org;
 h=from:subject; bh=zYFiNr/eldWQX1gt5iI0fKjxqDInIe25UpxzRqLUttk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePutBe85rrrjE9313UZy3CfWrLq8sGllfGsK2ovnFXc6
 m3AqyzXUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZS0MTI0Hh27bH1f5+ka1/h
 3LiIW9F7bdJDrp8Tcy4K3tTZdLVb6g3DP43ZXL/X7Ix7b1m3Nfm/Y/5h3sZDi0KXCneJHVugbyP CygsA
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-29-ardb+git@google.com>
Subject: [PATCH v2 07/20] crypto/arm64: sm4-ce-ccm - Avoid pointless yield of
 the NEON unit
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

Kernel mode NEON sections are now preemptible on arm64, and so there is
no need to yield it when calling APIs that may sleep.

Also, move the calls to kernel_neon_end() to the same scope as
kernel_neon_begin(). This is needed for a subsequent change where a
stack buffer is allocated transparently and passed to
kernel_neon_begin().

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/sm4-ce-ccm-glue.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/crypto/sm4-ce-ccm-glue.c b/arch/arm64/crypto/sm4-ce-ccm-glue.c
index e9cc1c1364ec..f9771ab2a05f 100644
--- a/arch/arm64/crypto/sm4-ce-ccm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-ccm-glue.c
@@ -179,11 +179,7 @@ static int ccm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 				 walk->src.virt.addr, walk->iv,
 				 walk->nbytes - tail, mac);
 
-		kernel_neon_end();
-
 		err = skcipher_walk_done(walk, tail);
-
-		kernel_neon_begin();
 	}
 
 	if (walk->nbytes) {
@@ -193,15 +189,13 @@ static int ccm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 
 		sm4_ce_ccm_final(rkey_enc, ctr0, mac);
 
-		kernel_neon_end();
-
 		err = skcipher_walk_done(walk, 0);
 	} else {
 		sm4_ce_ccm_final(rkey_enc, ctr0, mac);
-
-		kernel_neon_end();
 	}
 
+	kernel_neon_end();
+
 	return err;
 }
 
-- 
2.51.0.618.g983fd99d29-goog


