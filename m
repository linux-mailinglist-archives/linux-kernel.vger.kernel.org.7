Return-Path: <linux-kernel+bounces-761332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD7B1F883
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2E4176DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8A1F4199;
	Sun, 10 Aug 2025 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wcILaRqp"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4020B801
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805150; cv=none; b=UNw9IozCycSQd9Q++1F5BYVqSWslDVXdd9izBxH04m3cK60DTGMrjAJKUQbhuzr/xchLUsjcJdccogCE0mgUbCTBkqu0Y4xj6FWajXiUq8qqgo0nN/DntxZZ+xoHjfD9dBPzJTZ6sWac1Vn55vyODwLCmzzq0oxOgtU4TzTnpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805150; c=relaxed/simple;
	bh=+eLGnxvvqvTTdh1BA9DbAP09pacbL/3s3+u1502w5io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3uT1K/zohD5I+bg9qJEisruRW5ZgRVynjIXiUdHmX0qxbEtqN3uFebozXO26L+T3X3nODr1lVdZH7dse1DX3wyBTXqokvsBHOcVBOLgg+osOaM6r/1HafIne4HUvlfg5k4Nsj0p4aj/NvBFcs76P7iP2MDjMkhXfK5OeAOiL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wcILaRqp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCooMsfORuA0Zw7dtPUylsaELoayY0q+VRBoGcPUYYQ=;
	b=wcILaRqpsY4e/XtKQN3xW8azX8vf9VtL8twvoySCGwlK07z9+z3h90ASbhyrJ/5fDVEGaA
	l/FR1sYviPmxZdDq44nz2b7M7s8CQLjx8csNwuEoUuyC5j0MtYO8l9iJrxVOyweKpUdt26
	FFuvjJLI5Gkxz6IhKW+Qrj85QvAknic=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 08/10] um: Add initial SMP support
Date: Sun, 10 Aug 2025 13:51:34 +0800
Message-Id: <20250810055136.897712-9-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

Add initial symmetric multi-processing (SMP) support to UML. With
this support enabled, users can tell UML to start multiple virtual
processors, each represented as a separate host thread.

In UML, kthreads and normal threads (when running in kernel mode)
can be scheduled and executed simultaneously on different virtual
processors. However, the userspace code of normal threads still
runs within their respective single-threaded stubs.

That is, SMP support is currently available both within the kernel
and across different processes, but still remains limited within
threads of the same process in userspace.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 .../core/generic-idle-thread/arch-support.txt |   2 +-
 arch/um/Kconfig                               |  46 +++-
 arch/um/include/asm/current.h                 |   5 +-
 arch/um/include/asm/hardirq.h                 |  24 +-
 arch/um/include/asm/mmu.h                     |  10 +
 arch/um/include/asm/pgtable.h                 |   2 +
 arch/um/include/asm/smp.h                     |  15 +-
 arch/um/include/linux/smp-internal.h          |  17 ++
 arch/um/include/shared/kern_util.h            |   1 +
 arch/um/include/shared/os.h                   |  16 ++
 arch/um/include/shared/skas/mm_id.h           |   5 +
 arch/um/include/shared/smp.h                  |  20 ++
 arch/um/kernel/Makefile                       |   1 +
 arch/um/kernel/irq.c                          |  25 ++
 arch/um/kernel/mem.c                          |   2 +
 arch/um/kernel/process.c                      |   7 +-
 arch/um/kernel/skas/mmu.c                     |  32 ++-
 arch/um/kernel/skas/process.c                 |   7 +-
 arch/um/kernel/smp.c                          | 239 ++++++++++++++++++
 arch/um/kernel/tlb.c                          |   5 +-
 arch/um/kernel/trap.c                         |   2 +-
 arch/um/kernel/um_arch.c                      |  25 +-
 arch/um/os-Linux/Makefile                     |   4 +-
 arch/um/os-Linux/internal.h                   |   7 +
 arch/um/os-Linux/main.c                       |   3 +-
 arch/um/os-Linux/process.c                    |  20 ++
 arch/um/os-Linux/signal.c                     |  29 ++-
 arch/um/os-Linux/skas/process.c               |  22 +-
 arch/um/os-Linux/smp.c                        | 142 +++++++++++
 arch/um/os-Linux/start_up.c                   |   4 +
 arch/um/os-Linux/time.c                       |  11 +-
 31 files changed, 710 insertions(+), 40 deletions(-)
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c

diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 0735cb5367b4..425442e31fa2 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -24,7 +24,7 @@
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |          um: | TODO |
+    |          um: |  ok  |
     |         x86: |  ok  |
     |      xtensa: |  ok  |
     -----------------------
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..24dc240be0f9 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -27,6 +27,7 @@ config UML
 	select OF_EARLY_FLATTREE if OF
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
+	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_GCC_PLUGINS
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
@@ -79,10 +80,48 @@ config HZ
 	int
 	default 100
 
