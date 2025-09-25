Return-Path: <linux-kernel+bounces-832675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C2BA0120
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52277B4441
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FF2E0922;
	Thu, 25 Sep 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp9Tx36r"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52242DCF77
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811786; cv=none; b=YzA+WFNX9bRzKpRjnMgj/uIPPClAm17asCq0HuUyNz2pK6GJAZd6gHDPbaXmn7pog2jxofgWAOS459ssFgzgGoH03clap4XbCueQKn8ZBz+JeBhHA/pNOt2Ezmnr/ikq/2EOkxeNR4myfYEyhJszD5DF9P1M8XMbDfwJ4Vap328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811786; c=relaxed/simple;
	bh=usB823VFGw7JJjZ8cJVebyZbeCLJQaxY0uQIHwdbvE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNxRFs/cCiaFkT0+BJiYPRbA535QG9uH1XWBQsLDvgCW90V6irPyYcaBEu6FPl7gi/Lq6HMq3BS6r0zRhknE+VL8L2bo9Iw3oyI/1JYt6+VySV+o+ld7KaGkN689R3U/Nm4Ce+/bMlPy7bc8UzdXtYXjSH9MFBEB94vBdeL5g6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp9Tx36r; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b557367479eso754892a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758811784; x=1759416584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rovQXBMGlH+WdMko9tBwUJE7c1iL7Sj9W2ARd93iF4Q=;
        b=Gp9Tx36rhb3KUZBYUBxA9vAaq3jOeEI2JtK/28JoCzOcjiGEI2P4SYVoUzjlfwYKmT
         CEsTzyKfKeVeB4kz36LQbX33/EAGUDt8SMCLGQbaHab+Do09sbPMXiOmu8oLTrKpi86k
         nDKbX1m00im1SQPjDhNO2U9R38QUE6GHln/GM2zO2zx1o97gkcG+YoCRR/7JxTQ13zIa
         LzNSPYPQTp6lgQ1t2RlZwBWYGfvXaMwTdB7DZtEhYTeMhEEo53+yk6PFLFd9WgvYY7qj
         3m6P8dhJ+1wJu5+S7xi+Jkz0Pl7Qa0qq1pIB1cFNSAdEDDazGZ8GAWF80K5JMRpDH0Nk
         II6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758811784; x=1759416584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rovQXBMGlH+WdMko9tBwUJE7c1iL7Sj9W2ARd93iF4Q=;
        b=IbCJrCEDxKHMEc1Yt9eQpHRKVXNbJza/PcL214U03DQCh39eKuXY/umeclPoJmgJUy
         yFUqSnFDtB7upLY3K8nB6b9ihiw3An8MVlfrjiyUGbAoX9zgcWKAK34XhS9lVIS/gUMr
         L7+cR6BEmaAUkwFvH4KXWjtmGL8n+l3FhVWWdAOqj/2NsfVfuQxFcW7Uqfk/GMHteqey
         hhZ/i/mDohXw48RY5lP3PqGtD2Aqg0P7KT1jk4QoMUiN6vZ2K3+vOsoVoiL0S1WdLvp0
         jScQksZgRnbGtPyOdvsw2nbY8/RHOKQk6bWDAaIcA4NTZSei/YaR7RT9vM4g2ZOdrHXx
         5Khw==
X-Forwarded-Encrypted: i=1; AJvYcCV28c7mEyNgahyxWaxbfgkiHZkT2GFdGoMbcYfUIJC05kt/p6wnFLN9bYt1I9XWbqndPdy10EzyjiQsEko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mFqmHq6Xgm7gWwnyTTH5ulERNjngvuT6xHRfLbHi1NYYTr8c
	PZuJ5MJUg1kxUbKuMthqXhBxi3HoUJt8weifXXxpjnR3+Sl2Vo6WdKSfzLrP24LuBhE=
X-Gm-Gg: ASbGncucL9f4Wbg/Qs8vfsq4vYgd+lKFfl+mcPDs4Fe9lsROuX8NF4zeTJ0ERSXl+wD
	WCaLlDVa9EwS9RLOE1J6XYkyuYc1rxMy/PUYIEfqvtS2E2JQp4/568CkEt1UdZII3wXiB3Yh6HD
	yl9zGviOSknA1yzpKmPFTGBLty2l6AebQj+iVLb7OGyVw4wGF6Cof/SPKjB/NDbYzNnSPjUqVK/
	aW2l4Cl9UPqyZqswkTgLmZu7VBHQrAMefpDANaT84Qg7JeNWQOAw3IfeiuATDI2hvdUs3Vuixe3
	o8SjsW1SIxTWGxUui91R9b2stuZbKyq/SiG1nsXd4fcVsPC0T7CRuU75CoJbp7LA9/bUaZe5dVG
	pN+SnRbUYYfJw+UYzQV+rQa/Ag30zFaPWVXN8gS9z2WD3jVZFChh+iyMJtcCpnq06b5VDx90vP9
	cc0O0=
X-Google-Smtp-Source: AGHT+IHCZkipERRfFFQvCNVbKNbLe7gqjyfLJr0sdOftwhgT3H9vNK2pNjmfJvAfYa/v+uljVYabag==
X-Received: by 2002:a17:902:f546:b0:273:240a:9b6f with SMTP id d9443c01a7336-27ed4a76ec0mr39941125ad.39.1758811783941;
        Thu, 25 Sep 2025 07:49:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:17a4:33dc:a325:4bce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed65e8e89sm28432605ad.0.2025.09.25.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:49:43 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: [PATCH] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
Date: Thu, 25 Sep 2025 20:19:32 +0530
Message-ID: <20250925144934.150299-1-kartikey406@gmail.com>
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


