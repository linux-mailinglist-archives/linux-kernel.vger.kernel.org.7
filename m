Return-Path: <linux-kernel+bounces-725695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E8B0027F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6041C25381
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29440233D64;
	Thu, 10 Jul 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jcsn0TT2"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96525A327
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151994; cv=none; b=T+GlQIfBDSWse2ocs1xDcbQ9pzn0/g4nCfuXvR+xod1FP6OZHDX1+SDOE2l0z/sQ1NNaAmNsXSxPikWJF1CetKdACSI7PWJcpi+CT9Zy6uIrpCyq84/4ggUXi5Uj9MhIYuDsbQQNmSseZQp7mhBdlsI3YSGhz6Ge9Ethce11STw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151994; c=relaxed/simple;
	bh=ld31PWs3Hu9yneai6gIrFhnFitW5QOaiKmgVGP+gL4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cu+mB70c00dzVuvY55oLxrEE74Tkd5J9pwR9bkwPjywwOjeVfRD0wWLrTL0vzuY+CI8HgMczI0w68Imqu4ELdcw8A0AI5GSbJr2vR9/96X7z0CGImqozWCpuvROxwMesJvg0scmDf/liFoAZJ/OoqrzftPqlvN86ctoT/NziIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jcsn0TT2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237e6963f63so5600965ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752151992; x=1752756792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUBrApPl0MrERM7TPlmT1Q+HLECusX9y+4Bm+UR5Vho=;
        b=Jcsn0TT2vCVFrzy1cId3MCfOM1VCqZYWDxMSyemzGlEOyq+LL+LM1PlLhD4mHcz0Oz
         QMTE/RbQK+tagNXbFsBiNc6e/2KxDhoT/9KFirwkNI6MOn+6azBdI8DwlAFO+sWS4ShK
         1G+Sl33afsGDKGKY+4+Q+TRZU06BIK4uBVU1kEUzEIHuedP+Qe7AtrgIc7JNRfh8sxNT
         va54VIto8F1qlYWohU9nl7AJKP1YPggtpmx5aPll4WNXzKBKKp6NPXhau5IHZm2/xSl6
         cgwdbUu12g8qeLZcPLR92ZeNtCvQfANKPx7B/OQSwP4uv4Txw4DR4Wd3Vpul4m7et1lM
         5O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151992; x=1752756792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUBrApPl0MrERM7TPlmT1Q+HLECusX9y+4Bm+UR5Vho=;
        b=DHx7wqYEOfTpzBkqXnpzEDmqy2cEIWWItmBUcQD81zzxkE0hAZb9H7V5Hx4DJ/jwCi
         xao5NMUBbn9swRr0PPxRvGv8m236OLNnFFzjVHTj7X6Qv4SvnzKl4Gw72ivb8IS/1iXE
         9RCbu96e4hzT6zolfVmI6SHHCNhUbBhfPWX2MBGhuk57NSqGckGDsvithikyhLOBYDg8
         u8dUc9SQ4vBNS1nMNPjfbRXhVMRnGv+g3hkFBIy2umQB8oXOJxzaD4/klsdhHETWZgdu
         9w5rxddUNhYrsSgKckbxJdKpx30bXoXTQEjsoNT/kviVcWNFz2yoPoIeus841ZpB2yP3
         GEww==
X-Forwarded-Encrypted: i=1; AJvYcCVEoVxHG4Z6oSdZqWOH/nUrHOMIR41Wt4UBN114CperBoPFumLPwPU3/qJgl02LiXBewBSuPTAvnOds8uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFCpc02quFOeuGzcK8T+hOyzmOrTGkkzH7mZrwQKZSYjORlxm
	yrKU/8ze9S03ZcLdAiI0YNXw8qMEWB3/TUNh8j0O8pWErcuppfdfBKV6s4QDMmGw/Y4=
X-Gm-Gg: ASbGncsSvzl93iv+rzpdmr9WS1xWTFg9jXuINs9xYz4rx/T6PgOarfygw/Lxn5xbwH3
	d7VkaE9ROg63ljuI+3nFG8/HfrrSmgBzGtwBeVvzi1FoGNS8pBavQcrksyawiUhDvmjgEWPcx0z
	f5Qb2qDzcVb/cQAH0SgFsOppAYseiEhljiGGjmUf81Y6uHSsCJHj4Rq/iJJNnLdUOCd5RHfiYKA
	m0/4C2tOJ06BdM1u9XklUJ95pqn88QvpUVoX4B81eVP4wtG/IcYG4bB6Luky2kkuY8BbtQu+aVM
	9ObQWvCNvZZwPfYWsreeUzIDJakP9NW4nMleGtAwGTymXhGCSgI/4tWw+drfMzpS23UZAtAXUpC
	V9FG3GPASb4rnQ1Ialv0rSJU=
