Return-Path: <linux-kernel+bounces-896220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F9C4FE72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E9D3A8842
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F6352F8B;
	Tue, 11 Nov 2025 21:42:52 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D533D6CF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897372; cv=none; b=uJ1E4jeAlKTXc7uIP6+SJvP/wKjQ59JafFAO7ILQDT4PJ84qezJJkO6bRLc0elxWueJOEevydONXQ+/UOTnJtGJ0DMXkzAcQrq4Cc4rkEi3L0B7dt//zCr7nknQxn5909hjpcduFI0gwBwZIKs7HrhJhZDzzi4oPdbR8jJEFKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897372; c=relaxed/simple;
	bh=Zit10IcjEQgZrlYn+H0pI2muI6sNj2U/B2zs6yrH+H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t5QG4/WYcWbjHP5Cj9RgDrhUXOGL20RCDFKpJRcy3RukTY7Up4vAYu99qx+gQ+Bgp4rWhmH9mPDJ2Ajg9rK3vVsYchEKptn8mMC7mC49OIEsOgojpotB3pNPvhF3RFwgIGck1FaisuKh2GyFPL6FftH/8prJJpRY3gf27UQ7ErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b28f983333so22409185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897366; x=1763502166;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37+7hBkhzuE7kcjBfybqxVC8HAYgIXzyLEuWgJ3dqEM=;
        b=khOEptkTncqWEQrwpLb0bM46Y9J4xKpqOwyEHqIVJz0B53/XAdweLGaNkr6DZ9FiJr
         wr5nIb/Fodkmf3F0FhyoFjaMoglGwYVwuTVUv4DqxGR1zdiK+5IRmzZOEzpnhhRBtL/+
         wopZM27ke42ZI8A70YlU+ut+/eZoNN7TZYEDBWClNhlAh4fgXMkR2u+CuJjI+F2cAe0A
         4cqqfKYy59Uti23jNpQE1DyKYbcrW3TJUIfXG7FVf6NQjiomy/UKGSRl4MWMJM3VSNOt
         R7nGwrS+3CKWBRlqAG89dk3FO15YMRc3Z58a3Ze5R/t5TvIc6LVB6/GEe/0pldTKllwB
         uXig==
X-Forwarded-Encrypted: i=1; AJvYcCWyvIFgctoyCBtOFLReU4gF7HcXGqcGiZe1AKrebDpuvR18kFBrrw0fcok9sQ0jxCxQvv/XXC5OklL/9pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCK96MAZDg3Z/ocioIJwttd64gBOWkCyEhPupCtv4ST/bejySG
	8ivjI8NYAUjGFue8DfL7p2GK+I9bTK69hmGPVkt8Cmib7qJmfRO4jJ8k
X-Gm-Gg: ASbGncsGzM/kTk/WILgBCs2LCHgDMEnnh/GLCsxvRXVCFRcj1aGm1px8fdH9egGPeM0
	1+DIBsDwAwDzSX2HTzLTz4WQMfge8jayGmPpVevKWzUNgZd8w8S0QdMaN9IKIawLvRj2euLFcrH
	K52leRsta3Iqenj3cP/w8lpWndfal893R8YnxULHW58B66U0c71lZ7FONKBu7/SmRN3lVVtDjG1
	3noBt7KEgcNtv66FhaGblXRQKOqp7Gp3pAt2B+Li9GPB0JC28UrvsfmJg8kTHXFP7GA8KKxDV4q
	7swrgMadUorkcRlmsrveWfyT61KyxgWDdjxQUdac1EFgFz5aVRKyllki44DhtCgF/X4tWTzkFOU
	scNEHsg6+7ajPHdWmL1WIitC0VrfsR0bsA9cOG5K0gGyPB5jW0NbzcWsehT5BXwqwRYjZKxG7Uu
	DytBa/u+7So9/tn111Uw1ug3H+iT1vNtmLefQS2L5rls0jwQ+7290P2ghZViCM70Y=
X-Google-Smtp-Source: AGHT+IG3pd8H8cinV9KY2sxGF9Lqdw5K5u9F1WzBYcrYijYiG5sk7Zas84UeYzEmg+TDrSyPXJndow==
X-Received: by 2002:a05:620a:40c1:b0:8b1:ac18:acc9 with SMTP id af79cd13be357-8b29b77ad4bmr110215985a.32.1762897366312;
        Tue, 11 Nov 2025 13:42:46 -0800 (PST)
