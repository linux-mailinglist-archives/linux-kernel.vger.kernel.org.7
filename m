Return-Path: <linux-kernel+bounces-847694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A8BCB6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C6219E86B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC823E23C;
	Fri, 10 Oct 2025 02:29:04 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03589239581;
	Fri, 10 Oct 2025 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063342; cv=none; b=tzmW0QR5rxA50ceRty/l9JyNfDPa10wtwuJlysV1z5Meh8RqhmwRm7KGwHTk8kehZh7VyZp+TYkQgdAiIf9LfA4GjXwzkwnjt8r9tVzAZmP0g0t1TECrSZDs2SbM121M3k1Qna4COx45ERNxInf49tNkmcezEiOWnYjFXxKPkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063342; c=relaxed/simple;
	bh=TgT8HQzo8rED8HunfJRnPiJqYVLhhiYLq7E51OFfJGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJdqbkU42pvTO12/vffU9HK9UnwQ302oORLxC9z4onx95oJvQMUns8M5tpZS+m/vw9XNGavLQqFxBNK2nJ2qc7UYY9/f0noaciFThbKgYiFOyrM28FXTAhPjszMoxbvdaekwIzj9IDJTtLyRyrpYRQBF7ORl6ySqiT3zlZXvBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.57.136])
	by gateway (Coremail) with SMTP id _____8CxJ9Fjb+hoSYYUAA--.43614S3;
	Fri, 10 Oct 2025 10:28:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.57.136])
	by front1 (Coremail) with SMTP id qMiowJDxQ+Rfb+hoHsHXAA--.20307S4;
	Fri, 10 Oct 2025 10:28:50 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	corbet@lwn.net,
	alexs@kernel.org,
	si.yanteng@linux.dev,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	peterz@infradead.org,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	maobibo@loongson.cn,
	siyanteng@cqsoftware.com.cn,
	gaosong@loongson.cn,
	yangtiezhu@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH v5 2/2] irqchip/irq-loongarch-ir:Add Redirect irqchip support
Date: Fri, 10 Oct 2025 10:28:41 +0800
Message-ID: <20251010022845.140234-3-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20251010022845.140234-1-zhangtianyang@loongson.cn>
References: <20251010022845.140234-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+Rfb+hoHsHXAA--.20307S4
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfWr1xWFW3Aw1DWw4ruryrKrX_yoW8trW7to
	WfJFs3G34rWr18CrWFkw47tFyxZ3yrGw4Fy34fuFs7Z3ZFvrWrKrW7G3yavFy2gF10qFnr
	AayIqrn8Jayxtrn3l-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUZVWUtwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbRVbDUUUUU==

The main function of the Redirected interrupt controller is to manage
the redirected-interrupt table, which consists of many redirected entries.
When MSI interrupts are requested, the driver creates a corresponding
redirected entry that describes the target CPU/vector number and the
operating mode of the interrupt. The redirected interrupt module has an
independent cache, and during the interrupt routing process, it will
prioritize the redirected entries that hit the cache. The driver
invalidates certain entry caches via a command queue.

Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/include/asm/cpu-features.h |   1 +
 arch/loongarch/include/asm/cpu.h          |   2 +
 arch/loongarch/include/asm/loongarch.h    |   6 +
 arch/loongarch/kernel/cpu-probe.c         |   2 +
 drivers/irqchip/Makefile                  |   2 +-
 drivers/irqchip/irq-loongarch-avec.c      |  20 +-
 drivers/irqchip/irq-loongarch-ir.c        | 527 ++++++++++++++++++++++
 drivers/irqchip/irq-loongson.h            |  19 +
 8 files changed, 565 insertions(+), 14 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-ir.c

diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index fc83bb32f9f0..03f7e93e81e0 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -68,5 +68,6 @@
 #define cpu_has_ptw		cpu_opt(LOONGARCH_CPU_PTW)
 #define cpu_has_lspw		cpu_opt(LOONGARCH_CPU_LSPW)
 #define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
+#define cpu_has_redirectint	cpu_opt(LOONGARCH_CPU_REDIRECTINT)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index dfb982fe8701..27b9cfbfbaa8 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -102,6 +102,7 @@ enum cpu_type_enum {
 #define CPU_FEATURE_PTW			27	/* CPU has hardware page table walker */
 #define CPU_FEATURE_LSPW		28	/* CPU has LSPW (lddir/ldpte instructions) */
 #define CPU_FEATURE_AVECINT		29	/* CPU has AVEC interrupt */
