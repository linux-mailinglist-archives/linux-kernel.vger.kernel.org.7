Return-Path: <linux-kernel+bounces-871697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B4C0E1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936F83B8BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD630505E;
	Mon, 27 Oct 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dpjIOa4N"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE9264627
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572109; cv=none; b=r7LTOrBHwz3psrVpFGJzxij6cwRLWyRywbD9BwyivsO/EKK/lPyu9waoROQQCfo0zAELOQVVlSa/err/Rs5m1Zk38R7Ar29FZA3X2MvseGUA/dvfKkqDDMcHM1CWtlnnqsAKqAfvqZY35UK1AYdmhdz0H+YSByCsqcJ3pyojqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572109; c=relaxed/simple;
	bh=OMQeELq5i1oqj8MMmIr62wlSDWXyLwK8IOuno6mr/zU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZiBFM/SjUfeTLcj9XztO3Yxjve+iUUbrWpSDHm+nSQYgF6HGNPdY9+RbU9TmqO6Waq1GMSDRX+G0cDlhahf2U/Pp8ditQo1Ap6ZNwug3gQlvWzTdkqA41uL0aMalfVkpDqUUa20eBGnIWn8K3Zy/KmVWEs8gYS+++hqgFFS5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dpjIOa4N; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-780fc3b181aso2870394b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761572106; x=1762176906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf2byQo5fmxHvlqt1fW/n5vtPohTmPg2uYhy1tIBWrE=;
        b=dpjIOa4NLVhvPI4Ra1b9+c+cAgutz9ifetjHFwdRfWBNP1Rlju5edfSOV0SpP/tujF
         7aIonDYFORZCCj7YeCGOU2kYJ0SRLx56feKUDZK7nyKhVyTA4UkA5fVGgmE3mnPlTExO
         kaatNOKI7/K7W9bGTvoUzn0vuNCIO6cIlRv0JJzGML58axJJyXV72lKtMy1H0MIiU8VX
         qYCQQ/UTMRoYZlzxf73DA/O0Cxg/HcEqXFfMWJqGtXlQ3VO3+c5GQAjQ+fVIWKUkyHRZ
         svAUapWnocX55qKel0AwLKC2a5uKFCRcrjAF5nyTS7lP6iTHE9wkKmvL6hn8C8LOIif8
         G+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572106; x=1762176906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gf2byQo5fmxHvlqt1fW/n5vtPohTmPg2uYhy1tIBWrE=;
        b=cNtyw6GL5/ffBv/670IP3X/RvaQoH1cRR5d0LKFXPr9Vs1TeiJ5QF7lhFblweAejyg
         AzX49ou+FliudwIKWb0j0QXc1fmI1Gc0Lii13uRCZ9rtpvyO+YPStnAEUKUJBMV3/zbB
         o+LrOanp9hSaKX4hq7hsi6nKyESpxSJW7qc4cKQxAwZCLmMSpl8gBx/Mbnrw322eZ4Uz
         UHQZPRBFgFKWbX2tKGvwx9v+MIaWnS4bag0EpUgycPHO84n5iUKa0NiNoAthi4f+GN9x
         GnEONX9tbk6b24s0nxUtQJipDoVRCJ4FnwU0lsBMaimMc9eoVxYQBIrXSJ2Ogkffdm/J
         lDvw==
X-Forwarded-Encrypted: i=1; AJvYcCXZGBd1T8E74FH+o9bqrIORCmTFGJzIxJY8UOEL6ccVVtvMZSSnCkzTcCYutXJL+QJKc7r0NvsTnmTcb8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiTz04AjLK9h7MRlT398gwroRYIrOxWDmMhZI1461nF+OKOd/
	dMWULVsE6p6PZJ5cbRz5c4IKD+WtMrN7fzqPtjTEI65HQwZcbtfdFwc82ogdZ5TqLn8=
X-Gm-Gg: ASbGncsD4Fc+YL1oAxcOINe3TRkNn4v/3Pl3lQ62l3S+foVKvSorf2XIbvBa4vwy8o6
	8zg3O1O70JmR6Jzt01190Pb9taEYB9R7DrvwGZujIk4GC76airW1H66gy+vten5WcxHZiUSysq+
	5a4U8rpQxt1v7Um/ftX0NJA1N5nWQi/5sbkpavuwXobRBaK+c7przDKbDusV3hs26alfv922EdR
	sr7yop/+3RnI/NywMs764cNrYXbId8BQcUsd3sxmw+IzWuqATwduTWK8eMOfFDCE2EaYxsH314E
	RocUBgPUKzLI3/fi2At+OdAHN4FRFL6tM3uWwFe6mXLSKKz+lSFobV/HKCaJYHSTtOpKfL8aPPX
	Xt/dPWSfwwE4W3jaZt42D9xxoDozz20FEwCewynCGmQST3fyrRniWggK8cy4t6ZkG0ZNal7r3pJ
	ZJ1C+vaFCa3mPR8/wAbpWoqYVBd5fdZw5oigMxCBdeYlID
