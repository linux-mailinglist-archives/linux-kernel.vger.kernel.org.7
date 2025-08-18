Return-Path: <linux-kernel+bounces-774197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A68B2AFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0013561083
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1932D24BC;
	Mon, 18 Aug 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwNpqqLy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66222D248E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539646; cv=none; b=A9umkOODNyVENXX4j/hro5ht0CsSfLgYS/EjazlyE+x2KJlyuIUgmY4CWcxsTGCfj93M4P8YaUjBAhLNzxoLtzvjAKTyRrIBKt4mYiO5A9FhibVOXKTWJXp4Mwi79FvpTenC6cFsZwexG7PaC2dS/7JWCnvBSl4fTrrK1Mldt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539646; c=relaxed/simple;
	bh=wtShDuLv1/AdrpolkIVF+4p+W/dYUrt/G8rSkbffguw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eR7kaPxTS5Go6SKzPPieEF6JV3LGuJt/42XKffcO+6UAiplqsq/OYdeSk6cnuDGI1Z3hB7EOajwopwtVIeWljt5n3KG0mCHnOSzBBcQ+1DsH7EyotEokfjyn4u0cgJiN7vFBS0izxtX5r6q35tEXMBQ2GWxgw/kU2KZRVCg0iKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwNpqqLy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755539643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=89YYgFY/atKO7NXyA1yiC1oohqeWnpMbKEyE+yEL/fg=;
	b=PwNpqqLyNQZ6DzmH0IxFFzbG2+uVuZleW95U7lxNsHp7ne+nGxWt+DMWzLnjuhArLSyHhg
	8zSQb0gvdnWaXcI56CC4vn2Ekpigdk+QKjw32tlPQcJl70Xtb4K8OFo8UjIdDb3hSjhfUk
	9eNkAohNj87+h2PHKc3X25DmUNoaBJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-YNKb9DT6PkWh_PZvXEY1MQ-1; Mon, 18 Aug 2025 13:54:02 -0400
X-MC-Unique: YNKb9DT6PkWh_PZvXEY1MQ-1
X-Mimecast-MFC-AGG-ID: YNKb9DT6PkWh_PZvXEY1MQ_1755539641
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so26972555e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755539641; x=1756144441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89YYgFY/atKO7NXyA1yiC1oohqeWnpMbKEyE+yEL/fg=;
        b=Lst2eqf6ZRwwn1b5G6BIlYrdzDMUXJJTOcrnuqLgAz9QfDWXIu9NEnXgC/mfeBxKau
         F+SHZZOECMTgRLy6wdwLu3U/Nbdh4gEsSkizrEKxw8ojg6Fo9S0bwavpgqLgYC4qwMdX
         V6m47wxD0o1xugLWAw1IdrO7s0aUfJk2iDPqovHH9BW7TGiZUaDUDJrV0ByXHc7VjPmR
         ktnkMzUR3qMaqag5VxmV3ChJTj2wexdlkLqtyoCiZR8aIsptm6DMwLYOR40DkpM1Am1r
         wtCfmDJoZHfg+qlLBrhDpZKrNHvPziSzQ5AjyCtUv7OxlunPZ/ZEgI1nlO1nImspCnZX
         dZ0A==
X-Gm-Message-State: AOJu0Yy7S3A1d6QoRLMiZPUkSDsbcKJ47inyHKOBs4nFgqlc21CcdXOJ
	4PceSRUVXkSe6ZfwQhXYoNIh5nqto8Du52WRel0+Sg3ZxjzAxp2/C/A7TUkPbCm1Cr4Fp1J61aK
	Sz/oN6/ovvPNXBk3lBaqIil5y1oRl6Bi0WFVbykci8esqn0L+WglkaTPyETgBTIgbmidUz/Schu
	W2Fnkp83Y2AnHOr/HdxD0DxNlukOVS1bytolqr+QSwbsvhnXOE
X-Gm-Gg: ASbGncvadWvInq26C3bNHdJbVo/33jzblsBCbIff2MTVB/4vcr8EGSQOJ6fvfZIVYMg
	ZJZIeC4wJ+6kIKRBHArMgXbZycn7easFuqv+n5Lj+eEMzneTkE1Xe12VkQilYS7FSTIVSVL4oz1
	0U6nvqJZh3dPSnTK5kfHYLcACoypsLwCuRHyT4ofXwbLot5zBdh/OA3vTR88g/3SKZSbONB+iYI
	W2IkqMw2juz/aPosptEjVCG0rsVsYEuQtFJ0mVccpI/uLWn82UQHSVxT1+u7CQzQQKI1UxqlLFU
	Wuga0zWJOdhdgr79BFgqhaUTj/jfg6+bY26H5yQDvPAXktOl6tjXtOpzG5SKTNXRsly45eKbZRX
	OyZp6xK1d+8wYhpy+SIE+9A==
X-Received: by 2002:a05:6000:1448:b0:3b7:8342:dc58 with SMTP id ffacd0b85a97d-3c089a308e2mr135487f8f.16.1755539640953;
        Mon, 18 Aug 2025 10:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZFhZbPqR5i6NEhC4IJI8iYAbzcC+PQVoWnhvOMkVOWh9OMDuG2EqkAM9pwaYapKx+zoqh+w==
X-Received: by 2002:a05:6000:1448:b0:3b7:8342:dc58 with SMTP id ffacd0b85a97d-3c089a308e2mr135463f8f.16.1755539640439;
        Mon, 18 Aug 2025 10:54:00 -0700 (PDT)
Received: from localhost (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789106sm386191f8f.51.2025.08.18.10.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 10:53:59 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com,
	stable@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH v1] mm/mremap: fix WARN with uffd that has remap events disabled
