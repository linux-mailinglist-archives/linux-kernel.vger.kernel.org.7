Return-Path: <linux-kernel+bounces-722189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E908AFD65B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F23C3B0805
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C092E92B3;
	Tue,  8 Jul 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pN5byba/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7VL/gOn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2A2E8DFC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998834; cv=none; b=beKROC9y+HCsvJIXj5tNtq1qiT98KWW62sx8FiEivK1D3RAPYJ35xahnznB/lk0HoBzE3JqikQ2tA8DzHCTpLDP+sB7Z+LfK3DxsNyqiw2VBmbNu3GAx9OlV1wXiy21065MtlLVM5GsGPkf1CJnZIktBDIjkKT+Krjc3TqFn+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998834; c=relaxed/simple;
	bh=zEB8tKqWPqJaPtwE/c41iE8V0wi+BpY80G/HwTqV8cw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JdZd3ZEau4/9tployX/2G2D5ls8lkbXLIeRcpY9rZ7jpd8+V5h2Iv0qxlqXri219mmvzDFC7yHoezsoMJZMdDGBsqLQVCxZffmjnwTGlQl1piApvYfvyN4LWIRbg6zSPIJzM+9pITTWoqdkuDE0gPWotfg8rke0CGK9Usaycmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pN5byba/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7VL/gOn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngS40/ReaW2gl+dW/zYI0GZrhyUxBImT0E0FNbYtyGY=;
	b=pN5byba/BPfh8Aj6RcE3X9OrjxONKtoiK1f9Pz7b3aCp6oFv+/UFeOh8jU+un6AG1U1Xq0
	TmYBpzXlr6DUVrEZmdFV+YbZmYR5ug7XXQ8wqJJbHSmkrlfgS2Pai4Mz66IUhicgCMkvLK
	mzmq8VtgPw+UvVrWLJlhha6iVDuU2CVv3dIG43k5y1xXKDPsmXqlFqxw8t9+NQ22SOwk5O
	qzj4Gnm1jodd+7yjIFRRvq1exXrdP7nGaZwZ2lqTNfhyGL1vK9mhjk8mCQcIjG7WwIr6qJ
	C5gQS8NRtOQdNvaV3aU/mDES/zroKZ/k0sh0s8AoyRxMXPN3G3HZAUKJ68G6Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngS40/ReaW2gl+dW/zYI0GZrhyUxBImT0E0FNbYtyGY=;
	b=N7VL/gOny/PXTKxId/+MqKUmDyCxSVKUUdW8uSHNu4ZU+gmdjdmeUsMFW7BACqkhgdeVd5
	9FZ31EA7nfzpEcAQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: Add support for GICv5 GSB barriers
Cc: Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-19-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-19-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199882939.406.11217739614225079831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e62e1e9493aa7aeba6670db6373031533a4d4ced
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e62e1e9493aa7aeba6670db6373031533a4d4ced
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:09 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:51 +01:00

arm64: Add support for GICv5 GSB barriers

The GICv5 architecture introduces two barriers instructions
(GSB SYS, GSB ACK) that are used to manage interrupt effects.

Rework macro used to emit the SB barrier instruction and implement
the GSB barriers on top of it.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-19-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/barrier.h |  3 +++
 arch/arm64/include/asm/sysreg.h  | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1ca947d..f5801b0 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -44,6 +44,9 @@
 						 SB_BARRIER_INSN"nop\n",	\
 						 ARM64_HAS_SB))
 
+#define gsb_ack()	asm volatile(GSB_ACK_BARRIER_INSN : : : "memory")
+#define gsb_sys()	asm volatile(GSB_SYS_BARRIER_INSN : : : "memory")
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 #define pmr_sync()						\
 	do {							\
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f1bb0d1..9b5fc63 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -113,10 +113,14 @@
 /* Register-based PAN access, for save/restore purposes */
 #define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
 
-#define __SYS_BARRIER_INSN(CRm, op2, Rt) \
-	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
-
-#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
+#define __SYS_BARRIER_INSN(op0, op1, CRn, CRm, op2, Rt)			\
+	__emit_inst(0xd5000000					|	\
+		    sys_insn((op0), (op1), (CRn), (CRm), (op2))	|	\
+		    ((Rt) & 0x1f))
+
+#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 3, 3, 0, 7, 31)
+#define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
+#define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
 
 /* Data cache zero operations */
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)

