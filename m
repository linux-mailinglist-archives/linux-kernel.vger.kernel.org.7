Return-Path: <linux-kernel+bounces-767820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8CCB25982
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBAE1B6717A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDA257AEE;
	Thu, 14 Aug 2025 02:28:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87AA1EB195
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138517; cv=none; b=YNXG0jfdyeYsFUatpfWSsUBee+Q76WR6f6J1LU1zPxIObsdgIBG5uvh8V6FT2D8q4+L3mvUc29SMG6KvCXqQbnJ1XD4viSiLB3QG0FcAt66WH0MBwiQ/RvtcD2rm0MHb7lZgk4/JLx+IdNJptzrPfho70kuT2oEFq3Hgpj9YCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138517; c=relaxed/simple;
	bh=ikqHFmnyith9tdcpeJccTEEfJxKQm7i4cmgUo35wwn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gJA3kwBGGQShNVBkzZXjDmcdV0uR8uZqtF53CJ5QgD+QMk3gKAh7BVtAaOxCbrDafskZc0D/7S9xREeLe6uahtI6rNn1mvob2bgFd6esVLPPcKQGsd4aMcApm6p0kvMP7Hx6BPzxbpt3zMQ+6SYLGPc7v7KXvY3askavRI4AQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxSWrGSZ1ocJU_AQ--.20155S3;
	Thu, 14 Aug 2025 10:28:22 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxM+TFSZ1oOWNKAA--.20901S4;
	Thu, 14 Aug 2025 10:28:22 +0800 (CST)
From: Kanglong Wang <wangkanglong@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: module: Optimize module load time by optimizing PLT/GOT counting
Date: Thu, 14 Aug 2025 10:28:10 +0800
Message-Id: <20250814022810.2917-1-wangkanglong@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+TFSZ1oOWNKAA--.20901S4
X-CM-SenderInfo: 5zdqwyxdqjz0tqj6z05rqj20fqof0/1tbiAgEOAmicKQgR0gAAsZ
X-Coremail-Antispam: 1Uk129KBj93XoWxtr15WF1xtF47WF48CF4DGFX_yoW7XF4xpF
	W3Cr4rGr48JFn8Wa18A3WDuFs8W3sruF42qF4fKw17Aw1xXr10vF4ktr1rAFW3JrZ5AFy5
	WFyjgw1ftF4UZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==

When enabling CONFIG_KASAN, CONFIG_PREEMPT_VOLUNTARY_BUILD and
CONFIG_PREEMPT_VOLUNTARY at the same time, there will be soft deadlock,
the relevant logs are as follows:

rcu: INFO: rcu_sched self-detected stall on CPU
...
Call Trace:
[<900000000024f9e4>] show_stack+0x5c/0x180
[<90000000002482f4>] dump_stack_lvl+0x94/0xbc
[<9000000000224544>] rcu_dump_cpu_stacks+0x1fc/0x280
[<900000000037ac80>] rcu_sched_clock_irq+0x720/0xf88
[<9000000000396c34>] update_process_times+0xb4/0x150
[<90000000003b2474>] tick_nohz_handler+0xf4/0x250
[<9000000000397e28>] __hrtimer_run_queues+0x1d0/0x428
[<9000000000399b2c>] hrtimer_interrupt+0x214/0x538
[<9000000000253634>] constant_timer_interrupt+0x64/0x80
[<9000000000349938>] __handle_irq_event_percpu+0x78/0x1a0
[<9000000000349a78>] handle_irq_event_percpu+0x18/0x88
[<9000000000354c00>] handle_percpu_irq+0x90/0xf0
[<9000000000348c74>] handle_irq_desc+0x94/0xb8
[<9000000001012b28>] handle_cpu_irq+0x68/0xa0
[<9000000001def8c0>] handle_loongarch_irq+0x30/0x48
[<9000000001def958>] do_vint+0x80/0xd0
[<9000000000268a0c>] kasan_mem_to_shadow.part.0+0x2c/0x2a0
[<90000000006344f4>] __asan_load8+0x4c/0x120
[<900000000025c0d0>] module_frob_arch_sections+0x5c8/0x6b8
[<90000000003895f0>] load_module+0x9e0/0x2958
[<900000000038b770>] __do_sys_init_module+0x208/0x2d0
[<9000000001df0c34>] do_syscall+0x94/0x190
[<900000000024d6fc>] handle_syscall+0xbc/0x158

