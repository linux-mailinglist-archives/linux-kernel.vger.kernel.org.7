Return-Path: <linux-kernel+bounces-845055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F9BC3619
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 07:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B9F189D16D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 05:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39422D8390;
	Wed,  8 Oct 2025 05:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmGEIvPF"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C228C871
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759901290; cv=none; b=JHN2JpYINhLvMcW2oDCfSJWTmG+dszMPX8yKoboxG9z+GQLN3+3hSbnjeeNfWL6WxOQquOTlFQU7KGlyqfA9trW7hx9eZQWDP/pVE4xv7bmmq2vCXvmZWBpreq1jIrvGXVfgQhlUzFHfcTKY4eToOUxSEQQIlzotq8lvkGD2xfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759901290; c=relaxed/simple;
	bh=AC95x54JN1lRJt8eqwpof77duFRSx5Dj0tjKcKFDpSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcbingbZqDW9kBn2kUByqSFVFQhX1LCipW/mTDmzI6rQPYlXQ0+NhcsEvNP+tI8YPiTHJ3P4R/tOgDsSWZ7o/8/rgJMCqVSVq5bEPgfmhdkxCwtMelK3Cxcl8BZca/onLQmVaxqaH33PKBB5EbYTTsn7RjKyiFHsdqWAmwLOm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmGEIvPF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b551350adfaso6257277a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 22:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759901288; x=1760506088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMqvRrCCbf00Rf1hkLneqb6IWYGGdZT3hFbhVoMk1mQ=;
        b=bmGEIvPFRttG1TKlyDQhafPE4RZiPgGaQR8yjVBWPsrcWqCFzIPlFRG5c+FliHKsUS
         QujdgvaRVHxnJ0goWQKAX0AHa1n8hg24D8Fg1sAN4AItLD/8frX96hVh2Oe4UAIr2qYh
         6nLBfYO5lEQB7rNmdnsLMXDXvzeKIlahtcUzEE/2djvZUImBtSCeXAPr6soLyzUYBs7J
         QSjun2gtFN4rZL0JlQUkQhsYkdJbBUsuSrLWKHPVvsDKYVdvilrc0hV/BF5rC0O/khqU
         WYV+fVFq0KLTbKDlqHbk3gLGzcy5CTJBJeUdqSKjk2AaWT2u2WJyeMqSvp6xMjmqr14N
         7Y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759901288; x=1760506088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMqvRrCCbf00Rf1hkLneqb6IWYGGdZT3hFbhVoMk1mQ=;
        b=JcJSwqQ0ZFH6dcRVgOfadYQ2YtDseVC6RzcZY2GOJPdeyMVjHjeueudasXiXD89JDC
         WF41AwBuPMtvYlDlYDLi4b0DZY8o5t5KrQRVACHedrXAfKLazoJmlCtPQ/VFnf26mLwc
         MUdshYj8Kkh6npme7rUJkVjkwh/g53vNkQbJVVT66LUvHTuTRASaF5lKWU7cMqnE0ZWC
         L5ijPu5u7HxKINGIQefSfrInfhvQ4p1axButUS2fqg+OAVPAM3Q7KCtCudGzLVstE9K0
         pj8nFFyH4bFfigY7ilfbGSFm7cSTFx1iWQS/qHa0uttS8980scFk7trfwLA3ikmdT6Cw
         Lf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIW2ANU+buu+jTW8ajDtGqokBFW9eatKUUOw8o+4MdoagQxPI5KIAT+ee+5FWSpu5VQdyerIUYYSbbbOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3yyufUjnAjRNsAuTNKdCb1AgzMratAT5AdQjFjl5RyK/JAa0
	w5a2RziFbLbcHde5ykzOEpI38RjUr17SIXxRN51XxzaluoKQA7h3oK9g
X-Gm-Gg: ASbGncsjxPfxIyIKi9bsOvraNmO/2PCLaWeStZeZxmdfuDLq8kWXM9JsCqpWlRDD6fs
	bUHEO24uLFRCTubt6NU/IXMBLVcq8uI0tBoqTpjPduOL+MXqkkOlH9d82e6YH4sR6FXWvmc3MQs
	1SLUqYMqxPeOW5YrBmtVpGBnSr0anyzWg4a+ft1uq57MMCVIaMUUvcvIpfP0CIARcFTAYHEoCKv
	+gmXyi3362rv6d02poNV5nPDSca2fw6Vv2D0IRP4js+kzXVbuEi7DTRRdE8Dc1vNTNJCH3RlwUb
	+EEZa3t3D4AxPvf3hBq/+j4xjpsgzAcAYyj29AJp8WzvtkJINtyDNRyUz5ZzQ1p4zboRsJmeD1y
	WM1s9FNlO6ECig6jWHx9tHzj0wZdrgAurnLYLRc3O8M1pBeSFnz1vL12xNDW/drItfO4a57Izyu
	1juz/5Tqxk8fSYvGlTGGPhrEI=
X-Google-Smtp-Source: AGHT+IFbymgP7acspeJIYGYr+yCoZt35ZnCOv65FC9GFvmEZGXKh8iwKgmM+q7JvQSYy5hZmRSAA/Q==
X-Received: by 2002:a17:903:3c4d:b0:267:44e6:11d3 with SMTP id d9443c01a7336-29027379986mr28771885ad.21.1759901287971;
        Tue, 07 Oct 2025 22:28:07 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:4c4:4e8:dff0:bf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1f1a75sm184147135ad.125.2025.10.07.22.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 22:28:07 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org,
	broonie@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: [PATCH v4] hugetlbfs: check for shareable lock before calling  huge_pmd_unshare()
Date: Wed,  8 Oct 2025 10:57:59 +0530
Message-ID: <20251008052759.469714-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003174553.3078839-1-kartikey406@gmail.com>
References: <20251003174553.3078839-1-kartikey406@gmail.com>
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

Instead of skipping VMAs or adding new flags, check __vma_shareable_lock()
directly in __unmap_hugepage_range() right before calling huge_pmd_unshare().
This ensures PMD unsharing only happens when the VMA has a shareable lock
structure, while still allowing page unmapping and freeing to proceed for
all VMAs.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Reported-by: Mark Brown <broonie@kernel.org>
Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Suggested-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v4:
- Simplified approach per Oscar's suggestion: check __vma_shareable_lock()
  directly in __unmap_hugepage_range() before calling huge_pmd_unshare()
- Removed ZAP_FLAG_NO_UNSHARE flag per David's feedback to avoid polluting
  generic mm.h header
- Reverted hugetlb_vmdelete_list() to not skip VMAs

Changes in v3:
- Added ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing, not entire VMA

Changes in v2:
- Skip entire VMAs without shareable locks in hugetlb_vmdelete_list()
  (caused PUNCH_HOLE regression)

Changes in v1:
- Initial fix attempt
---
 fs/hugetlbfs/inode.c | 10 +---------
 mm/hugetlb.c         |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9c94ed8c3ab0..1e040db18b20 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -478,14 +478,6 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
 
-		/*
-		 * Skip VMAs without shareable locks. Per the design in commit
-		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
-		 * called after this function with proper locking.
-		 */
-		if (!__vma_shareable_lock(vma))
-			goto skip;
-
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
@@ -496,7 +488,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-skip:
+
 		hugetlb_vma_unlock_write(vma);
 	}
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6cac826cb61f..9ed85ab8420e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5885,7 +5885,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		if (__vma_shareable_lock(vma) && huge_pmd_unshare(mm, vma, address, ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
-- 
2.43.0


