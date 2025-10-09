Return-Path: <linux-kernel+bounces-846894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35ECBC95B5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6F23B2949
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12972C21E7;
	Thu,  9 Oct 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Be4OGBvR"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B034BA48
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017538; cv=none; b=YXiqSIriRZP9lUE4Rj5YUhv1bfjePeQpNgrQnysXrUpBjxp0L48wQkhXMAGNc8qv1HVsDNTfXHl807CZPnGskGX6obyknT8oH/YYvyJuiTqczPF6hvwyYntiKzIxiy+xHo8bM2uGc1e6d1t57wz7dBSfAUpVTRuiy21BDCr10uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017538; c=relaxed/simple;
	bh=ONz0iwdpEXBR9QXBr7fBiVKfbUdVWUHg5O8jRMu2rvI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=B9HVkjXdlTcp2VPAT1+BZyBCMM/5rUpnDPaw8vqHsgtTjQse6kDF+tEVQjuotqepnSsuieTkSQDJYfnQJLKZSTVQL5DLfdJ1jXQWdBwuboiWZYXeR9uW63Bq/UH5/khSwXVvLVkKU17jqpAwYPE0cT5asElv+iWWOMS6Wf79joU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Be4OGBvR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d69771e3eso6135755ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760017535; x=1760622335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Avy7qeTTmfq4DZivkTM47xk9+61lo2fuJS8O1YcKX0=;
        b=Be4OGBvRFPj7xiWJDYLuPSgypkqfjG1Q2f+BauDuh6BQYWl8bwkiyZq7f9MvmyGOB/
         wBvT3Z5AHGtrvdqL+peC+rkEQwD4wLIVnMGwFfdgOy1JN13uOrGcVfqf+aKTEYyrQFzE
         WUhEbI9hXvh/TtpIQhxmAWgKoXwxL5ON3fzkS/f3xdaTgp4McjAis72eqAUZ48F5nJyU
         ywQ775eXS62EUsj1yFSMkoMmuL/iaVIpa94sNTj3ILn6CpqwIG9eXyAPPFvJHORodID/
         x9Jta8pfDoXMzm4i+tvmHl0Cd6GpL8D9Fadp+GFmhsGw7VUvjyfWhqFvN7jsWl1A2wXD
         fktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017535; x=1760622335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Avy7qeTTmfq4DZivkTM47xk9+61lo2fuJS8O1YcKX0=;
        b=tiLywP6jtrCXuPrwrCI0sazIA1RTik8WKRoP+kiVJ40Lgci6IZTaIANP/u80blOI6f
         ln8xXxuvPvr9/ERLLobhr0eO3HKndvfBLoD7bV5XfpzAeRS6TGY4R0Q/X7MgANGM7kYw
         CddKQeonViy/M8GfIMsHiF/N4OkeOS2oryBewOj2ADtEozqOeVucBz/NyAHcS6rqQFSU
         m3nfew4Lp5QCQftWfYZp94TaAeXKhml/y40qCP94OoY+qFCN3eaWm8q+rHQsMtaNneFQ
         i/H+HWUf68iSD6mTuLzpa/kpB7cCD48NTYxkw6d5HITfYLPVq8Inoe1xhrZucVRBDNFX
         1e9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWknDNf8zep6YgHR0K6AMqzEfwST2UnZ4eh+996vCYjTzKZPIOynRQsEVj3/b8fKFjDjbcWy7aUNx/Zpgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0IPiSjgUnUg7ZvvrxTA0ofWjZv1t88ZgJB8KnrMdffi6TI93
	ScYAFCHmJJuAD1Y5wARk7c0hQjxb8kQv1S1FuaVfJ2bHgLGh/RrGWTNxxGWzWtglFVc=
X-Gm-Gg: ASbGncurYgEc6J9nidJM6IL0+gmofd6q6SKgKdgX3RbfArWCXTrVa5UtVrRfTwK5xU/
	VUuekhbZfsjqF3cVSH0uPtwc/KBzFze7zSq1pFWPjPv4Ccz9gBEK1H4p2huViHZJw0HZfg28jh5
	TyazzhqYTGLZP8P8/+RvSV8j+aXMOVotb+sa3AwVaxzSF79pAKQVE0JBpifNCW9zB4sK3VwXIIS
	8kRccLnBoSTzMzq57MybLBvi1gdrHztZdun0j1mWV9DOEapkPiuETchYeUZeOQeRSUn+uj+aI8V
	not6v2lbjF4PbIUHQXxvs/ShhIKmY5Kr5C8psBGrkd5ZyieCwHOi1QVqMSxGzxtbxBSvWvCID0n
	L65Y0678kCu4Bx2Gp5gFBaXCX76n8QnM8Oyg9VORhZXT1LJyTG7cKqm7T2b3+J3aB72c8SilMtJ
	wzLukCvvC0Ovt5+lkcpi5qpw==
X-Google-Smtp-Source: AGHT+IFuQphml+3tSf/kNUKzOSrQUbkNN4IQAlQeDGBfiV9Ri5g+RslgrcOdjzz4EiXYtcwTC8PEKw==
X-Received: by 2002:a17:903:244b:b0:272:c95c:866 with SMTP id d9443c01a7336-2902723c20cmr98032745ad.20.1760017535202;
        Thu, 09 Oct 2025 06:45:35 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f95ecbsm28718335ad.130.2025.10.09.06.45.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Oct 2025 06:45:34 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	ardb@kernel.org,
	willy@infradead.org,
	guoren@kernel.org,
	ziy@nvidia.com,
	akpm@linux-foundation.org,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	ajones@ventanamicro.com,
	parri.andrea@gmail.com,
	cleger@rivosinc.com,
	yongxuan.wang@sifive.com,
	inochiama@gmail.com,
	samuel.holland@sifive.com,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	yikming2222@gmail.com,
	andybnac@gmail.com,
	yury.norov@gmail.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC] riscv: add support for Ziccid
