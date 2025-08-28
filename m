Return-Path: <linux-kernel+bounces-789727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A13BB399AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DA9468160
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D330E0D5;
	Thu, 28 Aug 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUuYbLNi"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25030BB92
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376572; cv=none; b=GJQw3m/IU7xQMvezAj2OR2UlS1dAlUU0y0kOmNTlGX0BDbnzw4Ct5eGMtb53yUrqVijl5SUdV+3nq5qMXm80ywEO47LO0GzYYrwQLB2uK4kRpeqTr9qgn4M6KNxrZjNof4bYPAqtNThPSfUHZAmaOjJWDrl9d6mIgz4nB/KCi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376572; c=relaxed/simple;
	bh=G2zufqLCQn7+KfD8fnQ9mx11YDR18l1Dlw5GsKNscZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=If7I9foM+weG5x/aawjtkSpHzD2lRJuplmJvzW7OszI8OBu2IajKJk5F33W3cRK5Y+xaXAWIFIQxJgmoO2M33UpjqRvp46fP4GcP+X4pqBuRqcYa3x8UFNt1S+hQEK6l6oCIHTxrUqgNvGQdN3PwmMdI1o/z+fc0gJUHT7sjnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUuYbLNi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b51baec92so1619175e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376569; x=1756981369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujXKSc+zgno0OOMX6c7Rga5ycdtxsGZotgyzuX1fels=;
        b=sUuYbLNiUlc3YoWE5WBJpCKXQ59MeVVgXFIz8sk6iD1150VCDtP5NZcMAk4iiEeK1K
         I231yYrMAu+e15EbafiSQSXzpjGC0DiMsfSUzK5m5+fJ0yR+xn7fnITbLw9ICtQAv8m/
         Bg6+y4WU0sJK0fn3fFBJTQ7RpESnsa7FfxqgikC5jbEp4CSwRKMUxxN2B+1dze5XxPVx
         ocoPHQYqc8HvibZYhJGo8y6JuJJov/huQKuXSPclOA/CXjJNUwSjC5+CRGTWK7fO2gqN
         Bkf+idHQiHkU3hui3uwk/QcCMmQEBQfP6yr2P5NXQg1drVbHSVEyN+nb1xQw7XEmwGWF
         +D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376569; x=1756981369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujXKSc+zgno0OOMX6c7Rga5ycdtxsGZotgyzuX1fels=;
        b=Kf2BLu5rjES8crqTCA1y8lk9AJj9dx8AunHrdasapgIZi3zb+J+B1xgC91RT4Iofvs
         UeMXfYbhI9GpEukBjruhrSHjrLHzcF/SLu7Hoh8SZvS2YjFEdfUEndXWIoexV5pqos/4
         d+YehaBMCRnjpgh4iS4wCfWaj4dn96CCtGYW1PttWwovSl5SrZ61ercT8HHcr7rX9wok
         JQmJbCeniNia9Ex7uQHewy+rb8HKaXP7Vb+AbdVWE5CGXhG9yrafsMkDIm9tPWCsJ75g
         It+7RXHVWY1yGyvMuvAWvu2xXibcAIiWS3fe9UMarTSkdQVXzVuhN9OVFlWYqH84gWDg
         zgvQ==
X-Gm-Message-State: AOJu0YwiBkVaiHjEtxeTQ0DMxDKHTGgdPE2lUfaqZ+0sCBZrcwTaKoH6
	PvnMtX4kEIJuPEJyNR6IUazDz536jTsUHNqGnWFAAus127UktEf9O87xzXbgn5rWsyNzwiwSn/2
	nU8WQb35GryrzqjAKx8BOQr8NyDdMT3+2hQOXtEp9qhDb+zs+3KzoFQh2cfC9GItFyHH4lHeHsC
	YfzWZ2PIB5lmTB2LOrqDtsw77asnBbTmdgUQ==
