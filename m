Return-Path: <linux-kernel+bounces-866572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B519BC001D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A38D3A5F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D66304989;
	Thu, 23 Oct 2025 09:07:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E6304962
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210419; cv=none; b=LjfetmiBvXReduryVsvp7BmD5I0qlvBy2OpjCnXVd4CoJXUlEmfkMGvDMDwMoGH/e6s7maaruCueDCa5vKJNRru8dG1GqkdEQXF391PNmjYQAhcNvg80nZEI0U5UEsCDw4BZUV1qG3iiJ8Wxc82RldawwovbaJpVhaRQde9uOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210419; c=relaxed/simple;
	bh=51I7FiCG7V8FCtoydmDwFx4LkEUZDt9pgGX+LfX0q0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NgH5TC1ktvVeDswtt0KSW2ihWm5vaOaYSMFDoehfxjAIjolJYmsmQ/Zz2ESROrOGafbvO1vffuntNEZrLh6ZLj9SYG26QLqwkCqD7yuTrsR1nckMvsdH4hPPhEHJkMMVtVRchNjD4btiTTvM2B0MmMxCmziKzulvTpdpE5mi3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4csgB53fnSzKHMf3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:06:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9BCC31A0D8B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:06:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with SMTP id Syh0CgBnCUIm8PloVMNQBQ--.5875S2;
	Thu, 23 Oct 2025 17:06:52 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	jpoimboe@kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next v4] x86/dumpstack: Prevent KASAN false positive warnings in __show_regs
Date: Thu, 23 Oct 2025 09:06:32 +0000
Message-Id: <20251023090632.269121-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnCUIm8PloVMNQBQ--.5875S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DZw45Gw4fZr4fXryDtrb_yoWrGr43pF
	ZakasFkr4jqFyvgF9Fkw4Du345Zr4kX34qyFs3Cw45tw1DAF1fJF1Iy3W7Zr1UGr9rWa4a
	yrZ0vrykGrs8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

When triggering a stack dump via sysrq (echo t > /proc/sysrq-trigger),
KASAN may report false-positive out-of-bounds access:

  BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
  Call Trace:
    dump_stack_lvl
    print_address_description.constprop.0
    print_report
    __show_regs
    show_trace_log_lvl
    sched_show_task
    show_state_filter
    sysrq_handle_showstate
    __handle_sysrq
    write_sysrq_trigger
    proc_reg_write
    vfs_write
    ksys_write
    do_syscall_64
    entry_SYSCALL_64_after_hwframe

The issue occurs as follows:

Task A (walk other tasks' stacks)           Task B (running)
1. echo t > /proc/sysrq-trigger
show_trace_log_lvl
  regs = unwind_get_entry_regs()
  show_regs_if_on_stack(regs)
                                            2. The stack value pointed by
                                               `regs` keeps changing, and
                                               so are the tags in its
                                               KASAN shadow region.
    __show_regs(regs)
      regs->ax, regs->bx, ...
        3. hit KASAN redzones, OOB

When task A walks task B's stack without suspending it, the continuous
changes in task B's stack (and corresponding KASAN shadow tags) may cause
task A to hit KASAN redzones when accessing obsolete values on the stack,
resulting in false positive reports.

Simply stopping the task before unwinding is not a viable fix, as it
would alter the state we intend to inspect. This is especially true for
diagnosing misbehaving tasks (e.g., in a hard lockup), where stopping
might fail or hide the root cause by changing the call stack.

Therefore, fix this by disabling KASAN checks during asynchronous stack
unwinding, which is identified when the unwinding task does not match the
current task (task != current).

Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
v4: Address Boris comments, introduce __show_trace_log_lvl and wrap it
    with kasan disable/enable, rewrite the commit message.
v3: https://lore.kernel.org/all/20250830092556.3360776-1-wutengda@huaweicloud.com/
v2: https://lore.kernel.org/all/20250829094744.3133324-1-wutengda@huaweicloud.com/
v1: https://lore.kernel.org/all/20250818130715.2904264-1-wutengda@huaweicloud.com/
---
 arch/x86/kernel/dumpstack.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 71ee20102a8a..516740fba207 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -181,7 +181,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
  * in false positive reports. Disable instrumentation to avoid those.
  */
 __no_kmsan_checks
-static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+static void __show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;
@@ -303,6 +303,25 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
+static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+			unsigned long *stack, const char *log_lvl)
+{
+	/*
+	 * Disable KASAN to avoid false positives during walking another
+	 * task's stacks, as values on these stacks may change concurrently
+	 * with task execution.
+	 */
+	bool disable_kasan = task && task != current;
+
+	if (disable_kasan)
+		kasan_disable_current();
+
+	__show_trace_log_lvl(task, regs, stack, log_lvl);
+
+	if (disable_kasan)
+		kasan_enable_current();
+}
+
 void show_stack(struct task_struct *task, unsigned long *sp,
 		       const char *loglvl)
 {
-- 
2.34.1


