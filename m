Return-Path: <linux-kernel+bounces-838617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC35BAFBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC83D3A89D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9A2D876A;
	Wed,  1 Oct 2025 08:59:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BD17A2FC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309148; cv=none; b=GPW7z2ZatlRLWjQQKjATyPpLH7dcy43qtgKZyKPeG706uDWwH4jOx6GLw7vKOCKDpqvUKdhHYAm2WbQQg0Q7iy3OpB5t1r6gerCjcJmleFaemYydzGn8BrTrAiglzflOGnF2FJ3AS8X1WFkR3lB1k0wnyUZr1IJVwGYxKGJAkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309148; c=relaxed/simple;
	bh=pKSeD1yQbxWfwIkzPuax838bf9a0PUsuhLbY7KhUVSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AAeus9eRy50EMeZhFdhzi203xwgxVDzY8s3lYcut4pE9dw6APHDmRPxQEmzD0/CkYboTh7cuWj0CxXIZEiGsBmPuvF5AZfVjF4rmDnkFRUWkVGvcPiXC+UpqkAYfG0czlqF1cAHyGG7ow5hPI+t3I63drWMdhr/+TBh4a6vGTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-90efeb58159so689044339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309144; x=1759913944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1KfB6y2C45OVMbOJIacD6RmSooTpGw9Rdm3Od/mOis=;
        b=bKmn8Z4E762qKlY6bYovxkubhs5jBiDgGMdIBHQFLdKwl4ZXqgXQeMVheJ1H/T4iqk
         IYlYiepEKWF43QeIKADZX5fiydrkEySQWLPWRuEcrOCMfm4u3gCji42rUvGwPlk3Uqhr
         UHAwZo21G3zEtAt1xQYB/zYDM1AAO4pHWGvfpdrnDjNVTRGKflvvyuOGqe6FQ0Nyofk5
         XA2fjGIzEqRkmKDBGbSQNdKK5y9RAVTIU7sCeq6ACcsn0XvPb2GKi3ofXXZF+47gKbDI
         6CQ06TC8WIhNxrv9O+RpexEukgFQYfoU5BPlBQFp18Q4VURlu9nakLOGk0CbTldEBL27
         FMow==
X-Gm-Message-State: AOJu0YzJoK7Fv3ewg1Ae7F6F+je49dJftKjpfzbf1K6OdnoP6XOQzWLg
	dmKKA+TGNWJxPgvCNYKB/k4hukrPQs8ZmoFXkPVFC0Q4N7XYDEIDy60CWDNrAL5JGnZtOKkkINg
	YI8CFNl8px0brpBY3dhzFdu1wXH9rI0YWFbNwBVdnm/CLotmKwAIip0ke9Qc=
X-Google-Smtp-Source: AGHT+IFSQK8OA1WgNOdtLLGQC/ooKbzck8t158+sLp7rTMw99P7+bQawh6NBqiGcsF2MOukFIlND1Pza667OdJUdYL5D7jQVZabb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:608d:b0:8e0:f662:69e6 with SMTP id
 ca18e2360f4ac-937ac92ddebmr395219939f.11.1759309144246; Wed, 01 Oct 2025
 01:59:04 -0700 (PDT)
Date: Wed, 01 Oct 2025 01:59:04 -0700
In-Reply-To: <68dc3ade.a70a0220.10c4b.015d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dced58.050a0220.25d7ab.0774.GAE@google.com>
Subject: Forwarded: [PATCH] isofs: fix inode leak caused by disconnected
 dentries from exportfs
From: syzbot <syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

When open_by_handle_at() is used with iso9660 filesystems, exportfs
creates disconnected dentries during file handle resolution. If the
operation fails (e.g., with -ESTALE during reconnect_path()), these
dentries remain cached with their associated inodes.

During unmount, shrink_dcache_for_umount() does not fully evict these
disconnected dentries, leaving their inodes with non-zero reference
counts. This triggers the "VFS: Busy inodes after unmount" warning
and causes inode leaks that accumulate across mount/unmount cycles.

The issue occurs because:
1. open_by_handle_at() calls exportfs_decode_fh_raw() to resolve
   file handles
2. For iso9660 with Joliet extensions, this creates disconnected
   dentries for both primary (iso9660) and secondary (Joliet) root
   inodes
3. When path reconnection fails with -ESTALE, the dentries are left
   in DCACHE_DISCONNECTED state
4. shrink_dcache_for_umount() in generic_shutdown_super() does not
   aggressively evict these disconnected dentries
5. The associated inodes (typically root inodes 1792 and 1807)
   remain with i_count=1, triggering the busy inode check

Add explicit shrink_dcache_sb() call in isofs_put_super() to ensure
all cached dentries, including disconnected ones created by exportfs
operations, are released before the superblock is destroyed.

Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/isofs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 6f0e6b19383c..bee410705442 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -52,6 +52,7 @@ static int isofs_dentry_cmp_ms(const struct dentry *dentry,
 static void isofs_put_super(struct super_block *sb)
 {
 	struct isofs_sb_info *sbi = ISOFS_SB(sb);
+	shrink_dcache_sb(sb);
 
 #ifdef CONFIG_JOLIET
 	unload_nls(sbi->s_nls_iocharset);
-- 
2.43.0


