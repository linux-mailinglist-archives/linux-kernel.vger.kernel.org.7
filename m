Return-Path: <linux-kernel+bounces-849189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC651BCF773
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383C83B3864
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38D727C178;
	Sat, 11 Oct 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knlhwKEU"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D56800
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193639; cv=none; b=W0YcxKuvX4Kl83+cz3RIccSk1ZScwl0pbeCEIBILnP6EGmVP0z24Qp5/HsPZr1xvbrMrHJ9Md3oxAc/2S6O0pCCPxWI0kQFwwBE420EEBkaKhOgG8qiXtxCie/LRtcQYd5mnMmILhtW4I3pEP8oLpUk6Y5QVdruP7+Wb9WAqGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193639; c=relaxed/simple;
	bh=oLQSnAlJlsYDjmmmAf4TakNV9ImPLYoXrO4RVN5kZOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hykgo78+q9eN9MDIyNnfcK0/C8wTiYTEKhYcdi6qJPNyqhw6KnQfq2Yg8J4j/JvdLe6Tb4EnJknvBNhaSCjmLbVwAvIRx9BpvP7A1+hc/L2WB4NNg78qYAT3uFel+qy7XjPLf0lhu+HOzV1Afk/Pqg9tgo3svFJxrVlVm2h2saM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knlhwKEU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27edcbcd158so32982145ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760193637; x=1760798437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gl+ae1b3aiy4YJ4vxFhTeoZVmvj8iAgFv13VRfipKes=;
        b=knlhwKEUUDP7BvwSUbYomqPZwbmAYd4I9IzdcVemRUw+PeTe4wah0yFoAQQF7Kkrxd
         p8tOb+RwFApLDnzyshy1gUgdYPIq/aPl0MCWZX8eJdG/V6IWwysupnZD8bAZz0mTYyfr
         9LRc/84uZ2z1iJ3/iE1+UjAxy6AstOD3AirLOi5EEZRxwwZRvIWY18xzERO3XUY9FU8q
         Jl4qEWEPTXGBxP5Ada6x7d//wY/8taRxGc3cMMBQY1VYoRXctANbRvuu4YbaxHoBxAUt
         yUi2CMCxGFfFiwgcpU2LGVbQbJaUBorm/cPY9sbjoQ8qsWQC4Dl3fXQxMiiPmf7HHqmj
         57vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760193637; x=1760798437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl+ae1b3aiy4YJ4vxFhTeoZVmvj8iAgFv13VRfipKes=;
        b=JoK3/BgXVYHTbafXOQGnAzE4YzEIxaJ87n8m4ZVqR+5YoZPFLEWjzYU4pog0FRaFvg
         4/SdU3u2cvL2jjMvWAsuKqQCDca2ZMNcL+QTdYp/2vowvuEaGzndQBo4sKVnyclDfhAF
         LwjK54EqAub6PaN18WFzh8YDEyDFulaNiXMYmVYusjjJztpDIvD8AcGzupXRnwQo+/i+
         rMZmC+GQ2IVRvZHdkl0uf/aFfPqJn1XqPwGPVpRWx9TZWeihBJeDA+JsjYm8rgHR/scL
         oO080xTMkq+wgXC6XbNmRfiGjq0UddLc7BraMfas7vEwtMQJ3eISV9SPsjYQ7xCJp76L
         d1nA==
X-Forwarded-Encrypted: i=1; AJvYcCXlyq0u6xB+wN5DFZ7gDDJqeCmn44fx2j28ml5h8smjyEFmWFLd7a5/q+TaOmvgwTYfGh3AUV1ppIeprgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05V555HyHEgEl5bAqymWAHkLJg2PQNe8Ecv3Hh3ajgkO88Icr
	vyErrqDohG/IM+4xw99rjWiexDmHsmn5vMFksk6W85GwdnHhlnIcXnSE
