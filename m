Return-Path: <linux-kernel+bounces-827724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF39B9289C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191623A71EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBE3164A4;
	Mon, 22 Sep 2025 18:03:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19E2FFFAF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564214; cv=none; b=iKlykhxfXYTlU3gcRlA7GR22pQc5TvpvqlHXY0gQi1si32XCiYe4Xy5MqQkLCh8XN8iNoy2h4FQpINbZ/ZZQmAmUqQldeJlwUqDRJxBV8//L9lsq790RApROTJ7/Ztv7SlZaoP/Cnre5l7q7t4Y6gGucgcfIMtWeG2JRHo92ehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564214; c=relaxed/simple;
	bh=W3Z5cNaSAlSkeXFbF4SJtO89PSvXkTwdpax24WIpZj8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EMAwDCOGVu43+3lugUujwKhQXCjRmdXCa4FBasN/fJ2Cn9AS/vpn+ajh1v+2RJicVrEJB/x3fNhnuUXX0b1/b/088kIpdrEKZU+M0HbDpgmYg/Zwf9nN5v4GNxi7pFjkyfyB6q/I0RW8SUaX1HJ3ummsZ0FEOrSJ3O/TdkgPBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4241c41110eso116226885ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758564212; x=1759169012;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INOp5h++E56owrWuWxvRLYU8Wp8GTyAnoNtDtFVjXdU=;
        b=BiDD8slBxPIGagSpEj5QOGHoJJYTBqlwxbL4C5RabRluGXvtY8Iyx94rZc7Kryp2hF
         MVFVUEf2u6kC/nKcVEIRxFAnSRE4Kf8IpX3RdI4FRx8YxuBrKM3cJy1gkiTIq7OVZZww
         E7ybyZ1Z+vlq3B0aAB2hdGJBJJmMhHlhixEl5CSNj4S1f3gUooKoNS52+89wvshEAA2c
         qVaqdnuRLkuCljXdleyqgjbCD6BUJ/V6QvSG8hoWASXOOeVUC04IVHK//+RhnqEYNWHV
         wctdpyj9K3IBNxuTNE0JaVuQiuSPXDEGn2xeN3sNZQYO8ZLCD116R1HQj6oHza7noebF
         e06g==
X-Gm-Message-State: AOJu0Yxe7iCuGzFOR+RRf4lhT0oHa5aPf0QoRmYypkfYQdbenc4y4dlc
	e+oc5fXuqcqHFq7z7NhxAtdixwSkeF9gkv+Y24d1LRbjmdRQtmvA5CY+qHWLYDH1g29RKCnMsal
	FUNKhQfo81M92kh40Bj74oMedtXTg+6KgNdgSm2oyYKOkWT/nxTQRf+Pvyis=
X-Google-Smtp-Source: AGHT+IHIwamozpxjcNWouw9JIWoYtp3LkK7GwIdgfYPddGaDYgxaAukwSy1mN5hP8mqY5jtxBVXjXf1Z/YDvC2IWd9FX51Xu3Xtp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0a:0:b0:424:8013:c7d3 with SMTP id
 e9e14a558f8ab-424818f7dbcmr221001035ab.2.1758564212079; Mon, 22 Sep 2025
 11:03:32 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:03:32 -0700
In-Reply-To: <68cb3c62.050a0220.50883.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d18f74.050a0220.139b6.001d.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
Author: sidharthseela@gmail.com

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com

#syz test 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 37cbbee7fa58..6b14c13bda68 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1716,6 +1716,7 @@ int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
 	de = __getname();
 	if (!de)
 		return -ENOMEM;
+	memset(de,0,PATH_MAX);
 
 	/* Mark rw ntfs as dirty. It will be cleared at umount. */
 	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
-- 
2.47.3


