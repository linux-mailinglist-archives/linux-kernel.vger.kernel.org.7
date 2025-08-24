Return-Path: <linux-kernel+bounces-783635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84868B32FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54922189EDFD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D902D9EDD;
	Sun, 24 Aug 2025 12:50:04 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9603264F85
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039804; cv=none; b=CMbyxMg6MzhOsBQ9IyH4stG3i7HtPx1iJlqxuUfByDV0z7pk4WUU7oqstwXpdZL59EJl0p2M5+aHTne91qXtSGnSNwrIzc6e5VDFyODI2p0g/skbKVTJSglEUW5rBMU+JKkpxjrTb0/U8gy+8gTeR2BmJ/+VUrMkOu/wgpZRRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039804; c=relaxed/simple;
	bh=HUVpZAGjPziVrLOqrz+HXqAWKsDBSguYr4mqqUs+oW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efvXJ2C61M4UXLS4hUHN6PNll3biTLGAifk0d39otYAnMIoWw/8Na+wtkrgLB+Fxgl6t21HG0ZfQs8aCeXWHW/CDv1ImyF9e/+qpYCS2sa9w39U+4EUJwit27sg0oxV1xF7kzZPZbCfqhXWFUcJMyM4F3vhoQhxqtyNt9r5nalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.vlan11.wl120.cc.ntu.edu.tw (ip24-218.wifi.cc.ntu.edu.tw [140.112.24.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 7502C2F104;
	Sun, 24 Aug 2025 20:43:50 +0800 (CST)
From: b10902118 <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	b10902118 <b10902118@ntu.edu.tw>
Subject: [PATCH 1/3] arm64: ptrace: fix hw_break_set() by setting addr and ctrl together
Date: Sun, 24 Aug 2025 20:43:15 +0800
Message-Id: <20250824124317.390795-2-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824124317.390795-1-b10902118@ntu.edu.tw>
References: <20250824124317.390795-1-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTRACE_SETREGSET fails when setting a hardware breakpoint on a
non-4-byte aligned address with a valid length to a 32-bit tracee. The
length should be valid as long as the range started from the address
is within one aligned 4 bytes.

The cause is that hw_break_set() modifies a breakpoint's addr
first and then ctrl. This calls modify_user_hw_breakpoint() twice,
although once registering both suffices. The first modification causes
errors because new addr and old ctrl can be an invalid combination at
hw_breakpoint_arch_parse(). For example, when a user sets a hardware
breakpoint with addr=0x2 and ctrl.len=1, hw_breakpoint_arch_parse()
will first see addr=0x2 and ctrl.len=4 (the default) and return
-EINVAL. On the other hand, if a user sets the same value to
a breakpoint whose ctrl.len has previously been set to 1 or 2,
it succeeds.

The fix is to set addr and ctrl in one modify_user_hw_breakpoint(),
effectively eliminating the discrepancy in validation.

Signed-off-by: b10902118 <b10902118@ntu.edu.tw>
---
 arch/arm64/kernel/ptrace.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4b001121c..73c67f743 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -467,6 +467,32 @@ static int ptrace_hbp_set_addr(unsigned int note_type,
 	return err;
 }
 
+/* Set the address and control together for non-compat ptrace */
+static int ptrace_hbp_set(unsigned int note_type, struct task_struct *tsk,
+			  unsigned long idx, u64 addr, u32 uctrl)
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
@@ -524,9 +550,6 @@ static int hw_break_set(struct task_struct *target,
 			return -EINVAL;
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
 					 offset, offset + PTRACE_HBP_ADDR_SZ);
-		if (ret)
-			return ret;
-		ret = ptrace_hbp_set_addr(note_type, target, idx, addr);
 		if (ret)
 			return ret;
 		offset += PTRACE_HBP_ADDR_SZ;
@@ -537,10 +560,11 @@ static int hw_break_set(struct task_struct *target,
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
2.50.1


