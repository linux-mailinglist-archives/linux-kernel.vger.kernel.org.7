Return-Path: <linux-kernel+bounces-857644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3EBE753B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC222624AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD762D46D9;
	Fri, 17 Oct 2025 08:57:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66A2D23AD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691456; cv=none; b=PkE73JPg8Nja2U/pZrODJ/UpKBxGobIKWXFfzVRABwfkBB0ek0ueDVz8VGCfg9AlVfMiK0UBZVZ+07wtTqO8suikJ78vwTC/fzq1nEdscypMyfSyPb6BWwhFfd799hrNEbz5zGSP8AR/mS3P8YZeRlnqMzEkyMuDWbHoIxSwgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691456; c=relaxed/simple;
	bh=+hqDM6+8L/tFzS20limIuvpxVyXOM2NhkElpZjHKKPE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YMgrkd9i2FMFmy4g1qpCNl2V/XcRIXSAZG92BarkKE6nyF9xllofa6k5XUozOR7HS68v+bQKib/y4n4t8gmg4v9QMUalIf17b01ClNe1ytLvuifyBWU0qfL4Cw1GoK/prGlGd/NypWcbzrnh6Fy6EXs6aXrhXz96mwWMMc9o2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42486b1d287so49952775ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691452; x=1761296252;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz7opAJOPtEUpqdbMru/mhdJ8A+K38vy28KXfUcDrpk=;
        b=K1u6fn9tKq1g5WXqrHVQNcI3gA7GDCcETMo4nKzvIs/160t9IaN19aLBh1VVwQCZhL
         dRiSWeGS4V9adeZvmqmikufBxYGxtsMhvwDaojQ7H1EGcvB/G+RiPuELAMHuW0ScD2LW
         BK+8ONKg7UsbR9OVD7BFc1KNkjMITvNwz/Blw6QNICighskOTaq7KfkME8G4icExUxmI
         Fx13dSGALmELB+J69+ZYx+tt9Me5kWlSRCJOgG8FB3cK4xH8ur7FY+zncYDsK1sFz14M
         ryfe49PWnLzVYgj3JKYvmi8YWtduAa8lWWgTYPbbEbTOtdm3krgRV96DKvcK5fVzUYPM
         RhtQ==
X-Gm-Message-State: AOJu0YyB0ttdyHcLQlCfc84kc7uf46kHBaGQ6SeBlo7wnG0ROfPJslMM
	1TU/WgEBecJaxcYhXjkrVMFPKxAUR7827VmOoRfMuxKLc5EnCqR+xpD0hLKrQ9Fi/77AApN/CKl
	ttNa/OkhHQSlaMLFWdr0AWvCPq2DPByKWE39vAQQYU2WkVEBCS7FaOLg5gvk=
X-Google-Smtp-Source: AGHT+IHT37vNVmiPMh4gxBW2+S8jwRatXmjjvSUYFK+ZbWzqRvLmjR9oWgQeyAf8ahJlIGxgWGN1cE3ppIA7OOm+AOVHzvL9N3RW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:430:b5b5:812e with SMTP id
 e9e14a558f8ab-430c5245f61mr41997775ab.9.1760691452681; Fri, 17 Oct 2025
 01:57:32 -0700 (PDT)
Date: Fri, 17 Oct 2025 01:57:32 -0700
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f204fc.050a0220.1186a4.0515.GAE@google.com>
Subject: Forwarded: [PATCH] fs: fix stale inode access in chown_common() retry path
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] fs: fix stale inode access in chown_common() retry path
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

When chown_common() retries due to delegation, it reuses the inode
pointer fetched before the retry_deleg label. However, break_deleg_wait()
can cause the dentry to be updated, making path->dentry->d_inode point
to a different inode. The stale inode pointer leads to locking/unlocking
an invalid or freed inode, triggering a rwsem warning.

The issue manifests as:
  WARNING: CPU: 0 PID: 5699 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420
  DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
                       !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)):
  count = 0x0, owner = 0x0

Fix by refreshing both the inode pointer and its associated filesystem
user namespace on each retry iteration, ensuring operations are always
performed on the current, valid inode.

Reported-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/open.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..8672072fb4c1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -755,7 +755,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 {
 	struct mnt_idmap *idmap;
 	struct user_namespace *fs_userns;
-	struct inode *inode = path->dentry->d_inode;
+	struct inode *inode;
 	struct inode *delegated_inode = NULL;
 	int error;
 	struct iattr newattrs;
@@ -766,9 +766,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	gid = make_kgid(current_user_ns(), group);
 
 	idmap = mnt_idmap(path->mnt);
-	fs_userns = i_user_ns(inode);
 
 retry_deleg:
+	inode = path->dentry->d_inode;
+	fs_userns = i_user_ns(inode);
 	newattrs.ia_vfsuid = INVALID_VFSUID;
 	newattrs.ia_vfsgid = INVALID_VFSGID;
 	newattrs.ia_valid =  ATTR_CTIME;
-- 
2.34.1


