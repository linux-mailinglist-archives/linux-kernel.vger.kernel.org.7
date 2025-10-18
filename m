Return-Path: <linux-kernel+bounces-859218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B355BED09A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC25E2573
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D7F2D837B;
	Sat, 18 Oct 2025 13:38:20 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B71D9A54
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760794700; cv=none; b=R9gK+k4Pg3J8EANem9HBjGCLmOUwCebbXQ28ONdilWJI/zLX5n6CzsUnhfM7/PZOkkuopZF1gPPAUfc/7ZjEvYwkwKeqyci80m+xKVDjL5ED0zZFzcq4uQyraiEwB+R82tXGt3IN49nsVsArJm02flYzNyx0Z2HGh6w2GitvEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760794700; c=relaxed/simple;
	bh=MoKzB1vv5bboPLAXL+wOillAA6bpS7SYdS28c/mlde4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+9ONree7+1/vwqB+lUvJ7O7WhVn0fpdYgIwteiwVA6jslS4v9hkIRVJd4BX7Nd6yHHlDURHPlrrilFzZccpuFxbhBpwnXFJLwZ9pxIqGkJrLoKhwjglywMuOTks1d/YAxgvtyrZ+9KgIA6vJVwrz16wkYiAB0lwWqfv19nPVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.. (unknown [101.14.4.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 8B5EE34F4C;
	Sat, 18 Oct 2025 21:38:07 +0800 (CST)
From: Bill Tsui <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Tsui <b10902118@ntu.edu.tw>
Subject: [PATCH v4 1/1] arm64: ptrace: fix hw_break_set() to set addr and ctrl together
Date: Sat, 18 Oct 2025 21:37:31 +0800
Message-ID: <20251018133731.42505-2-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251018133731.42505-1-b10902118@ntu.edu.tw>
References: <20251016154401.35799-1-b10902118@ntu.edu.tw>
 <20251018133731.42505-1-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the failure of PTRACE_SETREGSET when setting a hardware
breakpoint on a non-4-byte aligned address with a valid control to a
32-bit tracee. The issue was discovered while testing LLDB.

Link: https://github.com/llvm/llvm-project/pull/152284

The failure happens because hw_break_set() checks and sets the breakpoint
address and control separately. This can result in an check failure when
it first validates the address to be set with old control.

For example, the control are initialized with breakpoint length of 4.
Combining with a non-4-byte aligned address would cross a 4-byte boundary,
which is invalid. However, the user-provided control may actually specify a
length of 1, which should be valid.

The fix is to set the address and control together. This is supported
by modify_user_hw_breakpoint(), the function that sets and checks
breakpoints. The original implementation wrap this function to
ptrace_hbp_set_addr() and ptrace_hbp_set_ctrl() for 32-bit API
PTRACE_SETHBPREGS simply because it can only modify one register (address
or control) per call. For the 64-bit PTRACE_SETREGSET API, this
restriction does not apply, so a new helper function ptrace_hbp_set() was
added to set both in a single call to modify_user_hw_breakpoint().

Then ptrace_hbp_set_addr() and ptrace_hbp_set_ctrl() are only used by
compat_ptrace_hbp_set(), so moved into CONFIG_COMPAT block and renamed
with prefix compat_.

For reference, the check is in
	arch/arm64/kernel/hw_breakpoint.c:hw_breakpoint_arch_parse()
which is called via:
	modify_user_hw_breakpoint()
	-> modify_user_hw_breakpoint_check()
	-> hw_breakpoint_parse()
	-> hw_breakpoint_arch_parse()

Signed-off-by: Bill Tsui <b10902118@ntu.edu.tw>
---
 arch/arm64/kernel/ptrace.c | 90 ++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4b001121c72d..c8caf4e0805e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -421,10 +421,11 @@ static struct perf_event *ptrace_hbp_get_initialised_bp(unsigned int note_type,
 	return bp;
 }
 
-static int ptrace_hbp_set_ctrl(unsigned int note_type,
-			       struct task_struct *tsk,
-			       unsigned long idx,
-			       u32 uctrl)
+/* Set the address and control together for non-compat ptrace */
+static int ptrace_hbp_set(unsigned int note_type,
+				   struct task_struct *tsk,
+				   unsigned long idx,
+				   u64 addr, u32 uctrl)
 {
 	int err;
 	struct perf_event *bp;
@@ -438,6 +439,8 @@ static int ptrace_hbp_set_ctrl(unsigned int note_type,
 	}
 
 	attr = bp->attr;
+	attr.bp_addr = addr;
+
 	decode_ctrl_reg(uctrl, &ctrl);
 	err = ptrace_hbp_fill_attr_ctrl(note_type, ctrl, &attr);
 	if (err)
@@ -446,27 +449,6 @@ static int ptrace_hbp_set_ctrl(unsigned int note_type,
 	return modify_user_hw_breakpoint(bp, &attr);
 }
 
-static int ptrace_hbp_set_addr(unsigned int note_type,
-			       struct task_struct *tsk,
-			       unsigned long idx,
-			       u64 addr)
-{
-	int err;
-	struct perf_event *bp;
-	struct perf_event_attr attr;
-
-	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
-	if (IS_ERR(bp)) {
-		err = PTR_ERR(bp);
-		return err;
-	}
-
-	attr = bp->attr;
-	attr.bp_addr = addr;
-	err = modify_user_hw_breakpoint(bp, &attr);
-	return err;
-}
-
 #define PTRACE_HBP_ADDR_SZ	sizeof(u64)
 #define PTRACE_HBP_CTRL_SZ	sizeof(u32)
 #define PTRACE_HBP_PAD_SZ	sizeof(u32)
@@ -524,9 +506,6 @@ static int hw_break_set(struct task_struct *target,
 			return -EINVAL;
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
 					 offset, offset + PTRACE_HBP_ADDR_SZ);
-		if (ret)
-			return ret;
-		ret = ptrace_hbp_set_addr(note_type, target, idx, addr);
 		if (ret)
 			return ret;
 		offset += PTRACE_HBP_ADDR_SZ;
@@ -537,10 +516,11 @@ static int hw_break_set(struct task_struct *target,
 					 offset, offset + PTRACE_HBP_CTRL_SZ);
 		if (ret)
 			return ret;
-		ret = ptrace_hbp_set_ctrl(note_type, target, idx, ctrl);
+		offset += PTRACE_HBP_CTRL_SZ;
+
+		ret = ptrace_hbp_set(note_type, target, idx, addr, ctrl);
 		if (ret)
 			return ret;
-		offset += PTRACE_HBP_CTRL_SZ;
 
 		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
 					  offset, offset + PTRACE_HBP_PAD_SZ);
@@ -2139,6 +2119,52 @@ static int compat_ptrace_hbp_get(unsigned int note_type,
 	return err;
 }
 
+static int compat_ptrace_hbp_set_ctrl(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u32 uctrl)
+{
+	int err;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	struct arch_hw_breakpoint_ctrl ctrl;
+
+	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
+	if (IS_ERR(bp)) {
+		err = PTR_ERR(bp);
+		return err;
+	}
+
+	attr = bp->attr;
+	decode_ctrl_reg(uctrl, &ctrl);
+	err = ptrace_hbp_fill_attr_ctrl(note_type, ctrl, &attr);
+	if (err)
+		return err;
+
+	return modify_user_hw_breakpoint(bp, &attr);
+}
+
+static int compat_ptrace_hbp_set_addr(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u64 addr)
+{
+	int err;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+
+	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
+	if (IS_ERR(bp)) {
+		err = PTR_ERR(bp);
+		return err;
+	}
+
+	attr = bp->attr;
+	attr.bp_addr = addr;
+	err = modify_user_hw_breakpoint(bp, &attr);
+	return err;
+}
+
 static int compat_ptrace_hbp_set(unsigned int note_type,
 				 struct task_struct *tsk,
 				 compat_long_t num,
@@ -2151,10 +2177,10 @@ static int compat_ptrace_hbp_set(unsigned int note_type,
 
 	if (num & 1) {
 		addr = *kdata;
-		err = ptrace_hbp_set_addr(note_type, tsk, idx, addr);
+		err = compat_ptrace_hbp_set_addr(note_type, tsk, idx, addr);
 	} else {
 		ctrl = *kdata;
-		err = ptrace_hbp_set_ctrl(note_type, tsk, idx, ctrl);
+		err = compat_ptrace_hbp_set_ctrl(note_type, tsk, idx, ctrl);
 	}
 
 	return err;
-- 
2.51.0


