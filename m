Return-Path: <linux-kernel+bounces-770347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E730FB279CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CAE6232DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7EE2F90EA;
	Fri, 15 Aug 2025 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wy0SeTkS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XfP1BrBq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7C2F83DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241616; cv=none; b=YLZAsbajLLUkX9gDDdK6+QwVUQrRtqLw9eQMe5dxkoYRH2GwqeuC8ELxKq9ptQBgODE92Imx/+97/K0XjHOoPI+e0P5J70Kj0GlFZhtoUy7Vbxu4i2NLCbyOuWlmvNhsT5qEvFCoHds+IDQg0jvms0/NhnAb/1WjzSeiBXHVTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241616; c=relaxed/simple;
	bh=2p3mVQR6Pei4EbU9vfHkMqnuC71LnqWy+OEui4qrQhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czlOEAdPsshzzXqr01DUD/HFYhph0917g4KlzfulYUZ7mNawjjHQ9nLjfmENomxh4mqcWdguAEr7CzRCl/jms30AiQ3UAeeviK9nxoK1lkZ+v8YynsHwDnqKoIb7gIVNndOJ/9CdXDdipBXc+h8bT7HSjH8KXYgQDx4D3jc4W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wy0SeTkS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XfP1BrBq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr8g2138fQgNu0HI5HEQ50NVYhPOnkdlyJJ7xfGQCns=;
	b=wy0SeTkS2d6Mdb9+Q1aIiW39aynWaseSM445L+/4iabdY6oC+Il0otO6B9YkbiD6TrJRcC
	QrsrKGq1PIord+n9sCTv6/SBc5Q3D4xildNm5RBTTMOKCT9+QpZRSimZLCEv3jcwg48xbW
	Gi+y1tBR7vZ1hyKXkbv5IpRlwiJBK302pHq8/ffGrhPYQOjCKkhC2x1jevNmIa5+aGjmh7
	RnmE19XpnuNeENYpx2JI2MyDoteTNGWBn4QSmb1QAWmgr2JfFQWgOgLOcU2JVCaRUSrYMe
	FQ5zI7DjfHlNHNXspI4MkiFFJZGm0NLhZRX1vgs8bACz9umDBvOlvCgysE44ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr8g2138fQgNu0HI5HEQ50NVYhPOnkdlyJJ7xfGQCns=;
	b=XfP1BrBqt1e2Sww0FRaPWW3nSiAAUHedLKhuBdGHHmBAgouwJ8CTnJV5nOwt6IftaPa+FW
	b4RosLL7da4tdNBA==
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
Subject: [PATCH v4 34/34] x86/tsc: Use parsed CPUID(0x16)
Date: Fri, 15 Aug 2025 09:02:27 +0200
Message-ID: <20250815070227.19981-35-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use parsed CPUID(0x16) access instead of direct CPUID queries.

Remove the "max standard CPUID level >= CPUID_LEVEL_FREQ" checks since
the CPUID parser API's NULL check is equivalent.

At cpu_khz_from_cpuid(), remove the Intel vendor check.  The CPUID parser
caches this leaf output for Intel machines only, thus the CPUID parser
API's NULL check is also equivalent.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/tsc.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 87e749106dda..34da49d45d85 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -662,6 +662,7 @@ static unsigned long quick_pit_calibrate(void)
  */
 unsigned long native_calibrate_tsc(void)
 {
+	const struct leaf_0x16_0 *l16 = cpuid_leaf(&boot_cpu_data, 0x16);
 	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
 	unsigned int crystal_khz;
 
@@ -703,13 +704,8 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
-	}
+	if (crystal_khz == 0 && l16)
+		crystal_khz = l16->cpu_base_mhz * 1000 * eax_denominator / ebx_numerator;
 
 	if (crystal_khz == 0)
 		return 0;
@@ -736,19 +732,9 @@ unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
-
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
-		return 0;
-
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
-		return 0;
-
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
-
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
+	const struct leaf_0x16_0 *l16 = cpuid_leaf(&boot_cpu_data, 0x16);
 
-	return eax_base_mhz * 1000;
+	return l16 ? (l16->cpu_base_mhz * 1000) : 0;
 }
 
 /*
-- 
2.50.1


