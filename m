Return-Path: <linux-kernel+bounces-825978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00CB8D40B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56CB189A2ED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48626239E65;
	Sun, 21 Sep 2025 03:19:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD461C84DC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424750; cv=none; b=PHnhZElh7DSbtJ2wpEddQR+raW2T1dQT2k8p5+DcCzwOEvhSnubq3BhZEK2LzYwTgEPb0TFT8XVbbhflM5+9xKdPHiBwKw3vCaJVCZrsv4MrNSJdwvf7FcOQRQX9yx9TqFdfzb++h/U4G+3Nqc4M5p6gp1lPK7R0bgHHq4q17Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424750; c=relaxed/simple;
	bh=gNN+aMOzEFbSUKRsK21R8dPuZqG4pliuplC0oJtvMs0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZERoy0wplIMvwd0Nz+S4EpoWlZBvFFdQ4XIshHvVQ/PhyLA2k5/prnDrBwPfmlny6rURWt4vaN/GW8qjPpGotAj48limkHopWzXoWYY3eEMwSvW25T7LmmDf31YLgCpcyMfRluP3T+C3rEsxoPCCGdOOgXg46HJrgbc/EF54K+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4240926dcd1so46565975ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758424748; x=1759029548;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajb2v52eqLx5lxNtMtfhRpvrbjYWdz6Tn3XecePJ9bc=;
        b=qweLbrvY0+52tiehmDuIWCPauJ4cMoHzpm32qudd2rHVyIMjoEGkv+DopeE7zSJ9FU
         nxYL1zsrMK3Fsl9rfpyaQldjTuaIRoIZ+AmMP/NL/htKRX+wm1zGrpENV+fU7pq0WMw+
         rG0UkdcNh8W+9lzNki7xnTezOtLKkRu3quuvuSQ9jrjoSpxbOHdk7vr/VyPYAyeMOpvp
         vgVjXLxhRiLV/mDwcVZN1sLo4CvyWIN8NkHldy/U42Lm2U6NWN3dcgOA2agAX5VxQkqX
         G83qYLfLJsgvwAHDYQ/3QblaiHtcYdbpY62mihsr0RfNGKnpeNZbe42BFYJIimmhWNiq
         prvQ==
X-Gm-Message-State: AOJu0Yy6wOWQ5+mtCakV67RaSF2lm2us6muof1LcRLl9bCaLFNk+uvdK
	dHpi9EcCtTUUMcrCdVGe/dCEDYzYjKmX99h4u56wS2wAQ+3hD22zJbuX52JXn+5IYCCkSh/5PaQ
	vLPUK6KIHjbeTr4W2uqgThtl5Y43lTlW+SSnBVATd3gNIzw9vIGYe4EfsHaY=
X-Google-Smtp-Source: AGHT+IE7NJvdg2CsYO42AtH7hOOaA9MBfwKejmUeBQKSWyWtg53RXKvbgYh+YJtvHwOjgf47L9N1u+QYFGeOgI6R6h7wf2TspWmI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:40b:db4:839b with SMTP id
 e9e14a558f8ab-4248190391bmr122081815ab.5.1758424748341; Sat, 20 Sep 2025
 20:19:08 -0700 (PDT)
Date: Sat, 20 Sep 2025 20:19:08 -0700
In-Reply-To: <68cdf1ae.a00a0220.37dadf.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf6eac.a00a0220.37dadf.0035.GAE@google.com>
Subject: Forwarded: [PATCH] nsfs: reject file handles with invalid inode number
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] nsfs: reject file handles with invalid inode number
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Reject nsfs file handles that claim to have inode number 0, as no
legitimate namespace can have inode 0. This prevents a warning in
nsfs_fh_to_dentry() when open_by_handle_at() is called with malformed
file handles.

The issue occurs when userspace provides a file handle with valid
namespace type and ID but claims the namespace has inode number 0.
The namespace lookup succeeds but triggers VFS_WARN_ON_ONCE() when
comparing the real inode number against the impossible claim of 0.

Since inode 0 is reserved in all filesystems and no namespace can
legitimately have inode 0, we can safely reject such handles early
to prevent reaching the consistency check that triggers the warning.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..42672cec293c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -469,7 +469,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 	if (fh_len < NSFS_FID_SIZE_U32_VER0)
 		return NULL;
-
+	if (fid->ns_inum == 0)
+		return NULL;
 	/* Check that any trailing bytes are zero. */
 	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
 	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
-- 
2.43.0


