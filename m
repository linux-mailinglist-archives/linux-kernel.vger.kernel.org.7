Return-Path: <linux-kernel+bounces-802840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64B8B4578F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11DA1753E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709D34F499;
	Fri,  5 Sep 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlxJQhgG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vqsGq0Ug"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7E352FEF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074570; cv=none; b=rmoqJPnYgtFEf2nCcEeShKxWbE5G7ABeJpG2MxSjWkmR96iA5hXTLssNItQoKc0ABZc5HgbxpKPZSzlvjJvZmVQcx+yzLFyhA4vhYkpUZsgdh+KdKdV4PVQOw2VutFVkQi+lC2VZZJhnp5QWW2RKnExLsSIv4kkG4+DA7/nALPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074570; c=relaxed/simple;
	bh=pU/luzQBHwvhqb7dLeNckRcAmDp6BWrUgIWG/nq96CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh+VxUlK96JZxTpWGGUsQ4D4pIgsjO6GbDbM9WzQV16Kysljj7v3GY5dYliAlT9ccO5zsVQOqrGF84h0fbRCJYyQ3TlCMEat0TZvah4VQ1nkQrmQ7U3zEEYzywmY32w9FicNSMyH3/rv42wwxb73a0PsU1FNWxQG4iUB+KkfjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rlxJQhgG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vqsGq0Ug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su531WO3n0s4MwXJfjSCSav6UVBxpZNRYIumkWYWlb4=;
	b=rlxJQhgGuxJK2x2N5W+CFEkcKhGLN+w1H6a5b1/G63WBf7XnqfwlLBesUj6A3OR2z1gxdT
	D66UvJW3s/Ay8HGCkxmRlbckldGtimxJykv2Yph45riPyOnZicQfwyTEfAqMaQQZiBfglx
	/GuWKNy7//ExCk6h1u4rsOVdpkgOFZimDso4M/Goy7dLg9mYYMn9kf022o0QtfHxFX2VUO
	29fMr/N3Yyp+nDoftTqR07zypy1xGNCa+GhMO4OAwW9t33G54SNozOgM3AJavOOPGyZmGF
	4gzJZTt2GzinfNzEpp4b34QgGkgwQUuGGBV3ExsF747ubLfJ3dvTvclefJDDpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su531WO3n0s4MwXJfjSCSav6UVBxpZNRYIumkWYWlb4=;
	b=vqsGq0Ugbqzc+dp4UcZDS7lObw+K1lpAdiavdOHiBl7KjFykxUyYdkLO1Y3dbxVPOiJVeq
	xMniOdck/EQ1IoAg==
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
Subject: [PATCH v5 15/35] x86/cpu: Use parsed CPUID(0x80000002)..CPUID(0x80000004)
Date: Fri,  5 Sep 2025 14:14:55 +0200
Message-ID: <20250905121515.192792-16-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For CPU brand string enumeration, use parsed CPUID(0x80000002) to
CPUID(0x80000004) access instead of directly invoking CPUID queries.

This allows centralizing CPUID queries, and the access of their cached
data output, to one place in the kernel.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0a0340a7ac1c..1d45dbdd0e05 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -780,16 +780,19 @@ static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] = {};
 
 static void get_model_name(struct cpuinfo_x86 *c)
 {
-	unsigned int *v;
+	const struct cpuid_regs *leaf[] = {
+		cpuid_leaf_raw(c, 0x80000002),
+		cpuid_leaf_raw(c, 0x80000003),
+		cpuid_leaf_raw(c, 0x80000004),
+	};
 	char *p, *q, *s;
 
-	if (c->extended_cpuid_level < 0x80000004)
+	if (!leaf[0] || !leaf[1] || !leaf[2])
 		return;
 
-	v = (unsigned int *)c->x86_model_id;
-	cpuid(0x80000002, &v[0], &v[1], &v[2], &v[3]);
-	cpuid(0x80000003, &v[4], &v[5], &v[6], &v[7]);
-	cpuid(0x80000004, &v[8], &v[9], &v[10], &v[11]);
+	for (int i = 0; i < ARRAY_SIZE(leaf); i++)
+		*(struct cpuid_regs *)&c->x86_model_id[16 * i] = *leaf[i];
+
 	c->x86_model_id[48] = 0;
 
 	/* Trim whitespace */
-- 
2.50.1


