Return-Path: <linux-kernel+bounces-876571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848AC1C1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2B5C03B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3E34C142;
	Wed, 29 Oct 2025 15:45:04 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBA34AB1F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752704; cv=none; b=kA3ESgIqK5uo2p30jVDK0qQ6BPGKzQ4/eJg14SVX6U7DthtggNLymQuF7MmAnwiOd+dhzgjrNhe21NXW/ChxYhRi/E2nDrhC9WmLvQ+oL/H7zddJxaDGMOTxR90SOPhFkul2yeq0TGbXCVfHF2bujkhHsRMtnL4QpaYgCtlYJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752704; c=relaxed/simple;
	bh=LUKhmCcDHmOd1ZUPv07YQs7L48f4jaD6YukQ1MvBL60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B73DqpPYSC1w4W+hzHpM4vm1NrENSkPOb2U/g4mAhkGh8HlJhrbmkajNRC/UokT/CITxAB4FL4c5YMM7j674xBxqRxIWv8y56q2B67pyHfWzEk1qh2QpSdKeFrSb0ibEHGEf3l/2Cab+aRZ47385xEGhhTeltv3HbkO+hKdm5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.. (unknown [101.10.245.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 8DBD8CE7F;
	Wed, 29 Oct 2025 23:38:02 +0800 (CST)
From: Bill Tsui <b10902118@ntu.edu.tw>
To: chenhuacai@kernel.org,
	oleg@redhat.com
Cc: kernel@xen0n.name,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bill Tsui <b10902118@ntu.edu.tw>
Subject: [PATCH] LoongArch: ptrace: Merge ptrace_hbp_set_*()
Date: Wed, 29 Oct 2025 23:36:49 +0800
Message-ID: <20251029153649.33345-1-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hw_break_set(), those functions actually can be combined into one.
This eliminates intermediate calls to modify_user_hw_breakpoint() that
may leave hardware registers in a partially updated state.

This redundancy was originally found in ARM ptrace, where it caused
non-4-byte address alignment checks to fail.

Link:
https://lore.kernel.org/all/20251018133731.42505-2-b10902118@ntu.edu.tw/

The LoongArch implementation appears to have been derived from ARM,
so this refactor helps avoid the same issue and simplifies future
maintenance.

Signed-off-by: Bill Tsui <b10902118@ntu.edu.tw>
---
 arch/loongarch/kernel/ptrace.c | 69 +++++++++-------------------------
 1 file changed, 17 insertions(+), 52 deletions(-)

diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index 8edd0954e55a..c6cd51569a64 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -581,13 +581,15 @@ static int ptrace_hbp_get_addr(unsigned int note_type,
 	return 0;
 }
 
-static int ptrace_hbp_set_ctrl(unsigned int note_type,
+static int ptrace_hbp_set(unsigned int note_type,
 			       struct task_struct *tsk,
-			       unsigned long idx, u32 uctrl)
+			       unsigned long idx, u64 addr,
+				   u64 mask, u32 uctrl)
 {
 	int err;
 	struct perf_event *bp;
 	struct perf_event_attr attr;
+	struct arch_hw_breakpoint *info;
 	struct arch_hw_breakpoint_ctrl ctrl;
 	struct thread_info *ti = task_thread_info(tsk);
 
@@ -597,6 +599,17 @@ static int ptrace_hbp_set_ctrl(unsigned int note_type,
 
 	attr = bp->attr;
 
+	/* addr */
+	/* Kernel-space address cannot be monitored by user-space */
+	if ((unsigned long)addr >= XKPRANGE)
+		return -EINVAL;
+	attr.bp_addr = addr;
+
+	/* mask */
+	info = counter_arch_bp(bp);
+	info->mask = mask;
+
+	/* ctrl */
 	switch (note_type) {
 	case NT_LOONGARCH_HW_BREAK:
 		ctrl.type = LOONGARCH_BREAKPOINT_EXECUTE;
@@ -623,46 +636,6 @@ static int ptrace_hbp_set_ctrl(unsigned int note_type,
 	return modify_user_hw_breakpoint(bp, &attr);
 }
 
-static int ptrace_hbp_set_mask(unsigned int note_type,
-			       struct task_struct *tsk,
-			       unsigned long idx, u64 mask)
-{
-	struct perf_event *bp;
-	struct perf_event_attr attr;
-	struct arch_hw_breakpoint *info;
-
-	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
-	if (IS_ERR(bp))
-		return PTR_ERR(bp);
-
-	attr = bp->attr;
-	info = counter_arch_bp(bp);
-	info->mask = mask;
-
-	return modify_user_hw_breakpoint(bp, &attr);
-}
-
-static int ptrace_hbp_set_addr(unsigned int note_type,
-			       struct task_struct *tsk,
-			       unsigned long idx, u64 addr)
-{
-	struct perf_event *bp;
-	struct perf_event_attr attr;
-
-	/* Kernel-space address cannot be monitored by user-space */
-	if ((unsigned long)addr >= XKPRANGE)
-		return -EINVAL;
-
-	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
-	if (IS_ERR(bp))
-		return PTR_ERR(bp);
-
-	attr = bp->attr;
-	attr.bp_addr = addr;
-
-	return modify_user_hw_breakpoint(bp, &attr);
-}
-
 #define PTRACE_HBP_ADDR_SZ	sizeof(u64)
 #define PTRACE_HBP_MASK_SZ	sizeof(u64)
 #define PTRACE_HBP_CTRL_SZ	sizeof(u32)
@@ -733,10 +706,6 @@ static int hw_break_set(struct task_struct *target,
 					 offset, offset + PTRACE_HBP_ADDR_SZ);
 		if (ret)
 			return ret;
-
-		ret = ptrace_hbp_set_addr(note_type, target, idx, addr);
-		if (ret)
-			return ret;
 		offset += PTRACE_HBP_ADDR_SZ;
 
 		if (!count)
@@ -746,21 +715,17 @@ static int hw_break_set(struct task_struct *target,
 					 offset, offset + PTRACE_HBP_MASK_SZ);
 		if (ret)
 			return ret;
-
-		ret = ptrace_hbp_set_mask(note_type, target, idx, mask);
-		if (ret)
-			return ret;
 		offset += PTRACE_HBP_MASK_SZ;
 
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl,
 					 offset, offset + PTRACE_HBP_CTRL_SZ);
 		if (ret)
 			return ret;
+		offset += PTRACE_HBP_CTRL_SZ;
 
-		ret = ptrace_hbp_set_ctrl(note_type, target, idx, ctrl);
+		ret = ptrace_hbp_set(note_type, target, idx, addr, mask, ctrl);
 		if (ret)
 			return ret;
-		offset += PTRACE_HBP_CTRL_SZ;
 
 		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
 					  offset, offset + PTRACE_HBP_PAD_SZ);
-- 
2.51.0


