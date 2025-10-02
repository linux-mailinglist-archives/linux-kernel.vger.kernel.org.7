Return-Path: <linux-kernel+bounces-840850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD58BB5943
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6550D3ACD9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B22272801;
	Thu,  2 Oct 2025 22:57:54 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4A18027
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445874; cv=none; b=qhgj2e9F6UVUEtAq8l2R1JXCelQ+LMVyEZpyVqN4C48CUP71BNPVwIpjoWqOV/ZR4PVAxlKDD9RDOpAxud4FcI6Vu/12QSjHvQqidsxOFbErfYVXBfogf6WbKIqCaqLZ96pwinrc8gdgerBojouk+1m2j2ODCnRV+htrPGTxUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445874; c=relaxed/simple;
	bh=P6cyOAqNT4ozAYoB0GDWos+mD0gm2Dwy7mUIuTpXyjM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nqQ4P8yxQUvx7MSozUikTXzqckx5hc+Kpt4M0YrJkgaRmLrtLG0rmhyoNUSLMk5caUV421TuDjTafpH16HMUNuYvW909j0CNy841LJYFWcbTZdrNJtg5BxrY+gHjD8D+0mX4beCA6zce3+kCGXZB0UtTxuCzBV7pR1KHnEyMSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90efeb58159so190863539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 15:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445872; x=1760050672;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pvTXx6ez5iaZ3EJHSfXZah/P/awg88YzgkmbpLknGI=;
        b=N2yByupFhLzy8lHpdZcQZeCLXLlFS7ESjaRPdDRh139SOsRrXThVSla1ePodUTYqdx
         I0bmyRy6iNXsqH26kJTA4YyrPTYvVCIP1eq4H+SR+n4HLcPoTo6aSpcpoCFq8DcZD7v5
         q3rpXT0u5mU1kZacBNIRa9X9NqyDSAomvr19Bja4nbelJsJdprrpMSfDZX5h3NR2Rdpq
         8rgdzbzhYUPLajCPeMnI+VV88odUxywiDuQOmPAx585zM+PFbIwGUgGxFOb9frPoj5C+
         oMIhCCkeZJuX5KpVjobkxkdw8EXnwRsluMZCPmS5M+NOKHUC/2rVb5psutC6i9A9b7fI
         h5FA==
X-Gm-Message-State: AOJu0YyNi6pZCkiduWkDnQ9bDTupJrRjcXTQeLVOfQ4K+2JsU2rAAuIf
	YvZ/vkE1FRDjPITEdFNoboSCOLUImJ/D97dFMNm7gY8rgYt1XU5TiMbbbzQRi8rjgSRl7bRw75m
	E+bxXQR6wux68PNQoxwP0I5tLhedjNNNjw2xO8TiyPw8B0eKMSNrfyZ6KryM=
X-Google-Smtp-Source: AGHT+IEB+6/jLtbiP17fNpNDonaPeN6wQR3Jx9lAyl2CHjFs0XSj1jHP0N2NiQ37dmEjJhduQATshBOHRBSo2DP6U2m0qaHLIuEh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1447:b0:42e:712e:528c with SMTP id
 e9e14a558f8ab-42e7ad845e3mr10791745ab.19.1759445872071; Thu, 02 Oct 2025
 15:57:52 -0700 (PDT)
Date: Thu, 02 Oct 2025 15:57:52 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df0370.050a0220.2c17c1.0004.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: reject inline data flag when i_extra_isize
 is zero
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: reject inline data flag when i_extra_isize is zero
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Prevent use-after-free in ext4_search_dir by rejecting inodes that
claim to have inline data but have no extra inode space allocated.

ext4 inline data is stored in the extra inode space beyond the
standard 128-byte inode structure. This requires i_extra_isize to be
non-zero to provide space for the system.data xattr that stores the
inline directory entries or file data.

However, a corrupted filesystem can craft an inode with both:
- i_extra_isize == 0 (no extra space)
- EXT4_INODE_INLINE_DATA flag set (claims to use extra space)

This creates a fundamental inconsistency. When i_extra_isize is zero,
ext4_iget() skips calling ext4_iget_extra_inode(), which means the
inline xattr validation in check_xattrs() never runs. Later, when
ext4_find_inline_entry() attempts to access the inline data, it reads
unvalidated and potentially corrupt xattr structures, leading to
out-of-bounds memory access and use-after-free.

Fix this by validating in ext4_iget() that if an inode has the
EXT4_INODE_INLINE_DATA flag set, i_extra_isize must be non-zero.
This catches the corruption at inode load time before any inline
data operations are attempted.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Use ext4_test_inode_flag() instead of ext4_has_inline_data() as
  suggested by Theodore Ts'o, since i_inline_off is not yet initialized
  at this point in ext4_iget()
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..fe30d4192c7d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5417,6 +5417,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		if (ei->i_extra_isize == 0) {
+			if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA)) {
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