-config NR_CPUS
+config UML_SUBARCH_SUPPORTS_SMP
+	bool
+
+config SMP
+	bool "Symmetric multi-processing support"
+	default n
+	depends on UML_SUBARCH_SUPPORTS_SMP
+	help
+	  This option enables UML SMP support.
+
+	  With this enabled, users can tell UML to start multiple virtual
+	  processors. Each virtual processor is represented as a separate
+	  host thread.
+
+	  In UML, kthreads and normal threads (when running in kernel mode)
+	  can be scheduled and executed simultaneously on different virtual
+	  processors. However, the userspace code of normal threads still
+	  runs within their respective single-threaded stubs.
+
+	  That is, SMP support is available both within the kernel and
+	  across different processes, but remains limited within threads
+	  of the same process in userspace.
+
+config NR_CPUS_RANGE_BEGIN
 	int
-	range 1 1
-	default 1
+	default 1 if !SMP
+	default 2
+
+config NR_CPUS_RANGE_END
+	int
+	default 1 if !SMP
+	default 64
+
+config NR_CPUS_DEFAULT
+	int
+	default 1 if !SMP
+	default 2
+
+config NR_CPUS
+	int "Maximum number of CPUs" if SMP
+	range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
+	default NR_CPUS_DEFAULT
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
@@ -258,6 +297,7 @@ source "arch/um/drivers/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
+	depends on !SMP
 
 menu "Power management options"
 
diff --git a/arch/um/include/asm/current.h b/arch/um/include/asm/current.h
index 8accc6d6f502..159a29b3d4cc 100644
--- a/arch/um/include/asm/current.h
+++ b/arch/um/include/asm/current.h
@@ -7,15 +7,16 @@
 
 #ifndef __ASSEMBLER__
 
+#include <shared/smp.h>
+
 struct task_struct;
 extern struct task_struct *cpu_tasks[NR_CPUS];
 
 static __always_inline struct task_struct *get_current(void)
 {
-	return cpu_tasks[0];
+	return cpu_tasks[uml_curr_cpu()];
 }
 
-
 #define current get_current()
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index 52e2c36267a9..8de71752a9b8 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -2,8 +2,30 @@
 #ifndef __ASM_UM_HARDIRQ_H
 #define __ASM_UM_HARDIRQ_H
 
-#include <asm-generic/hardirq.h>
+#include <linux/cache.h>
+#include <linux/threads.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
 
+typedef struct {
+	unsigned int __softirq_pending;
+#if IS_ENABLED(CONFIG_SMP)
+	unsigned int irq_resched_count;
+	unsigned int irq_call_count;
+#endif
+} ____cacheline_aligned irq_cpustat_t;
+
+DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+
+#define __ARCH_IRQ_STAT
+
+#define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
+
+#include <linux/irq.h>
+
+static inline void ack_bad_irq(unsigned int irq)
+{
+	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
+}
+
 #endif /* __ASM_UM_HARDIRQ_H */
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 4d0e4239f3cc..07d48738b402 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -7,16 +7,26 @@
 #define __ARCH_UM_MMU_H
 
 #include "linux/types.h"
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <mm_id.h>
 
 typedef struct mm_context {
 	struct mm_id id;
+	struct mutex turnstile;
 
 	struct list_head list;
 
 	/* Address range in need of a TLB sync */
+	spinlock_t sync_tlb_lock;
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
 } mm_context_t;
 
