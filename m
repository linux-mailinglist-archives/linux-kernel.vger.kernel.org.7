Return-Path: <linux-kernel+bounces-791509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F7B3B7A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697A33B222E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250F5304BB5;
	Fri, 29 Aug 2025 09:48:21 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB833985
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460900; cv=none; b=GJIJQD1t9TK88HlHeTK9BA4CzbBZMNdsHbRLKIzZPyDnDRKky0sroWWVRCk2Z2ZUexrVoD9v6egQgNk2rM7G7kc32jGeQLdbNloKGb7um3cwJDJmnxS2s8xH6230FaUlMYfXaS2PfAi7+bkekgJ1elRWSPzxMJMO6aKGOEi6S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460900; c=relaxed/simple;
	bh=Wr3MtQQ0eSoLp1yMUlPh8bE0C8iqfoELjTmBz+OJLcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOgxaMWnJvjg172vndkU+1UbLNWxmKex4FLUEkuvbl1P9B0/Sy2gIdfy26QqrBdumUgroceVRDufYjJ8qbAHZfC1kk73T9SEr6kFxnbuX4/uTqsiMIgHWiU+ORaNJklakag7GMz9RwNKEBBcMK7jH29tpYJ1R47+ffXTf4HyedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCtk74S0JzKHN7S
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:48:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 563241A0879
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:48:15 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgDHXotXd7FoJJe9Ag--.3597S2;
	Fri, 29 Aug 2025 17:48:13 +0800 (CST)
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
Subject: [PATCH -next v2] x86: Prevent KASAN false positive warnings in __show_regs
Date: Fri, 29 Aug 2025 09:47:44 +0000
Message-Id: <20250829094744.3133324-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHXotXd7FoJJe9Ag--.3597S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF13Wry3Kw45ZF4xXF17trb_yoWruF1xpF
	s3tasYqF4Yy34FqF42yF48X3s8XF4qqryv9rs3Gr15JFn8Xr18Ja1rCF1jvFyfCry7Ca45
	Ja1qqw1qk34fCa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

When task A walks task B's stack without suspending it, the continuous
changes in task B's stack (and corresponding KASAN shadow tags) may cause
task A to hit KASAN redzones when accessing obsolete `regs->` contents,
resulting in false positive reports. [1][2]

The specific issue occurs as follows:

Task A (walk other task's stack)            Task B (running)
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
checking whether the `regs` are located in the current task's stack
during unwinding, and disabling KASAN checks when this scenario occurs.

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
v2: Use kasan_disable_current() instead of __no_sanitize_address.
v1: https://lore.kernel.org/all/20250818130715.2904264-1-wutengda@huaweicloud.com/

 arch/x86/kernel/dumpstack.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 71ee20102a8a..5413534de490 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -152,6 +152,18 @@ void show_iret_regs(struct pt_regs *regs, const char *log_lvl)
 static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 				  bool partial, const char *log_lvl)
 {
+	bool kasan_disabled = false;
+
+	/*
+	 * When 'regs' resides in another task's stack space, KASAN should be
+	 * disabled to prevent false positives during 'regs->' operation, as
+	 * the 'regs' contents may change concurrently with task execution.
+	 */
+	if (!object_is_on_stack(regs)) {
+		kasan_disable_current();
+		kasan_disabled = true;
+	}
+
 	/*
 	 * These on_stack() checks aren't strictly necessary: the unwind code
 	 * has already validated the 'regs' pointer.  The checks are done for
@@ -173,6 +185,9 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 		 */
 		show_iret_regs(regs, log_lvl);
 	}
+
+	if (kasan_disabled)
+		kasan_enable_current();
 }
 
 /*
-- 
2.34.1