+#define CPU_FEATURE_REDIRECTINT		30      /* CPU has interrupt remmap */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -133,5 +134,6 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
 #define LOONGARCH_CPU_LSPW		BIT_ULL(CPU_FEATURE_LSPW)
 #define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
+#define LOONGARCH_CPU_REDIRECTINT	BIT_ULL(CPU_FEATURE_REDIRECTINT)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 09dfd7eb406e..2cb4b407fbff 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1137,6 +1137,7 @@
 #define  IOCSRF_FLATMODE		BIT_ULL(10)
 #define  IOCSRF_VM			BIT_ULL(11)
 #define  IOCSRF_AVEC			BIT_ULL(15)
+#define  IOCSRF_REDIRECTINT		BIT_ULL(16)
 
 #define LOONGARCH_IOCSR_VENDOR		0x10
 
@@ -1196,6 +1197,11 @@
 
 #define LOONGARCH_IOCSR_EXTIOI_NODEMAP_BASE	0x14a0
 #define LOONGARCH_IOCSR_EXTIOI_IPMAP_BASE	0x14c0
+#define LOONGARCH_IOCSR_REDIRECT_CFG		0x15e0
+#define LOONGARCH_IOCSR_REDIRECT_TBR		0x15e8  /* IRT BASE REG*/
+#define LOONGARCH_IOCSR_REDIRECT_CQB		0x15f0  /* IRT CACHE QUEUE BASE */
+#define LOONGARCH_IOCSR_REDIRECT_CQH		0x15f8  /* IRT CACHE QUEUE HEAD, 32bit */
+#define LOONGARCH_IOCSR_REDIRECT_CQT		0x15fc  /* IRT CACHE QUEUE TAIL, 32bit */
 #define LOONGARCH_IOCSR_EXTIOI_EN_BASE		0x1600
 #define LOONGARCH_IOCSR_EXTIOI_BOUNCE_BASE	0x1680
 #define LOONGARCH_IOCSR_EXTIOI_ISR_BASE		0x1800
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index fedaa67cde41..543474fd1399 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -289,6 +289,8 @@ static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int
 		c->options |= LOONGARCH_CPU_EIODECODE;
 	if (config & IOCSRF_AVEC)
 		c->options |= LOONGARCH_CPU_AVECINT;
+	if (config & IOCSRF_REDIRECTINT)
+		c->options |= LOONGARCH_CPU_REDIRECTINT;
 	if (config & IOCSRF_VM)
 		c->options |= LOONGARCH_CPU_HYPERVISOR;
 }
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 93e3ced023bb..a0be18891890 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -118,7 +118,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
-obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-avec.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-avec.o irq-loongarch-ir.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
index bf52dc8345f5..de7b6059c1b6 100644
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -24,7 +24,6 @@
 #define VECTORS_PER_REG		64
 #define IRR_VECTOR_MASK		0xffUL
 #define IRR_INVALID_MASK	0x80000000UL
