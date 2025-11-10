Return-Path: <linux-kernel+bounces-892950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67836C46318
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FDF1886D61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF83093CD;
	Mon, 10 Nov 2025 11:16:10 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A193081DC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773370; cv=none; b=Mwshr1DHgsFg/GW/izRVopohj143qIPwRVdCifqTqIWvKDbrV7e+ySOfFvOFFwLv1fGFXmFCmGvHaji0DhZeZjTXij5Arc/3As9QCLlHs+j1TVQohTuZIvCNufzdRA0F3jJvTQJjXBNu7XUF26kpprKQT0y4ku9xvufYqU+O09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773370; c=relaxed/simple;
	bh=ceymkfrnA3MJEC9817EDAGtXIqp3D3ouo3FE26VPORM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7Xjau77j59N5AqbYGmUMEOmL3Vm9kETHDcb8HShbF4GzXR5KS4kwYSKCDQFATRv8OXG5MEHICDlbEfs1G7WDLTIpXDlaXicPsTG2Fgrjvkd5SpdDjP6FS0s3opFOHG/Cnw5x5EtRgr6LvALdpmZ/wm7kfF3f5ZLAF72hi+6oCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34361025290so1807413a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773368; x=1763378168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRSXEGDPXpNtVK5+kTNlEj4aQG5TyKfDyS+DDaGalzc=;
        b=LuRpENPAzUBjlkbDl7uM9KaiifYJAZMlIrdMlysfuNqJXaXH2H5qaNE+KhlMUirzut
         4qeLcRxorOj0ha+AglR/jJkTanerYD4MJusMaA4MC3ugrsVRGLM+pFgLW4E/StDNQrH9
         e4k1Hh8RdnEUhU4cGgOinUFHPNbC9xWb/GWb1XWXM4Qr0HyeSP1q3y1wn/lmspPnXF73
         Z2CKrocoj2dtiuH0v4NrTu1Ph9BnEj0spCjSa0MrsIppsVmiPV1htysstMhLGWfaDpQa
         EdW4qOcFnIcA9TeJLLjGJ1WbYkAIwJCw53yHtarC7g2ryPPySeUdsXSzAHhz+CdzLHXJ
         1zvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKvXD449wI6s54UD1k2KkMJYKZ1KQGJi37d03E9i0k/aw9mqds0cxqSru/Z41GHAnzlvSw2crQCVmWfQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDOEEvaK31VQNttwAPMQx4xHK/8j9HJe74Obz8KwdTsCD6WMM
	c/LTXwCLfBeVVCrU9SEikV2CP2eOId8AWnYxzd9L2+XzUenIatGv/Pho
X-Gm-Gg: ASbGnctzduXqlpfrlG+3DO08ioVLHzjInRy4s0E6O1B/85oD9CusIlk5hPuKDu3tkHU
	hLBdzMuvyuRITQd82E/VJloPXVtLvOWgs2N9Sa15mMIfulNrxBH0CC+ah+ulDoEagZKDVXwV4+t
	CttS5Grk034up/xD8bznr1D5GyzuPYnQZAiOWB1p3eVvPyYb/sHl7/9/EPceupHh3sZUNke8zCy
	hnEubHKnV1ZqSQEWMaVcTJ39LlxHLRj7c9xA1wGx+BKTdb9s1lL1Eiiypo0mYK0f7A7QdAdOUde
	Hx/Rp+z8Ez/PrrEPYXi9RB7gKjbOJIHVEUFlhTV+NFBwsq/dqWbmLXJ+KH53w9tGQ+AzPRHbUo6
	D0vB5MvAS9ZA8H4Zj5y8bxBh/+xQkyDIRTamVdY+si5Dn61DtCAVyNGLj+atD3R0JIh0OM5BBQ9
	Kp3ZK56bQ=
X-Google-Smtp-Source: AGHT+IFmx5F0C1FFfC1T3kTAEofW5SYHF07alyTgfqPESgG9ejsnGcr8FXW/IACqi7z7O6oK12Ycjg==
X-Received: by 2002:a17:90b:1f8e:b0:33e:2934:6e11 with SMTP id 98e67ed59e1d1-3436cb898dcmr10302982a91.11.1762773367674;
        Mon, 10 Nov 2025 03:16:07 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([2403:2c80:17::10:4006])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c801d1sm8989478a12.7.2025.11.10.03.16.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Nov 2025 03:16:06 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: syzbot+3f5f9a0d292454409ca6@syzkaller.appspotmail.com,
	syzbot+ci5a676d3d210999ee@syzkaller.appspotmail.com,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	syzkaller-bugs@googlegroups.com,
	syzbot@lists.linux.dev,
	syzbot@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 1/1] mm/hugetlb: fix possible deadlocks in hugetlb VMA unmap paths
Date: Mon, 10 Nov 2025 19:15:53 +0800
Message-ID: <20251110111553.88384-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The hugetlb VMA unmap path contains several potential deadlocks, as
reported by syzbot. These deadlocks occur in __hugetlb_zap_begin(),
move_hugetlb_page_tables(), and the retry path of
hugetlb_unmap_file_folio() (affecting remove_inode_hugepages() and
unmap_vmas()), where vma_lock is acquired before i_mmap_lock. This lock
ordering conflicts with other paths like hugetlb_fault(), which establish
the correct dependency as i_mmap_lock -> vma_lock.

Possible unsafe locking scenario:

CPU0                                 CPU1
----                                 ----
lock(&vma_lock->rw_sema);
                                     lock(&i_mmap_lock);
                                     lock(&vma_lock->rw_sema);
lock(&i_mmap_lock);

Resolve the circular dependencies reported by syzbot across multiple call
chains by reordering the locks in all conflicting paths to consistently
follow the established i_mmap_lock -> vma_lock order.

Reported-by: syzbot+3f5f9a0d292454409ca6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/69113a97.a70a0220.22f260.00ca.GAE@google.com/
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
V1 -> V2:
  - Update changelog
  - Resolve three related deadlock scenarios reported by syzbot
    https://lore.kernel.org/linux-mm/6911ad38.a70a0220.22f260.00dc.GAE@google.com/
  - https://lore.kernel.org/linux-mm/20251110051421.29436-1-lance.yang@linux.dev/

 fs/hugetlbfs/inode.c | 2 +-
 mm/hugetlb.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3919fca56553..d1b0b5346728 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -447,8 +447,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		 * a reference.  We must 'open code' vma locking as we do
 		 * not know if vma_lock is still attached to vma.
 		 */
-		down_write(&vma_lock->rw_sema);
 		i_mmap_lock_write(mapping);
+		down_write(&vma_lock->rw_sema);
 
 		vma = vma_lock->vma;
 		if (!vma) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b1f47b87ae65..f0212d2579f6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5110,8 +5110,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	/* Prevent race with file truncation */
-	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
+	hugetlb_vma_lock_write(vma);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		src_pte = hugetlb_walk(vma, old_addr, sz);
 		if (!src_pte) {
@@ -5327,9 +5327,9 @@ void __hugetlb_zap_begin(struct vm_area_struct *vma,
 		return;
 
 	adjust_range_if_pmd_sharing_possible(vma, start, end);
-	hugetlb_vma_lock_write(vma);
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_lock_write(vma);
 }
 
 void __hugetlb_zap_end(struct vm_area_struct *vma,
-- 
2.49.0


