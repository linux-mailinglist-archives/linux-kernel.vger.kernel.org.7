Return-Path: <linux-kernel+bounces-811422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792DB528E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31D55655E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C1D26CE2F;
	Thu, 11 Sep 2025 06:35:04 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB8265632
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572503; cv=none; b=q+td+n3fW6zg2uJvIP1ClV7vcM7d+7MqBdl2rQuBKvDFqJDKi/NuQAzE/m1MFrhvSCJ2u77hvIBT/K9Ez706srjzs8Q597LedbLhTga8KaO+lQk7rMoblj2hBMbcTIm6nnuZsy1esy3rYjslKcqsjI23AIr7cDueBo8GXy0gx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572503; c=relaxed/simple;
	bh=0chMgS+HuY2HQ0YAl8bAwKMS66ewLLYj2X7SRquFhjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvTM/ArMtvZUD6XTm+OQguPyHMiRQjHjaYSfvtv2C1o1eeCIGas8x8bPQmWvON4rrG6eyBP9jF37p59G2PqYgRp3xqtLw5/O0yq26u6cDqbXaAPbMM+9eazmos5DtuQzxkmyJbM0M7n8SMGL3axV5f1Oo6zLpMFa71spC7RBUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41FFB3FA7F;
	Thu, 11 Sep 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D62761372E;
	Thu, 11 Sep 2025 06:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KjfjMpBtwmgGTQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 11 Sep 2025 06:34:56 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 03/14] x86/paravirt: remove PARAVIRT_DEBUG config option
Date: Thu, 11 Sep 2025 08:34:22 +0200
Message-ID: <20250911063433.13783-4-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911063433.13783-1-jgross@suse.com>
References: <20250911063433.13783-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 41FFB3FA7F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

The only effect of CONFIG_PARAVIRT_DEBUG set is that instead of doing
a call using a NULL pointer a BUG() is being raised.

While the BUG() will be a little bit easier to analyse, the call of
NULL isn't really that difficult to find the reason for.

Remove the config option to make paravirt coding a little bit less
annoying.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig                      | 7 -------
 arch/x86/include/asm/paravirt.h       | 1 -
 arch/x86/include/asm/paravirt_types.h | 8 --------
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..07bf67b849b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -794,13 +794,6 @@ config PARAVIRT_XXL
 	bool
 	depends on X86_64
 
-config PARAVIRT_DEBUG
-	bool "paravirt-ops debugging"
-	depends on PARAVIRT && DEBUG_KERNEL
-	help
-	  Enable to debug paravirt_ops internals.  Specifically, BUG if
-	  a paravirt_op is missing when it is called.
-
 config PARAVIRT_SPINLOCKS
 	bool "Paravirtualization layer for spinlocks"
 	depends on PARAVIRT && SMP
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b5e59a7ba0d0..99291f3123a9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -16,7 +16,6 @@ struct mm_struct;
 #include <asm/nospec-branch.h>
 
 #ifndef __ASSEMBLER__
-#include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/static_call_types.h>
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 84cc8c95713b..085095f94f97 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -354,12 +354,6 @@ extern struct paravirt_patch_template pv_ops;
 #define VEXTRA_CLOBBERS	 , "rax", "r8", "r9", "r10", "r11"
 #endif	/* CONFIG_X86_32 */
 
-#ifdef CONFIG_PARAVIRT_DEBUG
-#define PVOP_TEST_NULL(op)	BUG_ON(pv_ops.op == NULL)
-#else
-#define PVOP_TEST_NULL(op)	((void)pv_ops.op)
-#endif
-
 #define PVOP_RETVAL(rettype)						\
 	({	unsigned long __mask = ~0UL;				\
 		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
@@ -388,7 +382,6 @@ extern struct paravirt_patch_template pv_ops;
 #define ____PVOP_CALL(ret, op, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
-		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
 				ALT_CALL_ALWAYS)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
@@ -402,7 +395,6 @@ extern struct paravirt_patch_template pv_ops;
 			  extra_clbr, ...)				\
 	({								\
 		PVOP_CALL_ARGS;						\
-		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
 				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
 				 alt, cond)				\
-- 
2.51.0


