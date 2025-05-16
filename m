Return-Path: <linux-kernel+bounces-651215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C640AB9BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3074E3B31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0565242D6C;
	Fri, 16 May 2025 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYdyOhmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4923C8DB;
	Fri, 16 May 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747397651; cv=none; b=WzIZDpZ6H7Eb1oLASHafiyyDBcMFX7LeWdqgzqYFimP0RIstR+e4hkJaVeU6k2BeXWryuq0t7mJNgt8qCPKn3j7VMGY8H99nPbDJot9CJytHBM6XVOiDG/P3EPhs3/rksnAA6YAtYwRb/U2HVYgwzj88dNIrUv1NQ57JHdOoH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747397651; c=relaxed/simple;
	bh=RXexCK8Qdt/LRm9vYunDp7LKFYd3x/0zE98ns8Tksyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFKudbzCDvG962JNQMSQI+moi4ly8+wZIezi9fsHNIuqTR+3KitZZbQpQXAJLfOJn3Owkow1EyBLg+d+yfdJ/FK4nQo856J04wku2Ox6RZDbpBDDPxWnWgS4Hiewcx0V1UlGEnrOw63spVq3R0jQY/MmBnq7BrK0J13B4oWSxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYdyOhmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F11BCC4CEFA;
	Fri, 16 May 2025 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747397651;
	bh=RXexCK8Qdt/LRm9vYunDp7LKFYd3x/0zE98ns8Tksyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qYdyOhmJClToEWPcyFZ9I6K8ccYMWstaLbbI/B8EJc7ZRSq/IcOSmB9O6zlLlpxMq
	 6uPDgljGZ4WOBncFIbY2W1SFIPc9kkL1HQvwrqvNIXvmTVjWZKUIsphHSCbxqUaqIx
	 wQPauvLBH2Iy39RtpQSVe6VuPAdMI56CVm11FyJjlXPRoGdjbi9VoyUfEPzBwkw8D+
	 jbCpHSBCPbi9Vgs0sUP6ludNPCLl4K4lsJliRRGT8i8Yy8dTySFvi22rlfIVfE7Sxv
	 j5TyN7fYmh2gE958dV2u/Rx3BVHTMuvotIRmt3OPNw+DSspz89rc695yFA+iO/lWHn
	 MNndziDeSiqYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE1C3ABC9;
	Fri, 16 May 2025 12:14:10 +0000 (UTC)
From: Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org>
Date: Fri, 16 May 2025 12:14:04 +0000
Subject: [PATCH v4 5/5] KVM: arm64: Support FFA_MSG_SEND_DIRECT_REQ2 in
 host handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-virtio-msg-ffa-v4-5-580ee70e5081@google.com>
References: <20250516-virtio-msg-ffa-v4-0-580ee70e5081@google.com>
In-Reply-To: <20250516-virtio-msg-ffa-v4-0-580ee70e5081@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, sebastianene@google.com, qperret@google.com, 
 qwandor@google.com, arve@android.com, perl@immunant.com, 
 lpieralisi@kernel.org, kernel-team@android.com, tabba@google.com, 
 james.morse@arm.com, armellel@google.com, jean-philippe@linaro.org, 
 ahomescu@google.com, Per Larsen <perlarsen@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747397650; l=6287;
 i=perlarsen@google.com; s=20250508; h=from:subject:message-id;
 bh=hU7p4PRxZqf05XqHITft3GvP1fgJbAOODTG2NRdcdeA=;
 b=iqh8j3zsh8Sg9ZxHsL1pNDrvJXbbRkE3cDt2V0ruu86Mope78hrZsh3HSQqO2P3NgAOp8kAQh
 RF/+ph1MMUwAjs0uFLWFuzPlOTSVvtlp6zZHrE/fuiO9HC+glkCgb9R
X-Developer-Key: i=perlarsen@google.com; a=ed25519;
 pk=jjc/Ta4VmrLRmMoahP6d1mBcKzvWU+nsmdtYe2oS2kQ=
X-Endpoint-Received: by B4 Relay for perlarsen@google.com/20250508 with
 auth_id=402
X-Original-From: Per Larsen <perlarsen@google.com>
Reply-To: perlarsen@google.com

