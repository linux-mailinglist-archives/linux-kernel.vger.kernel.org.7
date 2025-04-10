Return-Path: <linux-kernel+bounces-598352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E52A84535
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662E51B677DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24F228D849;
	Thu, 10 Apr 2025 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wEUtSqcq"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8828D82F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292522; cv=none; b=lCnaVozPrQinplTsZ3XlylC6KB7lxWhdpwE2ZW2fyv7Kg1/tLI+Zq0xnbLyYjwBTaPtqe/L3PPa3cdxUrWi7PKcudPzK5n74zeJSBJoCaGG1d7N70T9XfVlZIYjMoyPQABGWXpkhvzPfOgGfNslwpq/UMPXyb/N3zXpIBYRyL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292522; c=relaxed/simple;
	bh=3RDY+InRbRGkZwpv/31rtaQafCmsuYt5wpq5FyYuVIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fBaTdrUjK4JCvYSV/B3xcDWyhz+eWIyfdHMlB/MHtKiY5pJByeRRXfgYq9R79o0uiN4IHu6wwr3BI6iSRSI3CeiTwL6j1nNhJPruk0hRPl4ZJQxVOeX/X0xnRv3G+k9pm0f1S1Kj0Rx/QeRBLdyHG30k3Mino+zfakGWjkaJJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wEUtSqcq; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43947a0919aso6422025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744292518; x=1744897318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yq2Udp4AIBfEdCHQPPm/mcMlKJxLC8HFZ/abGzZSPM=;
        b=wEUtSqcqfgQUbm6mveqdmeMq6laXD/Bj5fmk4oBNV1JarzI/LiPJ0IpMQsSsFeKSpZ
         S4ijSQk0V60y/66Ib87LLGFpZx2Tqy1781ZS3728X0jhOHQsh3VhK8DqCj4oX9ZoN7pU
         nUKMdchtrKfM6ljE4SpbIv/vW9HTY2N2afAVI3jbL1gu+0EyY49CcdbEmOWdineszgK4
         42cP/lZVzJ8ofCttzElkzWShdQGZ0DAAIyyDRDkUS/OUDuUaqutrGlHcBUlagGynkqJw
         KZ3abo5wQE8AAQTzEFYIzf46kxz5LxYyX/Nvz54JIF9Df4a5WXuu9wEKQ6zXjqY+jmUQ
         L2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292518; x=1744897318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yq2Udp4AIBfEdCHQPPm/mcMlKJxLC8HFZ/abGzZSPM=;
        b=qwga4Bygqkpi622u9eTh1t9wzKubdwmWCtEOdCeKAhdApUjB8dz6fFrpWaPWKmuMgF
         Z6Xrn9S7kR7BctLdG5jG4JMatVLWxY8zvwTJ3ddnk+sg2c3CFKsHmBAfg/I7lHZxHbKf
         OncLgqHYXRdpDXs990XTjqQhbv0IBKcYXl35d1OsBw7ExExdLNYhRgGf3nJDPSpGYqY0
         FromwcJ//J3hYX/ZcnFgCfdoAobM6SsbnO5YwEF/l07lrZW7iWxS2B2DOSOVB75Im+Tj
         /p5/JwFTvLMIYuZDxxAfFs2ThbKl16794XMmLxTHz8ptFCBRsSE4Pw9SDuVDLKx1YjTL
         4hEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpyn/cREt1I5YubBXq5OLHF0K6SnUg7NJTgfn6FNZvdEO+Oc91qGWUZ69ratRSef/vf/FV9Ohd4AI2BXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8vska+Dxs9xZLsISjo75XnCm2JLq8adfJz60XEe8ezFdox2u
	iJyS1c2fhZlqpHk3Ao19bikTPulfFpL0BfgNzdkbgR2eIDGUg3gS5OqUfJBVu6gzcOhqWw==
