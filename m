Return-Path: <linux-kernel+bounces-832547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE6B9FA34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61AA2E2C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC8A2773FC;
	Thu, 25 Sep 2025 13:43:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE122741A6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807804; cv=none; b=JXVj+ZITjLSQp9aZNffodYR74HxBSFCXDnT+P6cIHhf++n10PVNKDm7MesZoM0Bg82oFErAW7t8MEljmv+WVYTyQ5vJgcsCNBbCy36Vv7mnbws4pZ9AMh9tBJeUrekmesP85QRdBFDyFIXtm3kV9oMfatCoPV4DiuX/LK4L0QkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807804; c=relaxed/simple;
	bh=IIYBqmqmFn1QrHkSF1UxKT8WwZXngN2SMA/fDUKr8V4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o9M9EkwJbg2xLlPS+cNCkcdDpSye91/tBftODl47WTDNWpeXKug6Q8pXL9q5dEfPAXP8UtQU1TFxlIMJF8OOiNEXFwm5A7vIkCRFPGg0rYSbfWdfdS4aOLFJ7HH0UReRtpveqgQWYTLHkKz/Z7xz0vjsL1sDQPLLHr0zJuml8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42594e15f1bso13865195ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807801; x=1759412601;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z49VZ+UOTMnf4oeu3gM2wE2mVrn3NSs6sqGONi2C/KM=;
        b=q87ZcGGHRWykLO2+cihDV6qXIl9wlbCIsvkn7flLgA6R18OeLi9LJC9K42JxOZ9xzP
         QW5mzpS6s9sd2S6owtAtQO+vXpDP/fUxo/SuoZAybXwZ19n2wCblDVoIuRtzIMOnDXZp
         MsPoeSTeeke1qZmmp6TYw+ztW7Yc5+cjlEE8ZR9koKH1QurvYAE6Sbl2q4Dgb/8fE0K/
         4OkO7+5ZM970/Be/uMGxNlGez8NL8vbLCnv7Peg94jSDUH+mcVAzYudb5DJxRy4/ic4E
         nDDDsSsMyWmpUn2wQ5nHrIoV4/TTOH5QeS6lfH1Puh8XopFYHsd2vQHeCWY6YFGAkaY9
         fuCQ==
X-Gm-Message-State: AOJu0YyMo7f1N1igvUaFNg8RldwCjl4JYHyUw+7IAZtR8yAWAVBe2krs
	kcLNfTebugTQrRmgzejYlSoRlRGpSvZeHxIu3Yv2/I0VNMONiEOJtS+eKD7Vj6i/+8EjGobkJmS
	nFojwcGay+gbwJMc5SZOTy4mGmy9FbmhONWemTPIzfBC+K7eNoY7FBYFE/2A=
X-Google-Smtp-Source: AGHT+IHx+L/MdD5bUa7TLUKhmQbajNiZ87aQlIJBZqubzRqW08cUTHQjxbwJOQ0V6MI6Getc10GpP8rjI0AaOuXWQEI6xYlv1kS/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca09:0:b0:425:8a71:b3eb with SMTP id
 e9e14a558f8ab-425955afa50mr58894255ab.4.1758807800954; Thu, 25 Sep 2025
 06:43:20 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:43:20 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d546f8.050a0220.25d7ab.001c.GAE@google.com>
Subject: Forwarded: [PATCH] hugetlbfs: skip non-shareable VMAs in hugetlb_vmdelete_list
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] hugetlbfs: skip non-shareable VMAs in hugetlb_vmdelete_list
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

hugetlb_vmdelete_list() processes VMAs from the i_mmap interval tree
during truncate operations. This tree should only contain shareable
(VM_MAYSHARE) mappings, as private mappings are handled through
different code paths.

However, VMAs without shareable locks can incorrectly appear in this
path, causing assertion failures in huge_pmd_unshare() when it calls
hugetlb_vma_assert_locked(). The assertion expects a lock to be held
for the VMA being processed.

When hugetlb_vma_trylock_write() succeeds but the VMA has no shareable
lock (__vma_shareable_lock returns false), the code proceeds to call
unmap_hugepage_range(). Inside this function, huge_pmd_unshare() calls
hugetlb_vma_assert_locked() which fails because no lock is actually held,
resulting in a kernel panic:

  WARNING: CPU: 1 PID: 6594 Comm: syz.0.28 Not tainted
  Call Trace:
   hugetlb_vma_assert_locked+0x1dd/0x250
   huge_pmd_unshare+0x2c8/0x540
   __unmap_hugepage_range+0x6e3/0x1aa0
   unmap_hugepage_range+0x32e/0x410
   hugetlb_vmdelete_list+0x189/0x1f0

Fix by skipping VMAs that don't have a shareable lock. These VMAs
should not be in the shared mapping deletion path and are handled
by separate code paths for private mappings.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
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