X-Google-Smtp-Source: AGHT+IELwBKJ1UROeUm4ICPfKLRu9iKkB4nXcVpVpcr3BHxSyVYVCTcIRJFBmrQ1Gj31W7uvHssJ33ov
X-Received: from wrui11.prod.google.com ([2002:a5d:630b:0:b0:3c5:97f8:7ce7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2306:b0:3c8:ffcf:e01d
 with SMTP id ffacd0b85a97d-3c8ffcfe6bbmr11059839f8f.55.1756376568911; Thu, 28
 Aug 2025 03:22:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:15 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=ardb@kernel.org;
 h=from:subject; bh=NkmNKRuvJHRR3ewqik/hXwp4Dka2MgHQ5hAg1woLvBM=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7s0DeteO7X2zc4WWmFyiTKH1/9enOu62X0ibyCk2s
 SrRTyaso5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzE5SbD/zDvgyxb8jzY+HMD
 rHyXHfP05fw7Idhn1fXYI2bKy58sYmVkuM74L+1Y21uf/05/ngUUJn3vfCrWF/7p+Tqh05lsj6K 2sAAA
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-36-ardb+git@google.com>
Subject: [PATCH v7 12/22] x86/sev: Provide PIC aliases for SEV related data objects
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Provide PIC aliases for data objects that are shared between the SEV
startup code and the SEV code that executes later. This is needed so
that the confined startup code is permitted to access them.

This requires some of these variables to be moved into a source file
that is not part of the startup code, as the PIC alias is already
implied, and exporting variables in the opposite direction is not
supported.

Move ghcb_version as well, but don't provide a PIC alias as it is not
actually needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/sev.c      |  3 ++
 arch/x86/boot/startup/sev-shared.c  | 19 -----------
 arch/x86/boot/startup/sev-startup.c |  9 ------
 arch/x86/coco/sev/core.c            | 34 ++++++++++++++++++++
 4 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d650a314143b..6822eb4b9152 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -38,6 +38,9 @@ struct ghcb *boot_ghcb;
 #define __BOOT_COMPRESSED
 
 u8 snp_vmpl;
+u16 ghcb_version;
+
+u64 boot_svsm_caa_pa;
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index b86027d9a968..180f54570022 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -19,25 +19,6 @@
 #define WARN(condition, format...) (!!(condition))
 #endif
 
-/*
- * SVSM related information:
- *   During boot, the page tables are set up as identity mapped and later
- *   changed to use kernel virtual addresses. Maintain separate virtual and
- *   physical addresses for the CAA to allow SVSM functions to be used during
- *   early boot, both with identity mapped virtual addresses and proper kernel
- *   virtual addresses.
- */
-u64 boot_svsm_caa_pa __ro_after_init;
-
-/*
- * Since feature negotiation related variables are set early in the boot
- * process they must reside in the .data section so as not to be zeroed
- * out when the .bss section is later cleared.
- *
- * GHCB protocol version negotiated with the hypervisor.
- */
-u16 ghcb_version __ro_after_init;
-
 /* Copy of the SNP firmware's CPUID page. */
 static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
 
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index b0fc63f8dee1..138b26f14ff1 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,15 +41,6 @@
 #include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
 
-/* Bitmap of SEV features supported by the hypervisor */
-u64 sev_hv_features __ro_after_init;
-
-/* Secrets page physical address from the CC blob */
-u64 sev_secrets_pa __ro_after_init;
-
-/* For early boot SVSM communication */
-struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 9782ebe30675..b9133c825f90 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -46,6 +46,29 @@
 #include <asm/cmdline.h>
 #include <asm/msr.h>
 
+/* Bitmap of SEV features supported by the hypervisor */
+u64 sev_hv_features __ro_after_init;
+SYM_PIC_ALIAS(sev_hv_features);
+
+/* Secrets page physical address from the CC blob */
+u64 sev_secrets_pa __ro_after_init;
+SYM_PIC_ALIAS(sev_secrets_pa);
+
+/* For early boot SVSM communication */
+struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+SYM_PIC_ALIAS(boot_svsm_ca_page);
+
+/*
+ * SVSM related information:
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kernel
+ *   virtual addresses.
+ */
+u64 boot_svsm_caa_pa __ro_after_init;
+SYM_PIC_ALIAS(boot_svsm_caa_pa);
+
 DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 DEFINE_PER_CPU(u64, svsm_caa_pa);
 
@@ -119,6 +142,17 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
  */
 u8 snp_vmpl __ro_after_init;
 EXPORT_SYMBOL_GPL(snp_vmpl);
+SYM_PIC_ALIAS(snp_vmpl);
+
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+u16 ghcb_version __ro_after_init;
+SYM_PIC_ALIAS(ghcb_version);
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-- 
2.51.0.268.g9569e192d0-goog


