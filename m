Return-Path: <linux-kernel+bounces-770325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF09B279AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AF9B61030
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BAB2E3AFC;
	Fri, 15 Aug 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hSpmWnGd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Exq/h+mD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175302E36E1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241547; cv=none; b=u5dIUIzDrFz6pPamsa3bmMWRj7aD8CcdB5CeCy+jWNnzY2z3X84VVJpc0XXgD5mM1CVsCAfnxOvpuSIVfUeAeA19r+zyqxWwrB+uvHRVJI+4AA72ic1C6G4oOl6CaFkS9V2vutmQqsEqwJ92JrO9Ev2xLhe9N6FBv/VlsMq8i2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241547; c=relaxed/simple;
	bh=TsepN/EN4yDneUnLhlfnROZ/pgzLY1M8ub/dQ0YSiVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUKpc3nfL3btZAikd0zASp00ADu4xNWkicNWz6m+rGkVKa1z6OvNtpHGumZUPFsZP8mfYu/UeAH5uPVjSXzHkVXVkGreiYg9KDGU+rJxUZ0xoN6UM21SM/1SODGbjhdHSQTQ59zSNgo56CRtt7NuOAqL9eOdbsKjyDNXcVAJPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hSpmWnGd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Exq/h+mD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOnzDrwMeCT8sT2NClHc7gMvrFgWabPLEjgLirDzaDM=;
	b=hSpmWnGd/JS0DRy2+5AvSwPQpeo6HJREoSkRNNAkyiejyYv5+NSZjAItAuC0S+zCuuymZL
	ZlJ9PRuZiU+x634j2BHt0rRvq45nESeU5EBUal0085DFy+S+Ph9rE6mNVCCI4ZeJN1seN9
	1pxbkTmRAuvtcnL9Gzk2mlbNJIkiuOr0Oo/1/FLE8/pmAB+ih7fM0VASQCAGuZp+vmLDYY
	vxj1SvDM5ZjuHb2WSnJRYH5WvF9gCrSPhTAibv2Rh5WEC9YIFXLIBZVJedqzzl/rowwTVG
	FAK6Z+Xz2pkMJhJYAgqBHfEPrpG5BVtov6x2oYG0OgQczNiZtyJ4zvEAcEEd2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOnzDrwMeCT8sT2NClHc7gMvrFgWabPLEjgLirDzaDM=;
	b=Exq/h+mDarBWc3rot0ymYTrkTtoHDW/2Y1uG7u4dHr68816GTu7MR1TTR3mz5x8wrGxUpF
	3A6TN5a38EoKwLBQ==
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
Subject: [PATCH v4 13/34] x86/cpu: Use parsed CPUID(0x80000000)
Date: Fri, 15 Aug 2025 09:02:06 +0200
Message-ID: <20250815070227.19981-14-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use parsed CPUID(0x80000000) access instead of a direct CPUID query.

The affected code has the check:

	(eax & 0xffff0000) == 0x80000000

to protect against Intel 32-bit CPUs that lack extended CPUID support.  A
similar check is already done at the CPUID(0x80000000) scanner read
function at cpuid_parser.c:

	/*
	 * Protect against 32-bit CPUs lacking extended CPUID support: Max
	 * extended CPUID leaf must be in the 0x80000001-0x8000ffff range.
	 */
	if ((l->max_ext_leaf & 0xffff0000) != 0x80000000) {
		// Handle error
	}

Thus, just check that the parsed CPUID macro:

	cpuid_leaf(c, 0x80000000)

does not return NULL, thus providing a sanity check similar to the
original code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f989c8099490..6b5a4dd2f33e 100644
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
+	c->extended_cpuid_level = (el0) ? el0->max_ext_leaf : 0;
 
 	if (c->extended_cpuid_level >= 0x80000001) {
 		cpuid(0x80000001, &eax, &ebx, &ecx, &edx);
-- 
2.50.1


