Return-Path: <linux-kernel+bounces-745622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05812B11C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142441CE24F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A847C2DE6ED;
	Fri, 25 Jul 2025 10:28:44 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424472DCF68
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439324; cv=none; b=dEWyIfg+6SE8dxY6EohNI20MmYEWMkWHwP3aVfEKQCsPA18sCczkqfTYGnWDeHDkJUnU/oWTn9WXp0GBRmF5PKF2vRg3I5eZxD6b0uyMhWHP4F9NvUxEhk+6ac+pTf9x6lshjwYA9NwvkU1wzHvYIdEZx3IYcKVWOPSMS7z35IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439324; c=relaxed/simple;
	bh=wL0YoBZvA/egp26SXrGZI0omKkqZ2mI9qoUGAzUzx8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QgYUDHjxxBPCP8fK4iqCdkwbX1RE7KJpE7Aw+6B1Cc7EmUROyHkFhJ6DrAPUijiZgYAkBHAjwIgqyAzR8mzp3/H4Fx5n3quP5c1l82p2hdvq32Juq6bb6MXgprl/mOmhKYEig6u6/G1Sf6vPpKzEtjim6USyF/pT1FYWyO8p6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bpPCf6HSQz1R8kY;
	Fri, 25 Jul 2025 18:25:50 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 441321A016C;
	Fri, 25 Jul 2025 18:28:32 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Jul 2025 18:28:31 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <beata.michalska@arm.com>,
	<sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<viresh.kumar@linaro.org>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2] arm64: topology: Setup AMU FIE for online CPUs only
Date: Fri, 25 Jul 2025 18:28:13 +0800
Message-ID: <20250725102813.1404322-1-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100008.china.huawei.com (7.202.181.93)

When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
only CPU0 will go online. The support AMU flag of CPU0 will be set but the
flags of other CPUs will not. This will cause AMU FIE set up fail for CPU0
when it shares a cpufreq policy with other CPU(s). After that, when other
CPUs are finally online and the support AMU flags of them are set, they'll
never have a chance to set up AMU FIE, even though they're eligible.

To solve this problem, the process of setting up AMU FIE needs to be
modified as follows:

1. Set up AMU FIE only for the online CPUs.

2. Try to set up AMU FIE each time a CPU goes online and do the
freq_counters_valid() check for all the online CPUs share the same policy.
If this check fails, clear scale freq source of these CPUs, in case they
use different source of the freq scale.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 arch/arm64/kernel/topology.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5d07ee85bdae..d578c496d457 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -357,12 +357,15 @@ static void amu_fie_setup(const struct cpumask *cpus)
 
 	/* We are already set since the last insmod of cpufreq driver */
 	if (cpumask_available(amu_fie_cpus) &&
-	    unlikely(cpumask_subset(cpus, amu_fie_cpus)))
+	    cpumask_subset(cpus, amu_fie_cpus))
 		return;
 
-	for_each_cpu(cpu, cpus)
-		if (!freq_counters_valid(cpu))
+	for_each_cpu(cpu, cpus) {
+		if (!freq_counters_valid(cpu)) {
+			topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, cpus);
 			return;
+		}
+	}
 
 	if (!cpumask_available(amu_fie_cpus) &&
 	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
@@ -385,7 +388,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
 	struct cpufreq_policy *policy = data;
 
 	if (val == CPUFREQ_CREATE_POLICY)
-		amu_fie_setup(policy->related_cpus);
+		amu_fie_setup(policy->cpus);
 
 	/*
 	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
@@ -404,10 +407,46 @@ static struct notifier_block init_amu_fie_notifier = {
 	.notifier_call = init_amu_fie_callback,
 };
 
+static int cpuhp_topology_online(unsigned int cpu)
+{
+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
+	cpumask_var_t cpus_to_set;
+
+	if (!zalloc_cpumask_var(&cpus_to_set, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpus_to_set, cpumask_of(cpu));
+
+	policy = cpufreq_cpu_get(cpu);
+	if (policy) {
+		cpumask_or(cpus_to_set, cpus_to_set, policy->cpus);
+		amu_fie_setup(cpus_to_set);
+	}
+
+	free_cpumask_var(cpus_to_set);
+	return 0;
+}
+
 static int __init init_amu_fie(void)
 {
-	return cpufreq_register_notifier(&init_amu_fie_notifier,
+	int ret;
+
+	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
 					CPUFREQ_POLICY_NOTIFIER);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"arm64/topology:online",
+					cpuhp_topology_online,
+					NULL);
+	if (ret < 0) {
+		cpufreq_unregister_notifier(&init_amu_fie_notifier,
+					    CPUFREQ_POLICY_NOTIFIER);
+		return ret;
+	}
+
+	return 0;
 }
 core_initcall(init_amu_fie);
 
-- 
2.33.0


