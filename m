Return-Path: <linux-kernel+bounces-724442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F81AFF2F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7645A75CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679EB243379;
	Wed,  9 Jul 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGHL+WZp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CB4vgEXX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658124500A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092842; cv=none; b=tpKM1L+ciNg6o1FLDAQ39Dx8yAxs642RJuKEUMPH2yJpUTQzfk5SIY3RCSaAx6MO9tsdNkxy497hXwWdsyLWcPJdCIzfGQdr9kZ5DBgLWK+XbxTAfLrL8rts5gc+/upgLQFKyxoVbnyBykfoeOM0N/5AkKqwlgXs5gGnuzok7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092842; c=relaxed/simple;
	bh=FZ9H4/MGT0XYBHeY+H65v0m9KWcRSW93roPsQeAFDLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqK7TyXbU8et+MAzzcXYRt8IqJfZruVcHTHD5fEkF+h/+DLg44oBjPxAbchhSsSTS75X5McHRwfiHOutqD8rY827Q+ZVsuTruh2xfzJLGqcANaWO7qTN2kvlRr9Ncd8m5K4e7v7THff5X4FYDlZuovzTq7jwmCYceM/IjHiZTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGHL+WZp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CB4vgEXX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752092839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=av1RJLmDJc38MxsK1DauTEQVAq72KkzKxqMBwAWtSvk=;
	b=pGHL+WZpvfBJ7CNjZ0sYzhYvLcV2KDR43hFM9OBkFYvPgcT3jO5Qy1v987rMI/huga4ecJ
	pXtlAeRZxlz/0Ts1Qvafb2XSUObg7SOqkMuYD1PRGkm0c1Vh4RgbOKAqDi40735Vql1lbM
	UF8VEtJpcCa2yhXpArpoXSrN66XQV9fQABil+uKsRcL2URMkEdLZmRD9KJyofPGvhyfUCh
	NKpHihgQlA9Z/s/ZNjQiAzIL0hfSIAx+IYNhUqTRvYMm7O6VpDjkw410ARvoJ4DiynbUXz
	T//FWxfzxvJtzkqREbI2n1NhzD0KtDTHrX7OUJ3JmkC6DJDolh+xXUzWkmCarw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752092839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=av1RJLmDJc38MxsK1DauTEQVAq72KkzKxqMBwAWtSvk=;
	b=CB4vgEXX4BKrRqPnSa1Kicay2XyTJ2X38kbNkv4g779OUz0VNTl5ubvQLecekP/kPImIJw
	NTbPy6DdGznPIaDg==
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
Subject: [PATCH v2 2/6] ASoC: Intel: avs: Include CPUID header at file scope
Date: Wed,  9 Jul 2025 22:26:29 +0200
Message-ID: <20250709202635.89791-3-darwi@linutronix.de>
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
2.49.0


