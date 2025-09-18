Return-Path: <linux-kernel+bounces-822146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39139B8328F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1581C8031A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFF2DFF3F;
	Thu, 18 Sep 2025 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWOp21Sh"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F842DCBFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177375; cv=none; b=DmidChlOE0LG0sp4w7yo3koSytVzeKPN+irSYw8Ue+tUGmZCmbZPpGdwX/PRxB0/hQQEaLMJKW1r/Bue+d36myxUKguB7Op+HZycFGuOFpXesHmq/iSjFfc24Z6zlZR/fzxE0t46jTG0CDH1iU6Bi4aLQZ4rek+OIHtWNPH9Zx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177375; c=relaxed/simple;
	bh=vWcZ1QI8Z0VaPchJBkch+vuuwu97oCktK301998ooq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JwfeIwMI8Rt6TN+VLYBF42Lkn1AAQ0xvzgCBuL7J2I7ePgBYGPHN4E24ztnd2gRYDf9TH+QzWOj+IBB40XY5E3UVy1M6mySTewFqAwMIHXlxyVZMtXahse2YiVN1U55kGc39rrfuFfHOYc9y5nVenLDhjis6Mjp3gXcZqjkAxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWOp21Sh; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e40057d90aso261084f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758177372; x=1758782172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nd/aa+Cyw0z/Ul0/qN6NY/ef41tVXmadJuCUPt5tdFQ=;
        b=VWOp21ShvkbTAf3SDWezj96iSzA2qVWgyYbTsajuxJAqc2dX1HpgdCAjhWb85ceLqZ
         fRBNAsdN6PHRSuMjLxIJ59M8u4W4iRCdPi+3HBvVgByoqTXvWVtnGZPPxSYNvxyxvFNr
         DqnCXcQtzWHuu8tizxSMChSqK8vEoQLl7KG4Ox8Jsq6FYZc2yKRhsHScXsoyeGNAX2qD
         n8a8fupMZuAJyVh82YC3LIUpp0xvQtQGvjUYggKovowfBqdrNXf6/bQcI5mpcnjjYMDb
         gjh8Lfw7Ix7q/Rui3YEvppPf80OgZgzWhcay4Ek443flvG0WhlbIzlwfhij6T9SFHpw8
         +Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177372; x=1758782172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nd/aa+Cyw0z/Ul0/qN6NY/ef41tVXmadJuCUPt5tdFQ=;
        b=uKmmG0laf5D1q7f/qIaX/CoNSqVXsSFHTrBUU1WYtU5WnPzSxJucDyoHntc1za7wkl
         8EHpWoUt0CaA7653/kzHNIMujXLsFC09k/a54NdaJ2h7IAQb0rAD2exOrC+Km96U8OrJ
         zCrGmWWRgH91WTG06SxCRxFx2H3af2I+V8Q9HJ6vL7XYBCHQ877m1sj8191QYfqm/KhE
         RCda/XEJpNsCiIGIjLIoUsTZMAx/p4B/x/slRyytskv4x65uNisT+t2zuPvSkFIGKFiL
         C3gVySLE2ESH6JUbxZyw7qCfatceOv9Jy90GmNru1hHpvICXJP+stBXjXCPYhaLjsINi
         UYeA==
X-Forwarded-Encrypted: i=1; AJvYcCWvQ0ZcVgnuTBDidxSrVW5GixfBHH1JnkwzhBmLYiu0ZhfNyUUYOs6CqPSfxrkexHsWhJb4Ix9f13SuRcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpy2qXwM8kqo85pSObLS6a/oa28TwUPsj3Beypc7JVMNRXP5fR
	1wWA4X8lJv152L/2ji/GAJ29juknZ4CHIUms1V3xHjACTVDm1xXb4XHjBTUCApuEUK0AmQ/oUg=
	=
X-Google-Smtp-Source: AGHT+IEaYfwr01ZjRAssGnsJ1gUGd1rN8g5Gj0e5CjahKJgyizByZHhPk8uuPViunThk6UOOlyd5IgyT
X-Received: from wrbbs28.prod.google.com ([2002:a05:6000:71c:b0:3eb:6104:3eb])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2284:b0:3ea:124c:8fc7
 with SMTP id ffacd0b85a97d-3ecdfa1434dmr3783151f8f.39.1758177371854; Wed, 17
 Sep 2025 23:36:11 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:35:44 +0200
