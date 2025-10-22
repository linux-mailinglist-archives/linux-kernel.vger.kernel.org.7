Return-Path: <linux-kernel+bounces-865522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86431BFD4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CA618849B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CE280CFB;
	Wed, 22 Oct 2025 16:31:01 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADF280CE5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150660; cv=none; b=lfGM2LZkNqP10Rseze8P9dv2Wm5VdfD+ZPXwIrLqBEBjlHq0sx/rbo0gp/yw1uMNzr1rLFzMYVil/5yH7EfGURu9MbypU974VYYuV7dmJBZ7izqhDRsValFJiSZlUSoWNAEFJnKd5my9jGGjjp11egONeT7MTX9fCBPA2TQbjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150660; c=relaxed/simple;
	bh=sVgFhZF0xc0JqHBjwoSgHECr9ptUnJhN3xjrC3rgT5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CLqLBQWJCKdCsa21e0rWsslIAqGobNPfxYHqk5iXaLaSk9lIUqVsnpB5t7Zr93HgaueMJVnUMyfOH/NVoIrnbfsYb5UAbWf1Qah6L9m/UyiDClq459ERSBoU4yQewaOKx4tO9khWDRFs8wDbOzdYm9oVh1/5OvdRqvsxOoXPL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430e67e2427so40443295ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150657; x=1761755457;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL3HtsZmLoh1JCezgxkVTr7Dw8wzkzZqEz7d/kBb4Mo=;
        b=CmIrMaV4tusPLqcRELhDPRpVt1syIUEWVjx8/kqTSAfcp0Mz/aD9eDMdyGvH2JPTyi
         yn23ptccz4eNk6QCWM2IYGX75kOrixVqbr7nRDiOlKB/qWWvF22dkY9l7NeSEwPrThW4
         jFPxyaNQm2vBJ1FSYCkgJ2wF9mkqoBUHgRswBWeKDoaq56DJJq8VhuKr7p/lqp45NSPU
         EKxLM5+SnZ1l2ZSMWGlo9lCKMIDR6aho6TOZUev8kpwlAmzmCXrrwPvmpIUDGyZQLe9V
         uJir6QbGGJNmlih9vvMxUfkotAOYExG8YhgFzKUG5GMnE+hn51f6cbWxHQJervSHGd1o
         iOhw==
X-Gm-Message-State: AOJu0YzANVUsXIVrwyUFE0ugM9OXx7GZDyNSMkFde1A2n6lcHDRgY3xG
	EnWhd2gs/P765kO0DvZ4qam4hD2mO/5N++3IXFMnDaOFzvQFYsDMxsx8leevKM4P7I82LNt6iIo
	WDUjgZ10UH5kIunVE+uRVlI07LkP3k38uHc6QcREE5L4B25C+MHD5/pLO3ZA=
X-Google-Smtp-Source: AGHT+IHMe3wmzMQA1jgcgPMvPImZKtztTEMINzbV3Kg0RG3RKQOJKBJdDSUYH+T8r8hEuGz89I5CCLpqUnuOjsVp6BmXnJps9VGd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3086:b0:431:d83a:9a8 with SMTP id
 e9e14a558f8ab-431d83a0c8cmr23141575ab.25.1761150657313; Wed, 22 Oct 2025
 09:30:57 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:30:57 -0700
In-Reply-To: <68ed75c7.050a0220.91a22.01ef.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f906c1.050a0220.346f24.005b.GAE@google.com>
Subject: Forwarded: [PATCH] f2fs: invalidate dentry cache on failed whiteout creation
From: syzbot <syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] f2fs: invalidate dentry cache on failed whiteout creation
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master

F2FS can mount filesystems with corrupted directory depth values that
get runtime-clamped to MAX_DIR_HASH_DEPTH. When RENAME_WHITEOUT
operations are performed on such directories, f2fs_rename performs
directory modifications (updating target entry and deleting source
entry) before attempting to add the whiteout entry via f2fs_add_link.

If f2fs_add_link fails due to the corrupted directory structure, the
function returns an error to VFS, but the partial directory
modifications have already been committed to disk. VFS assumes the
entire rename operation failed and does not update the dentry cache,
leaving stale mappings.

This causes subsequent operations to use cached dentry information that
no longer matches the on-disk state. When a second rename targets the
same entry, VFS attempts to decrement i_nlink on the stale inode, which
may already have i_nlink=3D0, triggering a WARNING in drop_nlink().

Example sequence:
1. First rename (RENAME_WHITEOUT): file2 =E2=86=92 file1
   - f2fs updates file1 entry on disk (points to inode 8)
   - f2fs deletes file2 entry on disk
   - f2fs_add_link(whiteout) fails (corrupted directory)
   - Returns error to VFS
   - VFS cache still has: file1 =E2=86=92 inode 7 (stale!)

2. Second rename: file3 =E2=86=92 file1
   - VFS uses stale cache: file1 =E2=86=92 inode 7
   - Tries to drop_nlink on inode 7 (i_nlink already 0)
   - WARNING in drop_nlink()

Fix this by explicitly invalidating old_dentry and new_dentry when
f2fs_add_link fails during whiteout creation. This forces VFS to
refresh from disk on subsequent operations, ensuring cache consistency
even when the rename partially succeeds.

Reproducer:
1. Mount F2FS image with corrupted i_current_depth
2. renameat2(file2, file1, RENAME_WHITEOUT)
3. renameat2(file3, file1, 0)
4. System triggers WARNING in drop_nlink()

Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D632cf32276a9a564188d
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/f2fs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..712479b7b93d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1053,9 +1053,11 @@ static int f2fs_rename(struct mnt_idmap *idmap, stru=
ct inode *old_dir,
 	if (whiteout) {
 		set_inode_flag(whiteout, FI_INC_LINK);
 		err =3D f2fs_add_link(old_dentry, whiteout);
-		if (err)
+		if (err) {
+			d_invalidate(old_dentry);
+			d_invalidate(new_dentry);
 			goto put_out_dir;
-
+		}
 		spin_lock(&whiteout->i_lock);
 		whiteout->i_state &=3D ~I_LINKABLE;
 		spin_unlock(&whiteout->i_lock);
--=20
2.43.0


