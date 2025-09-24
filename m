Return-Path: <linux-kernel+bounces-830504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E6B99DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E5616D79C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544CA2FE05A;
	Wed, 24 Sep 2025 12:33:18 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62835155A30
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717197; cv=none; b=mj4C9n2MSGBbL2S37HNPU/baWSDIOUG5eZOuWz2r1sLynArHUG/m1dIEqeA9JFKLCuEjv/YnifL2gsLc714wW8Mi3fi3idrHlIhK6kxpAJ8Krc0Wf1f5qg51DJ5Rfi2R3yotDiLN6fhRNtMbuvYVuvfuK+3qqqghVg6kKFIyvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717197; c=relaxed/simple;
	bh=Z2DekRANhU63yCDVlTJ+Ku9N1zzw4/waJ26agKxKQnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amTO0YGQNYABGwsUiWL6g4WdD+3tjDlyeJGRyeJnmdqrsDKKQov8C4eDWSkOMXZIOY9h4BMKdWZo8J8oCzeMrOW+0l/oiMmYLlu0RT2WFVrAMiR8b9qWJvSd1hP3BrC4iWBajHJHYwYaLLCJJxMoQ8RJoigcLw+f5Xghbtvok0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cWx6f24MLzB6mdQ;
	Wed, 24 Sep 2025 20:31:38 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Wed, 24 Sep 2025 20:33:04 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <catalin.marinas@arm.com>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
	<chenjialong@xfusion.com>, <yuxiating@xfusion.com>, shechenglong
	<shechenglong@xfusion.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] cpu: fix hard lockup triggered by printk calls within scheduling context
Date: Wed, 24 Sep 2025 20:32:47 +0800
Message-ID: <20250924123247.807-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20250918064907.1832-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03046.xfusion.com (10.32.128.186) To
 wuxpheds03048.xfusion.com (10.32.143.30)

relocate the printk() calls from spectre_v4_mitigations_off() and
spectre_v2_mitigations_off() into setup_system_capabilities() function,
preventing hard lockups that occur when printk() is invoked from scheduler context.

Link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250918064907.1832-1-shechenglong@xfusion.com/
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 arch/arm64/include/asm/spectre.h |  3 +++
 arch/arm64/kernel/cpufeature.c   |  9 +++++++++
 arch/arm64/kernel/proton-pack.c  | 18 ++++--------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 8fef12626090..6fe29df41788 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -118,5 +118,8 @@ void spectre_bhb_patch_wa3(struct alt_instr *alt,
 void spectre_bhb_patch_clearbhb(struct alt_instr *alt,
 				__le32 *origptr, __le32 *updptr, int nr_inst);
 
+bool spectre_v2_mitigations_off(void);
+bool spectre_v4_mitigations_off(void);
+
 #endif	/* __ASSEMBLY__ */
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef269a5a37e1..7d1f541e66a0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -94,6 +94,7 @@
 #include <asm/traps.h>
 #include <asm/vectors.h>
 #include <asm/virt.h>
+#include <asm/spectre.h>
 
 /* Kernel representation of AT_HWCAP and AT_HWCAP2 */
 static DECLARE_BITMAP(elf_hwcap, MAX_CPU_FEATURES) __read_mostly;
@@ -3942,6 +3943,14 @@ static void __init setup_system_capabilities(void)
 	 */
 	if (system_uses_ttbr0_pan())
 		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
+
+	/*
+	 * Report Spectre mitigations status.
+	 */
+	if (spectre_v2_mitigations_off())
+		pr_info("spectre-v2 mitigation disabled by command line option\n");
+	if (spectre_v4_mitigations_off())
+		pr_info("spectre-v4 mitigation disabled by command-line option\n");
 }
 
 void __init setup_system_features(void)
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index edf1783ffc81..0d4a8a123e07 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -89,14 +89,9 @@ static int __init parse_spectre_v2_param(char *str)
 }
 early_param("nospectre_v2", parse_spectre_v2_param);
 
-static bool spectre_v2_mitigations_off(void)
+bool spectre_v2_mitigations_off(void)
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
@@ -419,15 +414,10 @@ early_param("ssbd", parse_spectre_v4_param);
  * with contradictory parameters. The mitigation is always either "off",
  * "dynamic" or "on".
  */
-static bool spectre_v4_mitigations_off(void)
+bool spectre_v4_mitigations_off(void)
 {
-	bool ret = cpu_mitigations_off() ||
+	return cpu_mitigations_off() ||
 		   __spectre_v4_policy == SPECTRE_V4_POLICY_MITIGATION_DISABLED;
-
-	if (ret)
-		pr_info_once("spectre-v4 mitigation disabled by command-line option\n");
-
-	return ret;
 }
 
 /* Do we need to toggle the mitigation state on entry to/exit from the kernel? */
-- 
2.33.0