X-Google-Smtp-Source: AGHT+IEkSEsG4Ebc/jr5wleheQlZJY/QTQo5NA62FtFuEAV5bE/VX+mMzdF9/JFM2TWcUbWDoospuw==
X-Received: by 2002:a17:903:2f88:b0:267:a5df:9b07 with SMTP id d9443c01a7336-2946de3ea9cmr168514315ad.12.1761572105420;
        Mon, 27 Oct 2025 06:35:05 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42558sm82144935ad.69.2025.10.27.06.34.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 06:35:05 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor@kernel.org,
	cuiyunhui@bytedance.com,
	luxu.kernel@bytedance.com,
	atishp@rivosinc.com,
	cleger@rivosinc.com,
	ajones@ventanamicro.com,
	apatel@ventanamicro.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	songshuaishuai@tinylab.org,
	bjorn@rivosinc.com,
	charlie@rivosinc.com,
	masahiroy@kernel.org,
	valentina.fernandezalanis@microchip.com,
	jassisinghbrar@gmail.com,
	conor.dooley@microchip.com
Subject: [PATCH 3/3] riscv: crash: use NMI to stop the CPU
Date: Mon, 27 Oct 2025 21:34:31 +0800
Message-Id: <20251027133431.15321-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251027133431.15321-1-cuiyunhui@bytedance.com>
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NMI is more robust than IPI for stopping CPUs during crashes,
especially with interrupts disabled. Add SBI_SSE_EVENT_LOCAL_CRASH_NMI
eventid to implement NMI for stopping CPUs.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/crash.h   |  1 +
 arch/riscv/include/asm/sbi.h     |  1 +
 arch/riscv/kernel/crash.c        | 31 +++++++++++++-
 drivers/firmware/riscv/sse_nmi.c | 71 +++++++++++++++++++++++++++++++-
 include/linux/sse_nmi.h          |  8 ++++
 5 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/sse_nmi.h

diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/crash.h
index b64df919277d4..5076f297cbc15 100644
--- a/arch/riscv/include/asm/crash.h
+++ b/arch/riscv/include/asm/crash.h
@@ -5,6 +5,7 @@
 
 #ifdef CONFIG_KEXEC_CORE
 void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs);
+void cpu_crash_stop(unsigned int cpu, struct pt_regs *regs);
 #else
 static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 52d3fdf2d4cc1..65cce85237879 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -487,6 +487,7 @@ enum sbi_sse_attr_id {
 #define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS	0x00108000
 #define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED	0xffff0000
 #define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI		0xffff0001
+#define SBI_SSE_EVENT_LOCAL_CRASH_NMI		0xffff0002
 #define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED	0xffff8000
 
 #define SBI_SSE_EVENT_PLATFORM		BIT(14)
diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
index 12598bbc2df04..9f3f0becfdd95 100644
--- a/arch/riscv/kernel/crash.c
+++ b/arch/riscv/kernel/crash.c
@@ -3,14 +3,16 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/kexec.h>
+#include <linux/sse_nmi.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
 
+#include <asm/crash.h>
 #include <asm/cpu_ops.h>
 
 static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 
-inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+void cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 	crash_save_cpu(regs, cpu);
 
@@ -27,6 +29,11 @@ inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 		wait_for_interrupt();
 }
 
+inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
+{
+	cpu_crash_stop(cpu, regs);
+}
+
 /*
  * The number of CPUs online, not counting this CPU (which may not be
  * fully online and so not counted in num_online_cpus()).
@@ -38,6 +45,24 @@ static inline unsigned int num_other_online_cpus(void)
 	return num_online_cpus() - this_cpu_online;
 }
 
+#ifdef CONFIG_RISCV_SSE_NMI
+static int send_nmi_stop_cpu(cpumask_t *mask)
+{
+	unsigned int cpu;
+	int ret = 0;
+
+	for_each_cpu(cpu, mask)
+		ret += carsh_nmi_stop_cpu(cpu);
+
+	return ret;
+}
+#else
+static inline int send_nmi_stop_cpu(cpumask_t *mask)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 void crash_smp_send_stop(void)
 {
 	static int cpus_stopped;
@@ -66,7 +91,9 @@ void crash_smp_send_stop(void)
 	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
 
 	pr_crit("SMP: stopping secondary CPUs\n");
-	send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
+
+	if (send_nmi_stop_cpu(&mask))
+		send_ipi_mask(&mask, IPI_CPU_CRASH_STOP);
 
 	/* Wait up to one second for other CPUs to stop */
 	timeout = USEC_PER_SEC;