-#define AVEC_MSG_OFFSET		0x100000
 
 #ifdef CONFIG_SMP
 struct pending_list {
@@ -47,15 +46,6 @@ struct avecintc_chip {
 
 static struct avecintc_chip loongarch_avec;
 
-struct avecintc_data {
-	struct list_head	entry;
-	unsigned int		cpu;
-	unsigned int		vec;
-	unsigned int		prev_cpu;
-	unsigned int		prev_vec;
-	unsigned int		moving;
-};
-
 static inline void avecintc_enable(void)
 {
 	u64 value;
@@ -85,7 +75,7 @@ static inline void pending_list_init(int cpu)
 	INIT_LIST_HEAD(&plist->head);
 }
 
-static void avecintc_sync(struct avecintc_data *adata)
+void avecintc_sync(struct avecintc_data *adata)
 {
 	struct pending_list *plist;
 
@@ -109,7 +99,7 @@ static int avecintc_set_affinity(struct irq_data *data, const struct cpumask *de
 			return -EBUSY;
 
 		if (cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest))
-			return 0;
+			return IRQ_SET_MASK_OK_DONE;
 
 		cpumask_and(&intersect_mask, dest, cpu_online_mask);
 
@@ -121,7 +111,8 @@ static int avecintc_set_affinity(struct irq_data *data, const struct cpumask *de
 		adata->cpu = cpu;
 		adata->vec = vector;
 		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(data);
-		avecintc_sync(adata);
+		if (!cpu_has_redirectint)
+			avecintc_sync(adata);
 	}
 
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
@@ -412,6 +403,9 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 
 static inline int __init acpi_cascade_irqdomain_init(void)
 {
+	if (cpu_has_redirectint)
+		return redirect_acpi_init(loongarch_avec.domain);
+
 	return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
 }
 
diff --git a/drivers/irqchip/irq-loongarch-ir.c b/drivers/irqchip/irq-loongarch-ir.c
new file mode 100644
index 000000000000..82f28d4f1c8b
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-ir.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Loongson Technologies, Inc.
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/irq-msi-lib.h>
+#include <linux/irqdomain.h>
+#include <linux/spinlock.h>
+#include <linux/msi.h>
+
+#include <asm/irq.h>
+#include <asm/loongarch.h>
+#include <asm/loongson.h>
+#include <asm/numa.h>
+#include <asm/setup.h>
+#include <larchintrin.h>
+
+#include "irq-loongson.h"
+
+#define IRD_ENTRY_SIZE			16
+#define IRD_ENTRIES			65536
+#define IRD_TABLE_PAGE_ORDER		get_order(IRD_ENTRIES * IRD_ENTRY_SIZE)
+
+#define INVALID_QUEUE_SIZE		4096
+#define INV_QUEUE_PAGE_ORDER		get_order(INVALID_QUEUE_SIZE * IRD_ENTRY_SIZE)
+
+#define GPID_ADDR_MASK			GENMASK(47, 6)
+#define GPID_ADDR_SHIFT 		6
+
+#define CQB_SIZE_MASK			0xf
+#define CQB_ADDR_MASK			GENMASK(47, 12)
+
+#define CFG_DISABLE_IDLE		2
+#define INVALID_INDEX			0
+
+#define MAX_IR_ENGINES			16
+
+struct redirect_entry {
+	struct  {
+		u64	valid	: 1,
+			res1	: 5,
+			gpid	: 42,
+			res2	: 8,
+			vector	: 8;
+	}	lo;
+	u64	hi;
+};
+
+struct redirect_gpid {
+	u64	pir[4];      // Pending interrupt requested
+	u8	en	: 1, // doorbell
+		res0	: 7;
+	u8	irqnum;
+	u16	res1;
+	u32	dst;
+	u32	rsvd[6];
+};
+
+struct irde_inv_cmd {
+	union {
+		u64	cmd_info;
+		struct {
+			u64	res1		: 4,
+				type		: 1,
+				need_notice	: 1,
+				pad		: 2,
+				index		: 16,
+				pad2		: 40;
+		}	index;
+	};
+	u64		notice_addr;
+};
+
+struct redirect_table {
+	struct redirect_entry	*table;
+	unsigned long		*bitmap;
+	raw_spinlock_t		lock;
+};
+
+struct redirect_queue {
+	struct irde_inv_cmd	*cmd_base;
+	int			head;
+	int			tail;
+	raw_spinlock_t		lock;
+};
+
+struct irde_desc {
+	struct	redirect_table	ird_table;
+	struct	redirect_queue	inv_queue;
+	int			node;
+};
+
+struct redirect_item {
+	int			index;
+	struct irde_desc	*irde;
+	struct redirect_gpid	*gpid;
+};
+
+
+static struct irq_domain *redirect_domain;
+static struct irde_desc irde_descs[MAX_IR_ENGINES];
+static phys_addr_t msi_base_addr;
+static phys_addr_t redirect_reg_base = LOONGSON_REG_BASE;
+
+#define REDIRECT_REG(reg, node) \
+	((void *)(IO_BASE | redirect_reg_base | (u64)(node) << NODE_ADDRSPACE_SHIFT | (reg)))
+
+static inline void redirect_write_reg64(u32 node, u64 val, u32 reg)
+{
+	void __iomem *reg_addr = REDIRECT_REG(reg, node);
+
+	return writeq(val, reg_addr);
+}
+
+static inline void redirect_write_reg32(int node, u32 val, u32 reg)
+{
+	void __iomem *reg_addr = REDIRECT_REG(reg, node);
+
+	return writel(val, reg_addr);
+}
+
+static inline u32 redirect_read_reg32(int node, int reg)
+{
+	void __iomem *reg_addr = REDIRECT_REG(reg, node);
+
+	return readl(reg_addr);
+}
+
+static inline struct redirect_entry *item_get_entry(struct redirect_item *item)
+{
+	return item->irde->ird_table.table + item->index;
+}
+
+static inline bool invalid_queue_is_full(int node, u32 *tail)
+{
+	u32 head = redirect_read_reg32(node, LOONGARCH_IOCSR_REDIRECT_CQH);
+
+	*tail = redirect_read_reg32(node, LOONGARCH_IOCSR_REDIRECT_CQT);
+
+	return head == ((*tail + 1) % INVALID_QUEUE_SIZE);
+}
+
+static void invalid_enqueue(struct redirect_item *item, struct irde_inv_cmd *cmd)
+{
+	struct redirect_queue *inv_queue = &item->irde->inv_queue;
+	u32 tail;
+
+	guard(raw_spinlock_irqsave)(&inv_queue->lock);
+
+	while (invalid_queue_is_full(item->irde->node, &tail))
+		cpu_relax();
+
+	memcpy(&inv_queue->cmd_base[tail], cmd, sizeof(*cmd));
+
+	redirect_write_reg32(item->irde->node, (tail + 1) % INVALID_QUEUE_SIZE,
+			     LOONGARCH_IOCSR_REDIRECT_CQT);
+}
+
+static void irde_invalid_entry_node(struct redirect_item *item)
+{
+	struct irde_inv_cmd cmd;
+	u64 raddr = 0;
+
+	cmd.cmd_info = 0;
+	cmd.index.type = INVALID_INDEX;
+	cmd.index.need_notice = 1;
+	cmd.index.index = item->index;
+	cmd.notice_addr = (u64)(__pa(&raddr));
+
+	invalid_enqueue(item, &cmd);
+
+	while (!raddr)
+		cpu_relax();
+
+}
+
+static inline struct avecintc_data *irq_data_get_avec_data(struct irq_data *data)
+{
+	return data->parent_data->chip_data;
+}
+
+static int redirect_table_alloc(struct redirect_item *item)
+{
+	struct redirect_table *ird_table = &item->irde->ird_table;
+	int index;
+
+	guard(raw_spinlock_irqsave)(&ird_table->lock);
+
+	index = find_first_zero_bit(ird_table->bitmap, IRD_ENTRIES);
+	if (index > IRD_ENTRIES) {
+		pr_err("No redirect entry to use\n");
+		return -ENOMEM;
+	}
+
+	__set_bit(index, ird_table->bitmap);
+
+	item->index = index;
+
+	return 0;
+}
+
+static void redirect_table_free(struct redirect_item *item)
+{
+	struct redirect_table *ird_table = &item->irde->ird_table;
+	struct redirect_entry *entry = item_get_entry(item);
+
+	memset(entry, 0, sizeof(*entry));
+
+	scoped_guard(raw_spinlock_irq, &ird_table->lock)
+		bitmap_release_region(ird_table->bitmap, item->index, 0);
+
+	kfree(item->gpid);
+
+	irde_invalid_entry_node(item);
+}
+
+static inline void redirect_domain_prepare_entry(struct redirect_item *item,
+						 struct avecintc_data *adata)
+{
+	struct redirect_entry *entry = item_get_entry(item);
+
+	item->gpid->en = 1;
+	item->gpid->irqnum = adata->vec;
+	item->gpid->dst = adata->cpu;
+
+	entry->lo.valid = 1;
+	entry->lo.gpid = ((u64)item->gpid & GPID_ADDR_MASK) >> GPID_ADDR_SHIFT;
+	entry->lo.vector = 0xff;
+}
+
+static int redirect_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
+{
+	struct redirect_item *item = data->chip_data;
+	int ret;
+
+	ret = irq_chip_set_affinity_parent(data, dest, force);
+	if (ret == IRQ_SET_MASK_OK_DONE) {
+		return ret;
+	} else if (ret) {
+		pr_err("IRDE:set_affinity error %d\n", ret);
+		return ret;
+	} else {
+		struct avecintc_data *adata = irq_data_get_avec_data(data);
+
+		redirect_domain_prepare_entry(item, adata);
+		irde_invalid_entry_node(item);
+		avecintc_sync(adata);
+	}
+
+	return IRQ_SET_MASK_OK;
+}
+
+static void redirect_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct redirect_item *item = irq_data_get_irq_chip_data(d);
+
+	msg->address_lo = (msi_base_addr | 1 << 2 | ((item->index & 0xffff) << 4));
+	msg->address_hi = 0x0;
+	msg->data = 0x0;
+}
+
+static struct irq_chip loongarch_redirect_chip = {
+	.name			= "REDIRECT",
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_affinity	= redirect_set_affinity,
+	.irq_compose_msi_msg	= redirect_compose_msi_msg,
+};
+
+static void redirect_free_resources(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs)
+{
+	for (int i = 0; i < nr_irqs; i++) {
+		struct irq_data *irq_data = irq_domain_get_irq_data(domain, virq + i);
+
+		if (irq_data && irq_data->chip_data) {
+			struct redirect_item *item = irq_data->chip_data;
+
+			redirect_table_free(item);
+			kfree(item);
+		}
+	}
+}
+
+static int redirect_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *arg)
+{
+	msi_alloc_info_t *info = arg;
+	int ret, i, node;
+
+	node = dev_to_node(info->desc->dev);
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *irq_data = irq_domain_get_irq_data(domain, virq + i);
+		struct redirect_item *item;
+
+		item = kzalloc(sizeof(*item), GFP_KERNEL);
+		if (!item) {
+			pr_err("Alloc redirect descriptor failed\n");
+			goto out_free_resources;
+		}
+		item->irde = &irde_descs[node];
+
+		ret = redirect_table_alloc(item);
+		if (ret) {
+			pr_err("Alloc redirect table entry failed\n");
+			goto out_free_resources;
+		}
+		/*
+		 * Only bits 47:6 of the GPID are passed to the controller,
+		 * 64-byte alignment must be guaranteed.
+		 */
+		BUILD_BUG_ON(sizeof(*item->gpid) != 64);
+		item->gpid = kzalloc_node(sizeof(*item->gpid), GFP_KERNEL, node);
+		if (!item->gpid) {
+			pr_err("Alloc redirect GPID failed\n");
+			goto out_free_resources;
+		}
+
+		irq_data->chip_data = item;
+		irq_data->chip = &loongarch_redirect_chip;
+
+		redirect_domain_prepare_entry(item, irq_data_get_avec_data(irq_data));
+	}
+	return 0;
+
+out_free_resources:
+	redirect_free_resources(domain, virq, nr_irqs);
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+
+	return -ENOMEM;
+}
+
+static void redirect_domain_free(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs)
+{
+	redirect_free_resources(domain, virq, nr_irqs);
+	return irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops redirect_domain_ops = {
+	.alloc		= redirect_domain_alloc,
+	.free		= redirect_domain_free,
+	.select		= msi_lib_irq_domain_select,
+};
+
+static int redirect_queue_init(struct irde_desc *irde)
+{
+	struct redirect_queue *inv_queue = &irde->inv_queue;
+	struct folio *folio;
+
+	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, INV_QUEUE_PAGE_ORDER, irde->node);
+	if (!folio) {
+		pr_err("Node [%d] invalid queue alloc pages failed!\n", irde->node);
+		return -ENOMEM;
+	}
+
+	inv_queue->cmd_base = folio_address(folio);
+	inv_queue->head = 0;
+	inv_queue->tail = 0;
+	raw_spin_lock_init(&inv_queue->lock);
+
+	return 0;
+}
+
+static int redirect_table_init(struct irde_desc *irde)
+{
+	struct redirect_table *ird_table = &irde->ird_table;
+	struct folio *folio;
+	unsigned long *bitmap;
+	int node = irde->node;
+
+	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, IRD_TABLE_PAGE_ORDER, node);
+	if (!folio) {
+		pr_err("Node [%d] redirect table alloc pages failed!\n", node);
+		goto fail;
+	}
+	ird_table->table = folio_address(folio);
+
+	bitmap = bitmap_zalloc(IRD_ENTRIES, GFP_KERNEL);
+	if (!bitmap) {
+		pr_err("Node [%d] redirect table bitmap alloc pages failed!\n", node);
+		goto free_pages;
+	}
+
+	ird_table->bitmap = bitmap;
+
+	raw_spin_lock_init(&ird_table->lock);
+
+	return 0;
+
+free_pages:
+	folio_put(folio);
+	ird_table->table = NULL;
+fail:
+	return -ENOMEM;
+}
+
+static void redirect_irde_cfg(struct irde_desc *irde)
+{
+	redirect_write_reg64(irde->node, CFG_DISABLE_IDLE, LOONGARCH_IOCSR_REDIRECT_CFG);
+	redirect_write_reg64(irde->node, __pa(irde->ird_table.table), LOONGARCH_IOCSR_REDIRECT_TBR);
+	redirect_write_reg32(irde->node, 0, LOONGARCH_IOCSR_REDIRECT_CQH);
+	redirect_write_reg32(irde->node, 0, LOONGARCH_IOCSR_REDIRECT_CQT);
+	redirect_write_reg64(irde->node, ((u64)irde->inv_queue.cmd_base & CQB_ADDR_MASK) |
+			     CQB_SIZE_MASK, LOONGARCH_IOCSR_REDIRECT_CQB);
+}
+
+static void __redirect_irde_fini(struct irde_desc *irde)
+{
+	struct redirect_table *ird_table = &irde_descs->ird_table;
+	struct redirect_queue *inv_queue = &irde_descs->inv_queue;
+
+	if (ird_table->table) {
+		folio_put(virt_to_folio(ird_table->table));
+		ird_table->table = NULL;
+	}
+
+	if (ird_table->bitmap) {
+		bitmap_free(ird_table->bitmap);
+		ird_table->bitmap = NULL;
+	}
+
+	if (inv_queue->cmd_base) {
+		folio_put(virt_to_folio(inv_queue->cmd_base));
+		inv_queue->cmd_base = NULL;
+	}
+}
+
+static inline void redirect_irde_fini(int node)
+{
+	__redirect_irde_fini(&irde_descs[node]);
+}
+
+static int redirect_irde_init(int node)
+{
+	struct irde_desc *irde = &irde_descs[node];
+	int ret;
+
+	irde->node = node;
+
+	ret = redirect_table_init(irde);
+	if (ret)
+		goto fail;
+
+	ret = redirect_queue_init(irde);
+	if (ret)
+		goto fail_clear;
+
+	redirect_irde_cfg(irde);
+
+	return 0;
+
+fail_clear:
+	__redirect_irde_fini(irde);
+fail:
+	return ret;
+}
+
+#ifdef CONFIG_ACPI
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
+
+	msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
+
+	return pch_msi_acpi_init_avec(redirect_domain);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
+}
+
+int __init redirect_acpi_init(struct irq_domain *parent)
+{
+	struct fwnode_handle *fwnode;
+	int ret, node;
+
+	fwnode = irq_domain_alloc_named_fwnode("redirect");
+	if (!fwnode) {
+		pr_err("Unable to alloc redirect domain handle\n");
+		goto fail;
+	}
+
+	redirect_domain = irq_domain_create_hierarchy(parent, 0, IRD_ENTRIES, fwnode,
+						      &redirect_domain_ops, irde_descs);
+	if (!redirect_domain) {
+		pr_err("Unable to alloc redirect domain\n");
+		goto out_free_fwnode;
+	}
+
+
+	for_each_node_mask(node, node_possible_map) {
+		ret = redirect_irde_init(node);
+		if (ret)
+			goto out_clear_irde;
+	}
+
+	ret = acpi_cascade_irqdomain_init();
+	if (ret < 0)
+		pr_err("Failed to cascade IRQ domain, ret=%d\n", ret);
+
+	pr_info("loongarch irq redirect modules init succeeded\n");
+	return 0;
+
+out_clear_irde:
+	for_each_node_mask(node, node_possible_map)
+		redirect_irde_fini(node);
+
+	irq_domain_remove(redirect_domain);
+out_free_fwnode:
+	irq_domain_free_fwnode(fwnode);
+fail:
+	return ret;
+}
+#endif
diff --git a/drivers/irqchip/irq-loongson.h b/drivers/irqchip/irq-loongson.h
index 11fa138d1f44..1f11d799bf0a 100644
--- a/drivers/irqchip/irq-loongson.h
+++ b/drivers/irqchip/irq-loongson.h
@@ -6,6 +6,17 @@
 #ifndef _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
 #define _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
 
+#define AVEC_MSG_OFFSET		0x100000
+
+struct avecintc_data {
+	struct list_head        entry;
+	unsigned int            cpu;
+	unsigned int            vec;
+	unsigned int            prev_cpu;
+	unsigned int            prev_vec;
+	unsigned int            moving;
+};
+
 int find_pch_pic(u32 gsi);
 
 int liointc_acpi_init(struct irq_domain *parent,
@@ -24,4 +35,12 @@ int pch_msi_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_msi_pic *acpi_pchmsi);
 int pch_msi_acpi_init_avec(struct irq_domain *parent);
 
+int redirect_acpi_init(struct irq_domain *parent);
+
+#ifdef CONFIG_SMP
+void avecintc_sync(struct avecintc_data *adata);
+#else
+static inline void avecintc_sync(struct avecintc_data *adata) {}
+#endif
+
 #endif /* _DRIVERS_IRQCHIP_IRQ_LOONGSON_H */
-- 
2.41.0


