Return-Path: <linux-kernel+bounces-852716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B4BD9B78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184DA19A3011
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA802F066A;
	Tue, 14 Oct 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="izrSlSsW"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058E314B60
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448088; cv=none; b=XRB524kgU3+uizkMRLHjNeb7e35u8IDQxhY+R7B6BcBhQ6mutZvSAajHOEU4HiKa7bgYXPNq48s02GIrCM2BJuDhtKaLQv/mNtHDqFuA/QzzaKeKcfMsTG2eIna0chnvP37D873miLxJH4Jki5kRIxrRIHcLX7lh8YgvjKSxCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448088; c=relaxed/simple;
	bh=Z6uGbZKLqe/suWFUUAGV3RlRoWpNc6LcJp7UiQ0KLCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjioJItU+8gNWxzHse6KqgZFzqY1HxX/Ptjafm7K1y1bFhODsCoe+m0cFYzf5hY+HA01AEUT+5MPUHYFTx28kln77GKvA8O05BT0tx2tXM1CE4S78pWnW2UrHx9+u+BfSNjeKArOGV2Q0hNoDYIP/ATCM6Qi6TtQTrrtd8q65Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=izrSlSsW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-273a0aeed57so78243725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760448085; x=1761052885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DksyJIp4tcKqureXkHFAt6jH/Gz5hXdtIRAW/xwjAb8=;
        b=izrSlSsWe5bLeaCGXA/mv6SOdwHfbFR7RRPD2CYMTBZGxZvDzTk1MRuPM/kiMb2483
         gGpGFmzjV6Zc4mYcHpd8WfKMuEAipf+z8uE8RdNCTwmDE8sIZsLIIhDS7BiA+jpBfTJQ
         IVPmsTD052th56tLCddN56zUCyuflQieN3l6n0Z8dg4NAbneKu9ER/vM5kDMlBFjbH2y
         2VWbqkSnLlRnLS5nwtgi4+qGnzZTmQY3jQ/pNlM8o0tyIVjwEQbN6kDFk8561/mYdk76
         5Ay/mszySojygUWLSPxFMwFMKpyBz1GH9lezDDXyWCNf5btZP6MZxSdFcSVDAVLxTLbF
         W8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448085; x=1761052885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DksyJIp4tcKqureXkHFAt6jH/Gz5hXdtIRAW/xwjAb8=;
        b=e19vnkr5A9hPIgSefRgmYWrF+Qp/pjCHm9eNqT9Gn6JvZ0hrqPC8xYzTbRB6XxgTPD
         p/Z8hQU+Zkr5xIz+xGOeIBqSBPDTQJkjPbq+tof6dhc2KOfUasFKOfwGcro1RRNxrHFP
         HROANuwT1EJYTqzDjt9cQTs1rMyrbxmALRBTi9b3FOqZucl3yasFulPUahp1jsjq2T24
         YV5FUx1/2K8Sc4eIGBcLVkZPGh8OYMbdKqCHQFkl6JNQrbWHHp+oa12wQ2pE3iTpUMWf
         QsC+1Y03EKw6wzyZArrsD1EsbYdpDw38nQvrHbrj9Ox5E9y8oak+IySaVVGQpFlnsKUj
         H91A==
X-Forwarded-Encrypted: i=1; AJvYcCVdfoVXIb1cyTXGglneibSkxE+R5Kb0/ugHIySKmj9HntLAsnBeP3L7rmDiCP9KZJQbGw+VLeg0qp+DXrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3jwx89f1NgAm9v6bcUJumJOYVh+Rcjh3YV25DryewvIYp62L
	bUVmw+oMD3MCHx5WOvCOxytJf9N7E1eZAGaNUJM7EptTSDJDt6ZxEWHuD0T4sil7lOg=
X-Gm-Gg: ASbGncu13e1pnCVj7RNI+UbzovqXyfcw27QzfJqSI778W2FKyMPEhwL8Qajwuf3+Tas
	29DKJ6nJkihU6u8ZYwW6xhwb7ujPLHBzqoCDvF57pPTgRrTHKypPukKt4W5OSNnqrSK1Xq/xQUP
	RMFFbYy5afATrxJZptn+D4Q33VpSF4lXXBR6rIdS7K5oi89wz+YkbFM9c8QX8EdwwfdruneEJ+/
	aUKksuzxEERUmVoOPfCt26UrFPsjIxpyj4IpO08JyL8GXqYXHZ1xeV3aiYeG9fra5vAINSFSS2h
	y5lGEfIAdRdOnN/XpWxxvR4SAiw/gtnG9siz2OYkeX1B27HtaiaCaSQIjo2FSha3Y07Yp74mQtv
	o5dItf2wBEJlauMGB6+fi9KFQYUFnzKVNvxJGKtyFx8JBVzXaxJRtpidIxb5ja3fjieksDuQf
