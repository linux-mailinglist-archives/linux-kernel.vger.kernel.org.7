Return-Path: <linux-kernel+bounces-828090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28FB93E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30123A6234
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8425F7A5;
	Tue, 23 Sep 2025 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P7oDHlYV"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC62CCC0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592473; cv=none; b=sPeZAjyIPBzhx5OxlO/bDRthHnqklO+0szGW/WQPOy1AZQBabQXwi1k128o1U2MkNC4d2IStHBQc/HKGb4PuyuTzV79f0UF7ufvnI0Xm15FYvJb4Y5ZDc0IZYwiCvDAUli7Bd5OjVQy1oczsG35OqUmZFCYjbkcyybRasorqnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592473; c=relaxed/simple;
	bh=UUNd97xB69CRa+VWH8WDlfC/7yzej2Br0UbCqUKDNh8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EARc5+uZqrOPv8PHpk90G6wniFP6OuXQO478RgtsuRfqf6WQQL1Gx/Re3olq5chOwOEY8/DncA8Y7kl66lTYONXwwIHz2vs7mH1DpCKEaF5x3xHRxsceuarMp1+CnIYtYs1g20bAJrzaatrT9t50k5iEURVPTUuKYIXn0pTdKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P7oDHlYV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3322e63602eso2371966a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758592471; x=1759197271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsk0+ZyYUlCeBMpvtgc0y0+NQ46VkaEHVxXhIiqoDXY=;
        b=P7oDHlYVEYSP7GR6cpfdBO7rOodWOB/k7YRaCCkuMmZpPwFEmhCjhlVLxZG0dZd7Ay
         Oc/lo6O3zk9ctuS4wwHhP/9x6uRb58KfV7NZFllHNk7/z+b2IgE2/jsHax4oB5tma9xo
         SFjtTXel9xjEwQuKKuARugg5h4e/7Ow+NNDNICR6+o9kZVpiPDtnSXo4oAxVTfHGyxCR
         FoQsc9Pk8RFHpyGa/vMmhSK//KNgrRkKerXDF5ez/k9I+wn42oRf3wC45PeQ7rfAb3VT
         zvIqlS/QvidUxlnFMus4PYF1A2Gn09TDOEYpK9M2qQdr31CyXOCzrJF5E+v7a8bBHk6n
         2hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758592471; x=1759197271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsk0+ZyYUlCeBMpvtgc0y0+NQ46VkaEHVxXhIiqoDXY=;
        b=lxzlIlbebTRWYVAC92ulyYPCKxuMyCGPLeqkNikOXgadHSl5K2nliCIy1+JZZLqjd2
         VOQCrXpP42x0ylXL/PI89noVhBvMRoJ9suscgJauOwEKHK7maPrKLQn6nIp29+6Q1wA0
         OD6rsSeBY6SNCJL7dRCtuQDq4yvcig4qJFBBB7ohusqpR8NgXZJHxNuywqtBUiFCEcR3
         RgcxqxqR4tLmzlGJRiEzW0zHHgfCRo88b63haxCuIRH/UwHfHENrcYv884ogC35g/9tY
         8mJmalpExNgfMEmJNl9JQI8pMz4fttVnYuaNuwPGlKzrMrjr5DCNoGQTLV1BmuU+Zons
         hl/w==
X-Forwarded-Encrypted: i=1; AJvYcCWnQKDuehdLHdy9SkXvRdi+AIvF3kDzR94YvJrkELbJyzncPJi5rTItY8IU2KcnU0TOj3COXrau/uD2eCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkyiRPdCYH6576OXuk5F+w4Eqq71NRbeuzyDmMH8BDogndadl/
	h6XU5uKMrpXfpAoU8PzsP4+KrmHWf4oE79SrVyqaO+Bwt/ULVVuzdkOZ0FCB0G8EvW0=
