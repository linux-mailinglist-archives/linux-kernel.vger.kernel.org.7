Return-Path: <linux-kernel+bounces-839499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B305EBB1BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7F116A958
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6130EF81;
	Wed,  1 Oct 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuEOYH/p"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABE30EF80
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352636; cv=none; b=QRY0AqGU4oLVgCtJwMRme1z2uM1m3+GrIF8gb5itY3/+GeDw4mrlhdbBKIxa+imijDglf0lni3YgCxQ0y8WVSDQ16ymYh+m/UKzcAIsUeym61XIsNc4IxcdxFnpCDf+1bfix70/pLXJ/8XySL+wl3nWe6AN7V03MSZpZ4cm2lHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352636; c=relaxed/simple;
	bh=CcSQX2utR81UxJpArQsfhwlVVaWfbrFwN0ei3ceAlxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XoP4KwJ8k38KCCFkTU4awW7kriNZXelf528hpZ8x+RDe+1ZJ/Ufs0mdBwklpdKMmLW/MW5/XbM6uQtXKO5//g7FjjHzPHiMvh2CV9DAegM1F8PWZFId/izZFLv1cxjOXX1zyVnUzGrCLyfEhqRYzBtyX9atxnbmNUr+9I//j1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuEOYH/p; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb72a8816so31997166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352633; x=1759957433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYBWVcMrL+XqSLPgxbyO6R+Pmodg0fLAvWpUbIMCypQ=;
        b=CuEOYH/p6U+1yrP2pJY7YE0I00HIXk9lxXF0ss5ginJ4/1VvcPk21DRUkQ40FQsVMf
         BW8cDvnkbvUioGf0pXs7NUPLIjqlUQsiprgXNOt5BclDCl7eGLoAm11CemuqRrlbQv/P
         OQDIbjdhe+pFk39addXymvJ+OQLZelObTzmXc1g2kf4aAD+8wsUKEzog+c11X8kS8GpP
         nif25nfnP3OixGI24GsvEYoxMFGvs8rCNQ+02cjzGUFygBmrYhK6HV+smPtOg+1thShf
         rMlE8weLt8Pemb+TTXh6pRdREOX8dOL4yz8r6gYeswfqEj25JNwaDnQar9n2Scq3SQJm
         pNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352633; x=1759957433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYBWVcMrL+XqSLPgxbyO6R+Pmodg0fLAvWpUbIMCypQ=;
        b=otNW8w2uagUqxAqidiLjtQof77LkWCCDSfFkPuIrwJvnfoBfS1yG+TmuhvYYMASeVS
         9h/a9hGKMyarIFbNHW5bLKu7wZVdAAdZBVVst5FyflT6eLYVGFgME8+5W+NwxlIXwexj
         elWI2xa0zTQWguplNp48Eeq/taFyPKcL9qXTofxyrEH6y+/xAtZg8O4UjyaIZL8Wedu1
         sjIviTIR1pIk76XnNZXMi1B80nCO4tohvFZnAYXVPoL9U098CcBlLXSDdTW6tAKH1yRE
         WlLvpdNx1XYEsxGfMVtckyrPPW/t6QDIxdXnlmQtxTvDhc7Bjl1xchsmMc9MsxDmMQzX
         CcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJe/kM7vRzhPXzidG0/nmZtJ2RhTypwW8FbZk5cfJQF7yqAM63xW0BRfAwFI32YPp9ZUGJtHcY1+QlNNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RkEd37LANcKTlVbzrRJ5ocxP8234OpE/S94AMySzJy27AMkB
	8slhnnDqLDzZs/lfJZeirQKVZuuKOjRIQyZh22YyO6qXQ35QKPcpcrHukSCk4692TP/riVg0nw=
	=
X-Google-Smtp-Source: AGHT+IHMlqwMCs9Npi3jOeY+LiGowC4953WrKZ9yJK8uSZJrjaUNV6KEIrxdClpYRueyTEYTFhCkPyP5
X-Received: from ejbwq1.prod.google.com ([2002:a17:907:641:b0:b3f:5a00:1605])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3f8a:b0:b04:3dc7:7d80
 with SMTP id a640c23a62f3a-b46e585ad3bmr632727366b.18.1759352633431; Wed, 01
 Oct 2025 14:03:53 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:04 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=ardb@kernel.org;
 h=from:subject; bh=zW/Ll9u+2fAT/Va1/PfNMYyKFzy2uIhE96GfLDmS5ew=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGjdltPIlHC+BqQZgjT+Q/Oqs9tM4IdV3oG7ERBq2+2gSCD9a
 4h1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmjdltMACgkQMG4JVi59LVyPtwD/fjev
 K07ta1hTMaGo/CMNU/2cOZDAmzhu/3WAashGtlsA/joiQcKT/3M+Pd4404SNOcFD27Upbf7uPzp TSe/KAyMB
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-24-ardb+git@google.com>
Subject: [PATCH v2 02/20] arm64/simd: Add scoped guard API for kernel mode SIMD
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

Encapsulate kernel_neon_begin() and kernel_neon_end() using a 'ksimd'
cleanup guard. This hides the prototype of those functions, allowing
them to be changed for arm64 but not ARM, without breaking code that is
shared between those architectures (RAID6, AEGIS-128)

It probably makes sense to expose this API more widely across
architectures, as it affords more flexibility to the arch code to
plumb it in, while imposing more rigid rules regarding the start/end
bookends appearing in matched pairs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/simd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 8e86c9e70e48..d9f83c478736 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -6,12 +6,15 @@
 #ifndef __ASM_SIMD_H
 #define __ASM_SIMD_H
 
+#include <linux/cleanup.h>
 #include <linux/compiler.h>
 #include <linux/irqflags.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
 
+#include <asm/neon.h>
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 /*
@@ -40,4 +43,8 @@ static __must_check inline bool may_use_simd(void) {
 
 #endif /* ! CONFIG_KERNEL_MODE_NEON */
 
+DEFINE_LOCK_GUARD_0(ksimd, kernel_neon_begin(), kernel_neon_end())
+
+#define scoped_ksimd()	scoped_guard(ksimd)
+
 #endif
-- 
2.51.0.618.g983fd99d29-goog


