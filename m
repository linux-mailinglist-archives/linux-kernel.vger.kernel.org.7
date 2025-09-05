Return-Path: <linux-kernel+bounces-802837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF235B45783
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903061B21009
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355535209A;
	Fri,  5 Sep 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RPxaDtPU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpgHbB7x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897F350D7B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074564; cv=none; b=ibWUVUW660izs74GwnZchwnzYLDh7Pa5hWkMZOrJl4VavCdP344f1Ipbmas9aBPZy1zth625mSnADmT3BjTPEevujfU2YpO46aMr33ccoxy43TcUuv+nmTT6QTMc3UkmMwmmXVgsClYdl4kLiWbMPuyPxN9ve89GwOKkWN9lYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074564; c=relaxed/simple;
	bh=YE1zP9F3PJBAVUw+8cemB4kXR3Y9cKoz3JRrv1dxu68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke1ILSozuEUeqoYoTC62x3uxRPjt5N45AYEZKIefh/7Yz6uoo+ff7KD0trfOw4d6D4uX1jM48u7nrog+gJBbIHtfvUm0D+B45wyFlqg7snSazzl73Xsb0/ysNH+PDYyjMXN3lNoebUfhZV0Tn0tEldMiJxh2MsXEYvj3Ryb8BeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RPxaDtPU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpgHbB7x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVtzqcPzX3LElgpViGnnRqDbJ6yW0GrL6GmMecTYiO4=;
	b=RPxaDtPUJoAJBFyjSCiO2js7uiShxpE3hZwQsR5y0eukUnPOysGBQzg34CRBACKUkhiIqq
	IZIJu5YCpNmbIM+Cbst5dVPc3PQG1Rd9pnNot658x5s34PxiVXpp3ntiULGWDnVcVoCxds
	ZED8a0Qn1lpvn7ha4LZ17hEf17uzcBKQ8WS8RQOSR2W11TMeRFtDsIw/Rl6Xx4KETaTLFz
	n2mX/5DJJ2yAoOxigkcs//OiR2FiD+NlyKEULaU1S7MnjNg2OhvOVwTmtU7fnKfHLUxGRi
	ectnMh2Zo7xLA3XOriYEg6lE5P0Oj+GrsuWTiTxYF34J0jMtsPT9hvN49LZrYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FVtzqcPzX3LElgpViGnnRqDbJ6yW0GrL6GmMecTYiO4=;
	b=gpgHbB7xEokD//dMTmkFk3eV5DI0j0/rGsJm8S4z6MIqlt6K9DfNRS7G20Y3MxhhjaA291
	QA7d7xIJfNHj68CQ==
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
Subject: [PATCH v5 13/35] x86/cpu: Use parsed CPUID(0x80000000)
Date: Fri,  5 Sep 2025 14:14:53 +0200
Message-ID: <20250905121515.192792-14-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the early boot code, use parsed CPUID(0x80000000) access instead of a
direct CPUID query.

Note that the modified code has the check:

    extended_cpuid_level = ((eax & 0xffff0000) == 0x80000000) ? eax : 0;

to protect against Intel 32-bit machines without an extended range, where
a CPUID(0x80000000) query will repeat the max-valid standard CPUID leaf
output.  A similar check is already done at the CPUID parser's own
CPUID(0x80000000) code:

    if ((l->max_ext_leaf & 0xffff0000) != 0x80000000) {
        // Handle error
    }

Thus, for the modified call-site code, the parsed CPUID access NULL
check:

    el0 = cpuid_leaf(c, 0x80000000);
    extended_cpuid_level = el0 ? el0->max_ext_leaf : 0;

is sufficient.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f989c8099490..0a0340a7ac1c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -971,6 +971,7 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
+	const struct leaf_0x80000000_0 *el0;
 	u32 eax, ebx, ecx, edx;
 
 	/* Intel-defined flags: level 0x00000001 */
@@ -1006,12 +1007,8 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
-	/*
-	 * Check if extended CPUID leaves are implemented: Max extended
-	 * CPUID leaf must be in the 0x80000001-0x8000ffff range.
-	 */
-	eax = cpuid_eax(0x80000000);
-	c->extended_cpuid_level = ((eax & 0xffff0000) == 0x80000000) ? eax : 0;
+	el0 = cpuid_leaf(c, 0x80000000);
+	c->extended_cpuid_level = el0 ? el0->max_ext_leaf : 0;
 
 	if (c->extended_cpuid_level >= 0x80000001) {
 		cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
-- 
2.50.1


