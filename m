Return-Path: <linux-kernel+bounces-724449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1EAFF303
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C6D1BC5E64
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6724501B;
	Wed,  9 Jul 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KLWqtMIk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IloMWda3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E481243378
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093043; cv=none; b=b3DICZVJNx/wJhszNpQ8lygfgCGoR643ZMj/MV+NjS2PFdSzsd0gMQJEcP6Tx2Gu2dCo8c7LFANNEXUo7zQ1xMLisV8eZFJHZC8njZuAdPI/fsIPp07auEC4FAe9J4z3XawYHFVWsy7Pn1aSVVhAfPqWcGja7xGR44hKKRkHJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093043; c=relaxed/simple;
	bh=6Pf/tXMZzJo5FfKHir7iP/T7zDvDoWdK5wp07Bj9XFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVnDc5La2V8OWJFRgOa9d6POA7dQrX78cwHU7fSv6uAwnag7GP6Woa2xNPS+fITwn8Ucbw2EAu977XofM1M+cNbS9k6arh6uunGLh6sCEKzpga97DfOtJWEei2JHWbV3FOOV1FN5fp5UsNTntk9OjAQCxq790v1erahw4hJbgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KLWqtMIk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IloMWda3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752093039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moW3grsIEEkZ24nmNYOLsz6RTNF0J1cs4slM6upzMSY=;
	b=KLWqtMIkfuDr7fn54kJXYONCKQzNw1AUNnVA1ZFCqJbPAZWBe3JI6r+bH9dVK/paJpZfCi
	x7R/tXiVIiLU4tHeLBrEVmaeh9lR3f2/bU7K5gDmiX553zEL4mQ87vMIW1nCT2+jDn2HWQ
	15SKO5+G1KmQKBOQXpKCWgNPOslfdjkiVs0bq063MQJ2oBi/eG1ATzNSZ1w6rZbIaI3Cs3
	1Yq1Vxsf5pnJGcnrlgsiZH6SWtwdplUNbUQ+gYMrbVQ5+7TgWJLZlBhAdBO8XMVmPQRCcL
	esSZ2hSC0SUwL7qOUx628OEgyvztii7e7MHIEwYmuSArTp7abpBk+zLq4h9V2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752093039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moW3grsIEEkZ24nmNYOLsz6RTNF0J1cs4slM6upzMSY=;
	b=IloMWda38o6M9BADibY7anRQo4Sv7GNbPTP3NnAkHyGv7JnHFSVMwfP9/J2XjZucuR62NL
	hC6FNsLG/iR4TWBA==
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
Subject: [PATCH v2 1/6] x86/cpuid: Remove transitional <asm/cpuid.h> header
Date: Wed,  9 Jul 2025 22:30:27 +0200
Message-ID: <20250709203033.90125-2-darwi@linutronix.de>
In-Reply-To: <20250709203033.90125-1-darwi@linutronix.de>
References: <20250709170454.74854-1-darwi@linutronix.de>
 <20250709203033.90125-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All CPUID call sites were updated at commit:

    968e30006807 ("x86/cpuid: Set <asm/cpuid/api.h> as the main CPUID header")

to include <asm/cpuid/api.h> instead of <asm/cpuid.h>.

The <asm/cpuid.h> header was still retained as a wrapper, just in case
some new code in -next started using it.  Now that everything is merged
to Linus' tree, remove the header.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
deleted file mode 100644
index d5749b25fa10..000000000000
--- a/arch/x86/include/asm/cpuid.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _ASM_X86_CPUID_H
-#define _ASM_X86_CPUID_H
-
-#include <asm/cpuid/api.h>
-
-#endif /* _ASM_X86_CPUID_H */
-- 
2.49.0


