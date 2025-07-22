Return-Path: <linux-kernel+bounces-741314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED0AB0E2B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4144EAC0BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5628137C;
	Tue, 22 Jul 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O/VldrfG"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526028031C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205920; cv=none; b=SAnNE8Ue9NrWxYa74JmLp5U5wLL+I4sC4BHDlC0N/ZCK8elbI4POo6SixcE+y7PoriyPcG4VXKZ9xQj2AOsiDdUQqa80j99nrDzFXCx8AxUtm5ryaBZnk81wEZoOSrkw9ymV+ZuQKVAcxVF/KScvamOoqihdlteYTUigpAlNBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205920; c=relaxed/simple;
	bh=X0nYrS4JALaj/fpgpCsXuXix6lXWM6RhMXvsIL5A6Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDXSTCfk6amFfaD9ZuYCNSzkLwKdDkX1jeVkMAxNNkRZQ5y6KTNFaQkdsKCOKEGASjV9lQsrd9JE2BxxSU0tPWfLXXBE+aT19gNMlz+yKhgiPOrkO10lj0lJbEvE1jdrhMEHpHfaNlu4RSzMG4nUKlm/VucicWtPP3vxxxyrqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O/VldrfG; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so76189676d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753205917; x=1753810717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXqZufAwOynwVDtOm/mGtjNRKy10BDBSIzmTZQmFVT0=;
        b=O/VldrfGjsUDBzNSusIgwjoZjSNF1oW4Zlr7lwnr07ltllxkwLxab/dRc7y+GbcFX+
         xZVUsknLXaCTfn5hwkuUMKykmVacBAjjtaBtv++bGAhdxyMZqr/OJfAJ3AuWa0/r0xJz
         cgwIAEwN9NlA9DtPqytE8FFJlFPQTypcpwNppzEFhAX5SZivAW0IZz9YQdsKLfF/4EQB
         3OOYw9pwe/khpeMQeKh5l7vGiiHJF73I3VqF1UgNF5/I+v3+WlPmIMbw3FAYtgISi2Yv
         MM8NpjHbw4TQI83EX/EtaApewz/gZnQ2PVGvl7WzJeafgR5NOZAqSS+pwecTD57lJRFG
         SsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205917; x=1753810717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXqZufAwOynwVDtOm/mGtjNRKy10BDBSIzmTZQmFVT0=;
        b=WLU9/PI76FIhZkUNGb4NCjtESwriBFuAHmZBn/iDMadmKpx+w6yMsrNxA0DiXq2dtK
         JkpYee++Pd+sOqj26Yjy+JHif6APpxMAWYCZKkQ9GuWXNvC7F6rG2SND2fpzMmFLUoy8
         phdh+y+4xCCRkhouF+u+4zf3soDf7AIcpxjO17O15ZrsrTb1dYHM6e3Ov9kAoRMNDhs4
         rc1IwxMxvXAITBGanIsy/BF55YWZodRzcKkY0A677JhNCGH+fAy2OsCPkuHiH6J75zdT
         RwFhxEbaSWGaaopXqq6ebywgqaOVsaMTtztJzXUD3Ewx5RN8MewFd+Elp6yZTIcP9Fhz
         i0MA==
X-Forwarded-Encrypted: i=1; AJvYcCW9XSwiK6gJSdX7ab0iVNRfB02k9l/4Uo1Dl2a0qVsgIaVvyNz6edgSXiz2qJBZ/CcFou+aE0lJfQsulbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUVQ6+A5WIhAjwNEsMpN4uRRmz6BAXHJFexy/sHLPdq7+UdjPp
	7aqcZzEx7pYRb9MchjUOBWHoT1r7pNK1344Sc2RuLyzCYrqs5GFodLv2C+Qm842OTs4=
