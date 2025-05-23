Return-Path: <linux-kernel+bounces-660819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C9DAC2286
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 14:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C523AE19F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6C235067;
	Fri, 23 May 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OHm3q/t9"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA221C5F18
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002777; cv=none; b=TYJPNWrIev2dAFWIRNrNeuz9/IcteRRIVP6wQPIidNwNCezMx0+q6f62kzvV94tihrpOhqyiVwdJpJiaiAJjUo92RxpmntDwbEPnGuA4mHbHxdoJ0Ba1qCXSR2t3HgyFy0UmlUv2WlZnnR+ew99fpnKhIazlAXrqYRU7tQ8j8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002777; c=relaxed/simple;
	bh=6vCQPQSX0IahjxZG+qKgNteQ63FhQqQp2acQlUledw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q5EQO+OKQVRvlsG2bo8+WxWIWK3NV0St56uj12yhcef1tbzvDKvYvTOaN4ZLR8pfU9e1DJWo1POSQHO0h7w7nV+wOC73MAgKooJqwHcmYEgVGOcRc5mSHx33Nvn83tJP8LEmwmxADjzmiGmD98PBffejeg+16Mu50WU/Lq1zdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OHm3q/t9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gHKdaLjNWznosjFXABDMzjNah37u9q2zyqkMU/Xg4fU=; b=OHm3q/t9Tug5yHzoTpmEZH+HVE
	UHNvQYMvrYY15fc3CDdb9CCCFZsyiBsr09xjcSidURzQJY7cD65YBYOToOTXcJf6/vQA9gk1BAZmI
	wV66LGiDVBynZWBfCYQpZx2Y8zHnlBY3CA/dWzjiaHXCELOT2FVtBqrrfMEzMSh/mWyGdzNcTAmjN
	Jrl/LO4Wx0N6EnYyKK1v1GbIKhiZBMxT2U/8Sz2e96503JSxE3ctChIph+TpzdlhiT8PAaxJHFbDE
	iysc9ZfozExUsVKC5hY9lWq4jSp3GLCipPDjdPMGNh1/VG7zUd+9Q13T528aFSRIfUvcWKMLD5GAM
	dPDgjR+A==;
