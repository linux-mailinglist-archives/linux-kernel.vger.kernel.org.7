Return-Path: <linux-kernel+bounces-873142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CB5C13363
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D658A1AA4FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA524271454;
	Tue, 28 Oct 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g+13w49F"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4128000B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634396; cv=none; b=JIRwlkAS3fCopI/dDioyx+soFO6jmnl6Q5dNegbjabS9Mhd7oRY1DSF5X00shyM6mhX6QzKJ1XQ/VgJZMrwbOnFWIlr1x55HRXxSRkK4kok4D47/DaLMY+SA4O4GNwQAaYiaeuf5+KGyCvcY8KhDmj4OF5XR/oQnpI7Q/aJKl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634396; c=relaxed/simple;
	bh=cHCAFr3bDIe20W1u4NOZPS9he0BMGsrN0qVV3tfL/Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXFRi7quRejRr67ot1n257UjuCKbI6ujXedIlmq5PazlakVknUKxaidKB1nDcS0/uWB/gz1ivJasNyNKTWMOQSTzujfHVo0MrFscC7BPSWbWpqRrB97CG0lDtdPK72xylrHkooppgSIbbcm2C3A9PpZW/c8nVuxXu7p3A4f75hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g+13w49F; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761634381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NqS6VU5MIVR//qY5Ua4Xx8PnMfFDh/WpsUPptTf5jMo=;
	b=g+13w49F2TcV+0UrcvNeGf7GegKZhpumP0aKGnpERPXeqIEPWseZaWoxCdldb09ihEMbY9
	VSZBnLUqBGN4+GhmPbbnsIHNWtPIH8vP9jD80O/DN48/aE0pT1MvuLqZfKaVfOKCCKMTfD
	eX2YdFo4y9YWc79N3j8mTqwzHJN/vlI=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] LoongArch: jump_label: Batch icache maintenance
Date: Tue, 28 Oct 2025 14:51:39 +0800
Message-ID: <20251028065139.10227-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Switch to the batched version of the jump label update functions so
instruction cache maintenance is deferred until the end of the update.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/include/asm/cacheflush.h | 16 +++++++++++++++-
 arch/loongarch/include/asm/jump_label.h |  1 +
 arch/loongarch/kernel/inst.c            |  6 +++---
 arch/loongarch/kernel/jump_label.c      | 13 +++++++++++--
 arch/loongarch/mm/cache.c               | 10 ----------
 5 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index f8754d08a31a..66c34c821ecb 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -31,9 +31,23 @@ static inline unsigned int cpu_last_level_cache_line_size(void)
 	return boot_cpu_data.cache_leaves[cache_present - 1].linesz;
 }
 
+/*
+ * LoongArch maintains ICache/DCache coherency by hardware,
+ * we just need "ibar" to avoid instruction hazard here.
+ */
+static inline void local_flush_icache_all(void)
+{
+	asm volatile ("\tibar 0\n"::);
+}
+
+static inline void local_flush_icache_range(unsigned long start, unsigned long end)
+{
+	local_flush_icache_all();
+}
+
 asmlinkage void __flush_cache_all(void);
-void local_flush_icache_range(unsigned long start, unsigned long end);
 
+#define flush_icache_all	local_flush_icache_all
 #define flush_icache_range	local_flush_icache_range
 #define flush_icache_user_range	local_flush_icache_range
 
diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/include/asm/jump_label.h
index 4000c7603d8e..d0689032fd9d 100644
--- a/arch/loongarch/include/asm/jump_label.h
+++ b/arch/loongarch/include/asm/jump_label.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 
+#define HAVE_JUMP_LABEL_BATCH
 #define JUMP_LABEL_NOP_SIZE	4
 
 /* This macro is also expanded on the Rust side. */
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index bf037f0c6b26..65c1b74d677a 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -209,6 +209,9 @@ int larch_insn_write(void *addr, u32 insn)
 	int ret;
 	unsigned long flags = 0;
 
+	if ((unsigned long)addr & 3)
+		return -EINVAL;
+
 	raw_spin_lock_irqsave(&patch_lock, flags);
 	ret = copy_to_kernel_nofault(addr, &insn, LOONGARCH_INSN_SIZE);
 	raw_spin_unlock_irqrestore(&patch_lock, flags);
@@ -221,9 +224,6 @@ int larch_insn_patch_text(void *addr, u32 insn)
 	int ret;
 	u32 *tp = addr;
 
-	if ((unsigned long)tp & 3)
-		return -EINVAL;
-
 	ret = larch_insn_write(tp, insn);
 	if (!ret)
 		flush_icache_range((unsigned long)tp,
diff --git a/arch/loongarch/kernel/jump_label.c b/arch/loongarch/kernel/jump_label.c
index 31891214b767..f5a394bdb5f3 100644
--- a/arch/loongarch/kernel/jump_label.c
+++ b/arch/loongarch/kernel/jump_label.c
@@ -6,9 +6,11 @@
  */
 #include <linux/kernel.h>
 #include <linux/jump_label.h>
+#include <asm/cacheflush.h>
 #include <asm/inst.h>
 
-void arch_jump_label_transform(struct jump_entry *entry, enum jump_label_type type)
+bool arch_jump_label_transform_queue(struct jump_entry *entry,
+				     enum jump_label_type type)
 {
 	u32 insn;
 	void *addr = (void *)jump_entry_code(entry);
@@ -18,5 +20,12 @@ void arch_jump_label_transform(struct jump_entry *entry, enum jump_label_type ty
 	else
 		insn = larch_insn_gen_nop();
 
-	larch_insn_patch_text(addr, insn);
+	larch_insn_write(addr, insn);
+
+	return true;
+}
+
+void arch_jump_label_transform_apply(void)
+{
+	flush_icache_all();
 }
diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 6be04d36ca07..966b8d2b04ad 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -31,16 +31,6 @@ void cache_error_setup(void)
 	set_merr_handler(0x0, &except_vec_cex, 0x80);
 }
 
-/*
- * LoongArch maintains ICache/DCache coherency by hardware,
- * we just need "ibar" to avoid instruction hazard here.
- */
-void local_flush_icache_range(unsigned long start, unsigned long end)
-{
-	asm volatile ("\tibar 0\n"::);
-}
-EXPORT_SYMBOL(local_flush_icache_range);
-
 static void flush_cache_leaf(unsigned int leaf)
 {
 	int i, j, nr_nodes;
-- 
2.43.0


