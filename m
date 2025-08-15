Return-Path: <linux-kernel+bounces-770321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB479B279A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862083BF3D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61122DC32F;
	Fri, 15 Aug 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NThzNQd1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wwsp9IG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBED2D97A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241536; cv=none; b=NIE0SH+7fip5FQVsCnV0KGkDHkaK+6M6xzE8nsM1ovYMuvm7nKfrW/xd84Kk/gsma1RaO0z7hkQtSXuZ4R7sBZ6LKX3MMRmvkfLciRrwoI1Ocxi7Y9oFppLrog80PoYTuKeWbZARVQplQyVOEdQYNjw9SM1YTTL/+wCD0IDPcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241536; c=relaxed/simple;
	bh=GZR8RHQZex4Pd9dmQhrZYFm58mezVjJewpqZgR2DRr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE5Bok9MzJRKRVQY5zD3vpjKYwqyXZXCkE1BDJlPH8hzy4inq59vXcEvQcrFLWinyvvU9f/lXjq06YNMJDtPcnjhe0OOafd+0ezZZgHhAEnRCi0toKTwXbLC+jrVj7QhsGBkI2sUH8qqodntNSpNDtrG6EAeylKf8nIQaQlsoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NThzNQd1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wwsp9IG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FmzRFTeoeh2phfMhf2hDpLbShwrkipDxrnDX8PpCbU=;
	b=NThzNQd17rDXt9ZUYOXY2s7RlB/tyWtnG6qCHH0ExKWVedm31YPHr63aYOS27AXUiv+q76
	7KF+ZHV6aEkBvvvA134QV08nY+vn/WbImgnAk9WRJf33nwT07JExuPWBvW/6xJXWuYcnT0
	MDyCm1uIlcZ/5vKTSXl8Nwg2qxZlhFWrwxfUgn7ptOC052JNw7e4/MRs41eHOgjhDnAfFY
	MEkIWZzOq5ublt1lrKdr3H4ChSEBix9m0b6Mgn90+YVMYiHvi9NH2uHq3ba2T2I70pZY6u
	mVBe4se6cldCajyPOe1ZGuzk7g8aFRm7Y1uIrkvcYR/TT6x1MEU+YXJ9XNOIaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FmzRFTeoeh2phfMhf2hDpLbShwrkipDxrnDX8PpCbU=;
	b=0wwsp9IG1TDB8A/5PRVnrEEH39AgLS+cnyOfRgj3+eLTd50sLz58bWUj7hpvzHAZeUe2eV
	1IeDE+onZS1kbiDQ==
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
Subject: [PATCH v4 09/34] x86/cpu: Use parsed CPUID(0x0)
Date: Fri, 15 Aug 2025 09:02:02 +0200
Message-ID: <20250815070227.19981-10-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use parsed CPUID(0x0) access instead of a direct CPUID query.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 43582d7e167d..e081f92ddfe9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -896,11 +896,12 @@ void get_cpu_vendor(struct cpuinfo_x86 *c)
 
 void cpu_detect(struct cpuinfo_x86 *c)
 {
-	/* Get vendor name */
-	cpuid(0x00000000, (unsigned int *)&c->cpuid_level,
-	      (unsigned int *)&c->x86_vendor_id[0],
-	      (unsigned int *)&c->x86_vendor_id[8],
-	      (unsigned int *)&c->x86_vendor_id[4]);
+	const struct leaf_0x0_0 *l0 = cpuid_leaf(c, 0x0);
+
+	c->cpuid_level = l0->max_std_leaf;
+	*(u32 *)&c->x86_vendor_id[0] = l0->cpu_vendorid_0;
+	*(u32 *)&c->x86_vendor_id[4] = l0->cpu_vendorid_1;
+	*(u32 *)&c->x86_vendor_id[8] = l0->cpu_vendorid_2;
 
 	c->x86 = 4;
 	/* Intel-defined flags: level 0x00000001 */
-- 
2.50.1


