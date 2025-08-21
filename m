Return-Path: <linux-kernel+bounces-779258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593ECB2F15F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2284D58777A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB52F5305;
	Thu, 21 Aug 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MqKVAdR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7F2F3C2F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764097; cv=none; b=rwFz1FygXLLxskTLnV2wchUfGVGZq5yWdNWEhWsJy4v+77oaZdQF3pjnEb7TDbFnxHuiY9ptlPZWS8hhGMVgShwANK4k+LD/e/NYWK2N158DoxF11a1b3x/soQJ9VoMkNbkTfv4tGQx7vs+j+V4EJvO29X0XcqODgyGfgQTVMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764097; c=relaxed/simple;
	bh=GYhMRL/4BrKlzUJdbWBycxCFy/OOj1KxnU0mfovQ03k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DH7Hp1GT4asnG975Kd2FuHjREn0R893Zp2PCAr09K27REZTTQA0Uq5HD/U3d+NkmGUIEZx7yoDz8nOO2V1acLIWHCrpfKfSeqO2SXRHWVdbYFs5SJzy9RS5m6Tgw1vKclvct/NKmfrntP0cp52NtLJE4L+JoaB5W0A7KnZ/BRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MqKVAdR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so4076355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764094; x=1756368894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJuYw9YtOUTxOKcJe9GYPUdg6A5eauGTuxfSWUfKtck=;
        b=2MqKVAdRgLLeGy1UPVZEXsfuCy8vJecuUR29EV8FBifjZxuBtPEFHhxgeWIznlXk6T
         RvtWxHW6InR0UA+9+rn6DsMmhhUqve4E1XUeu62D/7ql42uyY5TUdyFHxqQh1jhh8Tdf
         5Vp4OfYrf7L+PgyI+hKi5q6r+A8VSpfoDap7XbtDIGCV+lLYr4h+UZ+K9bLbwuSmxDYP
         gvtj587nVkp77BMlcFh9S9+6R7w0HzD8/UPPnWF7niCP7tLjY7yhq7bOVd6mMeLH7huj
         oirMbXUNV7kUKWIWFZ95DW/sm9DMGVNurl+7oSRO0nI44sTfojIaUBsm9WBwhVjtGBv2
         YoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764094; x=1756368894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJuYw9YtOUTxOKcJe9GYPUdg6A5eauGTuxfSWUfKtck=;
        b=BDuNQtk+xh0iGp0dJfD/2g70IjVDmd+0dEpT7g/WgewTmbiXFqcHIJGpIeOYqdedld
         n6CzAp969KNE9djEFCPQfIr2zb8oKAjw4AkCJyI5/Olf/sjUybhWmghXmrvoVa8aobIL
         3kJ9Av8a3lxbAphDUx6DE5t9qel3qto+Zbn9464JzvYwRO4n+nOakt+TDI4Sr50M1hGI
         +jFcdw8dXZyIsegTAeZtgK//L5Q/xfkGjFpC5SLJUq0j02KTf4VJ/E0YnjBOw29CuC8m
         FNkhCC74ukW+V+MxsLouQRi5ofcIF6OP4olvEK1vPaziFakmyKN1i6V7ICKfG78xUn9b
         kblA==
X-Forwarded-Encrypted: i=1; AJvYcCXQhqWtXRvzx9Z2v75QRSvTiDuzX0hGJabWctA0Bm/1n2AIzqAmVtWDTr7YWQozOd5BGtp8Zu0Emh51A2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvPa1rBSVvzlWLzPNq5fCEnRdaWAkD4nc4OBZ6ga5h/c0Yups
	/k4QcRZmuQ28cnIhZj+cU2o5ETaFslVyQmINfnJMPms4VROeTRrYdXhKnU8IDU4HB4O8W2oaE25
	Ezv16nImCDwsxlSKcwRaLvQ==
X-Google-Smtp-Source: AGHT+IEinA++oc/gQDS+j3wuYMFfToMe5DnZzzdAdhRTYs5/w3tHItN2vCEdHVa+TZ6bcaADQEZqE25FZvUvHW2b
X-Received: from wrbcm4.prod.google.com ([2002:a5d:5f44:0:b0:3a5:648f:da85])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2404:b0:3c3:973a:fe3d with SMTP id ffacd0b85a97d-3c497838009mr1125897f8f.59.1755764093978;
 Thu, 21 Aug 2025 01:14:53 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:10 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-23-vdonnefort@google.com>
Subject: [PATCH v6 22/24] KVM: arm64: Add hyp_enter/hyp_exit events to pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
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
index aebed41f7de7..f8361520967b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -12,6 +12,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_hyp.h>
+#include <asm/kvm_hypevents.h>
 #include <asm/kvm_mmu.h>
 
 #include <nvhe/ffa.h>
@@ -716,7 +717,9 @@ static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
 
 static void default_host_smc_handler(struct kvm_cpu_context *host_ctxt)
 {
+	trace_hyp_exit();
 	__kvm_hyp_host_forward_smc(host_ctxt);
+	trace_hyp_enter();
 }
 
 static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
@@ -740,6 +743,8 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 {
 	u64 esr = read_sysreg_el2(SYS_ESR);
 
+	trace_hyp_enter();
+
 	switch (ESR_ELx_EC(esr)) {
 	case ESR_ELx_EC_HVC64:
 		handle_host_hcall(host_ctxt);
@@ -754,4 +759,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
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
index ccd575d5f6de..e51f431e8b23 100644
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
@@ -302,10 +302,13 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
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
2.51.0.rc2.233.g662b1ed5c5-goog