From: Per Larsen <perlarsen@google.com>

FF-A 1.2 adds the DIRECT_REQ2 messaging interface which is similar to
the existing FFA_MSG_SEND_DIRECT_{REQ,RESP} functions except that it
uses the SMC calling convention v1.2 which allows calls to use x4-x17 as
argument and return registers. Add support for FFA_MSG_SEND_DIRECT_REQ2
in the host ffa handler.

Signed-off-by: Per Larsen <perlarsen@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 110 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/arm_ffa.h       |   2 +
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 0b952ace29f6847b4e941262c4c1b05a5bc13e5a..cd75f98bffdb75abd41f9ddc944b8426b93056e4 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -79,6 +79,14 @@ static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 	};
 }
 
+static void ffa_to_smccc_1_2_error(struct arm_smccc_1_2_regs *regs, u64 ffa_errno)
+{
+	*regs = (struct arm_smccc_1_2_regs) {
+		.a0	= FFA_ERROR,
+		.a2	= ffa_errno,
+	};
+}
+
 static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
 {
 	if (ret == FFA_RET_SUCCESS) {
@@ -94,6 +102,12 @@ static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
 	ffa_to_smccc_res_prop(res, ret, 0);
 }
 
+static u32 ffa_get_func_id(struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, func_id, ctxt, 0);
+	return func_id;
+}
+
 static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 			   struct arm_smccc_res *res)
 {
@@ -128,6 +142,54 @@ static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 	}
 }
 
