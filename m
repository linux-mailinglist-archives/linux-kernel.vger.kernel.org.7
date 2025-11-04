Return-Path: <linux-kernel+bounces-884207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7FC2F9D4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF8E94E724B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF13074B1;
	Tue,  4 Nov 2025 07:30:18 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22329306B31
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241418; cv=none; b=OK6UhtfENJCjorKhSC++HGVm+H1Uju/ffwb0rJfefXea3HLoSACuutWRv4ZbM1tKzaLzE9FdW7X4K9FqfaXdqNSPMchFPA3yd9DIiNnfSdBu7QrWkshap+uyHxtzx5T1dddih+o6BO5b/pxNyzAorXkrk3hi0Hku3hXwqJkWwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241418; c=relaxed/simple;
	bh=4qu48qG7YL4eZS1i6WIUe1h73DZmFPEKiZYJlND7Mn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DT+1IIB1RsF4Al4hIcApUGtPHZzWWf3JWbf3MIemZ9HPSlz0ydAmy+FLPuPD8Sen6eTKuNLm8fqoeeYDBDAkiCZGmLekftmRl1ZZYeBRNcnZti9UAWTPyiQmhEH7Ob1raNoms7GniafCKAMX5uF0Glv8A/O1GDD7cFDlrDDH93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.57.136])
	by gateway (Coremail) with SMTP id _____8BxmdGDqwlpspkeAA--.1093S3;
	Tue, 04 Nov 2025 15:30:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.57.136])
	by front1 (Coremail) with SMTP id qMiowJAxfcGBqwlpo+MlAQ--.61910S2;
	Tue, 04 Nov 2025 15:30:09 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com,
	linmag7@gmail.com,
	thuth@redhat.com,
	maobibo@loongson.cn,
	apopple@nvidia.com
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Liupu Wang <wangliupu@loongson.cn>
Subject: [PATCH] Loongarch:Make pte/pmd_modify can set _PAGE_MODIFIED
Date: Tue,  4 Nov 2025 15:30:06 +0800
Message-ID: <20251104073006.1764241-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcGBqwlpo+MlAQ--.61910S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFWftFWkAFyxAw1xWw47KFX_yoW8Zr4UpF
	s7CF9Yvay5Kr1xZay3JF17Xr15AwsrGas7J3sFk3WkG3Wqq3yjqr1xKwn8Zr1rXay8Zr18
	X3yFgw45WF4UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

In the current pte_modify operation, _PAGE_DIRTY might be cleared. Since
the hardware-page-walk does not have a predefined _PAGE_MODIFIED flag,
this could lead to loss of valid data in certain scenarios.

The new modification involves checking whether the original PTE has the
_PAGE_DIRTY flag. If it exists, the _PAGE_MODIFIED bit is set, ensuring
that the pte_dirty interface can return accurate information.

Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/include/asm/pgtable.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index bd128696e96d..106abfa5183b 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -424,8 +424,13 @@ static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
-		     (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
+	unsigned long val = (pte_val(pte) & _PAGE_CHG_MASK) |
+		     (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
+
+	if (pte_val(pte) & _PAGE_DIRTY)
+		val |= _PAGE_MODIFIED;
+
+	return __pte(val);
 }
 
 extern void __update_tlb(struct vm_area_struct *vma,
@@ -547,9 +552,13 @@ static inline struct page *pmd_page(pmd_t pmd)
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-	pmd_val(pmd) = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
+	unsigned long val = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
 				(pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
-	return pmd;
+
+	if (pmd_val(pmd) & _PAGE_DIRTY)
+		val |= _PAGE_MODIFIED;
+
+	return __pmd(val);
 }
 
 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
-- 
2.41.0


