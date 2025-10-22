Return-Path: <linux-kernel+bounces-864331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC29BFA888
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD7774E9EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EB2F6196;
	Wed, 22 Oct 2025 07:26:35 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813362EF65A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117995; cv=none; b=RMaJcIQlEeKDx2QWR5k9lEEPo05HL4BFwwbVg68IwZvj9/o73xnEJbJMvtkR+4/SQOWPWXt/cawjSa5nB5oVYE6eI3XwVsZojAUhmETTX71707z9gyyVm+EuNZP6Oe6SefcNedefuYcph9zB7h/fbP4i0XYOeJYOUEutTF4a8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117995; c=relaxed/simple;
	bh=BWATRJeprbI/wzXVFYDswfA72j+hIQw/rKOPmKNtgkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXF0nUpzbVudlYf3EBmLlYezohQ+XrLRVVjO4kkpkOYfALQuj+xAbDlSbacoJ5Ww3qpOtJ3SHkukDdTol/ln589Z1c+Bn01oasRSA9Ark1T9BKZK4ZyC9l8wW6ewnTr1Zf0vY3MVdIlzAl/G0CQKjy/8VY3BHJcGCDBPNKv4sqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowADnihQWh_ho49jPEw--.25078S2;
	Wed, 22 Oct 2025 15:26:15 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] riscv: stacktrace: Disable KASAN checks for non-current tasks
Date: Wed, 22 Oct 2025 15:26:08 +0800
Message-Id: <20251022072608.743484-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnihQWh_ho49jPEw--.25078S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4fWF13Cw4rWryftr4rGrg_yoW8ZFyrpF
	Z3Kas3Xrs5Kr4Ik3ZIqr1rWryrJrZ3K347trZrX34rArsxtryYqry0gay5Jr4UZryqqa4a
	9FZ0yrnFkan8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1D
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4CJPDUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwsDB2j4YrGF4wAAst

Unwinding the stack of a task other than current, KASAN would report
"BUG: KASAN: out-of-bounds in walk_stackframe+0x41c/0x460"

There is a same issue on x86 and has been resolved by the commit 84936118bdf3
("x86/unwind: Disable KASAN checks for non-current tasks")
The solution could be applied to RISC-V too.

This patch also can solve the issue: https://seclists.org/oss-sec/2025/q4/23

Fixes: 5d8544e2d007 ("RISC-V: Generic library routines and assembly")
Co-developed-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 arch/riscv/kernel/stacktrace.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 3fe9e6edef8f..ad1e43dbf7af 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,6 +16,21 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
+/*
+ * This disables KASAN checking when reading a value from another task's stack,
+ * since the other task could be running on another CPU and could have poisoned
+ * the stack in the meantime.
+ */
+#define READ_ONCE_TASK_STACK(task, x)			\
+({							\
+	unsigned long val;				\
+	if (task == current)				\
+		val = READ_ONCE(x);			\
+	else						\
+		val = READ_ONCE_NOCHECK(x);		\
+	val;						\
+})
+
 extern asmlinkage void handle_exception(void);
 extern unsigned long ret_from_exception_end;
 
@@ -69,8 +84,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->ra;
 			pc = regs->ra;
 		} else {
-			fp = frame->fp;
-			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
+			fp = READ_ONCE_TASK_STACK(task, frame->fp);
+			pc = READ_ONCE_TASK_STACK(task, frame->ra);
+			pc = ftrace_graph_ret_addr(current, &graph_idx, pc,
 						   &frame->ra);
 			if (pc >= (unsigned long)handle_exception &&
 			    pc < (unsigned long)&ret_from_exception_end) {
-- 
2.34.1