+#define INIT_MM_CONTEXT(mm)						\
+	.context = {							\
+		.turnstile = __MUTEX_INITIALIZER(mm.context.turnstile),	\
+		.sync_tlb_lock = __SPIN_LOCK_INITIALIZER(mm.context.sync_tlb_lock), \
+	}
+
 #endif
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 24fdea6f88c3..91aec3698475 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -225,6 +225,8 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 static inline void um_tlb_mark_sync(struct mm_struct *mm, unsigned long start,
 				    unsigned long end)
 {
+	guard(spinlock_irqsave)(&mm->context.sync_tlb_lock);
+
 	if (!mm->context.sync_tlb_range_to) {
 		mm->context.sync_tlb_range_from = start;
 		mm->context.sync_tlb_range_to = end;
diff --git a/arch/um/include/asm/smp.h b/arch/um/include/asm/smp.h
index a8cc1d46ddcb..be1743a6ff3c 100644
--- a/arch/um/include/asm/smp.h
+++ b/arch/um/include/asm/smp.h
@@ -2,6 +2,19 @@
 #ifndef __UM_SMP_H
 #define __UM_SMP_H
 
-#define hard_smp_processor_id()		0
+#if IS_ENABLED(CONFIG_SMP)
+
+#include <linux/cpumask.h>
+#include <shared/smp.h>
+
+#define raw_smp_processor_id() uml_curr_cpu()
+
+void arch_smp_send_reschedule(int cpu);
+
+void arch_send_call_function_single_ipi(int cpu);
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+
+#endif /* CONFIG_SMP */
 
 #endif
diff --git a/arch/um/include/linux/smp-internal.h b/arch/um/include/linux/smp-internal.h
new file mode 100644
index 000000000000..1dbcbc23f9c9
--- /dev/null
+++ b/arch/um/include/linux/smp-internal.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_SMP_INTERNAL_H
+#define __UM_SMP_INTERNAL_H
+
+#if IS_ENABLED(CONFIG_SMP)
+
+void prefill_possible_map(void);
+
+#else /* !CONFIG_SMP */
+
+static inline void prefill_possible_map(void) { }
+
+#endif /* CONFIG_SMP */
+
+extern char cpu_irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
+
+#endif /* __UM_SMP_INTERNAL_H */
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 3daaa5c4b35d..14a8df1927a6 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -14,6 +14,7 @@ struct siginfo;
 extern int uml_exitcode;
 
 extern int kmalloc_ok;
+extern int kmalloc_disabled[];
 
 #define UML_ROUND_UP(addr) \
 	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 0ca6e4548671..2be7309b7863 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -216,6 +216,9 @@ extern int can_drop_memory(void);
 
 void os_set_pdeathsig(void);
 
+int os_futex_wait(void *uaddr, unsigned int val);
+int os_futex_wake(void *uaddr);
+
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
@@ -339,4 +342,17 @@ extern void um_trace_signals_off(void);
 /* time-travel */
 extern void deliver_time_travel_irqs(void);
 
+/* smp.c */
+#if IS_ENABLED(CONFIG_SMP)
+void os_init_smp(void);
+int os_start_cpu_thread(int cpu);
+void os_start_secondary(void *arg, jmp_buf *switch_buf);
+int os_send_ipi(int cpu, int vector);
+void os_local_ipi_enable(void);
+void os_local_ipi_disable(void);
+#else /* !CONFIG_SMP */
+static inline void os_local_ipi_enable(void) { }
+static inline void os_local_ipi_disable(void) { }
+#endif /* CONFIG_SMP */
+
 #endif
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 4f977ef5dda5..fb96c0bd8222 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -6,6 +6,8 @@
 #ifndef __MM_ID_H
 #define __MM_ID_H
 
+#include <linux/compiler_types.h>
+
 #define STUB_MAX_FDS 4
 
 struct mm_id {
@@ -19,6 +21,9 @@ struct mm_id {
 	int syscall_fd_map[STUB_MAX_FDS];
 };
 
+void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile);
+void exit_turnstile(struct mm_id *mm_id) __releases(turnstile);
+
 void notify_mm_kill(int pid);
 
 #endif
diff --git a/arch/um/include/shared/smp.h b/arch/um/include/shared/smp.h
new file mode 100644
index 000000000000..06e3faa95091
--- /dev/null
+++ b/arch/um/include/shared/smp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_SHARED_SMP_H
+#define __UM_SHARED_SMP_H
+
+#if IS_ENABLED(CONFIG_SMP)
+
+extern int uml_ncpus;
+
+int uml_curr_cpu(void);
+void uml_start_secondary(void *opaque);
+void uml_ipi_handler(int vector);
+
+#else /* !CONFIG_SMP */
+
+#define uml_ncpus 1
+#define uml_curr_cpu() 0
+
+#endif /* CONFIG_SMP */
+
+#endif /* __UM_SHARED_SMP_H */
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..be60bc451b3f 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
+obj-$(CONFIG_SMP) += smp.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 5ed8014e43e4..ed1a3d69d09b 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -22,6 +22,9 @@
 #include <irq_kern.h>
 #include <linux/time-internal.h>
 
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+
+#define irq_stats(x)		(&per_cpu(irq_stat, x))
 
 /* When epoll triggers we do not know why it did so
  * we can also have different IRQs for read and write.
@@ -696,3 +699,25 @@ void sigchld_handler(int sig, struct siginfo *unused_si,
 {
 	do_IRQ(SIGCHLD_IRQ, regs);
 }
+
+/*
+ * /proc/interrupts printing for arch specific interrupts
+ */
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+#if IS_ENABLED(CONFIG_SMP)
+	int cpu;
+
+	seq_printf(p, "%*s: ", prec, "RES");
+	for_each_online_cpu(cpu)
+		seq_printf(p, "%10u ", irq_stats(cpu)->irq_resched_count);
+	seq_puts(p, "  Rescheduling interrupts\n");
+
+	seq_printf(p, "%*s: ", prec, "CAL");
+	for_each_online_cpu(cpu)
+		seq_printf(p, "%10u ", irq_stats(cpu)->irq_call_count);
+	seq_puts(p, "  Function call interrupts\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b5..d35c1bd225e0 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -53,6 +53,8 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD];
 /* Initialized at boot time, and readonly after that */
 int kmalloc_ok = 0;
 
+int kmalloc_disabled[NR_CPUS];
+
 /* Used during early boot */
 static unsigned long brk_end;
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 01b935c00454..5570c6065243 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -185,11 +185,12 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 
 void initial_thread_cb(void (*proc)(void *), void *arg)
 {
-	int save_kmalloc_ok = kmalloc_ok;
+	int cpu = raw_smp_processor_id();
+	int save_kmalloc = kmalloc_disabled[cpu];
 
-	kmalloc_ok = 0;
+	kmalloc_disabled[cpu] = 1;
 	initial_thread_cb_skas(proc, arg);
-	kmalloc_ok = save_kmalloc_ok;
+	kmalloc_disabled[cpu] = save_kmalloc;
 }
 
 int arch_dup_task_struct(struct task_struct *dst,
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index afe9a2f251ef..511b2e21fea0 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -23,12 +23,30 @@ static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 static spinlock_t mm_list_lock;
 static struct list_head mm_list;
 
+void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile)
+{
+	struct mm_context *ctx = container_of(mm_id, struct mm_context, id);
+
+	mutex_lock(&ctx->turnstile);
+}
+
+void exit_turnstile(struct mm_id *mm_id) __releases(turnstile)
+{
+	struct mm_context *ctx = container_of(mm_id, struct mm_context, id);
+
+	mutex_unlock(&ctx->turnstile);
+}
+
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
 	struct mm_id *new_id = &mm->context.id;
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
+	mutex_init(&mm->context.turnstile);
+
+	spin_lock_init(&mm->context.sync_tlb_lock);
+
 	stack = __get_free_pages(GFP_KERNEL | __GFP_ZERO, ilog2(STUB_DATA_PAGES));
 	if (stack == 0)
 		goto out;
@@ -73,6 +91,9 @@ void destroy_context(struct mm_struct *mm)
 		return;
 	}
 
+	scoped_guard(spinlock_irqsave, &mm_list_lock)
+		list_del(&mm->context.list);
+
 	if (mmu->id.pid > 0) {
 		os_kill_ptraced_process(mmu->id.pid, 1);
 		mmu->id.pid = -1;
@@ -82,10 +103,6 @@ void destroy_context(struct mm_struct *mm)
 		os_close_file(mmu->id.sock);
 
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
-
-	guard(spinlock_irqsave)(&mm_list_lock);
-
-	list_del(&mm->context.list);
 }
 
 static irqreturn_t mm_sigchld_irq(int irq, void* dev)
@@ -110,12 +127,11 @@ static irqreturn_t mm_sigchld_irq(int irq, void* dev)
 				/* Marks the MM as dead */
 				mm_context->id.pid = -1;
 
-				/*
-				 * NOTE: If SMP is implemented, a futex_wake
-				 * needs to be added here.
-				 */
 				stub_data = (void *)mm_context->id.stack;
 				stub_data->futex = FUTEX_IN_KERN;
+#if IS_ENABLED(CONFIG_SMP)
+				os_futex_wake(&stub_data->futex);
+#endif
 
 				/*
 				 * NOTE: Currently executing syscalls by
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 5881b17eb987..444e82b5b7ee 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -7,6 +7,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/task.h>
+#include <linux/smp-internal.h>
 
 #include <asm/tlbflush.h>
 
@@ -26,12 +27,12 @@ static int __init start_kernel_proc(void *unused)
 	return 0;
 }
 
-static char cpu0_irqstack[THREAD_SIZE] __aligned(THREAD_SIZE);
+char cpu_irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
 
 int __init start_uml(void)
 {
-	stack_protections((unsigned long) &cpu0_irqstack);
-	set_sigstack(cpu0_irqstack, THREAD_SIZE);
+	stack_protections((unsigned long) &cpu_irqstacks[0]);
+	set_sigstack(cpu_irqstacks[0], THREAD_SIZE);
 
 	init_new_thread_signals();
 
diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
new file mode 100644
index 000000000000..08fa49a1e037
--- /dev/null
+++ b/arch/um/kernel/smp.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Ant Group
+ * Author: Tiwei Bie <tiwei.btw@antgroup.com>
+ *
+ * Based on the previous implementation in TT mode
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <linux/sched/task_stack.h>
+#include <linux/module.h>
+#include <linux/processor.h>
+#include <linux/threads.h>
+#include <linux/cpu.h>
+#include <linux/hardirq.h>
+#include <linux/smp.h>
+#include <linux/smp-internal.h>
+#include <init.h>
+#include <kern.h>
+#include <os.h>
+#include <smp.h>
+
+enum {
+	UML_IPI_RES = 0,
+	UML_IPI_CALL_SINGLE,
+	UML_IPI_CALL,
+	UML_IPI_STOP,
+};
+
+void arch_smp_send_reschedule(int cpu)
+{
+	os_send_ipi(cpu, UML_IPI_RES);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	os_send_ipi(cpu, UML_IPI_CALL_SINGLE);
+}
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mask)
+		os_send_ipi(cpu, UML_IPI_CALL);
+}
+
+void smp_send_stop(void)
+{
+	int cpu, me = smp_processor_id();
+
+	for_each_online_cpu(cpu) {
+		if (cpu == me)
+			continue;
+		os_send_ipi(cpu, UML_IPI_STOP);
+	}
+}
+
+static void ipi_handler(int vector, struct uml_pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs((struct pt_regs *)regs);
+	int cpu = raw_smp_processor_id();
+
+	irq_enter();
+
+	if (current->mm)
+		os_alarm_process(current->mm->context.id.pid);
+
+	switch (vector) {
+	case UML_IPI_RES:
+		inc_irq_stat(irq_resched_count);
+		scheduler_ipi();
+		break;
+
+	case UML_IPI_CALL_SINGLE:
+		inc_irq_stat(irq_call_count);
+		generic_smp_call_function_single_interrupt();
+		break;
+
+	case UML_IPI_CALL:
+		inc_irq_stat(irq_call_count);
+		generic_smp_call_function_interrupt();
+		break;
+
+	case UML_IPI_STOP:
+		set_cpu_online(cpu, false);
+		while (1)
+			pause();
+		break;
+
+	default:
+		pr_err("CPU#%d received unknown IPI (vector=%d)!\n", cpu, vector);
+		break;
+	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+
+void uml_ipi_handler(int vector)
+{
+	struct uml_pt_regs r = { .is_user = 0 };
+
+	preempt_disable();
+	ipi_handler(vector, &r);
+	preempt_enable();
+}
+
+/* AP states used only during CPU startup */
+enum {
+	UML_CPU_PAUSED = 0,
+	UML_CPU_RUNNING,
+};
+
+static int cpu_states[NR_CPUS];
+
+static int start_secondary(void *unused)
+{
+	int err, cpu = raw_smp_processor_id();
+
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+
+	err = um_setup_timer();
+	if (err)
+		panic("CPU#%d failed to setup timer, err = %d", cpu, err);
+
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+	return 0;
+}
+
+void uml_start_secondary(void *opaque)
+{
+	int cpu = raw_smp_processor_id();
+	struct mm_struct *mm = &init_mm;
+	struct task_struct *idle;
+
+	stack_protections((unsigned long) &cpu_irqstacks[cpu]);
+	set_sigstack(&cpu_irqstacks[cpu], THREAD_SIZE);
+
+	set_cpu_present(cpu, true);
+	os_futex_wait(&cpu_states[cpu], UML_CPU_PAUSED);
+
+	smp_rmb(); /* paired with smp_wmb() in __cpu_up() */
+
+	idle = cpu_tasks[cpu];
+	idle->thread_info.cpu = cpu;
+
+	mmgrab(mm);
+	idle->active_mm = mm;
+
+	idle->thread.request.thread.proc = start_secondary;
+	idle->thread.request.thread.arg = NULL;
+
+	new_thread(task_stack_page(idle), &idle->thread.switch_buf,
+		   new_thread_handler);
+	os_start_secondary(opaque, &idle->thread.switch_buf);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	int err, cpu, me = smp_processor_id();
+	unsigned long deadline;
+
+	os_init_smp();
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == me)
+			continue;
+
+		pr_debug("Booting processor %d...\n", cpu);
+		err = os_start_cpu_thread(cpu);
+		if (err) {
+			pr_crit("CPU#%d failed to start cpu thread, err = %d",
+				cpu, err);
+			continue;
+		}
+
+		deadline = jiffies + msecs_to_jiffies(1000);
+		spin_until_cond(cpu_present(cpu) ||
+				time_is_before_jiffies(deadline));
+
+		if (!cpu_present(cpu))
+			pr_crit("CPU#%d failed to boot\n", cpu);
+	}
+}
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	cpu_tasks[cpu] = tidle;
+	smp_wmb(); /* paired with smp_rmb() in uml_start_secondary() */
+	cpu_states[cpu] = UML_CPU_RUNNING;
+	os_futex_wake(&cpu_states[cpu]);
+	spin_until_cond(cpu_online(cpu));
+
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+/* Set in uml_ncpus_setup */
+int uml_ncpus = 1;
+
+void __init prefill_possible_map(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < uml_ncpus; cpu++)
+		set_cpu_possible(cpu, true);
+	for (; cpu < NR_CPUS; cpu++)
+		set_cpu_possible(cpu, false);
+}
+
+static int __init uml_ncpus_setup(char *line, int *add)
+{
+	*add = 0;
+
+	if (kstrtoint(line, 10, &uml_ncpus)) {
+		os_warn("%s: Couldn't parse '%s'\n", __func__, line);
+		return -1;
+	}
+
+	uml_ncpus = clamp(uml_ncpus, 1, NR_CPUS);
+
+	return 0;
+}
+
+__uml_setup("ncpus=", uml_ncpus_setup,
+"ncpus=<# of desired CPUs>\n"
+"    This tells UML how many virtual processors to start. The maximum\n"
+"    number of supported virtual processors can be obtained by querying\n"
+"    the CONFIG_NR_CPUS option using --showconfig.\n\n"
+);
+
+EXPORT_SYMBOL(uml_curr_cpu);
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index cf7e0d4407f2..39608cccf2c6 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -162,9 +162,11 @@ int um_tlb_sync(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 	struct vm_ops ops;
-	unsigned long addr = mm->context.sync_tlb_range_from, next;
+	unsigned long addr, next;
 	int ret = 0;
 
+	guard(spinlock_irqsave)(&mm->context.sync_tlb_lock);
+
 	if (mm->context.sync_tlb_range_to == 0)
 		return 0;
 
@@ -177,6 +179,7 @@ int um_tlb_sync(struct mm_struct *mm)
 		ops.unmap = unmap;
 	}
 
