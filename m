Return-Path: <linux-kernel+bounces-856493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDA0BE4519
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADFBF4EB8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1D34DCF4;
	Thu, 16 Oct 2025 15:45:57 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206121F91E3
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629556; cv=none; b=VUjS7ENwyfDhkziC76ZWCGtXZCXl1He+EArrSVpYipxWrpNvsWxDtOzlh1tjY3VOh1tP4J+8fCA+Pv8CGWWSEJzFWdaTtXBWizHysNqVUgJlFla0mBdM8cU6Uf8FUkMbUE52KQcDsiOkI0JIRcqaDrHzwDoFb/DlkyXScGYx+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629556; c=relaxed/simple;
	bh=c3ekHxUxcfAall2QGhItOG5oe4aKXyz4LshibRVXomU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwKTIcuMuNYxY2Ow5H/oEIA9JwBgszjtO+bpBgHbMvPZmTukvnZfsSu9S0hwJtgxP7fcCs02TTh77ObiOxNFu7HmwpIy9svJjJg+wDZZx0cfYJ4DkjxTNo0D0Ewpv94NNhYtYd9ZnS+lY/k4AtcOAs/JnEG6IwYF5Ok3buZyCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.. (unknown [49.214.10.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id C9EDB32A79;
	Thu, 16 Oct 2025 23:45:49 +0800 (CST)
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
Subject: [PATCH v3 1/1] arm64: ptrace: fix hw_break_set() to set addr and ctrl together
Date: Thu, 16 Oct 2025 23:44:01 +0800
Message-ID: <20251016154401.35799-2-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016154401.35799-1-b10902118@ntu.edu.tw>
References: <20250827014113.5852-1-b10902118@ntu.edu.tw>
 <20251016154401.35799-1-b10902118@ntu.edu.tw>
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

For reference, the check is in
	arch/arm64/kernel/hw_breakpoint.c:hw_breakpoint_arch_parse()
which is called via:
	modify_user_hw_breakpoint()
	-> modify_user_hw_breakpoint_check()
	-> hw_breakpoint_parse()
	-> hw_breakpoint_arch_parse()

Signed-off-by: Bill Tsui <b10902118@ntu.edu.tw>
---
 arch/arm64/kernel/ptrace.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4b001121c..8963f40ba 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -467,6 +467,34 @@ static int ptrace_hbp_set_addr(unsigned int note_type,
 	return err;
 }
 
+/* Set the address and control together for non-compat ptrace */
+static int ptrace_hbp_set(unsigned int note_type,
+				   struct task_struct *tsk,
+				   unsigned long idx,
+				   u64 addr, u32 uctrl)
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
+	attr.bp_addr = addr;
+
+	decode_ctrl_reg(uctrl, &ctrl);
+	err = ptrace_hbp_fill_attr_ctrl(note_type, ctrl, &attr);
+	if (err)
+		return err;
+
+	return modify_user_hw_breakpoint(bp, &attr);
+}
+
 #define PTRACE_HBP_ADDR_SZ	sizeof(u64)
 #define PTRACE_HBP_CTRL_SZ	sizeof(u32)
 #define PTRACE_HBP_PAD_SZ	sizeof(u32)
@@ -524,9 +552,6 @@ static int hw_break_set(struct task_struct *target,
 			return -EINVAL;
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
 					 offset, offset + PTRACE_HBP_ADDR_SZ);
-		if (ret)
-			return ret;
-		ret = ptrace_hbp_set_addr(note_type, target, idx, addr);
 		if (ret)
 			return ret;
 		offset += PTRACE_HBP_ADDR_SZ;
@@ -537,10 +562,11 @@ static int hw_break_set(struct task_struct *target,
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
-- 
2.51.0