X-Google-Smtp-Source: AGHT+IH5IZ4nLFaGoD4MuACElwJFU9aXPnUiWGgPaq1XTHhC2cKM31QzFF70nprkf6ZRYgrR6xmVXgVr
X-Received: from wmcn12.prod.google.com ([2002:a05:600c:c0cc:b0:43c:f60a:4c59])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e13:b0:43c:e481:3353
 with SMTP id 5b1f17b1804b1-43f2d7f1b68mr32794315e9.17.1744292518802; Thu, 10
 Apr 2025 06:41:58 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:41:27 +0200
In-Reply-To: <20250410134117.3713574-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410134117.3713574-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=ardb@kernel.org;
 h=from:subject; bh=ZxH01yKh1YWsY6C3Y3GXCe7hCPc6xzGAIM8w8oIWNO0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf37qV67Dyt0dPKafwRHms/cEjtZ1GTdBltth8sTJuusY
 C2IVl3RUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACairMrwh8+zpnrOPpvjyfue
 6Rkq7Zgf8aB5fcfPiSs+7Jt7J933ySFGhpmTdJn93AREKqN0D0uzM1a+XVT9ZtLnY/2l2S9Xr/g 9lx0A
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410134117.3713574-22-ardb+git@google.com>
Subject: [PATCH v4 09/11] x86/boot: Move SEV startup code into startup/
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: x86@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the SEV startup code into arch/x86/boot/startup/, where it will
reside along with other code that executes extremely early, and
therefore needs to be built in a special manner.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c                              |  2 +-
 arch/x86/boot/startup/Makefile                              |  2 +-
 arch/x86/{coco/sev/shared.c => boot/startup/sev-shared.c}   |  0
 arch/x86/{coco/sev/startup.c => boot/startup/sev-startup.c} |  2 +-
 arch/x86/coco/sev/Makefile                                  | 21 +-------------------
 5 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 714e30c66eae..478c65149cf0 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -144,7 +144,7 @@ int svsm_perform_call_protocol(struct svsm_call *call);
 u8 snp_vmpl;
 
 /* Include code for early handlers */
-#include "../../coco/sev/shared.c"
+#include "../../boot/startup/sev-shared.c"
 
 int svsm_perform_call_protocol(struct svsm_call *call)
 {
diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index ccdfc42a4d59..b56facb9091a 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -16,7 +16,7 @@ UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
 obj-$(CONFIG_X86_64)		+= gdt_idt.o map_kernel.o
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= sme.o sev-startup.o
 
 lib-$(CONFIG_X86_64)		+= la57toggle.o
 lib-$(CONFIG_EFI_MIXED)		+= efi-mixed.o
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/boot/startup/sev-shared.c
similarity index 100%
rename from arch/x86/coco/sev/shared.c
rename to arch/x86/boot/startup/sev-shared.c
diff --git a/arch/x86/coco/sev/startup.c b/arch/x86/boot/startup/sev-startup.c
similarity index 99%
rename from arch/x86/coco/sev/startup.c
rename to arch/x86/boot/startup/sev-startup.c
index 9f5dc70cfb44..10b636009d1c 100644
--- a/arch/x86/coco/sev/startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -422,7 +422,7 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 }
 
 /* Include code shared with pre-decompression boot stage */
-#include "shared.c"
+#include "sev-shared.c"
 
 noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 7d7d2aee62f0..b89ba3fba343 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,22 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o startup.o
-
-# jump tables are emitted using absolute references in non-PIC code
-# so they cannot be used in the early SEV startup code
-CFLAGS_startup.o += -fno-jump-tables
-
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_startup.o = -pg
-endif
-
-KASAN_SANITIZE_startup.o	:= n
-KMSAN_SANITIZE_startup.o	:= n
-KCOV_INSTRUMENT_startup.o	:= n
-
-# With some compiler versions the generated code results in boot hangs, caused
-# by several compilation units. To be safe, disable all instrumentation.
-KCSAN_SANITIZE		:= n
-
-# Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
-UBSAN_SANITIZE		:= n
+obj-y += core.o
-- 
2.49.0.504.g3bcea36a83-goog


