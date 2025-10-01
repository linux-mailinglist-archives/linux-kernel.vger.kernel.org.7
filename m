Return-Path: <linux-kernel+bounces-839504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFDEBB1C08
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0E02A6756
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7364131076A;
	Wed,  1 Oct 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1+HtXub"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0653101AE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352641; cv=none; b=kbPk6Fq9Km/Mb5i5cdYPb9lcoookJzl5/frlMBqYIUfXSZp9CnH1RC8ZHOchCkbunU0kuwi6csH6hV30zKESM2kcC58V+L3FjvpC7ouDGwjMlQJGXp/EUKd6bEsMZN2Csi8uvmlBfz1MM57y7rre9DKNEtL+UPp+rGlc4gpLMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352641; c=relaxed/simple;
	bh=G71rjTtZIaGIXR3UGbv3E5LniLfYD2qy9Arh2X+LvNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eW2cgjVXsm1jIBaYIDSRZH7JvHJZ2SYS32b/4TA/TujCFOj6X27o2HZBPVWsSEOV4QDTYZ7IEZ5S6sbf2h1wi96yS1VzQozj8EL8One8/H8h19X8CGmX2ctgHCEy6/MvoUdyTD4/pcsTF91EIT9+yjZFN3Pzz7ybdpreHHj2dQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1+HtXub; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso78701f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352638; x=1759957438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4j20MEC8Ax3r4R1mIrlpRXC+UmhNM+andOU7drpFlJg=;
        b=c1+HtXub1tsW6Ro/L61pROfXURB4H1hVBy/UvsvtwubqYow8d4Jywu4xt6S29GXX/C
         52xPUQ1o7dxEfXlf8FU8XGM6UFfTI2e52i90Ur6MAuHGq/Q317Z9ewr212k+1bkX8Ljk
         GdWjmj1rsJuUGEgcZmJmk1Fkd4dvpri6tZY5xXQYcPMzGAT37il9C+4RWej+QSe5WV5X
         Bi644UlA4m8QQtP4/1icEOc2VCvSH9QoIL0jHUZn0O3eL7oIryyguz/thA9d7L2MmwDZ
         0TBSqoJa7PqNuOZhrB/maL7kQUmpmZgNXxWqwnO3HXbHiFYV8DtgumHMF++1c4wMhheD
         Kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352638; x=1759957438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4j20MEC8Ax3r4R1mIrlpRXC+UmhNM+andOU7drpFlJg=;
        b=XO5eHMkPgGVNDxGz3gKvlkMsVQD87VmI91Q4QknmYQnna3ooBqrfrKJO7LwRml9w5E
         5aY4X8NYvmdVpluKQaWKP73Vbf1pV4P0sxiZ6QjHKFJTEcMphzJV3peEnzDtk9cC2FIa
         b2HTck83WQcNwmHUJ1MYoZRU9ionGTrZzROqIgETF+oELszhTlRXE8OtEXeXAj40Hko/
         l5Ys8Ka+m055UFIUSlbrAneK0SZzK9iNOv4YjsyDzC97JXRRAPexuSTxYclcT1QqtfK6
         YnoM4+gi+INf/OOt7XGIUnCBqldW3Gwk3iRQvmiSq2G1slmxNmYZKmzM3/9RK6G/fWbY
         zE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuGd+NHq6FyUS/Hb6pwMHcYuxNKID2b2qy/XjAwSwz2drtM3h2xxCQJrhsDoDBNAhgNT6dG6xVDiIGQRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRG7i4b3ABaX5GT88r85pFD0O871eWm5f/Vr5JwEnwFp0u9OZ
	Tkp33tBD9wu5XQlyRFcS9RhDdbGG6483niC7u699UISCpO2ULBsvqiigKHAHivLNSZS0MgF7gA=
	=
X-Google-Smtp-Source: AGHT+IEuG1RbtJ6FiwIucAXGOGuLO6+jN3odMsNV/hZ3o58B9bsNzZE7dpr8nZZ7AG2wrt76ICGCYLz6
X-Received: from wmph10.prod.google.com ([2002:a05:600c:498a:b0:46e:3d73:fc5f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:220b:b0:402:71e6:5e00
 with SMTP id ffacd0b85a97d-425577ed455mr3244884f8f.7.1759352638294; Wed, 01
 Oct 2025 14:03:58 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:08 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=ardb@kernel.org;
 h=from:subject; bh=cfu0++gxesQ+j0mFCsE0nnO6ije/EROXIJJwVNT18uY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePutMcBulsb9Sf4Rn696XB38WaDfWe15F4pq8cpdulUF
 insmBLQUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYiF8zwT73e6+Ks9K/+Zebd
 R+6sq/m6USFAcL2p+MU135V7PqktCmRk+LXMZ/6d0FIN7xxPpoX/jt5W3mGrLFV3wuGL08ZXstw XeQE=
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-28-ardb+git@google.com>
Subject: [PATCH v2 06/20] crypto/arm64: aes-ce-ccm - Avoid pointless yield of
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
no need to yield it explicitly in order to prevent scheduling latency
spikes.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-ce-ccm-glue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index 2d791d51891b..2eb4e76cabc3 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -114,11 +114,8 @@ static u32 ce_aes_ccm_auth_data(u8 mac[], u8 const in[], u32 abytes,
 			in += adv;
 			abytes -= adv;
 
-			if (unlikely(rem)) {
-				kernel_neon_end();
-				kernel_neon_begin();
+			if (unlikely(rem))
 				macp = 0;
-			}
 		} else {
 			u32 l = min(AES_BLOCK_SIZE - macp, abytes);
 
-- 
2.51.0.618.g983fd99d29-goog