X-Gm-Gg: ASbGncuLKWjp/a2sBBXW41WzJN4RpXKKQ7goeshuJ7FLOcc/qyn4Lg3p6FW8MamQdht
	AqtJGdC24bsjOtJDRtxGqPr+pndfvzLAaLUEY5QSUGoDO3bUyLTf9G+BzYyk2mEolZX5NBFw/mc
	EVVfVXLnWhEXnXiBjgj05+OlWZr3g4KUHhPDkammOHIYL7OEZGNvN/pe8roBLYh20lFDZakC1Y2
	wl11s+/HhpBVKv9N3HFUCsxxK5RZWeN8UUU5o4WfY0cHGuEppKf1jqH6UndazlfRfaJHfExG60o
	puEw30uMtZtUS7ds+4M2e9UPVlrXcnvJnu+bY+47slrCk3FAXiq4CJSnRshnrbS7KmlD47Y066S
	ZA1M47L9W2e46z1phYYlcUMWAP0sSblSXBSYMVvwk/EGCHV5w6wvDclrKKFkz3tQyRcs3nQiNZe
	Y2ARSegLhq2QY=
X-Google-Smtp-Source: AGHT+IFl5MdnALhnFlAPeUqJjc0LiQr4y0cJ3FIOSwIVt0xu3nkZkMzLnHNIn0BMb25QIizG2QBzmg==
X-Received: by 2002:a05:6214:226c:b0:704:8fa0:969e with SMTP id 6a1803df08f44-7051a17b191mr204722796d6.41.1753205916756;
        Tue, 22 Jul 2025 10:38:36 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b783sm54184536d6.73.2025.07.22.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:38:36 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Evan Green <evan@rivosinc.com>,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [RFC PATCH 4/6] riscv: Introduce support for hardware break/watchpoints
Date: Tue, 22 Jul 2025 10:38:27 -0700
Message-ID: <20250722173829.984082-5-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722173829.984082-1-jesse@rivosinc.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

RISC-V hardware breakpoint framework is built on top of perf subsystem and uses
SBI debug trigger extension to install/uninstall/update/enable/disable hardware
triggers as specified in Sdtrig ISA extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/hw_breakpoint.h |  60 +++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/include/asm/sbi.h           |   4 +-
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 620 +++++++++++++++++++++++++
 arch/riscv/kernel/traps.c              |   6 +
 7 files changed, 693 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bbec87b79309..95d3047cab10 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -163,6 +163,7 @@ config RISCV
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS && RISCV_SBI
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
new file mode 100644
index 000000000000..8efa3921c535
--- /dev/null
+++ b/arch/riscv/include/asm/hw_breakpoint.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Ventana Micro Systems Inc.
+ */
+
+#ifndef __RISCV_HW_BREAKPOINT_H
+#define __RISCV_HW_BREAKPOINT_H
+
+struct task_struct;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+#include <uapi/linux/hw_breakpoint.h>
+
+#if __riscv_xlen == 64
+#define cpu_to_le cpu_to_le64
+#define le_to_cpu le64_to_cpu
+#elif __riscv_xlen == 32
+#define cpu_to_le cpu_to_le32
+#define le_to_cpu le32_to_cpu
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+struct arch_hw_breakpoint {
+	unsigned long address;
+	unsigned long len;
+
+	/* Callback info */
+	unsigned long next_addr;
+	bool in_callback;
+
+
+	/* Trigger configuration data */
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+/* Maximum number of hardware breakpoints supported */
+#define RV_MAX_TRIGGERS 32
+
+struct perf_event_attr;
+struct notifier_block;
+struct perf_event;
+struct pt_regs;
+
+int hw_breakpoint_slots(int type);
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data);
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#endif /* __RISCV_HW_BREAKPOINT_H */
diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kdebug.h
index 85ac00411f6e..53e989781aa1 100644
--- a/arch/riscv/include/asm/kdebug.h
+++ b/arch/riscv/include/asm/kdebug.h
@@ -6,7 +6,8 @@
 enum die_val {
 	DIE_UNUSED,
 	DIE_TRAP,
-	DIE_OOPS
+	DIE_OOPS,
+	DIE_DEBUG
 };
 
 #endif
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index be2ca8e8a49e..64fa7a82aa45 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -282,7 +282,9 @@ struct sbi_sta_struct {
 	u8 pad[47];
 } __packed;
 
