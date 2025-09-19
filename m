Return-Path: <linux-kernel+bounces-824248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5F1B887FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E9B560AED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C02F25E0;
	Fri, 19 Sep 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D3kzGZnW"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1572EC087
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272377; cv=none; b=oufwofujvNHCouZRN+bZzAbjU/ePkNEL2TAluc+ycwMLlFCYpeaGSyUa7arETmQO3nrwLUenrO7CQekU0GSJCb5TkbZ2/bM25dum1rMfnLlzlAHwqwnPJpFj8ElnKU2W1sBScvJrIDidcd7l7ausdOxAuhnYBTPYwXL1zb8Jsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272377; c=relaxed/simple;
	bh=rhY9M6WtaAYza5WOkEejOoB1iJqI0wRgUacoCtoTd0s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lyXQz8Kwq6QBHzqpvwQ0PWPCoHE6YysIJIANADif0w6ZzndCGOnO9XFmwXMiqye9t1MMWSBHKynLXhJCfdnPSbY5T0tcNyzuTnWe9I2YdkdyZlKvMwtGMzE/kHDBtjRcj+fgr0y6hneTmct6Uq44KV0S02qNulYu47rXAFAyVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D3kzGZnW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7761b392d50so2490453b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758272375; x=1758877175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ed7wH4BH2c9USQ0xx5UjV+eQ1c1wPsVw6DTEK0h97Kg=;
        b=D3kzGZnWyTHgydVEGJzAsWbQER2tlJczEE5Dsf/aHV3Tl6FzrCJ2Nh5Uwf2Yz3qb2p
         c3wG/YRu0iD6R8B2kuAIPr/ROKDMtMX56tl4WX7VBjTB0DrYDYv6WMN9TuZg+g4rXibw
         Ac70juvP0YYoa4x3tPRy43CAjD2o9WfLmtWp4PlDgaTRPTWU6MKk1K03PPYH6mayWZYy
         HKwZpDWykEwx8bKZ9QHfhggLHvfrPXuWQbOgoE1tnZtS6BYjPV29e+Pqe6DPJLyamdZT
         WhfADyGSwOALS4xq9T2FMM+X3XnAfcoC77ZXqwCBzIiCD8Q5Bg/FOibaxJaDQ3/bwV5c
         vC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758272375; x=1758877175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed7wH4BH2c9USQ0xx5UjV+eQ1c1wPsVw6DTEK0h97Kg=;
        b=GQZmlp+PAwVcHmNYZQan3i80q+AqVAaE05aHJTbkyytxZQGLsh1g0u4W4+OJMKXSJK
         AlCnXj6bZC+pZ2N/KdiKOH5NqLb72tqn1PQ0yZT/xEKh6RasvJCCALsVhNBURCe/sH0K
         GtJF1UstZLlQd94fvCDB71Vkv3hmf4IScSCap117nOs82UZAXHzC5eNzgg5aVeTpI30q
         yQ5YdJ0dFtaurWzIyPAzQUDnF4nOMOAKHb7lr36LD4NfD2hiTV08jSVj7UDga1r6f7z1
         f2znWc6ZXRKdqCsG7FHr2hXc52FvmP4n/J8QxqjjZW6lxDcAB2j0y1taGBgAWExSp1n5
         pO8w==
X-Forwarded-Encrypted: i=1; AJvYcCV7UBA282truJl6sJniCkoPausiCv25eHgyEzIYoqmzhikrkB2PDPcl6qlP3kVHhKMsgDOD9kvhsI31a/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5aP+/Mzr+jsaz1MmN7gSPGu0N5NSIOZr+isKpjEdEKclo+VT
	ijht4+Y8YGFcbctermuvhNkUeWjhLhT53yHExA+EpipZaW/jsuoL4Z3A9abZ8u+zNsU=
X-Gm-Gg: ASbGncuCfJfKHiG3zHSYBpCddDVnRfwPiMPIk14+udroMw8O0XcOG6VnEyb6I4LIL1B
	n4iUA+zb/NCc60HYnWzk9dAA9NmULRasa1qWHpJFgSfMjrugdFJBQ/nkRsGqLPoBAeASBLI7M0m
	hf69GmHmiTT6CUgwuaf3NOU1GcoW/rgHVUTTqus+qiwaBNtGj1AjMHxfxUkgTi6F4F9KVE6v83D
	BMgnzznrWKmNdGHxwNhblTQbvIbSMhs4CnInjDcS+HUm+gLk5ipJNZ4BxcPcIA1xu7tOj3ixxoO
	x40HWjw3sGaI8rO5HD+zjq3L5wYeDL6AM+679aqPRLdpNOwwkInaZYojDIJNoX8i+aBc8xlxLOR
	9IMoD/hXQSomK+q0Ni0iHQtkKIcw8zObYrYBOEtAt4BB7mS5D5tSW
