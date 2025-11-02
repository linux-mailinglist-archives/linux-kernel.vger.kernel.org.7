Return-Path: <linux-kernel+bounces-881859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D68C29150
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5800B3AFB8D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4961F09AD;
	Sun,  2 Nov 2025 15:50:46 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B08EEBB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098646; cv=none; b=JOs3fNkIoqc7J13DoY51S2ldFchlullmmljlpVVFPM4chaCjsl3jLCGYj6yY7S6hv6vXcowAAQqe6T9zB6kLEwJDaurgP0P+KfD+ly5tpgMwTSlKdjrAzEFfZzg9U8O/DiBj9RQX5vpEdEo4wWZbAWGlEPiKO99amX43pVPTz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098646; c=relaxed/simple;
	bh=l0HmeORHvXPprfxg7sdclXU1+B/78evW1G0TkK1eInA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FStGMHcuPJtojcDbSo6H3ev2meAp+yOndEBRqACVHbnxZn42lXjZVQ6RsY/RdYX76wIRJVIFfiyUqwqNSnxHBnhgdxrEXDQX71JCQGClgC10VD5vjHXrPrxDbInOSvVIxodflmmYZv9dJcufVzXHN1O0hAowqjhb6M2qdbL6azY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4332ae73d5cso3093855ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762098644; x=1762703444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaOBmQV7FrUOyqWIy6y0Uz2nLNntBfU2M31UJqEBrtk=;
        b=o7XC6hXsgGFqwHkpSyWQzA12v6WMG/CL9W5sL9WetJZiO6qz6hRQ7OjtfRo89WxEUb
         XGfmCHUiBQNz8ieyVIn6DG+pUnjEkqjR+5UawUCiO+2KvrijpqOx/smILZdXj3h1++kR
         yHhZbvwHH114gt+hzCbq8P9xafwmHFMbIqAQeZZCQ078xEHAxsFiDNJ1Bn2be4J0hJ44
         O8yhDML6ED6pTRISMvxuQ/caopcqvHo6VPwMz2GgIJ3htzsMZysw5wUzDiZqioAuG4ro
         k+jzFx9Pj85+20oFYwtgi6vLNLZ2I6Nm1zeo8swovKP+fIdPC5W0c6sPqYkkGDp21x7e
         OK0Q==
X-Gm-Message-State: AOJu0Yzqc/5KqcYd5xdVNvgBAKV64Xz9tiqMwFbuUGdTDV2Hr3iJ/02B
	Rbsa6YCBoF8xGWdqk1JqMlVrNJDg+OhQzolE5jDF9e1r0E4gz9QCnjIumcSxhgDW0CzzCft1G/B
	mD8yOj+sJ+DDJONXYT06n9pL2LMenBCbwIHsZIdvzhrxpXxYkvXEaXdX5whM=
X-Google-Smtp-Source: AGHT+IHQ0kq2UqGtUVbRLwhivsQ7yjDIqpfS1H2oSjoJwD2n1cHIxyc9Fh6rf8kbv4eEDlJMKJ8v596403gSHV/3hK5OFiz26/Lk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c7:b0:433:2a9b:1668 with SMTP id
 e9e14a558f8ab-4332a9b1829mr25876085ab.15.1762098644091; Sun, 02 Nov 2025
 07:50:44 -0800 (PST)
Date: Sun, 02 Nov 2025 07:50:44 -0800
In-Reply-To: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69077dd4.050a0220.29fc44.0025.GAE@google.com>
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

diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d54273c3c9ff..ce62cb61186d 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -168,4 +168,6 @@ static inline int minix_test_bit(int nr, const void *vaddr)
 
 #endif
 
+#define EFSCORRUPTED   EUCLEAN         /* Filesystem is corrupted */
+
 #endif /* FS_MINIX_H */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..493a75eff2c9 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -208,6 +218,13 @@ static int minix_rename(struct mnt_idmap *idmap,
                if (dir_de && !minix_empty_dir(new_inode))
                        goto out_dir;
 
+               err = -EFSCORRUPTED;
+               if (new_inode->i_nlink == 0 || (dir_de && new_inode->i_nlink != 2)) {
+                       printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
+                              "has corrupted nlink", new_inode->i_ino);
+                       goto out_dir;
+               }
+
                err = -ENOENT;
                new_de = minix_find_entry(new_dentry, &new_folio);
                if (!new_de)

