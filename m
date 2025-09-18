Return-Path: <linux-kernel+bounces-822145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2574B8328C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969434A6BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAD2DECC2;
	Thu, 18 Sep 2025 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua7Zczlj"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6992DAFB5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177374; cv=none; b=gcUhwOR+vsLf3Xv//oZBjLUsArzLwzZWkJ3VTxSxh4fLbu52EOTXx7OZJEZG/zE8Z1gORkYi3MX0B9PIHEaIUcIdG8IeLeuGf5joMGtxC/YMchPydyLgp8HyTYolmQ3lcdPNT9xul7hDFk8YC0wTH6CDsPz2iyl3HqdMA3d8kUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177374; c=relaxed/simple;
	bh=2l669OT1VVHx2cj5ILqnp92BauRxbLKh1Xc2uacpqlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZIz6iVufC8f+utcfWjf/j7NoMyQdE8fvTw+D8cDJAjXk99jywWOt4emDJGNpb0JfYbIuurnVaQwwqZEPvhJykH8kHcIJ34CT5ZmhA2kV2vnXkCuAj5EGXQJIjH9gUvAM8s52feCvEVLvxtn8PMK91nUM/HMrNwbBDyHec0Jk5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ua7Zczlj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45de5fdda1aso2730595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758177371; x=1758782171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8Z9iG9ZM/mOKO9yo1YmJm8M5BUfmaBw3dfvTInzj84=;
        b=Ua7ZczljHktTBPnjoWO2gbrsfbn6g2xTTb/V6XtxUYr7ILpGzphXlIEgysWli823v2
         bJ1ak5e99cmxbC7DhXHe9Ypjp+Avw2cjSnu7XLKXuvXyxMjNPdd14z68kSMAp6qJhWyO
         bazyAyJZ76ChJIvdi1X1Uuew5xnboAwzc5agbnv2RL2nJdWgxaYdBUh0EwGKoEKWh2JG
         w/JQQ1c/DB+DS1J21w+Urj4DTU8o2bsH4509S9ifYTwYLNG6YGe0fkjGCcyq3zVrON4y
         Ys2HMEFMbSPqETfLgKhLd2jWzuA8/kDG/gnSqvLymUBTBkiOso+8jKdtic6AIv4c0iIw
         qVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177371; x=1758782171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8Z9iG9ZM/mOKO9yo1YmJm8M5BUfmaBw3dfvTInzj84=;
        b=RB1qtm7WM5uDud7tiBbyriLWxnaFQpEQjgPRbndP2EJW67lbkShVy5Qtu5XPHbDz0J
         zs7qgvWdFf7hKpeQDZwjq2CLNwEyXc6SXRiKKlGFrjmSiEbBH7/qU6ljsDTRxrUx8p+x
         rELdvROiUeX/Fdq1uxmklWosGGLDwc2UdawFGMWf51+IsIF1gSAvfXTJjQejmu+tBjru
         xyIpprVqUOVfxqrRgZzqYz1866eIUTsSgWqZgDvQbb9kpsq1ycFT620edzbEwKEshAZS
         cSnkiEBKpZdO0vs+79u5AcDqZD9EUvRIwuAcWVFv6/VooprVSMY7kH0tJgNlJIDwx+ij
         zMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgywcEEQob52l+GQYOPGlAmKn46wk9GmJbO5RkIQuwS4pPt+kOQ0hX/jkidq96BmlNuPPn2HRh2QB5scU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAHogZGs/s+iYjVwx7nZ+u0TqRRGkCvAzNLY91rPGgiO5J8Ct
	6Jc/2bbKsadC+hz3Rm9Jw4VP2mZVu2ndYSkkT3VElAwfO2PSTkz08NmDE7lRndm91pdBLITq2A=
	=
X-Google-Smtp-Source: AGHT+IHxBAKGYkR61gqu3o/eZtme4C7mY2byQeaaeuydCfPZf2Zi8C+SYZvLGQxjBgBDO7fwzsRPKVL5
X-Received: from wmbei6.prod.google.com ([2002:a05:600c:3f06:b0:45f:2b4d:3c2b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:adf:fcd0:0:b0:3ed:e1d8:bd73
 with SMTP id ffacd0b85a97d-3ede1d8c23amr1247837f8f.57.1758177370889; Wed, 17
 Sep 2025 23:36:10 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:35:43 +0200
In-Reply-To: <20250918063539.2640512-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918063539.2640512-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=ardb@kernel.org;
 h=from:subject; bh=NpGBicW7ecuYgImi2Z4C0oMoJDuRSNpKAibFeYN1DS4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0Codcfb8dR3+tWDl7z4OeX7N+7mBZfqpUzlRu0Z2Eg
 N0RjsfjOkpZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE1rkyMqxy3Z108I3FPy+T
 55nvPez/shUk+fnvlZowfxqX4PIFXEAVz7wF1pwVaTiwZrrgxZ7Zynsi8h5NFTE72c94dlHL5Y9 R7AA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918063539.2640512-10-ardb+git@google.com>
Subject: [PATCH 3/5] crypto/arm64: sm4-ce-gcm - Avoid pointless yield of the
 NEON unit
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Kernel mode NEON sections are now preemptible on arm64, and so there is
no need to yield it when calling APIs that may sleep.

Also, move the calls to kernel_neon_end() to the same scope as
kernel_neon_begin(). This is needed for a subsequent change where a
stack buffer is allocated transparently and passed to
kernel_neon_begin().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/sm4-ce-gcm-glue.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/crypto/sm4-ce-gcm-glue.c b/arch/arm64/crypto/sm4-ce-gcm-glue.c
index c2ea3d5f690b..170cd0151385 100644
--- a/arch/arm64/crypto/sm4-ce-gcm-glue.c
+++ b/arch/arm64/crypto/sm4-ce-gcm-glue.c
@@ -165,26 +165,22 @@ static int gcm_crypt(struct aead_request *req, struct skcipher_walk *walk,
 					       ctx->ghash_table,
 					       (const u8 *)&lengths);
 
-			kernel_neon_end();
-
-			return skcipher_walk_done(walk, 0);
+			err = skcipher_walk_done(walk, 0);
+			goto out;
 		}
 
 		sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, dst, src, iv,
 				       walk->nbytes - tail, ghash,
 				       ctx->ghash_table, NULL);
 
-		kernel_neon_end();
-
 		err = skcipher_walk_done(walk, tail);
-
-		kernel_neon_begin();
 	}
 
 	sm4_ce_pmull_gcm_crypt(ctx->key.rkey_enc, NULL, NULL, iv,
 			       walk->nbytes, ghash, ctx->ghash_table,
 			       (const u8 *)&lengths);
 
+out:
 	kernel_neon_end();
 
 	return err;
-- 
2.51.0.384.g4c02a37b29-goog


