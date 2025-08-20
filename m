Return-Path: <linux-kernel+bounces-777830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECECAB2DE34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4727AC817
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8F1E835D;
	Wed, 20 Aug 2025 13:45:13 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02750321F59
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697513; cv=none; b=ow2dI345D61gcsB6OKm8jhi9craVMZcnXjoKp3yDD4sX4CSFmgWamxeBI6tg/dWP3x8I3sFNBLYOfo4ujI2cxR5dH944PouYXmA1ZaRmKZD3Etc2uKrLHbC91Ug8i4ntg+127UMlMXUGxgDkDa5JWtSil9RvtFLZ8L9bfCZ7VYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697513; c=relaxed/simple;
	bh=UaCKawQeo4rcaFjHfUPRvD0w2sJMwd20/syfhFSKKaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvE0ixoq1q+5xmNDGHRItusThIy88JrTBs+RMhCEKQFbxpsdi8C9bfxLm3l77ZitQPcjOzeYza3tKOhvZ2eBTQ7CVeKE+k0Ai3f94ar84KHaFFb8RK1yv8P9VTs6LB4Vvdlhc+Wc7SRKYzhgFOCqe7YRFmMcxLFwRbh5HSbgcUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowABHN6tT0aVogOTBDQ--.24665S4;
	Wed, 20 Aug 2025 21:44:52 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 20 Aug 2025 21:44:46 +0800
Subject: [PATCH 2/6] riscv: pgtable: Convert to use_alternative_unlikely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-riscv-altn-helper-wip-v1-2-c3c626c1f7e6@iscas.ac.cn>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowABHN6tT0aVogOTBDQ--.24665S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUKFWUWrWxtFyftF1xGrg_yoW5CFy5pr
	Z3CasxXFWrGw1I9rZayr4Uur45Z39ag3Z8tr1S93ZYyr4akrWavFnxJ3WSvry8Ja97X34x
	KF4Ykr45Gw1ayr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbH5lUUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use use_alternative_unlikely() to check for RISCV_ISA_EXT_SVVPTC,
replacing the use of asm goto with ALTERNATIVE.

The "unlikely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("nop", "j %l[svvptc]", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/pgtable.h | 15 +++++++--------
 arch/riscv/mm/pgtable.c          | 22 ++++++++++------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f9013005800f713797e4b6b1fc8d312..81eb386da837f064c7372530e2f2227575a703d3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -495,8 +495,13 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 		struct vm_area_struct *vma, unsigned long address,
 		pte_t *ptep, unsigned int nr)
 {
-	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
-		 : : : : svvptc);
+	/*
+	 * Svvptc guarantees that the new valid pte will be visible within
+	 * a bounded timeframe, so when the uarch does not cache invalid
+	 * entries, we don't have to do anything.
+	 */
+	if (use_alternative_unlikely(0, RISCV_ISA_EXT_SVVPTC))
+		return;
 
 	/*
 	 * The kernel assumes that TLBs don't cache invalid entries, but
@@ -508,12 +513,6 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 	while (nr--)
 		local_flush_tlb_page(address + nr * PAGE_SIZE);
 
-svvptc:;
-	/*
-	 * Svvptc guarantees that the new valid pte will be visible within
-	 * a bounded timeframe, so when the uarch does not cache invalid
-	 * entries, we don't have to do anything.
-	 */
 }
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 8b6c0a112a8db4e91de54c3bd3bd527a605a6197..e0c414fa0d433fdc39c80ec390c467ca59a9a334 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -9,8 +9,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
 {
-	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
-		 : : : : svvptc);
+	if (use_alternative_unlikely(0, RISCV_ISA_EXT_SVVPTC)) {
+		if (!pte_same(ptep_get(ptep), entry)) {
+			__set_pte_at(vma->vm_mm, ptep, entry);
+			/* Here only not svadu is impacted */
+			flush_tlb_page(vma, address);
+			return true;
+		}
+
+		return false;
+	}
 
 	if (!pte_same(ptep_get(ptep), entry))
 		__set_pte_at(vma->vm_mm, ptep, entry);
@@ -19,16 +27,6 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	 * the case that the PTE changed and the spurious fault case.
 	 */
 	return true;
-
-svvptc:
-	if (!pte_same(ptep_get(ptep), entry)) {
-		__set_pte_at(vma->vm_mm, ptep, entry);
-		/* Here only not svadu is impacted */
-		flush_tlb_page(vma, address);
-		return true;
-	}
-
-	return false;
 }
 
 int ptep_test_and_clear_young(struct vm_area_struct *vma,

-- 
2.50.1


