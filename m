Return-Path: <linux-kernel+bounces-862859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE6BF65DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7AD7354C69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5F355052;
	Tue, 21 Oct 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qpJz1HmD"
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78C355026;
	Tue, 21 Oct 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048768; cv=none; b=n737z//9fh+QjlQmAr7HYtdgaMsAo6Tt3kP1h3GJRAuDfDWEBJU/FzYoxwECZL62IsS/wjvIhImToNp8MGmfyJXjo0ac9LAqh1dxcIyjZcj6bwmrwZZDs5GCPYLMTYFy/40PfrCr48Z1H5ss847uazKV15QLMbkzvF0rNaREekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048768; c=relaxed/simple;
	bh=wiD+0/AZVa3NKyDlqbcnqHnYQ4oQcnmmX54eoGAi9Qk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ufr9oyEdcd53bHK/9JSX9uir5++2GU90LUXmYSOampX1LT1L6vk6dw+fa3mazqfslbxvXPntZMQ7A5+dMhyK5uVBBbG4eCtSV0DDo9r7UJHK+XnQoqeq6HqVvNpIgz8Ey1Oi6WCX8gICgnI9czIVJdI8jHJDDIDDs+y5Fb0eyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qpJz1HmD; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZYnZ5rl8ra5LMmp0nS6khBlS0UWmleV+sVAGtX9r6VA=;
	b=qpJz1HmD7inbH6v+Umr1oyzEbNOvum+nx9YHpWOIidwVrx8FLHIgwb1TEuXSPWfAScqYLEgSF
	cWJeZgZJpW58BVuq09wwW8yTA8HXdMaykH/g+hkkOPsl114ujhRKr2WbsUlmmccLGYS3I+9Uu2C
	pXwGmNGbmwyaCiZ25QuS08o=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4crWP073JKzcZyT;
	Tue, 21 Oct 2025 20:11:32 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B5DF18006C;
	Tue, 21 Oct 2025 20:12:42 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 20:12:42 +0800
Received: from huawei.com (10.67.174.28) by kwepemq200011.china.huawei.com
 (7.202.195.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 20:12:41 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <mingo@kernel.org>, <bp@alien8.de>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <maz@kernel.org>,
	<broonie@kernel.org>, <oliver.upton@linux.dev>, <yeoreum.yun@arm.com>,
	<yangyicong@hisilicon.com>, <james.morse@arm.com>, <ardb@kernel.org>,
	<hardevsinh.palaniya@siliconsignals.io>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: Add kernel parameter to disable trap EL0 accesses to IMPDEF regs
Date: Tue, 21 Oct 2025 11:54:28 +0000
Message-ID: <20251021115428.557084-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200011.china.huawei.com (7.202.195.155)

Add kernel parameter to allow system-wide EL0 access to IMPDEF system
regregisters and instructions without trapping to EL1/EL2. Since trap
overhead will compromises benefits, and it's even worse in
virtualization on CPU where certain IMPDEF registers and instructions
are designed for EL0 performance use.

More early discussion could be found from link below.

Link: https://lore.kernel.org/all/24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com/
Tested-by: Xinyu Zheng <zhengxinyu6@huawei.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 arch/arm64/kernel/cpufeature.c                  | 14 +++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5a7a83c411e9..11ffa9f7b972 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -326,6 +326,15 @@
 			See Documentation/arch/arm64/asymmetric-32bit.rst for more
 			information.
 
+	no_trap_el0_impdef [Arm64,EARLY]
+			Allow system-wide EL0 access to IMPDEF system registers
+			and instructions without trapping to EL1/EL2.
+			Since trap overhead compromises benefits, and it's even
+			worse in virtualization on CPU where certain IMPDEF
+			registers and instructions are designed for EL0
+			performance use. This assumes the kernel adds the
+			support for Armv8.8 extension FEAT_TIDCP1.
+
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef269a5a37e1..d12e35d799ee 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2459,9 +2459,21 @@ static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, in
 }
 #endif /* CONFIG_KVM */
 
+static bool no_trap_el0_impdef;
+
+static int __init parse_no_trap_el0_impdef(char *p)
+{
+	no_trap_el0_impdef = true;
+	return 0;
+}
+early_param("no_trap_el0_impdef", parse_no_trap_el0_impdef);
+
 static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
 {
-	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
+	if (no_trap_el0_impdef)
+		sysreg_clear_set(sctlr_el1, SCTLR_EL1_TIDCP, 0);
+	else
+		sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
 }
 
 static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)
-- 
2.34.1


