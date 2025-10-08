Return-Path: <linux-kernel+bounces-845988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD7BC6A73
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBCAB4E566C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210D92BFC60;
	Wed,  8 Oct 2025 21:13:22 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF5224AF3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958001; cv=none; b=rOG8/0055FgIunrMco+exkWLPxKp756pJ0gu74SH/4mJyGJa27talHIeIR2ERtkw1DLiYf6Ads8XrClpwmd+L7XajXalDncYWb4s8tDbQOmCJHDIKccLVpXYiRo9UbshWNImdGotajqsOnogfC/uCHl6JU6+B5a2CkxkvF0FXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958001; c=relaxed/simple;
	bh=U9GL6SiUkluJTue8UfxVFwIkJr4z3l59ge0YZH7aNuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQKfiZ6GWKkmJ7mFtwf9VnJZm+y4Uc8DCJb5kZ0D2UBf6mXINOI97whUfgc6fDXZSYihCwxQYQG0UxTITNMpZoaoC0jtE2m7QIFzaIm6S2s5ivtRW9rZKrMJc29HAXHbY2zKOzCvyIOFgvLzOvjCSp20P4Ci1R+bDxiy8HxZCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7810214dda9so49345b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957999; x=1760562799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLh4JfqdToTCSFHPlw/HO3cQZJoXYFuBoaG7iGYgs6U=;
        b=SXlYoOHxZL0R1VHCGgiwBfpt5Hnki6zvCwH8mwRYgola5AfejihLqZOn6Xki4Rm4tm
         qfv+xBAZf2CLaQ9fJAj9315mj3oZI32KUh1NGoHCqnVf/2ny4N0TJTpEtS3e919Z/PZr
         4cx2CK5sM2kisxlWDMr8DU1v7B7GLl4ZwMY6LnbQ4zAuVhpUf1NQMCaLy2hhmptyqu2R
         zagluvM3lNJXzGZEXcAwdPHSghfOkSwvkWIZK8k+plLC6dYw3twgDGx2OzBrVefUP9rK
         5C9DYQfUPsQKoMhFeeCoFHbRpxZSE+bUI2c5e4aFGS/vbHOt2RwhTqG/lq9fDNcIj5dY
         q9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaITJxrvwNEpXsZhnQYQYeHaImE34tMvEWml1JiUfOBAbaNlQt2ieetvChV5nGtrPpbLGYrvmb5OoRzao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlkwu338swSC6+aT1HWP/ENvpH9xUlG8fMekTlnBHC4by8S6in
	NlCIl2VPIVuJ5CCz0Uio1N1BsjslMZLQnpW5oS0mKmLGCfoB6LmEVERj
X-Gm-Gg: ASbGnctnPNJF6x7+0oo0YmN3I0fuTTDRzMr/YRiWlcXX5PJ8c/9kdYQUSqQdJefSPxr
	KOTVEkRAMniwhl1Qdo1RHDVwdueQyzczMQYSmiof2DMp/oRDTJ7U9VEawBR7PFiy7LuBfDvqBU+
	j7uRKhkPJCaAzlfafL0s09QgZkcHCtLMyuaPLJYKscTtpDEVHWQpwdUtsi/MrC8DWsUIQLCMP2b
	8JD3OFfT9wkLzS9lPQfNels+6n9sOju4EM9go3GrhUFSm+VgBKr43Bvgkh1uj3lXtGj25e2ah+i
	FarXYBqpVGah5cYkBZeRyZPacS2N4F0PHDCv3rVvJ9lhyYGnjKDpV0iUa+Y6mTUAJL5ApY0eq89
	ocMPJ7Ejj9U5UnK7jYPawMQ5An/8YEn4LpJdx18VCBjyJLkC6mNu8HjjNQZPaGvabINSp8FFK85
	RwV2T3k5xZ0f+MaNEBSXR6xSY=
X-Google-Smtp-Source: AGHT+IFSVR1KgZV2nCh81HvRh5o+4N6nOInRYrHDDvVbq5J5rsHIk6/TNC0RmNewXwvlmXbU/eC8yw==
X-Received: by 2002:a05:6a00:a589:b0:781:21db:4e06 with SMTP id d2e1a72fcca58-79382794da2mr3112777b3a.0.1759957998850;
        Wed, 08 Oct 2025 14:13:18 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e33efc46sm666364b3a.74.2025.10.08.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:13:18 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH] arm64: cpufeature: Don't cpu_enable_mte() when KASAN_GENERIC is active
Date: Wed,  8 Oct 2025 21:04:27 +0000
Message-ID: <20251008210425.125021-3-ysk@kzalloc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a kernel built with CONFIG_KASAN_GENERIC=y is booted on MTE-capable
hardware, a kernel panic occurs early in the boot process. The crash
happens when the CPU feature detection logic attempts to enable the Memory
Tagging Extension (MTE) via cpu_enable_mte().

Because the kernel is instrumented by the software-only Generic KASAN,
the code within cpu_enable_mte() itself is instrumented. This leads to
a fatal memory access fault within KASAN's shadow memory region when
the MTE initialization is attempted. Currently, the only workaround is
to boot with the "arm64.nomte" kernel parameter.

This bug was discovered during work on supporting the Debian debug kernel
on the Arm v9.2 RADXA Orion O6 board:

 https://salsa.debian.org/kernel-team/linux/-/merge_requests/1670