+static void ffa_set_retval_smccc_1_2(struct kvm_cpu_context *ctxt,
+				     struct arm_smccc_1_2_regs *regs)
+{
+	cpu_reg(ctxt, 0) = regs->a0;
+	cpu_reg(ctxt, 1) = regs->a1;
+	cpu_reg(ctxt, 2) = regs->a2;
+	cpu_reg(ctxt, 3) = regs->a3;
+	cpu_reg(ctxt, 4) = regs->a4;
+	cpu_reg(ctxt, 5) = regs->a5;
+	cpu_reg(ctxt, 6) = regs->a6;
+	cpu_reg(ctxt, 7) = regs->a7;
+	cpu_reg(ctxt, 8) = regs->a8;
+	cpu_reg(ctxt, 9) = regs->a9;
+	cpu_reg(ctxt, 10) = regs->a10;
+	cpu_reg(ctxt, 11) = regs->a11;
+	cpu_reg(ctxt, 12) = regs->a12;
+	cpu_reg(ctxt, 13) = regs->a13;
+	cpu_reg(ctxt, 14) = regs->a14;
+	cpu_reg(ctxt, 15) = regs->a15;
+	cpu_reg(ctxt, 16) = regs->a16;
+	cpu_reg(ctxt, 17) = regs->a17;
+}
+
+/*
+ * Must a given FFA function use the SMC calling convention v1.2?
+ */
+static bool ffa_call_needs_smccc_1_2(u64 func_id)
+{
+	switch (func_id) {
+	case FFA_MSG_SEND_DIRECT_REQ2:
+	case FFA_MSG_SEND_DIRECT_RESP2:
+	case FFA_PARTITION_INFO_GET_REGS:
+		return true;
+	}
+
+	return false;
+}
+
+static void ffa_set_retval_smccc_1_x(struct kvm_cpu_context *ctxt,
+				     struct arm_smccc_res *res,
+				     struct arm_smccc_1_2_regs *regs)
+{
+	if (ffa_call_needs_smccc_1_2(ffa_get_func_id(ctxt)))
+		ffa_set_retval_smccc_1_2(ctxt, regs);
+	else
+		ffa_set_retval(ctxt, res);
+}
+
 /* Call SMC64 using SMCCC 1.2 if hyp negotiated FF-A 1.2 falling back to 1.1 */
 static void arm_smccc_1_x_smc(u64 func_id, u64 a1, u64 a2, u64 a3,
 			      u64 a4, u64 a5, u64 a6, u64 a7,
@@ -683,7 +745,6 @@ static bool ffa_call_supported(u64 func_id)
 	case FFA_NOTIFICATION_GET:
 	case FFA_NOTIFICATION_INFO_GET:
 	/* Unimplemented interfaces added in FF-A 1.2 */
-	case FFA_MSG_SEND_DIRECT_REQ2:
 	case FFA_MSG_SEND_DIRECT_RESP2:
 	case FFA_CONSOLE_LOG:
 	case FFA_PARTITION_INFO_GET_REGS:
@@ -852,9 +913,47 @@ static void do_ffa_part_get(struct arm_smccc_res *res,
 	hyp_spin_unlock(&host_buffers.lock);
 }
 
+static void do_ffa_direct_msg2(struct arm_smccc_1_2_regs *regs,
+			       struct kvm_cpu_context *ctxt,
+			       u64 vm_handle)
+{
+	DECLARE_REG(u32, func_id, ctxt, 0);
+	DECLARE_REG(u32, endp, ctxt, 1);
+	DECLARE_REG(u64, uuid_lo, ctxt, 2);
+	DECLARE_REG(u64, uuid_hi, ctxt, 3);
+	DECLARE_REG(u64, x4, ctxt, 4);
+	DECLARE_REG(u64, x5, ctxt, 5);
+	DECLARE_REG(u64, x6, ctxt, 6);
+	DECLARE_REG(u64, x7, ctxt, 7);
+	DECLARE_REG(u64, x8, ctxt, 8);
+	DECLARE_REG(u64, x9, ctxt, 9);
+	DECLARE_REG(u64, x10, ctxt, 10);
+	DECLARE_REG(u64, x11, ctxt, 11);
+	DECLARE_REG(u64, x12, ctxt, 12);
+	DECLARE_REG(u64, x13, ctxt, 13);
+	DECLARE_REG(u64, x14, ctxt, 14);
+	DECLARE_REG(u64, x15, ctxt, 15);
+	DECLARE_REG(u64, x16, ctxt, 16);
+	DECLARE_REG(u64, x17, ctxt, 17);
+
+	if (FIELD_GET(FFA_SRC_ENDPOINT_MASK, endp) != vm_handle) {
+		ffa_to_smccc_1_2_error(regs, FFA_RET_INVALID_PARAMETERS);
+		return;
+	}
+
+	struct arm_smccc_1_2_regs args = {
+		func_id, endp, uuid_lo, uuid_hi,
+		 x4,  x5,  x6,  x7,  x8,  x9, x10,
+		x11, x12, x13, x14, x15, x16, x17
+	};
+
+	arm_smccc_1_2_smc(&args, regs);
+}
+
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
 	struct arm_smccc_res res;
+	struct arm_smccc_1_2_regs regs;
 
 	/*
 	 * There's no way we can tell what a non-standard SMC call might
@@ -910,14 +1009,21 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	case FFA_PARTITION_INFO_GET:
 		do_ffa_part_get(&res, host_ctxt);
 		goto out_handled;
+	case FFA_MSG_SEND_DIRECT_REQ2:
+		if (hyp_ffa_version >= FFA_VERSION_1_2) {
+			do_ffa_direct_msg2(&regs, host_ctxt, HOST_FFA_ID);
+			goto out_handled;
+		}
+		goto out_not_supported;
 	}
 
 	if (ffa_call_supported(func_id))
 		return false; /* Pass through */
 
+out_not_supported:
 	ffa_to_smccc_error(&res, FFA_RET_NOT_SUPPORTED);
 out_handled:
-	ffa_set_retval(host_ctxt, &res);
+	ffa_set_retval_smccc_1_x(host_ctxt, &res, &regs);
 	return true;
 }
 
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index c0dd6183d956043192114a522b7eef465e7078ac..82a35a3b22de426f7e9a8894e76fdf1e933b3d6b 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -269,6 +269,8 @@ bool ffa_partition_check_property(struct ffa_device *dev, u32 property)
 	(ffa_partition_check_property(dev, FFA_PARTITION_DIRECT_REQ2_RECV) && \
 	 !dev->mode_32bit)
 
+#define FFA_SRC_ENDPOINT_MASK	GENMASK(31, 16)
+
 /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP} which pass data via registers */
 struct ffa_send_direct_data {
 	unsigned long data0; /* w3/x3 */

-- 
2.49.0.1101.gccaa498523-goog



