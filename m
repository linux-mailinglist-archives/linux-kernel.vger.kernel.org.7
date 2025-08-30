Return-Path: <linux-kernel+bounces-792857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C8B3C9CA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB93BDD4B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BFD25D209;
	Sat, 30 Aug 2025 09:26:22 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB134A32
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756545982; cv=none; b=k/FwoiLVzxpj2WYVkxT1wUMNBoybA/QFsGFjC7fpG44AvfFFGRSgs/0yYKV/OMt3e9CKr4AWm1aHrozt9M71Bj1iEaTE0MUO+im1bxbEeWr9Uo6ZyicNgd21pHm/jYlxn582mUuI8dVOOchFkU+0Ft7GMyG09sPxG+Q25/ixuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756545982; c=relaxed/simple;
	bh=r8atrMbSguvMtcWwmzbiRD7TMAgS0pd2yAU69tmJjdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ne9NnHVp2Iy09lP/XbS80T0DrnEWP3N+ikYIasPE52iOhzujaWe7Fv30nwqJ7bnGyb2+JFxhxYSiVLwVZLBanSDt0adbzC/afaL3QQJsBfCI8W8+Y4Ht3DDfkhFOSoXpixyLTp8z6RbJHlSV4J+mN1I5Kj7z0sD7ez5eRatN8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cDVBB2XbDzKHLtY
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:26:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1FE961A0B60
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:26:10 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgCH0o6ow7Job8QsAw--.23574S2;
	Sat, 30 Aug 2025 17:26:07 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: x86@kernel.org,
	jpoimboe@kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive warnings in __show_regs
Date: Sat, 30 Aug 2025 09:25:56 +0000
Message-Id: <20250830092556.3360776-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH0o6ow7Job8QsAw--.23574S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF13Wry3Kw45Zw1rWr4xXrb_yoWrtF4xpF
	4ftasYqF4Yy34FqF42vF48W3sxZF4qqryvkrZ3Gr15AF1DXr18Ja1rAF1jvryfCryUCa43
	Ja1qqw1qk3yfCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When task A walks task B's stack without suspending it, the continuous
changes in task B's stack (and corresponding KASAN shadow tags) may cause
task A to hit KASAN redzones when accessing obsolete values on the stack,
resulting in false positive reports. [1][2]

The specific issue occurs as follows:

Task A (walk other tasks' stacks)           Task B (running)
1. echo t > /proc/sysrq-trigger

show_trace_log_lvl
  regs = unwind_get_entry_regs()
  show_regs_if_on_stack(regs)
                                            2. The stack data pointed by
                                               `regs` keeps changing, and
                                               so are the tags in its
                                               KASAN shadow region.
    __show_regs(regs)
      regs->ax, regs->bx, ...
        3. hit KASAN redzones, OOB

Fix this by detecting asynchronous stack unwinding scenarios through
`task != current` during unwinding, and disabling KASAN checks when this
scenario occurs.

[1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
[2] KASAN out-of-bounds:
[332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
[332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
[332706.552562]
[332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
[332706.552783] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
[332706.552906] Call Trace:
[332706.552998]  <TASK>
[332706.553089]  dump_stack_lvl+0x32/0x50
[332706.553193]  print_address_description.constprop.0+0x6b/0x3d0
[332706.553303]  print_report+0xbe/0x280
[332706.553409]  ? __virt_addr_valid+0xed/0x160
[332706.553512]  ? __show_regs+0x4b/0x340
[332706.553612]  kasan_report+0xa8/0xe0
[332706.553716]  ? __show_regs+0x4b/0x340
[332706.553816]  ? asm_exc_page_fault+0x22/0x30
[332706.553919]  __show_regs+0x4b/0x340
[332706.554021]  ? asm_exc_page_fault+0x22/0x30
[332706.554123]  show_trace_log_lvl+0x274/0x3b0
[332706.554229]  ? load_elf_binary+0xf6e/0x1610
[332706.554330]  ? rep_stos_alternative+0x40/0x80
[332706.554439]  sched_show_task+0x211/0x290
[332706.554544]  ? __pfx_sched_show_task+0x10/0x10
[332706.554648]  ? _find_next_bit+0x6/0xc0
[332706.554749]  ? _find_next_bit+0x37/0xc0
[332706.554852]  show_state_filter+0x72/0x130
[332706.554956]  sysrq_handle_showstate+0x7/0x10
[332706.555062]  __handle_sysrq+0x146/0x2d0
[332706.555165]  write_sysrq_trigger+0x2f/0x50
[332706.555270]  proc_reg_write+0xdd/0x140
[332706.555372]  vfs_write+0x1ff/0x5f0
[332706.555474]  ? __pfx_vfs_write+0x10/0x10
[332706.555576]  ? __pfx___handle_mm_fault+0x10/0x10
[332706.555682]  ? __fget_light+0x99/0xf0
[332706.555785]  ksys_write+0xb8/0x150
[332706.555887]  ? __pfx_ksys_write+0x10/0x10
[332706.555989]  ? ktime_get_coarse_real_ts64+0x4e/0x70
[332706.556094]  do_syscall_64+0x55/0x100
[332706.556196]  entry_SYSCALL_64_after_hwframe+0x78/0xe2

Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
v3: Address Josh comment, move kasan checks to show_trace_log_lvl, and
    controlled by task != current.
v2: https://lore.kernel.org/all/20250829094744.3133324-1-wutengda@huaweicloud.com/
v1: https://lore.kernel.org/all/20250818130715.2904264-1-wutengda@huaweicloud.com/
---
 arch/x86/kernel/dumpstack.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 71ee20102a8a..6d1ae0d77ffc 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -189,9 +189,20 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	unsigned long visit_mask = 0;
 	int graph_idx = 0;
 	bool partial = false;
+	bool kasan_disabled = false;
 
 	printk("%sCall Trace:\n", log_lvl);
 
+	/*
+	 * KASAN should be disabled during walking another task's stacks
+	 * to prevent false positives, as values on these stacks may change
+	 * concurrently with task execution.
+	 */
+	if (task && task != current) {
+		kasan_disable_current();
+		kasan_disabled = true;
+	}
+
 	unwind_start(&state, task, regs, stack);
 	stack = stack ?: get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
@@ -301,6 +312,9 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		if (stack_name)
 			printk("%s </%s>\n", log_lvl, stack_name);
 	}
+
+	if (kasan_disabled)
+		kasan_enable_current();
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp,
-- 
2.34.1


