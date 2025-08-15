Return-Path: <linux-kernel+bounces-770330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81532B279B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1495C6A52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD72E7BBE;
	Fri, 15 Aug 2025 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGKMAvtA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EwZ3bJrY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8C29A303
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241562; cv=none; b=Qr2/xeUUdvBwonHpTzDiHXEQwIi+0NCfru2cAGJqgTBGYVYyxdK7Ol3m1saOx8xcoMhD1FreeChQAHQG1QGyp+S2QG53byBM3fgDtO/RhxdTqsKyzCQjx3KmswZ4UWr8lubBSyNi9IFedI+iIQKpK0OeAVZlNaORk3vS9NSC3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241562; c=relaxed/simple;
	bh=0CZoe1jqaOgC4GCxjGCKMxxpTSYNuXAPnqxxDkDU2wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqL6prpvU79rRayESA6Kwva1jq9CZhmrgLhpfPK4y5oYZIqdJD5ZvJrvep36wfaR4hgGrmHyqwdVad6QFoviOFdXHxY5B8bzGZFJVS5WROr/N2EhfHfoynLqMDvev5r/N1nYK0Mpc4U2DLY8hHtlkNSJ5Ehz4fFTgeZb7nhrF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OGKMAvtA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EwZ3bJrY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUh9DNE9z8dPvy+AypGRO/TNpdxYUzBpKnMNKbc3pcE=;
	b=OGKMAvtAZqNWkHrYdsEBUKkIcNP0gwEsKdIs3M9AV6LmFuP6zFvl/RwVPl5iXZA0IwUjzs
	oX9EQZVqXvALMlDdSQy+ZiBX/0YQYXyeqYCJkFoS2k+0beMnfIz8TLaT5tUbtqqIKnDNQD
	dhoFeMVV2MNTCnbDJBXRPjzTF+pD7mZJUgzFbYzjrwYxQ69+jXNuVFsNYSHeKX1y0RNmwz
	qKz7hzBO4yHFN/e6AMXVgc4YIHo+1teQHKz5y/6EHjSnGZYArhlE25R75hxZjkwJtT8GBR
	kQ3twT3wf2dw2ZKFghtX1jqPZUpSmCBx75GBb4vpAWHlCQio+zZbGORq0AdmVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUh9DNE9z8dPvy+AypGRO/TNpdxYUzBpKnMNKbc3pcE=;
	b=EwZ3bJrYNpN0PQ1OZecEz94WGGnRLYqNJmy/hurE7hrcuao7dQ349k19kjFdOqLBaJlhrr
	EdSrWhp/oIS7ToBA==
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
Subject: [PATCH v4 18/34] x86/cpuid: Introduce parsed CPUID(0x2) API
Date: Fri, 15 Aug 2025 09:02:11 +0200
Message-ID: <20250815070227.19981-19-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new iterator macro, for_each_parsed_cpuid_0x2_desc(), for
retrieving parsed CPUID(0x2) entries as 1-byte descriptors.

Unlike the existing for_each_cpuid_0x2_desc() macro, which operates on
directly retrieved CPUID data, the new one takes its input from the
centralized CPUID parser.  That is, it is expected to be used as:

    const struct leaf_0x2_table *desc;
    const struct cpuid_regs *regs;
    u8 *ptr;

    regs = cpuid_leaf_regs(c, 0x2);	// Parsed CPUID access
    for_each_parsed_cpuid_0x2_desc(regs, ptr, desc) {
        ...
    }

which should replace the older method:

    const struct leaf_0x2_table *desc;
    union leaf_0x2_regs regs;
    u8 *ptr;

    cpuid_leaf_0x2(&regs);		// Direct CPUID access
    for_each_leaf_0x2_desc(regs, ptr, desc) {
        ...
    }

In the new macro, assert that the passed 'regs' is the same size as a
'union leaf_0x2_regs'.  This is necessary since the macro internally
casts 'regs' to that union in order to iterate over the CPUID(0x2) output
as a 1-byte array.

A size equivalence assert is used, instead of a typeof() check, to give
callers the freedom to either pass a 'struct cpuid_regs' pointer or a
'struct leaf_0x2_0' pointer, both as returned by the parsed CPUID API at
<cpuid/api.h>.  That size comparison matches what other kernel CPUID APIs
do; e.g. cpuid_read() and cpuid_read_subleaf() at <cpuid/api.h>.

Note, put the size equivalence check inside a GNU statement expression,
({..}), so that it can be placed inside the macro's loop initialization.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/api.h | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index b5a6e40419b7..b125e492d239 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -545,6 +545,49 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
 	__cpuid_leaves_subleaf_info(&(_cpuinfo)->cpuid.leaves, _leaf, 0).nr_entries; \
 })
 
+/*
+ * Convenience leaf-specific functions (using parsed CPUID data):
+ */
+
+/*
+ * CPUID(0x2)
+ */
+
+/**
+ * for_each_parsed_cpuid_0x2_desc() - Iterator for parsed CPUID(0x2) descriptors
+ * @_regs:   Leaf 0x2 register output, as returned by cpuid_leaf_regs()
+ * @_ptr:  u8 pointer, for macro internal use only
+ * @_desc:  Pointer to parsed descriptor information at each iteration
+ *
+ * Loop over the 1-byte descriptors in the passed CPUID(0x2) output registers
+ * @_regs.  Provide the parsed information for each descriptor through @_desc.
+ *
+ * To handle cache-specific descriptors, switch on @_desc->c_type.  For TLB
+ * descriptors, switch on @_desc->t_type.
+ *
+ * Example usage for cache descriptors::
+ *
+ *	const struct leaf_0x2_table *desc;
+ *	struct cpuid_regs *regs;
+ *	u8 *ptr;
+ *
+ *	regs = cpuid_leaf_regs(c, 0x2);
+ *	if (!regs) {
+ *		// Handle error
+ *	}
+ *
+ *	for_each_parsed_cpuid_0x2_desc(regs, ptr, desc) {
+ *		switch (desc->c_type) {
+ *			...
+ *		}
+ *	}
+ */
+#define for_each_parsed_cpuid_0x2_desc(_regs, _ptr, _desc)				\
+	for (({ static_assert(sizeof(*_regs) == sizeof(union leaf_0x2_regs)); }),	\
+	     _ptr = &((union leaf_0x2_regs *)(_regs))->desc[1];				\
+	     _ptr < &((union leaf_0x2_regs *)(_regs))->desc[16] && (_desc = &cpuid_0x2_table[*_ptr]);\
+	     _ptr++)
+
 /*
  * CPUID parser exported APIs:
  */
-- 
2.50.1