X-Google-Smtp-Source: AGHT+IEpf/5Uci82EAvBJ21mN3DA1E59JJn6rSDZStsQ1j7+Szl4gzUE5LnonR/jL7o1KWe4VvZxDg==
X-Received: by 2002:a05:6a00:3c8f:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-77e4e5c5230mr2637567b3a.16.1758272374689;
        Fri, 19 Sep 2025 01:59:34 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7ab97sm4687456b3a.14.2025.09.19.01.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 01:59:34 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	beata.michalska@arm.com,
	ptsm@linux.microsoft.com,
	sumitg@nvidia.com,
	yangyicong@hisilicon.com,
	cuiyunhui@bytedance.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] arch_topology: move parse_acpi_topology() to common code
Date: Fri, 19 Sep 2025 16:59:18 +0800
Message-Id: <20250919085918.5442-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250919085918.5442-1-cuiyunhui@bytedance.com>
References: <20250919085918.5442-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, RISC-V lacks arch-specific registers for CPU topology
properties and must get them from ACPI. Thus, parse_acpi_topology()
is moved from arm64/ to drivers/ for RISC-V reuse.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/arm64/kernel/topology.c  | 87 +---------------------------------
 drivers/base/arch_topology.c  | 89 ++++++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h |  1 +
 3 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5d07ee85bdae4..55650db53b526 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -26,7 +26,7 @@
 #include <asm/topology.h>
 
 #ifdef CONFIG_ACPI
-static bool __init acpi_cpu_is_threaded(int cpu)
+bool __init acpi_cpu_is_threaded(int cpu)
 {
 	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
 
@@ -39,91 +39,6 @@ static bool __init acpi_cpu_is_threaded(int cpu)
 
 	return !!is_threaded;
 }
-
-struct cpu_smt_info {
-	unsigned int thread_num;
-	int core_id;
-};
-
-/*
- * Propagate the topology information of the processor_topology_node tree to the
- * cpu_topology array.
- */
-int __init parse_acpi_topology(void)
-{
-	unsigned int max_smt_thread_num = 1;
-	struct cpu_smt_info *entry;
-	struct xarray hetero_cpu;
-	unsigned long hetero_id;
-	int cpu, topology_id;
-
-	if (acpi_disabled)
-		return 0;
-
-	xa_init(&hetero_cpu);
-
-	for_each_possible_cpu(cpu) {
-		topology_id = find_acpi_cpu_topology(cpu, 0);
-		if (topology_id < 0)
-			return topology_id;
-
-		if (acpi_cpu_is_threaded(cpu)) {
-			cpu_topology[cpu].thread_id = topology_id;
-			topology_id = find_acpi_cpu_topology(cpu, 1);
-			cpu_topology[cpu].core_id   = topology_id;
-
-			/*
-			 * In the PPTT, CPUs below a node with the 'identical
-			 * implementation' flag have the same number of threads.
-			 * Count the number of threads for only one CPU (i.e.
-			 * one core_id) among those with the same hetero_id.
-			 * See the comment of find_acpi_cpu_topology_hetero_id()
-			 * for more details.
-			 *
-			 * One entry is created for each node having:
-			 * - the 'identical implementation' flag
-			 * - its parent not having the flag
-			 */
-			hetero_id = find_acpi_cpu_topology_hetero_id(cpu);
-			entry = xa_load(&hetero_cpu, hetero_id);
-			if (!entry) {
-				entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-				WARN_ON_ONCE(!entry);
-
-				if (entry) {
-					entry->core_id = topology_id;
-					entry->thread_num = 1;
-					xa_store(&hetero_cpu, hetero_id,
-						 entry, GFP_KERNEL);
-				}
-			} else if (entry->core_id == topology_id) {
-				entry->thread_num++;
-			}
-		} else {
-			cpu_topology[cpu].thread_id  = -1;
-			cpu_topology[cpu].core_id    = topology_id;
-		}
-		topology_id = find_acpi_cpu_topology_cluster(cpu);
-		cpu_topology[cpu].cluster_id = topology_id;
-		topology_id = find_acpi_cpu_topology_package(cpu);
-		cpu_topology[cpu].package_id = topology_id;
-	}
-
-	/*
-	 * This is a short loop since the number of XArray elements is the
-	 * number of heterogeneous CPU clusters. On a homogeneous system
-	 * there's only one entry in the XArray.
-	 */
-	xa_for_each(&hetero_cpu, hetero_id, entry) {
-		max_smt_thread_num = max(max_smt_thread_num, entry->thread_num);
-		xa_erase(&hetero_cpu, hetero_id);
-		kfree(entry);
-	}
-
-	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
-	xa_destroy(&hetero_cpu);
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_ARM64_AMU_EXTN
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb459..09f77fd549490 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -823,12 +823,99 @@ void remove_cpu_topology(unsigned int cpu)
 	clear_cpu_topology(cpu);
 }
 
