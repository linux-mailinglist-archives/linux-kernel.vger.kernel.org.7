Return-Path: <linux-kernel+bounces-802858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9824CB457A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC93160FED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ABA35E4C9;
	Fri,  5 Sep 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocVNo+6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpPzO952"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934735CECD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074634; cv=none; b=N7XnKSt6IBRMVeezIJamAeVOABzJdKfWer6rbez2jk1DKryPXgfGxbHC7bJTYRUQ4yrWa2rP0cJKjV+vtmenpy0bqSivpQp0cn8UcL0wKiPTbWLsVsIIJ4y4hlgCGJC3zCHUfGOnwVq0u0SILfkcOEga9q4fHQOjUe7uaYKMwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074634; c=relaxed/simple;
	bh=5fdcoPUvdlD524keF9ij+kOFiFaEcRqH8n3QFhInQ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1/Ura77ENItUlUzqNdCGRSrRnJzKGPBAHWgapemK5uaJvpLTJVPxaVIYx+9hSFM23mQ/BuYJnKygnzxUaLLIDm6dZDuKM8u4rLVvGMXpYTScIVjobAU4hjjc696QwsadRAhA4hcKV0FW4W9HUcjoyiIce2SM/FVd/hpxwrEXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocVNo+6h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dpPzO952; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGhLRPv3T2ZfPDukdKO031Z+Va1drrHlEhRJWLjPwzM=;
	b=ocVNo+6hk/Pj5iuH9R6lSi4kzrzJxE5SZItx+LEw6h/QfvvYPyysNXJ3MzoYYHRWlajOuT
	jQRiBmIsi8VBLmRz3/GNB+chmdcr+d0g2LpuBCphH9l+10J5bhie8O+ZLnRNY6clH4v9om
	VZq5pFsziBEZFlJHgfJfNqlcF0F3pqWhamz2fdd8Zvf3aCzAWclOeTh08r3MHY72IV05Q4
	8+9rfN/Aw4c87pe7Ojizp3P2RnYXhTocGm1U3xf7vdrvrY+yJGsHy9d62HO+Iwx+T4qbin
	e7rEhx+7DTyHZ1T6EO6V39Zi9lIxId3I27no3/g3x4wwCmFzQBZmbGI3OyTpoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGhLRPv3T2ZfPDukdKO031Z+Va1drrHlEhRJWLjPwzM=;
	b=dpPzO952CuExUeI21UhLjUOdiZxQFpvdzRVwC+HRK1Sw6LaCwQqKA+40Cf42LmK0Nmev5f
	Ldh4pK+JPT3b25CQ==
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
Subject: [PATCH v5 33/35] x86/cpu: Rescan CPUID table after unlocking full CPUID range
Date: Fri,  5 Sep 2025 14:15:13 +0200
Message-ID: <20250905121515.192792-34-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
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
index dd284ece0de0..ffaba5a378f5 100644
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


