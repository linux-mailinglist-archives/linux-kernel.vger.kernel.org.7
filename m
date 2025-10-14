Return-Path: <linux-kernel+bounces-851770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141BFBD7367
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17041890981
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496B3043D9;
	Tue, 14 Oct 2025 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZKVCEf1"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188717A30A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414260; cv=none; b=YOfCzvw9XW3yoePmlAiHK7cW7azLhMRs0AMBsC7VoAteCYlIvgBSaWvsix3IrrXjyInLBXl8qzlQ//6//6v4PFNwipeYxA8YMv5I/R37ieVyeXOr8/oxmqj1S6bZhuQXfnpCT6hQxVyBCJfIU240XxVJ6Nw/LrNA3/lPBK7LM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414260; c=relaxed/simple;
	bh=XWGmCumYMFtzqsZIMSbS5LotmRF+YnRWgF5niQ8P0UY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CfhlEUxX0gj6q2ezJiwElsj4qOnWaEnaNZj0dLSjDQpRZmZa3zfdhK5/iEx5cwl+3E8qxh6chvn9og2e5tMQgMzYy/ZAzUKr0M9wHYkiJQOPfaZ5qLEEWhM+LuCJ/SRquvez0ohrjM8nEWIl9+MAgHfe1dri3Rv1T54zYNotlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZKVCEf1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f67ba775aso6857386b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760414258; x=1761019058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z2NlKgP/sNpQxsAzBMmC/fbOmtwwCUWX3Npz5SEPkc=;
        b=XZKVCEf1eMHRU68oZjDLXqii0w3qfm3IyHBKKh/ICH6n1vXlR2+e8DnclU5WtwtMZL
         LknSDaZbRjVCB64NWP7K89ZnQg6SIKGUWEd7JG223uaGcDZiOjeXrEfjpuzoyw8zFNTO
         kYLV0zRJPkRnTELfc5lNPibAsHX/kBQ6aK8gE5kAhI9HSQiyEtUpQLacV2PIxKRIxZbU
         WDemVD4KYAXbzufIV+W6SE2W+0jeQ3Jt3FupSUZXWq22iY1n9O5DoMZpnIoQsR8/MFzy
         jacgrvzAJHH5Z+2R94dUsUwFtMq5kmkByY2TNMvDd0HZFBWE1joU7L+WgjArVskDz7vP
         48sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414258; x=1761019058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Z2NlKgP/sNpQxsAzBMmC/fbOmtwwCUWX3Npz5SEPkc=;
        b=TkSvF85YuWxnvo1A+bCtCxJiEXjGevyaP1eIwK0jtA8MuVvbPngQN2bIv0ot9oyLT2
         Jw/+pArp5MruWVnHdfH7VxNAfjHmNE+P8+8Bn3jPmtxKOUclf1OF3WzNGOd5Oifqggyo
         kowzdvLYcITZdzPQePnVSHFhu38qzzgwtvmiEh98o0BC7rYI6F2tm8vfnBLSLP500SGE
         hyO0gBajfuuhSB4vH99MmI1lQPQHK4JlPjfuFUqFwWtaAjLOY0juu5TSNmZaN2CBTAli
         L45lax2WG3CSnX5aTmOrtGRLOwz1znl7KMGcZrOtWDuV8aonslttl+9bbGga+LdWqNa4
         8Kjg==
X-Forwarded-Encrypted: i=1; AJvYcCU+MXyFYWdDxuDNEfQ3VIso8zSStMIljneKkPxBD7jazy5ZXznqWACkptKRp77nJ8bAAqm/xfaUbeWkHPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRqVysTfB0Ef5mg/S0G0f4A/oZJOScfOypycWlnLL6CXbzkfY
	OjDjsRqUd6v8wpY6B7oeezZO6/dtUZMKFtWHqa3oAbuKg/yS06m0rxRc
X-Gm-Gg: ASbGncvWchT1Jx3goZkaApvW5thxP1xzHzx1jEbBPZEuoUmRgIuFLhReGQs/sgJUyoK
	6gA0EQGzCKbE9XgjXdUle6kb750B3yEa5LJOPY+U64Z7rSnZOrU4y3HwgyXK9Q7Kg2uoWrZIzuf
	X96zRGBCl4uWba27Krjp7ekgwupg2oqrHASNkkOv6dvS68rE4OhOFWV31rO1wBDSy77Il3U+jg3
	hS+y431gmqxAcXTS7I2hnxSmBDRL1X/4+GOModNVBT9abZLgJs7tI9hJMZF9OdjrIZneGWvNzHR
	c6rQD0uDm0SIQdeAQgSKgxj0GzOu/QiP9Y6oKocT0Gj1g/LCJJ1a/fDQToLzUxZAtAZcSmJ/DaB
	iI4Kwwlnx4SZuuF7A/DkErJ3cNaU+UxzsGZQ4t+XZDNNRBXNPvZzq2ffz2leCJJMMl2PPhhbU9i
	nXGa0=
X-Google-Smtp-Source: AGHT+IGtOgrE8fYCzjl+tEEVLvrBjJ8kfoQiIhkeUyl6gIYCX4G4EyjTz7imEmv/zdWusWGJdNBk5Q==
X-Received: by 2002:a05:6a00:8c5:b0:772:59d2:3a49 with SMTP id d2e1a72fcca58-79385518011mr30755301b3a.13.1760414258257;
        Mon, 13 Oct 2025 20:57:38 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:389d:c391:4ad4:fa2d:b790])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd85317sm13243178b3a.79.2025.10.13.20.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 20:57:37 -0700 (PDT)
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
Date: Tue, 14 Oct 2025 09:27:20 +0530
Message-Id: <20251014035720.346268-1-kartikey406@gmail.com>
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