X-Gm-Gg: ASbGncuhfXM6SmkFnCvJKIzZ8khMQxF5cdw5gAjJFrbS3PYUBYWZIVEL/jSUs7JOiA6
	ifzbrKU78p9TqTkZ+0Cr+IDRAWlHQg+hb6y5SeCa9WwJKFp1m/1cuATmqMe24lyFPn2P28a4okz
	oySXkb5jbZtk6oz94AcDj1c4Ul0ULyQmnXjDh2XF9OPa8a6eJppRdozfL/oWv3BTSEfP59o/tU+
	9B9kkpwq5w7Mpol7rBmvVMQ6B0n6QjDepjdPwXWVjU79Ax1heGQay32hECOnmiYE7PHRyszG0ih
	CmePaj1c9CnL/gvWF3eXPmBbunjnhLNwb4hLJkDK6ljbufVdbYnAV0Ld/adIiAlFTy60FStjeoj
	ZQS4nlcIMRothUzgSp6mGrxd/1Wsr9f5YosiKyPhXMXYOX2B7ob5uU8ZCc+iAxvHv
X-Google-Smtp-Source: AGHT+IFbfrf5fhSPzrWBkgzrIx7CiQAXrF0fvKls15yDg7nnQCeX/7p3u/SEr+iLhqBLX3uBca/v2g==
X-Received: by 2002:a17:90b:48d1:b0:32e:c649:e583 with SMTP id 98e67ed59e1d1-332a95e9184mr924901a91.22.1758592470782;
        Mon, 22 Sep 2025 18:54:30 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed268813bsm17503265a91.1.2025.09.22.18.54.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Sep 2025 18:54:30 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	mario.limonciello@amd.com,
	cuiyunhui@bytedance.com,
	beata.michalska@arm.com,
	sumitg@nvidia.com,
	ptsm@linux.microsoft.com,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] arch_topology: move parse_acpi_topology() to common code
Date: Tue, 23 Sep 2025 09:54:09 +0800
Message-Id: <20250923015409.15983-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250923015409.15983-1-cuiyunhui@bytedance.com>
References: <20250923015409.15983-1-cuiyunhui@bytedance.com>
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
 arch/arm64/include/asm/topology.h |   3 +
 arch/arm64/kernel/topology.c      | 101 ------------------------------
 drivers/base/arch_topology.c      |  96 +++++++++++++++++++++++++++-
 include/linux/arch_topology.h     |   5 ++
 4 files changed, 103 insertions(+), 102 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 341174bf91063..b9eaf4ad70850 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -36,6 +36,9 @@ void update_freq_counters_refs(void);
 #define arch_scale_hw_pressure topology_get_hw_pressure
 #define arch_update_hw_pressure	topology_update_hw_pressure
 
+#undef arch_cpu_is_threaded
+#define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMASK)
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5d07ee85bdae4..5d24dc53799b7 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -25,107 +25,6 @@
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-#ifdef CONFIG_ACPI
-static bool __init acpi_cpu_is_threaded(int cpu)
-{
-	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
-
-	/*
-	 * if the PPTT doesn't have thread information, assume a homogeneous
-	 * machine and return the current CPU's thread state.
-	 */
-	if (is_threaded < 0)
-		is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
-
-	return !!is_threaded;
-}
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
-#endif
-
 #ifdef CONFIG_ARM64_AMU_EXTN
 #define read_corecnt()	read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0)
 #define read_constcnt()	read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0)
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb459..1ccb1eda4ce8b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -823,12 +823,106 @@ void remove_cpu_topology(unsigned int cpu)
 	clear_cpu_topology(cpu);
 }
 
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+struct cpu_smt_info {
+	unsigned int thread_num;
+	int core_id;
+};
+
+static bool __init acpi_cpu_is_threaded(int cpu)
+{
+	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
+
+	/*
+	 * if the PPTT doesn't have thread information, check for architecture
+	 * specific fallback if available
+	 */
+	if (is_threaded < 0)
+		is_threaded = arch_cpu_is_threaded();
+
+	return !!is_threaded;
+}
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
index d72d6e5aa2002..766ed9cf0e549 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -80,6 +80,11 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
 #define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
+
+#ifndef arch_cpu_is_threaded
+#define arch_cpu_is_threaded()	(0)
+#endif
+
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
-- 
2.39.5


