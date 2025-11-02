Return-Path: <linux-kernel+bounces-881839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DEAC2909D
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55F23AD322
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1C2236FD;
	Sun,  2 Nov 2025 14:56:41 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F7E555
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095401; cv=none; b=R7R5cPTMDZf2crM/o8tj50LSKrQP/fxpcxCDxLF9QBr//ao0/brezCSEheT0pEYLfpDX9W8XR2KIc/yAdKFoX/e+uVkuJGjbu9zjKjRk7U7jA2BcYJjf0vdhH359O2dL12rH2hCKEMS6Wps6Ay18qkFPPLfMTRV0+x9na9Aj94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095401; c=relaxed/simple;
	bh=JaoJPGRUtwpCMkrmZPNmOtEuxsF52Ext86L+14IrcxA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RCM6x2s8t4+2tYS5zRpN0j49SzmVPoOMDw5+U9fISxGCB1eumf4ENv4Bs2QpRYorg6UhkgwWZnU3uE3JuNwyAb+vUafUA3dRxgVtCAhGWIwAUWdWq9y3vGsUs3FSvfEpbSBdxeWuiOvlW4tJaMfzvk6SMpc4ZOped10Z3jH99qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43321627eabso56161845ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 06:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762095399; x=1762700199;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCzN/OKAI/d+RhcGHL8OyS8BRPptFXoLgo6Qiq8kwtw=;
        b=inFlE9hrB/O1cONVA894o9BYUlqBkdf0+asUcPblVpZrTcQ47Xq9DiABrl9++1EwB8
         02yOdDyUhynnc1SCsIveXqzN9xeH/qXPNp2sMFhE+M2nBLUoYIDA6klVyNOD1+9L3WSZ
         R9YXuraNBKnDcVEt/h2gtmsvMyqhc+li9d2e5RvRoDnblMJr+zzyAdE9fOsEowhkrUo2
         OvMx7FUDX8DqsmSW703kgAOwdQbnUTKi7UGQuQWMSlkCa3y57adZTCpbWXQkjiOi2uds
         thnsRneTloLoKgdgDvIjD60eLX+lDJwkwaWX2sK+gKtbt7VxU/tiq/8Xlndd433R5FxV
         bDYw==
X-Gm-Message-State: AOJu0Yyb9rgbMtUGfO7XnIeSriYZHECydyreJ0uAeLQWuA7GFRxUMf1M
	CsFCSCO54ys5dHDp+bdGcmN8wydZMqisVL7selBxoMMPr/6YKQdsrGv8nUg3HBiKqVQl6IdK9CL
	pZWIvssHOdSI+AkrUxKoGf7oTLC7jYKlkmbyT4Cx8WGksCf3wXsTT/CDXH/U=
X-Google-Smtp-Source: AGHT+IHH4KhLbnMzdr0YWp1yNJZfZ0O7arMvJ0cUIn3+aQsg0fD1ddTL8PcRG5E/qFswgnzU2M18wJCWK0QNwd6DUKEenseZq7UU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:430:a530:ede2 with SMTP id
 e9e14a558f8ab-4330d1db6a3mr120157365ab.24.1762095399149; Sun, 02 Nov 2025
 06:56:39 -0800 (PST)
Date: Sun, 02 Nov 2025 06:56:39 -0800
In-Reply-To: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69077127.050a0220.29fc44.0023.GAE@google.com>
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
index a8d5a7e22b7b..8648d860ef0c 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -218,6 +218,13 @@ static int minix_rename(struct mnt_idmap *idmap,
                if (dir_de && !minix_empty_dir(new_inode))
                        goto out_dir;
 
+               err = -EFSCORRUPTED;
+               if (dir_de && new_inode->i_nlink != 2) {
+                       printk(KERN_CRIT "minix-fs error: directory inode has "
+                              "corrupted nlink");
+                       goto out_dir;
+               }
+
                err = -ENOENT;
                new_de = minix_find_entry(new_dentry, &new_folio);
                if (!new_de)