Related kernel configs:

 CONFIG_ARM64_AS_HAS_MTE=y
 CONFIG_ARM64_MTE=y

 CONFIG_KASAN_SHADOW_OFFSET=0xdfff800000000000
 CONFIG_HAVE_ARCH_KASAN=y
 CONFIG_HAVE_ARCH_KASAN_SW_TAGS=y
 CONFIG_HAVE_ARCH_KASAN_HW_TAGS=y
 CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
 CONFIG_CC_HAS_KASAN_GENERIC=y
 CONFIG_CC_HAS_KASAN_SW_TAGS=y

 CONFIG_KASAN=y
 CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
 CONFIG_KASAN_GENERIC=y

The panic log clearly shows the conflict:

[    0.000000] kasan: KernelAddressSanitizer initialized (generic)
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.2
[    0.000000] percpu: Embedded 486 pages/cpu s1950104 r8192 d32360 u1990656
[    0.000000] pcpu-alloc: s1950104 r8192 d32360 u1990656 alloc=486*4096
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Address authentication (architected QARMA3 algorithm)
[    0.000000] CPU features: detected: GICv3 CPU interface
[    0.000000] CPU features: detected: HCRX_EL2 register
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Memory Tagging Extension
[    0.000000] CPU features: detected: Asymmetric MTE Tag Check Fault
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: detected: SSBS not fully self-synchronizing
[    0.000000] Unable to handle kernel paging request at virtual address dfff800000000005
[    0.000000] KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000005
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x05: level 1 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] [dfff800000000005] address between user and kernel address ranges
[    0.000000] Internal error: Oops: 0000000096000005 [#1]  SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.17+unreleased-debug-arm64 #1 PREEMPTLAZY  Debian 6.17-1~exp1
[    0.000000] pstate: 800000c9 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : cpu_enable_mte+0x104/0x440
[    0.000000] lr : cpu_enable_mte+0xf4/0x440
[    0.000000] sp : ffff800084f67d80
[    0.000000] x29: ffff800084f67d80 x28: 0000000000000043 x27: 0000000000000001
[    0.000000] x26: 0000000000000001 x25: ffff800084204008 x24: ffff800084203da8
[    0.000000] x23: ffff800084204000 x22: ffff800084203000 x21: ffff8000865a8000
[    0.000000] x20: fffffffffffffffe x19: fffffdffddaa6a00 x18: 0000000000000011
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    0.000000] x14: 0000000000000000 x13: 0000000000000001 x12: ffff700010a04829
[    0.000000] x11: 1ffff00010a04828 x10: ffff700010a04828 x9 : dfff800000000000
[    0.000000] x8 : ffff800085024143 x7 : 0000000000000001 x6 : ffff700010a04828
[    0.000000] x5 : ffff800084f9d200 x4 : 0000000000000000 x3 : ffff8000800794ac
[    0.000000] x2 : 0000000000000005 x1 : dfff800000000000 x0 : 000000000000002e
[    0.000000] Call trace:
[    0.000000]  cpu_enable_mte+0x104/0x440 (P)
[    0.000000]  enable_cpu_capabilities+0x188/0x208
[    0.000000]  setup_boot_cpu_features+0x44/0x60
[    0.000000]  smp_prepare_boot_cpu+0x9c/0xb8
[    0.000000]  start_kernel+0xc8/0x528
[    0.000000]  __primary_switched+0x8c/0xa0
[    0.000000] Code: 9100c280 d2d00001 f2fbffe1 d343fc02 (38e16841)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 arch/arm64/kernel/cpufeature.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5ed401ff79e3..a0a9fa1b376d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2340,6 +2340,24 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 
 	kasan_init_hw_tags_cpu();
 }
+
+static bool has_usable_mte(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	if (!has_cpuid_feature(entry, scope))
+		return false;
+
+	/*
+	 * MTE and Generic KASAN are mutually exclusive. Generic KASAN is a
+	 * software-only mode that is incompatible with the MTE hardware.
+	 * Do not enable MTE if Generic KASAN is active.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) && kasan_enabled()) {
+		pr_warn_once("MTE capability disabled due to Generic KASAN conflict\n");
+		return false;
+	}
+
+	return true;
+}
 #endif /* CONFIG_ARM64_MTE */
 
 static void user_feature_fixup(void)
@@ -2850,7 +2868,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Memory Tagging Extension",
 		.capability = ARM64_MTE,
 		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_usable_mte,
 		.cpu_enable = cpu_enable_mte,
 		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, MTE, MTE2)
 	},
@@ -2858,21 +2876,21 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Asymmetric MTE Tag Check Fault",
 		.capability = ARM64_MTE_ASYMM,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_usable_mte,
 		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, MTE, MTE3)
 	},
 	{
 		.desc = "FAR on MTE Tag Check Fault",
 		.capability = ARM64_MTE_FAR,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_usable_mte,
 		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, MTEFAR, IMP)
 	},
 	{
 		.desc = "Store Only MTE Tag Check",
 		.capability = ARM64_MTE_STORE_ONLY,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_usable_mte,
 		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, MTESTOREONLY, IMP)
 	},
 #endif /* CONFIG_ARM64_MTE */
-- 
2.51.0


