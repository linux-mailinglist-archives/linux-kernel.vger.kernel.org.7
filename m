Return-Path: <linux-kernel+bounces-644801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48255AB44A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE33BF5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60729A9DA;
	Mon, 12 May 2025 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPFKUVAL"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F629A330
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077126; cv=none; b=sbh6WK83yQwXXzSrHDMcyDFjrn2MIeMkiJEHb3jh8m5sa7aQioyz1nzIwrEmUwgKd6Hhp2x0BPsn64SZhItJRbwUnISdi7eWRZCUTHn2HfXhkbfEl6QbOvmPKcBeoSl+ODK2L7pNZEctK5p08XVzweFdysntfq5SiS/e88zFFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077126; c=relaxed/simple;
	bh=UpwjHr7P0UTMrRDdN9ig7iDxvsWOONTSOP6veAaUT9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDgd4N3lsMr8KWUuHKPD2fWdZEH1NzKUzIVmjKcoWV3r6WTj6tMO0yVh2CxoAb4AgLIvax0gHaKVf28Kyn6uaIQZMmNNYfV72P9jVtY3rMgPrjyX+3iFrS7mP7TrFoPm/8dC3qD/RRDDREVDpJzQgYnMC6R79O5/z4ffD7hBSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NPFKUVAL; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a0bcaf5f45so1413433f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077123; x=1747681923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nrQ/4XTmJ+KyHu86vIY+wvcxckDvPLq0CZmdp/p5iA=;
        b=NPFKUVALKtwgU4uLJeOF/BW5llI7HqVGlbkKF4K+LiJQDuqMdEXNJd/YtJmtyTljbs
         mFwnX6z/AMv02EEHnr2L5D5FW2xIkzS3nb07Cy56GcK1UiIf7SDSJpFAOaLWa+DA5bMf
         Mio3NVEn7G9XMpeZ5vP4IsI6F7/6YlKZxeAGlq8gUUpx8sXuMHoEcuWbRRli13pCzPBY
         nAXjP3EdT8TQIJjzuS7lopAPfTB1gwC8vIMM8ZH50d0KUgpAsWEDJsprv8YS0bJmwtL4
         AeQjERuHOWt/mpnI67rK7fFXPMGHlXgRyWuckgdV1d1l8ukueJ66csscrLdt/6+KoAF5
         D/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077123; x=1747681923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nrQ/4XTmJ+KyHu86vIY+wvcxckDvPLq0CZmdp/p5iA=;
        b=rfkoZKIU5itELlrAkPAzib6cexdrvpNctDDANCi0DWWVW2KUw3jxGJXOVvVcdYM7Vo
         SW6GQVCADu9RzetrZrQUU0l8ADHDLPr1vbmKf4n90S6xH1wf50Kb7EPvQDJoWGH4Qvuf
         rA0vBBZQQK+0727PZfWD1rELSxq42xqKEzXLbva7LOmlODVUxLjMV3tpXiX4mjlW+ERD
         aaFI4uF5YWqshhT3kDsi+UsIhe2h36oZ6FlECqz6kzO2jE/PDMf9/9UYllh/lDtzqPSB
         3my+fPQylJ6j1qV9EY9Laz7CXTJ9iHSseQ1XpKjggdkyL0ULbf3+wsnluthUJoBuWLM4
         lx6Q==
X-Gm-Message-State: AOJu0YwMCLx/vmAOCEqy7FeNcVOYjrWzLU9GbEuI4oAOvlCIGpNhRYm2
	wVKLajAupcmCrvZd/f9/mDDNhwYbgA1rweD1dZhdmIwGS4G6wv2aiTGtU7psQmQkFxoC3LjksfP
	3U5HSYmuoXs+CcGBlNXGq+4zzW7BTYs5t7bAGyCMZphNg7j3hfyoqMi4JSpyfP6A0vujVPkceZ6
	2y/I7yrKOi/nM7atVXE6bEE1yN44TIxA==
