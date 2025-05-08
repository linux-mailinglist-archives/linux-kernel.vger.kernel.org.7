Return-Path: <linux-kernel+bounces-639316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD053AAF5E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 10:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68AAB22045
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCCC263F52;
	Thu,  8 May 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjUc3a6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFA262FFA;
	Thu,  8 May 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693573; cv=none; b=RX8okjb5CpxREOKSmk54OQY29IrM9CTbfgPQUPvZp301BbL9v8i5/MqQBCzcrWCK8RPdlWAfVLQxNfeA2u+KStJu5rOAf6CgbckpFoP+wQEalF4D+ZUr/CEUQRxhOs2uPoKKfbl35GfudAifxByvZPjj2oXg8Ov4zMZ3plO6LhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693573; c=relaxed/simple;
	bh=rs0mFCDDTIYMQ6yNU6NBZKwXd2cRp1GG9xedpmFAkOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LY78wLQDCppzXonMddRK3Wq0Mqx7rfZzKpP6igcLuH7/ELIJXM5hfIYfS9T9iMGEVW8//Az85poWVHIPk+DlCFHbmawu6AgnH49jBgfd1gubWJGs1sO8EFxPyNKnfE6gDAXw60ronnTU5xsZbcIE07JavoxfrYdsQjHGsIYkUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjUc3a6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03213C4CEED;
	Thu,  8 May 2025 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746693573;
	bh=rs0mFCDDTIYMQ6yNU6NBZKwXd2cRp1GG9xedpmFAkOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KjUc3a6ngt56HCwSsIJXvXjH/Ax6ed6naTJvGJ0lLkNkDPQBGlxFwPQCiKyBcWSMp
	 nMxzsdjoxK4G/zduF+CSQMVgLQzEPTkagL0Bey4IXicOJviZkV3tqS3O+1KNDlmSb9
	 zYhzCmrjZrGQwcqD6CWcZFBdu7FBSIZ5i/ALnky487Uu2pqu04jt7WrwopNgYGDhhV
	 HnX35f13i3jUOFisE4gZeb3cJsyG7FmemkJ0kmPtI/rUmiHDi+/CrEIIyBbv7hiX41
	 30g1vXgxxOwDGONPPhUKeeaySxHqKLPyfALSCh4ERZZYlUS5obBnB3HS/QU19S268p
	 2MAAcStZHg8Zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A54C3ABBE;
	Thu,  8 May 2025 08:39:31 +0000 (UTC)
From: Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org>
Date: Thu, 08 May 2025 08:38:53 +0000
Subject: [PATCH v2 2/3] KVM: arm64: Bump the supported version of FF-A to
 1.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-virtio-msg-ffa-v2-2-ed84f8053965@google.com>
References: <20250508-virtio-msg-ffa-v2-0-ed84f8053965@google.com>
In-Reply-To: <20250508-virtio-msg-ffa-v2-0-ed84f8053965@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, arve@android.com, lpieralisi@kernel.org, 
 qwandor@google.com, jean-philippe@linaro.org, james.morse@arm.com, 
 perl@immunant.com, tabba@google.com, kernel-team@android.com, 
 armellel@google.com, qperret@google.com, sebastianene@google.com, 
 ahomescu@google.com, Ayrton Munoz <ayrton@google.com>, 
 Per Larsen <perlarsen@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746693571; l=6988;
 i=perlarsen@google.com; s=20250508; h=from:subject:message-id;
 bh=rdneVzDdgJnC0KDJn67CCo235olFHQ+wOu5HgJaQbUE=;
 b=jBgx4lYPHLKheNl3D2rM12b358xUAmOg45I0S9Bp5ASNGMyE2pzmyECO6XSQfHN4FWQO4eGYu
 kzSl+I8qiXfD61r8cOJJmcvBmOPW3UpD9nli2+idOR/F601X3x/9cgx
X-Developer-Key: i=perlarsen@google.com; a=ed25519;
 pk=jjc/Ta4VmrLRmMoahP6d1mBcKzvWU+nsmdtYe2oS2kQ=
X-Endpoint-Received: by B4 Relay for perlarsen@google.com/20250508 with
 auth_id=402
X-Original-From: Per Larsen <perlarsen@google.com>
Reply-To: perlarsen@google.com

From: Per Larsen <perlarsen@google.com>

