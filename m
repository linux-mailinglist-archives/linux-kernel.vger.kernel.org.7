Return-Path: <linux-kernel+bounces-832658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDDDBA00A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DD54A7436
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE12D9EFF;
	Thu, 25 Sep 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2CEtn9b"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDB2C2ABF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810802; cv=none; b=GTUXOOv8K+9CTTQWsFGX79F1eF8uwFe9YtWJ4XBZ3IcQjgscpdnQ3t4kFTIuff1Sf6YZICbLChBgnGEyUdJNHSynzGhQhktUKIXIRXMKoqAkHBt0RCXgBdssXshwlGFzEX9LAGJ/ifni8yCc2c+fWvqo5OFYcfQW1Y5i7i82lWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810802; c=relaxed/simple;
	bh=usB823VFGw7JJjZ8cJVebyZbeCLJQaxY0uQIHwdbvE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BxNngPezrvqPDEqI8872/3k1OFnjzuBp6t2vXXgDFErbYohEQGjWZHPAs13unN/D5PxyH/oOpIDVDZRLUjv/h4Yc4hCugUIOkR3steNhq/p5qOXOd0ox1jwHzuIzl+CtW3FJHeN8D64bvryRt4kNZurTZBZepmpehFgjnEt4huA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2CEtn9b; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b551350adfaso1007623a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758810800; x=1759415600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rovQXBMGlH+WdMko9tBwUJE7c1iL7Sj9W2ARd93iF4Q=;
        b=Z2CEtn9bdXUR/hpyN+qX1nZXkbybHGGe54TFK6ItPDEWoeuFtqDTA4DuBjQIhsz/xY
         uSVQQHttVuve86KPFecKRKSCJw59sRRxteOHujpVauFNKYpMxa7OJj0yac8KlK4lVatU
         pVMwW+ZZ9vCGI4AmQP86+RG50UG5okh421hdYoBqCvVBbj3LcadKMIm6efaqaGMjPnJl
         etaCe/s2nNOjArWQ4BPwohjqPjxZiOU/9XJQecpE4E7PjsYjmFBJxeAvOSBoRrrp2/zW
         cFjEj4FwvBQ97Mxg5DnIR69YE9rlmz8Ic+ki83maIWUwDtg2LKa6vzbcesdtrLi/gw0u
         ukUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810800; x=1759415600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rovQXBMGlH+WdMko9tBwUJE7c1iL7Sj9W2ARd93iF4Q=;
        b=ugF2RXn8ha/WMjNDmcf4gX6vJTzyK5vo86acYrHi7JkLz08fgJe9+Bv6R1qbOcmJD3
         KOu7enK9pgfswn3LXj0cOZDR2TzmDzQL2Ctl2WkFSx+gsVPwZWDuUk/Xjcshc+fkN8yo
         A92cD0tF+S770Gz2c8Snpu7LcaoqI0dmGZgTPE5cyhkudWv7DRkieIO5vqmxhWpla3cY
         EOnIi/UlO4TNiWQv9jmGPK6bswBqX36KeGGRUXL5F45wLP9IEXrO/KxW6soLPgIHJkHf
         v7UTeWVCiYcVhATn76mAs77JdFzQ8Edkkq1xTWXvwvdorYzwUnMoRHq2pym510Ascrwl
         84hg==
X-Forwarded-Encrypted: i=1; AJvYcCXoWF/MXFacs8lDZWRof25XlAyH1HiZq4rVkZavLnOxjOBqqEB1l12XJj4pGN0eZVY8MpnkoqF0Xt2XgTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcI0gr009Itsl3ClpDL/0J834S42BsqJNEL/wV0Jqoc5QyjjnK
	QJkk/4Px7/qOEXaAt5gkZJ2QIdTYm9txKXdSYpAsOZqFaAnZZ3TzxjnK
X-Gm-Gg: ASbGncu8iBSBerZx0kJ0hlnY9bxhK7+obAt2q3iOvscCIFsMG7EsN6vIT0CWbFZ/og6
	jPxv3Fc1Y+GrGSIbuVLRc63tsL4IvuajLmF9DkIvn+hxa5bi8tQD47NGJjvM0YG+p4JM/nl6MQ/
	zqivAJQfrJeOkOjjqJNhGhVRLbuLQVM2LO8giz/pTE0g7dhdG3ZOyQ4dq11xmsBbtzO9s7mIbZd
	Y/3VCihvam+ig3lMK9qxpNtZbLqMRTd1UQWw4jX1CqiHi6P86AKknXPo/QA9jyl3iBetNB8mic2
	CM7fvI4fvvnx0wML1SirhZd2QIOqWAw7JDefbiIdo2eR/6TJqCal81ZTkUII++NCunMjzrqNsQF
	fKisf3hCr0BxVz2j32+6uGX8vok4ACyR6kkkc1meORS6o3+TlcSrlm8e2/Moc4+xT/SbVxAuJ/r
	1OAb17wRgjSwJf
X-Google-Smtp-Source: AGHT+IHSDckebz//1CVV5rONYtIqOlPvAVcv8Lm81NXrtrXR1QF/SkRc6vOphHtEvl8rAXgjaL9smw==
X-Received: by 2002:a17:90b:4c12:b0:334:2a2f:59a9 with SMTP id 98e67ed59e1d1-3342a2f59bemr3860265a91.18.1758810800294;
        Thu, 25 Sep 2025 07:33:20 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:63df:f80:7856:8de9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d735d4sm2645767a91.2.2025.09.25.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:33:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com
Cc: akpm@linux-foundation.org,
	mike.kravetz@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: [PATCH] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
Date: Thu, 25 Sep 2025 20:03:09 +0530
Message-ID: <20250925143312.149623-1-kartikey406@gmail.com>
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

Fix by explicitly skipping VMAs without shareable locks after trylock
succeeds, consistent with the original design where such VMAs are
deferred to remove_inode_hugepages() for proper handling.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hugetlbfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9e0625167517..9ba98cab3388 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -487,7 +487,8 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
-
+		if (!__vma_shareable_lock(vma))
+			continue;
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
-- 
2.43.0


