Return-Path: <linux-kernel+bounces-770313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1F9B27996
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A365A8826
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55432D23BF;
	Fri, 15 Aug 2025 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rpDGC/aB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dD3ASqqH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9E2D12F6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241520; cv=none; b=UMiE58AlSzEKYINWcIjR63xvWxMf2o6GpPlMrpygz7G5K1C3rFyu0sy213WiIBFzY+HpYZUPbtU0Z3TAVYZEQ7CCvlR53waeu7hV3WxZbm8LqW8eUrPNkvnF3bzDbrT6pyBDB8Bp2WQGYLo2h0h8f+XVLQjSVKZbN4tHVQZLvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241520; c=relaxed/simple;
	bh=NqhvlfUYaDV/+2XHHooAozZ1Ma4TP4Tc6co3ykPUrHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+So3/6a/VRs+NmktSqSC0wLfPSbiX43RTsiCdsK9TuNAXJiNvlcgyHQq8I52sxNv5DVVI816AHPeNnFitJ7yv55r8mXZS/rFJnVBPBjFlWH1pG+tFWDFkyf7Eq0QWJlxZHQtvMWdpzLL3+68UfK+vS9d7hS+E1SwCPUTwEAiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rpDGC/aB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dD3ASqqH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAEsC2skIOSaWZt2MlflxtyQsbT7+BYF8vFWwagm9QY=;
	b=rpDGC/aB9lOOfqrKs/DDz8IRv6n+KS2aaWIxFfaWRUsMbC5AW6darZZxoHmZhqnERUQaYx
	ESxmLs+mee+CWwsfuTnv22jM1dkThGdOU048PxMUaR1kVuKr+uTdQgqCCcfrlZTBiOcXRx
	RGvRKyJdpfQHUJIIZNJvtTqueaGYu9OGKJE7z6ac3gGkoJdgCOLnvV29bBlhlucJ1EtJJg
	hES2FbXPZek8CBSkqiK4IjCO0DbZm3Eb0ivUQpJidEc3HxOtSRvHevQZvLUL8vIQU8FMwY
	6OBES709lMig8QcZvJClN7CNGQwiHEaeHi6q86h/LjejB9SVU37Y2qWLWrwY9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAEsC2skIOSaWZt2MlflxtyQsbT7+BYF8vFWwagm9QY=;
	b=dD3ASqqHutbaiVRc4WzldgcfUvblEBR7FVkxVdMR871o430cw9LGNLAzexaQ2L+dLEV9m0
	SZtzChLeRgqLADDg==
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
Subject: [PATCH v4 04/34] x86/cpu: <asm/processor.h>: Do not include the CPUID API header
Date: Fri, 15 Aug 2025 09:01:57 +0200
Message-ID: <20250815070227.19981-5-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
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


