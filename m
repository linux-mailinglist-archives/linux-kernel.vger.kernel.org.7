Return-Path: <linux-kernel+bounces-889750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6BC3E680
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1996188ACB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE0224AEF;
	Fri,  7 Nov 2025 03:58:20 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C581DE8AE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762487899; cv=none; b=cp8c/qCfbEipVjBxaNyserpTlcH8BHOFWLuxQ8f239cJ/Vjnf8xDfzJh3csxW95Zs3p7f3C34/0nb9slgsxsXA8c/wGXKaiY2W3/KLxsQzuyGngR2NHH4TK+XRs0bqxdL6CNJljlqHYXJNdJJTC+TsgZaRaq+3909tXQqF6q4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762487899; c=relaxed/simple;
	bh=PXrE+deCMowO9AFWIGSKYMU86NoDQh1TE8UqdrIAGWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJ4BjRMXr2uKqADm14Xc9fH1rfcz4vwqqJyVnflsApZwJjJqHDSoQyUx3koib9c7XbKCo1LCwEUBub6Qrzx8XBeSoQg+DpEy2rL92p72Zdrol/XT8T8iKdww0Hlgc8Yn09brbZC0IQcSecKhOsjvoDJksfyfyNZQQHH2OsU6xfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.57.136])
	by gateway (Coremail) with SMTP id _____8Dxvr9Pbg1pFh8gAA--.2455S3;
	Fri, 07 Nov 2025 11:58:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.57.136])
	by front1 (Coremail) with SMTP id qMiowJDxQ+RObg1pVHgqAQ--.1001S2;
	Fri, 07 Nov 2025 11:58:06 +0800 (CST)
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
Subject: [PATCH v2] LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY
Date: Fri,  7 Nov 2025 11:58:05 +0800
Message-ID: <20251107035805.3094024-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+RObg1pVHgqAQ--.1001S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW8uw1rtryfCrW8Zw45CFX_yoW8Wry7pF
	s7AFykua1rKF1xAay3GF13Xr13AwsrGFn7GrnFkF1kGasIq3yUXrW8Krn8AFyrXay8Za48
	XrsYgw45WF47AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

Now, if the pte is dirty _PAGE_DIRTY but without _PAGE_MODIFIED, after
pte_modify() we lose _PAGE_DIRTY, then pte_dirty() returns false. So
we need _PAGE_MODIFIED to record _PAGE_DIRTY here.

The new modification involves checking whether the original PTE has the
_PAGE_DIRTY flag. If it exists, the _PAGE_MODIFIED bit is set, ensuring
that the pte_dirty interface can return accurate information.

Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/include/asm/pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index bd128696e96d..e0b92fe850b3 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -424,6 +424,9 @@ static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
+	if (pte_val(pte) & _PAGE_DIRTY)
+		pte_val(pte) |= _PAGE_MODIFIED;
+
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
 		     (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
 }
@@ -547,6 +550,9 @@ static inline struct page *pmd_page(pmd_t pmd)
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
+	if (pmd_val(pmd) & _PAGE_DIRTY)
+		pmd_val(pmd) |= _PAGE_MODIFIED;
+
 	pmd_val(pmd) = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
 				(pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
 	return pmd;
-- 
2.41.0