In-Reply-To: <20250918063539.2640512-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918063539.2640512-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2845; i=ardb@kernel.org;
 h=from:subject; bh=fbTmP4aG6tbBHGWrU82oUT6Reb9I9nyA/9uuGWnWHsA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0Cqcpcmo3s9lOdcud6TTT/3/e+Haah27JoTmrPn36k
 qtkYXWuo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykPJyRYc9Ujxln1/M8UN0U
 srST+emhX57lN5vdFz69bBItdNUs9xHDP1OjzLYvG7QqeQXWeDWfFnstxjJ5Zu7xFo5XF1s+H1P byAcA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918063539.2640512-11-ardb+git@google.com>
Subject: [PATCH 4/5] arm64/fpsimd: Require kernel NEON begin/end calls from
 the same scope
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for making kernel_neon_begin() allocate a stack based
buffer for stashing the kernel mode FP/SIMD state on a context switch,
redefine kernel_neon_begin() and kernel_neon_end() as macros, in a way
that requires them to be called from the same scope, and therefore,
running from the same stack frame.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/neon.h |  7 +++++--
 arch/arm64/kernel/fpsimd.c    | 12 ++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
index d4b1d172a79b..4e24f1058b55 100644
--- a/arch/arm64/include/asm/neon.h
+++ b/arch/arm64/include/asm/neon.h
@@ -13,7 +13,10 @@
 
 #define cpu_has_neon()		system_supports_fpsimd()
 
-void kernel_neon_begin(void);
-void kernel_neon_end(void);
+void __kernel_neon_begin(void);
+void __kernel_neon_end(void);
+
+#define kernel_neon_begin()	do { __kernel_neon_begin()
+#define kernel_neon_end()	__kernel_neon_end(); } while (0)
 
 #endif /* ! __ASM_NEON_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c37f02d7194e..d7eb073d1366 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1833,7 +1833,7 @@ void fpsimd_save_and_flush_cpu_state(void)
  * The caller may freely use the FPSIMD registers until kernel_neon_end() is
  * called.
  */
-void kernel_neon_begin(void)
+void __kernel_neon_begin(void)
 {
 	if (WARN_ON(!system_supports_fpsimd()))
 		return;
@@ -1875,7 +1875,7 @@ void kernel_neon_begin(void)
 
 	put_cpu_fpsimd_context();
 }
-EXPORT_SYMBOL_GPL(kernel_neon_begin);
+EXPORT_SYMBOL_GPL(__kernel_neon_begin);
 
 /*
  * kernel_neon_end(): give the CPU FPSIMD registers back to the current task
@@ -1886,7 +1886,7 @@ EXPORT_SYMBOL_GPL(kernel_neon_begin);
  * The caller must not use the FPSIMD registers after this function is called,
  * unless kernel_neon_begin() is called again in the meantime.
  */
-void kernel_neon_end(void)
+void __kernel_neon_end(void)
 {
 	if (!system_supports_fpsimd())
 		return;
@@ -1902,7 +1902,7 @@ void kernel_neon_end(void)
 	else
 		clear_thread_flag(TIF_KERNEL_FPSTATE);
 }
-EXPORT_SYMBOL_GPL(kernel_neon_end);
+EXPORT_SYMBOL_GPL(__kernel_neon_end);
 
 #ifdef CONFIG_EFI
 
@@ -1936,7 +1936,7 @@ void __efi_fpsimd_begin(void)
 	WARN_ON(preemptible());
 
 	if (may_use_simd()) {
-		kernel_neon_begin();
+		__kernel_neon_begin();
 	} else {
 		/*
 		 * If !efi_sve_state, SVE can't be in use yet and doesn't need
@@ -1985,7 +1985,7 @@ void __efi_fpsimd_end(void)
 		return;
 
 	if (!efi_fpsimd_state_used) {
-		kernel_neon_end();
+		__kernel_neon_end();
 	} else {
 		if (system_supports_sve() && efi_sve_state_used) {
 			bool ffr = true;
-- 
2.51.0.384.g4c02a37b29-goog


