Return-Path: <linux-kernel+bounces-889418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A5DC3D814
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B974E4E7990
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F0336EDA;
	Thu,  6 Nov 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQevbzIM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298F32E12D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464573; cv=none; b=t6W5M+3+riDIEnT2dnGIKJfOE9UjRtF9ZTboD/IlfvkJltYlzsNND20IM4AiXKATbW3y5kr+xWIicHAuddLTQLEgmiuWJbRcloTWi39aJ88V7vHXW5JauZiJzWnxi8SkXRQpxBky3t08LDPnL2qKMQojCtv9yD+9g6mvJixueW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464573; c=relaxed/simple;
	bh=5RZkoJNqvdAIMPNqKgX7xIBRev8Oxa45/VMhXF9JQus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POSBHo3TJ+N0lNkwRFaBXQyAOYX/rxOReuIgt5EyfRSUxmoR+gxGFfzw2z/aYTlObgwdruT9PKpkpQj3N6XVsXNudpZMcIkFvl8RD85t9ErLO00bUnO0opUWas4fRoGMHONPkzVW/Z+E02oiYg/tdc+N3JYCIIpiPruOmD3jUqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQevbzIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBljr+WN6jo8BbvNcwYQG53rmJXeLFNVvjGUHCqr4HA=;
	b=GQevbzIM2uQuiJ2xOWi/HQ1hQxZtglOkhbgQMgp5IgxI9xhLokceySENIPMS2nhhwDMzq4
	OYOTR9/zCPVtT2hvU/+kQxSTjDYG40kDxWVlVKvfL0PBggtjfXfPTy4QQWlykim1Xl3WA6
	nICGLL0JaTfjJWcHXElGk3On3XB8o/k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-WXTMg0QmNGeR0iOyZVa33A-1; Thu,
 06 Nov 2025 16:29:25 -0500
X-MC-Unique: WXTMg0QmNGeR0iOyZVa33A-1
X-Mimecast-MFC-AGG-ID: WXTMg0QmNGeR0iOyZVa33A_1762464564
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F62B180045C;
	Thu,  6 Nov 2025 21:29:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 856B319560A7;
	Thu,  6 Nov 2025 21:29:23 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 07/10] treewide: rename has_transparent_hugepage() to arch_has_pmd_leaves()
Date: Thu,  6 Nov 2025 16:28:54 -0500
Message-ID: <9b56da53df2f0da40be68de9a7208d527b144afa.1762464515.git.luizcap@redhat.com>
In-Reply-To: <cover.1762464515.git.luizcap@redhat.com>
References: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Now that the majority of has_transparent_hugepage() callers have been
converted to pgtable_has_pmd_leaves(), rename has_transparent_hugepage()
to arch_has_pmd_leaves() since that's what the helper checks for.

arch_has_pmd_leaves() is supposed to be called only by
init_arch_has_pmd_leaves(), except for two exeptions:

1. shmem: shmem code runs very early during boot so it can't use
   pgtable_has_pmd_leaves()
2. hugepage_init(): just a temporary exception, this function will be
   converted in a future commit

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 arch/mips/include/asm/pgtable.h               |  4 ++--
 arch/mips/mm/tlb-r4k.c                        |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 10 +++++-----
 arch/powerpc/include/asm/book3s/64/radix.h    |  2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 ++--
 arch/s390/include/asm/pgtable.h               |  4 ++--
 arch/x86/include/asm/pgtable.h                |  4 ++--
 include/linux/pgtable.h                       |  4 ++--
 mm/huge_memory.c                              |  2 +-
 mm/memory.c                                   |  2 +-
 mm/shmem.c                                    |  6 +++---
 13 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index ae73ecf4c41a..fb9539002392 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -616,8 +616,8 @@ int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long vaddr,
 /* We don't have hardware dirty/accessed bits, generic_pmdp_establish is fine.*/
 #define pmdp_establish generic_pmdp_establish
 
-#define has_transparent_hugepage has_transparent_hugepage
-extern int has_transparent_hugepage(void);
+#define arch_has_pmd_leaves arch_has_pmd_leaves
+extern int arch_has_pmd_leaves(void);
 
 static inline int pmd_trans_huge(pmd_t pmd)
 {
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 347126dc010d..eb16ddedb40c 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -430,7 +430,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-int has_transparent_hugepage(void)
+int arch_has_pmd_leaves(void)
 {
 	static unsigned int mask = -1;
 
@@ -446,7 +446,7 @@ int has_transparent_hugepage(void)
 	}
 	return mask == PM_HUGE_MASK;
 }
-EXPORT_SYMBOL(has_transparent_hugepage);
+EXPORT_SYMBOL(arch_has_pmd_leaves);
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
 
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 8e5bd9902bed..6744c2287199 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -165,7 +165,7 @@ extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pmd_t *pmdp);
-extern int hash__has_transparent_hugepage(void);
+extern int hash__arch_has_pmd_leaves(void);
 #endif
 
 #endif /* !__ASSEMBLER__ */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 7deb3a66890b..9392aba5e5dc 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -278,7 +278,7 @@ extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pmd_t *pmdp);
