Return-Path: <linux-kernel+bounces-852613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD086BD974B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6103E38F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25F313537;
	Tue, 14 Oct 2025 12:53:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FC30C62B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446409; cv=none; b=FMsi3CGKEYNuKCXDFSwk1XeQp5npix9rNszAEA+9al6LGfevFdiBZGAeOvBdTpgN8WK5S5SospfPLHUQmuxCq1+DGoTr4tzJt9nbr9F2EzSa/oGq2O4d7XrI/EAiVJi7MxV/ZAT0/lok9b22LsJ9iMuffwSt0I2CifhZmmCqiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446409; c=relaxed/simple;
	bh=wlnpgxqKUtHipo1UE96/JGVHbGGSvs00Xy199A6lNvg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XzsM2dCabAmmcUhBbpD3B3oDxIIziuqDR/uKgXF2L66TAqI+ZpEHafAP8kOLZyVuT5ajJ7CyJR8HNy+WHv2mDNX48LyZjQOlo2DH9OM/IDreflQl/piHFhZY+ud5ZeUaWYbMGVBeA6TYXLmZkZWZkxr4cjTZFOKv8uwFk9egRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f9f48ee30so27269795ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446407; x=1761051207;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmp3P1Th37YuAjSeDEeB29rL1viZDNUJ5c1OsKnH9ZU=;
        b=pw0xsN1XjrBolMrhobBd9ex3po5g8PLDtxNK8IaBdd4sfHWdCZDjTPtPWVR6shxpa+
         omSGsZ6x8Mr3N53HACsdWmLU3IOeJohToLw6dyfJawafNSObYjDgyttIyQc9cydmC/oQ
         QexJ/5bvTTIfYw32u9IPEG68w77KiK2jyag0INWm9R+NmxUDDNN5YdfRe5uuL3qNK2De
         43ssdwzoT7bupvtj0u2qxMLSYEXcCHY7X9a98vHXpsWZCyVj7j0SFArbHd56Ui7JZ5AS
         ht/8MJ/BGMqzSTOe1PfR5bM7CJNefkSWXCA6daGhLfZxl2/pOrairBpBZ4vSIAwIyjD3
         tOQg==
X-Gm-Message-State: AOJu0YyhYuWhELNDclCNUXaNl6QmvADceV/gISoIDWOHby+uLA1Q8m4D
	iMCPRHKNQnmLuG2sn+7268tCVj4WAY6CJpfaODCjscQ+U7E3RdHoHuFwDXAP0HrBdzCtsCoSMIg
	ytkG5YOGDUGPql0YCtLre5btlM2mYy0wGfAGL+vxbpFHp1NUA0TRSeYIBgqo=
X-Google-Smtp-Source: AGHT+IEbe40n/brTiMJYQJ2dGBXpFhf9lNJA7z1YrB1L2kvwLeIOSIdBC7Nau4AopWOMaPmWh/VmrG5BmAono/kei91bD/3Fyhna
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:424:14a4:5064 with SMTP id
 e9e14a558f8ab-42f872bc7damr289497125ab.0.1760446406860; Tue, 14 Oct 2025
 05:53:26 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:53:26 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee47c6.050a0220.ac43.0101.GAE@google.com>
Subject: Forwarded: [PATCH] ntfs3: initialize run_lock for $Extend inode records
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ntfs3: initialize run_lock for $Extend inode records
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Inodes from the $Extend directory (NTFS system metadata files) were not
having their run_lock rwsem initialized. These inodes are assigned
ntfs_file_inode_operations but skip the normal S_ISREG initialization
path where run_lock is initialized.

When operations like truncate are called on these inodes, the code
attempts to acquire the uninitialized run_lock, triggering lockdep
warnings about using non-static keys.

Initialize run_lock for $Extend records to match the initialization done
for regular files.

Reported-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ntfs3/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..180cd984339b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -472,6 +472,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		/* Records in $Extend are not a files or general directories. */
 		inode->i_op = &ntfs_file_inode_operations;
 		mode = S_IFREG;
+		init_rwsem(&ni->file.run_lock);
 	} else {
 		err = -EINVAL;
 		goto out;
-- 
2.43.0


