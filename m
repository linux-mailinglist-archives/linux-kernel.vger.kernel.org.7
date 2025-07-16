Return-Path: <linux-kernel+bounces-732797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97FAB06C35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BAB7B4574
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F8289808;
	Wed, 16 Jul 2025 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ng/EiWLF"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3928935F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636165; cv=none; b=QI/r5y50waq/lfVMboNgHrfbUQ6X79tPJMgN9TGBSRyrarhcIfG2oFER3oBi/98Tb9wj/ipFMPhtYCmRtSrKkZpFqBUiOpxWbZkbkQYo48J7jam2SuWadvb2sSmhKSbohVtHslGU9VMcSIFlV5gwreDPCygKRq8uIHpZqwfrQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636165; c=relaxed/simple;
	bh=og78V1Zb+PcEV7AazoH73d5dq2n03AsVv6Eth60PTqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8fPLYS5LYsiDxF9y3NzPSmmrT6WMBQBTU6uzrlo/pNcoC+jMFXs0VNa7Zma0WfCydvFpAbMdZfRm9uFVJ7GPUXLaqkh0kCFN9O8XhMrrMAnIj9PITj3LL6JO9otjYySgGvw4T6pSYmCRnwcLF/eo4JjxGLYd84OUyu96vxUmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ng/EiWLF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45626532e27so10025985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752636162; x=1753240962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cpx4NiyNbT4MxlvP8PPoGquIm/1aTybUx8Yhuvtnt6I=;
        b=Ng/EiWLFLwu97Y2GEKBpMLikSprFT0ExTfGPfilYTqTjW95/hftKxjh2+S14pxuVQ6
         n+0cKoNFV8c8we+9uQ3qL1vvXlx9exVKkdM0ejO1zunJAohcwdW4xx0oWkUSF2Tn44Tm
         4+329XDRgJ2VVDIAGYikjaJ4t7wThGxBl/mUekahH9P8xuHXceyZNi2eImu9s/XZrq99
         LUocuyPhwshZ/FMNeNmff6rDbw2M+hhDXz1w+U3DdcR8JH68MolxcvLeGxKDRjvl4AcH
         nCVZ8KNmukm6dhojTZHLbByIh2DEduW4ZYxB4oqjBhfx0G/y09KnyY1tgJ3TdVmoNvJV
         4PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636162; x=1753240962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cpx4NiyNbT4MxlvP8PPoGquIm/1aTybUx8Yhuvtnt6I=;
        b=swy5KM6c42HAUim+XWW7Cd5V+F3CZRN1V0blCyJtA4Xhxgylk+QF3r3LqIlaiqp7Hz
         nnR+Jw1aUTvD7IrjP8+F88ZnAmHC9+J0kRooazxFVmGH9NWkrxnWU7UaGeTY8wxVullj
         Jlq+XlkufggUvgjVvcjRXLBKNxA2QfCq5ftsPU3VD7WaF86fcaREsAVN2i2xbCZuZ+C7
         Qv5DaQx73Wlho5xgULK3G2jsBMRxzyUK0qNeJDIlQqFXEqszPO0oOt4ic5uML/6mTebu
         SPP+OmP/vavziGF5VbyDPi3lMd6Sm7T5ihUsNynx3TgzwgMX0TyEIQx6b+qNViTTqfnL
         xRZw==
X-Gm-Message-State: AOJu0Yy6wTX44joS78GixQgR3OgA+Kx83SyiGtLIo0AkJphj/Zylh8St
	tyFdZ7HP3vyOdCmEAzZEDFCutARlYa2QeeEWtKlSeQlbbl6ylnOLL21ow/HxeAFC9uKYhWniosn
	VGKP+80fn9BvxY/uCIxkT5/WiA4DtAenLBRnER8h6Uf2qZsoNimjRB1rNKTc8FhPVl/dzN3bWHO
	G8+CAZmMTwLaE7HjRUXqu+w5sU5AO4MgjlSA==
X-Google-Smtp-Source: AGHT+IEfYtUbrbDDEmuTIbU4xaNSUCVc+LvthUFdglmYj/mvBHEHohZwX/i7QJlhPBy05B80p2bFqbzn
X-Received: from wmth21.prod.google.com ([2002:a05:600c:8b75:b0:456:f62:301d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3596:b0:445:1984:2479
 with SMTP id 5b1f17b1804b1-4562e031df5mr7797245e9.5.1752636161856; Tue, 15
 Jul 2025 20:22:41 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:18:28 +0200
In-Reply-To: <20250716031814.2096113-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716031814.2096113-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5947; i=ardb@kernel.org;
 h=from:subject; bh=Kgx6kkml75xrQvDgw+PvuVkStDU185KdttsrkQOiuu4=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGh3Gj+isMUfeVAkYvn9LHKa15sacYooHRq270MbMgOfQc2N0
 Ih1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmh3Gj8ACgkQMG4JVi59LVzHHQEAg4hp
 Woqan4eC+zx7lYWd8ePiULk9zkE8n6xKagj2E7YBAIl1ZgaVKzDBg6IqVdQNPeY/Q6wXhdcclu0 Aanou90UI
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716031814.2096113-37-ardb+git@google.com>
Subject: [PATCH v5 13/22] x86/sev: Move __sev_[get|put]_ghcb() into separate
 noinstr object
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
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
index 733491482cbb..e9238149f2cf 100644
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


