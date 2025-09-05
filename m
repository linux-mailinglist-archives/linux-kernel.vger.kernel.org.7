Return-Path: <linux-kernel+bounces-802835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C1B45786
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D63A60143
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95B35206A;
	Fri,  5 Sep 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZBeV/DaU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qfa75l7X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E6350D5C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074558; cv=none; b=WvqmDyVDQqbf81Vhhu37ncyHXc95XD4SvEiFddrRwgI6VVEi0N1N6LKAB+0lHuT+JG//HE9ab101MmVUMtn0cNevGCPANWrdPS+kB+o2gQRpYkrrRa2DY+rjDu6nv7CVAsPvK7J+Dxm1/trFGQHygwUJ/W0a1kRzhzCJqCpzaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074558; c=relaxed/simple;
	bh=ZbKPGgCVpT+HjHVyzGSP+eVNuk0jQWeGMUV8pTv848Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuWw7Gi05uTvNPxlqW6deZM90Kho93L29umfUVysRcr3eGUT81sLDF9+yOrn3scW3b+081yn2PwZfQicfGry0pCG5d1E+58pZ+Crd+cGKp01x+ZPP1qCsQgEcmjRjOs+BGcQ86MuMWirknr6RKALqddkpcYlL2EKYNeIJi36auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZBeV/DaU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qfa75l7X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYzQQ5I5COAby63SgxsfwehP/5pmXdd+M0EHhhjXcF0=;
	b=ZBeV/DaUfTD2QtelW1J9Mta2FmAmbUBuEvg0ogZA7P0iOedXebHdh3dyyLsCLzdzAKmo7b
	kwNPxRcPGNH8ivvA2GabRBUDuoYSjYH5zP5VcERzUL3YfUA/9XmvjW5yFesXyzhC50zSaR
	X/6ZsRbOaxUwsp+jUPC9m3hEkgFHSdUfwdnh5QxxZkaRSPN5vcmhcCwEWw4Ok82CleoKG2
	EilnjXZiqjSV+2WRuksCnkbAQrX0D1wfe6DzMVpYYCwBHUJaqyO1et8N2MtUtPaSDRdb9F
	f12tVpp7A1GC4VbXJffz8Dmb/xOicWGGMDV2ZwRhYLC9ptr4HjJROeremuE7wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYzQQ5I5COAby63SgxsfwehP/5pmXdd+M0EHhhjXcF0=;
	b=qfa75l7XV/kmSUDna6aG6j6k4oudYNLLJ0I4LNDBBpBODmBxcwJ5VzDjKcQYvPJ9rIuNmc
	wcP18nrjVprxT5Bg==
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
Subject: [PATCH v5 11/35] x86/cpu: Use parsed CPUID(0x1)
Date: Fri,  5 Sep 2025 14:14:51 +0200
Message-ID: <20250905121515.192792-12-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the early boot CPU detection code, use parsed CPUID(0x1) access
instead of a direct CPUID query.

Beside the CPUID parser centralization benefits, this allows using the
auto-generated <asm/cpuid/leaf_types.h> data types, and their full C99
bitfields, instead of doing ugly bitwise operations on CPUID register
output.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e081f92ddfe9..f989c8099490 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -897,6 +897,7 @@ void get_cpu_vendor(struct cpuinfo_x86 *c)
 void cpu_detect(struct cpuinfo_x86 *c)
 {
 	const struct leaf_0x0_0 *l0 = cpuid_leaf(c, 0x0);
+	const struct leaf_0x1_0 *l1 = cpuid_leaf(c, 0x1);
 
 	c->cpuid_level = l0->max_std_leaf;
 	*(u32 *)&c->x86_vendor_id[0] = l0->cpu_vendorid_0;
@@ -904,17 +905,14 @@ void cpu_detect(struct cpuinfo_x86 *c)
 	*(u32 *)&c->x86_vendor_id[8] = l0->cpu_vendorid_2;
 
 	c->x86 = 4;
-	/* Intel-defined flags: level 0x00000001 */
-	if (c->cpuid_level >= 0x00000001) {
-		u32 junk, tfms, cap0, misc;
 
-		cpuid(0x00000001, &tfms, &misc, &junk, &cap0);
-		c->x86		= x86_family(tfms);
-		c->x86_model	= x86_model(tfms);
-		c->x86_stepping	= x86_stepping(tfms);
+	if (l1) {
+		c->x86		= cpuid_family(l1);
+		c->x86_model	= cpuid_model(l1);
+		c->x86_stepping	= l1->stepping;
 
-		if (cap0 & (1<<19)) {
-			c->x86_clflush_size = ((misc >> 8) & 0xff) * 8;
+		if (l1->clflush) {
+			c->x86_clflush_size = l1->clflush_size * 8;
 			c->x86_cache_alignment = c->x86_clflush_size;
 		}
 	}
-- 
2.50.1