Received: from 53.red-81-38-30.dynamicip.rima-tde.net ([81.38.30.53] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uIRMt-00CAnI-1A; Fri, 23 May 2025 14:19:19 +0200
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Fri, 23 May 2025 14:19:10 +0200
Subject: [PATCH v2] mm: fix copy_vma() error handling for hugetlb mappings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250523-warning_in_page_counter_cancel-v2-1-b6df1a8cfefd@igalia.com>
X-B4-Tracking: v=1; b=H4sIAL1nMGgC/42NQQ6CMBAAv0J6toauiMST/zCkWepaNsEtaRE1h
 L9beYHHmcPMohJFpqTOxaIizZw4SAbYFcr1KJ403zIrKOFYHuGgXxiFxVsWO6In68JTJorWoTg
 aNDXuZLDuKtc0KkfGSHd+b4Nrm7nnNIX42X6z+dm/07PRRncAhrraYFXChT0OjHsXHqpd1/ULX
 t/IxM0AAAA=
X-Change-ID: 20250523-warning_in_page_counter_cancel-e8c71a6b4c88
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Cc: revest@google.com, kernel-dev@igalia.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
X-Mailer: b4 0.14.2

If, during a mremap() operation for a hugetlb-backed memory mapping,
copy_vma() fails after the source vma has been duplicated and
opened (ie. vma_link() fails), the error is handled by closing the new
vma. This updates the hugetlbfs reservation counter of the reservation
map which at this point is referenced by both the source vma and the new
copy. As a result, once the new vma has been freed and copy_vma()
returns, the reservation counter for the source vma will be incorrect.

This patch addresses this corner case by clearing the hugetlb private
page reservation reference for the new vma and decrementing the
reference before closing the vma, so that vma_close() won't update the
reservation counter. This is also what copy_vma_and_data() does with the
source vma if copy_vma() succeeds, so a helper function has been added
to do the fixup in both functions.

The issue was reported by a private syzbot instance and can be
reproduced using the C reproducer in [1]. It's also a possible duplicate
of public syzbot report [2]. The WARNING report is:

============================================================
page_counter underflow: -1024 nr_pages=1024
WARNING: CPU: 0 PID: 3287 at mm/page_counter.c:61 page_counter_cancel+0xf6/0x120
Modules linked in:
CPU: 0 UID: 0 PID: 3287 Comm: repro__WARNING_ Not tainted 6.15.0-rc7+ #54 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
RIP: 0010:page_counter_cancel+0xf6/0x120
Code: ff 5b 41 5e 41 5f 5d c3 cc cc cc cc e8 f3 4f 8f ff c6 05 64 01 27 06 01 48 c7 c7 60 15 f8 85 48 89 de 4c 89 fa e8 2a a7 51 ff <0f> 0b e9 66 ff ff ff 44 89 f9 80 e1 07 38 c1 7c 9d 4c 81
RSP: 0018:ffffc900025df6a0 EFLAGS: 00010246
RAX: 2edfc409ebb44e00 RBX: fffffffffffffc00 RCX: ffff8880155f0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff81c4a23c R09: 1ffff1100330482a
R10: dffffc0000000000 R11: ffffed100330482b R12: 0000000000000000
R13: ffff888058a882c0 R14: ffff888058a882c0 R15: 0000000000000400
FS:  0000000000000000(0000) GS:ffff88808fc53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b33e0 CR3: 00000000076d6000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 page_counter_uncharge+0x33/0x80
 hugetlb_cgroup_uncharge_counter+0xcb/0x120
 hugetlb_vm_op_close+0x579/0x960
 ? __pfx_hugetlb_vm_op_close+0x10/0x10
 remove_vma+0x88/0x130
 exit_mmap+0x71e/0xe00
 ? __pfx_exit_mmap+0x10/0x10
 ? __mutex_unlock_slowpath+0x22e/0x7f0
 ? __pfx_exit_aio+0x10/0x10
 ? __up_read+0x256/0x690
 ? uprobe_clear_state+0x274/0x290
 ? mm_update_next_owner+0xa9/0x810
 __mmput+0xc9/0x370
 exit_mm+0x203/0x2f0
 ? __pfx_exit_mm+0x10/0x10
 ? taskstats_exit+0x32b/0xa60
 do_exit+0x921/0x2740
 ? do_raw_spin_lock+0x155/0x3b0
 ? __pfx_do_exit+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? _raw_spin_lock_irq+0xc5/0x100
 do_group_exit+0x20c/0x2c0
 get_signal+0x168c/0x1720
 ? __pfx_get_signal+0x10/0x10
 ? schedule+0x165/0x360
 arch_do_signal_or_restart+0x8e/0x7d0
 ? __pfx_arch_do_signal_or_restart+0x10/0x10
 ? __pfx___se_sys_futex+0x10/0x10
 syscall_exit_to_user_mode+0xb8/0x2c0
 do_syscall_64+0x75/0x120
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x422dcd
Code: Unable to access opcode bytes at 0x422da3.
RSP: 002b:00007ff266cdb208 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007ff266cdbcdc RCX: 0000000000422dcd
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000004c7bec
RBP: 00007ff266cdb220 R08: 203a6362696c6720 R09: 203a6362696c6720
R10: 0000200000c00000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000002 R14: 00007ffe1cb5f520 R15: 00007ff266cbb000
 </TASK>
============================================================

Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel__repro.c [1]
Link: https://lore.kernel.org/all/67000a50.050a0220.49194.048d.GAE@google.com/ [2]
---
Changes in v2 (suggested by Lorenzo):
- Move the fix to a separate function and use it on copy_vma() and
  copy_vma_and_data().
- Paste the WARNING output in the commit message and remove the link.
- Update the comment in clear_vma_resv_huge_pages().
- Link to v1: https://lore.kernel.org/r/20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com
---
 include/linux/hugetlb.h |  5 +++++
 mm/hugetlb.c            | 16 +++++++++++++++-
 mm/mremap.c             |  3 +--
 mm/vma.c                |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8f3ac832ee7f3894e1445fe7cfa657f3844a62b2..4861a7e304bbf4bd588e41754af63b23af037a60 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -275,6 +275,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 bool is_hugetlb_entry_migration(pte_t pte);
 bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -468,6 +469,10 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
+{
+}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #ifndef pgd_write
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7ae38bfb9096c4b610bc2e723c6c08d826c68830..757c5187d65ea3f158cd0c3dc1106ce3890c6dff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1250,7 +1250,7 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 /*
  * Reset and decrement one ref on hugepage private reservation.
  * Called with mm->mmap_lock writer semaphore held.
- * This function should be only used by move_vma() and operate on
+ * This function should be only used by mremap and operate on
  * same sized vma. It should never come here with last ref on the
  * reservation.
  */
@@ -7931,3 +7931,17 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
 			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
 }
+
+/*
+ * For hugetlb, mremap() is an odd edge case - while the VMA copying is
+ * performed, we permit both the old and new VMAs to reference the same
+ * reservation.
+ *
+ * We fix this up after the operation succeeds, or if a newly allocated VMA
+ * is closed as a result of a failure to allocate memory.
+ */
+void fixup_hugetlb_reservations(struct vm_area_struct *vma)
+{
+	if (is_vm_hugetlb_page(vma))
+		clear_vma_resv_huge_pages(vma);
+}
diff --git a/mm/mremap.c b/mm/mremap.c
index 7db9da609c84f0a0efe7ee86f7b42b8e0eee6380..0d4948b720e22e6c77123707d5199401aaf5d661 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1188,8 +1188,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}
 
-	if (is_vm_hugetlb_page(vma))
-		clear_vma_resv_huge_pages(vma);
+	fixup_hugetlb_reservations(vma);
 
 	/* Tell pfnmap has moved from this vma */
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
diff --git a/mm/vma.c b/mm/vma.c
index 839d12f02c885d3338d8d233583eb302d82bb80b..a468d4c29c0cd4141657a3b321f5da2871708bdf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1834,6 +1834,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
+	fixup_hugetlb_reservations(new_vma);
 	vma_close(new_vma);
 
 	if (new_vma->vm_file)

---
base-commit: 94305e83eccb3120c921cd3a015cd74731140bac
change-id: 20250523-warning_in_page_counter_cancel-e8c71a6b4c88