-extern int hash__has_transparent_hugepage(void);
+extern int hash__arch_has_pmd_leaves(void);
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif	/* __ASSEMBLER__ */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index aac8ce30cd3b..6ed036b3d3c2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1094,14 +1094,14 @@ static inline void update_mmu_cache_pud(struct vm_area_struct *vma,
 {
 }
 
-extern int hash__has_transparent_hugepage(void);
-static inline int has_transparent_hugepage(void)
+extern int hash__arch_has_pmd_leaves(void);
+static inline int arch_has_pmd_leaves(void)
 {
 	if (radix_enabled())
-		return radix__has_transparent_hugepage();
-	return hash__has_transparent_hugepage();
+		return radix__arch_has_pmd_leaves();
+	return hash__arch_has_pmd_leaves();
 }
-#define has_transparent_hugepage has_transparent_hugepage
+#define arch_has_pmd_leaves arch_has_pmd_leaves
 
 static inline int has_transparent_pud_hugepage(void)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index da954e779744..c884a119cbd9 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -298,7 +298,7 @@ extern pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
 pud_t radix__pudp_huge_get_and_clear(struct mm_struct *mm,
 				     unsigned long addr, pud_t *pudp);
 
-static inline int radix__has_transparent_hugepage(void)
+static inline int radix__arch_has_pmd_leaves(void)
 {
 	/* For radix 2M at PMD level means thp */
 	if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 82d31177630b..1dec64bf0c75 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -366,7 +366,7 @@ pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 	return old_pmd;
 }
 
-int hash__has_transparent_hugepage(void)
+int hash__arch_has_pmd_leaves(void)
 {
 
 	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
@@ -395,7 +395,7 @@ int hash__has_transparent_hugepage(void)
 
 	return 1;
 }
-EXPORT_SYMBOL_GPL(hash__has_transparent_hugepage);
+EXPORT_SYMBOL_GPL(hash__arch_has_pmd_leaves);
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index b7100c6a4054..68fe444ace56 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1881,8 +1881,8 @@ static inline int pmd_trans_huge(pmd_t pmd)
 	return pmd_leaf(pmd);
 }
 
-#define has_transparent_hugepage has_transparent_hugepage
-static inline int has_transparent_hugepage(void)
+#define arch_has_pmd_leaves arch_has_pmd_leaves
+static inline int arch_has_pmd_leaves(void)
 {
 	return cpu_has_edat1() ? 1 : 0;
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e33df3da6980..08d109280e36 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -313,8 +313,8 @@ static inline int pud_trans_huge(pud_t pud)
 }
 #endif
 
-#define has_transparent_hugepage has_transparent_hugepage
-static inline int has_transparent_hugepage(void)
+#define arch_has_pmd_leaves arch_has_pmd_leaves
+static inline int arch_has_pmd_leaves(void)
 {
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e4c5f70b0a01..02a2772ec548 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2026,8 +2026,8 @@ static inline bool pgtable_has_pmd_leaves(void)
 #endif
 #endif
 
-#ifndef has_transparent_hugepage
-#define has_transparent_hugepage() IS_BUILTIN(CONFIG_TRANSPARENT_HUGEPAGE)
+#ifndef arch_has_pmd_leaves
+#define arch_has_pmd_leaves() IS_BUILTIN(CONFIG_TRANSPARENT_HUGEPAGE)
 #endif
 
 #ifndef has_transparent_pud_hugepage
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d1b74950332..9bfa11aa2cbc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -904,7 +904,7 @@ static int __init hugepage_init(void)
 	int err;
 	struct kobject *hugepage_kobj;
 
-	if (!has_transparent_hugepage()) {
+	if (!arch_has_pmd_leaves()) {
 		transparent_hugepage_flags = 1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED;
 		return -EINVAL;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 7b50f3ec9b37..6702c9187114 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -181,7 +181,7 @@ EXPORT_SYMBOL(__arch_has_pmd_leaves);
 
 static int __init init_arch_has_pmd_leaves(void)
 {
-	__arch_has_pmd_leaves = has_transparent_hugepage();
+	__arch_has_pmd_leaves = arch_has_pmd_leaves();
 	return 0;
 }
 early_initcall(init_arch_has_pmd_leaves);
diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28..48312b7727a7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -672,7 +672,7 @@ static int shmem_parse_huge(const char *str)
 	else
 		return -EINVAL;
 
-	if (!has_transparent_hugepage() &&
+	if (!arch_has_pmd_leaves() &&
 	    huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
 		return -EINVAL;
 
@@ -4646,7 +4646,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->huge = result.uint_32;
 		if (ctx->huge != SHMEM_HUGE_NEVER &&
 		    !(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		      has_transparent_hugepage()))
+		      arch_has_pmd_leaves()))
 			goto unsupported_parameter;
 		ctx->seen |= SHMEM_SEEN_HUGE;
 		break;
@@ -5430,7 +5430,7 @@ void __init shmem_init(void)
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (has_transparent_hugepage() && shmem_huge > SHMEM_HUGE_DENY)
+	if (arch_has_pmd_leaves() && shmem_huge > SHMEM_HUGE_DENY)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
 	else
 		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
-- 
2.51.1


