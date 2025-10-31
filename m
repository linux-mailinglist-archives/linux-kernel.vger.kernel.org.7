Return-Path: <linux-kernel+bounces-879822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D1C241B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 557A54F2C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A34330322;
	Fri, 31 Oct 2025 09:16:03 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326F32F774
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902163; cv=none; b=OkCntIfF/ci7SMKNPCWKXOO8Ec5LWuSrD6lqk2ikLhSr6m1XnrW/ofMbSnKd33HQhbN1mnV28aFZySJWr6pHWL4cYZtmrx8ZReamPINXh2i4FUW9HLKEVEDwxXoJTCBw6jr1o1eQKDA/XvyZbA/jSRYw3J4IjVX7uMMyGTryVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902163; c=relaxed/simple;
	bh=xeK78IQbAgvQ2hlSqh3ciefUMDMs69NGZ7iMAPLiTKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3xR/CHg+v4UGCOxfE/v0SAyXpBJdPL1xYzYTeCo5FoA0I3xS02sBABwN780vMEjEltj9qgdoWT92CKRQkIj1GcNYMsfJvq1lDLOuh6a7Ae6JqJnt023Q/RO3ZItRujR59/hrIdODhyDmCXgwe8szsHjSzgnXpIMIcVd7aFkXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cyb0y0CTszB9Xpw;
	Fri, 31 Oct 2025 17:15:14 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Fri, 31 Oct 2025 17:15:50 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>,
	<yuxiating@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [PATCH v3 2/2] cpu: fix hard lockup triggered by printk calls within scheduling context
Date: Fri, 31 Oct 2025 17:15:06 +0800
Message-ID: <20251031091507.1896-3-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20251031091507.1896-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <20251031091507.1896-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)

relocate the printk() calls from spectre_v4_mitigations_off() and
spectre_v2_mitigations_off() into setup_system_capabilities() function,
preventing hard lockups caused by printk calls in scheduler context.

Link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250918064907.1832-1-shechenglong@xfusion.com/
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 arch/arm64/include/asm/spectre.h |  1 +
 arch/arm64/kernel/cpufeature.c   |  6 ++++++
 arch/arm64/kernel/proton-pack.c  | 33 +++++++++++++++++---------------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 8fef12626090..900454aaa292 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -117,6 +117,7 @@ void spectre_bhb_patch_wa3(struct alt_instr *alt,
 			   __le32 *origptr, __le32 *updptr, int nr_inst);
 void spectre_bhb_patch_clearbhb(struct alt_instr *alt,
 				__le32 *origptr, __le32 *updptr, int nr_inst);
+void spectre_print_disabled_mitigations(void);
 
 #endif	/* __ASSEMBLY__ */
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5ed401ff79e3..e25b0f84a22d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -95,6 +95,7 @@
 #include <asm/vectors.h>
 #include <asm/virt.h>
 
+#include <asm/spectre.h>
 /* Kernel representation of AT_HWCAP and AT_HWCAP2 */
 static DECLARE_BITMAP(elf_hwcap, MAX_CPU_FEATURES) __read_mostly;
 
@@ -3875,6 +3876,11 @@ static void __init setup_system_capabilities(void)
 	 */
 	if (system_uses_ttbr0_pan())
 		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
+
+	/*
+	 * Report Spectre mitigations status.
+	 */
+	spectre_print_disabled_mitigations();
 }
 
 void __init setup_system_features(void)
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index d833b7c1bba8..c7d70d04c164 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -91,12 +91,7 @@ early_param("nospectre_v2", parse_spectre_v2_param);
 
 static bool spectre_v2_mitigations_off(void)
 {
-	bool ret = __nospectre_v2 || cpu_mitigations_off();
-
-	if (ret)
-		pr_info_once("spectre-v2 mitigation disabled by command line option\n");
-
-	return ret;
+	return __nospectre_v2 || cpu_mitigations_off();
 }
 
 static const char *get_bhb_affected_string(enum mitigation_state bhb_state)
@@ -421,13 +416,8 @@ early_param("ssbd", parse_spectre_v4_param);
  */
 static bool spectre_v4_mitigations_off(void)
 {
-	bool ret = cpu_mitigations_off() ||
-		   __spectre_v4_policy == SPECTRE_V4_POLICY_MITIGATION_DISABLED;
-
-	if (ret)
-		pr_info_once("spectre-v4 mitigation disabled by command-line option\n");
-
-	return ret;
+	return cpu_mitigations_off() ||
+	       __spectre_v4_policy == SPECTRE_V4_POLICY_MITIGATION_DISABLED;
 }
 
 /* Do we need to toggle the mitigation state on entry to/exit from the kernel? */
@@ -1042,8 +1032,6 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 
 	if (arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE) {
 		/* No point mitigating Spectre-BHB alone. */
-	} else if (cpu_mitigations_off() || __nospectre_bhb) {
-		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
 	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
 		state = SPECTRE_MITIGATED;
 		set_bit(BHB_HW, &system_bhb_mitigations);
@@ -1197,3 +1185,18 @@ void unpriv_ebpf_notify(int new_state)
 		pr_err("WARNING: %s", EBPF_WARN);
 }
 #endif
+
+void spectre_print_disabled_mitigations(void)
+{
+	/* Keep a single copy of the common message suffix to avoid duplication. */
+	const char *spectre_disabled_suffix = "mitigation disabled by command-line option\n";
+
+	if (spectre_v2_mitigations_off())
+		pr_info("spectre-v2 %s", spectre_disabled_suffix);
+
+	if (spectre_v4_mitigations_off())
+		pr_info("spectre-v4 %s", spectre_disabled_suffix);
+
+	if (__nospectre_bhb || cpu_mitigations_off())
+		pr_info("spectre-bhb %s", spectre_disabled_suffix);
+}
-- 
2.33.0