X-Google-Smtp-Source: AGHT+IGwebx1boYxEpf6P+mBpk5aFk0EQxxdDY6lc4FvX5l2uj1RjCC5fi/lwymPmxge/NGIBj3n0Q==
X-Received: by 2002:a17:902:e952:b0:26c:4085:e3ef with SMTP id d9443c01a7336-29027f234aemr274358875ad.21.1760448084765;
        Tue, 14 Oct 2025 06:21:24 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6f08sm164387635ad.26.2025.10.14.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:21:24 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v3 1/1] RISC-V: Add common csr_read_num() and csr_write_num() functions
Date: Tue, 14 Oct 2025 18:51:06 +0530
Message-ID: <20251014132106.181155-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014132106.181155-1-apatel@ventanamicro.com>
References: <20251014132106.181155-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RISC-V, there is no CSR read/write instruction which takes CSR
number via register so add common csr_read_num() and csr_write_num()
functions which allow accessing certain CSRs by passing CSR number
as parameter. These common functions will be first used by the
ACPI CPPC driver and RISC-V PMU driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 184 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..46e1fcd82fd0 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -575,6 +575,9 @@
 			      : "memory");			\
 })
 
+extern unsigned long csr_read_num(unsigned long csr_num, int *out_err);
+extern void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_RISCV_CSR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f60fce69b725..a75e79192531 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y	+= soc.o
 obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
+obj-y	+= csr.o
 obj-y	+= entry.o
 obj-y	+= irq.o
 obj-y	+= process.o
diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
new file mode 100644
index 000000000000..e96b129c1a99
--- /dev/null
+++ b/arch/riscv/kernel/csr.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <asm/csr.h>
+
+#define CSR_CUSTOM0_U_RW_BASE		0x800
+#define CSR_CUSTOM0_U_RW_COUNT		0x100
+
+#define CSR_CUSTOM1_U_RO_BASE		0xCC0
+#define CSR_CUSTOM1_U_RO_COUNT		0x040
+
+#define CSR_CUSTOM2_S_RW_BASE		0x5C0
+#define CSR_CUSTOM2_S_RW_COUNT		0x040
+
+#define CSR_CUSTOM3_S_RW_BASE		0x9C0
+#define CSR_CUSTOM3_S_RW_COUNT		0x040
+
+#define CSR_CUSTOM4_S_RO_BASE		0xDC0
+#define CSR_CUSTOM4_S_RO_COUNT		0x040
+
+#define CSR_CUSTOM5_HS_RW_BASE		0x6C0
+#define CSR_CUSTOM5_HS_RW_COUNT		0x040
+
+#define CSR_CUSTOM6_HS_RW_BASE		0xAC0
+#define CSR_CUSTOM6_HS_RW_COUNT		0x040
+
+#define CSR_CUSTOM7_HS_RO_BASE		0xEC0
+#define CSR_CUSTOM7_HS_RO_COUNT		0x040
+
+#define CSR_CUSTOM8_M_RW_BASE		0x7C0
+#define CSR_CUSTOM8_M_RW_COUNT		0x040
+
+#define CSR_CUSTOM9_M_RW_BASE		0xBC0
+#define CSR_CUSTOM9_M_RW_COUNT		0x040
+
+#define CSR_CUSTOM10_M_RO_BASE		0xFC0
+#define CSR_CUSTOM10_M_RO_COUNT		0x040
+
+unsigned long csr_read_num(unsigned long csr_num, int *out_err)
+{
+#define switchcase_csr_read(__csr_num)				\
+	case (__csr_num):					\
+		return csr_read(__csr_num)
+#define switchcase_csr_read_2(__csr_num)			\
+	switchcase_csr_read(__csr_num + 0);			\
+	switchcase_csr_read(__csr_num + 1)
+#define switchcase_csr_read_4(__csr_num)			\
+	switchcase_csr_read_2(__csr_num + 0);			\
+	switchcase_csr_read_2(__csr_num + 2)
+#define switchcase_csr_read_8(__csr_num)			\
+	switchcase_csr_read_4(__csr_num + 0);			\
+	switchcase_csr_read_4(__csr_num + 4)
+#define switchcase_csr_read_16(__csr_num)			\
+	switchcase_csr_read_8(__csr_num + 0);			\
+	switchcase_csr_read_8(__csr_num + 8)
+#define switchcase_csr_read_32(__csr_num)			\
+	switchcase_csr_read_16(__csr_num + 0);			\
+	switchcase_csr_read_16(__csr_num + 16)
+#define switchcase_csr_read_64(__csr_num)			\
+	switchcase_csr_read_32(__csr_num + 0);			\
+	switchcase_csr_read_32(__csr_num + 32)
+#define switchcase_csr_read_128(__csr_num)			\
+	switchcase_csr_read_64(__csr_num + 0);			\
+	switchcase_csr_read_64(__csr_num + 64)
+#define switchcase_csr_read_256(__csr_num)			\
+	switchcase_csr_read_128(__csr_num + 0);			\
+	switchcase_csr_read_128(__csr_num + 128)
+
+	*out_err = 0;
+	switch (csr_num) {
+	switchcase_csr_read_32(CSR_CYCLE);
+	switchcase_csr_read_32(CSR_CYCLEH);
+	switchcase_csr_read_256(CSR_CUSTOM0_U_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM1_U_RO_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM2_S_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM3_S_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM4_S_RO_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM5_HS_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM6_HS_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM7_HS_RO_BASE);
+#ifdef CONFIG_RISCV_M_MODE
+	switchcase_csr_read_64(CSR_CUSTOM8_M_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM9_M_RW_BASE);
+	switchcase_csr_read_64(CSR_CUSTOM10_M_RO_BASE);
+#endif
+	default:
+		*out_err = -EINVAL;
+		break;
+	}
+
+	return 0;
+#undef switchcase_csr_read_256
+#undef switchcase_csr_read_128
+#undef switchcase_csr_read_64
+#undef switchcase_csr_read_32
+#undef switchcase_csr_read_16
+#undef switchcase_csr_read_8
+#undef switchcase_csr_read_4
+#undef switchcase_csr_read_2
+#undef switchcase_csr_read
+}
+EXPORT_SYMBOL_GPL(csr_read_num);
+
+void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err)
+{
+#define switchcase_csr_write(__csr_num, __val)			\
+	case (__csr_num):					\
+		csr_write(__csr_num, __val);			\
+		break
+#define switchcase_csr_write_2(__csr_num, __val)		\
+	switchcase_csr_write(__csr_num + 0, __val);		\
+	switchcase_csr_write(__csr_num + 1, __val)
+#define switchcase_csr_write_4(__csr_num, __val)		\
+	switchcase_csr_write_2(__csr_num + 0, __val);		\
+	switchcase_csr_write_2(__csr_num + 2, __val)
+#define switchcase_csr_write_8(__csr_num, __val)		\
+	switchcase_csr_write_4(__csr_num + 0, __val);		\
+	switchcase_csr_write_4(__csr_num + 4, __val)
+#define switchcase_csr_write_16(__csr_num, __val)		\
+	switchcase_csr_write_8(__csr_num + 0, __val);		\
+	switchcase_csr_write_8(__csr_num + 8, __val)
+#define switchcase_csr_write_32(__csr_num, __val)		\
+	switchcase_csr_write_16(__csr_num + 0, __val);		\
+	switchcase_csr_write_16(__csr_num + 16, __val)
+#define switchcase_csr_write_64(__csr_num, __val)		\
+	switchcase_csr_write_32(__csr_num + 0, __val);		\
+	switchcase_csr_write_32(__csr_num + 32, __val)
+#define switchcase_csr_write_128(__csr_num, __val)		\
+	switchcase_csr_write_64(__csr_num + 0, __val);		\
+	switchcase_csr_write_64(__csr_num + 64, __val)
+#define switchcase_csr_write_256(__csr_num, __val)		\
+	switchcase_csr_write_128(__csr_num + 0, __val);		\
+	switchcase_csr_write_128(__csr_num + 128, __val)
+
+	*out_err = 0;
+	switch (csr_num) {
+	switchcase_csr_write_256(CSR_CUSTOM0_U_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM2_S_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM3_S_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM5_HS_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM6_HS_RW_BASE, val);
+#ifdef CONFIG_RISCV_M_MODE
+	switchcase_csr_write_64(CSR_CUSTOM8_M_RW_BASE, val);
+	switchcase_csr_write_64(CSR_CUSTOM9_M_RW_BASE, val);
+#endif
+	default:
+		*out_err = -EINVAL;
+		break;
+	}
+#undef switchcase_csr_write_256
+#undef switchcase_csr_write_128
+#undef switchcase_csr_write_64
+#undef switchcase_csr_write_32
+#undef switchcase_csr_write_16
+#undef switchcase_csr_write_8
+#undef switchcase_csr_write_4
+#undef switchcase_csr_write_2
+#undef switchcase_csr_write
+}
+EXPORT_SYMBOL_GPL(csr_write_num);
diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 42c1a9052470..fe491937ed25 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
 static void cppc_ffh_csr_read(void *read_data)
 {
 	struct sbi_cppc_data *data = (struct sbi_cppc_data *)read_data;
+	int err;
 
-	switch (data->reg) {
-	/* Support only TIME CSR for now */
-	case CSR_TIME:
-		data->ret.value = csr_read(CSR_TIME);
-		data->ret.error = 0;
-		break;
-	default:
-		data->ret.error = -EINVAL;
-		break;
-	}
+	data->ret.value = csr_read_num(data->reg, &err);
+	data->ret.error = err;
 }
 
 static void cppc_ffh_csr_write(void *write_data)
 {
 	struct sbi_cppc_data *data = (struct sbi_cppc_data *)write_data;
+	int err;
 
-	data->ret.error = -EINVAL;
+	csr_write_num(data->reg, data->val, &err);
+	data->ret.error = err;
 }
 
 /*
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 7644147d50b4..b41f353ba964 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -16,6 +16,7 @@
 #include <linux/smp.h>
 #include <linux/sched_clock.h>
 
+#include <asm/csr.h>
 #include <asm/sbi.h>
 
 static bool riscv_perf_user_access(struct perf_event *event)
@@ -88,58 +89,21 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_short = 1;
 }
 
-static unsigned long csr_read_num(int csr_num)
-{
-#define switchcase_csr_read(__csr_num, __val)		{\
-	case __csr_num:					\
-		__val = csr_read(__csr_num);		\
-		break; }
-#define switchcase_csr_read_2(__csr_num, __val)		{\
-	switchcase_csr_read(__csr_num + 0, __val)	 \
-	switchcase_csr_read(__csr_num + 1, __val)}
-#define switchcase_csr_read_4(__csr_num, __val)		{\
-	switchcase_csr_read_2(__csr_num + 0, __val)	 \
-	switchcase_csr_read_2(__csr_num + 2, __val)}
-#define switchcase_csr_read_8(__csr_num, __val)		{\
-	switchcase_csr_read_4(__csr_num + 0, __val)	 \
-	switchcase_csr_read_4(__csr_num + 4, __val)}
-#define switchcase_csr_read_16(__csr_num, __val)	{\
-	switchcase_csr_read_8(__csr_num + 0, __val)	 \
-	switchcase_csr_read_8(__csr_num + 8, __val)}
-#define switchcase_csr_read_32(__csr_num, __val)	{\
-	switchcase_csr_read_16(__csr_num + 0, __val)	 \
-	switchcase_csr_read_16(__csr_num + 16, __val)}
-
-	unsigned long ret = 0;
-
-	switch (csr_num) {
-	switchcase_csr_read_32(CSR_CYCLE, ret)
-	switchcase_csr_read_32(CSR_CYCLEH, ret)
-	default :
-		break;
-	}
-
-	return ret;
-#undef switchcase_csr_read_32
-#undef switchcase_csr_read_16
-#undef switchcase_csr_read_8
-#undef switchcase_csr_read_4
-#undef switchcase_csr_read_2
-#undef switchcase_csr_read
-}
-
 /*
  * Read the CSR of a corresponding counter.
  */
 unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
 {
-	if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
-	   (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
-		pr_err("Invalid performance counter csr %lx\n", csr);
-		return -EINVAL;
+	unsigned long val;
+	int rc;
+
+	val = csr_read_num(csr, &rc);
+	if (rc) {
+		pr_err("Failed to read performance counter csr %lx (error %d)\n", csr, rc);
+		return rc;
 	}
 
-	return csr_read_num(csr);
+	return val;
 }
 
 u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
-- 
2.43.0


