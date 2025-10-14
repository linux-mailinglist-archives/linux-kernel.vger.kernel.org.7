Return-Path: <linux-kernel+bounces-852467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B77BD90ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBC254F59D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F030E825;
	Tue, 14 Oct 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LihidN2o"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2D248F57
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441639; cv=none; b=eLHLTn4C3pa5WvQ8PEGI5l7JcliiCP+khBlLJrfCzTSXjnh/G7fPKfeFjl8TMowQ7m6+yJtjMoTOLxCxZfxD9LEXsK/nb5KjHWyKYOgdLeFourja0RkDEpzPIW5t3s7y3G6mai6hfQ+BbRPc/fNtB5FNZf3RWsCQqxnqUsZQbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441639; c=relaxed/simple;
	bh=dzIDjwiKn2vE7+jPWk06YQWrk2ZUTy00oh2oD368A+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UR5GxWL4L+r5mrWAM05u8oIiAwOt9pWi8J8VUeeW4x0kb9a7vhdgaEyn/7wJzbqx5IRiBO8oPDlNFzl6gj/xSmcoNnKkeohA0jzztOTGmJzlXGziNpyTBKeYXnopQuFA25p17GwKHgrsMchY9HXkIFnD03WjzqR/YyuHP98gn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LihidN2o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782e93932ffso4678983b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441637; x=1761046437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqXpe7x7iRLgj6HmBHBg92vRFuM1OGyjmXgGmtw1Vmk=;
        b=LihidN2oIhCbGuXwpXX7K+fsImViWZHVuoHQa6dI3tXnTO52vYUm+1ld9f08BAAqY5
         yGo0G48rwFG3UOZDE4NENMWIIePO1QV1opul4Wda2/8FhFfmfkFCEIrmCHowQlN+GLW1
         zGVnfqoTw2OS63NoNyl15S/PDAP+KkNxhHA/Iub5Gz6AZrldhEtiIDDnb6Om1eevxQs2
         uNKS9tVikhDzmeWAwT8DDB1FZpwCbp4Csx0Xc6+GyHj0ky0qKrT6sjhJD0GlGFbVvRWo
         ZhDiMybgDcAXszSPk/286D74gV7nWJmF4uOQ1b+y+C5OLIpSMUoTcLzOj5hZvKxD+8mo
         3UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441637; x=1761046437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqXpe7x7iRLgj6HmBHBg92vRFuM1OGyjmXgGmtw1Vmk=;
        b=mElSWMMpfN8YALFw5OqgNx6+Z3mEFA04XOzQn7fxT8ovknUvketikcUGDAVK20ZD4J
         tbSZ3htHY6MnYiKK+NyU0fZyK3GhgCa0a0kbAFglIXEIHifpT6rVLHnzFuax9EJNCl3P
         CyJeYabpu+NkytO/kVq1YpH6TCJnMHzmc5qL+wCplXY2gSrNYAK1VBI2Q/n32Yd0Oc/R
         M657JbiO8XgQ3jmrZT3+xa1L3Uy6g55o7rcjNQOIOa2ZEes7QF8fYU1gMjxaFzFZ6Q4v
         /68pywRDQASQQz6yQEYmuwvcLEGpMF734fZZWadhHteQxkCcgHGn83KMGNT+PJyF/+QO
         Uofw==
X-Forwarded-Encrypted: i=1; AJvYcCXcSuI6IX/vh+rJMPIEEzQCzXm4tCz1l6Lzpca1atGyJ92usgOH5llWuD2vsuKtwcCRpT+X2GOM/VGZ6Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHvHMnk7pIT5vj8tMcEJHUe/FHpo1MlPbicx8/iEBXD+XuopZ
	6HGtbhpPyZHaUsrhj9BB33Ay5zsfRKQJEPh2tF+eCX+HGCQ+S//dzVR7
X-Gm-Gg: ASbGncvXOkzwDzgwL4Y1ydPL6K7aVNmiFI6ZYRCqHwj/xQ4hjjOZcAlsqOrQKgQCdhO
	XV2lzRSsQE/gIVfIXKelXHXxmy+AxqJjmfocGx62LDb4wFmsncQ3xk9LcxZZbqN30tSJn8UQ5BL
	1cDxTebG89WM97dZWRBYJ0r5wqPbu7vW+G7P8L2a2+xqbPbx2KbDGubId7i4ZyoT8M4k/JjW8K6
	q0PnJKytnQ49YXGhlp+ySfMpoh4aa4xSBCYzAW1Hzit9f3KRgCSJfHGu0rgZp5RmVVuixnMPsAI
	R3kZ4xio2R5xxIpaZRRQ9jBXbUohC3rP3UAVBzyx5wH1FmMQHdiqrIlrtTop7+z4oDitzVYOHNn
	As7o2qy0Q6JDOQyOY83JptmQTcN/uTe+fAn84lgoo9KWQ4U32swi2qKvepkFzk9stI8T/4L8VXY
	XoNDIxpQ9ze/Q9Fg==
X-Google-Smtp-Source: AGHT+IEH57zSPjucO0Eu9gEc1MdmkoQRp0mGC5W+PYhilR+SJlwfPxoxj4Bq3iEq4uuqQJa3s64vWg==
X-Received: by 2002:a05:6a00:3e07:b0:781:899:a9 with SMTP id d2e1a72fcca58-79385ce166bmr27119513b3a.11.1760441636489;
        Tue, 14 Oct 2025 04:33:56 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:389d:b33d:a221:52bf:8d99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd854a2sm14792004b3a.76.2025.10.14.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:33:55 -0700 (PDT)
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
Subject: [PATCH v8] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
Date: Tue, 14 Oct 2025 17:03:44 +0530
Message-Id: <20251014113344.21194-1-kartikey406@gmail.com>
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

Instead of checking locks in the caller or skipping VMAs, move the lock
assertions in huge_pmd_unshare() to after the early return checks. The
assertions are only needed when actual PMD unsharing work will be performed.
If the function returns early because sz != PMD_SIZE or the PMD is not
shared, no locks are required and assertions should not fire.

This approach reverts the VMA skipping logic from commit dd83609b8898
("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
while moving the assertions to avoid the assertion failure, keeping all the
logic within huge_pmd_unshare() itself and allowing page unmapping and
freeing to proceed for all VMAs.

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
Link: https://lore.kernel.org/linux-mm/e6bb05f7-8f05-409f-9d87-2d25f66942a9@redhat.com/ [v6]
Link: https://lore.kernel.org/linux-mm/CADhLXY4WPxzvzuiZPJmhS-9xMqRZ_qf7ZcFf5MXPgXbgB3_Xzg@mail.gmail.com/ [v7]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v8:
- Add missing revert of skip code in fs/hugetlbfs/inode.c that was
  introduced in commit dd83609b8898
- Move lock assertions after early returns in huge_pmd_unshare()
- Based on mm/mm-stable

Changes in v7:
- Rebased on mm/mm-stable per David's request
- Forgot to revert skip code from fs/hugetlbfs/inode.c

Changes in v6:
- Remove __vma_shareable_lock() check from __unmap_hugepage_range()
- Move lock assertions after early returns in huge_pmd_unshare()

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
 fs/hugetlbfs/inode.c | 9 ---------
 mm/hugetlb.c         | 5 ++---
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9c94ed8c3ab0..f42548ee9083 100644
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
 
@@ -496,7 +488,6 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-skip:
 		hugetlb_vma_unlock_write(vma);
 	}
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 795ee393eac0..0455119716ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
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


