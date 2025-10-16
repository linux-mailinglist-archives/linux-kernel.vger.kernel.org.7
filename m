Return-Path: <linux-kernel+bounces-856065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B8BE2FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C634A3B9EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0592E543B;
	Thu, 16 Oct 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FPZ1AnBM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74972301468;
	Thu, 16 Oct 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612313; cv=none; b=FnetXmEa8I5w3Y5A/sSxLcOEifv9mnef90Lt630XsIe3U/+Z0xgn1gCwilW9uG5Ri2mxHaliZQ5j4mrTgJsRx/xYrFflNxvaxULIbliQykxcN/4FJlcBr4EBOuACVuU1w6ARtysp+5rOxj83VF2z7ESwsPbEFh6IAxOqDR/XxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612313; c=relaxed/simple;
	bh=G5YIzlM0wW45iOdOfOR7wWJBmL7Lgrcc8f2jbTPM22E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JycHJ6B4Kk6j+Fe1d6vHHAyusPZzHtlxVIzJ17dDQ6P5UIvJdnCnTRrpZGddczE/2I27+pUSD9foqHzJ4STsGDqurTNLj+B0utxEZwgSNeVpDTAoGl4Lnv8k17Zu0A64KvS47JRu/7YPwp9DeSGDv83FFYCinmzLiCpy8U4aSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FPZ1AnBM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF2C340E01A5;
	Thu, 16 Oct 2025 10:58:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H3F_11x1GYkR; Thu, 16 Oct 2025 10:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760612302; bh=cLAm2KZbcUMyv3Nykzzh+blygKDExFAFcPx/1H0Hto0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPZ1AnBMLzWN3gC/Gf8oC+xPZnSOsHILd7rdmywbZYi1fx/C6g7Oo9/xbTgXCLICK
	 avBK1uzfruRje0qZ9aAWGt3FhexI9arjvQTYu5wXUlmWFijiDwi/UiU3H26beBeHl1
	 ubBVVlBJmk2AIIcm1a8KaJvfmNqdtvibRhZOV3lWWJKKYYZ8LGKOJpo2V+/2cYhi7U
	 BtP9zHYpgg2dUiWN5qSe+zWjVNuXF5UrU54/hm7l5/ZH94kW401Mgxg72d+ua4KfUj
	 QiLNwPv6Hbq8dPK5wxeQpE+t67c2z2Jc2Wr83mIdX8MesmQ4kd9LLf9gZxRlCn/bu3
	 PNtGvtFFaC9N6CZ+VeImrsvBOT1ejhhFsdKMKWrHTz51aiMgcfMrZcbF9aW8WrNh+G
	 t6KSGgg0sAKfX+/7/SZe/xtAW4RbRe2biZyzKsHwP7sJ9xpuE9MaEtSJ7neMm2x1S9
	 QTAjSU9UHVKkITvVjIBAt6yh1oHgf3RmuTgSgZi231zw0i98jpzbDYN7Ug7kULo2OG
	 yVMYdVqxQRWt8bhL+Whg6r10tcXTa2rgn7gaH+OrMd1T7sU/eepYzP/AvN/9eTV5HO
	 oGJ7Opl3ejfSYV5pGsokRoFsXc7As8XF2y8ZV7ZE2EI4dkB6UwjaEAKGlf+1AQB4Yp
	 uan2LaXdq9kM5oqqGjUJn2Is=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 44B0C40E016E;
	Thu, 16 Oct 2025 10:58:06 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:57:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v5 01/35] ASoC: Intel: avs: Include CPUID header at file
 scope
Message-ID: <20251016105514.GCaPDPEu016XyDocfY@fat_crate.local>
References: <20250905121515.192792-1-darwi@linutronix.de>
 <20250905121515.192792-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905121515.192792-2-darwi@linutronix.de>

On Fri, Sep 05, 2025 at 02:14:41PM +0200, Ahmed S. Darwish wrote:
> +#ifdef CONFIG_X86
> +#include <asm/cpuid/api.h>
> +static unsigned int intel_crystal_freq_hz(void)
> +{
> +	return cpuid_ecx(CPUID_LEAF_TSC);
> +}
> +#else
> +static unsigned int intel_crystal_freq_hz(void)
> +{
> +	return 0;
> +}
> +#endif /* !CONFIG_X86 */

Why are we even bothering with !CONFIG_X86?

Because this thing has || COMPILE_TEST in Kconfig.

But this thing gets enough compile testing on x86 already so why not simply
drop the whole unnecessary gunk?

---

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 412555e626b8..63367364916a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -95,7 +95,7 @@ config SND_SOC_INTEL_KEEMBAY
 
 config SND_SOC_INTEL_AVS
 	tristate "Intel AVS driver"
-	depends on X86 || COMPILE_TEST
+	depends on X86
 	depends on PCI
 	depends on COMMON_CLK
 	select ACPI_NHLT if ACPI
diff --git a/sound/soc/intel/avs/tgl.c b/sound/soc/intel/avs/tgl.c
index afb066516101..d920488d24b1 100644
--- a/sound/soc/intel/avs/tgl.c
+++ b/sound/soc/intel/avs/tgl.c
@@ -11,7 +11,7 @@
 #include "debug.h"
 #include "messages.h"
 
-#define CPUID_TSC_LEAF 0x15
+#include <asm/cpuid/api.h>
 
 static int avs_tgl_dsp_core_power(struct avs_dev *adev, u32 core_mask, bool power)
 {
@@ -44,18 +44,15 @@ static int avs_tgl_config_basefw(struct avs_dev *adev)
 {
 	struct pci_dev *pci = adev->base.pci;
 	struct avs_bus_hwid hwid;
+	unsigned int freq;
 	int ret;
-#ifdef CONFIG_X86
-	unsigned int ecx;
 
-#include <asm/cpuid/api.h>
-	ecx = cpuid_ecx(CPUID_TSC_LEAF);
-	if (ecx) {
-		ret = avs_ipc_set_fw_config(adev, 1, AVS_FW_CFG_XTAL_FREQ_HZ, sizeof(ecx), &ecx);
+	freq = cpuid_ecx(CPUID_LEAF_TSC);
+	if (freq) {
+		ret = avs_ipc_set_fw_config(adev, 1, AVS_FW_CFG_XTAL_FREQ_HZ, sizeof(freq), &freq);
 		if (ret)
 			return AVS_IPC_RET(ret);
 	}
-#endif
 
 	hwid.device = pci->device;
 	hwid.subsystem = pci->subsystem_vendor | (pci->subsystem_device << 16);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

