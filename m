Return-Path: <linux-kernel+bounces-802846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B86B4578A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB3A1C871B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D21DA21;
	Fri,  5 Sep 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSS6XjTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VuUY4Ebw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C5356909
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074590; cv=none; b=JSBe4UoEvQWj9JgpNgnSZNqWFVcYw8bsSNIyx0XskDGiCtAA+obkd3g8hxmo4+nNuj2ZF9sepMmd0GgQUZrDutBnu+GbWhnQ40mGHaLIA9EK4gaOiIo2m2HC76AGHO0DTWB9zGsqyvcK6uXt/99BTyX38EK8epwV0NmWD4iyXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074590; c=relaxed/simple;
	bh=jNgEx2eDog9agelm0hZ1d2Hksj0ecKsAQbeVdX6jQcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSzvxQELIZSLoIeSGeZZKX/5l352qkP9umli+tY+QlOo4QKPbIJBD5BavJGoHLW0hHmVJmppfOZgBWXCYpxEffQVaM2Tqfgo+6Ef/VStnxM3v4QlRhwN+8zZBY3DvR1hCdzbTL8ffb2pdlkQyJMjc1s4jp48/9bMceij0Rra0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YSS6XjTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuUY4Ebw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtKNAecyTmIQEvsVids3IFeQilSYo0cBXCC3LBkklLc=;
	b=YSS6XjTk/fqWbAswF9vdydJiw0IOncAxCRw99zdHTKDl1eg0jqfnEDum5bEufX+rPhWiMp
	znhJxyQawUVj4AyFR2Gk+/KHfmvn/sul4l/TEbRYQG/pvpn8ODWQReGhJ/QbFUYK5VWXvo
	Ag6cqnAg/4rnnN7y+c6OqElkzuLQCcES9UEo9Uy/OvrRGvmueB01nTF4pVSpHj+BQWM3FL
	T7nYUAuYc0k5DtmbgrtR/FO2/G4FXsSXxid3rufspDrTiwoDDH209O9nxP7u8sMbAMqY/s
	yKJwRoB9KQv2+awpbaLwRXnzOXNTbvFutSNpdJbdlo+nAVvnqHo2w3dRaaF1Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtKNAecyTmIQEvsVids3IFeQilSYo0cBXCC3LBkklLc=;
	b=VuUY4Ebww20rmu/VDBW6IvEafbuv0+Gs1lzIQcb8Xf99P9b5SxFZefwtFsvnlcXu3FCdJg
	1t1Bw7p9/MMaUPDg==
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
Subject: [PATCH v5 21/35] x86/cpu: Use parsed CPUID(0x2)
Date: Fri,  5 Sep 2025 14:15:01 +0200
Message-ID: <20250905121515.192792-22-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the Intel cacheinfo code, use parsed CPUID(0x2) access instead of a
direct CPUID query.

Remove the "maximum standard CPUID level >= 0x2" check as the parsed
CPUID API output NULL check is equivalent.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 98ae4c37c93e..7078b4264294 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -710,14 +710,14 @@ static void intel_tlb_lookup(const struct leaf_0x2_table *desc)
 static void intel_detect_tlb(struct cpuinfo_x86 *c)
 {
 	const struct leaf_0x2_table *desc;
-	union leaf_0x2_regs regs;
+	const struct cpuid_regs *regs;
 	u8 *ptr;
 
-	if (c->cpuid_level < 2)
+	regs = cpuid_leaf_raw(c, 0x2);
+	if (!regs)
 		return;
 
-	cpuid_leaf_0x2(&regs);
-	for_each_cpuid_0x2_desc(regs, ptr, desc)
+	for_each_parsed_cpuid_0x2_desc(regs, ptr, desc)
 		intel_tlb_lookup(desc);
 }
 
-- 
2.50.1


