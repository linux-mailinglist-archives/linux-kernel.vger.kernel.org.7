Return-Path: <linux-kernel+bounces-845695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA9BC5F13
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394E954129A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A952FC018;
	Wed,  8 Oct 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCu12P0x"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0512FB09C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938424; cv=none; b=JHHDVaxwv8JKuFmGCkYBJoniHZ22/r0EtQ2FvpNnww4pMSSHCpZXEU10HoFzqqc4C23vP61FpYV3PGpYFqlcYKGM1Tt5bdzwhzuqyFYr79KMYIaq63LiEH7DLFK4lUYsavucGiw07zMzcCoBpr8pNV9ogVatUifhtCtpyyQdlfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938424; c=relaxed/simple;
	bh=CY8sASFNr+cydSaRmK+XCtThWiaAY5mURJItMU/mY60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPb1VXYhTWW+//0cwJdwc3AZoplx54WKItj1tKa5v11tFKMyFLVI5h0GrihHa38DcYRr3j9ABMrQPEnLnIMueuArCAB+K66M9PfFjjNpsD75/1KQ95xD8z7wyAe1QhNIJZer9yryiH8JWskjbxxSEfk0tFOCZo1lAGMPpN2al7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCu12P0x; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so71991885e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759938421; x=1760543221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX+FOTwqwmP67LIKWGzioSokTb9JzlGhSXeNKUrBT70=;
        b=sCu12P0xd+iMvFV591zeA+TvF5mSlnq5o2NA5Hl6YD9Tlp0wji6JUcpt9vn3SgUchA
         73MWnc8WChsK9gvIZS/dobatwDaDqU83Vgb+UTsIjFf1QYVDKtFetfLtwxZ0S4v7lT9C
         Tovc/QCAvUWjUoRkkgzP/OdXGMd9hQSlDPY+hgpkmaclzw+6YGGvL6k0O7yal+IpDNrM
         T+YzVvVWTdIAPkVSL1kXn5BO90cbEv2Mo1euPa8IOins3KaT9mE170lW5bjXa3H7yXm4
         g+VnW08Dy6ytjMaRIeSuZa4vLyXLS6kiO/XZ+QsUUdd7W7MnBgQZAnGRNZ0ybPW0xzTx
         nCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938421; x=1760543221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX+FOTwqwmP67LIKWGzioSokTb9JzlGhSXeNKUrBT70=;
        b=mvK78mKZpZbE1pG0wWH29z8cZ+KRi9s4EwKC5kTOwewkBAuUs0QSv9o1oofEfoYzC9
         NWz7e3RK3nMT0jZvgYOuTKEQXHA/Hqf0wgWkVAyUoW8ANbRGPZzLaou2Qa6EkZG7Rl/I
         DJmEyzcDM/CrWfv90I/SzWOqg5lC+kd/WIcy9x6cQreTCwIUIWlKWsFwydtHc6+ewNBI
         kS7lWocgLnN5CaBj5NegtYL7EgCrxf5tK+7/845Iypd3O7Bu7hj0qL9LaFyd/u1P1I/L
         QXNc5xEF4QrZG8Kn7S5Q7NGu+GeIocIB+5tF+4sKpx5xCWV9UFfrauTz7tbaMaRkDPxy
         7Z7g==
X-Gm-Message-State: AOJu0YzLyTNFe4nkO0Uvdmp/MwUYYBpuOJ/isSGhaUtry5hLnjCaUvux
	nX7iRuMcDhfYJZ3Cg8EFRDexKfSSN5OoAXZiskunB29wummFii0GZL23UODkBj5eFC6MwFp8ZA=
	=
X-Google-Smtp-Source: AGHT+IEjiKxPM3P1jo2NCQMtIkDGka2bla0TgaKSnshbu1vw6e4DEdLUwhej0pREcTGcshyShoBFv3ri
X-Received: from wmbjx19.prod.google.com ([2002:a05:600c:5793:b0:45f:2306:167])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b07:b0:46e:1fb9:5497
 with SMTP id 5b1f17b1804b1-46fa9af84fdmr26813135e9.18.1759938420853; Wed, 08
 Oct 2025 08:47:00 -0700 (PDT)
Date: Wed,  8 Oct 2025 17:45:48 +0200
In-Reply-To: <20251008154533.3089255-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008154533.3089255-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=ardb@kernel.org;
 h=from:subject; bh=dcVJ+FEDVLktPv+MhuXF3k3ccZKN6EYdh2F7GcW5Gk4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeNZu9u/hFcu0+49t26d836RcFnpng+zf7O881h/33/d6
 eqyzCUGHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiotMY/qk+2FRhLna5uZcx
 5KXyndDC70EpWYYruRLTvz9gOn1bTZSR4eo0pYydhffVZG+Xdm4++epYQY1OzPEfXx4v1Ezvu1s UzwcA
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008154533.3089255-37-ardb+git@google.com>
Subject: [PATCH v3 14/21] crypto/arm64: polyval - Switch to 'ksimd' scoped
 guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Switch to the more abstract 'scoped_ksimd()' API, which will be modified
in a future patch to transparently allocate a kernel mode FP/SIMD state
buffer on the stack, so that kernel mode FP/SIMD code remains
preemptible in principe, but without the memory overhead that adds 528
bytes to the size of struct task_struct.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
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
2.51.0.710.ga91ca5db03-goog


