Return-Path: <linux-kernel+bounces-794447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B492B3E1E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EDF188CD71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B331DDA4;
	Mon,  1 Sep 2025 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EJSxSOTI"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9AD31CA5F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726916; cv=none; b=gkBcM8pncPpL2Dz8Pz6r5I3aK17Ad8JbPPbVP71wHqZMkqDmGiTAabEW0uI1ZK4FBeRJGOkO9MUrbrsVW/jpDAbEW7Yhg988VuJp+V9OFN36O89Jc6d92ClKbHz6t4WRLG/CDy6L4ErpAs94IOSsAxkLVaBcMKmKG/W6z4Vr+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726916; c=relaxed/simple;
	bh=bmoCRBZVQHKL7pYu0BadqLLVNtiz9T3RkUnAwpiNyrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t63wkbRf/SyfIj6pwRB1vDDrhpOtYuBdMFj4fA2/CaLsP7WWRL9mC8tWCr6M9GhuibI+YcgeP5sra7xTRrshT//p+ToBHCl98TD3KzDkyrIBnqd9dwZ9LRBFE/InXAty0c3qbrkL3vwgEpXszpoM8uxr2jZVaHkIJz95uHu5V3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EJSxSOTI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248a638dbbeso37885305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726914; x=1757331714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLolE06gtjbWk3ZkrQiU7O1WYGsW8aCemQeBBGyQyek=;
        b=EJSxSOTI/EoJZh4dMR9nka2CukJ827E3kcQK7OsItlIFPVeSUQ9G7tYZnzgerv2y7C
         0s1I2oRWVkgFGy6S8RSYSWLQueua2grLXEgdY0D4PRy1Dp0xlRKPb2ANdfOdGEZuMoGY
         /wdjMnBzCVpVEDOJYavMQlKUFMfenq7vSTfQdbZPfoVhwQCYACqbtcH4OBXvykp82JVW
         8CJgFGKlHFcr2uolBfF5sBACuXUNNNKPIxen51vOllYeXLxEoOeoisIVjmAzP5l9mqP9
         MkeAlsN2tBU/DxvlYcWwAL7y4H5YYRqpeoVuxIgyWl7rb6Ob267itZz6TZG/J8vEDWp1
         7MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726914; x=1757331714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLolE06gtjbWk3ZkrQiU7O1WYGsW8aCemQeBBGyQyek=;
        b=WQBstWbrrHm4cEIvlL+saIjOa+E88rpN22KxL77NSz8ij+7hTJkdg8Bxr+O48/bmvc
         1a9qR3/dMpivUMV0zvMHnAi/MyRACG2sih6P/Ct9tapY8N5ogadbP4JlhG+uQjKSVaBT
         0bGac0M0osFQAsXrgDq1PAd4xuXXVQ6N7SMdTyL9CjBUMD6eq4aaJgaezPxA3an4vN+p
         /uusEUE/0ec9jYXNmd6fn/CQLRfyim4WBzCRFeHG6sU9y7NLZ8+oubZBmEe1yBdQ/ghM
         aW7/vGiIuVI4VjHNTwMx+QjSZApt4FWs4J3TZ3CUgtfDnlodARQea/8Vfghq/KF7BUoC
         TYHA==
X-Forwarded-Encrypted: i=1; AJvYcCWytqRn54Bfcl+dFBCsb+ke1W/WAxa96W4lABQA/zsogJBtsAp+S9uwvSMWbGbwx2zgl4FBtCdnW0Dgrcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE1aflc50mtK/DIWEyqiHKQ3ZKd+jae3MvkyKw3z0lmnerfetB
	47V8q8Kd9eJcDmW+twB+IsXN4D9DshzLj8NrOlTlXAayUvya43uKrDH8UuFJepZ+mPVs72K6hVY
	VneqnFg0=
X-Gm-Gg: ASbGnctBkjKIe/WMSy8bPt8UoKOXlBHcjyrLFwl8ckmZNVMUyYnAdUKHWgEeACCQgTa
	l3XYkWWPhE/b4OybmLM7PrlpxldkQFjZSy8K+lb5UZwdQ3h7b7DnbRB7b6auXRo9cHe0+VKKjcU
	bR0tVaj8f/wHSd2Mp4ZlmV+L5wHKS/wJy+0/HxM4SJKX811wCCUAiGzY3xy1VeR2+wRqAxKMm0i
	pcSfpEdlcY8+AgBXNJ8LEw8kBfW/O2Fm50lB3L3UBiJanAtXdrNwXoSbQbJ9CQZh19+TSmv8xjX
	kn0DdqcBcIAWjPqilBuYApp4Zkn0FUXrDVxUtodujJBZjxWA6Ci3sEz9wtIqD1s1o6mKC0wlNl2
	T1SWV47/yiS2jERXVxFPXj7sxFcw5bPomur022oAuKBn7shOMzWuzmwQK3Mcs9TC99EvvprPrvS
	WtiEeWXLCmgRKeWHSeNEuNPNNqbpR0tQNRwm7H/IkHSvGHHgfUSvzrKg==
