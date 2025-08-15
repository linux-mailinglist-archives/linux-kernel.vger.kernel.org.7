Return-Path: <linux-kernel+bounces-770332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070FB279B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6D4AC4E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF862C3770;
	Fri, 15 Aug 2025 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wYD+Hi3/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cg4GvD4D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A12E889D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241569; cv=none; b=CGzq0qlXU9x42F6KLp9lI1kHQIGje7SRABfeyOmG3Ywjq8CfKzU3Zsu9+W6CS1zhtJPGQEbzEKgm8PcVYpr/o+m8f0n0KzaPsHUTONypSxHDASu5c37OEyYCUL1CpEHCRxa21sOD97G+qYd12sb+zXC6c5Iao5gMHtU9WnY4zrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241569; c=relaxed/simple;
	bh=3JgGac+wLi2t8hgJ5cs7uHeU+da7Ttsi4FfXEQS7jEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCOEonZKYfWPnIGJ8OTLnoPouiHCi7bIEgYbEYWkflmaY69CAueVgJNtBDIICZ3yPXRZ++YIWX/Bz8uCfujZEGafkOJTgVBnIzmLTiLN9ViJWadL081N41g/vIzObmO/oIz6pig8NVM8nqfauQr9qbfp7R6nop9Spc035ZYnW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wYD+Hi3/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cg4GvD4D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRQM0gtExWMEhiBSKGLu87ejkMzs1S3UQSqE31gfaWw=;
	b=wYD+Hi3/DjUEie8GboVIY0w45CtbfO2Ff/Zw4/Pq9M46fNjMOHReqha6nKJbE7M1ZLL8oG
	+PiZFNNPJRuEgdrwaUthQq6vty1jTZjThkNdqVdVCWjw+S7tgGC212dh/3GxD1uhQEKj9O
	J4w/AQnoAzYyIdn6Xu4fxOM3lTzB0TQpdGE4O/4vWny1VeM4Dej5oJTdX3YbNQjdAd33nP
	7/29NjuDXOS/1oYsofYhe4ySYheWHNUTveBLXMlbPR0HgDdS4JwHSK+qs/f/oQp0NceeWy
	dH20rDU3QBfq6qOv2FRx3QayVcF6i8x3NbnogOntdFo6vchbOtk0ds72RsIzNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRQM0gtExWMEhiBSKGLu87ejkMzs1S3UQSqE31gfaWw=;
	b=cg4GvD4Doqt7AYXnLzbVK/KdQfyDD8GfwdlmNOopfdiG8JMfjxerF3c5d7edCmQsz8+FfD
	ujzIFddsHRgHRLDA==
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
Subject: [PATCH v4 20/34] x86/cacheinfo: Use parsed CPUID(0x2)
Date: Fri, 15 Aug 2025 09:02:13 +0200
Message-ID: <20250815070227.19981-21-darwi@linutronix.de>
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
 arch/x86/kernel/cpu/cacheinfo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index adfa7e8bb865..39cd6db4f702 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -382,14 +382,14 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 {
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
 	const struct leaf_0x2_table *desc;
-	union leaf_0x2_regs regs;
+	struct cpuid_regs *regs;
 	u8 *ptr;
 
-	if (c->cpuid_level < 2)
+	regs = cpuid_leaf_regs(c, 0x2);
+	if (!regs)
 		return;
 
-	cpuid_leaf_0x2(&regs);
-	for_each_cpuid_0x2_desc(regs, ptr, desc) {
+	for_each_parsed_cpuid_0x2_desc(regs, ptr, desc) {
 		switch (desc->c_type) {
 		case CACHE_L1_INST:	l1i += desc->c_size; break;
 		case CACHE_L1_DATA:	l1d += desc->c_size; break;
-- 
2.50.1


