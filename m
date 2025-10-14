Return-Path: <linux-kernel+bounces-851819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E313EBD75BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAC03E4AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B246212B3D;
	Tue, 14 Oct 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+n29hv4"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2291ACEDA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418385; cv=none; b=GjXX4/Bkl/tcf/vhkO6sGkC91z0LSMOZ8fdSlcPnkFwICzgF9mJKlQcjiQxe9cpN4i+K36RZOCCX3x+plD+KHv0XY8HOoHbEhlLKdPHcfiHsV0cJ4uZybT92dtkKqp28hH62rP59e9kLizgur3sHtJ6xXiqUS0MaBiXtoibx7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418385; c=relaxed/simple;
	bh=7xxe14zUjQg487rK+bWWPlv72VsWBxV5PQyV45VTGa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukK8stgwf7yFE0pqKR0t2FJs5okLZ+T7in3IEi4ypPDwFr+Mo9LYA4Lol8jklzKHiSyiw57dRDxubpVE3ZcUz/u+mZWsdO9yFmYkkDNXbIdKPhEOnO75IxEODtu4/o40Vhyh29pxMhEROXyhRp2bBlg1pM/G8XR+Gaaxzx3I6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+n29hv4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso3112468a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760418382; x=1761023182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9BK+9ajYmleGpxEkSE4YYmD6WR6oYv/sY36uPRqwkM=;
        b=Z+n29hv4WqKWukEIOSlUIHzu+iB8aO2angccORiSWBwrs3cV1COIabWdovwoks3JGU
         DymwdMNfmaRZpPb6DVnV2XDiIQG0ExtyT44gbEiYCbtSp5ygPLW8SKn/iC1LYHF26Zl7
         Qcf+KsC+saUCdPC4apvnh8sLHSJRBdwgFu4K6G0ReD+IzIOHfFG9KLaYtcZHgcQy1rJt
         jHdEKD6ZCEi6S24dAW9UCcBMoLpOSpac+vmnx9nLg63bRpnxpmbqfJCSa9vUNEyqk/FQ
         OhSfAgvAPCl8Oq8tHbcm0wd4fCkBXciRoZMlfLXixZiqrdHjhJ8ofS0pw+DC7z/i2NtL
         k4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418382; x=1761023182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9BK+9ajYmleGpxEkSE4YYmD6WR6oYv/sY36uPRqwkM=;
        b=tj0tDovpxamY2IuOSASl6EeZpT2R3fUcslYlMaPNNeC1TbEB8z+I3f9taqzWCsgtlO
         i3KquPo8ccJ+dLMGxudLZmPhseBAlKjifHVTVMgv2GLsAjAAgGRsqvKUUcA4leXOs6JH
         0Tk4UOne5fRlZccG2uFGsBX6vQWOPtO0InmSRm6D3v7y06/orbZazHJn30KLgz3u86f3
         mI1QaP0Fxpw2/EPtfrAyl6pa+MgUmkBwmgKZVfwzGyDHSvRDC18wR6lNpaVxghq/5UfS
         0+bWSErDhAPl56PK5z73J5vor5AzdcL99/GSvzm6FSfpohLCyd1hu0y6AUkhUxrOqpZn
         mSTg==
X-Forwarded-Encrypted: i=1; AJvYcCV4wsnnZDIzPIiHbwfVvJ27KgXLX9QAIaVzG6jLGYfcUDedANXLHTen0XXcwLeH2rKHIjgK/iNCXRCve/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFr9EyaIIWi2Ob2o5Bbm4jxbpPlPfoBN8WOGcNOs6wzefi+UZ
	yqalb+67e39drfZF1JxahKW6eqoMzbip82n9dsCLQlVivfq2mwxX9zY6
X-Gm-Gg: ASbGncsllPjJnc8vizR4kf24M5llp9pT18ao1VlLq0eLixUtXMXuuL9HQJhte3vtyFp
	S5hkdk/nnbU88QNrtM1eV3plUlcfL5+kSvr7kE0MN/xfl0q58ZUkWKeVdMhTOYpQn6km8bidXs2
	LvEuzEe7UHzluK9uk3uAlELhi3ApAOASQ3apeMaOXTYRoMYAGDjC0d2ejMvp74AGRoRAixlSlOk
	PEYv1/uRvOg8J0BWP68MPxDDJm/njdYNI9xCFFo5Lmpca1h1IYJR/voNK99dMMKu1kCdb9k7otn
	frKm64L5MXtlYPGN7iRtj4o5WPm6tOE1d32sNkGRGkqH8N41MoOMct/ez1fUH9UQCDVPSjILTLP
	JnERNaMaiGnz+Liw3eT2p5FAOfsNOa63A3Ui2npUSLBEW4SuiIL1/yf1sWpYRRzEznP63KrGt5n
	lUhRs12CVVz6iVsg==
