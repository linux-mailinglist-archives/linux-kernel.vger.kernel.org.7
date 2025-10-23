Return-Path: <linux-kernel+bounces-866842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C76C00CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928AF3AD614
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734C2FFDEA;
	Thu, 23 Oct 2025 11:35:41 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F16222564
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219340; cv=none; b=LWBE6o5Djcex2npJjOnFYOom/JxcY5WgcEhWtv3x+WDcLfsFrc3r6esqc5OoesRaRoCZBHxPOekUjHIcjt5Lgak1bOQ/TnUfi+TD/ctqBa99qbYQ1TAPPo7VPBF5kbTzAsaZ/7iiUAZclz4662bUu6/4MmtlFhf/5UybOiCIfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219340; c=relaxed/simple;
	bh=e0+IDdt+/8qv4HkcSGbhOs8HD8GleWSmToCjaho3FT0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=glcH1vtRt/VIT/YKDEDXHYtnV86imEy3kYarnkHIL2GKuu7wVMhkDexnOV1iKsC9iP6CfRL9zew93b0NSmkx8d0To+eup3fjESXB0FfaTLFhq3fqJzHB3GUiZOE23pBLzIezCnuSBII7xbcQ4NhLzNae15Hbdc222YhwKP1yPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so223025839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219338; x=1761824138;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MelhfZEB566sHkE9CfFD2NmXEFdLbtUEvpHDL449hZY=;
        b=dII0qGZEz9GBCxhSsTu0d5E2Iy8eBSsHxduwobz3wfwSB9rstWOJXm6EhFy3+tOPji
         srku1TrncIktG+ZTbD3WjIhwlIPlEaI+1OOKk9qPSlDIUUQtUK89dcFHJaO9CUgw3OE7
         kpyw9Ud6E1dzhM1ORl6VWSHTq89O/dBCM5QS5Yomt5YMgVDlhALjXbXzalLkEi1n1jFA
         E9PSNAxbcXhsCcMcrH9q6anhtcaa3JnUmFus7b1x649OkvyivaCVT7W/+JN7Aea/iI06
         f0aharRya71Oi25XF2lSVfPyr/lyYtxYDtocW5/1hM/9f7cpLW51CeRt/ouhuvqPi9Ly
         RigQ==
X-Gm-Message-State: AOJu0YzciYt+JKnAy3pcPPozKYxo/0oekzqdXOvXAAd+tvyOjkBTPdmI
	vzHf+Z/glWdPRvKHYq2zr675bqFKxBFaDADADGqcf6QbpUME2wc5GAAM+eJFs+w9zHOpsr2LhrG
	y//0KDiRTfaQ9YNdBLeSAC1pfdYrDX/C9xSNpKaH0vQWPaVEx7yMbz5Cxuys=
X-Google-Smtp-Source: AGHT+IGrddiNN3S4W7+qN6CetfxHlHOABF+w7c4shivmirv7ThlHZfI8Thtp0Y6KrqD6nQtzDc6vrP5518pwAgKy33Ak4Rpv/Zai
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a11:b0:431:d678:fcb with SMTP id
 e9e14a558f8ab-431d7326896mr67543025ab.9.1761219338408; Thu, 23 Oct 2025
 04:35:38 -0700 (PDT)
Date: Thu, 23 Oct 2025 04:35:38 -0700
In-Reply-To: <675e5ede.050a0220.37aaf.00ed.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa130a.050a0220.346f24.0077.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
Author: dmantipov@yandex.ru

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..60ff8b3068d1 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -859,23 +859,37 @@ static int ocfs2_wipe_inode(struct inode *inode,
 		}
 	}
 
-	/* we do this while holding the orphan dir lock because we
-	 * don't want recovery being run from another node to try an
-	 * inode delete underneath us -- this will result in two nodes
-	 * truncating the same file! */
-	status = ocfs2_truncate_for_delete(osb, inode, di_bh);
-	if (status < 0) {
-		mlog_errno(status);
-		goto bail_unlock_dir;
-	}
-
-	/* Remove any dir index tree */
-	if (S_ISDIR(inode->i_mode)) {
-		status = ocfs2_dx_dir_truncate(inode, di_bh);
+	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		/* Short circuit for an inode with inline data,
+		 * do this just like in ocfs2_truncate_file().
+		 */
+		unmap_mapping_range(inode->i_mapping, PAGE_SIZE - 1, 0, 1);
+		truncate_inode_pages(inode->i_mapping, 0);
+		status = ocfs2_truncate_inline(inode, di_bh, 0,
+					       i_size_read(inode), 1);
 		if (status) {
+			mlog_errno(status);
+			goto bail;
+		}
+	} else {
+		/* we do this while holding the orphan dir lock because we
+		 * don't want recovery being run from another node to try an
+		 * inode delete underneath us -- this will result in two nodes
+		 * truncating the same file! */
+		status = ocfs2_truncate_for_delete(osb, inode, di_bh);
+		if (status < 0) {
 			mlog_errno(status);
 			goto bail_unlock_dir;
 		}
+
+		/* Remove any dir index tree */
+		if (S_ISDIR(inode->i_mode)) {
+			status = ocfs2_dx_dir_truncate(inode, di_bh);
+			if (status) {
+				mlog_errno(status);
+				goto bail_unlock_dir;
+			}
+		}
 	}
 
 	/*Free extended attribute resources associated with this inode.*/

