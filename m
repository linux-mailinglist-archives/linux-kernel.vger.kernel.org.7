Return-Path: <linux-kernel+bounces-724446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA6AFF2FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B6C641477
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E32243399;
	Wed,  9 Jul 2025 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Emcnzhco";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="830KHWrm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191492459FE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092862; cv=none; b=ErgzEAuwxFz9nYRxFwb2hPDGEpaFiYuP7EHfS1uzar8ApTd80teJIyqI6Mw/wYnZwdIImvvDGE5KEF25vmdqF2bPjxpwqy53w+Lx722rwIRPSgY+EZjURzBtQ+zMVCRAxcUoKJNvHJngQ5dIcbmgFaF1LsmJrpZ+pfdnBTU+GQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092862; c=relaxed/simple;
	bh=ZdY+cMju7XjfyLPGquSDZy/E5RM93XsArXwgZNl5ar8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkgde/l/HUXLOcANIZKEuSxVfT07oB9sSk4FOPftwHB4d1A+5U5cdyAgkyUpckjdAwApSAfOrOJ2Bsxb/oIQlYm9UcIGgACtdswajBWh6r/J94fuDsg+ovSG3rTf50neJVjHoRLZxCQ5eX7jDf8lyR939sSgTmzbOAMFUwSlAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Emcnzhco; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=830KHWrm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752092859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKia7v+pqE/QvyMWvuUTMQRfRRiIr8Kp1yEYerm0uTo=;
	b=Emcnzhco8lgF/YjV/LgDrfnYis2Q41j89upLzXjP7Jd19JnlpaPFvABVVbDqG1Nd7BosFw
	JCCNiWV5/04L1y4+qxg+IIGSxPAYkI1qNBROAJesIm8M37g1tQbVOaxwAsenyxOtQhvjEL
	lhT8dVZvibKDbbacDi0AGlKjY/IPETZX/77P3748nu9DwlHOGJ7uij0raRSiR5uu0m46UA
	q9lLqZ7ZUTQPg7O2XP2pMiRcHw80n39sD6PtjJnFtfgCHsWNawfvO3nw38S5qAT+u6vq+1
	htmXSw1Dqdiiggxkp39rkuLFgUqydQULvNL4JsdjRCZrWWi+mVGVcmqvWr1ncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752092859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKia7v+pqE/QvyMWvuUTMQRfRRiIr8Kp1yEYerm0uTo=;
	b=830KHWrm1urOHnVlNwdTw53aAx0X2HcSbXekePzlBwT0p3qWSGdHu1nVs4ukcDgZfGlmk4
	O+E5Hez2NGkfHwDQ==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 6/6] x86/cpu: <asm/processor.h>: Do not include CPUID API header
Date: Wed,  9 Jul 2025 22:26:33 +0200
Message-ID: <20250709202635.89791-7-darwi@linutronix.de>
In-Reply-To: <20250709202635.89791-1-darwi@linutronix.de>
References: <20250612234010.572636-1-darwi@linutronix.de>
 <20250709202635.89791-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<asm/processor.h> includes the CPUID API header <asm/cpuid/api.h> but it
does not need it.

Remove the CPUID API header include.

This allows the CPUID API header to include <asm/processor.h> without
introducing a circular dependency, which is needed for the upcoming CPUID
model and parser.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bde58f6510ac..910e36b0c00d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -16,7 +16,6 @@ struct vm86;
 #include <uapi/asm/sigcontext.h>
 #include <asm/current.h>
 #include <asm/cpufeatures.h>
-#include <asm/cpuid/api.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
-- 
2.49.0


