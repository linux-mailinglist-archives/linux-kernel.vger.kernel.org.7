Return-Path: <linux-kernel+bounces-802827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2BB4577A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85D75C38C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9334F465;
	Fri,  5 Sep 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwRKe3Gq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m67rlNbX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DC34DCF1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074533; cv=none; b=gCAlExdlzfoyi+/Sl3aNBCK5xKAAsl9u/h7NoWBw/bd6reKe/iC3Cy0Ry86xg7ZkAw8xtmOYPJo4WELhgQb9I2m8x/EScIfZ3lzVrdiMbocBiGXe2PKNzjyOwEM1iVUkt1ZQSpv1ig0pNTQsTY2ZxF+g43UkS3ctwoF+KuO7WOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074533; c=relaxed/simple;
	bh=NqhvlfUYaDV/+2XHHooAozZ1Ma4TP4Tc6co3ykPUrHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFAZlJPcdGSb3RHNI7A9KeZlDBd8vfM/MjHdsI9di9y1kRxsbs7YLG4LwYeHnwyChtaKOEbIMSk3kXV12NVEfHDzikikdarYOHabA2mgnlBIcYsFQSP1FEXp/ZCoGHRApe5PkzMPr4cGJD5eY/Tzvqu1cZ+HT5v9A8hle1VFNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwRKe3Gq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m67rlNbX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAEsC2skIOSaWZt2MlflxtyQsbT7+BYF8vFWwagm9QY=;
	b=YwRKe3GqJBa3yv19GFVyfmqeN1i9legG9BMvWF5NaeDlmttbMIscUnIxtInbW2XpumHE6E
	rm7kh5sWAlksofwmWJEefEBCfERYaENlqWlqrIy1wYhdRfuA1kkyhTaMz4JB7iRqOedVzW
	IWWvM8VFigHhuKbT+a7qGnGY7tc1wXRIIno8eu4W7nTETeHXuYs4qfd/6xqxUdPj+V061U
	cM5QYfdfeFlFHy/Yq4KLRQ/VjZJ4Q+I6pNQ5RKgn7AbcJwi4Sq0noR/QaLZRdOmGcmt654
	YOM0qRX8qEDKm56jkk8mUqk8ho93CfWCXDxooFeE5ELInqtdBXDZ8hvp0Vdlug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAEsC2skIOSaWZt2MlflxtyQsbT7+BYF8vFWwagm9QY=;
	b=m67rlNbXmSKZsshHY0o9NmnU4FSqKoppGWXlbFV5dnb4toX+5SPXZJRO+U20pN6di0pIUC
	VtrIK0z5Jzku9PAw==
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
Subject: [PATCH v5 03/35] x86/cpu: <asm/processor.h>: Do not include the CPUID API header
Date: Fri,  5 Sep 2025 14:14:43 +0200
Message-ID: <20250905121515.192792-4-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<asm/processor.h> includes the main CPUID API header <asm/cpuid/api.h>
but it does not need it.

Remove the include.

Note, this allows the CPUID API header to include <asm/processor.h> at a
later step, which is needed for the upcoming CPUID model and parser,
without introducing a circular dependency.

Note, all call sites which implicitly included the CPUID API header
through <asm/processor.h> have been already modified to explicitly
include the CPUID API instead.

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
2.50.1


