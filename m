Return-Path: <linux-kernel+bounces-802844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDFB45790
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328027C494C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F03353360;
	Fri,  5 Sep 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NuYZb7Kx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w8saUylo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66235335C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074582; cv=none; b=Qc5z0kHtbMeXCWceuNzGL86ngfhtP2zNSBif2agM6EyF13PTmrMhPzvbAWTfCHy2vVOKEOT43LyG3bdqIRDjxO7Uke6GlQqO8G+vdavPPlF2cL8j+jxe7pRSsBksb4Dm37dvSDfZm2TN7/6bHHK+jrDfkGfUBJ6V5Hz+dEgpfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074582; c=relaxed/simple;
	bh=qMdf1jyQL5UirNvEw2ynQa1R8TT/nSoa8qDmigWq32Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRJ4E02LNMUpIzLRgJ9cVZI1xZkM/Q7bPYOjCVHTP7RwmnC9gWo5phpC8ZEjaiIo4/qOVyq2dP5CAeFzAAHo5Rkz/SCqQ4/bh1JTQ/xTsG66v5aqoUSYUy5sqHVio7EMeuwTajyq/wgDv8KkGROQh+YzBn3qNm7Sqg47KEueCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NuYZb7Kx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w8saUylo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDI4umHATVRZl01ao44nBPkXLxRk1y7+6juPw2qjVBQ=;
	b=NuYZb7KxuHCOYdDywJVM6B2fLz/G1Lo5XEAe5iey2ezti6i1Cl3fNYJtGxCPVWU65y88wO
	YD4cooJjctbffQmkRfzI4dL0G9A2e/6UhPj9cMSjZZigfvft/sZ5/nrTFSg6uS8/ZaPxQn
	rfwbjBjjVkYOt2yBgKTl1FrVSgTXNhdQ3lRIcErK4b5vABIxvkfSNOf6nsXhT6rpIjGYaA
	U+guEBBQLmpOZeA8pHJfXpctZ6WW9w0YqZFbi0GZvtk/THLz5TkcKW/d1hLHrLy8vcgjhg
	pZmqHSQxmuTCZx0MqDSmUsJ9vQazn8xT4O9bTqRESKpRzLkB/6wzfwGHuhy8gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDI4umHATVRZl01ao44nBPkXLxRk1y7+6juPw2qjVBQ=;
	b=w8saUylo52W004kLpRqMVxS2Q4oRp8yLjicwpCFL5M2gGj+GE3wYRTyhprobet4Jh5pNr4
	fiqHUw7bZ+U2dOAg==
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
Subject: [PATCH v5 19/35] x86/cpuid: Warn once on invalid CPUID(0x2) iteration count
Date: Fri,  5 Sep 2025 14:14:59 +0200
Message-ID: <20250905121515.192792-20-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPUID(0x2) output includes a "query count" byte.  That byte was
supposed to specify the number of repeated CPUID(0x2) subleaf 0 queries
needed to extract all of the CPU's cache and TLB descriptors.

Per current Intel manuals, all CPUs supporting this leaf "will always"
return an iteration count of 1.

Since the CPUID parser ignores any CPUID(0x2) output with an invalid
iteration count, lightly warn once about this in the kernel log.

Do not emit a warning if any of the CPUID(0x2) output registers EAX->EDX,
or even all of them, are invalid; i.e., their most significant bit is
set.  Such a case is both architecturally defined and legitimate.

References: b5969494c8d8 ("x86/cpu: Remove CPUID leaf 0x2 parsing loop")
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/lkml/aBnmy_Bmf-H0wxqz@gmail.com
---
 arch/x86/kernel/cpu/cpuid_parser.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index 6efe594b9f2b..f7dc5c78b06b 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.c
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -3,6 +3,8 @@
  * Centralized CPUID parser (for populating the system's CPUID tables.)
  */
 
+#define pr_fmt(fmt) "x86/cpuid: " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 
@@ -42,8 +44,11 @@ static void cpuid_read_0x2(const struct cpuid_parse_entry *e, struct cpuid_read_
 	 * keep the leaf marked as invalid at the CPUID table.
 	 */
 	cpuid_read_subleaf(e->leaf, e->subleaf, l);
-	if (l->iteration_count != 0x01)
+	if (l->iteration_count != 0x01) {
+		pr_warn_once("Ignoring CPUID(0x2) due to invalid iteration count = %d",
+			     l->iteration_count);
 		return;
+	}
 
 	/*
 	 * The most significant bit (MSB) of each CPUID(0x2) register must be clear.
-- 
2.50.1