diff --git a/drivers/firmware/riscv/sse_nmi.c b/drivers/firmware/riscv/sse_nmi.c
index 2c1eaea2bbabc..152d787075345 100644
--- a/drivers/firmware/riscv/sse_nmi.c
+++ b/drivers/firmware/riscv/sse_nmi.c
@@ -4,13 +4,16 @@
 
 #include <linux/nmi.h>
 #include <linux/riscv_sbi_sse.h>
+#include <linux/sse_nmi.h>
 #include <linux/sysctl.h>
 
+#include <asm/crash.h>
 #include <asm/irq_regs.h>
 #include <asm/sbi.h>
 
 int unknown_nmi_panic;
 static struct sse_event *unknown_nmi_evt;
+static struct sse_event *crash_nmi_evt;
 static struct ctl_table_header *unknown_nmi_sysctl_header;
 
 static int __init setup_unknown_nmi_panic(char *str)
@@ -32,6 +35,12 @@ const struct ctl_table unknown_nmi_table[] = {
 	},
 };
 
+static inline struct sbiret sbi_sse_ecall(int fid, unsigned long arg0,
+					  unsigned long arg1)
+{
+	return sbi_ecall(SBI_EXT_SSE, fid, arg0, arg1, 0, 0, 0, 0);
+}
+
 static int unknown_nmi_handler(u32 evt, void *arg, struct pt_regs *regs)
 {
 	pr_emerg("NMI received for unknown on CPU %d.\n", smp_processor_id());
@@ -73,9 +82,69 @@ static int unknown_nmi_init(void)
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_CORE
+int carsh_nmi_stop_cpu(unsigned int cpu)
+{
+	unsigned int hart_id = cpuid_to_hartid_map(cpu);
+	u32 evt = SBI_SSE_EVENT_LOCAL_CRASH_NMI;
+	struct sbiret ret;
+
+	ret = sbi_sse_ecall(SBI_SSE_EVENT_INJECT, evt, hart_id);
+	if (ret.error) {
+		pr_err("Failed to signal event %x, error %ld\n", evt, ret.error);
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
+	return 0;
+}
+
+static int crash_nmi_handler(u32 evt, void *arg, struct pt_regs *regs)
+{
+	cpu_crash_stop(smp_processor_id(), regs);
+
+	return 0;
+}
+
+static int crash_nmi_init(void)
+{
+	int ret;
+
+	crash_nmi_evt = sse_event_register(SBI_SSE_EVENT_LOCAL_CRASH_NMI, 0,
+				 crash_nmi_handler, NULL);
+	if (IS_ERR(crash_nmi_evt))
+		return PTR_ERR(crash_nmi_evt);
+
+	ret = sse_event_enable(crash_nmi_evt);
+	if (ret) {
+		sse_event_unregister(crash_nmi_evt);
+		return ret;
+	}
+
+	pr_info("Using SSE for crash NMI event delivery\n");
+
+	return 0;
+}
+#endif
+
 static int __init sse_nmi_init(void)
 {
-	return unknown_nmi_init();
+	int ret;
+
+	ret = unknown_nmi_init();
+	if (ret) {
+		pr_err("Unknown_nmi_init failed with error %d\n", ret);
+		return ret;
+	}
+
+#ifdef CONFIG_KEXEC_CORE
+	ret = crash_nmi_init();
+	if (ret) {
+		pr_err("Crash_nmi_init failed with error %d\n", ret);
+		return ret;
+	}
+#endif
+
+	return 0;
 }
 
 late_initcall(sse_nmi_init);
diff --git a/include/linux/sse_nmi.h b/include/linux/sse_nmi.h
new file mode 100644
index 0000000000000..548a348ac0a46
--- /dev/null
+++ b/include/linux/sse_nmi.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_RISCV_SSE_NMI_H
+#define __LINUX_RISCV_SSE_NMI_H
+
+int carsh_nmi_stop_cpu(unsigned int cpu);
+
+#endif
-- 
2.39.5


