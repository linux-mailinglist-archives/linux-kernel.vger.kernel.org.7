Return-Path: <linux-kernel+bounces-770324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1905B279AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB31AB6120E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D5E2E1C4B;
	Fri, 15 Aug 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t9cCLScj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zC1k19Vk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F362E2DCD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241545; cv=none; b=WOW6cWY7n0MjEHbZXv/WxjOSoRed6gG2s/0+FGBB37yopajK20Azu1eVgSbPYxZlh5Q5DTgRo+sAaPsKgW0W1vlcXtfCIG/JP28TezOhjoMlZUKp54rBYN9w5pg+YUpZlUONhRb36MOJNHwaPXF2mkj375E3VIIP3as3whIT9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241545; c=relaxed/simple;
	bh=oV/fZ8mujpFAr6wYDng1io4GmCwn7FzBxgsoYQBBGek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCU1a7mA5zI2BXDZUUHy0HbdQYBmtrX5WD04r1Y6qYhpMGtx8V11HFULgT2sq7mlJcNEh3E+hE2a0Pr75YqDLX5Lr5f6YNRpF4WHpqcokhWOJSYizf59wB+fui40szGAeMmGuAiYHI/dKvHGbRK3PHDh9r+lPRvixthf718d4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t9cCLScj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zC1k19Vk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YdLX/IqqO4CKKT2ZUvYFekYqtfCaupjSFTQr8qfc1Y=;
	b=t9cCLScjHQ3uLSc+w0vq46FX9ql38dAj3ya3z6xPGRzDYBwdh6HvHG3hsMLvDdSJV2Q0Lh
	PtMPavih33DuTA0KetMuH+eypUZ/fjM0CBRI7DvVpdp56GpYiIb3tJb8ZQqZaqONnfdADc
	2+i4cP9/PPLKDop9bWIAyHQNs51yaKwwcgxu7zhrDiYn/7Yxme2SDWIS4VKpvWso4BcTEE
	ijXyqkaHXimroPNjOnRvZTiEdx6cjo1qQyL7ieZ9VexA2XBuFlR/kwf9XZRD8pm8dxKi/O
	3tY5r2tgwltk9mML0oY2zCPJHVoikhOPcFpiFzPpbB+EkExl46ZZvDELUjj8GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YdLX/IqqO4CKKT2ZUvYFekYqtfCaupjSFTQr8qfc1Y=;
	b=zC1k19Vkf0VgcUL0ZBW5hNTtKCizk2XH6zbaUjxxACt1Wf2TINhao83Mz7g4dK9614mTzi
	TOw9fqlAP2hyDTDg==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v4 12/34] x86/cpuid: Parse CPUID(0x80000000)
Date: Fri, 15 Aug 2025 09:02:05 +0200
Message-ID: <20250815070227.19981-13-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPUID parser logic for CPUID(0x80000000).

Similar to kernel/head_32.S and kernel/cpu/common.c, verify the
CPUID(0x80000000) query output beforehand.  This is due to x86-32
machines without an extended CPUID range, where a CPUID(0x80000000) query
will just repeat the max-valid standard CPUID leaf output.

References: 8a50e5135af0 ("x86-32: Use symbolic constants, safer CPUID when enabling EFER.NX")
References: 67ad24e6d39c ("- pre5:    - Rasmus Andersen: add proper...")  # Historical git
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/d4fcfd91-cc92-4b3c-9dd2-56ecd754cecc@citrix.com
---
 arch/x86/include/asm/cpuid/types.h |  7 ++++++-
 arch/x86/kernel/cpu/cpuid_parser.c | 27 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/cpuid_parser.h |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 320f152675af..d0f0e6a8a457 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -33,7 +33,11 @@ enum cpuid_regs_idx {
 #define CPUID_LEAF_TILE		0x1d
 
 #define CPUID_BASE_START	0x0
-#define CPUID_BASE_END		(CPUID_BASE_START + 0xffff)
+#define CPUID_EXT_START		0x80000000
+
+#define __CPUID_RANGE_END(idx)	((idx) + 0xffff)
+#define CPUID_BASE_END		__CPUID_RANGE_END(CPUID_BASE_START)
+#define CPUID_EXT_END		__CPUID_RANGE_END(CPUID_EXT_START)
 
 /*
  * Types for CPUID(0x2) parsing:
@@ -211,6 +215,7 @@ struct cpuid_leaves {
 	/*         leaf		subleaf		count */
 	CPUID_LEAF(0x0,		0,		1);
 	CPUID_LEAF(0x1,		0,		1);
+	CPUID_LEAF(0x80000000,	0,		1);
 };
 
 /*
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index 80476e578fb8..be9c8571f886 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.c
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -27,6 +27,29 @@ static void cpuid_read_generic(const struct cpuid_parse_entry *e, struct cpuid_r
 		cpuid_read_subleaf(e->leaf, e->subleaf + i, output->regs);
 }
 
+static void cpuid_read_0x80000000(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
+{
+	struct leaf_0x80000000_0 *l = (struct leaf_0x80000000_0 *)output->regs;
+
+	cpuid_read_subleaf(e->leaf, e->subleaf, l);
+
+	/*
+	 * Protect against 32-bit CPUs lacking an extended CPUID range: Ensure that the
+	 * returned max extended CPUID leaf is in the 0x80000001-0x8000ffff range.
+	 *
+	 * Do not depend on leaving 'info->nr_entries' set as zero, but zero-out the
+	 * whole leaf output area as well.  This is due to the CPUID parser internals
+	 * using the __cpuid_leaves_subleaf_0() API to get the cached max extended leaf,
+	 * which does not do any sanity checks,
+	 */
+	if ((l->max_ext_leaf & 0xffff0000) != 0x80000000) {
+		*l = (struct leaf_0x80000000_0){ };
+		return;
+	}
+
+	output->info->nr_entries = 1;
+}
+
 /*
  * CPUID parser tables:
  *
@@ -46,6 +69,7 @@ static unsigned int cpuid_range_max_leaf(const struct cpuid_table *t, unsigned i
 {
 	switch (range) {
 	case CPUID_BASE_START:	return __cpuid_leaves_subleaf_0(&t->leaves, 0x0).max_std_leaf;
+	case CPUID_EXT_START:   return __cpuid_leaves_subleaf_0(&t->leaves, 0x80000000).max_ext_leaf;
 	default:		return 0;
 	}
 }
@@ -61,7 +85,8 @@ cpuid_range_valid(const struct cpuid_table *t, unsigned int leaf, unsigned int s
 
 static bool cpuid_leaf_in_range(const struct cpuid_table *t, unsigned int leaf)
 {
-	return cpuid_range_valid(t, leaf, CPUID_BASE_START, CPUID_BASE_END);
+	return cpuid_range_valid(t, leaf, CPUID_BASE_START, CPUID_BASE_END) ||
+	       cpuid_range_valid(t, leaf, CPUID_EXT_START, CPUID_EXT_END);
 }
 
 static void
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 48e962106d4a..c2b78badd67e 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -100,5 +100,6 @@ struct cpuid_parse_entry {
 	/*		  Leaf		Subleaf		Reader function */		\
 	CPUID_PARSE_ENTRY(0x0,		0,		generic),			\
 	CPUID_PARSE_ENTRY(0x1,		0,		generic),			\
+	CPUID_PARSE_ENTRY(0x80000000,	0,		0x80000000),
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


