Return-Path: <linux-kernel+bounces-799540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1252B42D57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5AF4E28EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231402E36FD;
	Wed,  3 Sep 2025 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mv7aqWTo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4452D24A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941887; cv=none; b=dXxrsm/amfgVRe47KeGYOztEpP5Yud16VYUg7wGIpHc4VAa54YxtMLBNea3XUzDKv1zrJaivGIj7HgylrIh4Jloxfjo/vJIMUpGDFpOQoVpkZrnXdYekuyQZOgZHyZVf1ayqr2+eesW941+RcXHDqKp7zYV3AKqeSllXniIw4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941887; c=relaxed/simple;
	bh=LAX0vFAiGT9Ei9QR0meGt66wAs60XrYOFVTgjsQ0ReE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q70lIX1BbAHbrrdtQA5FxN/NXjZeomoUlKH/ZtS/rTskjJLbVloLtZtHhuW1ipJ530POGpg98U0bpH9eEX2a4TLgbaAMc7+269te7+RaXnLkfC+Qb9Xolb3GQmjW7JDr2VDKZ/k3LI/DrhN50uCLt1VieaKvHeQ0KUYT6BSkKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mv7aqWTo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329e55e686dso438485a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756941885; x=1757546685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgPTVCi/fpzUuEvg9xD+jIRme2pJE3B6Yq7rj7B3nZY=;
        b=Mv7aqWToDvpJYeX+mzpkrC6rZi2Vyp/zRoJSzCSNbGN8KqPfiYn1N+ViiCs6k64Im7
         BA+8036Oz+hZJMI7tG9GDYOLPk6AMb7oQ7vQKPJOnmtaZObrWL/yybo00ORtOL41l7vy
         omxXGs6rU9Coozm4zgLF7RNhbx0Z5100ClcRhkmTlZq2a0e8+K8I0Ig/tGUa8nN6WRkU
         PF91/W4WkJ7VjgxGOKrNzf6a7D5HURI3USmaQ7nr8xdCe3TBJ+pbD9gP+zU3PCAefuoB
         zwSA2UAUrDD2GQTiCUdtnBwatOWBND9S42320liNUaY7zbX/NLuhtrIctt5IZxa9M+Nj
         ssOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941885; x=1757546685;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgPTVCi/fpzUuEvg9xD+jIRme2pJE3B6Yq7rj7B3nZY=;
        b=Bh5g/lKBESP4o2szLej5/NjsqBKlzyO9Las6sgW/9GCtIfLNGcUBN24hPOiiEFY9TQ
         kIr8skhj3U+/EBB2qY4JCrNATnJciUPQry2Iy+vLweoVlHXBs1ezT8GnzCMWqNstcdOu
         GxiJ/aQAEX5mP6MzxeAr92n+Ld/5FvUODUjxCryTxjMLeJSz2g2hnsydvHwjmnwYruP0
         420sINcjAzw+XSkuaEhoNU8CauxXasb180X7ZwiOV2gfMxbKi5Fny3RFeG0QWoR+F6d4
         nfK/rrXh9UwaqBjNu1GdO3VaG605xCiWTsneNehkM6UhOJRAjLDu6zCg60ioaTelWYZR
         rmCg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ITp0mqaYUvd1YRYs3VJMXsBchOdVQSe3M4arl7LNdpvRpzXDqkL8AHAaf9dc93MafDcS2vXqFEVA8nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDzyosu3iTNWjneAImRuwRAxHU14pqFMOTXX2ZjdbLt2cacHK
	5r0d5K5IRc2vRIhzsSLN3IRDKfOjR0vKyA2MXgFR94VRtz8zw8AKi5m5O+sqbBP9/zexKjxfsmh
	xwN3lRJrlmyUWl1uAfP2vqZv8cw==
X-Google-Smtp-Source: AGHT+IE847aFywtv64trKEqJQS4xk/rRzoYt8J98LejVPNK+qtP1XoLxGjxJLrG9gDKIj8QvnnA8vG+EvTtsf7QD3Q==
X-Received: from pjbst8.prod.google.com ([2002:a17:90b:1fc8:b0:312:ea08:fa64])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c105:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-32b95061914mr549097a91.9.1756941885037;
 Wed, 03 Sep 2025 16:24:45 -0700 (PDT)
Date: Wed,  3 Sep 2025 16:24:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903232437.1454293-1-kaleshsingh@google.com>
Subject: [PATCH] mm: centralize and fix max map count limit checking
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The check against the max map count (sysctl_max_map_count) was
open-coded in several places. This led to inconsistent enforcement
and subtle bugs where the limit could be exceeded.

For example, some paths would check map_count > sysctl_max_map_count
before allocating a new VMA and incrementing the count, allowing the
process to reach sysctl_max_map_count + 1:

    int do_brk_flags(...)
    {
        if (mm->map_count > sysctl_max_map_count)
            return -ENOMEM;

        /* We can get here with mm->map_count == sysctl_max_map_count */

        vma = vm_area_alloc(mm);
        ...
        mm->map_count++   /* We've now exceeded the threshold. */
    }

