Return-Path: <linux-kernel+bounces-860421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3060BBF018E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5145189EAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B12ED846;
	Mon, 20 Oct 2025 09:10:19 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C529ACC3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951419; cv=none; b=dW5iF3vabOWa1fW+/scY3rh5mnomobc2Z+eGQoSzWiz6gxtiT63bt1HNKoCI0fGba5g+5rvEdzaSF3OBQ9RXsR/vh7UpXvXeh+yP/CGDIvCb0XbnGlxjy/6Acamk9nHeK0iIxUqxAo1W5t+DeXJ2FJpuDCtOEYFbOX7RO0SRwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951419; c=relaxed/simple;
	bh=1Fpu5TRjaKm/gCFWSwIXaUyUaS0kUs+SPCDS31PS0kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/FpPdksjhsaGeoQG2ECco0v9FHHCtp09gBj58mPVFOcNTHV8e+75UFeGq+zqLVcsVXtAPUrKj35p/PSE0SeDuop62lorDfR97pPuSd/SqfjuqWafC1mHalSRF03i2KrwdtMd+wDZF3rEVOoE1hcb7L1U0g0L0Tz6AuEHBY0zrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-03 (Coremail) with SMTP id rQCowAD3RoFo_PVo4mflEQ--.23190S3;
	Mon, 20 Oct 2025 17:10:00 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 20 Oct 2025 17:09:56 +0800
Subject: [PATCH v4 1/5] riscv: pgtable: Use riscv_has_extension_unlikely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-riscv-altn-helper-wip-v4-1-ef941c87669a@iscas.ac.cn>
References: <20251020-riscv-altn-helper-wip-v4-0-ef941c87669a@iscas.ac.cn>
In-Reply-To: <20251020-riscv-altn-helper-wip-v4-0-ef941c87669a@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Walmsley <pjw@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, 
 =?utf-8?q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-CM-TRANSID:rQCowAD3RoFo_PVo4mflEQ--.23190S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUAw18GrW7Aw4xtr1DJrb_yoW5Zr4Upr
	Z3Ca9IgrWrCw1Ivrs7trs8ur4Yv393W3W3Kr1Sg3WFyr4ak3y2vrsxJa1Syry8JFWxX348
	KF4fKr4UG3Wayr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUfKs8UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use riscv_has_extension_unlikely() to check for RISCV_ISA_EXT_SVVPTC,
replacing the use of asm goto with ALTERNATIVE.

The "unlikely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("nop", "j %l[svvptc]", ...).

Note that this makes the check for RISCV_ISA_EXT_SVVPTC a runtime one if
RISCV_ALTERNATIVE=n, but it should still be worthwhile to do so given
that TLB flushes are relatively slow.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/pgtable.h | 15 +++++++--------
 arch/riscv/mm/pgtable.c          | 22 ++++++++++------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 29e994a9afb6..d1a4bdc36f2c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -496,8 +496,13 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
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
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC))
+		return;
 
 	/*
 	 * The kernel assumes that TLBs don't cache invalid entries, but
@@ -509,12 +514,6 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
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
index 8b6c0a112a8d..807c0a0de182 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -9,8 +9,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
 {
-	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
-		 : : : : svvptc);
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC)) {
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
2.51.0


