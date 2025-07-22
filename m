Return-Path: <linux-kernel+bounces-741315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFDB0E2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2401188DC28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926F281376;
	Tue, 22 Jul 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3fQihfSt"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA0280339
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205920; cv=none; b=GZjpg4T6ehNlRtu4cIAglUI2t55jAo31J/z9FTLvpF8G7CsuEIXuEN0cYBCKzeh/NYVQPGv13XuasTooMmi501vii6qq1GMz+Qb2lvLsOAqrRbzaKLqTyHyejZrwwUcRoCW0q40l7gQq1evlwMjLeOe926BRedU2i4Dso/vkSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205920; c=relaxed/simple;
	bh=YpxOG2TsBFmJTbwEppASaFu8JfCqJGH4+EWAhuNSceU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuE0rZCMw82TPWaGTC0/MpVSxVPDZIyDfP1lLlwvjCIXIey33wr7u1yUK/ACRKqsm3BwNnII3q6uzYyKSHVzyfcs2aegjNn3JiAa+oQW3tFqOH6mKNAT/uYgBN/dm+waT1/pj9U9euMm4/z0IkX3Cu25ZowzFUZDqeJxidn833I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3fQihfSt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e34399cdb2so607471485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753205918; x=1753810718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW4csVV0UWW4773SLdvTdDiMmcrFmADNMqZ78npo3qA=;
        b=3fQihfStllnAfwJz9gYUCpLHdyT7kZHAIoqPK3SdK0RwHFiVtOMFlKB0BWfOT7nN51
         wLi9oDgoE03RYBu9PHZ+o7A0kxY0bhq8lpAwcGQEGiV4oiZUQYJBaLVyMkwaKDskr45K
         qCc9gaKDq1zgT9YIHB3OOgMwUMyAWu+upQnU4UiONt7ULA1DaaJgu6JFwCUPQEDNW/LV
         R6qQ6Y38vht8xF8x8js5Hf9yYcTDQr1gkbkyEFbCIXHeHfcD6JvdHD//9VI7aAcxh18W
         tvBPC5CJ57hRsCWCcoaM9mtaKcXcagSxLTo3/Jf5H05FyzJwGf/WNaqBRgvCQHqKImhZ
         0bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205918; x=1753810718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW4csVV0UWW4773SLdvTdDiMmcrFmADNMqZ78npo3qA=;
        b=cJV/CbCyVR/wsTfcNovoiYHY7FI3VdMf4NZsi8P99iEYRfspFHC2fRIGkJ2RIlMpTz
         lsZtVcu5UanO8kc0/KkgzkSVh50GyNvE1FTZJ3e1Ao5FjNgVPpVkGPCJZmaZT/7J2qfr
         QRxwiCEs09/rkg+YiNmzatJsewPJce0NSoqhTWrVfzvM9PzhRtTnAU32x5PbEH1XDjQu
         T/WnxxnEFScW1nrTyk4lkZFPHOzglyfqVLGDcHbnnL59s6PMY5YrsdvrrjXpsMCfhr/h
         ioIFSJVU3nYZr2ulvL0FOFRGaBPAH89ynnpz8HU5bXgTDc74SxO3dZAXNSuWNOuAAbpu
         wyXA==
X-Forwarded-Encrypted: i=1; AJvYcCV0VrJJQqraHFSPOs0ebA6X7dj7EDTIRqLfeCZQX2yKz1whrXzmsoofRZWHbXUHMSDI1KiVF24CslAWrFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJSUVRE4IoiGXskKt23sMbIrQ2yottwwZMZ61AATx8/QinVps
	JosSHoaLbd4jeUAvhv60gI6C66+E0LcLOC8+wRAE2+SjGlJvnoexeB63T1N5VEVRCzk=
