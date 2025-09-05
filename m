Return-Path: <linux-kernel+bounces-802825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A233CB45778
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7567AFD57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D2934AAFA;
	Fri,  5 Sep 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DwA3397L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vd3qLtYb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94B20EB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074526; cv=none; b=BzWKcV1/Tfy/IblnjAymno2IKsBFyxGGQHNZVAOMf1Ny4UUMxJDeoQ6DWoRUal4WNgzYRmGd8Qwe1HE8iK9ZQdYJwjU8UUxrAn5ldx3uIWL3aUsFbcKpMnf4l+d8UJiFQqWWUOSG2WDPFTl0JWpGqA2XVTjUuy30yqfksSvIfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074526; c=relaxed/simple;
	bh=l8ElQRAT1Hszveqk+X21k8IIcIZzDZmj+WUDZsTY2C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr/y0zbHX1ZDus9WLXba/avLOftsgm07YEKgGeNkszHkFKsxE+ofaNYCwLOpojzqIsnz1jcRXx+ZKhqoqEVwT5Uv78ows+WTXPTetiYCU58vYbWseyWirWQzoeaCdOGyKvTvtS9FrNn6vH8Utgv3Uz0dQ7P6CaQX/BiDi9z/nLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DwA3397L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vd3qLtYb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILIDCHvFGsvZiwtpyNNKEdOsJOlcSIX04cXR7l0HOA4=;
	b=DwA3397LhSlgh5+HBdsWv8v1ZxjliC3F0XLaTLc9bjzoVmoFZtew2mD54FW0wvpnkn9q9B
	dhSybgaux4geGazQ7akCZDcPrJxY7S8KVxsaKtSdZ7JvFa+x6tSOPjkRNIA0flDBPPudut
	U9KasVeMkG6mCxxriQ6xrIZbL9WFDgFYNMajhsyXVnZbdOd6cqDacNQWPKSEK6tHJ0it/1
	m3DnP3ujII8QGaFBXrxLUvRLAhiVSbUbdUmlSu0QWFYuJ6i/8ZtC8fBN7AfiWoFwiE9vXF
	d3hrwVFZ1031QuV6rtDFSpsGIklgZLvuyl19y6d2caPQdhsYkKNmFgdeQ0XfoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILIDCHvFGsvZiwtpyNNKEdOsJOlcSIX04cXR7l0HOA4=;
	b=Vd3qLtYbjjVHZxZQqxkw/X9M2naa/EPcYpNw5/dfEHVBH5/YgbDDtsqBA73d3oEKN/nmDk
	aChUrxO/lm+UPQBw==
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
Subject: [PATCH v5 01/35] ASoC: Intel: avs: Include CPUID header at file scope
Date: Fri,  5 Sep 2025 14:14:41 +0200
Message-ID: <20250905121515.192792-2-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit

    cbe37a4d2b3c ("ASoC: Intel: avs: Configure basefw on TGL-based platforms")

includes the main CPUID header from within a C function.  This works by
luck and forbids valid refactorings inside the CPUID header.

Include the CPUID header at file scope instead.

Note, for the CPUID(0x15) leaf number, use CPUID_LEAF_TSC instead of
defining a custom local macro for it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/tgl.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/avs/tgl.c b/sound/soc/intel/avs/tgl.c
index 9dbb3ad0954a..cf19d3a7ced2 100644
--- a/sound/soc/intel/avs/tgl.c
+++ b/sound/soc/intel/avs/tgl.c
@@ -10,8 +10,6 @@
 #include "avs.h"
 #include "messages.h"
 
-#define CPUID_TSC_LEAF 0x15
-
 static int avs_tgl_dsp_core_power(struct avs_dev *adev, u32 core_mask, bool power)
 {
 	core_mask &= AVS_MAIN_CORE_MASK;
@@ -39,22 +37,31 @@ static int avs_tgl_dsp_core_stall(struct avs_dev *adev, u32 core_mask, bool stal
 	return avs_dsp_core_stall(adev, core_mask, stall);
 }
 
+#ifdef CONFIG_X86
+#include <asm/cpuid/api.h>
+static unsigned int intel_crystal_freq_hz(void)
+{
+	return cpuid_ecx(CPUID_LEAF_TSC);
+}
+#else
+static unsigned int intel_crystal_freq_hz(void)
+{
+	return 0;
+}
+#endif /* !CONFIG_X86 */
+
 static int avs_tgl_config_basefw(struct avs_dev *adev)
 {
+	unsigned int freq = intel_crystal_freq_hz();
 	struct pci_dev *pci = adev->base.pci;
 	struct avs_bus_hwid hwid;
 	int ret;
-#ifdef CONFIG_X86
-	unsigned int ecx;
 
-#include <asm/cpuid/api.h>
-	ecx = cpuid_ecx(CPUID_TSC_LEAF);
-	if (ecx) {
-		ret = avs_ipc_set_fw_config(adev, 1, AVS_FW_CFG_XTAL_FREQ_HZ, sizeof(ecx), &ecx);
+	if (freq) {
+		ret = avs_ipc_set_fw_config(adev, 1, AVS_FW_CFG_XTAL_FREQ_HZ, sizeof(freq), &freq);
 		if (ret)
 			return AVS_IPC_RET(ret);
 	}
-#endif
 
 	hwid.device = pci->device;
 	hwid.subsystem = pci->subsystem_vendor | (pci->subsystem_device << 16);
-- 
2.50.1


