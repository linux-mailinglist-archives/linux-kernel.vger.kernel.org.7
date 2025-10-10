Return-Path: <linux-kernel+bounces-848890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB21BCEC2C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694D93BB67C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF028153D;
	Fri, 10 Oct 2025 23:36:55 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEB27FB37
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139415; cv=none; b=D/K9pDxW0HUtdkD9XJTCmkLKL08JyuMgM/2aNNfzHJ4Pm553D3TFPTw77yDqZe7LZ0Hj0jwI4BydbuDV+vBY+R/5Xmtx6rBvaqJZxppTTOzq34sh300B+9nM8AsEnrJHLLZiiK+GcZP8V38hyl8TCTcZV6KXtpfGiI2Lucbzl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139415; c=relaxed/simple;
	bh=yn549GC5MTVOmDeuKYorX8vzwQVzn0ayeG7Hx9nghZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iEFp5jr83cbEhvozc84GjqOdS0S66wPyMxG0u39K4bqxTrFNkVO+MqiKKb8+My/mpKK3G2Cc54zelq6IePZ09MaLtRhbNwpIhNC6vsdojKJMpE3r8Mmq0pcAJVJGGM7T9AUxMZvNoew1vJ114uur0xg4d0lXetmLNDQTkF8J8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.81.247])
	by APP-05 (Coremail) with SMTP id zQCowADHaxVUmOloXC2IDQ--.41211S3;
	Sat, 11 Oct 2025 07:35:48 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Sat, 11 Oct 2025 07:35:43 +0800
Subject: [PATCH v3 1/5] riscv: pgtable: Use __riscv_has_extension_unlikely
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-riscv-altn-helper-wip-v3-1-d40ddaa1985a@iscas.ac.cn>
References: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
In-Reply-To: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Walmsley <pjw@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, 
 =?utf-8?q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Vivian Wang <uwu@dram.page>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowADHaxVUmOloXC2IDQ--.41211S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUKFW8uF4rXr1fJF45trb_yoW5Cw1Upr
	Z3CasxWrWrCw1xurZ2yr4DCr45Z39ag3W3Kr1S93WrAr4akw42vrnxJ3Wayry8Ja97X348
	KF4akr45W3W3Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUjrHUDUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Use __riscv_has_extension_unlikely() to check for RISCV_ISA_EXT_SVVPTC,
replacing the use of asm goto with ALTERNATIVE.

The "unlikely" variant is used to match the behavior of the original
implementation using ALTERNATIVE("nop", "j %l[svvptc]", ...).

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 arch/riscv/include/asm/pgtable.h | 15 +++++++--------
 arch/riscv/mm/pgtable.c          | 22 ++++++++++------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 29e994a9afb67c638173d4a2475fdfbd91bee967..02f37322eb83a113b411e95e153fecc5c20319ad 100644
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
+	if (__riscv_has_extension_unlikely(0, RISCV_ISA_EXT_SVVPTC))
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
index 8b6c0a112a8db4e91de54c3bd3bd527a605a6197..289ca6fa6b4de80d42287d28e266a0a8d3848cff 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -9,8 +9,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
 {
-	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
-		 : : : : svvptc);
+	if (__riscv_has_extension_unlikely(0, RISCV_ISA_EXT_SVVPTC)) {
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


