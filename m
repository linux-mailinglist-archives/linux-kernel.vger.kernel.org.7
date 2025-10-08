Return-Path: <linux-kernel+bounces-845686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDFBC5DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9EF1890896
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC02F9DAB;
	Wed,  8 Oct 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzflwAAQ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77D2F83D2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938414; cv=none; b=lljs/yIH2B6Tqqr1BLPV6JvXMqwZparEyTt8FZb6fxTbZ7mcAXkXjgqj7eaRmQmm4i7tA/i/nrVywVw/2n9JRVfUiyGw/f31fmp1x6SBaBDBntBeC/YTzIREIL+U4Kk2C5tGH4xXBJVtjeCyzrwgcdlG+C+aA9le0NxTsu6NftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938414; c=relaxed/simple;
	bh=KEvq8fCT/mr/NUx3/4WNfXk1AMS/oERIC+y51xl/09U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eABrQIrxY8KtmTritD/nkXpQ10WJWWe+uXhqrR/AGrWynPnO76st/LYF8xKyNnJKmZEAA2mF0vVpmJXJ+gYvcrjPP3BQXFcmeONJkZ9Eip6RW336j3ixottuAMI5ltS7NPpwQgGvjy+Lvyp53PSp/LPrVrsacHt7JBvsnl+oWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzflwAAQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e3ed6540fso516455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938410; x=1760543210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6qU4dk91tAr2/hjLbeesrEFLeALQh619b79NXK4nw4=;
        b=CzflwAAQzAxqgCUjQWwomtSIHV3T3BQwxQhKyFzP0XZIrtCWMNdpKeOB4WndK9sz/e
         GhEWP+AdMbyhPRpPgY4rYEpcaRQ2b4fqWDY8qTIRZzIlB+ijqoM8jq6/Pj9OEV5P8d3q
         a9GlbOxO8PPn8zlBZ3aknRRl0eS/Z6BfuGlGLeUmR6/YlTZMcblglsW1s9riYSjR9/Xs
         yoyp7TmbnkqMd5qMH+26xrq4x1nIDN/FqLqxaHqSihyyvJVKY7wO4Rhtcu7uprr8eLQo
         pe8r34MMGdXF33amy/At27anz8MF+QZXTzfWaqecL8j9yMg8oyl9j4Awpu4q9S0d3wvf
         E9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938410; x=1760543210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6qU4dk91tAr2/hjLbeesrEFLeALQh619b79NXK4nw4=;
        b=guyC90IS2T6wCrra+dR6EftIGyEYPBys/cuNshd8aFD/PL4RwxPp5sADfpg99r8F1s
         pAny0tiE3anUcPF3acR43XP0c/bAh/67BcL8gMs8mx+jcxrf/t8HruvYPSo5zOyNR/Zx
         CXV0eZa7rDsRE4xAe9Ow7/G8xwz8KQCJAsZEy19NwZdDGbufqqgREe+2RSnAcfBM2VGj
         NJPsfrqdBSIT7i7YpNG3aCppv1PY9r3yjQQnqTssT/ANG0uw2mN5q5M5fydqX7mRVjA4
         NPcOtVZALvooq8phoJm0tlKGXPWyWRCOpYD1T/9Nz3Z1aoOGpFB3FHUs/2UbZ0glLC8U
         s83A==
X-Gm-Message-State: AOJu0Yy5ofV3kywzLci8usFruOFgO1KgL7L0JZuAa0lnWWdOPXRATw8/
	e7dKllfFvlAKbz4prarYGTidVxI9JgBGMQ2BJdtXf5JhRvj1mVP6O45s2QN2TqFhsc88UxDyYQ=
	=
X-Google-Smtp-Source: AGHT+IFgQd+cxAsEksCTNK8/LMhLr7VTFVSm/ymPavO/ZmIgqUdl9TlX+DTaPdHycCZ8dWC8FxaOxcb1
X-Received: from wmby11-n1.prod.google.com ([2002:a05:600c:c04b:10b0:45f:2be0:b17e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d9e:b0:46e:2815:8568
 with SMTP id 5b1f17b1804b1-46fa9ebe0dfmr26954295e9.10.1759938410501; Wed, 08
 Oct 2025 08:46:50 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:39 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=ardb@kernel.org;
 h=from:subject; bh=03C5PCob8A/RgOeAQHX/4ZCOM9qpxWhAP4TBfsL5DQ8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeNZu67vx5bzQuJBJ9VNz8z77964fOkps5iNBqHnH35iW
 FNVeKyro5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEfSrDH/4Xk6WsfxU6r3kX
 4aVd5JkRbTaTSd1xptHVuhknJe8+PMbwP9hcNNXGOvjmNMd69f/504wueGtfWLcnMH7vf2vbg56 K/AA=
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-28-ardb+git@google.com>
Subject: [PATCH v3 05/21] ARM/simd: Add scoped guard API for kernel mode SIMD
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Implement the ksimd scoped guard API so that it can be used by code that
supports both ARM and arm64.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/simd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/simd.h b/arch/arm/include/asm/simd.h
index be08a8da046f..8549fa8b7253 100644
--- a/arch/arm/include/asm/simd.h
+++ b/arch/arm/include/asm/simd.h
@@ -2,14 +2,21 @@
 #ifndef _ASM_SIMD_H
 #define _ASM_SIMD_H
 
+#include <linux/cleanup.h>
 #include <linux/compiler_attributes.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#include <asm/neon.h>
+
 static __must_check inline bool may_use_simd(void)
 {
 	return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && !in_hardirq()
 	       && !irqs_disabled();
 }
 
+DEFINE_LOCK_GUARD_0(ksimd, kernel_neon_begin(), kernel_neon_end())
+
+#define scoped_ksimd()	scoped_guard(ksimd)
+
 #endif	/* _ASM_SIMD_H */
-- 
2.51.0.710.ga91ca5db03-goog


