Return-Path: <linux-kernel+bounces-819888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651CB7F835
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948963A983E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479B2F5307;
	Wed, 17 Sep 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Smc/9ZS7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEE2222AA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076220; cv=none; b=pWvSFKBs7vr0STuNZ3bV2oit017O8jY72K4pXY0urcSf473eybwMJzx+Al1AKtIEXgWzyHsEGAGFsw3ZtmmBbQ40RjHkGXeAAq91rPh4sATFqPPueIFywk3kgpvNMgIQqhYWwd9lQf2PmODnIvTICOHObyAFg01RcuTwLWRrIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076220; c=relaxed/simple;
	bh=qL0Ox2fSDt+2G5ScGOEk8w9oM6fmzZPSbVEEvl2KDMA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=spgz+GKg9OIdTmIcQN4sbPsJx7yEwb6/zD6hbZDQEekA5ua0bl5eAdTIxidVOe/pR/dAJJEmyTtztDYH3ZuIfBMJlaCbHIw2BukZPYPJXIXh6sAdB4mEHxON23UHAqvhy/Ico7xzSuXco0X5xabnF3bMIB9XfrIWaYfcyv0nrXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Smc/9ZS7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso25158b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758076217; x=1758681017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbfOHx4kxbLSRlZnJMRy2JtVsUEGR5+lIot3ZCtU+0E=;
        b=Smc/9ZS7NaAOdnO1olRPOvTkY+f0/9gR2OL4il88MlVQYtyButwDa9SkWUSnjBKtVM
         KDjjjH9FAkwpmbUdqbxH1jDLH5FYLLQ7LbOtomqeLDC9fziuhmyGEEdIEgJ24fCNuGJe
         7kd/cBU92VZpf2dL7d2dC+sUBhjQoeXXNkW2Nf7ODftFTOePyExpR9ms1utWxTd4Rd3u
         1cNzND3ZS9k/JxUpPoqKo7yxsobE1HCc1CStXmHEX9myDUC7ndgmRw/NIZPGbT2x/xPb
         1yaX/C4bfwilRFXX9kx3yTBm8Yxrkw0GxZFHRyqDpsUsgpDHvJbFbY7PES8j2DqWc6e1
         oDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758076217; x=1758681017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbfOHx4kxbLSRlZnJMRy2JtVsUEGR5+lIot3ZCtU+0E=;
        b=OmtbtRQ2JXXkcABgthbOFnqLepZOlKwDr24af/p6Jn4A6CFnIPlQO/dN6a6bg9S9eA
         tnWMu7B5zGVLxqLroGxS2b/si/xigOcHjl0ebmqm32cyXmWdL2UFU7GBKBd9n/jr9PoN
         LyWuwzwnz+ZqWX26ogHKKPZx5t9fmrwMkFmnriPDcVtYkNipqoOQXL62miP+SnS7NsJv
         jCQJRLUFdx1gkmTWSG70Ht3mNmV4VvMf0NP/i/0tTSbgcUaDpca6rP4hdnUYC0W1oxSt
         ZqRUlHIaSWiEohI+GUlzHHapShbKqCNIo5iP+XUY2Qyj3NvAhYyleV8tuRd7nYuTO03h
         AAPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2q8itD/LajRAVWueNX26g8HZ32ROK4PHJFz0vcL2FS2l2iGUGRfsj79YZar+XfN+JW38Xh8OIY/A6nIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDkF7EuhJxoP5Oxowtq0NBBlxWfZ9kKjPXGtmsJ7lnlVtkrAN
	Nf9o/tLIxTwZIJ7xvU/wAb7jBE9GWGVmP0YWzyXwE9erwc6TjW8mvHc5QTiIT4yJGqI=
X-Gm-Gg: ASbGncspXJjHImYok4EpksoJTCLSMShDE7Qr4ipYvAu6XBK1rfpP20JHujcWYqJqiId
	CQdSVoRhjKKljpQxFQwUHMibtvLVoeKLaKVbA2TY7JacT8xp47EmRbXqb/y4+OfP20WBGpZ1TN2
	Q1JFXFVOTMdUAYls/bWnU/R+KorKnqAesc4bsPM/oL/5BgIhbhgncUup8f13h1ZI737YCvtKRhY
	qDxJOp4mdxwXAhgaoFV3Yu9ufJtb192zhZ4t0aPrR72C45i55j0vP9W5gCkpf/QsOsAkAYnJ+L3
	6U4tg4C/sZJ2gelPGVP53cVVBLa8Wm+krGIDTTr/m0r/rHheUg1NtkAqxOFkMrwtG8k8YWvKfHX
	8QZN8Bx+Iufi2iffWjr6WQTITFU+J+L5ZF7cDDqvP6PlEl8b5vHcJHyjHWHzI
X-Google-Smtp-Source: AGHT+IHrVERgQmh7lAH6JDt1kYBBcduFHRx2UuVAjcsAgXlINws6Nn6ovQWKdf6zTTGNaVe31DCbfQ==
X-Received: by 2002:a05:6a20:548d:b0:24f:f79d:66a8 with SMTP id adf61e73a8af0-27a96a993f3mr586251637.24.1758076217466;
        Tue, 16 Sep 2025 19:30:17 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1a031sm17829080b3a.57.2025.09.16.19.30.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 19:30:17 -0700 (PDT)
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
Subject: [PATCH] arch_topology: move parse_acpi_topology() to common code
Date: Wed, 17 Sep 2025 10:30:07 +0800
Message-Id: <20250917023007.97637-1-cuiyunhui@bytedance.com>
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
 arch/arm64/kernel/topology.c  | 87 +----------------------------------
 drivers/base/arch_topology.c  | 85 +++++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h |  6 +++
 3 files changed, 91 insertions(+), 87 deletions(-)

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
index 1037169abb459..65ec1f3d2bd28 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -823,12 +823,95 @@ void remove_cpu_topology(unsigned int cpu)
 	clear_cpu_topology(cpu);
 }
 
+__weak bool __init acpi_cpu_is_threaded(int cpu)
+{
+	int is_threaded = acpi_pptt_cpu_is_thread(cpu);
+
+	return !!is_threaded;
+
+}
+
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
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
index d72d6e5aa2002..50d33b5a78ccd 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -70,6 +70,11 @@ struct cpu_topology {
 	cpumask_t llc_sibling;
 };
 
+struct cpu_smt_info {
+	unsigned int thread_num;
+	int core_id;
+};
+
 #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
@@ -88,6 +93,7 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+bool acpi_cpu_is_threaded(int cpu);
 void freq_inv_set_max_ratio(int cpu, u64 max_rate);
 #endif
 
-- 
2.39.5


