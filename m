Return-Path: <linux-kernel+bounces-808287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B2B4FD8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C546188BE7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6CB350827;
	Tue,  9 Sep 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVv8kbt6"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947334575B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425007; cv=none; b=tPDB8B1g++vaHoy5+3NQfiePVfSR48qSQVpEIvDTgynpsklFWO31kkSnp81AVAIP2rGF/3I+nUCC3mzN+txj6K7W+t9GsIcq76qQOM89TU69aUczruKtYO0982JGYS5pyVtXLXFqQ+a4LbMXYxMxh5oxFRHOP4gC1A/nba5TFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425007; c=relaxed/simple;
	bh=1jUbV2w9NIp9JNhFFgwdG1HeX8G5TcJfmUWpWozhTZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hunMliV+9wSDeCbs2YUX4phlI5LfVHeZP9yRMfnKRMKm4oZSJPyH8rmE2HWDk2doGcMJl02EG29GY5qVAP5w5/08lV7+L7S3y/NoDG+zbGYm5jhVyBEY6G8gdGUUjsen1lYfNDGPTvH3r8cSwL2DqR5VuqL/DsRNl75Z4SlGZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVv8kbt6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45de07b831dso16744205e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757425002; x=1758029802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ejP7jVX3oQKxjUP0aHsAIaSpTtnAmNmXF173kk9bzw=;
        b=bVv8kbt6OPi47pe79dbtI36k4NbOxqCxGEU6tWbqZ095ZB3Bb2OPBFlS3H8o7sJ84Z
         ZfNfdrZZJODJ5ZGPoJX3UCPT/6ZVCKiLMoZV66suu1oRDCeu/xHCqmThbTYhe6gNTeTM
         31ka6K2L2qC31cDPnP0+RTRJO/ziK0CZpWChXvVfOsOTVO3J0mkVWBZfzMVCaolVnhTF
         /d0IT96W8SWaZLbCWZO1DCyPlKTSF01ZMMxVffD7kI5EEZ7Y+t8nBRS+99T/thSQU0Rg
         qO5D+iscTHOxfqXzmsp9LngPkmiZXHOj4tm3IXoCezSMkzM0+pEv77Zgr12Jm9l6u3UL
         ghcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425002; x=1758029802;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ejP7jVX3oQKxjUP0aHsAIaSpTtnAmNmXF173kk9bzw=;
        b=Tx9V+twlZextkJyIOvVZtUENK2yj2XdbAOPLxva4fZBTq75ZOHziYxrDKCmYo6JaiX
         y0rC8CA7kPFI/W6+tuiNdZ5lUtJhpIAmzRevd+b2cFbNr2wdr+LJBpq6Ck3H5vTPwKNC
         XUlo2B1CYjYHV7ytW7/M8hXOEgCRHvx/V0Z7tTaySvkkY686nWSsNyWbjVIhfo2UKP1/
         om9dfA8PMEDOYiYS24ODvNPV5rduCSs32zgqES6pFLWfwXpE14VchdNVbL+xH8o2vGI+
         GSNc/844HZ2d9QIlBHzIXFRW6Z+9L0tcf9BFwbtg5iCIgMC7Cc839/GBRk8VS96IRuXU
         ONIg==
X-Forwarded-Encrypted: i=1; AJvYcCVuCov4WorCtxCSVveLGvUmSxmKPYzL5UABxC+HOYauryw6o8v8SGTWQ96oqOGtIS2YPgOHMGJkQHCex9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMCJiQDXjAZrF6vS2CyAEBLUz1P3kCVpaNr6g0SISrzfU/xOA
	MxPjnqiR0R26R8KwGqZ4k3m62wRfLzPVIaOhCDmq9xOZygSa48sbPT0OFq6W8MAvwFFG9Wkl1XS
	DBLKO6Bxz/4Z8rg==
X-Google-Smtp-Source: AGHT+IEZ4MmWEqJ4zcjlEgRxSK3Lw+dH71yaATrmPGW/tzAa4gHwSjlPd/5GfSIOf/nbPGOdCuFEx5PEaVOpHw==
X-Received: from wmtk8.prod.google.com ([2002:a05:600c:c4a8:b0:45d:24fb:e425])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470d:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-45ddde815a1mr94298705e9.2.1757425002214;
 Tue, 09 Sep 2025 06:36:42 -0700 (PDT)
