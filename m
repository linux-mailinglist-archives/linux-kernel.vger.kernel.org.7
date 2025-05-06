Return-Path: <linux-kernel+bounces-636457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E6AACBAB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0714E1C075B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491828AB0F;
	Tue,  6 May 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gma4B5++"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516528B41F
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550163; cv=none; b=YPS2Fb7im45iZrhRkDkgULCUrlmzoRji/ZIuifT9VSIBjY7+oAKvIObl/3WPg+SgytIi9ofoCrow//0loq0o9GCNzglzUnbwfPg/Ygnkqm0phGvh7a2ScufZyIhv0RtXrBnHSnym5hkdy+EJoUyqa8VVdTsaNeUeAX0nuENJIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550163; c=relaxed/simple;
	bh=torEYCq9v46z/4CnJ0hFeX5w0LCijhb9CNJxYaNikPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=itKy8xyMI3VfpEIIZLsDZgj+yafkOhHEc6B8GZVbt+MlAY3bzL4imCg8ckRIeJvJ/EpZmdvPNafp79KSA4xYsA3+KFY+dW12So+oTymbZ8V8dNrPBUETpksMhcd+o8tBmI24DwpqBhOIK+yATzU3axCBjY9rGpPHyzQdB4nVnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gma4B5++; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso39478635e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550160; x=1747154960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sP0+o0uEsWOaDtIvEsCo5unr0sfd3Il5igHJZ3qKciY=;
        b=gma4B5++r9jhYde2foiUjTEK94LfAg6Eess6cId4jzwIclu4KMeCpw9wuxTz0T/XXu
         mAWPrv98VO+fHguksrph6cwzCHt0H3948vCpJFgi6IKP6csxX0rcpsjAT+TXri4/W1ds
         uTM/38CCnUhf81YXbKDnHtEJryDiofLA/RfrL3vADU8SUmBfB8mXKQLr9fnew05rTkVK
         G2CNbUiW2+ZX/LRvohl0nI53qhc+ejLdkBSqawCrvU8v3n7PCxh3s8gC/qCRtJ/6Ti9C
         81oxIqAVxRF2TacaxI5ep4CIltJHLrXqn1krRYndabT6IdahQ2TVnVwj/ZVQlhc9QPUW
         A7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550160; x=1747154960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP0+o0uEsWOaDtIvEsCo5unr0sfd3Il5igHJZ3qKciY=;
        b=utUFP9ABUuOPCIWEXe0JcnV05Wn+Pdv1rXxtSG/FWETurUtVbGJgesjMNoXwHeOe4R
         64Ktz06KN1kv7LQRjeVKbd1MnHf2O7sdGIEtezzgPryfQg62zX+uFFRfeB4d2V8Ky656
         kGBWhtZM2Wp6l1Xp1LT73JscsRRfvgqGYxFHIeryKkQaRjjtHjbwVDilK/iyNjOzUbO5
         9dRdrvsrTMSF3YOrj9em7Ic+Riu3KlZht8QVlowImoqH7vOtp4YYHrk2fVYksTPKjefe
         Wo5pFsLChhc6jEZgOQ6AiJ/GKAo8k5xaUS3L7PGNewz5MCPFNQsQRLc7le9a6NHhCGYE
         vm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN9oSuHr7B066fd876x7+3qPiiaWZGZPnCwvIitOwFcBK+xvGdioTGvuDEn/+QFw0GiurDmlgu8YVOao0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7gcYYGoLtk3/89D+q3665gY43zqscjaS3pvU+fPxJn12zKmH
	bvrX+VoPS3Pdm8xthtH8C7ImgCII1/aS+gG6KSbxSxhTqeW9HI0LPq02KOnIfOjqmWlzMuNPTwp
	iGscRjaiv2+JobhL2rg==
X-Google-Smtp-Source: AGHT+IHUuqs+r3rhJxv97f89Ad2Z2eXd2asFXzm6hFHj+5AyVi1/wxB573CGibob8tbRu/wOxVh8rL3Ar7Iep4nH
X-Received: from wmben3.prod.google.com ([2002:a05:600c:8283:b0:43e:9aac:5a49])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3494:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-441c48aa314mr122683335e9.4.1746550160430;
 Tue, 06 May 2025 09:49:20 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:18 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-23-vdonnefort@google.com>
