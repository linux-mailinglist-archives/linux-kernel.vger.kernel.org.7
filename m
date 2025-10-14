Return-Path: <linux-kernel+bounces-851755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47FBD72F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9B23BC959
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C814F2C2372;
	Tue, 14 Oct 2025 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcKB01NL"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959D2222B7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412403; cv=none; b=RJy1/7oZeZsSymdkw/kbqxD/c9cRHnRclAkhxHtQDWwRfDup3Ou3JTgFD3feYh4cyKUhdzi7f5edmJnKCZqSawvBXF3FadlLZQDGT9CRMWUVt+R/DW92PodFwC9oClMi5gnGzv4dzHaUH91uXOjRAW22grgvAEN41zTl/st+ugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412403; c=relaxed/simple;
	bh=XWGmCumYMFtzqsZIMSbS5LotmRF+YnRWgF5niQ8P0UY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GlsCZS0nU2guQNflWDTi1kHDLrVf+lRXxIZEcZ0pNSUEn3qlbFhxbg6u3etdwheM67ihorT/a1txFSOv427z1Lx2kF34sUdy+IpWgLdTKA4SVmegow+yEkfATR9wCPc18FjKLHN5Ls6CePDAXQ8f98E/NjmJikJDNySnMCm0mMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcKB01NL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f5d497692so5941534b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760412401; x=1761017201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z2NlKgP/sNpQxsAzBMmC/fbOmtwwCUWX3Npz5SEPkc=;
        b=IcKB01NLZ6+qoY6S6BRjXT6ULQIrsOd9QgBibFlfgFCmbW92ZuD/Z/Fftt9SDGwGL4
         bVaarssh8TFoaz1GUTGdtQDOJRqB5WFnkdC8z9c6rokcvbI2L0xbB1olbUptiugBAcuQ
         Zh+JcRfftTg1wxGep18T901rrdIuzZ4NhThUEZbkvLoyuYQsL1ED3BOKBVPogstoSvtC
         TBHhjBpT4RyygrXqXuT3/Em6SsR5ESR50LTfBatoYFUCnmc1NSNREIHvYB9EV72uyIFu
         uNGe/p7uFGs/i0vmy/4YWXO+nt50pCzwXdNxH7sDef3ldXOXVITmWBG9MTug5YLBxYdU
         BpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760412401; x=1761017201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Z2NlKgP/sNpQxsAzBMmC/fbOmtwwCUWX3Npz5SEPkc=;
        b=OONFFfDQzSivKDgFmoc5INwYZc90Whg0YLhZdwzfGMNtOC6jWZC+62/4W/3lNDJw3Q
         SFwgfCtYVtVQ6gQoUkpGLTI0FuarJMVT4i8nMGerRJCD5Q0NC3GZR4qVLema/Hncqc/V
         JI7DsEFyYSW08m+WD/LSAH9trt1kvtysqLYgT8XzU2FmhfH4hOc7F2Zbq3K860TgLUtY
         VSZmWAiUAuvLmWnP3uFgi8RyYQu/JVJ/QHKUcP6mx8esPeosfRjJgYiVMnTPWenulqPG
         ConUHZTuYvB0OBnzIskfAnU5Ru7UV3GsTQILnKWiYGZRm5+AEbj2sZ9HSFT3SQ/fYBuM
         K3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhLGfR9ZghBtK2w/81qxBmXGhSiP7aRvTiCK46xGd2nUEuwg15kdJbpMIT58qiXXhi4idadzZrl8fsOLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMNmkcgGn1i2kKlWlIQnfoUoutfFffWt3rzYYoCriMSPl87uj
	LjQO6XWNMEavELvB3N5s+w7OVbpq6poHPfW5QEaYNrf9WFptXtk+RgxxFqWOoyXbJT8=
X-Gm-Gg: ASbGncvGAIkVzp063oFGgzaMNWGPbxffkxXmS2MVqH/1K7LORH0QhhQ3L8LaHCFYVeR
	3WiOSa/mZA2ABAzW6bBcLZZxf47NL8r0xJmE1VW7xrTgn9sw4QD2M43iQMBiS3ElhKKyTfY30IY
	D63K/30Tg+W8HU9TBcTZAH2olpsdSOXXN9fTvOQi0x0bpLSDRucoAWSdiBdftfOPCt25ocziJXJ
	vPGsLEaRKjtV17bXWw40LeTq4XQQnL99VJmdjj1SziDeELqbnhrdjd8bSxRkZz81kQ73aH1NV8M
	56i0mKGvjALbz8fYq8G3cb3RZsXkMrKM5TwUrBvNPcI5nHdt3ZbEObnfDy9AszbSgQPSVyVn+YM
	yXgoanzfkJL2l5cGMlg2D8l7udeThgiF8jLvt7x67rVnAR389ppHDVk0bFjMLC99mIl44G8zuqP
	2ttmdgtib3Mgn7eQ==
X-Google-Smtp-Source: AGHT+IHiLyaDYcsWx+W3f+TMyLFs0ZaeLr7rJrtuKhZhf00wDHV9m8BCbHrvN/bPmejb7TkCpfTpuA==
X-Received: by 2002:a05:6a20:2446:b0:262:4378:9df2 with SMTP id adf61e73a8af0-32da845f861mr29523182637.44.1760412400792;
        Mon, 13 Oct 2025 20:26:40 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:389d:c391:4ad4:fa2d:b790])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0606f0sm13673109b3a.15.2025.10.13.20.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 20:26:40 -0700 (PDT)
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
Subject: [PATCH v5] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
Date: Tue, 14 Oct 2025 08:56:21 +0530
Message-Id: <20251014032621.344209-1-kartikey406@gmail.com>
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

This is cleaner than previous approaches because it keeps all the logic
within huge_pmd_unshare() itself, while still allowing page unmapping and
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
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v5:
- Move lock assertions after early return checks in huge_pmd_unshare()
  per David's suggestion - cleaner approach that keeps logic within the
  function itself
- Revert all previous approaches (VMA skipping, flag additions, caller checks)

Changes in v4:
- Check __vma_shareable_lock() in __unmap_hugepage_range() before calling
  huge_pmd_unshare() per Oscar's suggestion
- Remove ZAP_FLAG_NO_UNSHARE flag per David's feedback

Changes in v3:
- Add ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing, not entire VMA

Changes in v2:
- Skip entire VMAs without shareable locks (caused PUNCH_HOLE regression)

Changes in v1:
- Initial fix attempt
---
 mm/hugetlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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


