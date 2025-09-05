Return-Path: <linux-kernel+bounces-802847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F03B4578C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C0D1C872DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7275350843;
	Fri,  5 Sep 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vXCPdK/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZ0uzxc8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAC350850
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074601; cv=none; b=dTn4mNAXRsjKgMXnme+2SMSPwdN6Wetaj0EbwmsR8dj9t2bjjq+KqPtKB/lr1CXK1m7I7jdzq9iS8FHKmGLbzssivm9oSL5LkuA9nCxAbzyjPoc1e1w1DK53DqzLxleyrV2DseY2Mp9G1SFJXRVT6eJR3WkO/FVxe685Tk5rJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074601; c=relaxed/simple;
	bh=vrilB8Pp2o05wrxQDrd+PviVOlyflql/qEV4JyceAE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0pTk5yqpK/njx37cleJuUYJJj+Kc3RlsYBPoaCyoMWGc4zBcbSfPIRLnkfVGEZo+da+DPj5b7/IpDHSXswQXzpP+sAyMZ0ANWzerS9fTb2K31sU3n36YhJJcFFoUwkF6XjNiS7wOSwGV0lz7SdGZawDOk4Ko11ZeuBf/oTTIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2vXCPdK/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZ0uzxc8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnhfp7RG9+kQXAh3FHU78TA6UXd+wPzE4jdCgJfYuRU=;
	b=2vXCPdK/cDM/fFaCVa7+M/HEZCFqCrdX3V26yelvqpDZg+Ktm6eM+RelgwYd3rITUYtQPA
	qB2pyQtvxryyfXbwFLeXPOn7KSYuSu3PpEhMaaZNvjEVL5dsL+i9l+sIjttTFYmZ1qKhsX
	VR73HrL15rvNcIG6pidUgAacp4TUsYbaXTO6haqrvVAOL9R0x/kJOB2RJs737ygAeaVzo0
	uG/RDYlQXvqRkZxPhUt6BO32iUaJ+sKN3WfecYjpQhxbNKoUhbGxXuhTmKx0mpzNfLfYqk
	kcYWTHPw01ganVjKXdOOqkNXDVwa4n9pWc4WDnY85xNMHC+NsX+V/M6oo+CpQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnhfp7RG9+kQXAh3FHU78TA6UXd+wPzE4jdCgJfYuRU=;
	b=GZ0uzxc8oZF987oRDh1i/2wt8uFNiMa4UVH2bXKNxLsPQxWI3vHoUK8/UYF+KnfMaJPz9c
	CHq9u20r61/6mqCA==
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
Subject: [PATCH v5 22/35] x86/cacheinfo: Use parsed CPUID(0x2)
Date: Fri,  5 Sep 2025 14:15:02 +0200
Message-ID: <20250905121515.192792-23-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use parsed CPUID(0x2) access instead of direct CPUID queries.

Remove the max standard CPUID level check since the NULL check of
cpuid_leaf_raw()'s result is equivalent.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 51a95b07831f..4c3a08593ec4 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -391,14 +391,14 @@ static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 {
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
 	const struct leaf_0x2_table *desc;
-	union leaf_0x2_regs regs;
+	const struct cpuid_regs *regs;
 	u8 *ptr;
 
-	if (c->cpuid_level < 2)
+	regs = cpuid_leaf_raw(c, 0x2);
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