Subject: [PATCH v4 22/24] KVM: arm64: Add hyp_enter/hyp_exit events to pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The hyp_enter and hyp_exit events are logged by the hypervisor any time
it is entered and exited.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
index d6e033c96c52..ce3953bc884a 100644
--- a/arch/arm64/include/asm/kvm_hypevents.h
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -7,4 +7,21 @@
 #include <nvhe/trace.h>
 #endif
 
+HYP_EVENT(hyp_enter,
+	HE_PROTO(void),
+	HE_STRUCT(
+	),
+	HE_ASSIGN(
+	),
+	HE_PRINTK()
+);
+
+HYP_EVENT(hyp_exit,
+	HE_PROTO(void),
+	HE_STRUCT(
+	),
+	HE_ASSIGN(
+	),
+	HE_PRINTK()
+);
 #endif
diff --git a/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
new file mode 100644
index 000000000000..4b69d33e4f2d
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <asm/kvm_hypevents.h>
+
+#include <linux/arm-smccc.h>
+
+#undef arm_smccc_1_1_smc
+#define arm_smccc_1_1_smc(...)					\
+	do {							\
+		trace_hyp_exit();				\
+		__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__);	\
+		trace_hyp_enter();				\
+	} while (0)
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 3369dd0c4009..e00931fd194f 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -26,10 +26,10 @@
  * the duration and are therefore serialised.
  */
 
-#include <linux/arm-smccc.h>
 #include <linux/arm_ffa.h>
 #include <asm/kvm_pkvm.h>
 
+#include <nvhe/arm-smccc.h>
 #include <nvhe/ffa.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/memory.h>
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 3d36be6d94ca..7d7d0c07a6d4 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -12,6 +12,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
 
 #include <nvhe/ffa.h>
@@ -713,7 +714,9 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 
 static void default_host_smc_handler(struct kvm_cpu_context *host_ctxt)
 {
+	trace_hyp_exit();
 	__kvm_hyp_host_forward_smc(host_ctxt);
+	trace_hyp_enter();
 }
 
 static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
@@ -737,6 +740,8 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
 
+	trace_hyp_enter();
+
 	switch (ESR_ELx_EC(esr)) {
 	case ESR_ELx_EC_HVC64:
 		handle_host_hcall(host_ctxt);
@@ -751,4 +756,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	default:
 		BUG();
 	}
+
+	trace_hyp_exit();
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index c3e196fb8b18..64d1d418df1d 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -6,11 +6,12 @@
 
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
-#include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
 #include <uapi/linux/psci.h>
 
+#include <nvhe/arm-smccc.h>
 #include <nvhe/memory.h>
 #include <nvhe/trap_handler.h>
 
@@ -205,6 +206,7 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	struct psci_boot_args *boot_args;
 	struct kvm_cpu_context *host_ctxt;
 
+	trace_hyp_enter();
 	host_ctxt = host_data_ptr(host_ctxt);
 
 	if (is_cpu_on)
@@ -221,6 +223,7 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
 	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
 
+	trace_hyp_exit();
 	__host_enter(host_ctxt);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 7d2ba6ef0261..bbe035acda89 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -7,7 +7,6 @@
 #include <hyp/switch.h>
 #include <hyp/sysreg-sr.h>
 
-#include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
 #include <linux/types.h>
 #include <linux/jump_label.h>
@@ -21,6 +20,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
@@ -349,10 +349,13 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	__debug_switch_to_guest(vcpu);
 
 	do {
+		trace_hyp_exit();
+
 		/* Jump in the fire! */
 		exit_code = __guest_enter(vcpu);
 
 		/* And we're baaack! */
+		trace_hyp_enter();
 	} while (fixup_guest_exit(vcpu, &exit_code));
 
 	__sysreg_save_state_nvhe(guest_ctxt);
-- 
2.49.0.967.g6a0df3ecc3-goog


