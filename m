Return-Path: <linux-kernel+bounces-884158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA4C2F7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D675F189C501
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587318D65C;
	Tue,  4 Nov 2025 06:47:51 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8ADDD2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238871; cv=none; b=IwGTgvZJJCVxrbk+RpNDLNvPjubTOU9Knojt5gjPS5VZf+1qruqJFavjmtpejal2UPNhBR9qQbZyy3iLOS9dIyV2iGcNsIhIUwnr+0Z2bBDbVyZvDYihUxp9SCzoEuK+C0h1gy/Iin9VtVYauIcSU5RJnSz/nc/W7srvnc50o2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238871; c=relaxed/simple;
	bh=ddf86FLLLeKZL/xNVRS7TYqL2ik954LfaUZYObQwM14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HKp5nQGetrSFKjwd+y5EmLl8HQgLUDMA3sRVdOn8UbYBL5dafB+EkOiwGDXxHHsU+k48CVVTpVsSA43MV281ML4+yAZK1UxVd5RjupNGE9hQkuJG6+wL07WvZ6M1b1Otf+CuN2TkjvUojj4TZu/tNw7PFZ6lI6RA+kvLSRF7k2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-940d395fd10so1570891039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238868; x=1762843668;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APjmYikMLEovXv1fpum5IiN+eRIx17kDAdhcoab6tuI=;
        b=i7AkEBjXmV5q+oUQI9rj8ZzcSsKpjVQukA3ldFXHtTd5mtIYqbwDqmJQaxRYmxabSQ
         lrxyEpno3HTEb+eZsrCUwiJxKuC4f79x4C9wrIPVByaZd8kiZ/+g3+RmgLFpd7cCbv7q
         LLsP0EtsU0lxekfLpCAumq6x3RmAt5gCaLU122nzp95WP2LsxqEvJaVzFW82Ld77KW9V
         Yne1pct1SsgUn63l2OOW6Wdws/upd1aBg715xr5zioKyt1i3Cme2VPWbhJG+cj8TcNIq
         XGb7pJgmFt4c2Ikq+rRWN8TyFNf4GqAYwV26KC6FWWTBcCNRnzlPdcEfnDLNCdb+Uk2o
         CJ3g==
X-Gm-Message-State: AOJu0Yz5HbIE06x1S5u4nXYgebiOiGmJ/MOxJW/z1ekf5Ylsn/fKe/Hr
	HHZiashRDyoB/isITfKGlRc42V5IJwmWjXYGEhorjH2POOPzmA/O1I9+ltv+TGmIQOEACB+gfGe
	HQZFzuNoM98CjBzHAlAf8Q4Gr137mAoSsVwBc1WP76cd6HUZrbWIS3lbWUN2TkA==
X-Google-Smtp-Source: AGHT+IF80X6P2ZOXlS0miIeO5z6zAwSEgaodVszLT3m4nJL6yOAN5OMAg0IZaCgq4j0cn4UMo/Clj8M4j6u/YDgHWHO0TsL6q6JZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c92:b0:945:a58e:ba03 with SMTP id
 ca18e2360f4ac-948229a4807mr2294200539f.8.1762238868708; Mon, 03 Nov 2025
 22:47:48 -0800 (PST)
Date: Mon, 03 Nov 2025 22:47:48 -0800
In-Reply-To: <6903e832.050a0220.3344a1.044e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6909a194.050a0220.98a6.00a0.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [ntfs3?] WARNING in ni_rename (2)
From: syzbot <syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename (2)
Author: listout@listout.xyz

On 30.10.2025 15:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e53642b87a4f Merge tag 'v6.18-rc3-smb-server-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ca5932580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d8e30dbafb5c1260479
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17273fe2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15374fe2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c69a7713b158/disk-e53642b8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7138dd74fe48/vmlinux-e53642b8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e715eea6ae3e/bzImage-e53642b8.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/cd997f980581/mount_0.gz
> 
> The issue was bisected to:
> 
> commit d2d6422f8bd17c6bb205133e290625a564194496
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Fri Sep 6 10:59:04 2024 +0000
> 
>     x86: Allow to enable PREEMPT_RT.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e84e14580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e84e14580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e84e14580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

#syz test

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..d9cca094960b 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3023,6 +3023,18 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	/*
 	 * Way 1 - Add new + remove old.
 	 */
+	struct inode *dir_inode = &dir_ni->vfs_inode;
+	struct inode *new_dir_inode = &new_dir_ni->vfs_inode;
+
+	if (dir_inode == new_dir_inode) {
+		inode_lock(dir_inode);
+	} else if (dir_inode < new_dir_inode) {
+		inode_lock(dir_inode);
+		inode_lock(new_dir_inode);
+	} else {
+		inode_lock(new_dir_inode);
+		inode_lock(dir_inode);
+	}
 	err = ni_add_name(new_dir_ni, ni, new_de);
 	if (!err) {
 		err = ni_remove_name(dir_ni, ni, de, &de2, &undo);
@@ -3042,6 +3054,13 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	 *	}
 	 */
 
+	if (dir_inode == new_dir_inode) {
+		inode_unlock(dir_inode);
+	} else {
+		inode_unlock(dir_inode);
+		inode_unlock(new_dir_inode);
+	}
+
 	return err;
 }
 

-- 
Regards,
listout