+__weak bool __init acpi_cpu_is_threaded(int cpu)
+{
+	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
+
+	return is_threaded == 1;
+}
+
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+struct cpu_smt_info {
+	unsigned int thread_num;
+	int core_id;
+};
+
+/*
+ * Propagate the topology information of the processor_topology_node tree to the
+ * cpu_topology array.
+ */
 __weak int __init parse_acpi_topology(void)
 {
+	unsigned int max_smt_thread_num = 1;
+	struct cpu_smt_info *entry;
+	struct xarray hetero_cpu;
+	unsigned long hetero_id;
+	int cpu, topology_id;
+
+	if (acpi_disabled)
+		return 0;
+
+	xa_init(&hetero_cpu);
+
+	for_each_possible_cpu(cpu) {
+		topology_id = find_acpi_cpu_topology(cpu, 0);
+		if (topology_id < 0)
+			return topology_id;
+
+		if (acpi_cpu_is_threaded(cpu)) {
+			cpu_topology[cpu].thread_id = topology_id;
+			topology_id = find_acpi_cpu_topology(cpu, 1);
+			cpu_topology[cpu].core_id   = topology_id;
+
+			/*
+			 * In the PPTT, CPUs below a node with the 'identical
+			 * implementation' flag have the same number of threads.
+			 * Count the number of threads for only one CPU (i.e.
+			 * one core_id) among those with the same hetero_id.
+			 * See the comment of find_acpi_cpu_topology_hetero_id()
+			 * for more details.
+			 *
+			 * One entry is created for each node having:
+			 * - the 'identical implementation' flag
+			 * - its parent not having the flag
+			 */
+			hetero_id = find_acpi_cpu_topology_hetero_id(cpu);
+			entry = xa_load(&hetero_cpu, hetero_id);
+			if (!entry) {
+				entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+				WARN_ON_ONCE(!entry);
+
+				if (entry) {
+					entry->core_id = topology_id;
+					entry->thread_num = 1;
+					xa_store(&hetero_cpu, hetero_id,
+						 entry, GFP_KERNEL);
+				}
+			} else if (entry->core_id == topology_id) {
+				entry->thread_num++;
+			}
+		} else {
+			cpu_topology[cpu].thread_id  = -1;
+			cpu_topology[cpu].core_id    = topology_id;
+		}
+		topology_id = find_acpi_cpu_topology_cluster(cpu);
+		cpu_topology[cpu].cluster_id = topology_id;
+		topology_id = find_acpi_cpu_topology_package(cpu);
+		cpu_topology[cpu].package_id = topology_id;
+	}
+
+	/*
+	 * This is a short loop since the number of XArray elements is the
+	 * number of heterogeneous CPU clusters. On a homogeneous system
+	 * there's only one entry in the XArray.
+	 */
+	xa_for_each(&hetero_cpu, hetero_id, entry) {
+		max_smt_thread_num = max(max_smt_thread_num, entry->thread_num);
+		xa_erase(&hetero_cpu, hetero_id);
+		kfree(entry);
+	}
+
+	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
+	xa_destroy(&hetero_cpu);
 	return 0;
 }
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void __init init_cpu_topology(void)
 {
 	int cpu, ret;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d72d6e5aa2002..8cd8a9604f33f 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -88,6 +88,7 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+bool acpi_cpu_is_threaded(int cpu);
 void freq_inv_set_max_ratio(int cpu, u64 max_rate);
 #endif
 
-- 
2.39.5


