Return-Path: <linux-kernel+bounces-881836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3706AC29076
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A02188A645
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2281A3A80;
	Sun,  2 Nov 2025 14:41:54 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716057261B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094514; cv=none; b=k/2IRdicUzt58eGZj4PYzuGuf4aaepgGFLBl7vfyBQJVSSNGzqWPK4J7vmhRs2YqnZZT5fnLSoAIKj07721QT7AzEDv+uILwUAb3XE0GqFh6cWEzbGlvlUm2TBuxY6aeK2OEE3gFb0g38HdijXLz2xtSRI+JnG7nosWjP7aQHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094514; c=relaxed/simple;
	bh=ve4g7xcsHlOtzhB6F7QvzbE0TB8wRII/y0h1kk5GRIQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A7cMZaiSVfU4pf+FNjGlXhedPeBOA03qPcoNfTJ1ABDXoMH6IykPfjcv9V8ppXJV0qH7Z5zQGpAEQRg4lNP7/LGYz6+NNxsTpoqQuZ/+98WY9antYILD72NiBQ9AtygGuhWbs8ssglknO/7w6Xjiaz7nfrOVzGTxrfzAKKEfhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4332ad10c91so15500175ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 06:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762094511; x=1762699311;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g97bVmPSgyu7CAik80bLdzsu4txAdl3z+edcIjW1yCs=;
        b=tkgK/SSQxcGw7sHIV2bBdKLiUR8myjSpkKYnAjnNPjD1J5JlOgwJKQsbnbxzcxBDp3
         QbZ1IEQhyXb+r5RahZr3OMR+AQSUDvRQUvV6TcjLC7G38sApOoMN14XAqubZlnBp8uBL
         WGZW9zFSxMcrquHBSqAl5SywBa3oaj2xlHYR/g86AkproBUL2+yK6sWNv4TEQ5eOBnL5
         MJNMUNKwza/gHAhKwoJM2vZ9Sn9nvUSsB9Zq1IJ5fm6PsXIZPIh70S4Mb9Htc31Lx/f6
         VC22uwkxNLDH+pIzbmm3mYxx1jqw6fvValplAN4wLohs3ZZtxT5xR7bqwVYa1A391w7u
         txCg==
X-Gm-Message-State: AOJu0YysMXiVLYgN7oe2a6DEpDDRVOh0b7S4A7h0qjMjcv9EZKlzTRnA
	I2i/yR8Nk3GcU5OqrVYcbPKWxFqSWoc9YaB5TpXrFOTqU+RRPFTw0qpZlYYldhPZSKXEftpf+ZS
	n62o5H6y//0/0D8jUjPAorIx0VEk5pRLxoRCS/EwM7vzpQC2mzCHVVCg0CGo=
X-Google-Smtp-Source: AGHT+IGk+cbWCQUuAtQG2Ida0OL9ykikNqdw/PCVxGeklrgD8Xm22pzfDG2ywwKrTUy8o/tvrKWOLTCeM6O3YIdYa4uG3OmFaaoO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:433:2936:48c2 with SMTP id
 e9e14a558f8ab-43329364961mr24458805ab.24.1762094511682; Sun, 02 Nov 2025
 06:41:51 -0800 (PST)
Date: Sun, 02 Nov 2025 06:41:51 -0800
In-Reply-To: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69076daf.050a0220.29fc44.0020.GAE@google.com>
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