X-Gm-Gg: ASbGncssZvJ1rO66It/caoNKoCg2KSpGP88jFiJ2iO+1hdaHZAMN1n7vgAQDWrv/SwH
	2koMdbaAMNmAVcjZpOb3tgxvalCmKpVu3pk5E01KkGznoWIBcQznTYPspvmi6kmUWzf1keTmcks
	eWgCgk5ZFhGsGMM0ftIFkSpcBGpFzexLsSMKtyC3/lFWJt6edRNHuhH6NfeQsQ5XsLIMgvo/HnJ
	K1UrvZisKVkAcHkDmc/Zf2h0mzSWOb7fotoekrRb5+yLBfCwMpOWhJoRb8BEU/Dcx2Hz46b2gep
	Er9yX0rgjycH6qMdHe9gjCtrQ2BKZMZg7Zhe13MvkMAjpLeWTwyue0Mg+UIL/1ncMPBEkhoACwl
	jlN2f0+wG32tZHw0NSFMmTH5kl2/VEOocbPcfaWNNmw01tx5n/OSx4dP+FjT7XLld1DRxpN4JI3
	fOjXcIPE0spuI=
X-Google-Smtp-Source: AGHT+IGBDrTWn4V/STPt6DOLmJtCWDCzg0HfHNyXs5XppmVHnd6/xaUauxoLwI7I4C+gvMI7ST37gQ==
X-Received: by 2002:a05:6214:62c:b0:6fd:61b6:3360 with SMTP id 6a1803df08f44-707004b3e11mr421686d6.5.1753205918060;
        Tue, 22 Jul 2025 10:38:38 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b783sm54184536d6.73.2025.07.22.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:38:37 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Evan Green <evan@rivosinc.com>,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [RFC PATCH 5/6] riscv: hw_breakpoint: Use icount for single stepping
Date: Tue, 22 Jul 2025 10:38:28 -0700
Message-ID: <20250722173829.984082-6-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722173829.984082-1-jesse@rivosinc.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sdtrig RISC-V ISA extension does not have a resume flag for
returning to and executing the instruction at the breakpoint.
To avoid skipping the instruction or looping, it is necessary to remove
the hardware breakpoint and single step. Use the icount feature of
Sdtrig to accomplish this. Use icount as default with an option to allow
software-based single stepping when hardware or SBI does not have
icount functionality, as it may cause unwanted side effects when reading
the instruction from memory.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/Kconfig                | 11 +++++
 arch/riscv/kernel/hw_breakpoint.c | 81 +++++++++++++++++++++++++------
 2 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95d3047cab10..bbde5e118470 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1105,6 +1105,17 @@ config PARAVIRT_TIME_ACCOUNTING
 
 	  If in doubt, say N here.
 
+config HW_BREAKPOINT_COMPUTE_STEP
+	bool "Allow computing hardware breakpoint step address"
+	default n
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Select this option if hardware breakpoints are desired, but
+	  hardware or SBI does not have icount functionality. This may cause
+	  unwanted side affects when reading the instruction from memory.
+
+	  If unsure, say N.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
index 9e3a3b82d300..437fd82b9590 100644
--- a/arch/riscv/kernel/hw_breakpoint.c
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -20,6 +20,7 @@
 #define DBTR_TDATA1_DMODE		BIT_UL(__riscv_xlen - 5)
 
 #define DBTR_TDATA1_TYPE_MCONTROL	(2UL << DBTR_TDATA1_TYPE_SHIFT)
+#define DBTR_TDATA1_TYPE_ICOUNT		(3UL << DBTR_TDATA1_TYPE_SHIFT)
 #define DBTR_TDATA1_TYPE_MCONTROL6	(6UL << DBTR_TDATA1_TYPE_SHIFT)
 
 #define DBTR_TDATA1_MCONTROL6_LOAD		BIT(0)
@@ -55,6 +56,14 @@
 #define DBTR_TDATA1_MCONTROL_SIZELO_64BIT	1
 #define DBTR_TDATA1_MCONTROL_SIZEHI_64BIT	1
 
+#define DBTR_TDATA1_ICOUNT_U			BIT(6)
+#define DBTR_TDATA1_ICOUNT_S			BIT(7)
+#define DBTR_TDATA1_ICOUNT_PENDING		BIT(8)
+#define DBTR_TDATA1_ICOUNT_M			BIT(9)
+#define DBTR_TDATA1_ICOUNT_COUNT_FIELD		GENMASK(23, 10)
+#define DBTR_TDATA1_ICOUNT_VU			BIT(25)
+#define DBTR_TDATA1_ICOUNT_VS			BIT(26)
+
 /* Registered per-cpu bp/wp */
 static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RV_MAX_TRIGGERS]);
 static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