X-Google-Smtp-Source: AGHT+IE0gpMY+RbD+bbQtAxSuQoUme95REJGQ1QUPydfC5VbbDQitYO6UEhOO5n3dpTz10zYDTEtww==
X-Received: by 2002:a17:902:e74a:b0:249:1bd6:8a2f with SMTP id d9443c01a7336-2494486ee08mr115512295ad.3.1756726913831;
        Mon, 01 Sep 2025 04:41:53 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e042asm103147055ad.146.2025.09.01.04.41.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:41:53 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH RESEND 1/2] riscv: mm: Apply svinval in update_mmu_cache()
Date: Mon,  1 Sep 2025 19:41:40 +0800
Message-Id: <20250901114141.5438-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901114141.5438-1-luxu.kernel@bytedance.com>
References: <20250901114141.5438-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only flush tlb of the specified mm, and apply svinval if available.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h  | 16 +++++++++++++++-
 arch/riscv/include/asm/tlbflush.h | 23 +++++++++++++++++++++++
 arch/riscv/mm/tlbflush.c          | 23 -----------------------
 3 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f901..165cd02d51629 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -495,9 +495,15 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 		struct vm_area_struct *vma, unsigned long address,
 		pte_t *ptep, unsigned int nr)
 {
+	int i;
+	unsigned long asid = get_mm_asid(vma->vm_mm);
+
 	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
 		 : : : : svvptc);
 
+	asm goto(ALTERNATIVE("nop", "j %l[svinval]", 0, RISCV_ISA_EXT_SVINVAL, 1)
+		 : : : : svinval);
+
 	/*
 	 * The kernel assumes that TLBs don't cache invalid entries, but
 	 * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
@@ -506,7 +512,15 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
 	 */
 	while (nr--)
-		local_flush_tlb_page(address + nr * PAGE_SIZE);
+		local_flush_tlb_page_asid(address + nr * PAGE_SIZE, asid);
+	return;
+
+svinval:
+	local_sfence_w_inval();
+	for (i = 0; i < nr; i++)
+		local_sinval_vma(address + nr * PAGE_SIZE, asid);
+	local_sfence_inval_ir();
+	return;
 
 svvptc:;
 	/*
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index eed0abc405143..9636d07fe9eed 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -15,6 +15,29 @@
 #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
 
 #ifdef CONFIG_MMU
+static inline unsigned long get_mm_asid(struct mm_struct *mm)
+{
+	return mm ? cntx2asid(atomic_long_read(&mm->context.id)) : FLUSH_TLB_NO_ASID;
+}
+
+static inline void local_sfence_inval_ir(void)
+{
+	asm volatile(SFENCE_INVAL_IR() ::: "memory");
+}
+
+static inline void local_sfence_w_inval(void)
+{
+	asm volatile(SFENCE_W_INVAL() ::: "memory");
+}
+
+static inline void local_sinval_vma(unsigned long vma, unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid) : "memory");
+	else
+		asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory");
+}
+
 static inline void local_flush_tlb_all(void)
 {
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8404530ec00f9..962db300a1665 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -11,24 +11,6 @@
 
 #define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
 
-static inline void local_sfence_inval_ir(void)
-{
-	asm volatile(SFENCE_INVAL_IR() ::: "memory");
-}
-
-static inline void local_sfence_w_inval(void)
-{
-	asm volatile(SFENCE_W_INVAL() ::: "memory");
-}
-
-static inline void local_sinval_vma(unsigned long vma, unsigned long asid)
-{
-	if (asid != FLUSH_TLB_NO_ASID)
-		asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid) : "memory");
-	else
-		asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory");
-}
-
 /*
  * Flush entire TLB if number of entries to be flushed is greater
  * than the threshold below.
@@ -110,11 +92,6 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static inline unsigned long get_mm_asid(struct mm_struct *mm)
-{
-	return mm ? cntx2asid(atomic_long_read(&mm->context.id)) : FLUSH_TLB_NO_ASID;
-}
-
 static void __flush_tlb_range(struct mm_struct *mm,
 			      const struct cpumask *cmask,
 			      unsigned long start, unsigned long size,
-- 
2.20.1


