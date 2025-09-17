Return-Path: <linux-kernel+bounces-821209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938FB80BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6CC1C80FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50AD2FC022;
	Wed, 17 Sep 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEbDzn3b"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36B341346
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124116; cv=none; b=ttUOEmvY/NiOD3YddBKLudGKibLhbmPS62/YFb7yBQMlEzIjqbiKENhq1Q2qamKX/axJmPVzZ1HIp4sRNCIrr4PWbIj9+VGN4egj0NPDZ1L18515vUWCabvdr6JMFs/K6zZ/IM/BgBvWZAKHuu2wy1qwOYfbct1BV5eJIf9Diyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124116; c=relaxed/simple;
	bh=zC9ExXt9NWHJcLBpmurNQUP49mAFiZyVpcwenBGX6H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLypIuTcM3Va4l7bvYpzkQ8W6MLSIXsYf96WCDD88JYyLLzWvYmmHECf7LoPKMtDeqcrSZ4Zwc8y3VoXHcBuz2uAEwavF5sX9ubL7Acbpz2A/giC3ugnrXWMYZ9fq5pTWXXaHy37t8TnWVzw7VFrOATfQdSos9DdB8bX8RjrbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEbDzn3b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2680cf68265so7681855ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758124114; x=1758728914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5RPYj2govdLgAJsVUJ2S305q8KB/kIKY0e8R/KfmxA=;
        b=CEbDzn3b6eCsmEncox/Ufomvq5R+jFneM2cU9Y1sXSe/nKj4Vy6G+jxGkSoMyzJy3+
         aRFFL/TxZfFQ9SXfdiBY8gl0Pw7tjocsCiBZ+2C1T8ubxszhKmFmciq71+5/RECVuRyP
         J6C6tCweDpMkx00LVfAhF227AKj3wV2IgDY7+seRX4boa+tTjJ3u9eDuscgA9PlOc60Z
         ZKN/W1J+e8LkvvJlCAgq8lQYUzNwmJ2Bf5rCyfzQJyKzUr6zr0pTAAWTht9DWT+RZbcx
         NQYrkCDMMjRk4lY1sJzwBOMNZTcbXsLSlCbPSbEyTxZfvZD3YMIiu8c56TFlUmoVh3wz
         9I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124114; x=1758728914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5RPYj2govdLgAJsVUJ2S305q8KB/kIKY0e8R/KfmxA=;
        b=NVtQy0O0kyUb9xMhzdBzRI1RqaTEWMc7F0t5hUuJHg8e3u5fEBGmcpFCwbvMljv23z
         2JvSch59EX3F4RHyes5mcB4bDPI/NIW2HySSi1azb2jpP+ae54ZPp6bnMDUBVEq5UO0X
         c1MwWnP6Rnrl7Feq92s4R4BbQ3V1/uBc4QDTNRcVM6/YNBl0ly2NwjUpZJv+XDmkO87w
         I1lZWgITrQa1g3DALW7Zg8UYojHZM0PKp51qjSgqA5IVDDA5OftI8fk5QHlsxmAkjn1w
         NVrQkl7BB8QpQMoKUGlBI5Qc9r6un0AedOuwEyf2eA/w+IWv7cMzMIFlWy8r2nl6DVYz
         kL8A==
X-Forwarded-Encrypted: i=1; AJvYcCXxG1jD72bJzpkJr6AcZdYdHSEfPFhV1Ik3Rf/ozND2cwHF6rthIGX0lT6MxIyoPZarI1cMqFg8MEG90QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZq+8iLoUJGHDzXFLk45s1GN0azsGFX3bcDpwnh7aI7fkX/B7+
	SCgKLS2CafYmWfydSKqglwNKncFC2gXgUsaq/Fa2kQpsg3KAM8QMilv3
X-Gm-Gg: ASbGncsPTKtmGL38TjTh8ftDjDj1BdA5nxTaafI7U8k3wMGT9a8NC7Pj0nBLsyIqUIz
	RtagoLMS5PJFHYE90/+8Koi5592NG1e6VrB9hrK4NxU60enAuG1LJU++vZ9utM3v5av2Hk1jKAo
	/j4SfBRh8cjV0VO5Kc6cIIAt/hz56Il6nUCVjusOyIYV6LswffqHeCVPRRp5hzBgWTHYmKBE/Lv
	4IceHtyhfmNmqn1dqBguqvRRNLgtbhnJ0vcfkYrNtbBov18seuY1asYuB89gSWbmQ816jePqcsq
	hHp5VuK11lcSA2FUoPhJk4ZkAH48FFdvulMv0N41JR7zkGuKWJILPX2g9qkl4oGqFglwlTdfl3C
	cRy1EHtnsccH3pHejzw5QsfCiP6NcNOVaOw==