To fix this and unify the logic, introduce a new function,
exceeds_max_map_count(), to consolidate the check. All open-coded
checks are replaced with calls to this new function, ensuring the
limit is applied uniformly and correctly.

To improve encapsulation, sysctl_max_map_count is now static to
mm/mmap.c. The new helper also adds a rate-limited warning to make
debugging applications that exhaust their VMA limit easier.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/linux/mm.h | 11 ++++++++++-
 mm/mmap.c          | 15 ++++++++++++++-
 mm/mremap.c        |  7 ++++---
 mm/nommu.c         |  2 +-
 mm/util.c          |  1 -
 mm/vma.c           |  6 +++---
 6 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..d4e64e6a9814 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct page *page)
 #define MAPCOUNT_ELF_CORE_MARGIN	(5)
 #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
 
-extern int sysctl_max_map_count;
+/**
+ * exceeds_max_map_count - check if a VMA operation would exceed max_map_count
+ * @mm: The memory descriptor for the process.
+ * @new_vmas: The number of new VMAs the operation will create.
+ *
+ * Returns true if the operation would cause the number of VMAs to exceed
+ * the sysctl_max_map_count limit, false otherwise. A rate-limited warning
+ * is logged if the limit is exceeded.
+ */
+extern bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas);
 
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;
diff --git a/mm/mmap.c b/mm/mmap.c
index 7306253cc3b5..693a0105e6a5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (mm->map_count > sysctl_max_map_count)
+	if (exceeds_max_map_count(mm, 0))
 		return -ENOMEM;
 
 	/*
@@ -1504,6 +1504,19 @@ struct vm_area_struct *_install_special_mapping(
 int sysctl_legacy_va_layout;
 #endif
 
+static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
+
+bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas)
+{
+	if (unlikely(mm->map_count + new_vmas > sysctl_max_map_count)) {
+		pr_warn_ratelimited("%s (%d): Map count limit %u exceeded\n",
+				    current->comm, current->pid,
+				    sysctl_max_map_count);
+		return true;
+	}
+	return false;
+}
+
 static const struct ctl_table mmap_table[] = {
 		{
 				.procname       = "max_map_count",
diff --git a/mm/mremap.c b/mm/mremap.c
index e618a706aff5..793fad58302c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	 * We'd prefer to avoid failure later on in do_munmap:
 	 * which may split one vma into three before unmapping.
 	 */
-	if (current->mm->map_count >= sysctl_max_map_count - 3)
+	if (exceeds_max_map_count(current->mm, 4))
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
@@ -1811,9 +1811,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * split in 3 before unmapping it.
 	 * That means 2 more maps (1 for each) to the ones we already hold.
 	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 * the threshold. In other words, is the current map count + 6 at or
+	 * below the threshold? Otherwise return -ENOMEM here to be more safe.
 	 */
-	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+	if (exceeds_max_map_count(current->mm, 6))
 		return -ENOMEM;
 
 	return 0;
diff --git a/mm/nommu.c b/mm/nommu.c
index 8b819fafd57b..0533e1e3b266 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1316,7 +1316,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	mm = vma->vm_mm;
-	if (mm->map_count >= sysctl_max_map_count)
+	if (exceeds_max_map_count(mm, 1))
 		return -ENOMEM;
 
 	region = kmem_cache_alloc(vm_region_jar, GFP_KERNEL);
diff --git a/mm/util.c b/mm/util.c
index f814e6a59ab1..b6e83922cafe 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -751,7 +751,6 @@ EXPORT_SYMBOL(folio_mc_copy);
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;
-int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 unsigned long sysctl_user_reserve_kbytes __read_mostly = 1UL << 17; /* 128MB */
 unsigned long sysctl_admin_reserve_kbytes __read_mostly = 1UL << 13; /* 8MB */
 
diff --git a/mm/vma.c b/mm/vma.c
index 3b12c7579831..f804c8ac8fbb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -592,7 +592,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
-	if (vma->vm_mm->map_count >= sysctl_max_map_count)
+	if (exceeds_max_map_count(vma->vm_mm, 1))
 		return -ENOMEM;
 
 	return __split_vma(vmi, vma, addr, new_below);
@@ -1345,7 +1345,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (vms->end < vms->vma->vm_end &&
-		    vms->vma->vm_mm->map_count >= sysctl_max_map_count) {
+		    exceeds_max_map_count(vms->vma->vm_mm, 1)) {
 			error = -ENOMEM;
 			goto map_count_exceeded;
 		}
@@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (mm->map_count > sysctl_max_map_count)
+	if (exceeds_max_map_count(mm, 1))
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
-- 
2.51.0.338.gd7d06c2dae-goog