Received: from [192.168.2.45] (bras-base-mtrlpq3141w-grc-10-65-95-13-196.dsl.bell.ca. [65.95.13.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6e6asm59918585a.35.2025.11.11.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:42:45 -0800 (PST)
From: Dave Vasilevsky <dave@vasilevsky.ca>
Date: Tue, 11 Nov 2025 16:42:41 -0500
Subject: [PATCH v2] powerpc, mm: Fix mprotect on book3s 32-bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vasi-mprotect-g3-v2-1-881c94afbc42@vasilevsky.ca>
X-B4-Tracking: v=1; b=H4sIANCtE2kC/32NQQ6DIBBFr2Jm3WkAJdKueo/GBcFBJ23VACE1x
 rsXPUCX7+f/9zeIFJgi3KsNAmWOPE8F1KUCN9ppIOS+MCihtBSqxWwj42cJcyKXcKjRG69Va/p
 GNgLKbAnk+Xsqn13hkWOaw3o+ZHmkf2RZosTaaWlaYbS/2cdReVOOr/XqLHT7vv8A7zcQxrQAA
 AA=
X-Change-ID: 20251027-vasi-mprotect-g3-f8f5278d4140
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Nadav Amit <nadav.amit@gmail.com>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-mm@kvack.org, 
 Dave Vasilevsky <dave@vasilevsky.ca>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897365; l=3254;
 i=dave@vasilevsky.ca; s=20251027; h=from:subject:message-id;
 bh=Zit10IcjEQgZrlYn+H0pI2muI6sNj2U/B2zs6yrH+H8=;
 b=dn4omO7A8DZD+V7wNR4W4X80lGIpHjLAHsjIoZ421FOXmVeJST9kiGMlzTgaFTHCkeKQGUtcc
 o99hIiot/c+D1dhxLbSDf+lTXlQ2Eq/JmuM7PJ3WbD/2uIodH6yvTEe
X-Developer-Key: i=dave@vasilevsky.ca; a=ed25519;
 pk=Jsd1btZeqqg6x6y73Dx0YrleQb3A3pCBnUeE0qmoKq4=

On 32-bit book3s with hash-MMUs, tlb_flush() was a no-op. This was
unnoticed because all uses until recently were for unmaps, and thus
handled by __tlb_remove_tlb_entry().

After commit 4a18419f71cd ("mm/mprotect: use mmu_gather") in kernel 5.19,
tlb_gather_mmu() started being used for mprotect as well. This caused
mprotect to simply not work on these machines:

  int *ptr = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
                  MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  *ptr = 1; // force HPTE to be created
  mprotect(ptr, 4096, PROT_READ);
  *ptr = 2; // should segfault, but succeeds

Fixed by making tlb_flush() actually flush TLB pages. This finally
agrees with the behaviour of boot3s64's tlb_flush().

Fixes: 4a18419f71cd ("mm/mprotect: use mmu_gather")
Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Flush entire TLB if full mm is requested.
- Link to v1: https://lore.kernel.org/r/20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 8 ++++++--
 arch/powerpc/mm/book3s32/tlb.c                | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index e43534da5207aa3b0cb3c07b78e29b833c141f3f..b8c587ad2ea954f179246a57d6e86e45e91dcfdc 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -11,6 +11,7 @@
 void hash__flush_tlb_mm(struct mm_struct *mm);
 void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 void hash__flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
+void hash__flush_gather(struct mmu_gather *tlb);
 
 #ifdef CONFIG_SMP
 void _tlbie(unsigned long address);
@@ -28,9 +29,12 @@ void _tlbia(void);
  */
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+		hash__flush_gather(tlb);
+	} else {
+		/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
 		_tlbia();
+	}
 }
 
 static inline void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 9ad6b56bfec96e989b96f027d075ad5812500854..e54a7b0112322e5818d80facd2e3c7722e6dd520 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -105,3 +105,12 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
 }
 EXPORT_SYMBOL(hash__flush_tlb_page);
+
+void hash__flush_gather(struct mmu_gather *tlb)
+{
+	if (tlb->fullmm || tlb->need_flush_all)
+		hash__flush_tlb_mm(tlb->mm);
+	else
+		hash__flush_range(tlb->mm, tlb->start, tlb->end);
+}
+EXPORT_SYMBOL(hash__flush_gather);

---
base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
change-id: 20251027-vasi-mprotect-g3-f8f5278d4140

Best regards,
-- 
Dave Vasilevsky <dave@vasilevsky.ca>