Date: Thu,  9 Oct 2025 21:45:14 +0800
Message-Id: <20251009134514.8549-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ziccid extension provides hardware synchronization between
Dcache and Icache. With this hardware support, there's no longer
a need to trigger remote hart execution of fence.i via IPI.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/cacheflush.h |  4 ++--
 arch/riscv/include/asm/hwcap.h      |  1 +
 arch/riscv/include/asm/switch_to.h  | 10 ++++++++++
 arch/riscv/kernel/cpufeature.c      |  1 +
 arch/riscv/kernel/ftrace.c          |  2 +-
 arch/riscv/kernel/hibernate.c       |  2 +-
 arch/riscv/kernel/jump_label.c      |  2 +-
 arch/riscv/mm/cacheflush.c          | 16 ++++++++++++++--
 8 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 0092513c3376c..3a8cdf30bb4b1 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -68,7 +68,7 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 
 #else /* CONFIG_SMP */
 
-void flush_icache_all(void);
+void flush_icache_all(bool force);
 void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
@@ -80,7 +80,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 #define flush_icache_range flush_icache_range
 static inline void flush_icache_range(unsigned long start, unsigned long end)
 {
-	flush_icache_all();
+	flush_icache_all(false);
 }
 
 extern unsigned int riscv_cbom_block_size;
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a3..ad97d8955b501 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,7 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZICCID		100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920c..b8a9e455efe9e 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -98,7 +98,17 @@ static inline bool switch_to_should_flush_icache(struct task_struct *task)
 	bool stale_thread = task->thread.force_icache_flush;
 	bool thread_migrated = smp_processor_id() != task->thread.prev_cpu;
 
+	asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0, RISCV_ISA_EXT_ZICCID, 1)
+		 : : : : ziccid);
+
 	return thread_migrated && (stale_mm || stale_thread);
+
+ziccid:
+	/*
+	 * Process switching writes to SATP, which flushes the pipeline,
+	 * so only the thread scenario is considered.
+	 */
+	return thread_migrated && stale_thread;
 #else
 	return false;
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 67b59699357da..2da82aa2dbf0a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -540,6 +540,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
+	__RISCV_ISA_EXT_DATA(ziccid, RISCV_ISA_EXT_ZICCID),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 8d18d6727f0fc..431448e818363 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -43,7 +43,7 @@ void arch_ftrace_update_code(int command)
 {
 	command |= FTRACE_MAY_SLEEP;
 	ftrace_modify_all_code(command);
-	flush_icache_all();
+	flush_icache_all(false);
 }
 
 static int __ftrace_modify_call(unsigned long source, unsigned long target, bool validate)
diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 671b686c01587..388f10e187bae 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
 	} else {
 		suspend_restore_csrs(hibernate_cpu_context);
 		flush_tlb_all();
-		flush_icache_all();
+		flush_icache_all(true);
 
 		/*
 		 * Tell the hibernation core that we've just restored the memory.
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index b4c1a6a3fbd28..680b29f4c09c4 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -51,5 +51,5 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 
 void arch_jump_label_transform_apply(void)
 {
-	flush_icache_all();
+	flush_icache_all(false);
 }
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index d83a612464f6c..01f9f7a45e8d2 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -12,19 +12,24 @@
 #ifdef CONFIG_SMP
 
 #include <asm/sbi.h>
+#include <asm/alternative-macros.h>
 
 static void ipi_remote_fence_i(void *info)
 {
 	return local_flush_icache_all();
 }
 
-void flush_icache_all(void)
+void flush_icache_all(bool force)
 {
 	local_flush_icache_all();
 
 	if (num_online_cpus() < 2)
 		return;
 
+	if (!force)
+		asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0,
+			RISCV_ISA_EXT_ZICCID, 1)
+			: : : : ziccid);
 	/*
 	 * Make sure all previous writes to the D$ are ordered before making
 	 * the IPI. The RISC-V spec states that a hart must execute a data fence
@@ -41,6 +46,7 @@ void flush_icache_all(void)
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
+ziccid:;
 }
 EXPORT_SYMBOL(flush_icache_all);
 
@@ -61,13 +67,17 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 
 	preempt_disable();
 
+	local_flush_icache_all();
+
+	asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0, RISCV_ISA_EXT_ZICCID, 1)
+		 : : : : ziccid);
+
 	/* Mark every hart's icache as needing a flush for this MM. */
 	mask = &mm->context.icache_stale_mask;
 	cpumask_setall(mask);
 	/* Flush this hart's I$ now, and mark it as flushed. */
 	cpu = smp_processor_id();
 	cpumask_clear_cpu(cpu, mask);
-	local_flush_icache_all();
 
 	/*
 	 * Flush the I$ of other harts concurrently executing, and mark them as
@@ -91,6 +101,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
 	}
 
+ziccid:;
+
 	preempt_enable();
 }
 
-- 
2.39.5


