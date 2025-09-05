Return-Path: <linux-kernel+bounces-802860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C988B457A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F3716C548
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8C35207B;
	Fri,  5 Sep 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRbBN8D0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Bky2rvM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AE35E4DE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074640; cv=none; b=VBouV4D0cwyyw5jIhij8bpKKZcSqpMlS/hCDseboJzaMwMRNs1jUmt8TOSsr2/pwiiSBhJvB3MG/Tqen378phOMLOnVQYfeWLeaWOPScChiAVAsU37eqEjZAtU2LtaIMjvPm7qOdFtdwQUlEF4HBYgxLrnB3cYzd2JfoUjJoliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074640; c=relaxed/simple;
	bh=SpgDp4laY3Pb0mMhApX77JkuC/iMBdEU5Th067+K1MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D30Fgg4l4VMKEmXDVanOTQfPHhuTuuCBHSGzVVnLYH/oW17iC9IbEt8SZO8pMtmrBIdIAM5uwDiV1BK93T6Brp1mqlTzmRDHPJhzuo5SdWj11KjclMRC1oHvRM0WUXpxvPWveYqf0XzPzu1eCwiec0NIFAFS+PvYgcXepCVOY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRbBN8D0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Bky2rvM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvgIjikOWlsZNf2y+C+TbxciQN2DYhSOt1mMUIat88w=;
	b=gRbBN8D0BT86EDvmDy2uOirdkjS90R0KWnFyQbHANe9oHQz/cIdAlAM/QRI5AxF9mkBNwB
	4iQ+j+dLkOAlt7qXAJERUY1si8NFhMn2RWnVigEUeMUQZIA9gARdAVCOweTUVQJ/Vaoing
	tdhh84uCn+bMEoDmnbKwbsMyzVnfDLVQurPHgVtUBgnyRmiJeqd0PuSmCm4kYhJM02Uwhp
	CWD32TyU0+1rPuFTLluiHBNhGC3XznoFAfk8xpCeEbMWLlF/WRiQyT/TPybBzwALtjuxLu
	XebLf6UUzY5AabBW19Vo+R239ySs3b6oAQEtN2zkCgZqRZhnO967E44mAazMGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvgIjikOWlsZNf2y+C+TbxciQN2DYhSOt1mMUIat88w=;
	b=4Bky2rvMAtr0ehqV4LepPMwgz+hZLjP2pR8fC2+5RaxAKvk+POm3Jo3KI6TrxZqIjXBZtk
	Zvv3ek2z+tCOGdBg==
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
Subject: [PATCH v5 35/35] x86/tsc: Use parsed CPUID(0x16)
Date: Fri,  5 Sep 2025 14:15:15 +0200
Message-ID: <20250905121515.192792-36-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the x86 time stamp counter counter code, use parsed CPUID(0x16) access
instead of a direct CPUID query.

Beside the CPUID parser centralization benefits, this allows using the
auto-generated <asm/cpuid/leaf_types.h> data types, and their full C99
bitfields, instead of doing ugly bitwise operations on CPUID register
output.

Remove the "max standard level >= CPUID_LEVEL_FREQ" check since the CPUID
parser API's NULL check is equivalent.

Remove the Intel vendor check since the CPUID parser does a similar check
before caching CPUID(0x16) output.  Thus the CPUID parser API's NULL
check is also equivalent.

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


