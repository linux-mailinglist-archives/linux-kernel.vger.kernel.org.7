Return-Path: <linux-kernel+bounces-723048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9602AFE21C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BA15866F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E223BCE2;
	Wed,  9 Jul 2025 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGv04oiW"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDE27E075
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048697; cv=none; b=UfQxHPNbAJUhRUEKC7r9TJ9MVwic17BY9OWItzBAyQQgU9erMyC1ELo+rnu8d+UYHDaDMn2CQvp9qRxtHdNbbFX66Qy8cHPtkrWGG41PSJZH/WZdQgmYgsIyg2tkcs7FXsVxowID12jyPpJNM2dqMa0PBHZHOOkSvBriLf872CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048697; c=relaxed/simple;
	bh=AGlT/LHl9MzaxEHKXhO2ZblurSiOn1h3jOfRwltt3DE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eEJc2jJBx7g8pem2hMCnwipUmK+s0YhDRDTHWue86QF2PRO+XuGbSGxH5FoEQYrrmPN8bwIyQnzcySBWEboO2tjtD6qLBMILKBO2sbgYLAA+F0bqqItu8+kBtxtu/LghYyC0O+qIdvxFluCff8Bdzu8p5bBGnSDg+qE7TTgsnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGv04oiW; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so2610266f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048693; x=1752653493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRshuuEn2F0BA39jgtC7SgNobx9rRUXOK9J99LRFaaY=;
        b=RGv04oiW9qkqNiGeIiOUS+AOGt9O5y7CqdXLYDoS1sa9vC1MmsbEBNtAUQWP0Ejfe1
         3f7uEnd0mxQSmbgLdfJhefQuCMnexrnLX3CTh7okSCxIZ2FcX4Cn0vwLazizAN2SMN1T
         Y63fIomyl5VXWs+S1HyK+8FPtLkt/Lh5nHj73h2O2JODGarREBP6AL5hqByvJFcjC/47
         EdU8jjlSWRpLv/cmidUyxBgHxmia8FmYYcSKGFZCEbnHUA5xCc4SLuj97Q/+qbYlC6ZS
         Qeu+VtBs1E+eLRy4gLxp8ha2vlvxLUfBVxusL9IybOjCw6HXpT95wqLOwVf+M9vlSfLI
         TyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048693; x=1752653493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRshuuEn2F0BA39jgtC7SgNobx9rRUXOK9J99LRFaaY=;
        b=af7fsid39DBR6+yhRc2NrRuv1uv/Zdj7iE8c9XQ33xZY8CKoqrZP7FvZKo40RJht80
         cJp5ZUx8VqyK49W942Dyw7PlNEV1zIYYKQYFY38o3jlseXpLU7L4SnF77PxDFkbENmHm
         +3wzJLZB6OiROIlCRoIJK5wdSCjhI92/QFoZ2y5uWAMN0NIhSKhs07pqfee90TcYDNAF
         q8pBKk0ZsUKA8VAyRsIjQfZMRpML29NBm5wbME+By099IRG1RVkJX0D5GBmrhVJ//MZy
         +4YYrwiyd6IGeV8PGJAG7rlhGe5jPu8SS1HZinML3eOCTuI1fE3xczjAw0cBTckUcAPb
         f6WA==
X-Gm-Message-State: AOJu0Yz9sFE4a4P4lknTovumgsaqjoz8T+rw10mMw+OC7Iz8PaYwuIxO
	KyFVGD7R3kR8BvU6AE65XY0mbj/6koqk7VlxL3wPm4OQzJ3WPo651MDHZJRZ33zCzUlmahG2AT8
	RL0yN74LOgEz7ItZJH9Ue+CbkP8D3v3D06xGjT1pp34bzKPx4wIvD988z8Yp4jqqLBdxbA1ICXp
	vPwJXJhfHxzfNi/u8eL44b24itHelAeYA4/Q==
X-Google-Smtp-Source: AGHT+IFd2w5ZVTesfahbSSpkA4eCTiy1GduNxDCSOX0kEFz7Oc4RxGEnkxKU1qGXDl9LhGmdhRDN5Uwb
X-Received: from wmor11.prod.google.com ([2002:a05:600c:458b:b0:454:d826:7fb8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2006:b0:3a4:f939:b53
 with SMTP id ffacd0b85a97d-3b5e4530f3fmr842887f8f.38.1752048693596; Wed, 09
 Jul 2025 01:11:33 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:56 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5947; i=ardb@kernel.org;
 h=from:subject; bh=MKTGMdpJelTrHMYhuGbfBV3otCAWViTYIYy9a8cgjMY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+fr15drB8cKFti/PCe9btVbMf0rmqkczb7Fm+Pbbf
 /L81LOio5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzE0ZGRoTORx7RR+95FgQfF
 657fmLTrcB3D/cs57H5XizUbLTmdrjP8FXyT0P13pgvPwtd2wbGK7oELGN/+OxC4frLdgv5PB1/ /ZQcA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-41-ardb+git@google.com>
Subject: [PATCH v4 15/24] x86/sev: Move __sev_[get|put]_ghcb() into separate
 noinstr object
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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
index 0eb31bf81899..0fd80e63b639 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,83 +41,9 @@
 #include <asm/cpuid/api.h>
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
2.50.0.727.gbf7dc18ff4-goog


