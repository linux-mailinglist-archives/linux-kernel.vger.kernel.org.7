Return-Path: <linux-kernel+bounces-631575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEEDAA8A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 01:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B910B3B6296
	for <lists+linux-kernel@lfdr.de>; Sun,  4 May 2025 23:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0625394F;
	Sun,  4 May 2025 23:32:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F124E4B4;
	Sun,  4 May 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746401546; cv=none; b=Hro83FrfgtGAYE9vyomGrxfyGf3SS+i8VlYTSmEDfbRil2OJZhAqnmE6Qfbp/60ipOiiHx6K3JQ0PLEvSXizDjkJQLJ3Z35c0dtVux4DyfWzHfxA+Vl66ssyczY12MOYlBVJ2keaufiBFuWqcH0ao/NSBEzRiyWhIdazj91+bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746401546; c=relaxed/simple;
	bh=sqMQDzvFmXnESvEW65BX+Gydje+6XtdWN5A4O+i9z+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt9QHdE+n+LakEnzgDll7m3eRU4AbFzV9MFIMjVYZMqW+BZe9liPFbAIheyHbTAdnsXPY0yPV4q4Rn9PaXy4MblHWthxeMZAQq9spOjntE9iuXzcXouvzEiklcuQsW3eh+qlPY0HZF2gJn8BttFO6n8zslmSlrVHSct3NkHCSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F742175A;
	Sun,  4 May 2025 16:32:08 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 424C53F58B;
	Sun,  4 May 2025 16:32:17 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thiago.bauermann@linaro.org,
	broonie@kernel.org,
	yury.khrustalev@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 2/7] arm64: probes: Break ret out from bl/blr
Date: Sun,  4 May 2025 18:31:58 -0500
Message-ID: <20250504233203.616587-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504233203.616587-1-jeremy.linton@arm.com>
References: <20250504233203.616587-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for GCS by breaking RET out into its own function, where
it makes more sense to encapsulate the new behavior independent
from the branch instructions.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/probes/decode-insn.c   |  7 ++++---
 arch/arm64/kernel/probes/simulate-insn.c | 10 +++++++++-
 arch/arm64/kernel/probes/simulate-insn.h |  3 ++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 6438bf62e753..4137cc5ef031 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -108,9 +108,10 @@ arm_probe_decode_insn(u32 insn, struct arch_probe_insn *api)
 	    aarch64_insn_is_bl(insn)) {
 		api->handler = simulate_b_bl;
 	} else if (aarch64_insn_is_br(insn) ||
-	    aarch64_insn_is_blr(insn) ||
-	    aarch64_insn_is_ret(insn)) {
-		api->handler = simulate_br_blr_ret;
+		aarch64_insn_is_blr(insn)) {
+		api->handler = simulate_br_blr;
+	} else if (aarch64_insn_is_ret(insn)) {
+		api->handler = simulate_ret;
 	} else {
 		/*
 		 * Instruction cannot be stepped out-of-line and we don't
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 4c6d2d712fbd..09a0b36122d0 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -126,7 +126,7 @@ simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
 }
 
 void __kprobes
-simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
+simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
 {
 	int xn = (opcode >> 5) & 0x1f;
 
@@ -138,6 +138,14 @@ simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
 		set_x_reg(regs, 30, addr + 4);
 }
 
+void __kprobes
+simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
+{
+	int xn = (opcode >> 5) & 0x1f;
+
+	instruction_pointer_set(regs, get_x_reg(regs, xn));
+}
+
 void __kprobes
 simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
 {
diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
index efb2803ec943..9e772a292d56 100644
--- a/arch/arm64/kernel/probes/simulate-insn.h
+++ b/arch/arm64/kernel/probes/simulate-insn.h
@@ -11,7 +11,8 @@
 void simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs);
-void simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_ret(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
-- 
2.49.0


