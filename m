Return-Path: <linux-kernel+bounces-782539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3BEB321B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660145C6F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717429993E;
	Fri, 22 Aug 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OfCFDmNN"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D92980C2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884848; cv=none; b=XDP0yZHQzfbK6AVpQ8Mzp7zBqRaUZUalT4HsybPzY3DMdD5627BUmec58abqufE7lQyh349GJpPAxRMeTWP5u2jjgEJOXoiiWuTByRwfPg7Vxa7XQCx0cWv2IyuiQyXnZ8AUOAdC6RlupqQUDwMjTtmvB989cNrhOPIGOfnJmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884848; c=relaxed/simple;
	bh=0b+k1Da34Ie81q2wS6yZp0j3E9D5ClJNu8JRMBnHi+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+9wqLb7y6iKouw7+uaoinNAgCliaxrC3KPy+bu1Fkfpa2DJoL9jTuHimtIPZV5bwe9M63WiHiccG94ZX9ot9i+lAvyOxKYm+Dt9qIlG5ZthA2pmd2Gju1mo2IPe8C/BtqW9Z4QUH5e+6rtFTaoAbo+M8Lcyd1uqzjqgjq0lz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OfCFDmNN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b297962b24so23401921cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884845; x=1756489645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7icmFEtMbjG8nHUlUz3H6xEpzLvZfrYx0hP4AUrTZT0=;
        b=OfCFDmNNY64q0WQPlHvyCU01UrN1O7uFPdUYZGLx0gq160X8cjbGA6BXYsice8kGT9
         wuEOwiNl1w4Q+dE9CWSycC0eoFwKKguwPhKYsaJC2RKC8cm8sZqUGYtzUfuUYOvHVHxJ
         /Dd3snX4ScJbxhSb04vqSOj3UqLNR3fv0qLyynTX5fHvRf3qNAImmbMam6aQDtS0RrOc
         JI1bMoTYU8PPxCOIs+6Mwkmmvmq0Ezdc83d/grP5F59lZXe1lKB3Fv0vaA41zvrdUx30
         HboVj4nKplV2V9fWIMWA5HuGJ9pF+zZQJMFzijMWMKehgpxhX870AQ5eC7sgg6FSmq7P
         40eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884846; x=1756489646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7icmFEtMbjG8nHUlUz3H6xEpzLvZfrYx0hP4AUrTZT0=;
        b=Z/BkxVaAWn7bevVovD/N84xyUnOHvmevCf73PzWG2MFGZ9pGRmJAhZCsidvwqrcr+1
         Rq5H17m/HRu6MGyUrY1Ba5pgwmK0nOHuuUdh0Ig+5reo5ji7Tj5kU44BX0g1X0ixtNmT
         PxZqjUBTZjgN47T+5jmaX4oJPst2Z+qjmb+pl551QamJQ5ekt0H0piHucCAo/bvB+VEH
         xZZe5Aj8uZmWNHJNFr6cnoXJPtd6H3Np9b/JahAAYdAxKWUpSATkMj1IP+xBowFUof9t
         B0WFNVt+NgDYFc//sGsEO+42bwLWMp2mAIiXjZK2i/5ONAdel34oQs1IUxTsVA7H10NC
         8XYg==
X-Forwarded-Encrypted: i=1; AJvYcCVE5Bfy+NL1mtlMZ8S/T0Jg663myNDum1XvZfYbgzmoRJy6vihzjFmpf/IuuPeI1a3IhDhYEO22LRurfks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww33pLkil0bPllxYupZzBIwKPbPUv3jo7v7RiFz8mR2+cFVrO5
	gS/r5E5iDnPWNeC0gjhu1u6/dcjoCsIqBuXG3lLMnki4amB5EsLTx3RpPvWSm1Gt3Hg=
X-Gm-Gg: ASbGncsqyXcbzptQJEOGWGdLZZILO0VHnVtSWWvpdzPVPErZGQX8zV53DFu6fYfp92s
	3GFk7hW21fmY5x8BLK9XTnoDK/GMwFe+m4FVhgFG+zg6HaRUVLOS3zT4GKNj1NwAvUtTnZqDUan
	DXY7Z86ilQTP06Z/Cko8xPgMN3WprDUlgo7C8fEwXbt3zs0LPHaLDjO0VM2ct6XEHrg6pNHzNSZ
	n1S0lTQYPEFVbrtWMa5LykzMBxDNJ8X2Gk+QgZhRGVcxrafNGGrqjm5ke+heervYXW3mQlpe+Qr
	zNNwcElOvbfNVAAZ9PH7D3K20v/AzLviYT+jR7VyF/K32+Zdw9rmc2zEExgPPwPHKw2PZyJICoN
	gfFgRZbssd0MNx7Hdo/kDRSVY30C2VhyHM4or9xaJc5Xq+gg2ZqFNMvA7EbZAU6PSgVbb3TVZRf
	6/+lXLiQ==
X-Google-Smtp-Source: AGHT+IGt5FtRUkeNaYf2QqcOOYK1voNcUZefaLnp0B87objwjhy4KKvTzMxzHCr1EhOf/GN0KqwnNQ==
X-Received: by 2002:ac8:5dd1:0:b0:4b1:103b:bb6f with SMTP id d75a77b69052e-4b2aab276d4mr43535751cf.61.1755884845347;
        Fri, 22 Aug 2025 10:47:25 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:25 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 3/8] riscv: insn: Add get_insn_nofault
Date: Fri, 22 Aug 2025 10:47:10 -0700
Message-ID: <20250822174715.1269138-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_insn_nofault uses get_insn with pagefaults dissabled, allowing it to
be called in an atomic context.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
Unsure if copy_from_kernel_nofault is an acceptable replacement for
direct dereference in __read_insn.

RFC -> V1:
 - Add new function instead of using copy_from_user_nofault
V1 -> V2:
 - No change
---
 arch/riscv/include/asm/insn.h |  1 +
 arch/riscv/kernel/insn.c      | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index ba74e5b8262c..f87e0a48f786 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -553,6 +553,7 @@ static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype
 #include <asm/ptrace.h>
 
 int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn);
 unsigned long get_step_address(struct pt_regs *regs, u32 code);
 
 #endif /* _ASM_RISCV_INSN_H */
diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
index dd2a6ef9fd25..c8f77c0093c9 100644
--- a/arch/riscv/kernel/insn.c
+++ b/arch/riscv/kernel/insn.c
@@ -2,6 +2,9 @@
 /*
  * Copyright 2025 Rivos, Inc
  */
+
+#include <linux/uaccess.h>
+
 #include <asm/insn.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -74,6 +77,17 @@ int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 	}
 }
 
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn)
+{
+	int ret;
+
+	pagefault_disable();
+	ret = get_insn(regs, epc, r_insn);
+	pagefault_enable();
+
+	return ret;
+}
+
 /* Calculate the new address for after a step */
 unsigned long get_step_address(struct pt_regs *regs, u32 code)
 {
-- 
2.43.0