X-Google-Smtp-Source: AGHT+IECC5RCUDFesBFKIGtzIqiXdOPLJM2WpklrFQrN23THe850wIGVmIvvtP/kcyttO68OTh974g==
X-Received: by 2002:a17:902:ecc4:b0:235:e71e:a37b with SMTP id d9443c01a7336-23de488bf09mr36603995ad.34.1752151991421;
        Thu, 10 Jul 2025 05:53:11 -0700 (PDT)
Received: from ventana-bhyve.dc1.ventanamicro.com ([49.37.251.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359c68sm19230715ad.213.2025.07.10.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:53:11 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH v1 2/2] riscv: Introduce support for hardware break/watchpoints
Date: Thu, 10 Jul 2025 18:22:31 +0530
Message-ID: <20250710125231.653967-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710125231.653967-1-hchauhan@ventanamicro.com>
References: <20250710125231.653967-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V hardware breakpoint framework is built on top of perf subsystem
and uses SBI debug trigger extension to
install/uninstall/update/enable/disable hardware triggers as specified
in Sdtrig ISA extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/hw_breakpoint.h | 320 ++++++++++++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 657 +++++++++++++++++++++++++
 arch/riscv/kernel/traps.c              |   6 +
 6 files changed, 987 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d71ea0f4466f..741c8765724e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -169,6 +169,7 @@ config RISCV
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
new file mode 100644
index 000000000000..a8fa96ce3ee3
--- /dev/null
+++ b/arch/riscv/include/asm/hw_breakpoint.h
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ */
+
+#ifndef __RISCV_HW_BREAKPOINT_H
+#define __RISCV_HW_BREAKPOINT_H
+
+struct task_struct;
+
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+#include <uapi/linux/hw_breakpoint.h>
+
+#if __riscv_xlen == 64
+#define cpu_to_le cpu_to_le64
+#define le_to_cpu le64_to_cpu
+#elif __riscv_xlen == 32
+#define cpu_to_le cpu_to_le32
+#define le_to_cpu le32_to_cpu
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+#define RV_DBTR_BIT(_prefix, _name)		\
+	RV_DBTR_##_prefix##_##_name##_BIT
+
+#define RV_DBTR_BIT_MASK(_prefix, _name)		\
+	RV_DBTR_##_prefix##_name##_BIT_MASK
+
+#define RV_DBTR_BIT_MASK_VAL(_prefix, _name, _width)	\
+	(((1UL << _width) - 1) << RV_DBTR_BIT(_prefix, _name))
+
+#define CLEAR_DBTR_BIT(_target, _prefix, _bit_name)	\
+	__clear_bit(RV_DBTR_BIT(_prefix, _bit_name), &_target)
+
+#define SET_DBTR_BIT(_target, _prefix, _bit_name)	\
+	__set_bit(RV_DBTR_BIT(_prefix, _bit_name), &_target)
+
+enum {
+	RV_DBTR_BP	= 0,
+	RV_DBTR_WP	= 1,
+};
+
+enum {
+	RV_DBTR_TRIG_NONE = 0,
+	RV_DBTR_TRIG_LEGACY,
+	RV_DBTR_TRIG_MCONTROL,
+	RV_DBTR_TRIG_ICOUNT,
+	RV_DBTR_TRIG_ITRIGGER,
+	RV_DBTR_TRIG_ETRIGGER,
+	RV_DBTR_TRIG_MCONTROL6,
+};
+
+/* Trigger Data 1 */
+enum {
+	RV_DBTR_BIT(TDATA1, DATA)   = 0,
+#if __riscv_xlen == 64
+	RV_DBTR_BIT(TDATA1, DMODE)  = 59,
+	RV_DBTR_BIT(TDATA1, TYPE)   = 60,
+#elif __riscv_xlen == 32
+	RV_DBTR_BIT(TDATA1, DMODE)  = 27,
+	RV_DBTR_BIT(TDATA1, TYPE)   = 28,
+#else
+	#error "Unknown __riscv_xlen"
+#endif
+};
+
+enum {
+#if __riscv_xlen == 64
+	RV_DBTR_BIT_MASK(TDATA1, DATA) = RV_DBTR_BIT_MASK_VAL(TDATA1, DATA, 59),
+#elif __riscv_xlen == 32
+	RV_DBTR_BIT_MASK(TDATA1, DATA) = RV_DBTR_BIT_MASK_VAL(TDATA1, DATA,  27),
+#else
+	#error "Unknown __riscv_xlen"
+#endif
+	RV_DBTR_BIT_MASK(TDAT1, DMODE) = RV_DBTR_BIT_MASK_VAL(TDATA1, DMODE, 1),
+	RV_DBTR_BIT_MASK(TDATA1, TYPE) = RV_DBTR_BIT_MASK_VAL(TDATA1, TYPE,  4),
+};
+
+/* MC - Match Control Type Register */
+enum {
+	RV_DBTR_BIT(MC, LOAD)     = 0,
+	RV_DBTR_BIT(MC, STORE)    = 1,
+	RV_DBTR_BIT(MC, EXEC)     = 2,
+	RV_DBTR_BIT(MC, U)        = 3,
+	RV_DBTR_BIT(MC, S)        = 4,
+	RV_DBTR_BIT(MC, RES2)     = 5,
+	RV_DBTR_BIT(MC, M)        = 6,
+	RV_DBTR_BIT(MC, MATCH)    = 7,
+	RV_DBTR_BIT(MC, CHAIN)    = 11,
+	RV_DBTR_BIT(MC, ACTION)   = 12,
+	RV_DBTR_BIT(MC, SIZELO)   = 16,
+	RV_DBTR_BIT(MC, TIMING)   = 18,
+	RV_DBTR_BIT(MC, SELECT)   = 19,
+	RV_DBTR_BIT(MC, HIT)      = 20,
+#if __riscv_xlen >= 64
+	RV_DBTR_BIT(MC, SIZEHI) = 21,
+#endif
+#if __riscv_xlen == 64
+	RV_DBTR_BIT(MC, MASKMAX) = 53,
+	RV_DBTR_BIT(MC, DMODE)   = 59,
+	RV_DBTR_BIT(MC, TYPE)    = 60,
+#elif __riscv_xlen == 32
+	RV_DBTR_BIT(MC, MASKMAX) = 21,
+	RV_DBTR_BIT(MC, DMODE)   = 27,
+	RV_DBTR_BIT(MC, TYPE)    = 28,
+#else
+	#error "Unknown riscv xlen"
+#endif
+};
+
+enum {
+	RV_DBTR_BIT_MASK(MC, LOAD) = RV_DBTR_BIT_MASK_VAL(MC, LOAD, 1),
+	RV_DBTR_BIT_MASK(MC, STORE) = RV_DBTR_BIT_MASK_VAL(MC, STORE, 1),
+	RV_DBTR_BIT_MASK(MC, EXEC) = RV_DBTR_BIT_MASK_VAL(MC, EXEC, 1),
+	RV_DBTR_BIT_MASK(MC, U) = RV_DBTR_BIT_MASK_VAL(MC, U, 1),
+	RV_DBTR_BIT_MASK(MC, S) = RV_DBTR_BIT_MASK_VAL(MC, S, 1),
+	RV_DBTR_BIT_MASK(MC, RES2) = RV_DBTR_BIT_MASK_VAL(MC, RES2, 1),
+	RV_DBTR_BIT_MASK(MC, M) = RV_DBTR_BIT_MASK_VAL(MC, M, 1),
+	RV_DBTR_BIT_MASK(MC, MATCH) = RV_DBTR_BIT_MASK_VAL(MC, MATCH, 4),
+	RV_DBTR_BIT_MASK(MC, CHAIN) = RV_DBTR_BIT_MASK_VAL(MC, CHAIN, 1),
+	RV_DBTR_BIT_MASK(MC, ACTION) = RV_DBTR_BIT_MASK_VAL(MC, ACTION, 4),
+	RV_DBTR_BIT_MASK(MC, SIZELO) = RV_DBTR_BIT_MASK_VAL(MC, SIZELO, 2),
+	RV_DBTR_BIT_MASK(MC, TIMING) = RV_DBTR_BIT_MASK_VAL(MC, TIMING, 1),
+	RV_DBTR_BIT_MASK(MC, SELECT) = RV_DBTR_BIT_MASK_VAL(MC, SELECT, 1),
+	RV_DBTR_BIT_MASK(MC, HIT) = RV_DBTR_BIT_MASK_VAL(MC, HIT, 1),
+#if __riscv_xlen >= 64
+	RV_DBTR_BIT_MASK(MC, SIZEHI) = RV_DBTR_BIT_MASK_VAL(MC, SIZEHI,  2),
+#endif
+	RV_DBTR_BIT_MASK(MC, MASKMAX) = RV_DBTR_BIT_MASK_VAL(MC, MASKMAX, 6),
+	RV_DBTR_BIT_MASK(MC, DMODE) = RV_DBTR_BIT_MASK_VAL(MC, DMODE, 1),
+	RV_DBTR_BIT_MASK(MC, TYPE) = RV_DBTR_BIT_MASK_VAL(MC, TYPE, 4),
+};
+
+/* MC6 - Match Control 6 Type Register */
+enum {
+	RV_DBTR_BIT(MC6, LOAD)    = 0,
+	RV_DBTR_BIT(MC6, STORE)   = 1,
+	RV_DBTR_BIT(MC6, EXEC)    = 2,
+	RV_DBTR_BIT(MC6, U)       = 3,
+	RV_DBTR_BIT(MC6, S)       = 4,
+	RV_DBTR_BIT(MC6, RES2)    = 5,
+	RV_DBTR_BIT(MC6, M)       = 6,
+	RV_DBTR_BIT(MC6, MATCH)   = 7,
+	RV_DBTR_BIT(MC6, CHAIN)   = 11,
+	RV_DBTR_BIT(MC6, ACTION)  = 12,
+	RV_DBTR_BIT(MC6, SIZE)    = 16,
+	RV_DBTR_BIT(MC6, TIMING)  = 20,
+	RV_DBTR_BIT(MC6, SELECT)  = 21,
+	RV_DBTR_BIT(MC6, HIT)     = 22,
+	RV_DBTR_BIT(MC6, VU)      = 23,
+	RV_DBTR_BIT(MC6, VS)      = 24,
+#if __riscv_xlen == 64
+	RV_DBTR_BIT(MC6, DMODE)   = 59,
+	RV_DBTR_BIT(MC6, TYPE)    = 60,
+#elif __riscv_xlen == 32
+	RV_DBTR_BIT(MC6, DMODE)   = 27,
+	RV_DBTR_BIT(MC6, TYPE)    = 28,
+#else
+	#error "Unknown riscv xlen"
+#endif
+};
+
+enum {
+	RV_DBTR_BIT_MASK(MC6, LOAD) = RV_DBTR_BIT_MASK_VAL(MC6, LOAD, 1),
+	RV_DBTR_BIT_MASK(MC6, STORE) = RV_DBTR_BIT_MASK_VAL(MC6, STORE,  1),
+	RV_DBTR_BIT_MASK(MC6, EXEC) = RV_DBTR_BIT_MASK_VAL(MC6, EXEC, 1),
+	RV_DBTR_BIT_MASK(MC6, U) = RV_DBTR_BIT_MASK_VAL(MC6, U, 1),
+	RV_DBTR_BIT_MASK(MC6, S) = RV_DBTR_BIT_MASK_VAL(MC6, S, 1),
+	RV_DBTR_BIT_MASK(MC6, RES2) = RV_DBTR_BIT_MASK_VAL(MC6, RES2, 1),
+	RV_DBTR_BIT_MASK(MC6, M) = RV_DBTR_BIT_MASK_VAL(MC6, M, 1),
+	RV_DBTR_BIT_MASK(MC6, MATCH) = RV_DBTR_BIT_MASK_VAL(MC6, MATCH, 4),
+	RV_DBTR_BIT_MASK(MC6, CHAIN) = RV_DBTR_BIT_MASK_VAL(MC6, CHAIN, 1),
+	RV_DBTR_BIT_MASK(MC6, ACTION) = RV_DBTR_BIT_MASK_VAL(MC6, ACTION, 4),
+	RV_DBTR_BIT_MASK(MC6, SIZE) = RV_DBTR_BIT_MASK_VAL(MC6, SIZE, 4),
+	RV_DBTR_BIT_MASK(MC6, TIMING) = RV_DBTR_BIT_MASK_VAL(MC6, TIMING, 1),
+	RV_DBTR_BIT_MASK(MC6, SELECT) = RV_DBTR_BIT_MASK_VAL(MC6, SELECT, 1),
+	RV_DBTR_BIT_MASK(MC6, HIT) = RV_DBTR_BIT_MASK_VAL(MC6, HIT, 1),
+	RV_DBTR_BIT_MASK(MC6, VU) = RV_DBTR_BIT_MASK_VAL(MC6, VU, 1),
+	RV_DBTR_BIT_MASK(MC6, VS) = RV_DBTR_BIT_MASK_VAL(MC6, VS, 1),
+#if __riscv_xlen == 64
+	RV_DBTR_BIT_MASK(MC6, DMODE) = RV_DBTR_BIT_MASK_VAL(MC6, DMODE, 1),
+	RV_DBTR_BIT_MASK(MC6, TYPE) = RV_DBTR_BIT_MASK_VAL(MC6, TYPE, 4),
+#elif __riscv_xlen == 32
+	RV_DBTR_BIT_MASK(MC6, DMODE) = RV_DBTR_BIT_MASK_VAL(MC6, DMODE, 1),
+	RV_DBTR_BIT_MASK(MC6, TYPE) = RV_DBTR_BIT_MASK_VAL(MC6, TYPE, 4),
+#else
+	#error "Unknown riscv xlen"
+#endif
+};
+
+#define RV_DBTR_SET_TDATA1_TYPE(_t1, _type)				\
+	do {								\
+		_t1 &= ~RV_DBTR_BIT_MASK(TDATA1, TYPE);			\
+		_t1 |= (((unsigned long)_type				\
+			 << RV_DBTR_BIT(TDATA1, TYPE))			\
+			& RV_DBTR_BIT_MASK(TDATA1, TYPE));		\
+	} while (0)
+
+#define RV_DBTR_SET_MC_TYPE(_t1, _type)				\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC, TYPE);		\
+		_t1 |= (((unsigned long)_type			\
+			 << RV_DBTR_BIT(MC, TYPE))		\
+			& RV_DBTR_BIT_MASK(MC, TYPE));		\
+	} while (0)
+
+#define RV_DBTR_SET_MC6_TYPE(_t1, _type)			\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC6, TYPE);		\
+		_t1 |= (((unsigned long)_type			\
+			 << RV_DBTR_BIT(MC6, TYPE))		\
+			& RV_DBTR_BIT_MASK(MC6, TYPE));		\
+	} while (0)
+
+#define RV_DBTR_SET_MC_EXEC(_t1)		\
+	SET_DBTR_BIT(_t1, MC, EXEC)
+
+#define RV_DBTR_SET_MC_LOAD(_t1)		\
+	SET_DBTR_BIT(_t1, MC, LOAD)
+
+#define RV_DBTR_SET_MC_STORE(_t1)		\
+	SET_DBTR_BIT(_t1, MC, STORE)
+
+#define RV_DBTR_SET_MC_SIZELO(_t1, _val)			\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC, SIZELO);		\
+		_t1 |= ((_val << RV_DBTR_BIT(MC, SIZELO))	\
+			& RV_DBTR_BIT_MASK(MC, SIZELO));	\
+	} while (0)
+
+#define RV_DBTR_SET_MC_SIZEHI(_t1, _val)			\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC, SIZEHI);		\
+		_t1 |= ((_val << RV_DBTR_BIT(MC, SIZEHI))	\
+			& RV_DBTR_BIT_MASK(MC, SIZEHI));	\
+	} while (0)
+
+#define RV_DBTR_SET_MC6_EXEC(_t1)		\
+	SET_DBTR_BIT(_t1, MC6, EXEC)
+
+#define RV_DBTR_SET_MC6_LOAD(_t1)		\
+	SET_DBTR_BIT(_t1, MC6, LOAD)
+
+#define RV_DBTR_SET_MC6_STORE(_t1)		\
+	SET_DBTR_BIT(_t1, MC6, STORE)
+
+#define RV_DBTR_SET_MC6_SIZE(_t1, _val)				\
+	do {							\
+		_t1 &= ~RV_DBTR_BIT_MASK(MC6, SIZE);		\
+		_t1 |= ((_val << RV_DBTR_BIT(MC6, SIZE))	\
+			& RV_DBTR_BIT_MASK(MC6, SIZE));		\
+	} while (0)
+
+struct arch_hw_breakpoint {
+	unsigned long address;
+	unsigned long len;
+	unsigned int type;
+
+	/* Trigger configuration data */
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+/* Maximum number of hardware breakpoints supported */
+#define HW_BP_NUM_MAX 32
+
+struct perf_event_attr;
+struct notifier_block;
+struct perf_event;
+struct pt_regs;
+
+int hw_breakpoint_slots(int type);
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data);
+
+void arch_enable_hw_breakpoint(struct perf_event *bp);
+void arch_update_hw_breakpoint(struct perf_event *bp);
+void arch_disable_hw_breakpoint(struct perf_event *bp);
+int arch_install_hw_breakpoint(struct perf_event *bp);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void hw_breakpoint_pmu_read(struct perf_event *bp);
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk);
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
+
+#else
+
+int hw_breakpoint_slots(int type)
+{
+	return 0;
+}
+
+static inline void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+}
+
+static inline void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+}
+
+void arch_enable_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+void arch_update_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+void arch_disable_hw_breakpoint(struct perf_event *bp)
+{
+}
+
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#endif /* __RISCV_HW_BREAKPOINT_H */
diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kdebug.h
index 85ac00411f6e..53e989781aa1 100644
--- a/arch/riscv/include/asm/kdebug.h
+++ b/arch/riscv/include/asm/kdebug.h
@@ -6,7 +6,8 @@
 enum die_val {
 	DIE_UNUSED,
 	DIE_TRAP,
-	DIE_OOPS
+	DIE_OOPS,
+	DIE_DEBUG
 };
 
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index c7b542573407..39a3489bd9e2 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
new file mode 100644
index 000000000000..3a43d1e59de8
--- /dev/null
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -0,0 +1,657 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/kdebug.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+
+#include <asm/sbi.h>
+
+/* Registered per-cpu bp/wp */
+static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[HW_BP_NUM_MAX]);
+static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
+static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
+
+/* Per-cpu shared memory between S and M mode */
+static union sbi_dbtr_shmem_entry __percpu *sbi_dbtr_shmem;
+
+/* number of debug triggers on this cpu . */
+static int dbtr_total_num __ro_after_init;
+static int dbtr_type __ro_after_init;
+static int dbtr_init __ro_after_init;
+
+#if __riscv_xlen == 64
+#define MEM_HI(_m)	0
+#define MEM_LO(_m)	((u64)_m)
+#elif __riscv_xlen == 32
+#define MEM_HI(_m)	((u64)_m >> 32)
+#define MEM_LO(_m)	((u64)_m & 0xFFFFFFFFUL)
+#else
+#error "Unknown __riscv_xlen"
+#endif
+
+static int arch_smp_setup_sbi_shmem(unsigned int cpu)
+{
+	union sbi_dbtr_shmem_entry *dbtr_shmem;
+	unsigned long shmem_pa;
+	struct sbiret ret;
+	int rc = 0;
+
+	dbtr_shmem = per_cpu_ptr(sbi_dbtr_shmem, cpu);
+	if (!dbtr_shmem) {
+		pr_err("Invalid per-cpu shared memory for debug triggers\n");
+		return -ENODEV;
+	}
+
+	shmem_pa = __pa(dbtr_shmem);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			MEM_LO(shmem_pa), MEM_HI(shmem_pa), 0, 0, 0, 0);
+
+	if (ret.error) {
+		switch (ret.error) {
+		case SBI_ERR_DENIED:
+			pr_warn("%s: Access denied for shared memory at %lx\n",
+				__func__, shmem_pa);
+			rc = -EPERM;
+			break;
+
+		case SBI_ERR_INVALID_PARAM:
+		case SBI_ERR_INVALID_ADDRESS:
+			pr_warn("%s: Invalid address parameter (%lu)\n",
+				__func__, ret.error);
+			rc = -EINVAL;
+			break;
+
+		case SBI_ERR_ALREADY_AVAILABLE:
+			pr_warn("%s: Shared memory is already set\n",
+				__func__);
+			rc = -EADDRINUSE;
+			break;
+
+		case SBI_ERR_FAILURE:
+			pr_err("%s: Internal sdtrig state error\n",
+			       __func__);
+			rc = -ENXIO;
+			break;
+
+		default:
+			pr_warn("%s: Unknown error %lu\n", __func__, ret.error);
+			rc = -ENXIO;
+			break;
+		}
+	}
+
+	pr_info("CPU %d: HW Breakpoint shared memory registered.\n", cpu);
+
+	return rc;
+}
+
+static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
+{
+	struct sbiret ret;
+
+	/* Disable shared memory */
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
+			-1UL, -1UL, 0, 0, 0, 0);
+
+	if (ret.error) {
+		switch (ret.error) {
+		case SBI_ERR_DENIED:
+			pr_err("%s: Access denied for shared memory.\n",
+			       __func__);
+			break;
+
+		case SBI_ERR_INVALID_PARAM:
+		case SBI_ERR_INVALID_ADDRESS:
+			pr_err("%s: Invalid address parameter (%lu)\n",
+			       __func__, ret.error);
+			break;
+
+		case SBI_ERR_ALREADY_AVAILABLE:
+			pr_err("%s: Shared memory is already set\n",
+			       __func__);
+			break;
+		case SBI_ERR_FAILURE:
+			pr_err("%s: Internal sdtrig state error\n",
+			       __func__);
+			break;
+		default:
+			pr_err("%s: Unknown error %lu\n", __func__, ret.error);
+			break;
+		}
+	}
+
+	pr_warn("CPU %d: HW Breakpoint shared memory disabled.\n", cpu);
+
+	return 0;
+}
+
+static void init_sbi_dbtr(void)
+{
+	unsigned long tdata1;
+	struct sbiret ret;
+
+	if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
+		pr_warn("%s: SBI_EXT_DBTR is not supported\n", __func__);
+		dbtr_total_num = 0;
+		goto done;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: Failed to detect triggers\n", __func__);
+		dbtr_total_num = 0;
+		goto done;
+	}
+
+	tdata1 = 0;
+	RV_DBTR_SET_TDATA1_TYPE(tdata1, RV_DBTR_TRIG_MCONTROL6);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect mcontrol6 triggers\n", __func__);
+	} else if (!ret.value) {
+		pr_warn("%s: type 6 triggers not available\n", __func__);
+	} else {
+		dbtr_total_num = ret.value;
+		dbtr_type = RV_DBTR_TRIG_MCONTROL6;
+		pr_warn("%s: mcontrol6 trigger available.\n", __func__);
+		goto done;
+	}
+
+	/* fallback to type 2 triggers if type 6 is not available */
+
+	tdata1 = 0;
+	RV_DBTR_SET_TDATA1_TYPE(tdata1, RV_DBTR_TRIG_MCONTROL);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
+			tdata1, 0, 0, 0, 0, 0);
+	if (ret.error) {
+		pr_warn("%s: failed to detect mcontrol triggers\n", __func__);
+	} else if (!ret.value) {
+		pr_warn("%s: type 2 triggers not available\n", __func__);
+	} else {
+		dbtr_total_num = ret.value;
+		dbtr_type = RV_DBTR_TRIG_MCONTROL;
+		goto done;
+	}
+
+done:
+	dbtr_init = 1;
+}
+
+int hw_breakpoint_slots(int type)
+{
+	/*
+	 * We can be called early, so don't rely on
+	 * static variables being initialised.
+	 */
+
+	if (!dbtr_init)
+		init_sbi_dbtr();
+
+	return dbtr_total_num;
+}
+
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	unsigned int len;
+	unsigned long va;
+
+	va = hw->address;
+	len = hw->len;
+
+	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
+}
+
+static int rv_init_mcontrol_trigger(const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw)
+{
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		hw->type = RV_DBTR_BP;
+		RV_DBTR_SET_MC_EXEC(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_R:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC_LOAD(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_W:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC_STORE(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_RW:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC_LOAD(hw->tdata1);
+		RV_DBTR_SET_MC_STORE(hw->tdata1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		hw->len = 1;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 1);
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		hw->len = 2;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 2);
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		hw->len = 4;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 3);
+		break;
+#if __riscv_xlen >= 64
+	case HW_BREAKPOINT_LEN_8:
+		hw->len = 8;
+		RV_DBTR_SET_MC_SIZELO(hw->tdata1, 1);
+		RV_DBTR_SET_MC_SIZEHI(hw->tdata1, 1);
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	RV_DBTR_SET_MC_TYPE(hw->tdata1, RV_DBTR_TRIG_MCONTROL);
+
+	CLEAR_DBTR_BIT(hw->tdata1, MC, DMODE);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, TIMING);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, SELECT);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, ACTION);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, CHAIN);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, MATCH);
+	CLEAR_DBTR_BIT(hw->tdata1, MC, M);
+
+	SET_DBTR_BIT(hw->tdata1, MC, S);
+	SET_DBTR_BIT(hw->tdata1, MC, U);
+
+	return 0;
+}
+
+static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
+				     struct arch_hw_breakpoint *hw)
+{
+	switch (attr->bp_type) {
+	case HW_BREAKPOINT_X:
+		hw->type = RV_DBTR_BP;
+		RV_DBTR_SET_MC6_EXEC(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_R:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC6_LOAD(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_W:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC6_STORE(hw->tdata1);
+		break;
+	case HW_BREAKPOINT_RW:
+		hw->type = RV_DBTR_WP;
+		RV_DBTR_SET_MC6_STORE(hw->tdata1);
+		RV_DBTR_SET_MC6_LOAD(hw->tdata1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (attr->bp_len) {
+	case HW_BREAKPOINT_LEN_1:
+		hw->len = 1;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 1);
+		break;
+	case HW_BREAKPOINT_LEN_2:
+		hw->len = 2;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 2);
+		break;
+	case HW_BREAKPOINT_LEN_4:
+		hw->len = 4;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 3);
+		break;
+	case HW_BREAKPOINT_LEN_8:
+		hw->len = 8;
+		RV_DBTR_SET_MC6_SIZE(hw->tdata1, 5);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	RV_DBTR_SET_MC6_TYPE(hw->tdata1, RV_DBTR_TRIG_MCONTROL6);
+
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, DMODE);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, TIMING);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, SELECT);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, ACTION);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, CHAIN);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, MATCH);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, M);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, VS);
+	CLEAR_DBTR_BIT(hw->tdata1, MC6, VU);
+
+	SET_DBTR_BIT(hw->tdata1, MC6, S);
+	SET_DBTR_BIT(hw->tdata1, MC6, U);
+
+	return 0;
+}
+
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
+{
+	int ret;
+
+	/* Breakpoint address */
+	hw->address = attr->bp_addr;
+	hw->tdata2 = attr->bp_addr;
+	hw->tdata3 = 0x0;
+
+	switch (dbtr_type) {
+	case RV_DBTR_TRIG_MCONTROL:
+		ret = rv_init_mcontrol_trigger(attr, hw);
+		break;
+	case RV_DBTR_TRIG_MCONTROL6:
+		ret = rv_init_mcontrol6_trigger(attr, hw);
+		break;
+	default:
+		pr_warn("unsupported trigger type\n");
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * HW Breakpoint/watchpoint handler
+ */
+static int hw_breakpoint_handler(struct die_args *args)
+{
+	int ret = NOTIFY_DONE;
+	struct arch_hw_breakpoint *bp;
+	struct perf_event *event;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		event = this_cpu_read(pcpu_hw_bp_events[i]);
+		if (!event)
+			continue;
+
+		bp = counter_arch_bp(event);
+		switch (bp->type) {
+		/* Breakpoint */
+		case RV_DBTR_BP:
+			if (bp->address == args->regs->epc) {
+				perf_bp_event(event, args->regs);
+				ret = NOTIFY_STOP;
+			}
+			break;
+
+		/* Watchpoint */
+		case RV_DBTR_WP:
+			if (bp->address == csr_read(CSR_STVAL)) {
+				perf_bp_event(event, args->regs);
+				ret = NOTIFY_STOP;
+			}
+			break;
+
+		default:
+			pr_warn("%s: Unknown type: %u\n", __func__, bp->type);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data)
+{
+	if (val != DIE_DEBUG)
+		return NOTIFY_DONE;
+
+	return hw_breakpoint_handler(data);
+}
+
+/* atomic: counter->ctx->lock is held */
+int arch_install_hw_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+	struct sbi_dbtr_data_msg *xmit;
+	struct sbi_dbtr_id_msg *recv;
+	struct perf_event **slot;
+	unsigned long idx;
+	struct sbiret ret;
+	int err = 0;
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
+			      *this_cpu_ptr(&ecall_lock_flags));
+
+	xmit = &shmem->data;
+	recv = &shmem->id;
+	xmit->tdata1 = cpu_to_le(bp->tdata1);
+	xmit->tdata2 = cpu_to_le(bp->tdata2);
+	xmit->tdata3 = cpu_to_le(bp->tdata3);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
+			1, 0, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: failed to install trigger\n", __func__);
+		err = -EIO;
+		goto done;
+	}
+
+	idx = le_to_cpu(recv->idx);
+	if (idx >= dbtr_total_num) {
+		pr_warn("%s: invalid trigger index %lu\n", __func__, idx);
+		err = -EINVAL;
+		goto done;
+	}
+
+	slot = this_cpu_ptr(&pcpu_hw_bp_events[idx]);
+	if (*slot) {
+		pr_warn("%s: slot %lu is in use\n", __func__, idx);
+		err = -EBUSY;
+		goto done;
+	}
+
+	pr_debug("Trigger %lu installed at index 0x%lx\n", bp->tdata2, idx);
+
+	/* Save the event - to be looked up in handler */
+	*slot = event;
+
+done:
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
+				   *this_cpu_ptr(&ecall_lock_flags));
+	return err;
+}
+
+/* atomic: counter->ctx->lock is held */
+void arch_uninstall_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event) {
+			*slot = NULL;
+			break;
+		}
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error)
+		pr_warn("%s: Failed to uninstall trigger %d.\n", __func__, i);
+}
+
+void arch_enable_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+	struct perf_event **slot;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_ENABLE,
+			i, 1, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: Failed to install trigger %d\n", __func__, i);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_enable_hw_breakpoint);
+
+void arch_update_hw_breakpoint(struct perf_event *event)
+{
+	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
+	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
+	struct sbi_dbtr_data_msg *xmit;
+	struct perf_event **slot;
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
+			      *this_cpu_ptr(&ecall_lock_flags));
+
+	xmit = &shmem->data;
+	xmit->tdata1 = cpu_to_le(bp->tdata1);
+	xmit->tdata2 = cpu_to_le(bp->tdata2);
+	xmit->tdata3 = cpu_to_le(bp->tdata3);
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE,
+			i, 1, 0, 0, 0, 0);
+	if (ret.error)
+		pr_warn("%s: Failed to update trigger %d.\n", __func__, i);
+
+	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
+				   *this_cpu_ptr(&ecall_lock_flags));
+}
+EXPORT_SYMBOL_GPL(arch_update_hw_breakpoint);
+
+void arch_disable_hw_breakpoint(struct perf_event *event)
+{
+	struct sbiret ret;
+	int i;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		struct perf_event **slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
+
+		if (*slot == event)
+			break;
+	}
+
+	if (i == dbtr_total_num) {
+		pr_warn("%s: Breakpoint not installed.\n", __func__);
+		return;
+	}
+
+	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_DISABLE,
+			i, 1, 0, 0, 0, 0);
+
+	if (ret.error) {
+		pr_warn("%s: Failed to uninstall trigger %d.\n", __func__, i);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+	/* TODO */
+}
+
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	/* TODO */
+}
+
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	/* TODO */
+}
+
+static int __init arch_hw_breakpoint_init(void)
+{
+	unsigned int cpu;
+	int rc = 0;
+
+	for_each_possible_cpu(cpu)
+		raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
+
+	if (!dbtr_init)
+		init_sbi_dbtr();
+
+	if (dbtr_total_num) {
+		pr_info("%s: total number of type %d triggers: %u\n",
+			__func__, dbtr_type, dbtr_total_num);
+	} else {
+		pr_info("%s: No hardware triggers available\n", __func__);
+		goto out;
+	}
+
+	/* Allocate per-cpu shared memory */
+	sbi_dbtr_shmem = __alloc_percpu(sizeof(*sbi_dbtr_shmem) * dbtr_total_num,
+					PAGE_SIZE);
+
+	if (!sbi_dbtr_shmem) {
+		pr_warn("%s: Failed to allocate shared memory.\n", __func__);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Hotplug handler to register/unregister shared memory with SBI */
+	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			       "riscv/hw_breakpoint:prepare",
+			       arch_smp_setup_sbi_shmem,
+			       arch_smp_teardown_sbi_shmem);
+
+	if (rc < 0) {
+		pr_warn("%s: Failed to setup CPU hotplug state\n", __func__);
+		free_percpu(sbi_dbtr_shmem);
+		return rc;
+	}
+ out:
+	return rc;
+}
+arch_initcall(arch_hw_breakpoint_init);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 9c83848797a7..cc8ef120ff41 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -288,6 +288,12 @@ void handle_break(struct pt_regs *regs)
 	if (probe_breakpoint_handler(regs))
 		return;
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
+	    == NOTIFY_STOP)
+		return;
+#endif
+
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
-- 
2.45.2