-#define SBI_SHMEM_DISABLE		-1
+#define SBI_SHMEM_DISABLE	(-1UL)
+#define SBI_SHMEM_LO(pa)	((unsigned long)lower_32_bits(pa))
+#define SBI_SHMEM_HI(pa)	((unsigned long)upper_32_bits(pa))
 
 enum sbi_ext_nacl_fid {
 	SBI_EXT_NACL_PROBE_FEATURE = 0x0,
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4f719b09e5ad..3e72505734bd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
new file mode 100644
index 000000000000..9e3a3b82d300
--- /dev/null
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Ventana Micro Systems Inc.
+ */
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/kdebug.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+
+#include <asm/insn.h>
+#include <asm/sbi.h>
+
+#define DBTR_TDATA1_TYPE_SHIFT		(__riscv_xlen - 4)
+#define DBTR_TDATA1_DMODE		BIT_UL(__riscv_xlen - 5)
+
+#define DBTR_TDATA1_TYPE_MCONTROL	(2UL << DBTR_TDATA1_TYPE_SHIFT)
+#define DBTR_TDATA1_TYPE_MCONTROL6	(6UL << DBTR_TDATA1_TYPE_SHIFT)
+
+#define DBTR_TDATA1_MCONTROL6_LOAD		BIT(0)
+#define DBTR_TDATA1_MCONTROL6_STORE		BIT(1)
+#define DBTR_TDATA1_MCONTROL6_EXECUTE		BIT(2)
+#define DBTR_TDATA1_MCONTROL6_U			BIT(3)
+#define DBTR_TDATA1_MCONTROL6_S			BIT(4)
+#define DBTR_TDATA1_MCONTROL6_M			BIT(6)
+#define DBTR_TDATA1_MCONTROL6_SIZE_FIELD	GENMASK(18, 16)
+#define DBTR_TDATA1_MCONTROL6_SELECT		BIT(21)
+#define DBTR_TDATA1_MCONTROL6_VU		BIT(23)
+#define DBTR_TDATA1_MCONTROL6_VS		BIT(24)
+
+#define DBTR_TDATA1_MCONTROL6_SIZE_8BIT		1
+#define DBTR_TDATA1_MCONTROL6_SIZE_16BIT	2
+#define DBTR_TDATA1_MCONTROL6_SIZE_32BIT	3
+#define DBTR_TDATA1_MCONTROL6_SIZE_64BIT	5
+
+#define DBTR_TDATA1_MCONTROL_LOAD		BIT(0)
+#define DBTR_TDATA1_MCONTROL_STORE		BIT(1)
+#define DBTR_TDATA1_MCONTROL_EXECUTE		BIT(2)
+#define DBTR_TDATA1_MCONTROL_U			BIT(3)
+#define DBTR_TDATA1_MCONTROL_S			BIT(4)
+#define DBTR_TDATA1_MCONTROL_M			BIT(6)
+#define DBTR_TDATA1_MCONTROL_SIZELO_FIELD	GENMASK(17, 16)
+#define DBTR_TDATA1_MCONTROL_SELECT		BIT(19)
+#define DBTR_TDATA1_MCONTROL_SIZEHI_FIELD	GENMASK(22, 21)
+
+#define DBTR_TDATA1_MCONTROL_SIZELO_8BIT	1
+#define DBTR_TDATA1_MCONTROL_SIZELO_16BIT	2
+#define DBTR_TDATA1_MCONTROL_SIZELO_32BIT	3
+/* value of 5 split across HI and LO */
+#define DBTR_TDATA1_MCONTROL_SIZELO_64BIT	1
+#define DBTR_TDATA1_MCONTROL_SIZEHI_64BIT	1
+
+/* Registered per-cpu bp/wp */
+static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RV_MAX_TRIGGERS]);
+static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
+static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
+
+/* Per-cpu shared memory between S and M mode */
+static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, sbi_dbtr_shmem);
+
+/* number of debug triggers on this cpu . */
+static int dbtr_total_num __ro_after_init;
+static unsigned long dbtr_type __ro_after_init;
+static unsigned long dbtr_init __ro_after_init;
+
+static int arch_smp_setup_sbi_shmem(unsigned int cpu)
+{
+	union sbi_dbtr_shmem_entry *dbtr_shmem;
+	unsigned long shmem_pa;
+	struct sbiret ret;
+	int rc;
+
+	dbtr_shmem = per_cpu_ptr(&sbi_dbtr_shmem, cpu);
+	if (!dbtr_shmem) {
+		pr_err("Invalid per-cpu shared memory for debug triggers\n");
+		return -ENODEV;
+	}
+
+	shmem_pa = virt_to_phys(dbtr_shmem);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			SBI_SHMEM_LO(shmem_pa), SBI_SHMEM_HI(shmem_pa), 0, 0, 0, 0);
+
+	if (ret.error) {
+		switch (ret.error) {
+		case SBI_ERR_DENIED:
+			pr_warn("%s: Access denied for shared memory at %lx\n",
+				__func__, shmem_pa);
+			rc = -EPERM;
+			break;
+
+		case SBI_ERR_INVALID_PARAM:
+		case SBI_ERR_INVALID_ADDRESS:
+			pr_warn("%s: Invalid address parameter (%ld)\n",
+				__func__, ret.error);
+			rc = -EINVAL;
+			break;
+
+		case SBI_ERR_ALREADY_AVAILABLE:
+			pr_warn("%s: Shared memory is already set\n",
+				__func__);
+			rc = -EADDRINUSE;
+			break;
+
+		case SBI_ERR_FAILURE:
+			pr_err("%s: Internal sdtrig state error\n",
+			       __func__);
+			rc = -ENXIO;
+			break;
+
+		default:
+			pr_warn("%s: Unknown error %lu\n", __func__, ret.error);
+			rc = -ENXIO;
+			break;
+		}
+	}
+
+	pr_debug("CPU %d: HW Breakpoint shared memory registered.\n", cpu);
+
+	return rc;
+}
+
+static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
+{
+	struct sbiret ret;
+
+	/* Disable shared memory */
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			SBI_SHMEM_DISABLE, SBI_SHMEM_DISABLE, 0, 0, 0, 0);
+
+	if (ret.error) {
+		switch (ret.error) {
+		case SBI_ERR_DENIED:
+			pr_err("%s: Access denied for shared memory.\n",
+			       __func__);
+			break;
+
+		case SBI_ERR_INVALID_PARAM:
+		case SBI_ERR_INVALID_ADDRESS:
+			pr_err("%s: Invalid address parameter (%lu)\n",
+			       __func__, ret.error);
+			break;
+
+		case SBI_ERR_ALREADY_AVAILABLE:
+			pr_err("%s: Shared memory is already set\n",
+			       __func__);
+			break;
+		case SBI_ERR_FAILURE:
+			pr_err("%s: Internal sdtrig state error\n",
+			       __func__);
+			break;
+		default:
+			pr_err("%s: Unknown error %lu\n", __func__, ret.error);
+			break;
+		}
+	}
+
+	pr_debug("CPU %d: HW Breakpoint shared memory disabled.\n", cpu);
+
+	return 0;
+}
+
+static void init_sbi_dbtr(void)
+{
+	struct sbiret ret;
+
+	/*
+	 * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
+	 * Only proceed if this is the first CPU to reach this code.
+	 */
+	if (test_and_set_bit(0, &dbtr_init))
+		return;
+
+	if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
+		pr_debug("%s: SBI_EXT_DBTR is not supported\n", __func__);
+		dbtr_total_num = 0;
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect mcontrol6 triggers. error: %ld.\n",
+			__func__, ret.error);
+	} else if (!ret.value) {
+		pr_warn("%s: No mcontrol6 triggers available.\n", __func__);
+	} else {
+		dbtr_total_num = ret.value;
+		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL6;
+		return;
+	}
+
+	/* fallback to legacy mcontrol triggers if mcontrol6 is not available */
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			DBTR_TDATA1_TYPE_MCONTROL, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect mcontrol triggers. error: %ld.\n",
+			__func__, ret.error);
+	} else if (!ret.value) {
+		pr_err("%s: No mcontrol triggers available.\n", __func__);
+		dbtr_total_num = 0;
+	} else {
+		dbtr_total_num = ret.value;
+		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL;
+	}
+}
+
+int hw_breakpoint_slots(int type)
+{
+	/*
+	 * We can be called early, so don't rely on
+	 * static variables being initialised.
+	 */
+	init_sbi_dbtr();
+
+	return dbtr_total_num;
+}
+
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	unsigned int len;
+	unsigned long va;
+
+	va = hw->address;
+	len = hw->len;
+
+	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
+}
+
+static int rv_init_mcontrol_trigger(const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw)
+{
+	unsigned long tdata1 = DBTR_TDATA1_TYPE_MCONTROL;
+
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		tdata1 |= DBTR_TDATA1_MCONTROL_EXECUTE;
+		break;
+	case HW_BREAKPOINT_R:
+		tdata1 |= DBTR_TDATA1_MCONTROL_LOAD;
+		break;
+	case HW_BREAKPOINT_W:
+		tdata1 |= DBTR_TDATA1_MCONTROL_STORE;
+		break;
+	case HW_BREAKPOINT_RW:
+		tdata1 |= DBTR_TDATA1_MCONTROL_STORE | DBTR_TDATA1_MCONTROL_LOAD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		hw->len = 1;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
+				     DBTR_TDATA1_MCONTROL_SIZELO_8BIT);
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		hw->len = 2;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
+				     DBTR_TDATA1_MCONTROL_SIZELO_16BIT);
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		hw->len = 4;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
+				     DBTR_TDATA1_MCONTROL_SIZELO_32BIT);
+		break;
+#if __riscv_xlen >= 64
+	case HW_BREAKPOINT_LEN_8:
+		hw->len = 8;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
+				     DBTR_TDATA1_MCONTROL_SIZELO_64BIT) |
+			  FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZEHI_FIELD,
+				     DBTR_TDATA1_MCONTROL_SIZEHI_64BIT);
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	tdata1 |= DBTR_TDATA1_MCONTROL_U;
+
+	hw->tdata1 = tdata1;
+
+	return 0;
+}
+
+static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
+				     struct arch_hw_breakpoint *hw)
+{
+	unsigned long tdata1 = DBTR_TDATA1_TYPE_MCONTROL;
+
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		tdata1 |= DBTR_TDATA1_MCONTROL6_EXECUTE;
+		break;
+	case HW_BREAKPOINT_R:
+		tdata1 |= DBTR_TDATA1_MCONTROL6_LOAD;
+		break;
+	case HW_BREAKPOINT_W:
+		tdata1 |= DBTR_TDATA1_MCONTROL6_STORE;
+		break;
+	case HW_BREAKPOINT_RW:
+		tdata1 |= DBTR_TDATA1_MCONTROL6_STORE | DBTR_TDATA1_MCONTROL6_LOAD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		hw->len = 1;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
+				     DBTR_TDATA1_MCONTROL6_SIZE_8BIT);
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		hw->len = 2;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
+				     DBTR_TDATA1_MCONTROL6_SIZE_16BIT);
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		hw->len = 4;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
+				     DBTR_TDATA1_MCONTROL6_SIZE_32BIT);
+		break;
+	case HW_BREAKPOINT_LEN_8:
+		hw->len = 8;
+		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
+				     DBTR_TDATA1_MCONTROL6_SIZE_64BIT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tdata1 |= DBTR_TDATA1_MCONTROL6_U;
+
+	hw->tdata1 = tdata1;
+
+	return 0;
+}
+
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
+{
+	int ret;
+
+	/* Breakpoint address */
+	hw->address = attr->bp_addr;
+	hw->tdata2 = attr->bp_addr;
+	hw->tdata3 = 0x0;
+	hw->next_addr = 0x0;
+	hw->in_callback = false;
+
+	switch (dbtr_type) {
+	case DBTR_TDATA1_TYPE_MCONTROL:
+		ret = rv_init_mcontrol_trigger(attr, hw);
+		break;
+	case DBTR_TDATA1_TYPE_MCONTROL6:
+		ret = rv_init_mcontrol6_trigger(attr, hw);
+		break;
+	default:
+		pr_warn("Unsupported trigger type %lu.\n", dbtr_type >> DBTR_TDATA1_TYPE_SHIFT);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Set breakpoint to next insruction after breakpoint.
+ * Returns 0 if success
+ * Returns < 0 on error
+ */
+static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	struct arch_hw_breakpoint old_hw_bp;
+	struct perf_event_attr bp_insn;
+	unsigned long next_addr, insn;
+	int ret;
+
+	/* Remove breakpoint even if return error as not to loop */
+	arch_uninstall_hw_breakpoint(event);
+
+	ret = get_insn(regs, regs->epc, &insn);
+	if (ret < 0)
+		return ret;
+
+	next_addr = get_step_address(regs, insn);
+
+	ret = get_insn(regs, next_addr, &insn);
+	if (ret < 0)
+		return ret;
+
+	bp_insn.bp_type = HW_BREAKPOINT_X;
+	bp_insn.bp_addr = next_addr;
+	/* Get the size of the intruction */
+	bp_insn.bp_len = GET_INSN_LENGTH(insn);
+
+	ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
+	if (ret)
+		return ret;
+
+	ret = arch_install_hw_breakpoint(event);
+	if (ret)
+		return ret;
+
+	bp->in_callback = true;
+	bp->next_addr = next_addr;
+	return 0;
+}
+
+/*
+ * HW Breakpoint/watchpoint handler
+ */
+static int hw_breakpoint_handler(struct pt_regs *regs)
+{
+	struct perf_event *event;
+	struct arch_hw_breakpoint *bp;
+	int ret, i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		event = this_cpu_read(pcpu_hw_bp_events[i]);
+		if (!event)
+			continue;
+
+		bp = counter_arch_bp(event);
+		if (bp->in_callback) {
+			/* Reset changed breakpoint data */
+			bp->in_callback = false;
+			if (regs->epc == bp->next_addr) {
+				arch_uninstall_hw_breakpoint(event);
+				/* Restore original breakpoint */
+				if (hw_breakpoint_arch_parse(NULL, &event->attr, bp))
+					return NOTIFY_DONE;
+				if (arch_install_hw_breakpoint(event))
+					return NOTIFY_DONE;
+				return NOTIFY_STOP;
+			}
+
+			pr_err("%s: in_callback was set, but epc(%lx) was not next "
+				 "address(%lx).\n", __func__, regs->epc, bp->next_addr);
+			bp->next_addr = 0x0;
+			return NOTIFY_DONE;
+		}
+
+		switch (event->attr.bp_type) {
+		/* Breakpoint */
+		case HW_BREAKPOINT_X:
+			if (event->attr.bp_addr == regs->epc) {
+				ret = setup_singlestep(event, regs);
+				if (ret < 0) {
+					pr_err("%s: setup_singlestep failed %d.\n", __func__, ret);
+					return NOTIFY_DONE;
+				}
+
+				perf_bp_event(event, regs);
+				return NOTIFY_STOP;
+			}
+			break;
+
+		/* Watchpoint */
+		case HW_BREAKPOINT_W:
+		case HW_BREAKPOINT_R:
+		case HW_BREAKPOINT_RW:
+			if (event->attr.bp_addr == regs->badaddr) {
+				ret = setup_singlestep(event, regs);
+				if (ret < 0) {
+					pr_err("%s: setup_singlestep failed %d.\n", __func__, ret);
+					return NOTIFY_DONE;
+				}
+
+				perf_bp_event(event, regs);
+				return NOTIFY_STOP;
+			}
+			break;
+
+		default:
+			pr_warn("%s: Unknown type: %u\n", __func__, event->attr.bp_type);
+			break;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data)
+{
+	struct die_args *args = data;
+
+	if (val != DIE_DEBUG)
+		return NOTIFY_DONE;
+
+	return hw_breakpoint_handler(args->regs);
+}
+
+/* atomic: counter->ctx->lock is held */
+int arch_install_hw_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(&sbi_dbtr_shmem);
+	struct sbi_dbtr_data_msg *xmit;
+	struct sbi_dbtr_id_msg *recv;
+	struct perf_event **slot;
+	unsigned long idx;
+	struct sbiret ret;
+	int err = 0;
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
+			      *this_cpu_ptr(&ecall_lock_flags));
+
+	xmit = &shmem->data;
+	recv = &shmem->id;
+	xmit->tdata1 = cpu_to_le(bp->tdata1);
+	xmit->tdata2 = cpu_to_le(bp->tdata2);
+	xmit->tdata3 = cpu_to_le(bp->tdata3);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
+			1, 0, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: failed to install trigger. error: %ld\n", __func__, ret.error);
+		err = sbi_err_map_linux_errno(ret.error);
+		goto done;
+	}
+
+	idx = le_to_cpu(recv->idx);
+	if (idx >= dbtr_total_num) {
+		pr_warn("%s: invalid trigger index %lu\n", __func__, idx);
+		err = -EINVAL;
+		goto done;
+	}
+
+	slot = this_cpu_ptr(&pcpu_hw_bp_events[idx]);
+	if (*slot) {
+		pr_warn("%s: slot %lu is in use\n", __func__, idx);
+		err = -EBUSY;
+		goto done;
+	}
+
+	pr_debug("Trigger 0x%lx installed at index 0x%lx\n", bp->tdata2, idx);
+
+	/* Save the event - to be looked up in handler */
+	*slot = event;
+
+done:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
+				   *this_cpu_ptr(&ecall_lock_flags));
+	return err;
+}
+
+/* atomic: counter->ctx->lock is held */
+void arch_uninstall_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event) {
+			*slot = NULL;
+			break;
+		}
+	}
+
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error)
+		pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n", __func__, i, ret.error);
+}
+
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
+
+void hw_breakpoint_pmu_read(struct perf_event *bp) { }
+
+static int __init arch_hw_breakpoint_init(void)
+{
+	unsigned int cpu;
+	int rc = 0;
+
+	for_each_possible_cpu(cpu)
+		raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
+
+	init_sbi_dbtr();
+
+	if (dbtr_total_num) {
+		pr_debug("%s: total number of type %lu triggers: %u\n",
+			__func__, dbtr_type >> DBTR_TDATA1_TYPE_SHIFT, dbtr_total_num);
+	} else {
+		pr_debug("%s: No hardware triggers available\n", __func__);
+		return rc;
+	}
+
+	/* Hotplug handler to register/unregister shared memory with SBI */
+	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			       "riscv/hw_breakpoint:prepare",
+			       arch_smp_setup_sbi_shmem,
+			       arch_smp_teardown_sbi_shmem);
+
+	if (rc < 0)
+		pr_warn("%s: Failed to setup CPU hotplug state\n", __func__);
+
+	return rc;
+}
+arch_initcall(arch_hw_breakpoint_init);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 938a8b841f94..2ac471ec79a8 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -289,6 +289,12 @@ void handle_break(struct pt_regs *regs)
 	if (probe_breakpoint_handler(regs))
 		return;
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
+	    == NOTIFY_STOP)
+		return;
+#endif
+
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
-- 
2.43.0