After analysis, because the slow speed of loading the amdgpu module
leads to the long time occupation of the cpu and the soft deadlock.

When loading a module, module_frob_arch_sections() tries to figure out
the number of PLTs/GOTs that'll be needed to handle all the RELAs. It
will call the count_max_entries() to find in an out-of-order date which
counting algorithm has O(n^2) complexity.

To make faster, it sorts the relocation list by info and addend. That
way, to check for a duplicate relocation, it just needs to compare with
the previous entry. This reduces the complexity of the algorithm to O(n
 log n), as done in commit d4e0340919fb ("arm64/module: Optimize module
load time by optimizing PLT counting"). This gives sinificant reduction
in module load time for modules with large number of relocations.

After applying this patch, the soft deadlock problem has been solved,
and the kernel starts normally without "Call Trace".

Using the default configuration to test some modules, the results are as
follows:

Module              Size
ip_tables           36K
fat                 143K
radeon              2.5MB
amdgpu              16MB

Without this patch:
Module              Module load time (ms)	Count(PLTs/GOTs)
ip_tables           18				59/6
fat                 0				162/14
radeon              54				1221/84
amdgpu              1411			4525/1098

With this patch:
Module              Module load time (ms)	Count(PLTs/GOTs)
ip_tables           18				59/6
fat                 0				162/14
radeon              22				1221/84
amdgpu              45				4525/1098

Fixes: fcdfe9d22bed ("LoongArch: Add ELF and module support")
Signed-off-by: Kanglong Wang <wangkanglong@loongson.cn>
---
 arch/loongarch/kernel/module-sections.c | 34 ++++++++++++-------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index e2f30ff9afde..3b22b3c1af28 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/ftrace.h>
+#include <linux/sort.h>
 
 Elf_Addr module_emit_got_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr val)
 {
@@ -61,39 +62,36 @@ Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr v
 	return (Elf_Addr)&plt[nr];
 }
 
-static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
-{
-	return x->r_info == y->r_info && x->r_addend == y->r_addend;
-}
+#define cmp_3way(a, b)  ((a) < (b) ? -1 : (a) > (b))
 
-static bool duplicate_rela(const Elf_Rela *rela, int idx)
+static int compare_rela(const void *x, const void *y)
 {
-	int i;
+	int ret;
+	const Elf_Rela *rela_x = x, *rela_y = y;
 
-	for (i = 0; i < idx; i++) {
-		if (is_rela_equal(&rela[i], &rela[idx]))
-			return true;
-	}
+	ret = cmp_3way(rela_x->r_info, rela_y->r_info);
+	if (ret == 0)
+		ret = cmp_3way(rela_x->r_addend, rela_y->r_addend);
 
-	return false;
+	return ret;
 }
 
 static void count_max_entries(Elf_Rela *relas, int num,
 			      unsigned int *plts, unsigned int *gots)
 {
-	unsigned int i, type;
+	unsigned int i;
 
+	sort(relas, num, sizeof(Elf_Rela), compare_rela, NULL);
 	for (i = 0; i < num; i++) {
-		type = ELF_R_TYPE(relas[i].r_info);
-		switch (type) {
+		if (i > 0 && compare_rela(&relas[i-1], &relas[i]) == 0)
+			continue;
+		switch (ELF_R_TYPE(relas[i].r_info)) {
 		case R_LARCH_SOP_PUSH_PLT_PCREL:
 		case R_LARCH_B26:
-			if (!duplicate_rela(relas, i))
-				(*plts)++;
+			(*plts)++;
 			break;
 		case R_LARCH_GOT_PC_HI20:
-			if (!duplicate_rela(relas, i))
-				(*gots)++;
+			(*gots)++;
 			break;
 		default:
 			break; /* Do nothing. */
-- 
2.20.1


