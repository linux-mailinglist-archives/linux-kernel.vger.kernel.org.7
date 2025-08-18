Return-Path: <linux-kernel+bounces-773645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F4B2A415
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85A256652F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6131E100;
	Mon, 18 Aug 2025 13:07:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134330F7F8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522450; cv=none; b=H21oqrdUdn9fiXOBkQAph+ejLyo5baiKdXArgQtdMOo5bevtr8T7euiTw6Ve0pW99BuA2EEi4o3csq6vpn69Bl+BzA03cGtIaCTqRABcbg0dmoFzY5ig3Aff8rn+k+G3HFETeT7yRdjYeVyV/ZGRiF317GswBvyDy/RW2eK7N7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522450; c=relaxed/simple;
	bh=0zSBC2vvJdjkdCmI+qUeUA655YfIG82HLcSocUu/R8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5iF2+xl9AD5Pb3JfXy8N/pgD23auyWVOvGR6WAAKtHauSJGZkgXTOJeoumYpen79WC9vnAaTbvuQOSwWIECU8GbUz/2kC8759tUzwCuiCuhyQEIQTLEZbKy5MhWCZXmEZv/BI5hzRVetc8AX5zF1EBT6V6QvB7dFVKEY82QYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c5Cg15ZkTzKHMd7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:07:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2D78D1A018D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:07:25 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgCXExSFJaNoH6prEA--.57527S2;
	Mon, 18 Aug 2025 21:07:23 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: x86@kernel.org
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next] x86: Prevent KASAN false positive warnings in __show_regs()
Date: Mon, 18 Aug 2025 13:07:15 +0000
Message-Id: <20250818130715.2904264-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExSFJaNoH6prEA--.57527S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZry7Xr4DWF4kGF4DtF1xAFb_yoWrury7pF
	srAw1kXFWrC3s8ZFW7AF48X3sxuF4DWwn2yrZ3Jr1avFn09r1fJa13CF1jvryfJr98C345
	Jayqqw1qyFyfCaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When process A accesses process B's `regs` from stack memory through
__show_regs(), the stack of process B keeps changing during runtime.
This causes false positives like "stack out-of-bounds" [1] or
"out-of-bounds" [2] warnings when reading `regs` contents.

Add __no_sanitize_address attribute to __show_regs() to suppress these
false positives while maintaining the ability to debug register states
across processes.

[1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
[2] A similar KASAN report:
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
 arch/x86/include/asm/kdebug.h | 2 +-
 arch/x86/kernel/process_32.c  | 1 +
 arch/x86/kernel/process_64.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index d1514e70477b..2e0570d75bbc 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -36,7 +36,7 @@ extern void die(const char *, struct pt_regs *,long);
 void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
-extern void __show_regs(struct pt_regs *regs, enum show_regs_mode,
+extern void __no_sanitize_address __show_regs(struct pt_regs *regs, enum show_regs_mode,
 			const char *log_lvl);
 extern void show_iret_regs(struct pt_regs *regs, const char *log_lvl);
 extern unsigned long oops_begin(void);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 3ef15c2f152f..1b7ed4dee18b 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -56,6 +56,7 @@
 
 #include "process.h"
 
+__no_sanitize_address
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		 const char *log_lvl)
 {
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 52a5c03c353c..921c96154ce3 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -66,6 +66,7 @@
 #include "process.h"
 
 /* Prints also some state that isn't saved in the pt_regs */
+__no_sanitize_address
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		 const char *log_lvl)
 {
-- 
2.34.1