FF-A version 1.2 introduces the DIRECT_REQ2 ABI. Bump the FF-A version
preferred by the hypervisor as a precursor to implementing the 1.2-only
FFA_MSG_SEND_DIRECT_REQ2 and FFA_MSG_SEND_RESP2 messaging interfaces.

We must also use SMCCC 1.2 for 64-bit SMCs if hypervisor negotiated FF-A
1.2, so ffa_set_retval is updated and a new function to call 64-bit smcs
using SMCCC 1.2 with fallback to SMCCC 1.1 is introduced.

Update deny-list in ffa_call_supported to mark FFA_NOTIFICATION_* and
interfaces added in FF-A 1.2 as unsupported lest they get forwarded.

Co-developed-by: Ayrton Munoz <ayrton@google.com>
Signed-off-by: Ayrton Munoz <ayrton@google.com>
Signed-off-by: Per Larsen <perlarsen@google.com>
Signed-off-by: Per Larsen <perl@immunant.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile |  1 +
 arch/arm64/kvm/hyp/nvhe/ffa.c    | 86 +++++++++++++++++++++++++++++++++++++---
 include/linux/arm_ffa.h          |  1 +
 3 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b43426a493df5a388caa920e259cc8c54d118a1b..95404ff16dac0389f45a3ee2c13a93b3ebebaf6d 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -27,6 +27,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
+hyp-obj-y += ../../../kernel/smccc-call.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 hyp-obj-y += $(lib-objs)
 
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 2c199d40811efb5bfae199c4a67d8ae3d9307357..3fa5d1ae26c40fb96ad2deb834882bb3e0af5637 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -94,6 +94,7 @@ static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
 	ffa_to_smccc_res_prop(res, ret, 0);
 }
 
+
 static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 			   struct arm_smccc_res *res)
 {
@@ -101,6 +102,64 @@ static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 	cpu_reg(ctxt, 1) = res->a1;
 	cpu_reg(ctxt, 2) = res->a2;
 	cpu_reg(ctxt, 3) = res->a3;
+
+	/*
+	 * Other result registers must be zero per DEN0077A but SMC32/HVC32 must
+	 * preserve x8-x30 per DEN0028.
+	 */
+	cpu_reg(ctxt, 4) = 0;
+	cpu_reg(ctxt, 5) = 0;
+	cpu_reg(ctxt, 6) = 0;
+	cpu_reg(ctxt, 7) = 0;
+
+	/*
+	 * Per DEN0077A v1.2 11.2, the caller is expected to write zeroes to
+	 * unused parameter registers.
+	 */
+	if (ARM_SMCCC_IS_64(res->a0)) {
+		hyp_spin_lock(&version_lock);
+
+		if (hyp_ffa_version >= FFA_VERSION_1_2) {
+			cpu_reg(ctxt, 8) = 0;
+			cpu_reg(ctxt, 9) = 0;
+			cpu_reg(ctxt, 10) = 0;
+			cpu_reg(ctxt, 11) = 0;
+			cpu_reg(ctxt, 12) = 0;
+			cpu_reg(ctxt, 13) = 0;
+			cpu_reg(ctxt, 14) = 0;
+			cpu_reg(ctxt, 15) = 0;
+			cpu_reg(ctxt, 16) = 0;
+			cpu_reg(ctxt, 17) = 0;
+		}
+
+		hyp_spin_unlock(&version_lock);
+	}
+}
+
+/* Call SMC64 using SMCCC 1.2 if hyp negotiated FF-A 1.2 falling back to 1.1 */
+static void arm_smccc_1_x_smc(u64 func_id, u64 a1, u64 a2, u64 a3,
+			      u64 a4, u64 a5, u64 a6, u64 a7,
+			      struct arm_smccc_res *res)
+{
+	struct arm_smccc_1_2_regs args, regs = {0};
+
+	if (ARM_SMCCC_IS_64(func_id))
+		hyp_spin_lock(&version_lock);
+
+	/* SMC64 only as SMC32 must preserve x8-x30 per DEN0028 1.6G Sec 2.6 */
+	if (ARM_SMCCC_IS_64(func_id) && hyp_ffa_version >= FFA_VERSION_1_2) {
+		args = (struct arm_smccc_1_2_regs) { func_id, a1, a2, a3, a4,
+						     a5, a6, a7 };
+		arm_smccc_1_2_smc(&args, &regs);
+		*res = (struct arm_smccc_res) { .a0 = regs.a0, .a1 = regs.a1,
+						.a2 = regs.a2, .a3 = regs.a3 };
+		goto unlock;
+	}
+
+	arm_smccc_1_1_smc(func_id, a1, a2, a3, a4, a5, a6, a7, res);
+unlock:
+	if (ARM_SMCCC_IS_64(func_id))
+		hyp_spin_unlock(&version_lock);
 }
 
 static bool is_ffa_call(u64 func_id)
