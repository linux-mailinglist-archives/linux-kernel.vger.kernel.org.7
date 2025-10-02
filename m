Return-Path: <linux-kernel+bounces-840879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E6BB5A45
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513971AE4F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68618285412;
	Thu,  2 Oct 2025 23:54:16 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC881A76BC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449256; cv=none; b=uNBv9lbK6W10T3tOfMXmYJYx0EDRMzZxGSijzNHbHLrgHFln+77B1FRtwx3mjillj7YErDAkofnDMSYR1ODpR6fT/Bn+5z0daKLQe7PkMG1A1CdaqrFDdifJnDxC9LHUeybJTOVeIUf+OTLyelTDrvF52R8BvwIYIl8jXqHuuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449256; c=relaxed/simple;
	bh=y4AbbVI2zm9EjatU3Omkf2IF9HL2oH3g5rJ7sXpWV6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gryy1K246+hLB1s2A1vH7W6McBWy+sg235VtdMW6jV21yZ6tgttqB0PddNhOPCDoq7EBRNRUUQ0YDbfS4U/2l7Kfc/lxKqBTHq71MfmqtUmSTt8vzz7iqgd9n95Y2Te4niHsrYVUO6oD1Y1CCEs7m+Yb43Ip2tCAly+YtuYx3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-937ce715b90so358763939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759449253; x=1760054053;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhESs7nhkpLX12DtYICkVgH7hqFw6zMhaYu6P0p5YOY=;
        b=m2vpl5yfesuaSLD7me2Y+ll1FmwIf+z52KvAMXI48hAhe2ezfByxCa2BDtcjYTf6VU
         gK8Xd03EnkIrGzpdM7R8+Tyc2dh+4uzmzlgUzvZKmqBG7V1ZUV+KebPUR4TfPISWGVNa
         GGgg388LdlRciMnF3JBsekJ6EyUCaAQKahFEGo17orSLMLGGWUKHl4MCNcHHxQgjBNGt
         Rawfv4FZdfBrXWfvEECTo1PRJahJeSFG/D6xLQ3A82cCoYpgUfvfhkHAPMtFm07KfoT2
         X67sRDHLEpbgbAudBGKk8M2V1UIM+oOwr1LBG7LOKVvpUIv5rSmvlk6vYFltyxuQrev6
         R+Dg==
X-Gm-Message-State: AOJu0Yy4ymYPPT9X7RqMYf5S9UHzMzk/fYejaAl0EA2SooIwGqL0XDCe
	EnODdHeH0TV3nwMClm3Op1v63KUiIrUxtF6jLqmfFDffBv5JfJ/7tAJGqE1FQsbNChdJ0fxplYd
	DQhfec0yqyKgD4oSN5p5zeoB9ksdla6YGKozbrWeu/mM8LABwa6ltFX6bwi8=
X-Google-Smtp-Source: AGHT+IGue345gCJzI+PsUiEZO1n2wz8wBGvwrbtviOM9pME674NmjDQgwlwDFXQGuoI6RWrv61DTX8JUdAiB4Qo714WBQVupkWhY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6422:b0:917:4cb4:b4cf with SMTP id
 ca18e2360f4ac-93b96a7c06dmr121259339f.6.1759449253601; Thu, 02 Oct 2025
 16:54:13 -0700 (PDT)
Date: Thu, 02 Oct 2025 16:54:13 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df10a5.050a0220.2c17c1.0007.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: reject system.data xattr with external inode storage
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: reject system.data xattr with external inode storage
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Prevent use-after-free in ext4_search_dir by rejecting inline directory
xattr entries that claim to use external inode storage.

ext4 uses the "system.data" xattr to store inline directory entries
within the inode. When an inode has the EXT4_INODE_INLINE_DATA flag set,
the system.data xattr must use inline storage (e_value_inum == 0).

However, a corrupted filesystem can craft a system.data xattr entry with
e_value_inum != 0, creating an inconsistency. The existing validation in
check_xattrs() skips e_value_offs validation when e_value_inum != 0,
allowing a corrupt e_value_offs to pass through unchecked.

Later, when ext4_find_inline_entry() is called, ext4_get_inline_xattr_pos()
reads the corrupt e_value_offs and calculates an inline_start pointer that
can point outside the inode buffer, potentially into freed memory. When
ext4_search_dir() attempts to access this invalid pointer, it results in
a KASAN use-after-free.

Fix this by validating in check_xattrs() that if an inode has the inline
data flag set, the system.data xattr entry must have e_value_inum == 0.
This enforces the consistency between the inode flag and xattr storage
type, catching the corruption at validation time during inode load before
the corrupt pointer can be used.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..d082fff675ac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5417,6 +5417,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		if (ei->i_extra_isize == 0) {
+			if (ext4_has_inline_data(inode)) {
+				ext4_error_inode(inode, function, line, 0,
+						 "inline data flag set but i_extra_isize is zero");
+				ret = -EFSCORRUPTED;
+				goto bad_inode;
+			}
 			/* The extra space is currently unused. Use it. */
 			BUILD_BUG_ON(sizeof(struct ext4_inode) & 3);
 			ei->i_extra_isize = sizeof(struct ext4_inode) -
-- 
2.43.0


