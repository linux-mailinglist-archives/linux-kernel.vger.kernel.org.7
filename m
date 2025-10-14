Return-Path: <linux-kernel+bounces-852439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D645BD8FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A705B351363
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833730BBA0;
	Tue, 14 Oct 2025 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anmlqMog"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1F2DA750
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440990; cv=none; b=NWthpE2XwQb6rFKPjDljKPPEJuyc7VtO/bnA0Ufmp9VhkT8eFOeJs7HujcYySLwteZAsL647XZfJNaJr/NOtf6TsKdGDD4pHC/py2znEfl4jHngpCRiFcQjUARGmS5chA5wVLbXBZrBlrockebc/Dsxe1s/Dcuu2cIpwNFI1F68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440990; c=relaxed/simple;
	bh=97cTclnlTqvSFsMuYGAS578uXq82olrBtfh0lEuFimU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fd7CGY3gSpIbEaQHMpmjSdslO5m+m63av+cufCuM0hwETonVAoiznFTIYsaJclOLveUSJXUQNdm9WXrl8bkeSQHp7EbHn+waRc2V4+eF2e1l0/c1ocTv99wc6Zie/+gkuJahIPJ8IRGm4ie6TVCVzr/KVDrueN/aADr8APnhdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anmlqMog; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso1935037a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760440987; x=1761045787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IQr6PZDQBToACp5mh6bdKZxuflv1r2zt3g5MFeHMik=;
        b=anmlqMogdHEsHNQS9ZbUU9MuKFZ9lm96rqw7RePaXC4bR9w2TfbUbyq1m6xVWGBiod
         BnnL/LNOk8DEffMGm+rzY9/VQqLeDIoA6ZnKPF/zIU10tHAJ55dZjAHrpczBuZ+RhHGH
         DFSfuFbHZTp/AQiwd0HzKQZ+pa/fOWCq0DiFPH2GJg1cPR1Ud2w0qEfUCuwuYOnAotBt
         ZVijfDWNex2ZFXmI1+NwtbyETdjK4hBUbrqt0uNuhWgFGURGkWDzR0WkEePGE1U+WQjC
         /prAsOD/wYbSt9nhILtN1R0U4McFcxOiphZN93rS/IkSlL23yXSJI4V+Bp5EsWRg/IHn
         E0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440987; x=1761045787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IQr6PZDQBToACp5mh6bdKZxuflv1r2zt3g5MFeHMik=;
        b=sLXQqQ+Dve/7ABY9LNQquIQzMCS7pZ4JIXkocITlky7sIiMV8pDVR3q78kDdtgwDis
         WfOXoeOHx4KDpwfpxmM2tBIW3hiOURYRV5jTsLb031LHBE4624Zt38sLucVnyFgtURLv
         285SpDPW2amzXRliIY58cSJ2WK+Ted/u1HRQjlA9mqLGZaV8tkzyoTNtaP9RXOIUukL6
         9L6cJly2M/E3eBM248n+T+34UOB5AnLzIOW+ffZfN3QcWUSF6yCsGE22H4cdU54OphVc
         dGjPL8ByFLr+GOSKrGzh1C5aYtmOad3LLVrwbSV6P+v2qUxVTJk5qyhXKhooZTTYz346
         2iqg==
X-Forwarded-Encrypted: i=1; AJvYcCWMW49CHgmJBvycsEcZr8j8F4NA3fCF7Q+w5V/HPkrkyAQ8hR3M/NuHv2qeoPzr+hIZyjQsxh09ml8rspE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0h2lcIDVGjTmnVB4kHXBl4MLbwkwzpgEkmh9mTl5Nr+Qqvisb
	EnkDsAiGixP6iW+xziu5YM0dG/Awwd0xvAAWmT4c8NzNHsUKuEc4XLnM
X-Gm-Gg: ASbGnctyaS6ftDbsgMhO8j5IiLh3WB8GVKnRxFidlPHh3xhJOFMNr+Ben9u9xzffLtI
	w/5srcJmr3Bcrbn0fjavsuh9WDhT0LGPPbo6FpiO6g/lWKIcOGdHoC285xorXqZKKfsvfGEMw9k
	49A1G177xJ8ADNQ6D7PK1bSQuWCYzfaYSza9tUqTWKs3+vFVYpWMzEhsesMYUuacVTdXZK4456u
	NuHHSazhBFg8Z01Hg6MgG1QCBqgEJuxzxGk+R918c8fA4DODUGj0NQKt3N6O3wHYNXEpLPCRwcE
	2PG+Q2maItV+QXGRwY8g8wIueI8dyM5ko5kzwaQ26LMRxvWxockp7Pj4cS+Uz4CzKGP5EfPD3N5
	chbEqYHvpFYT+c2aYgMQfruYvfeO9OCqfXmLg2efqaUgnfTP3AB5c7tNZwZo1DGbiFmpmtJ9hWj
	tljhT+yuXPMEG30Q==
X-Google-Smtp-Source: AGHT+IGa0oqy5yfoyAy3K3ez2PQeHy+vgY4rEknyAjWpihPiUnLUUYcVsJVMT12j0p04g7Su/853Rw==
X-Received: by 2002:a17:903:286:b0:276:842a:f9a7 with SMTP id d9443c01a7336-290273a1725mr289815555ad.57.1760440986849;
        Tue, 14 Oct 2025 04:23:06 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:389d:b33d:a221:52bf:8d99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e18557sm161986165ad.39.2025.10.14.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:23:06 -0700 (PDT)
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
Subject: [PATCH v7] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
Date: Tue, 14 Oct 2025 16:52:56 +0530
Message-Id: <20251014112256.18793-1-kartikey406@gmail.com>
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
Link: https://lore.kernel.org/linux-mm/CADhLXY72yEVDjXWfxBUXfXhNfb8MWqwJmcb1daEHmDeFW+DRGw@mail.gmail.com/ [v5]
Link: https://lore.kernel.org/linux-mm/e6bb05f7-8f05-409f-9d87-2d25f66942a9@redhat.com/ [v6]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v7:
- Rebased on mm/mm-stable per David's request
- Move lock assertions after early returns in huge_pmd_unshare()

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


