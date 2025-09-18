Return-Path: <linux-kernel+bounces-823402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F90B8653F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 987764E0F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11C284884;
	Thu, 18 Sep 2025 17:54:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642342820CB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218070; cv=none; b=Jn1rfDhlAcgiBc8BWva7jhSVUFq5VUs7NwvuVUCFnpGJmi/RWIgW7H8YSYWxhFhKzKHgeYwFoM5Z7uwv8NDBDwtgPMn1ejx6f/xGOZ8IuwRZXPphwrN03UN19P2NYVQN/c7lKDJrWcixK/T5K642kVzYv6XTwGz6YHqBt5zgWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218070; c=relaxed/simple;
	bh=AiDpVpL086GW0wqB8PJLzdn3T2VZu/6FCyiorG+MC9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkXQR2Fw1/x4fXmv8MOIR+VZGAhAgo6YG12dCn71jofPnYncGZgPhmzSfEhd8P2uY6CZMVS/xjJkcTc0EpxE8jsARu53FqZo+WPOtV+YFBVyuUFNxni3aOp2Cbw4FDoxkBe+xyNA+afQxq/0LIWP6cE32w6E95YezNJGyDDzChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE12176C;
	Thu, 18 Sep 2025 10:54:19 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EE4C3F673;
	Thu, 18 Sep 2025 10:54:27 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	liaochang1@huawei.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] arm64: probes: Fix incorrect bl/blr address and register usage
Date: Thu, 18 Sep 2025 12:54:24 -0500
Message-ID: <20250918175424.3483164-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pt_regs registers are 64-bit on arm64, and should be u64 when
manipulated. Correct this so that we aren't truncating the address
during br/blr sequences.

Fixes: efb07ac534e2 ("arm64: probes: Add GCS support to bl/blr/ret")
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/probes/simulate-insn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 97ed4db75417..89fbeb32107e 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -145,7 +145,7 @@ void __kprobes
 simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
 {
 	int xn = (opcode >> 5) & 0x1f;
-	int b_target = get_x_reg(regs, xn);
+	u64 b_target = get_x_reg(regs, xn);
 
 	if (((opcode >> 21) & 0x3) == 1)
 		if (update_lr(regs, addr + 4))
@@ -160,7 +160,7 @@ simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
 	u64 ret_addr;
 	int err = 0;
 	int xn = (opcode >> 5) & 0x1f;
-	unsigned long r_target = get_x_reg(regs, xn);
+	u64 r_target = get_x_reg(regs, xn);
 
 	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
 		ret_addr = pop_user_gcs(&err);
-- 
2.50.1


