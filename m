Return-Path: <linux-kernel+bounces-788378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25483B38388
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133EC685667
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC48352FF6;
	Wed, 27 Aug 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y+ulyrPP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5835209B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300498; cv=none; b=E2+1izyfFFemLz+vbuMkADCOFXZ9ajlFjSaz2hSvbRI5Ab7q9DJli2oL/hofa4iYMaEyJxBNI9ratPlc30SfAc1mQ+LcWQOETmMR8A0DbroNKoVpOet5aUDx3qUDvkjtjd28BSLx++v5Mli7D3XCsHc+ISXDC2u1nn4mVAvRLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300498; c=relaxed/simple;
	bh=bmoCRBZVQHKL7pYu0BadqLLVNtiz9T3RkUnAwpiNyrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VX9/fgIB2RCILw1UAmvPS4tg2GDHM/KoqC478n1/ey8mCjXz+Cp+BlYAn+r2P8jqNSN3MVHJV6YaadFRLbwtssyoiKa7L6SsdHTCITMCyJmnhkTv7W8H+Ng9i6mV6gcAIkmEW4pXEsQdN5XNK2pAqgmefoacvTtlMvG/23PUPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y+ulyrPP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so780585b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756300496; x=1756905296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLolE06gtjbWk3ZkrQiU7O1WYGsW8aCemQeBBGyQyek=;
        b=Y+ulyrPPeILVH0M9Dk4ZMYOvH2woe7bje5cjNlHt3xcbPk2OWIV7dyfkP1SQTz/5b3
         hYQwAK/2cg8mCyKKAA7v81OSV9vxdLPCObdQIvYbwdpF7i41GSud7UjFvDwsrlBSuGo0
         hVKU823HaPz0LimUiQS3XgOyNjTOK7Qf3vRRXhD6EzE12dhusiRlCd94uZg1ct8tyPrq
         cqlkt1mPQnJkYKbPIpKPSXbA6lGMnmzpMp30bT4q3UgW7smASGwMrAz6No1MLx7odUra
         YrjnpNIEPckg+nM/JKPms2MayfsOnJELSRC+6rRwu+0rCxzZgM1Z3odQyS9qVlP409n5
         1n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300496; x=1756905296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLolE06gtjbWk3ZkrQiU7O1WYGsW8aCemQeBBGyQyek=;
        b=u9UjKWHTdAU/5OE7jVMvDoy+f63tUuKGrCxABCD+7b9NjIUXe0ok11gUdHhTUsXtZU
         h9K3/4rIOXQkF5B6rh3u67yoqwtkOFyEsk5kFsTY/g6VCqSHiFwd9nBdDWX1xUqyTP2l
         dUAhLhDhuk/vFFmrEcpELXu2zBPDUfyNI0ebgUe67H48NS+w73ntNOzSaZt0Emv9eh8E
         S/PElVFAsTAX8CL5NbSQO6c20BgPXs2cQyXiv9HGx375TuqH2mFhq9VoaLq4vHER+XoX
         lrr2U72ZL/aWH8qJO9fG2XBtHrqSeUx628WpLYIT3nhFQU0dlQPRN15kdLGHdaczcC6H
         LPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDIj4xX2U1JMpiS49x+p68oRpzkuQU1jVzjan/xlnVupoMwSjG8xJn0vXavwa1zHJdY9uYgn80EsCyA2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvvLcW8hFFgAillR+WAAgiJTeflmAHq+a9CVVglzlJMWZdLpyM
	363h4O1L2jNdexp9MVpu5K3hDvwqaQwkSv0IQynCxwEDSWxvgogv1Dc1KwDHmbzrBGI=
X-Gm-Gg: ASbGncsP14CuSDsycML+W/UdAQfWVYzvf9tjciF1EauxmoVxyCIdj22lKHCHTtLy3Ht
	Ckg7M2WAyYgkdeChOI4jPfjnimAJKW8vomFCRARtsM74y8STaonfIBbaXBkdIRrvbEGmGpeTDJV
	mb4CnkgPjayjJCLo+7dfODf+QJBJ5QAEv1pT2eMsxkqizI+rwoDtWjG6DgNuxBYwOdF5P6pMtLO
	KRgz8h7m7L4Cy965/cm3WlzepEi6o4eLXndoALkkF989DL3iOBwNnR2VjVd1d/V6kYgJuvuy91U
	WyFJsiUDvUU+gBDc3rSpDHhxUg2IUqTbz3sXBLDDqFD/aeliAUZZmALgR+H+SWci3KtEqqwGNho
	wFqYy1PcbpzkJJLEYI0a7zlo5W75Ijxqa700F7rQ9+H46mssHKIMUo0q+++99gpnFKk5T39znBv
	MuQJimhtFVJRH4a5Vd4I5udaTLi8RoWsPH93qN33NiIuA=
X-Google-Smtp-Source: AGHT+IGftdTOYF6nz2F5q8dhfpn+4AbM7RtvMhIPeiys1+oPjBs4p7djASEQc/d8Vhh5vx91SCurfQ==
X-Received: by 2002:a05:6a20:12cc:b0:243:78a:82d0 with SMTP id adf61e73a8af0-2438facc6aemr7067488637.29.1756300496326;
        Wed, 27 Aug 2025 06:14:56 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772017f538esm3172443b3a.21.2025.08.27.06.14.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 06:14:56 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 1/2] riscv: mm: Apply svinval in update_mmu_cache()
Date: Wed, 27 Aug 2025 21:14:43 +0800
Message-Id: <20250827131444.23893-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250827131444.23893-1-luxu.kernel@bytedance.com>
References: <20250827131444.23893-1-luxu.kernel@bytedance.com>
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