+	addr = mm->context.sync_tlb_range_from;
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, mm->context.sync_tlb_range_to);
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 5b80a3a89c20..177615820a4c 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -316,7 +316,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
-	if (!is_user && init_mm.context.sync_tlb_range_to) {
+	if (!is_user && address >= start_vm && address < end_vm) {
 		/*
 		 * Kernel has pending updates from set_ptes that were not
 		 * flushed yet. Syncing them should fix the pagefault (if not
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e46718b3c711..b4a80dcfe1c0 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -19,6 +19,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/suspend.h>
 #include <linux/random.h>
+#include <linux/smp-internal.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -71,6 +72,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	int i = 0;
 
+#if IS_ENABLED(CONFIG_SMP)
+	i = (uintptr_t) v - 1;
+	if (!cpu_online(i))
+		return 0;
+#endif
+
 	seq_printf(m, "processor\t: %d\n", i);
 	seq_printf(m, "vendor_id\t: User Mode Linux\n");
 	seq_printf(m, "model name\t: UML\n");
@@ -87,13 +94,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   loops_per_jiffy/(500000/HZ),
 		   (loops_per_jiffy/(5000/HZ)) % 100);
 
-
 	return 0;
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos < nr_cpu_ids ? &boot_cpu_data + *pos : NULL;
+	if (*pos < nr_cpu_ids)
+		return (void *)(uintptr_t)(*pos + 1);
+	return NULL;
 }
 
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
@@ -423,6 +431,7 @@ void __init setup_arch(char **cmdline_p)
 	strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	setup_hostinfo(host_info, sizeof host_info);
+	prefill_possible_map();
 
 	if (os_getrandom(rng_seed, sizeof(rng_seed), 0) == sizeof(rng_seed)) {
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
@@ -457,6 +466,18 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
 
+#if IS_ENABLED(CONFIG_SMP)
+void alternatives_smp_module_add(struct module *mod, char *name,
+				 void *locks, void *locks_end,
+				 void *text,  void *text_end)
+{
+}
+
+void alternatives_smp_module_del(struct module *mod)
+{
+}
+#endif
+
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
 	/*
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index fae836713487..70c73c22f715 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -16,8 +16,10 @@ CFLAGS_main.o += -Wno-frame-larger-than
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
+obj-$(CONFIG_SMP) += smp.o
+
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
-	tty.o umid.o util.o
+	tty.o umid.o util.o smp.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index 5d8d3b0817a9..0c21b4545d7c 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -4,6 +4,7 @@
 
 #include <mm_id.h>
 #include <stub-data.h>
+#include <signal.h>
 
 /*
  * elf_aux.c
@@ -20,4 +21,10 @@ void check_tmpexec(void);
  */
 void wait_stub_done(int pid);
 void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys);
+
+/*
+ * smp.c
+ */
+#define IPI_SIGNAL	SIGRTMIN
+
 #endif /* __UM_OS_LINUX_INTERNAL_H */
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 730723106228..f46a0b30a2a1 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -16,6 +16,7 @@
 #include <init.h>
 #include <kern_util.h>
 #include <os.h>
+#include <smp.h>
 #include <um_malloc.h>
 #include "internal.h"
 
@@ -207,7 +208,7 @@ void *__wrap_malloc(int size)
 {
 	void *ret;
 
-	if (!kmalloc_ok)
+	if (!kmalloc_ok || kmalloc_disabled[uml_curr_cpu()])
 		return __real_malloc(size);
 	else if (size <= UM_KERN_PAGE_SIZE)
 		/* finding contiguous pages can be hard*/
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 00b49e90d05f..3a2a84ab9325 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -10,6 +10,8 @@
 #include <errno.h>
 #include <signal.h>
 #include <fcntl.h>
+#include <limits.h>
+#include <linux/futex.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
 #include <sys/prctl.h>
@@ -189,3 +191,21 @@ void os_set_pdeathsig(void)
 {
 	prctl(PR_SET_PDEATHSIG, SIGKILL);
 }
+
+int os_futex_wait(void *uaddr, unsigned int val)
+{
+	int r;
+
+	CATCH_EINTR(r = syscall(__NR_futex, uaddr, FUTEX_WAIT, val,
+				NULL, NULL, 0));
+	return r < 0 ? -errno : r;
+}
+
+int os_futex_wake(void *uaddr)
+{
+	int r;
+
+	CATCH_EINTR(r = syscall(__NR_futex, uaddr, FUTEX_WAKE, INT_MAX,
+				NULL, NULL, 0));
+	return r < 0 ? -errno : r;
+}
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 58da8c6ece98..b05e32d51d5b 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -253,9 +253,29 @@ int change_sig(int signal, int on)
 	return 0;
 }
 
-void block_signals(void)
+static inline void __block_signals(void)
 {
+	if (!signals_enabled)
+		return;
+
+	os_local_ipi_disable();
+	barrier();
 	signals_enabled = 0;
+}
+
+static inline void __unblock_signals(void)
+{
+	if (signals_enabled)
+		return;
+
+	signals_enabled = 1;
+	barrier();
+	os_local_ipi_enable();
+}
+
+void block_signals(void)
+{
+	__block_signals();
 	/*
 	 * This must return with signals disabled, so this barrier
 	 * ensures that writes are flushed out before the return.
@@ -272,7 +292,8 @@ void unblock_signals(void)
 	if (signals_enabled == 1)
 		return;
 
-	signals_enabled = 1;
+	__unblock_signals();
+
 #if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 	deliver_time_travel_irqs();
 #endif
@@ -306,7 +327,7 @@ void unblock_signals(void)
 		 * tracing that happens inside the handlers we call for the
 		 * pending signals will mess up the tracing state.
 		 */
-		signals_enabled = 0;
+		__block_signals();
 		um_trace_signals_off();
 
 		/*
@@ -338,7 +359,7 @@ void unblock_signals(void)
 
 		/* Re-enable signals and trace that we're doing so. */
 		um_trace_signals_on();
-		signals_enabled = 1;
+		__unblock_signals();
 	}
 }
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 78f48fa9db8b..42fa99227b4c 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -553,7 +553,7 @@ extern unsigned long tt_extra_sched_jiffies;
 void userspace(struct uml_pt_regs *regs)
 {
 	int err, status, op;
-	siginfo_t si_ptrace;
+	siginfo_t si_local;
 	siginfo_t *si;
 	int sig;
 
@@ -563,6 +563,13 @@ void userspace(struct uml_pt_regs *regs)
 	while (1) {
 		struct mm_id *mm_id = current_mm_id();
 
+		/*
+		 * At any given time, only one CPU thread can enter the
+		 * turnstile to operate on the same stub process, including
+		 * executing stub system calls (mmap and munmap).
+		 */
+		enter_turnstile(mm_id);
+
 		/*
 		 * When we are in time-travel mode, userspace can theoretically
 		 * do a *lot* of work without being scheduled. The problem with
@@ -630,9 +637,10 @@ void userspace(struct uml_pt_regs *regs)
 			}
 
 			if (proc_data->si_offset > sizeof(proc_data->sigstack) - sizeof(*si))
-				panic("%s - Invalid siginfo offset from child",
-				      __func__);
-			si = (void *)&proc_data->sigstack[proc_data->si_offset];
+				panic("%s - Invalid siginfo offset from child", __func__);
+
+			si = &si_local;
+			memcpy(si, &proc_data->sigstack[proc_data->si_offset], sizeof(*si));
 
 			regs->is_user = 1;
 
@@ -728,8 +736,8 @@ void userspace(struct uml_pt_regs *regs)
 				case SIGFPE:
 				case SIGWINCH:
 					ptrace(PTRACE_GETSIGINFO, pid, 0,
-					       (struct siginfo *)&si_ptrace);
-					si = &si_ptrace;
+					       (struct siginfo *)&si_local);
+					si = &si_local;
 					break;
 				default:
 					si = NULL;
@@ -740,6 +748,8 @@ void userspace(struct uml_pt_regs *regs)
 			}
 		}
 
+		exit_turnstile(mm_id);
+
 		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
 
 		if (sig) {
diff --git a/arch/um/os-Linux/smp.c b/arch/um/os-Linux/smp.c
new file mode 100644
index 000000000000..78c416b1d8db
--- /dev/null
+++ b/arch/um/os-Linux/smp.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Ant Group
+ * Author: Tiwei Bie <tiwei.btw@antgroup.com>
+ */
+
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <kern_util.h>
+#include <um_malloc.h>
+#include <init.h>
+#include <os.h>
+#include <smp.h>
+#include "internal.h"
+
+struct cpu_thread_data {
+	int cpu;
+	sigset_t sigset;
+};
+
+static __thread int __curr_cpu;
+
+int uml_curr_cpu(void)
+{
+	return __curr_cpu;
+}
+
+static pthread_t cpu_threads[CONFIG_NR_CPUS];
+
+static void *cpu_thread(void *arg)
+{
+	struct cpu_thread_data *data = arg;
+
+	__curr_cpu = data->cpu;
+
+	uml_start_secondary(data);
+
+	return NULL;
+}
+
+int os_start_cpu_thread(int cpu)
+{
+	struct cpu_thread_data *data;
+	sigset_t sigset, oset;
+	int err;
+
+	data = uml_kmalloc(sizeof(*data), UM_GFP_ATOMIC);
+	if (!data)
+		return -ENOMEM;
+
+	sigfillset(&sigset);
+	if (sigprocmask(SIG_SETMASK, &sigset, &oset) < 0) {
+		err = errno;
+		goto err;
+	}
+
+	data->cpu = cpu;
+	data->sigset = oset;
+
+	err = pthread_create(&cpu_threads[cpu], NULL, cpu_thread, data);
+	if (sigprocmask(SIG_SETMASK, &oset, NULL) < 0)
+		panic("Failed to restore the signal mask, errno = %d", errno);
+	if (err != 0)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(data);
+	return -err;
+}
+
+void os_start_secondary(void *arg, jmp_buf *switch_buf)
+{
+	struct cpu_thread_data *data = arg;
+
+	sigaddset(&data->sigset, IPI_SIGNAL);
+	sigaddset(&data->sigset, SIGIO);
+
+	if (sigprocmask(SIG_SETMASK, &data->sigset, NULL) < 0)
+		panic("Failed to restore the signal mask, errno = %d", errno);
+
+	kfree(data);
+	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+}
+
+int os_send_ipi(int cpu, int vector)
+{
+	union sigval value = { .sival_int = vector };
+
+	return pthread_sigqueue(cpu_threads[cpu], IPI_SIGNAL, value);
+}
+
+static void __local_ipi_set(int enable)
+{
+	sigset_t sigset;
+
+	sigemptyset(&sigset);
+	sigaddset(&sigset, IPI_SIGNAL);
+
+	if (sigprocmask(enable ? SIG_UNBLOCK : SIG_BLOCK, &sigset, NULL) < 0)
+		panic("%s: sigprocmask failed, errno = %d", __func__, errno);
+}
+
+void os_local_ipi_enable(void)
+{
+	__local_ipi_set(1);
+}
+
+void os_local_ipi_disable(void)
+{
+	__local_ipi_set(0);
+}
+
+static void ipi_sig_handler(int sig, siginfo_t *si, void *uc)
+{
+	int save_errno = errno;
+
+	block_signals_trace();
+	uml_ipi_handler(si->si_value.sival_int);
+	unblock_signals_trace();
+
+	errno = save_errno;
+}
+
+void __init os_init_smp(void)
+{
+	struct sigaction action = {
+		.sa_sigaction = ipi_sig_handler,
+		.sa_flags = SA_SIGINFO | SA_ONSTACK | SA_RESTART,
+	};
+
+	if (sigaction(IPI_SIGNAL, &action, NULL) < 0)
+		panic("%s: sigaction failed, errno = %d", __func__, errno);
+
+	cpu_threads[0] = pthread_self();
+}
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index a827c2e01aa5..61c61e9c246c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -22,6 +22,7 @@
 #include <asm/unistd.h>
 #include <init.h>
 #include <os.h>
+#include <smp.h>
 #include <kern_util.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
@@ -481,6 +482,9 @@ void __init os_early_checks(void)
 			fatal("SECCOMP userspace requested but not functional!\n");
 	}
 
+	if (uml_ncpus > 1)
+		fatal("SMP is not supported with PTRACE userspace.\n");
+
 	using_seccomp = 0;
 	check_ptrace();
 
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index e38b6f84287b..4b49380eeff5 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -14,7 +14,9 @@
 #include <sys/time.h>
 #include <kern_util.h>
 #include <os.h>
+#include <smp.h>
 #include <string.h>
+#include "internal.h"
 
 static timer_t event_high_res_timer[CONFIG_NR_CPUS] = { 0 };
 
@@ -40,7 +42,8 @@ long long os_persistent_clock_emulation(void)
  */
 int os_timer_create(void)
 {
-	timer_t *t = &event_high_res_timer[0];
+	int cpu = uml_curr_cpu();
+	timer_t *t = &event_high_res_timer[cpu];
 	struct sigevent sev = {
 		.sigev_notify = SIGEV_THREAD_ID,
 		.sigev_signo = SIGALRM,
@@ -110,9 +113,13 @@ void os_idle_sleep(void)
 {
 	sigset_t set, old;
 
-	/* Block SIGALRM while performing the need_resched check. */
+	/*
+	 * Block SIGALRM and the IPI signal while performing
+	 * the need_resched check.
+	 */
 	sigemptyset(&set);
 	sigaddset(&set, SIGALRM);
+	sigaddset(&set, IPI_SIGNAL);
 	sigprocmask(SIG_BLOCK, &set, &old);
 
 	/* Sleep if no resched is pending. */
-- 
2.34.1