Date: Mon, 18 Aug 2025 19:53:58 +0200
Message-ID: <20250818175358.1184757-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registering userfaultd on a VMA that spans at least one PMD and then
mremap()'ing that VMA can trigger a WARN when recovering from a failed
page table move due to a page table allocation error.

The code ends up doing the right thing (recurse, avoiding moving actual
page tables), but triggering that WARN is unpleasant:

WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_normal_pmd mm/mremap.c:357 [inline]
WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_pgt_entry mm/mremap.c:595 [inline]
WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_page_tables+0x3832/0x44a0 mm/mremap.c:852
Modules linked in:
CPU: 2 UID: 0 PID: 6133 Comm: syz.0.19 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:move_normal_pmd mm/mremap.c:357 [inline]
RIP: 0010:move_pgt_entry mm/mremap.c:595 [inline]
RIP: 0010:move_page_tables+0x3832/0x44a0 mm/mremap.c:852
Code: ...
RSP: 0018:ffffc900037a76d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000032930007 RCX: ffffffff820c6645
RDX: ffff88802e56a440 RSI: ffffffff820c7201 RDI: 0000000000000007
RBP: ffff888037728fc0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000032930007 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc900037a79a8 R14: 0000000000000001 R15: dffffc0000000000
FS:  000055556316a500(0000) GS:ffff8880d68bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30863fff CR3: 0000000050171000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 copy_vma_and_data+0x468/0x790 mm/mremap.c:1215
 move_vma+0x548/0x1780 mm/mremap.c:1282
 mremap_to+0x1b7/0x450 mm/mremap.c:1406
 do_mremap+0xfad/0x1f80 mm/mremap.c:1921
 __do_sys_mremap+0x119/0x170 mm/mremap.c:1977
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f00d0b8ebe9
Code: ...
RSP: 002b:00007ffe5ea5ee98 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007f00d0db5fa0 RCX: 00007f00d0b8ebe9
RDX: 0000000000400000 RSI: 0000000000c00000 RDI: 0000200000000000
RBP: 00007ffe5ea5eef0 R08: 0000200000c00000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f00d0db5fa0 R14: 00007f00d0db5fa0 R15: 0000000000000005
 </TASK>

The underlying issue is that we recurse during the original page table
move, but not during the recovery move.

Fix it by checking for both VMAs and performing the check before the
pmd_none() sanity check.

Add a new helper where we perform+document that check for the PMD and
PUD level.

Thanks to Harry for bisecting.

Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/689bb893.050a0220.7f033.013a.GAE@google.com
Fixes: 0cef0bb836e ("mm: clear uffd-wp PTE/PMD state on mremap()")
Cc: <stable@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Once this is queued, I'll send a patch to perform a
userfaultfd_wp() check, to skip any uffd VMAs that don't mess with uffd-wp.

---
 mm/mremap.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 9afa8cd524f5f..87849af6682a7 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -323,6 +323,25 @@ static inline bool arch_supports_page_table_move(void)
 }
 #endif
 
+static inline bool uffd_supports_page_table_move(struct pagetable_move_control *pmc)
+{
+	/*
+	 * If we are moving a VMA that has uffd-wp registered but with
+	 * remap events disabled (new VMA will not be registered with uffd), we
+	 * need to ensure that the uffd-wp state is cleared from all pgtables.
+	 * This means recursing into lower page tables in move_page_tables().
+	 *
+	 * We might get called with VMAs reversed when recovering from a
+	 * failed page table move. In that case, the
+	 * "old"-but-actually-"originally new" VMA during recovery will not have
+	 * a uffd context. Recursing into lower page tables during the original
+	 * move but not during the recovery move will cause trouble, because we
+	 * run into already-existing page tables. So check both VMAs.
+	 */
+	return !vma_has_uffd_without_event_remap(pmc->old) &&
+	       !vma_has_uffd_without_event_remap(pmc->new);
+}
+
 #ifdef CONFIG_HAVE_MOVE_PMD
 static bool move_normal_pmd(struct pagetable_move_control *pmc,
 			pmd_t *old_pmd, pmd_t *new_pmd)
@@ -335,6 +354,8 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
+	if (!uffd_supports_page_table_move(pmc))
+		return false;
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
 	 * should have released it.
@@ -361,15 +382,6 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
 		return false;
 
-	/* If this pmd belongs to a uffd vma with remap events disabled, we need
-	 * to ensure that the uffd-wp state is cleared from all pgtables. This
-	 * means recursing into lower page tables in move_page_tables(), and we
-	 * can reuse the existing code if we simply treat the entry as "not
-	 * moved".
-	 */
-	if (vma_has_uffd_without_event_remap(vma))
-		return false;
-
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
@@ -418,6 +430,8 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
+	if (!uffd_supports_page_table_move(pmc))
+		return false;
 	/*
 	 * The destination pud shouldn't be established, free_pgtables()
 	 * should have released it.
@@ -425,15 +439,6 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 	if (WARN_ON_ONCE(!pud_none(*new_pud)))
 		return false;
 
-	/* If this pud belongs to a uffd vma with remap events disabled, we need
-	 * to ensure that the uffd-wp state is cleared from all pgtables. This
-	 * means recursing into lower page tables in move_page_tables(), and we
-	 * can reuse the existing code if we simply treat the entry as "not
-	 * moved".
-	 */
-	if (vma_has_uffd_without_event_remap(vma))
-		return false;
-
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.

base-commit: dfc0f6373094dd88e1eaf76c44f2ff01b65db851
-- 
2.50.1