X-Google-Smtp-Source: AGHT+IG+Qiac11pmTk0tCinNrp10vTINXiw2GLyFTb6yRHVut739dW6S796H6UTFDPxnHEvjt3sMJg==
X-Received: by 2002:a17:903:19eb:b0:266:e8c3:4712 with SMTP id d9443c01a7336-26813f198d7mr36117175ad.58.1758124113638;
        Wed, 17 Sep 2025 08:48:33 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea0f94005sm2569799a91.1.2025.09.17.08.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:48:33 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: mingo@redhat.com,
	tglx@linutronix.de,
	jroedel@suse.de
Cc: linux@armlinux.org.uk,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	urezki@gmail.com,
	arnd@arndb.de,
	vincenzo.frascino@arm.com,
	geert@linux-m68k.org,
	thuth@redhat.com,
	kas@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] mm: introduce ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to sync kernel mapping conditionally
Date: Wed, 17 Sep 2025 23:48:29 +0800
Message-ID: <20250917154829.2191671-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

After commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for
vmalloc area"), we don't need to synchronize kernel mappings in the
vmalloc area on x86_64.

And commit 58a18fe95e83 ("x86/mm/64: Do not sync vmalloc/ioremap
mappings") actually does this.

But commit 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK
and arch_sync_kernel_mappings()") breaks this.

This patch introduces ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC to avoid
unnecessary kernel mappings synchronization of the vmalloc area.

Fixes: 6659d0279980 ("x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 arch/arm/include/asm/page.h                 | 3 ++-
 arch/x86/include/asm/pgtable-2level_types.h | 3 ++-
 arch/x86/include/asm/pgtable-3level_types.h | 3 ++-
 include/linux/pgtable.h                     | 4 ++++
 mm/memory.c                                 | 2 +-
 mm/vmalloc.c                                | 6 +++---
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index ef11b721230e..764afc1d0aba 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -167,7 +167,8 @@ extern void copy_page(void *to, const void *from);
 #else
 #include <asm/pgtable-2level-types.h>
 #ifdef CONFIG_VMAP_STACK
-#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
+#define ARCH_PAGE_TABLE_SYNC_MASK		PGTBL_PMD_MODIFIED
+#define ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC	ARCH_PAGE_TABLE_SYNC_MASK
 #endif
 #endif
 
diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 54690bd4ddbe..650b12c25c0c 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -18,7 +18,8 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLER__ */
 
-#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
+#define ARCH_PAGE_TABLE_SYNC_MASK		PGTBL_PMD_MODIFIED
+#define ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC	ARCH_PAGE_TABLE_SYNC_MASK
 
 /*
  * Traditional i386 two-level paging structure:
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 580b09bf6a45..272d946a3c7d 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -27,7 +27,8 @@ typedef union {
 } pmd_t;
 #endif	/* !__ASSEMBLER__ */
 
-#define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
+#define ARCH_PAGE_TABLE_SYNC_MASK		PGTBL_PMD_MODIFIED
+#define ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC	ARCH_PAGE_TABLE_SYNC_MASK
 
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2b80fd456c8b..53b97c5773ba 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1476,6 +1476,10 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
 #endif
 
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC
+#define ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC 0
+#endif
+
 /*
  * There is no default implementation for arch_sync_kernel_mappings(). It is
  * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..cd2488043f8f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3170,7 +3170,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 			break;
 	} while (pgd++, addr = next, addr != end);
 
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC)
 		arch_sync_kernel_mappings(start, start + size);
 
 	return err;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5edd536ba9d2..2fe2480de5dc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -311,7 +311,7 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC)
 		arch_sync_kernel_mappings(start, end);
 
 	return err;
@@ -484,7 +484,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
 		vunmap_p4d_range(pgd, addr, next, &mask);
 	} while (pgd++, addr = next, addr != end);
 
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC)
 		arch_sync_kernel_mappings(start, end);
 }
 
@@ -629,7 +629,7 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 			break;
 	} while (pgd++, addr = next, addr != end);
 
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK_VMALLOC)
 		arch_sync_kernel_mappings(start, end);
 
 	return err;
-- 
2.49.0


