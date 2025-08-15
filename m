Return-Path: <linux-kernel+bounces-770345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE2B279BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2191E4E2015
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0022F659E;
	Fri, 15 Aug 2025 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oBZXma/e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oy/hprgt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D02F49FA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241610; cv=none; b=EIp/gxCu55IeDz8/R+1F4c8eTWUFZRY8ZN5WhOV/FX2IDRfsuvMjoRK+X+QTsPAk2r0rO4DcjouLEYH+ugMTpz5JL/ODX5H8vxq9Ei4V2+gvozlS45CrUISln1q2zDWUgL0/7WUKCOic61iAB3gS2PxgAdGQbCJB6NdNaQcQTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241610; c=relaxed/simple;
	bh=bs6ID0keeNxIWVK/mx/m/477rleOKy/Zl9acDnCWP6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh7tfjhCnvV4qDxp+5s90QYLEJFD5QvooYCXpT7lJlVOmdSLOJYO9ykqBARi++dL7oAE5R8uKnn+gRCCSDSBFYCM3JSJRgcpVvzyyD1kkTwHwlcL0A92t1OLlbkrpn6BqdA+0w0b+k8QXgGfiwq8u46XDN//qzPzybiexiRxM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oBZXma/e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oy/hprgt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO2vKfKqIpHayIxNLlexjRsodB8SjGkLch6hqDcDpc8=;
	b=oBZXma/e+4JJ2F9n/FthtEMbNP/CblXrHHTmTgQxj0i86YpiuEw1zgMez/lsmsjysERgsV
	t82lnDmOeAswGoihHsepC+fvyoZZQyni8MX80WpICE0yrQ564TEpZ1Gi5YsPk3FqCMaFNY
	gzVNRRkMoM3DHqPNLIGaV9OgV3buAEXk4u7Gc/ed3aBD5pDUA3RI04TqdH63chb5O3HnBR
	inDyCqbwQP7cHLeAUEZmK+lJWlHfrKUK20ncIiMV5FpvOazTrKzEslbDtUJSx0cflzWoDz
	qxmPA+aWdRrBoDhyHFlYXXuiXkJ2fa29BzDAv49ALxEbRZeZYJGR0XEIYufizg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO2vKfKqIpHayIxNLlexjRsodB8SjGkLch6hqDcDpc8=;
	b=Oy/hprgtnkREdloitUOr4mrA0lkegN7eba9Tr5LZBEwO2yNVTHuvJIptAcc5Pwk84cl0Dq
	oWyheW/6xdTQWwDg==
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
Subject: [PATCH v4 32/34] x86/cpu: Rescan CPUID table after unlocking full CPUID range
Date: Fri, 15 Aug 2025 09:02:25 +0200
Message-ID: <20250815070227.19981-33-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel CPUs have an MSR bit to limit CPUID enumeration to leaf two, which
can be set by old BIOSen before booting Linux.

Rescan the CPUID table after unlocking the CPU's full CPUID range.  Use
parsed CPUID(0x0) access, instead of a direct CPUID query, afterwards.

References: 066941bd4eeb ("x86: unmask CPUID levels on Intel CPUs")
References: 0c2f6d04619e ("x86/topology/intel: Unlock CPUID before evaluating anything")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 06c249110c8b..fe4d1cf479c2 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -192,11 +192,14 @@ void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
 		return;
 
 	/*
-	 * The BIOS can have limited CPUID to leaf 2, which breaks feature
-	 * enumeration. Unlock it and update the maximum leaf info.
+	 * Intel CPUs have an MSR bit to limit CPUID enumeration to CPUID(0x2),
+	 * which can be set by old BIOSes before booting Linux.  If enabled,
+	 * unlock the CPU's full CPUID range and rescan its CPUID table.
 	 */
-	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0)
-		c->cpuid_level = cpuid_eax(0);
+	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0) {
+		cpuid_parser_scan_cpu(c);
+		c->cpuid_level = cpuid_leaf(c, 0x0)->max_std_leaf;
+	}
 }
 
 static void early_init_intel(struct cpuinfo_x86 *c)
-- 
2.50.1


