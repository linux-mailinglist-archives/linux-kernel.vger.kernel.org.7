Return-Path: <linux-kernel+bounces-802836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F6B45787
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732BB1654DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AC34F46D;
	Fri,  5 Sep 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b4m5mJxC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVpv5YJ5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3742352075
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074561; cv=none; b=V5laqWgQyMrYsqTnRz5C1SY9AJqDnIJ5AYUDbmfVgCStTdiPjk/RGYuatovLya6YrvpAJJZCP1QngOzeghgNgYr2PTA+9vLpP8+boOCACpHBSz76ce2Mlot7a5QnLKGoQsQQI9zrHOXQDiCt52fNmjqh01Ysf6IQ+IKTUsnrchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074561; c=relaxed/simple;
	bh=I1leyWVm0tz3zHKIhmHsfiXis5rK21DFkRDwhPEuJBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R//295E5nCr0+VEDe1fi2ry6TV2uNAOXniwH+sNHR7904WfrvQFHSIS5ik26KXoOOUP6DbtlbQ0Nayfy41VlKAHk2vCVAXvorg6zKHJf3Qlh6kH7lqEEvtoMJjvwYWEXYZ7TDLLvLFgYSvIDv5590gXVK/9/kKWZQieCuBXxiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b4m5mJxC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RVpv5YJ5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymPEj5IwoeEiVyTDVAlIcYp8+kC3Z0KCzQGCWXoVM90=;
	b=b4m5mJxCSmiRBhVdGUux+CWtR1rOrSIwR81M8v1r6WHylrWxP2m6ZqDoIYOzFeb5OGOZ2m
	e1tKd/WUtzXonzqmp03KGv7oSr1Ls7O+G76QXqmz1hfafxBgz8pKfC+Z64UIXlAyLQ3ogo
	CiHYct5R3YOcrkqYX5w6Yv/LwfTVPuD0avIP4ruJa4cGUSOoZwKjV7466BdPr6ckRaapxp
	zXKGIlp1fQzu1CVBRolzkDdHNggycNfHQuLqCjDOZCuVvzVEIniYmE4inJe1P3ZgxtlcxV
	1YhdU0R+z+RwzYbczp55SXQLV+V9gKAGjgdUc+3IrTAv8tlG/nUvRdOjCXhpxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymPEj5IwoeEiVyTDVAlIcYp8+kC3Z0KCzQGCWXoVM90=;
	b=RVpv5YJ5nn4Kgtm/hK88YaYxOEvzVDheqZa10ZUcG0Uf6DYcQKH4vmpzcRj4n6VJu/t6yb
	xKSH9Lj84j5I3CAQ==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v5 12/35] x86/cpuid: Parse CPUID(0x80000000)
Date: Fri,  5 Sep 2025 14:14:52 +0200
Message-ID: <20250905121515.192792-13-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPUID parser logic for CPUID(0x80000000).

Verify the query output beforehand, since legacy 32-bit Intel machines
without an extended range will just repeat the output of the highest
standard CPUID leaf available.  This is similar to what is done at
arch/x86/kernel/head_32.S and arch/x86/kernel/cpu/common.c.

References: 8a50e5135af0 ("x86-32: Use symbolic constants, safer CPUID when enabling EFER.NX")
References: 67ad24e6d39c ("- pre5:    - Rasmus Andersen: add proper...")  # Historical git
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/d4fcfd91-cc92-4b3c-9dd2-56ecd754cecc@citrix.com
---
 arch/x86/include/asm/cpuid/types.h |  7 ++++++-
 arch/x86/kernel/cpu/cpuid_parser.c | 22 +++++++++++++++++++++-
 arch/x86/kernel/cpu/cpuid_parser.h |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 9b8bd6b22ff3..e57245ca6419 100644
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
@@ -232,6 +236,7 @@ struct cpuid_leaves {
 	/*		Leaf		Subleaf number (or max number of dynamic subleaves) */
 	CPUID_LEAF   (	0x0,		0  );
 	CPUID_LEAF   (	0x1,		0  );
+	CPUID_LEAF   (  0x80000000,	0  );
 };
 
 /*
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index 15264696eaad..9c40c180e3d4 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.c
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -27,6 +27,23 @@ static void cpuid_read_generic(const struct cpuid_parse_entry *e, struct cpuid_r
 		cpuid_read_subleaf(e->leaf, e->subleaf + i, output->regs);
 }
 
+static void cpuid_read_0x80000000(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
+{
+	struct leaf_0x80000000_0 *el0 = (struct leaf_0x80000000_0 *)output->regs;
+
+	cpuid_read_subleaf(e->leaf, e->subleaf, el0);
+
+	/*
+	 * Protect against Intel 32-bit CPUs lacking an extended CPUID range. A
+	 * CPUID(0x80000000) query on such machines will just repeat the output
+	 * of the highest standard CPUID leaf.
+	 */
+	if ((el0->max_ext_leaf & 0xffff0000) != 0x80000000)
+		return;
+
+	output->info->nr_entries = 1;
+}
+
 /*
  * CPUID parser tables:
  *
@@ -45,9 +62,11 @@ static const struct cpuid_parse_entry cpuid_parse_entries[] = {
 static unsigned int cpuid_range_max_leaf(const struct cpuid_table *t, unsigned int range)
 {
 	const struct leaf_0x0_0 *l0 = __cpuid_table_subleaf(t, 0x0, 0);
+	const struct leaf_0x80000000_0 *el0 = __cpuid_table_subleaf(t, 0x80000000, 0);
 
 	switch (range) {
 	case CPUID_BASE_START:	return l0  ?  l0->max_std_leaf : 0;
+	case CPUID_EXT_START:	return el0 ? el0->max_ext_leaf : 0;
 	default:		return 0;
 	}
 }
@@ -63,7 +82,8 @@ cpuid_range_valid(const struct cpuid_table *t, unsigned int leaf, unsigned int s
 
 static bool cpuid_leaf_in_range(const struct cpuid_table *t, unsigned int leaf)
 {
-	return cpuid_range_valid(t, leaf, CPUID_BASE_START, CPUID_BASE_END);
+	return cpuid_range_valid(t, leaf, CPUID_BASE_START, CPUID_BASE_END) ||
+	       cpuid_range_valid(t, leaf, CPUID_EXT_START, CPUID_EXT_END);
 }
 
 static void
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index acddcbc9bd06..39a361eed7ce 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -111,5 +111,6 @@ struct cpuid_parse_entry {
 	/*			Leaf		Subleaf		Reader function */		\
 	CPUID_PARSE_ENTRY   (	0x0,		0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x1,		0,		generic			),	\
+	CPUID_PARSE_ENTRY   (	0x80000000,	0,		0x80000000		),	\
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


