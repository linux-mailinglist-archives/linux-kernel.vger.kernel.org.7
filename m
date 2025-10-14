Return-Path: <linux-kernel+bounces-852027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7ADBD7F80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B72844E5917
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BAE23CE;
	Tue, 14 Oct 2025 07:38:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E199212572
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427527; cv=none; b=CgoShTur9Ayhu/qRXQNcd5MgWxtEqh2DuRp/yPj2sBXjDIk6bHYmVhLSTgxKrUOirJTqAb8hc//1+eK9UNTUN4l4l9LxpkDYXl2P90bBB/szxjevvDRfqxlX/dcoM9iyW3flC3r8gBshkrIPX/ZwGFObvXKmQs270JwhR8OYoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427527; c=relaxed/simple;
	bh=k7NuzTf3FLpUlX7J9beOXhOSBIwIc0vexsMq9IYQx8w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rrHYX3BVy3R9QaZIDmzouyqMVF5I/v2VT6NUGwWWZ7FmvZ6w7fUbQKqMzgnCLUEAyW6bW1+eQW40cQdmLsWtVyOEZOpHdvZm79k6P9SvNpT3YACO0+SPFmUX3sUgJ7O5ZeKqmCAggU1T/Ry5RdQ2feKOHwP0rA74w0aw7HqvCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43095c446dfso19487245ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427525; x=1761032325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWxizGH1oXySXmJCLKFpA1lSsvssfyqipcMSdPAIFqk=;
        b=ZRJp5y5nwy/Q8xIiXB9dvusk+vj7kcKMp4/ZWL/jn5h47rNxDAlqmyS/imulcf6Bjm
         W6moyqT5Y0l+fhlcURPuUtmMRam28eCQ7fHDMiHrPaEe2BC8sDMujQ7afqgQCSZh7ka0
         dR9M9U1f+P409/HBNwyE5QvRlhcdzVN6a6FuD0OoVk7TQPUzHA+6httOjdOU1KrpdGbI
         pjqM1Gr9YlBE34feP4kug8HDrFNxHM7uawlJlueu7u441x9GxUBCgL1InyPxsdfvuXqW
         pXPcchxei2A03nRnkIHt3T5jHXs+twINKn1bQeZ9KhAgcfXPVH4vtdL+E5EXLZw+oDTr
         +sig==
X-Gm-Message-State: AOJu0Ywr+RKcybtTnlbTVYQscCjJmqFVBOcpDKM/izzVlsVpco/7zD9K
	43+v7JKNS0TK7sHfckQwax0iF1YVYpodWGtWh7olx/UjJvJ+yutsqfRdXF1Q5dhKvZ62lbmeGLz
	byeDq9k2MqD3GUnCagfmg1ew/k64/Z4CR1imKnyOj/jYdM+1KIDIQG9dEGA8=
X-Google-Smtp-Source: AGHT+IEA0JIanLMA4cXGL+NJilYVCnIpnNFCPpdhva3gpNrrq0Neeg11HcillWxEQ9fsAdZh2pIS5UCrIDcDjGCTID3h87ZALUtQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198a:b0:428:7ace:e591 with SMTP id
 e9e14a558f8ab-42f87403db4mr248213935ab.16.1760427525184; Tue, 14 Oct 2025
 00:38:45 -0700 (PDT)
Date: Tue, 14 Oct 2025 00:38:45 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edfe05.050a0220.ac43.00c4.GAE@google.com>
Subject: Forwarded: [PATCH] ntfs3: prevent MFT inode resize operations
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ntfs3: prevent MFT inode resize operations
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


The MFT (Master File Table) inode does not have its run_lock rwsem
initialized, as noted in ntfs_file_release(). When a truncate operation
is attempted on the MFT inode, ntfs_truncate() tries to acquire the
uninitialized run_lock, triggering a lockdep warning about using a
non-static key.

The MFT is a special system file that should not be resized by user
operations. Add a check in ntfs_setattr() to reject any size change
attempts on the MFT inode with -EPERM before reaching ntfs_truncate().

This is consistent with the existing design where ntfs_file_release()
explicitly skips operations on MFT due to the missing run_lock
initialization.

Reported-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ntfs3/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..2555850483c4 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -792,7 +792,13 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (ia_valid & ATTR_SIZE) {
 		loff_t newsize, oldsize;
-
+		ntfs_warn(inode->i_sb,
+			   "DEBUG: Truncating inode %lu (MFT_REC_MFT is %d)",
+			    inode->i_ino, MFT_REC_MFT);
+		if (inode->i_ino == MFT_REC_MFT) {
+			err = -EPERM;
+			goto out;
+		}
 		if (WARN_ON(ni->ni_flags & NI_FLAG_COMPRESSED_MASK)) {
 			/* Should never be here, see ntfs_file_open(). */
 			err = -EOPNOTSUPP;
-- 
2.34.1