X-Google-Smtp-Source: AGHT+IHp/YiG0cb+tt0ySW/3CTLdy8q5aWilPzaE68xQMab/UbwLIitm0QYwgGU2Ch0iBs3weRd0lbVx
X-Received: from wmbds13.prod.google.com ([2002:a05:600c:628d:b0:43c:f6c0:3375])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:4b09:0:b0:3a1:fc5b:7389
 with SMTP id ffacd0b85a97d-3a1fc5b7445mr8284121f8f.2.1747077123366; Mon, 12
 May 2025 12:12:03 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:50 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5944; i=ardb@kernel.org;
 h=from:subject; bh=0c9s8oGSb2OEXkXwx2pR219N0YP69SHhQKlAVq+3foQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJPXCb47/LcV2Ply6YEf10gUd3+fydkcU9gkbHZ9RHJ
 BxWPafbUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayZD4jw032/Ron/6SfrQt4
 eKnW3dJ2K/NV1yM3V+V2mP/4kryR8TUjw4vydf3RMS9fivyy2F11R8nlyVv9yelbuDatZ/jRkvO llRMA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-38-ardb+git@google.com>
Subject: [RFT PATCH v3 15/21] x86/sev: Move __sev_[get|put]_ghcb() into
 separate noinstr object
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Rename sev-nmi.c to noinstr.c, and move the get/put GHCB routines
into it too, which are also annotated as 'noinstr' and suffer from the
same problem as the NMI code, i.e., that GCC may ignore the
__no_sanitize_address__ function attribute implied by 'noinstr' and
insert KASAN instrumentation anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sev-startup.c        | 74 --------------------
 arch/x86/coco/sev/Makefile                 |  6 +-
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} | 74 ++++++++++++++++++++
 3 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 9dc0e64ef040..b56a585f57ab 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,83 +41,9 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active)) {
-			/*
-			 * Backup-GHCB is also already in use. There is no way
-			 * to continue here so just kill the machine. To make
-			 * panic() work, mark GHCBs inactive so that messages
-			 * can be printed out.
-			 */
-			data->ghcb_active        = false;
-			data->backup_ghcb_active = false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active = true;
-
-		state->ghcb = &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
-
-	return ghcb;
-}
-
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
-noinstr void __sev_put_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (state->ghcb) {
-		/* Restore GHCB from Backup */
-		*ghcb = *state->ghcb;
-		data->backup_ghcb_active = false;
-		state->ghcb = NULL;
-	} else {
-		/*
-		 * Invalidate the GHCB so a VMGEXIT instruction issued
-		 * from userspace won't appear to be valid.
-		 */
-		vc_ghcb_invalidate(ghcb);
-		data->ghcb_active = false;
-	}
-}
-
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, enum psc_op op,
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index db3255b979bd..53e964a22759 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o sev-nmi.o vc-handle.o
+obj-y += core.o noinstr.o vc-handle.o
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
-UBSAN_SANITIZE_sev-nmi.o	:= n
+UBSAN_SANITIZE_noinstr.o	:= n
 
 # GCC may fail to respect __no_sanitize_address when inlining
-KASAN_SANITIZE_sev-nmi.o	:= n
+KASAN_SANITIZE_noinstr.o	:= n
diff --git a/arch/x86/coco/sev/sev-nmi.c b/arch/x86/coco/sev/noinstr.c
similarity index 61%
rename from arch/x86/coco/sev/sev-nmi.c
rename to arch/x86/coco/sev/noinstr.c
index d8dfaddfb367..b527eafb6312 100644
--- a/arch/x86/coco/sev/sev-nmi.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -106,3 +106,77 @@ void noinstr __sev_es_nmi_complete(void)
 
 	__sev_put_ghcb(&state);
 }
+
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active = true;
+
+		state->ghcb = &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb = *ghcb;
+	} else {
+		state->ghcb = NULL;
+		data->ghcb_active = true;
+	}
+
+	return ghcb;
+}
+
+noinstr void __sev_put_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (state->ghcb) {
+		/* Restore GHCB from Backup */
+		*ghcb = *state->ghcb;
+		data->backup_ghcb_active = false;
+		state->ghcb = NULL;
+	} else {
+		/*
+		 * Invalidate the GHCB so a VMGEXIT instruction issued
+		 * from userspace won't appear to be valid.
+		 */
+		vc_ghcb_invalidate(ghcb);
+		data->ghcb_active = false;
+	}
+}
-- 
2.49.0.1045.g170613ef41-goog