X-Gm-Gg: ASbGncsrm4pPN6eMeRt2mPzXkx7LU5p5J+zkpJDWcppx3M2/KUscGfFhBSvf5gfax+/
	oTe3WBxmzVyMtoObE43Mf6TQrC70VRwTOCdteU8i/9DQFoYSz2R5qbGpmcln5b5S/vIuXXwT9U1
	yZeYzja7fN3zbb5dMvHQF3wp8ZaPcAzmZquV2kw7Cf/AZ9sJShQ4B+VvbKl2h1W4MH9h6YLKDar
	DnY3vScyJAH+jcPR4/k4oTqpBEKcpg9f5vKwHhmK8nMOZkIzDA1OAQRVHaZmgG3ctTa8DqGKzkj
	MRwsYURAyx384UHAWaAEVU5oKF5OUOANtA9bFz32BbnC+L5tnoThpxyhIx9FQPa9PDO1Z0isav2
	/KmNrYQLnRiI4iI7sm/MiJ2AFtnv3vGCBpnpTUH++wPEf6EI+OD8=
X-Google-Smtp-Source: AGHT+IGzzau/mcdSdFO8lAk2rHCjKfAo88tRGKmQOZgSFMkk8lLXKA/0TUsBf/w56T4nxl6liJ70Lg==
X-Received: by 2002:a17:903:8cc:b0:267:e3af:ae67 with SMTP id d9443c01a7336-29027238ef6mr187745315ad.14.1760193636698;
        Sat, 11 Oct 2025 07:40:36 -0700 (PDT)
