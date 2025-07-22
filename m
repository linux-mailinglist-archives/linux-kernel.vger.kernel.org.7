Return-Path: <linux-kernel+bounces-740360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1ADB0D33B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366E91883A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31672E093E;
	Tue, 22 Jul 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAJacNzu"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAE2DF3E8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169409; cv=none; b=DKwqUtG2IXgjbVMCuo2E8j0gbcXKgqLCkD0r8mhfu/BDNqbApg/kUpl65J0EQ2CM9fOi5LUclMIRKwwTE96Rc7FUWTIg9MjR3f55MXE106XyS5PPl9aK58D7USbRUbNg+bpcieMnFgwMPL9IO7rixHrtsFzD4kwQFOk7No7d5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169409; c=relaxed/simple;
	bh=m+AA9YnrLD0iUVWnbGpAkFXJWtq3QSsvd+u3h67S7DA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fttV+lQimyjkSJ28nsGsN0qof99Y8q322Jk+D2thVTTZOHtnBVDtKynIRHBtM+bxGwBW0mgMfCgCQeuNcCSj/5e0CCkhkSb0opWUxjZxRhusc+eYCsFJRvTXgoFwcc2H/STMVoiRIaPpypdiJIhtoBaA2KBgQWVDXiR5AARrClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAJacNzu; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-612b6aa7ed2so4597971a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753169405; x=1753774205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=joWJVM2i9LyAMlJmIbS+61T1iNRyCZpWQH9FF0KYFxg=;
        b=sAJacNzuCWHCk+nmhbHQsDmjW60540vhAz/yTFm/FEbR5RuFLPdGArevtj75BuDTE4
         WyWvKYibR7BsBvhf9h4IrHg6H1qdwQ5SI/K2byGfmjKmz/6Zlq/x3e/Q2Wykpt3vZB2N
         DMSA2wu+K3y2zUQaP9hpzKuCebL0dsdvLoM4YIi0AYULzeTOaw0ZIUwD+3w08t+Q5xto
         mtSSdYTjjiY1WWRrhiH2md9vOmL9CxhuAKc2vlMGsAkLklL1TLAvUXoth40WKckVPR9H
         wgJjMoc6qsFVFkJ+OmBXfiYYtihAVJUAyG4IVdk9DkYYEKBQ4bc8rVcWzh/3VJyMO7NV
         lxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169405; x=1753774205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joWJVM2i9LyAMlJmIbS+61T1iNRyCZpWQH9FF0KYFxg=;
        b=M409RxgDBx1Iat4hL8UOOAIQvygS46JT10YsJj6pzlAdTnaKj3CDvNUaGhnKAKB8ww
         VXWvJvgWZjgzSC83H7csaZ0zXrG3wEZoxRpUe3XZSGjUZZifJ5BFE2ybNfHgBUeKeQil
         lyYGw7RwwqhpyChZ8G6Lyoe0Q12Cl0dmHOE1L+rpHjkH6hShNqBbevCdqT0SXGhwZ4qi
         aft+7ffWuVz2mEidRwFoCnDSCJybJFuuBGYKU5i96Scx1dxpxWactv6nVzbnPuVJvcS+
         /kGchAtKNIkrOUsOGjX2dipYYrzfc6AwNV57GxfO122dqtm+oR7IWvQs0iOd0IBD69QN
         ObCA==
X-Gm-Message-State: AOJu0YytAB9ZzFbRUtXHpoNZUfRlgyMg3dl/uYF0CfrWvh+cqPwwyylA
	S7nwVSZbVa7DoKJwhH7eARB7iFbVXRPE7pNE8tvt5uCE8rVmyU/GWaTryyZFJ7XF5FRcOOXQda1
	JjN9za/KBGYeGVKRfGp8/E7ougWiWxyPciq1Q6qKMvG+8ZzHb4gYYLgDEdFNu7yEkP8aw6oU7XD
	/sENgqYe48UWQhW0B53WZjQNtXks5a+wEDHQ==
X-Google-Smtp-Source: AGHT+IHBFkra3DT9d/Jz54hyx9X9Sbb5UtTq/QCThPQD9dIL+tW4Ej2jMl0lcTj1D0bBSsI+igZS8dIu
X-Received: from edbdh15.prod.google.com ([2002:a05:6402:1d2f:b0:612:bb19:6d36])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4407:b0:611:fdb4:1dc1
 with SMTP id 4fb4d7f45d1cf-612a4d17913mr19148358a12.7.1753169402910; Tue, 22
 Jul 2025 00:30:02 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:27:22 +0200
In-Reply-To: <20250722072708.2079165-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722072708.2079165-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6028; i=ardb@kernel.org;
 h=from:subject; bh=VRS61oLaIqj8kKv/u+4je9bg+LB91FkrmM3QiYMrk/A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaPetndtuc28T9VbDA/9LDLdalZ0R/Dkasl9252F79rJP
 NnbnGvbUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyqIiR4YPexKszT2+5EL2G
 ecOrwD7jA3nrV4UcXswZx/Xk/ymtc/4M/+NVIl47nDwjVHtDyG93fGB/wD2BFsM3rTO89J4LPpy 4ihUA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722072708.2079165-37-ardb+git@google.com>
Subject: [PATCH v6 13/22] x86/sev: Move __sev_[get|put]_ghcb() into separate
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
 arch/x86/coco/sev/Makefile                 |  8 +--
 arch/x86/coco/sev/{sev-nmi.c => noinstr.c} | 74 ++++++++++++++++++++
 3 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 76d40e381d41..2f7d21660cdf 100644
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
index 342d79f0ab6a..3b8ae214a6a6 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o sev-nmi.o vc-handle.o
+obj-y += core.o noinstr.o vc-handle.o
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
-UBSAN_SANITIZE_sev-nmi.o	:= n
+UBSAN_SANITIZE_noinstr.o	:= n
 
 # GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
-KASAN_SANITIZE_sev-nmi.o	:= n
-KCSAN_SANITIZE_sev-nmi.o	:= n
+KASAN_SANITIZE_noinstr.o	:= n
+KCSAN_SANITIZE_noinstr.o	:= n
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


