Return-Path: <linux-kernel+bounces-821885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A67B828CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D31463DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABA1A5BB4;
	Thu, 18 Sep 2025 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dFpqUEmQ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D123741
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160121; cv=none; b=TppUTEDPPPnL1eCt5KhFiRr+XPRYhXk1CRJY5L/SH6Ug1vzJpfKPciyt1+oewI8L2jYpltJqBZdECzDxKFEAfoM+pVJlG3X1jNkL7VD5RD3NgvgOTqD4vvmyi4FTv1GUdWWq9qGOKNLJ9J7qHx/CZSKZ5clLhq5FrkmyBGYI6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160121; c=relaxed/simple;
	bh=1Hpo5hikSxYp78HojoyWbCu93PukrQYB9v0XFuphil4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=P8Hlavfg9biT405IJfWDjue8w+lw7qUzJu74fupeUwUnyd6gg3YQFuttF5yEtcXB5O3LS0l7k3BVesYZTPZuF94BPYZNSOOr/p3GLg0ofQC02XUrviseYf1EF/bhs9FKUSeMqfKwuB6ILrUsl8NEGJNZJPGS6h1O7oADamcphds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dFpqUEmQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso317486a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758160118; x=1758764918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7KHWyc6262iDZIkf7ifrzZ8+Zh6e+Z9ki+t6iKm7ek=;
        b=dFpqUEmQEoGH6bmJ3JxaKF+XqT6NEo8YSh2QauH6n9eFQzGk2xwX7yITO+24mfeidl
         8rH6Zvigak/z3PcC3bn2TihnsUDAkclzDy3LVIvR4jPmFskzDOapUwfUY2TDRd6RDXwJ
         8gwjKpxitndnU2ZXFEodIAHnNupnwRhtKhaEu8PvV+9cwO/6eTdHFPpWTi4wDabi22kL
         9NmHce3KWdPYByEbcccliQ1Fv0eDbU6x5O2HrAeS+kvVZUbE/YpdIpmWEcDscnzQtP5H
         BoDw+rySBWqacB7vwa7SfBiWa91MECir9Tocs6jY/1m1Azn5nYlSthxHBlole96RN4tf
         OIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160118; x=1758764918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7KHWyc6262iDZIkf7ifrzZ8+Zh6e+Z9ki+t6iKm7ek=;
        b=OlsXV7FJzzpG+XOXMCBfP8/8F6kvl7qQ/vbKWxEQlrw22/LwecfyNbmb4BU3EzCN15
         tF6Z0Q+pssaRIr5VCVNQWbcBi0OWu8vmMlhTbGuf+ke2PWKtsdaF371C92voCKuKdrux
         G50JjzhFl/cBh9UVw8B8CphRUlJqox+AnJhCPv6lWOb1k6vWf86/UuMWQagB5Y5JJn7M
         5B0BA6xxXBvCZsnf0QURcMter7dyNLrQ1SYS3j2laQFaRln9iLZW4/jS2W/D8r0PLPRN
         MZ7sF7arxZISIfJ8sOk7nRxyLg77dSH7m00khYW08xr4UrDkTrtNiHEsujq2u4w9mFl0
         1tbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD1qF5bBjnF0eomAwdu4fj5rQIaPNHOr0R6NXA5rf0xZm83ea+jPkf/YmY5LLq4AFQ/BwF50ZYm3tmVb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wSooS5YFINix/y3PxIJaNkdwqiMwgUx6dgYGLKvIfRcsCjDL
	6juxuFmpTxDoaUD+sRoqjJeI0cSaqjBDDGBoX/yFdzHV272TRQtmFxucNu9MWLZFizE=
X-Gm-Gg: ASbGnct+MnIFIXRFFx3QuccYrUQkLDvaScHsMZgLVyHu7EGOsT5bmKZuDyiydnS8PkN
	92WX3PF1EELamSedyhwOJUGv4zDiXJHq15Uyc99BaeiVDkBDRdBqysKMW1lopQe6vbLlzxwDkVw
	jZmveaqROM9IFUWEyO6WuJ+Lwf26ORyY16/rCrX+Vqx/OTclHIKye9UB4yvSUcwzF3nac3jekxy
	Y3fUYx/xEof741uy4Hacz5JGGhbcVV6vpKV99vKGOWMTKO3i9+hejzpx9eXheJ9T6Jaza/ms00t
	55/Cmkw8e5fmVlK/0HszdKucVmNVM8rcBIkekhe91fn8MbLBwF4YIknpcZR0GUq2M3paxhaTlqC
	5zQe0ODZkpbI+uXcl37iXOXZ9Cfxd8ApnAfoYQgwJO25GGpxr86FuvyxX0k82TzdABsVYsbmswN
	pu/xQ=
X-Google-Smtp-Source: AGHT+IHitHTC24KBfHvioQFUEarlC9ZUeEtoOdWrUlM1i6XbM+QfUC6SN4lioQsTedp7a4Oa06zZxQ==
X-Received: by 2002:a17:90b:390a:b0:32e:3837:284e with SMTP id 98e67ed59e1d1-32ee3f0076emr4883683a91.10.1758160118154;
        Wed, 17 Sep 2025 18:48:38 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7a953sm686176b3a.20.2025.09.17.18.48.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 18:48:37 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	beata.michalska@arm.com,
	sumitg@nvidia.com,
	ptsm@linux.microsoft.com,
	cuiyunhui@bytedance.com,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arch_topology: move parse_acpi_topology() to common code
Date: Thu, 18 Sep 2025 09:48:28 +0800
Message-Id: <20250918014828.78383-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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
index 1037169abb459..c22746b45d57a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -823,12 +823,99 @@ void remove_cpu_topology(unsigned int cpu)
 	clear_cpu_topology(cpu);
 }
 
+__weak bool __init acpi_cpu_is_threaded(int cpu)
+{
+	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
+
+	return !!is_threaded;
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


