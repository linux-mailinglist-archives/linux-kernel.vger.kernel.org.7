Return-Path: <linux-kernel+bounces-770329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C862B279BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9041B6454D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10092D3229;
	Fri, 15 Aug 2025 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aySKjT47";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EXNy8kTb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612422E54D9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241561; cv=none; b=n6IRUJ24Xp3BKs2DXkrkVIBoOq+JIYN0cJ+DMCMtM+FHoyUQqdEPPjGGH3NvXCyVc/8v6X3Ao24ANyuNo19OUCWVWotcJpazIl3GJVRRw83+RrMRyvgIBOWEYEXVxOyOavQnLlNcsuSCzneoEMQcuFe4/MgTdkvBc8B5LvQY57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241561; c=relaxed/simple;
	bh=3sQ9xVRZdQttfg4JY5cFzs7tV82zFAHsRAFdqgF+bzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7dpFz7W1HVvXW6mVmdJKSJAKCZBNUpo41SDUbxnjFDL49LuY+X97RPqVfyQWrJjCoOeDIrZqUaSZ6hHLXiTSWoNgDeXsfTrq8yAag/gy/8adDIvK+EqKsqvCHOgrE5HIjcXl+v1m+3MHOb5c5X5OIT9SrF4ORe7EMwzcaSu/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aySKjT47; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EXNy8kTb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ArmXJNOuP+8K8NlkOZ1FWJcqOliXbq1/hLPTGJXSCU=;
	b=aySKjT47QGllfHd2NvpsBTgNLhAz1A9Z94BYoA8HBeUdT+9I3SfBWu5AXja4X0RsUZL1Zc
	vfOPoQPTHR617k+XWtg02p3/ISWreBvO0VN/1hcCTju+UtxAUAPfDl9ItUDjuWK7HhGKGt
	sdQWL+C6UBGy+06MqBx49JKusO2FwE0C9goREpik/AiGIROoxaeqM44+zh9nFgU48APhhq
	kPPiVDCkZZ8jUSeh1AtEYFoqefIz6RHuIoCfs1u/UgoIN6WcpzLTYJp1HnlOT5yT7jL5h5
	PZlWItB8NT1xNIvsGmajmc6pRPT0omKWDvA4keB2jJxDTWMJvnQvBg+iFudevQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ArmXJNOuP+8K8NlkOZ1FWJcqOliXbq1/hLPTGJXSCU=;
	b=EXNy8kTbLU+PcyemRiVLHa62yRvd2wH+C5NIcGLM//J4jb8Lsh1ZXElyXUrNV29GUf3fTx
	ggDAeIUpJW+8g/Aw==
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
Subject: [PATCH v4 17/34] x86/cpuid: Warn once on invalid CPUID(0x2) iteration count
Date: Fri, 15 Aug 2025 09:02:10 +0200
Message-ID: <20250815070227.19981-18-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
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
index f3dffdd43779..c340ad6eca3d 100644
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