Date: Tue,  9 Sep 2025 13:36:30 +0000
In-Reply-To: <20250909133631.3844423-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909133631.3844423-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909133631.3844423-2-smostafa@google.com>
Subject: [PATCH v2 1/2] KVM: arm64: Dump instruction on hyp panic
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, perret@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>, Kunwu Chan <chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Similar to the kernel panic, where the instruction code is printed,
we can do the same for hypervisor panics.

This patch does that only in case of =E2=80=9CCONFIG_NVHE_EL2_DEBUG=E2=80=
=9D or nvhe.

The next patch adds support for pKVM.

Also, remove the hardcoded argument dump_kernel_instr().

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/arm64/include/asm/traps.h |  1 +
 arch/arm64/kernel/traps.c      | 15 +++++++++------
 arch/arm64/kvm/handle_exit.c   |  5 +++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.=
h
index e3e8944a71c3..e92e4a0e48fc 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -36,6 +36,7 @@ int kasan_brk_handler(struct pt_regs *regs, unsigned long=
 esr);
 int ubsan_brk_handler(struct pt_regs *regs, unsigned long esr);
=20
 int early_brk64(unsigned long addr, unsigned long esr, struct pt_regs *reg=
s);
+void dump_kernel_instr(unsigned long kaddr);
=20
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index f528b6041f6a..83e6d1409e1f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -149,19 +149,18 @@ pstate_check_t * const aarch32_opcode_cond_checks[16]=
 =3D {
=20
 int show_unhandled_signals =3D 0;
=20
-static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
+void dump_kernel_instr(unsigned long kaddr)
 {
-	unsigned long addr =3D instruction_pointer(regs);
 	char str[sizeof("00000000 ") * 5 + 2 + 1], *p =3D str;
 	int i;
=20
-	if (user_mode(regs))
+	if (!is_ttbr1_addr(kaddr))
 		return;
=20
 	for (i =3D -4; i < 1; i++) {
 		unsigned int val, bad;
=20
-		bad =3D aarch64_insn_read(&((u32 *)addr)[i], &val);
+		bad =3D aarch64_insn_read(&((u32 *)kaddr)[i], &val);
=20
 		if (!bad)
 			p +=3D sprintf(p, i =3D=3D 0 ? "(%08x) " : "%08x ", val);
@@ -169,7 +168,7 @@ static void dump_kernel_instr(const char *lvl, struct p=
t_regs *regs)
 			p +=3D sprintf(p, i =3D=3D 0 ? "(????????) " : "???????? ");
 	}
=20
-	printk("%sCode: %s\n", lvl, str);
+	printk(KERN_EMERG "Code: %s\n", str);
 }
=20
 #define S_SMP " SMP"
@@ -178,6 +177,7 @@ static int __die(const char *str, long err, struct pt_r=
egs *regs)
 {
 	static int die_counter;
 	int ret;
+	unsigned long addr =3D instruction_pointer(regs);
=20
 	pr_emerg("Internal error: %s: %016lx [#%d] " S_SMP "\n",
 		 str, err, ++die_counter);
@@ -190,7 +190,10 @@ static int __die(const char *str, long err, struct pt_=
regs *regs)
 	print_modules();
 	show_regs(regs);
=20
-	dump_kernel_instr(KERN_EMERG, regs);
+	if (user_mode(regs))
+		return ret;
+
+	dump_kernel_instr(addr);
=20
 	return ret;
 }
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index a598072f36d2..99a8205fc104 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -559,6 +559,11 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr,=
 u64 spsr,
 	/* Dump the nVHE hypervisor backtrace */
 	kvm_nvhe_dump_backtrace(hyp_offset);
=20
+	/* Dump the faulting instruction */
+	if (!is_protected_kvm_enabled() ||
+	    IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
+		dump_kernel_instr(panic_addr + kaslr_offset());
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
--=20
2.51.0.384.g4c02a37b29-goog