X-Google-Smtp-Source: AGHT+IEIVs7lvSQ3NXzZb0jGdos4Hk3jrN73ntxBRefqVaXGal6SIJg7cZ/x00Q/QXcoJ9SkB9/Wgw==
X-Received: by 2002:a17:902:ce88:b0:26a:8171:daf7 with SMTP id d9443c01a7336-2902723f086mr387687875ad.16.1760418382248;
        Mon, 13 Oct 2025 22:06:22 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:389d:c391:4ad4:fa2d:b790])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9e0sm150546215ad.120.2025.10.13.22.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:06:21 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org,
	broonie@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v6] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
Date: Tue, 14 Oct 2025 10:36:09 +0530
Message-Id: <20251014050609.349461-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hugetlb_vmdelete_list() processes VMAs during truncate operations,
it may encounter VMAs where huge_pmd_unshare() is called without the
required shareable lock. This triggers an assertion failure in
hugetlb_vma_assert_locked().

The previous fix in commit dd83609b8898 ("hugetlbfs: skip VMAs without
shareable locks in hugetlb_vmdelete_list") skipped entire VMAs without
shareable locks to avoid the assertion. However, this prevented pages
from being unmapped and freed, causing a regression in fallocate(PUNCH_HOLE)
operations where pages were not freed immediately, as reported by Mark Brown.

A subsequent fix in commit 06e8ca1b3dca ("hugetlbfs: check for shareable
lock before calling huge_pmd_unshare()") addressed this by checking
__vma_shareable_lock() in the caller before calling huge_pmd_unshare().
However, a cleaner approach is to move the lock assertions in
huge_pmd_unshare() itself to after the early return checks. The assertions
are only needed when actual PMD unsharing work will be performed. If the
function returns early because sz != PMD_SIZE or the PMD is not shared,
no locks are required.

This patch removes the check added in commit 06e8ca1b3dca ("hugetlbfs:
check for shareable lock before calling huge_pmd_unshare()") and instead
moves the assertions inside huge_pmd_unshare(), keeping all the logic
within the function itself.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Oscar Salvador <osalvador@suse.de>
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
Link: https://lore.kernel.org/linux-mm/20251008052759.469714-1-kartikey406@gmail.com/ [v4]
Link: https://lore.kernel.org/linux-mm/CADhLXY72yEVDjXWfxBUXfXhNfb8MWqwJmcb1daEHmDeFW+DRGw@mail.gmail.com/ [v5]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v6:
- Remove __vma_shareable_lock() check from __unmap_hugepage_range()
  that was added in v4 (commit 06e8ca1b3dca)
- Move lock assertions after early returns in huge_pmd_unshare()
- Complete implementation of David's cleaner approach

Changes in v5:
- Incomplete: only moved assertions, forgot to remove v4 check

Changes in v4:
- Check __vma_shareable_lock() in __unmap_hugepage_range() before calling
  huge_pmd_unshare() per Oscar's suggestion

Changes in v3:
- Add ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing

Changes in v2:
- Skip entire VMAs without shareable locks (caused PUNCH_HOLE regression)

Changes in v1:
- Initial fix attempt
---
 mm/hugetlb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 85b2dac79d25..0455119716ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5885,7 +5885,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (__vma_shareable_lock(vma) && huge_pmd_unshare(mm, vma, address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, address, ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
@@ -7614,13 +7614,12 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	pud_t *pud = pud_offset(p4d, addr);
 
-	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
-	hugetlb_vma_assert_locked(vma);
 	if (sz != PMD_SIZE)
 		return 0;
 	if (!ptdesc_pmd_is_shared(virt_to_ptdesc(ptep)))
 		return 0;
-
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	hugetlb_vma_assert_locked(vma);
 	pud_clear(pud);
 	/*
 	 * Once our caller drops the rmap lock, some other process might be
-- 
2.34.1


