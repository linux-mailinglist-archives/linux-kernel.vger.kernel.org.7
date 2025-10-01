Return-Path: <linux-kernel+bounces-839506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A46BB1C14
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A108D169B02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124A3115A9;
	Wed,  1 Oct 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fm5dCh83"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AF310654
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352643; cv=none; b=LcXwcWvSBblO5X+KKuyF4o9pzGJ9VIGxkxF/bCuvb44D9a7bL6GHBoEl7VxHK3awRC3cfMce7JO3YCiNAQSdVgiyB/k8xcPzGeDfqbXTj/Tn/pH/PIVnHwwxJvPhlGfGT2S1Cc/pw8fM2kFmCEhpMquReJgU3rIHjE8Yhffqw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352643; c=relaxed/simple;
	bh=+MReetO5lOEq+ENKq1vyXwob8BhS+VD/ZAqXqiNcwSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iVb8hZCKgWYJgLPI+O95vvJwVbPqAGNXrmq1YDCf34TXJoQNmRRedW7CKcYyycWYNFGlLUf8qiwWcQt2zp43QaQ+iMvKzcEkf+UAv5xTouCc823H+lWInMCj5h8r0bEhBzXgdZlcBYEAGccs2TA139qEzmwQKxIwVrgz7kQ07fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fm5dCh83; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4255d025f41so138573f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352640; x=1759957440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKVgCyEYUlEYJnl7IzVVeeoQQVhKM/SWcfJ5A7yRcl4=;
        b=fm5dCh83lLBqxcTwL72MOpunDhd7CLCknZBefrVd0m5Lc0Xhj/0cWjeaV1LEnWqNh1
         wjlfObIHEPqW038ECtx3S3egOhQ/PsqI8Y+y/ybcQGCG/SZdM4Np7QuoTIcf0fcMWLKz
         C2QnzmF/oQ60hRjMbhqH4TOSlpIZmS8H5QCfGO7yoRqN34arxl9XTmysIcDSf5vR0jzX
         N2kAfwsj47aGSM0UrRRagYoONm2aZtPRi2Yw0Tvu1q56IiqQcAYwXQzIoaMoC69dgns1
         yOlKBltbXYSCZCKiQW/EyIJAeYYdGCktVNwX+R19dhh75uCPQzWIXt3TfyaoHzCjCsGa
         ibrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352640; x=1759957440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKVgCyEYUlEYJnl7IzVVeeoQQVhKM/SWcfJ5A7yRcl4=;
        b=Z2aDU7VSwg04iTH5/eeNDCdgOHhE52rTDVbfMGOV5KwS92idO9Fez+EkgS5ONc/E4+
         QRj4p76CmErvd2jRv2fIzmn0oCqlLilM7R4vjekuMZHL6ooLeEoUuEmFJWfAY2/ecRuV
         Ojjl/djUgi4gTOVPz+lxNWTlfI2adfLt5baQHnjvQVxLW1o3kP/DXDe70QeQ4CF0LRDh
         m2RUuceAw4RiX53JL9HXzaYufHCyDRP4oOKqTgZKgYRshWaSXA7sWh/yF5ga4As6to+4
         JMNiGr7/3eha3p7UF5teVcLu/nJ7DNIY+rZ4+PLDWwB7SUFGOxRYxvLcT75xN9K7G5pC
         qt0A==
X-Forwarded-Encrypted: i=1; AJvYcCX5jBlrOPDV2dTxm/5En4XX9FVaYhm3CcHA82FFT6G1yHV3IEb/bwYBiEd7g7H8A4F328efWXVMpK3vY7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHb7InFGk84jC5M7mydOvavBM6EmbDiMpu0sLSnFLvJ4Uv2V8t
	EPC6at+hLRmCtY7KsXvePKBnFWfkrhkj4rak19hzn4Jk3fu5ad2bZTJAuBQ7eh/oprCXlruO6g=
	=
X-Google-Smtp-Source: AGHT+IHDmr/Nj33e2mS518oZ37yPaOtdq4b9XOTrdSeSEajRVgzVPmNn2xLCvIBcNV1g6wzgv51cRxYJ
X-Received: from wrge9.prod.google.com ([2002:a05:6000:1789:b0:421:8d6a:e0b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:18a6:b0:3eb:a237:a051
 with SMTP id ffacd0b85a97d-42557820770mr3555146f8f.58.1759352640509; Wed, 01
 Oct 2025 14:04:00 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:10 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=ardb@kernel.org;
 h=from:subject; bh=ibLsffhkx3eQuDIH6wng+X3cde8PFK2qiv2gBQvEgB0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePutDcHLTbs9tkZJfys9AfjVivVRQv3qXhZt9g/3VRX8
 NRJsOZvRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhImxDDf4esiwetRG6+KPnm
 dV3iVm7kOcUz9zdPjTqh5XVbccJP178M/0xnpNX4dnd6mPue5Dt550ecgevSD2vKLggFBe54s/6 hGDsA
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-30-ardb+git@google.com>
Subject: [PATCH v2 08/20] crypto/arm64: sm4-ce-gcm - Avoid pointless yield of
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
2.51.0.618.g983fd99d29-goog


