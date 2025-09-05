Return-Path: <linux-kernel+bounces-802868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D9B457BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD483A9128
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D5B34F474;
	Fri,  5 Sep 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dns19tEC"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02832C301
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075129; cv=none; b=uOqnnncAQsrCs/WbFskSEvM9ysUmSDsD3P9VYPl8NLmvAVmK1e7QqAoW6lnOHZQXjHu3bYbzwcoaZf+PSgayAvYTYecO8NFohQAowymE9fHampWerwWmIVLn923lCjFCwPUF2xxCs+1msExZMMEzJDfItIO741p98S97sUrNbzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075129; c=relaxed/simple;
	bh=wEhLFCHHS2FQ/BArhhv8A39XsBb0j78cggxuLdMXqYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ap1NZzNJ4fHRTy463hjbaH48PXuUjIdTACS9LQn1nRn5n882D2mOquZJSA7jTB1l2aK3uPs3l0LYEwCsdt4mArD2N4v565NtjEo4VH8ruOELPUK+KJJ4WiyjIVSdwP/ZDdvR4rHyih2WS1fPOuEgw4nKTsJ/Bhdin+7nciUjX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dns19tEC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445826fd9dso25393955ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757075126; x=1757679926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lt3wTba5HiLB1Jjnt9R6GaWmJOoFQXkQR++gb9ZWNVM=;
        b=dns19tECVh74dN/Rn8F+l3wCQXG4ARA3NHm/Cp0EnUnI1KAIYE4oTj0EJUYp1Z27Zg
         oPSV/MSLh/SWn526TqKmAjwGBUz1MzmRRnZn/qSszPkQ5v3+kGLkDFnIUVY5W7sC60+Z
         nncu86QfJ3CMrbwfXPHcm4Qzqe4zvazWMtpzy3SD3d3IZ8S71QHcE/pmnFtfGN2988ZM
         cNW4Qjx+MUUdUZ/0iN9SOaTd9Phl4ejKyMWeo0zP3KyMvJro2pHCxZWkKf8sMiXgzjHl
         H5CBbZFxKV+4AzDsxF6mr9ZxoJAhb2FCCM0/sbgc7ufINo3CYwC4PbvgR7NcAXV/yJIZ
         nang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075126; x=1757679926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lt3wTba5HiLB1Jjnt9R6GaWmJOoFQXkQR++gb9ZWNVM=;
        b=tr3NmXbIOYVVcfyQ8S8352d0rSOOK65q+qfu9D2xoukkEYrrvwlNJci8ZnLKvjCc6F
         JeDBzdjDspTJ0M6wCdIcXym7+waF6J5ZAGNcfYVxriiSfBK5UqJBGwjVfkYKRynjcRjF
         qD6Cvg5II6/FSeEwko7JoqG95QxlZHcFuahpih+QAZUZJ00xsNhqaUOc2upYwv5zO7ZG
         vc8jj/7ls1gH3dmQG4eLReXf+PNYDLoW1ZzU2QbHFeT5XHXitAO7knDjlzW5fbzbQgQ0
         lg+7HH5vHIzSmmugGdZWpngJg9gLTkpvjptJamyojdO0xR8ZN/yss+KHW9/BShLcQco/
         Bg2w==
X-Forwarded-Encrypted: i=1; AJvYcCVGucPuDWtOKgBq0cTTZ8hG1i8pf5j3PsvTi8002MH3r93jQljj+N+UA2W+trV+78PAkc9bZnvqGP40cac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjlpiNjZy3Ih73dvCWBDzzj8IL+qmzh7nZf7s86Xd9coqa+U6+
	EEI/tFi45xNQlXkBy7wMD7+enfpaFYtHmavk9T+A71P9yfqGb4Zi4mCokDbxOZeRqcc=
X-Gm-Gg: ASbGncsMz7+uzDwRjw4xYYaWHoeNANMmWy5QNFMFrr/UPcsaSOOHV1mk3wimFFgPWS0
	KH1HtSyqQdOoTDGqcyIFhn+Jl0J5riINZ9NLvUuRa5itBZFSy7A28oRhV3p610HyvfhZPA5akXa
	gOPcplMJbViSMsIETotNi87Oj4AuNwdJhfTof3IQACv5XSw4hABwC7ONxeXJFwffgQq7YMEHgLp
	GCBsmYTXthyhCTGnNBWVkXRtgZWCHLv4TF4wXAybUhrAI7yYkWmqKtK4p/9JjqNo9sYTIrL4jpg
	icE1D6TVTvRzWhUsz6pPo/li+PQuXSXvaO8tORG4acclmdzS1Nj13Dji2BWlv0r8tYWnWf/mHRm
	eGEqbfLGoQ+5UsCu5wyyf46q9RZyGGoXiPQGV9jVwTNpPMLq0JX7fSw==
X-Google-Smtp-Source: AGHT+IHis+PqALG8tubNoGDFf9m6dFRkq8Qrsc4cRLOgmsEFTlFHoYeOzdbeXp8E6o75X+gtKjjeRA==
X-Received: by 2002:a17:903:28c:b0:249:1213:6725 with SMTP id d9443c01a7336-24944aef6f6mr275376745ad.50.1757075126264;
        Fri, 05 Sep 2025 05:25:26 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb6f17a2dsm48367725ad.75.2025.09.05.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:25:25 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: Enable HOTPLUG_PARALLEL for secondary CPUs
Date: Fri,  5 Sep 2025 17:55:12 +0530
Message-ID: <20250905122512.71684-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core kernel already supports parallel bringup of secondary
CPUs (aka HOTPLUG_PARALLEL). The x86 and MIPS architectures
already use HOTPLUG_PARALLEL and ARM is also moving toward it.

On RISC-V, there is no arch specific global data accessed in the
RISC-V secondary CPU bringup path so enabling HOTPLUG_PARALLEL for
RISC-V would only requires:
1) Providing RISC-V specific arch_cpuhp_kick_ap_alive()
2) Calling cpuhp_ap_sync_alive() from smp_callin()

This patch is tested natively with OpenSBI on QEMU RV64 virt machine
with 64 cores and also tested with KVM RISC-V guest with 32 VCPUs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig          |  2 +-
 arch/riscv/kernel/smpboot.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4b233a0659e..d5800d6f9a15 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -196,7 +196,7 @@ config RISCV
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
+	select HOTPLUG_PARALLEL if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 601a321e0f17..d85916a3660c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -39,7 +39,9 @@
 
 #include "head.h"
 
+#ifndef CONFIG_HOTPLUG_PARALLEL
 static DECLARE_COMPLETION(cpu_running);
+#endif
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
@@ -179,6 +181,12 @@ static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 	return -EOPNOTSUPP;
 }
 
+#ifdef CONFIG_HOTPLUG_PARALLEL
+int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
+{
+	return start_secondary_cpu(cpu, tidle);
+}
+#else
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret = 0;
@@ -199,6 +207,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 
 	return ret;
 }
+#endif
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
@@ -225,6 +234,10 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+#ifdef CONFIG_HOTPLUG_PARALLEL
+	cpuhp_ap_sync_alive();
+#endif
+
 	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
 
@@ -243,7 +256,9 @@ asmlinkage __visible void smp_callin(void)
 	 */
 	local_flush_icache_all();
 	local_flush_tlb_all();
+#ifndef CONFIG_HOTPLUG_PARALLEL
 	complete(&cpu_running);
+#endif
 	/*
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
-- 
2.43.0


