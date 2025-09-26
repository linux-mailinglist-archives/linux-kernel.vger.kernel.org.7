Return-Path: <linux-kernel+bounces-833558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054AFBA24E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FA93AF189
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064E1B87EB;
	Fri, 26 Sep 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCeWWvkW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91C8834
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857592; cv=none; b=KYkUV74JjtMCPXo49CoqpdU4/EaaYPb2T41vFQIf+p+un3w/j7w/4TmuaRV7PiJZ8PX/jwdXF7SWRQ3KTWgsJwApmxE1RQdAqdZkdPJbGqjXgm/MyTGRukCYZVbTclYgl7Q2emFToMfgUtRRxp0gplA+UWvnyquuxlxaKL3nwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857592; c=relaxed/simple;
	bh=MdfW5MoLF8+6nv3dxrSOEJ6G2KoCGUfCuXIBXeIBjZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SdX8iJH8ifl6cDVo36P/jPK2QUgfiLd9yVNm3jU9q2A74snKnn7g9ZyvL6LDPRjH5CsnUstLtue+CoAr89kxZ94KWWAL1erIgeyq9w2iuxu9hPlzpkD8jV9y18CKiQt1UMfXjv/NLwB3edKDb6AY30O+BU2Yh9mbyl318BgR2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCeWWvkW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d3540a43fso18696525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758857590; x=1759462390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swasiKAy9erpXahrURLh1edzUqPTKg8IFE0nB6K/KGE=;
        b=DCeWWvkWcHwgwxqx/Io4CA3Q4woImtxV30d/bxPeGDJupmD+dxsr8izc+3NR8/yORT
         kFMLCKZq5+5rM5Rjj6RZs+HK65CQLaE4vlpeY1R6++aYOX1p52ZSRBMs+a9FyzhGicR+
         vcixc7Gm2XXg9dGIFRAw8TRMUTwuZQOOifMG6FtJHL6sqy+2fRU0uQBZTPlYmLFcdIXq
         6Evz62KId4tdzlLfdfzqfL/fZXHHBn2BzU10SindG8LYc66m7Suy1qyNsGvo3SYKYhmf
         L9ZJDg2CKf/8iqirWsPvUcr6+BPTmV29g0hjFObwpmfzJ8ihbzH6rSFT8J3LkbYMJRs3
         Wuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758857590; x=1759462390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swasiKAy9erpXahrURLh1edzUqPTKg8IFE0nB6K/KGE=;
        b=hoWLBnTrdypSq62hjZ6InneuQygYMyzpYr4EqrZ3b9gTKOaesd/swLxZcxJMDV3Pp1
         uhJeycPLOwyBxCWAlIN2XyIdIxVbvwEbQCI09GVlaq/0hRIv0kG/fC3ngMx5PczvlNPm
         YJYNqezYQwFsuKiKFyr7yWw0vpaKGS69IvghkrkBflSKd9VFgyv0ZZOA6AAaLkKYZ3Is
         YSDZvsb6tGdQIfYeg66WWAh639IEJ5+Ri6yFpi797UHdw8BrcYIKVdo09lWVoen+R6Xf
         HLRLe0G9YVRBUw6WA1fboG+WpF2l9jNVx26JX8MJl2tVT5qRGHxu+pauOx05HqQtptUO
         pNWw==
X-Forwarded-Encrypted: i=1; AJvYcCVEsl03femwGAP/XZnghPgZNJNPGUFxnRr+OoREd9YJoOtS6nGzjRyg9BdWj0QMweH7Jqs3fvf6V96kueg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBJ7+nkAsW5LVEyheJ/B6KHBt41zQXh+UiQw7JOIoZCt4FuSn
	EAaeYgI2yC6zJsZ0N9/o6/8KzixIh1rOPWsAWKnRAiCoX/DNPkKB/tsb
X-Gm-Gg: ASbGncus6kItMPVAB+DuhGVPNlZemB5ZbTqZyLG1Pr41RkfdUt71aqvJSxOMphEf25E
	2ytZi1N43QimVl4z7ChoDT3zK4An8sPwVBlv7KcIory8RSfsG86v/KB67OfYBfmsaS0R+3PWlxg
	1h/xWmlAj9T02CK1JXJ0Bp6jcn2h8/SEwv5lRFHKwRmoIb1gV+/Z8HCN7DGbYm7KJ1hhFs3IsDB
	E0+1QifYnd+P0N31/9wuuLAtUwvjhxSrqBo3nkqiEUud7mxUoOsthCy+IYP7ngB2fInTM+MQYiE
	j/QapL3OFV1SM0g7LBorCScuXUqzY5K1t+hdkfqLn8Ko27/t8Z+XaskaUzHiL3e+Ii0GV2lT2Gq
	/H9QZPW7nUMBpSxcV4iEilXJEkXD8x25WY27z56SmqXRBvJRbFwNpBf8Z6TOaiONdPLckq6AasZ
	UgNo0=
X-Google-Smtp-Source: AGHT+IGVib1Wn8HeC0syL4GXw8dpS7EKsj57MJdQZoUqPJPbWnjFKnxPMpLvgZM17uyJ+TvLTPKElg==
X-Received: by 2002:a17:903:244b:b0:27e:ef35:2dbf with SMTP id d9443c01a7336-27eef3530ecmr12593585ad.30.1758857589845;
        Thu, 25 Sep 2025 20:33:09 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a5a4:3d95:4e23:c62c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882227sm39830265ad.82.2025.09.25.20.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 20:33:09 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
Date: Fri, 26 Sep 2025 09:02:54 +0530
Message-ID: <20250926033255.10930-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hugetlb_vmdelete_list() uses trylock to acquire VMA locks during truncate
operations. As per the original design in commit 40549ba8f8e0 ("hugetlb:
use new vma_lock for pmd sharing synchronization"), if the trylock fails
or the VMA has no lock, it should skip that VMA. Any remaining mapped
pages are handled by remove_inode_hugepages() which is called after
hugetlb_vmdelete_list() and uses proper lock ordering to guarantee
unmapping success.

Currently, when hugetlb_vma_trylock_write() returns success (1) for VMAs
without shareable locks, the code proceeds to call unmap_hugepage_range().
This causes assertion failures in huge_pmd_unshare() → hugetlb_vma_assert_locked()
because no lock is actually held:

  WARNING: CPU: 1 PID: 6594 Comm: syz.0.28 Not tainted
  Call Trace:
   hugetlb_vma_assert_locked+0x1dd/0x250
   huge_pmd_unshare+0x2c8/0x540
   __unmap_hugepage_range+0x6e3/0x1aa0
   unmap_hugepage_range+0x32e/0x410
   hugetlb_vmdelete_list+0x189/0x1f0

Fix by using goto to ensure locks acquired by trylock are always released, even
when skipping VMAs without shareable locks.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in v2:
- Use goto to unlock after trylock, avoiding lock leaks (Andrew Morton)
- Add comment explaining why non-shareable VMAs are skipped (Andrew Morton)
---
 fs/hugetlbfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9e0625167517..9fa7c72ac1a6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -488,6 +488,14 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
 
+		/*
+		 * Skip VMAs without shareable locks. Per the design in commit
+		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
+		 * called after this function with proper locking.
+		 */
+		if (!__vma_shareable_lock(vma))
+			goto skip;
+
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
@@ -498,7 +506,8 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-		hugetlb_vma_unlock_write(vma);
+skip:
+		hugetlb_vma_unlock_write(vma);
 	}
 }
 
-- 
2.43.0