@@ -65,6 +74,7 @@ static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, sbi_dbtr_shmem);
 
 /* number of debug triggers on this cpu . */
 static int dbtr_total_num __ro_after_init;
+static bool have_icount __ro_after_init;
 static unsigned long dbtr_type __ro_after_init;
 static unsigned long dbtr_init __ro_after_init;
 
@@ -168,6 +178,7 @@ static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
 static void init_sbi_dbtr(void)
 {
 	struct sbiret ret;
+	unsigned long dbtr_count = 0;
 
 	/*
 	 * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
@@ -182,6 +193,25 @@ static void init_sbi_dbtr(void)
 		return;
 	}
 
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+		DBTR_TDATA1_TYPE_ICOUNT, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect icount triggers. error: %ld.\n",
+			__func__, ret.error);
+	} else if (!ret.value) {
+		if (IS_ENABLED(CONFIG_HW_BREAKPOINT_COMPUTE_STEP)) {
+			pr_warn("%s: No icount triggers available. "
+				"Falling-back to computing single step address.\n", __func__);
+		} else {
+			pr_err("%s: No icount triggers available.\n", __func__);
+			dbtr_total_num = 0;
+			return;
+		}
+	} else {
+		dbtr_count = ret.value;
+		have_icount = true;
+	}
+
 	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
 			DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
 	if (ret.error) {
@@ -190,7 +220,7 @@ static void init_sbi_dbtr(void)
 	} else if (!ret.value) {
 		pr_warn("%s: No mcontrol6 triggers available.\n", __func__);
 	} else {
-		dbtr_total_num = ret.value;
+		dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
 		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL6;
 		return;
 	}
@@ -205,7 +235,7 @@ static void init_sbi_dbtr(void)
 		pr_err("%s: No mcontrol triggers available.\n", __func__);
 		dbtr_total_num = 0;
 	} else {
-		dbtr_total_num = ret.value;
+		dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
 		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL;
 	}
 }
@@ -344,6 +374,21 @@ static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
 	return 0;
 }
 
+static int rv_init_icount_trigger(struct arch_hw_breakpoint *hw)
+{
+	unsigned long tdata1 = DBTR_TDATA1_TYPE_ICOUNT;
+
+	/* Step one instruction */
+	tdata1 |= FIELD_PREP(DBTR_TDATA1_ICOUNT_COUNT_FIELD, 1);
+
+	tdata1 |= DBTR_TDATA1_ICOUNT_U;
+
+	hw->tdata1 = tdata1;
+	hw->tdata2 = 0;
+
+	return 0;
+}
+
 int hw_breakpoint_arch_parse(struct perf_event *bp,
 			     const struct perf_event_attr *attr,
 			     struct arch_hw_breakpoint *hw)
@@ -389,24 +434,28 @@ static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
 	/* Remove breakpoint even if return error as not to loop */
 	arch_uninstall_hw_breakpoint(event);
 
-	ret = get_insn(regs, regs->epc, &insn);
-	if (ret < 0)
-		return ret;
+	if (have_icount) {
+		rv_init_icount_trigger(bp);
+	} else {
+		ret = get_insn(regs, regs->epc, &insn);
+		if (ret < 0)
+			return ret;
 
-	next_addr = get_step_address(regs, insn);
+		next_addr = get_step_address(regs, insn);
 
-	ret = get_insn(regs, next_addr, &insn);
-	if (ret < 0)
-		return ret;
+		ret = get_insn(regs, next_addr, &insn);
+		if (ret < 0)
+			return ret;
 
-	bp_insn.bp_type = HW_BREAKPOINT_X;
-	bp_insn.bp_addr = next_addr;
-	/* Get the size of the intruction */
-	bp_insn.bp_len = GET_INSN_LENGTH(insn);
+		bp_insn.bp_type = HW_BREAKPOINT_X;
+		bp_insn.bp_addr = next_addr;
+		/* Get the size of the intruction */
+		bp_insn.bp_len = GET_INSN_LENGTH(insn);
 
-	ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
-	if (ret)
-		return ret;
+		ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
+		if (ret)
+			return ret;
+	}
 
 	ret = arch_install_hw_breakpoint(event);
 	if (ret)
-- 
2.43.0


