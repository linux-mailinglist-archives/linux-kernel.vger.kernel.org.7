Return-Path: <linux-kernel+bounces-881905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2277C292FE
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A6F1886DF0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368C236A8B;
	Sun,  2 Nov 2025 16:58:47 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F961C831A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102727; cv=none; b=lohbzvlDfdnIKzDOLq5nhAQp21phyPT2sZwtJxfcSFBbB8RtCpjsrNrtfiqiYAtEIycD3ZOPWdEEiXglzoQrTioXb4ou7OlRLhK4HWILu3r4mybU2hWegQ+rTlojGih/eshM6A8eFMbP/waKOzheJ+lQzBZlG7T+BIiMtGtnrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102727; c=relaxed/simple;
	bh=PoJ+nVdjMAluBGm9l7uzac3U4SL7UqJ3hkfNnU3bmiM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qwoh/hltTfhKmBbnLKa6R4n3xTJSJe0g4xy44Jn6ruyUdQrPoJNpwr28IDW6ZWgx5g9cex7+AcZ3CqeA7jUMEe/MQFw82PMkmNl8d6zD0A0sA5D82m+htRCxba4qZEJnLvp9jN/Wt9KaufzsmXpOYaKuqyPI4b/6yeY5rwDRBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4332ae73d5cso3425115ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762102725; x=1762707525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzdt67tmQZKq3cVbvIq82eNOZLydNznzL8tUZ33qvOc=;
        b=gGHPVdkbfXZMKyvKy+awVNn4OLG+3N+cQTBwT0NMaeIZbgPAu5DKakasVY5/CH3xCc
         oDp8fvCUdbVtz8y61lHVzfJzoYadk1cdTh+Ur+QNs3XeUaFoISII/6Hf6EHoBY1fAfEF
         XbwxsXPZgvxB4uBlFkr5G1ni6RVhK/Pbv8O15QeGquUjeuJ9XuqfVpw6/6w1jLfH6tnY
         7+7RJJLNOdgBy4wc7orF4M2+Ib+p6uyrp1jlOKPmnyZtcz1itRC72IxayAIOcLGheWlJ
         l6UTbRlldMHOWJa7cjAT4e68RDuiJC6+2q4MI8URUgyHW80nhaiC4X2dVvCbTy71GRD1
         zJww==
X-Gm-Message-State: AOJu0YydjbOxKyL5nDjbV0b8EqLbm6ovAoE43alxTyYFdUJAmwOX4IPw
	OIntKFMkYGgQCiNSw8hDSxVp5C5grJNYts/y/ce8KbrF1624XwLAjdlvipCY47nkTkAPEQZHqec
	ccIMq1Vug7QRt1hgr0miIRyDrknFkGoWml1HnmFk8a6bhgs6c11CrZ0pFIXY=
X-Google-Smtp-Source: AGHT+IFNPU8JPHId17PvEx8yVVt7QefVKPCIuQq9zFcTcxCP0B8NogrsclTnP2AOIMV913Gok14hj/VGgNK5f7WGzZJaRCcaBPxI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2581:b0:433:30d7:7ab4 with SMTP id
 e9e14a558f8ab-43330d77cb8mr5593525ab.26.1762102724925; Sun, 02 Nov 2025
 08:58:44 -0800 (PST)
Date: Sun, 02 Nov 2025 08:58:44 -0800
In-Reply-To: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69078dc4.050a0220.29fc44.0028.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d54273c3c9ff..ce62cb61186d 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -168,4 +168,6 @@ static inline int minix_test_bit(int nr, const void *vaddr)
 
 #endif
 
+#define EFSCORRUPTED   EUCLEAN         /* Filesystem is corrupted */
+
 #endif /* FS_MINIX_H */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index a8d5a7e22b7b..f18f7474aca4 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -145,6 +145,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
        struct minix_dir_entry * de;
        int err;
 
+       if (inode->i_nlink < 1) {
+               printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
+                      "has corrupted nlink", inode->i_ino);
+               return -EFSCORRUPTED;
+       }
+
        de = minix_find_entry(dentry, &folio);
        if (!de)
                return -ENOENT;
@@ -218,6 +224,13 @@ static int minix_rename(struct mnt_idmap *idmap,
                if (dir_de && !minix_empty_dir(new_inode))
                        goto out_dir;
 
+               err = -EFSCORRUPTED;
+               if (new_inode->i_nlink == 0 || (dir_de && new_inode->i_nlink != 2)) {
+                       printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
+                              "has corrupted nlink", new_inode->i_ino);
+                       goto out_dir;
+               }
+
                err = -ENOENT;
                new_de = minix_find_entry(new_dentry, &new_folio);
                if (!new_de)