Received: from n.. ([2401:4900:1c0e:53b:a256:f673:325:bb08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08e2dsm85442275ad.74.2025.10.11.07.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 07:40:36 -0700 (PDT)
From: mrigendrachaubey <mrigendra.chaubey@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>
Subject: [PATCH] arm64: Fix typos and spelling errors in comments
Date: Sat, 11 Oct 2025 20:10:04 +0530
Message-Id: <20251011144004.14946-1-mrigendra.chaubey@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects several minor typographical and spelling errors
in comments across multiple arm64 source files.

No functional changes.

Signed-off-by: mrigendrachaubey <mrigendra.chaubey@gmail.com>
---
 arch/arm64/include/asm/assembler.h  | 4 ++--
 arch/arm64/include/asm/cpufeature.h | 4 ++--
 arch/arm64/include/asm/el2_setup.h  | 2 +-
 arch/arm64/include/asm/pgtable.h    | 4 ++--
 arch/arm64/include/asm/suspend.h    | 2 +-
 arch/arm64/kernel/acpi.c            | 2 +-
 arch/arm64/kernel/cpufeature.c      | 2 +-
 arch/arm64/kernel/ftrace.c          | 2 +-
 arch/arm64/kernel/machine_kexec.c   | 2 +-
 arch/arm64/kernel/probes/uprobes.c  | 2 +-
 arch/arm64/kernel/sdei.c            | 2 +-
 arch/arm64/kernel/smp.c             | 4 ++--
 arch/arm64/kernel/traps.c           | 2 +-
 arch/arm64/kvm/arch_timer.c         | 2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c       | 2 +-
 arch/arm64/kvm/mmu.c                | 2 +-
 arch/arm64/kvm/nested.c             | 2 +-
 arch/arm64/net/bpf_jit_comp.c       | 2 +-
 18 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 23be85d93348..b8b1229e05e5 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -371,7 +371,7 @@ alternative_endif
  * [start, end) with dcache line size explicitly provided.
  *
  * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruciton
+ * 	domain:		domain used in dsb instruction
  * 	start:          starting virtual address of the region
  * 	end:            end virtual address of the region
  *	linesz:		dcache line size
@@ -412,7 +412,7 @@ alternative_endif
  * [start, end)
  *
  * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruciton
+ * 	domain:		domain used in dsb instruction
  * 	start:          starting virtual address of the region
  * 	end:            end virtual address of the region
  * 	fixup:		optional label to branch to on user fault
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e223cbf350e4..71ba4a47ab18 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -199,7 +199,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *    registers (e.g, SCTLR, TCR etc.) or patching the kernel via
  *    alternatives. The kernel patching is batched and performed at later
  *    point. The actions are always initiated only after the capability
- *    is finalised. This is usally denoted by "enabling" the capability.
+ *    is finalised. This is usually denoted by "enabling" the capability.
  *    The actions are initiated as follows :
  *	a) Action is triggered on all online CPUs, after the capability is
  *	finalised, invoked within the stop_machine() context from
@@ -251,7 +251,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 #define ARM64_CPUCAP_SCOPE_LOCAL_CPU		((u16)BIT(0))
 #define ARM64_CPUCAP_SCOPE_SYSTEM		((u16)BIT(1))
 /*
- * The capabilitiy is detected on the Boot CPU and is used by kernel
+ * The capability is detected on the Boot CPU and is used by kernel
  * during early boot. i.e, the capability should be "detected" and
  * "enabled" as early as possibly on all booting CPUs.
  */
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b37da3ee8529..f593ce79fe15 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -28,7 +28,7 @@
 	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
 	 * don't advertise it (they predate this relaxation).
 	 *
-	 * Initalize HCR_EL2.E2H so that later code can rely upon HCR_EL2.E2H
+	 * Initialize HCR_EL2.E2H so that later code can rely upon HCR_EL2.E2H
 	 * indicating whether the CPU is running in E2H mode.
 	 */
 	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index aa89c2e67ebc..36bf4655bc3d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -432,7 +432,7 @@ bool pgattr_change_is_safe(pteval_t old, pteval_t new);
  *   1      0      |   1           0          1
  *   1      1      |   0           1          x
  *
- * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
+ * When hardware DBM is not present, the software PTE_DIRTY bit is updated via
  * the page fault mechanism. Checking the dirty status of a pte becomes:
  *
  *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
@@ -598,7 +598,7 @@ static inline int pte_protnone(pte_t pte)
 	/*
 	 * pte_present_invalid() tells us that the pte is invalid from HW
 	 * perspective but present from SW perspective, so the fields are to be
-	 * interpretted as per the HW layout. The second 2 checks are the unique
+	 * interpreted as per the HW layout. The second 2 checks are the unique
 	 * encoding that we use for PROT_NONE. It is insufficient to only use
 	 * the first check because we share the same encoding scheme with pmds
 	 * which support pmd_mkinvalid(), so can be present-invalid without
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 0cde2f473971..e65f33edf9d6 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -23,7 +23,7 @@ struct cpu_suspend_ctx {
  * __cpu_suspend_enter()'s caller, and populated by __cpu_suspend_enter().
  * This data must survive until cpu_resume() is called.
  *
- * This struct desribes the size and the layout of the saved cpu state.
+ * This struct describes the size and the layout of the saved cpu state.
  * The layout of the callee_saved_regs is defined by the implementation
  * of __cpu_suspend_enter(), and cpu_resume(). This struct must be passed
  * in by the caller as __cpu_suspend_enter()'s stack-frame is gone once it
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7aca29e1d30b..d1ac0e58651c 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -133,7 +133,7 @@ static int __init acpi_fadt_sanity_check(void)
 
 	/*
 	 * FADT is required on arm64; retrieve it to check its presence
-	 * and carry out revision and ACPI HW reduced compliancy tests
+	 * and carry out revision and ACPI HW reduced compliance tests
 	 */
 	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
 	if (ACPI_FAILURE(status)) {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5ed401ff79e3..5c673778e28f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1002,7 +1002,7 @@ static void __init sort_ftr_regs(void)
 
 /*
  * Initialise the CPU feature register from Boot CPU values.
- * Also initiliases the strict_mask for the register.
+ * Also initialises, the strict_mask for the register.
  * Any bits that are not covered by an arm64_ftr_bits entry are considered
  * RES0 for the system-wide value, and must strictly match.
  */
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 5adad37ab4fa..5a1554a44162 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -492,7 +492,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		return ret;
 
 	/*
-	 * When using mcount, callsites in modules may have been initalized to
+	 * When using mcount, callsites in modules may have been initialized to
 	 * call an arbitrary module PLT (which redirects to the _mcount stub)
 	 * rather than the ftrace PLT we'll use at runtime (which redirects to
 	 * the ftrace trampoline). We can ignore the old PLT when initializing
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 6f121a0164a4..239c16e3d02f 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -251,7 +251,7 @@ void crash_post_resume(void)
  * marked as Reserved as memory was allocated via memblock_reserve().
  *
  * In hibernation, the pages which are Reserved and yet "nosave" are excluded
- * from the hibernation iamge. crash_is_nosave() does thich check for crash
+ * from the hibernation image. crash_is_nosave() does thich check for crash
  * dump kernel and will reduce the total size of hibernation image.
  */
 
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 2799bdb2fb82..941668800aea 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -131,7 +131,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	struct uprobe_task *utask = current->utask;
 
 	/*
-	 * Task has received a fatal signal, so reset back to probbed
+	 * Task has received a fatal signal, so reset back to probed
 	 * address.
 	 */
 	instruction_pointer_set(regs, utask->vaddr);
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 95169f7b6531..965b03fedfb8 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -202,7 +202,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 /*
  * do_sdei_event() returns one of:
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
- *  SDEI_EV_FAILED  -  failure, return this error code to firmare.
+ *  SDEI_EV_FAILED  -  failure, return this error code to firmware.
  *  virtual-address -  success, return to this address.
  */
 unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 68cea3a4a35c..a0bfe624f899 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -350,7 +350,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 
 	/*
 	 * Now that the dying CPU is beyond the point of no return w.r.t.
-	 * in-kernel synchronisation, try to get the firwmare to help us to
+	 * in-kernel synchronisation, try to get the firmware to help us to
 	 * verify that it has really left the kernel before we consider
 	 * clobbering anything it might still be using.
 	 */
@@ -523,7 +523,7 @@ int arch_register_cpu(int cpu)
 
 	/*
 	 * Availability of the acpi handle is sufficient to establish
-	 * that _STA has aleady been checked. No need to recheck here.
+	 * that _STA has already been checked. No need to recheck here.
 	 */
 	c->hotpluggable = arch_cpu_is_hotpluggable(cpu);
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 681939ef5d16..914282016069 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -922,7 +922,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
 	__show_regs(regs);
 
 	/*
-	 * We use nmi_panic to limit the potential for recusive overflows, and
+	 * We use nmi_panic to limit the potential for recursive overflows, and
 	 * to get a better stack trace.
 	 */
 	nmi_panic(NULL, "kernel stack overflow");
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index dbd74e4885e2..ebcb7f1a55ee 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -815,7 +815,7 @@ static void timer_set_traps(struct kvm_vcpu *vcpu, struct timer_map *map)
 		tpt = tpc = true;
 
 	/*
-	 * For the poor sods that could not correctly substract one value
+	 * For the poor sods that could not correctly subtract one value
 	 * from another, trap the full virtual timer and counter.
 	 */
 	if (has_broken_cntvoff() && timer_get_offset(map->direct_vtimer))
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 4e16f9b96f63..0ee7ebb2485e 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -115,7 +115,7 @@ static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 	 *
 	 * FFA-1.3 introduces 64-bit variants of the CPU cycle management
 	 * interfaces. Moreover, FF-A 1.3 clarifies that SMC32 direct requests
-	 * complete with SMC32 direct reponses which *should* allow us use the
+	 * complete with SMC32 direct responses which *should* allow us use the
 	 * function ID sent by the caller to determine whether to return x8-x17.
 	 *
 	 * Note that we also cannot rely on function IDs in the response.
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7cc964af8d30..9a6a80c3fbe5 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1755,7 +1755,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	/*
 	 * Check if this is non-struct page memory PFN, and cannot support
-	 * CMOs. It could potentially be unsafe to access as cachable.
+	 * CMOs. It could potentially be unsafe to access as cacheable.
 	 */
 	if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP) && !pfn_is_map_memory(pfn)) {
 		if (is_vma_cacheable) {
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 7a045cad6bdf..4c16dbbd6e90 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -85,7 +85,7 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	/*
 	 * Let's treat memory allocation failures as benign: If we fail to
 	 * allocate anything, return an error and keep the allocated array
-	 * alive. Userspace may try to recover by intializing the vcpu
+	 * alive. Userspace may try to recover by initializing the vcpu
 	 * again, and there is no reason to affect the whole VM for this.
 	 */
 	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ab83089c3d8f..3cfdb77fb47c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -3053,7 +3053,7 @@ bool bpf_jit_supports_exceptions(void)
 	/* We unwind through both kernel frames starting from within bpf_throw
 	 * call and BPF frames. Therefore we require FP unwinder to be enabled
 	 * to walk kernel frames and reach BPF frames in the stack trace.
-	 * ARM64 kernel is aways compiled with CONFIG_FRAME_POINTER=y
+	 * ARM64 kernel is always, compiled with CONFIG_FRAME_POINTER=y
 	 */
 	return true;
 }
-- 
2.34.1