@@ -115,7 +174,7 @@ static int ffa_map_hyp_buffers(u64 ffa_page_count)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_1_1_smc(FFA_FN64_RXTX_MAP,
+	arm_smccc_1_x_smc(FFA_FN64_RXTX_MAP,
 			  hyp_virt_to_phys(hyp_buffers.tx),
 			  hyp_virt_to_phys(hyp_buffers.rx),
 			  ffa_page_count,
@@ -174,7 +233,7 @@ static void ffa_mem_reclaim(struct arm_smccc_res *res, u32 handle_lo,
 
 static void ffa_retrieve_req(struct arm_smccc_res *res, u32 len)
 {
-	arm_smccc_1_1_smc(FFA_FN64_MEM_RETRIEVE_REQ,
+	arm_smccc_1_x_smc(FFA_FN64_MEM_RETRIEVE_REQ,
 			  len, len,
 			  0, 0, 0, 0, 0,
 			  res);
@@ -628,6 +687,20 @@ static bool ffa_call_supported(u64 func_id)
 	case FFA_RXTX_MAP:
 	case FFA_MEM_DONATE:
 	case FFA_MEM_RETRIEVE_REQ:
+	/* Optional notification interfaces added in FF-A 1.1 */
+	case FFA_NOTIFICATION_BITMAP_CREATE:
+	case FFA_NOTIFICATION_BITMAP_DESTROY:
+	case FFA_NOTIFICATION_BIND:
+	case FFA_NOTIFICATION_UNBIND:
+	case FFA_NOTIFICATION_SET:
+	case FFA_NOTIFICATION_GET:
+	case FFA_NOTIFICATION_INFO_GET:
+	/* Unimplemented interfaces added in FF-A 1.2 */
+	case FFA_MSG_SEND_DIRECT_REQ2:
+	case FFA_MSG_SEND_DIRECT_RESP2:
+	case FFA_CONSOLE_LOG:
+	case FFA_PARTITION_INFO_GET_REGS:
+	case FFA_EL3_INTR_HANDLE:
 		return false;
 	}
 
@@ -680,7 +753,7 @@ static int hyp_ffa_post_init(void)
 	if (res.a0 != FFA_SUCCESS)
 		return -EOPNOTSUPP;
 
-	switch (res.a2) {
+	switch (res.a2 & FFA_FEAT_RXTX_MIN_SZ_MASK) {
 	case FFA_FEAT_RXTX_MIN_SZ_4K:
 		min_rxtx_sz = SZ_4K;
 		break;
@@ -869,7 +942,7 @@ int hyp_ffa_init(void *pages)
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_1, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_2, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0 == FFA_RET_NOT_SUPPORTED)
 		return 0;
 
@@ -889,10 +962,11 @@ int hyp_ffa_init(void *pages)
 	if (FFA_MAJOR_VERSION(res.a0) != 1)
 		return -EOPNOTSUPP;
 
-	if (FFA_MINOR_VERSION(res.a0) < FFA_MINOR_VERSION(FFA_VERSION_1_1))
+	/* See do_ffa_guest_version before bumping maximum supported version. */
+	if (FFA_MINOR_VERSION(res.a0) < FFA_MINOR_VERSION(FFA_VERSION_1_2))
 		hyp_ffa_version = res.a0;
 	else
-		hyp_ffa_version = FFA_VERSION_1_1;
+		hyp_ffa_version = FFA_VERSION_1_2;
 
 	tx = pages;
 	pages += KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE;
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 5bded24dc24fea8cdcbe42bf79c7c025c3fa5f4b..c0dd6183d956043192114a522b7eef465e7078ac 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -128,6 +128,7 @@
 #define FFA_FEAT_RXTX_MIN_SZ_4K		0
 #define FFA_FEAT_RXTX_MIN_SZ_64K	1
 #define FFA_FEAT_RXTX_MIN_SZ_16K	2
+#define FFA_FEAT_RXTX_MIN_SZ_MASK	3
 
 /* FFA Bus/Device/Driver related */
 struct ffa_device {

-- 
2.49.0.987.g0cc8ee98dc-goog



