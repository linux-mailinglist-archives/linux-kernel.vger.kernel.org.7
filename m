Return-Path: <linux-kernel+bounces-770331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C44CCB279AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DE118826AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2272E8E1B;
	Fri, 15 Aug 2025 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OgBzUVga";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2stfjP2H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D182E7F22
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241565; cv=none; b=ttRZWz3943qu1C5dvgDdiLaAbkAFVr3jhqDtYyURQw0Cr6MAaZjgSeg2YQh41AfCZjTyC7DHGU2Adau01oHple5DocIIH1emaLMUYQZxOlqiALXuMhhsQ1yFrqDergjk1auPcq1UchXRQbTN3q7bH2pS90vJFLOd6c7JdzWBe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241565; c=relaxed/simple;
	bh=CPwt7tAmjsTsX1vXCApyLVizG83Rn5+DAyoFNbGuJjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+MFRcjqf5KzXjTLrZHmtCLSgDR2Da+flEWcIeoaXlmFga8y7Zpsd7ejPWRSGctYxgmBFBL7adYJSXDehj2NdRLK+QhqeYQnYJCNYVqWKw2yYVJUvB9Fd+NAfDcXC1QHqZduJ9PjypxuMpPvJukM6IpsK417YOD8HDQiD2+LMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OgBzUVga; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2stfjP2H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FmTJ9/rl5HA0Hu5v4rlLAGUGAO4sGRS8L1AAbKLcQc=;
	b=OgBzUVgalD4UGe7XFKlQJ/rT091wuPjk/dePtTLR+ijiafuoLD7eJCrmDGU7bqyhzMBKf7
	HCmUXNkUhKz7LSmQk2h+vQVMusqRQdsuUt1kmquKUMRNNhrMJZWOpZeFwPpz7n44A96cN+
	E1uLv6ax6eZm2oUBl7eBpF1LNA3Gb/c9mJtTokgOeMEikPNZaH2symKPlAo3nWR5S4gCQ4
	T6ZK9WpJfJNwSVviY5jn2BjJjn3Y2gIRWp/EUWjWSh+K5FfSpicLx8WoMcLDeBuvzTbvMD
	BpNClxmiJwXL8r9578gLb/clpqRuRusBq8RyQU8cF1dgJtAJ+tp8hGS9cNiQwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FmTJ9/rl5HA0Hu5v4rlLAGUGAO4sGRS8L1AAbKLcQc=;
	b=2stfjP2HfLZhA/Qq9KBYi27UioWqV+vPmE1+XZYOeBX/KNbBev4vHbc1xpUMXtdz768cRS
	OgPq4Ny323dFsRBQ==
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
Subject: [PATCH v4 19/34] x86/cpu: Use parsed CPUID(0x2)
Date: Fri, 15 Aug 2025 09:02:12 +0200
Message-ID: <20250815070227.19981-20-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use parsed CPUID(0x2) access instead of direct CPUID queries.

Remove the max standard CPUID level check since the NULL check of
cpuid_leaf_regs()'s result is equivalent.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 076eaa41b8c8..5eab9135b144 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -710,14 +710,14 @@ static void intel_tlb_lookup(const struct leaf_0x2_table *desc)
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
 	const struct leaf_0x2_table *desc;
-	union leaf_0x2_regs regs;
+	struct cpuid_regs *regs;
 	u8 *ptr;
 
-	if (c->cpuid_level < 2)
+	regs = cpuid_leaf_regs(c, 0x2);
+	if (!regs)
 		return;
 
-	cpuid_leaf_0x2(&regs);
-	for_each_cpuid_0x2_desc(regs, ptr, desc)
+	for_each_parsed_cpuid_0x2_desc(regs, ptr, desc)
 		intel_tlb_lookup(desc);
 }
 
-- 
2.50.1


