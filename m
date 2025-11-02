Return-Path: <linux-kernel+bounces-881805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FABC28F57
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 13:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F41188D16C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F8A72618;
	Sun,  2 Nov 2025 12:47:18 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821821D555
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762087638; cv=none; b=A4PJL6NjsaxBclUYF6N6Kw40NBzARGcWG/tSuCDlcbAtO2oFyGn7rmPVl03yOnLvrRrjEBrc64jeH9J33sS3lvjmTpG1aGVnCt2td5KYqsWBrjtmQfHNJbgLtvq1jGaHhOdmlKDNqOdo7qUK7Ho//lszIGHRm4QtjaMabXCaJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762087638; c=relaxed/simple;
	bh=y9Vv7G7El0oy4wMYPNL+VtbTM1gZZYSb4xipHKSztWw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lfKwll12zA9CWu1gOrCHwx2MEq4FNRuZp9aCFx/I+CqtRBoTyxnvYp3UhnDqwmHmxxG217wNe7GK4mMy2+h0MLZVWJ+6UF94ED0hZQq7MF0j2JMiK0uSbBqk/PlxdZ0h8w7w1qpq+n+Tj2W6l4qjvNiwgIosOVzLzMjK/Jp41+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433199c7fb4so17385675ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 04:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762087635; x=1762692435;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ae9rt8H7wB3/jIHrXppXwJTzQbdCylhJD3d2xsB7iBo=;
        b=wvir25WvGoIMSr6WqfJRv6CC7du+D48eRV1ngSBJnE0Z+Kp8e6Hnz9i/SwzNfP+UzP
         Xusdbrajn3By+wpGEGIQVbUgbNqEQ6mGwcp969IexPFgHvCUFQx3ZVVASYJwQbylABee
         0e+OUsueYFYIYHLkC4VCjT9gv8yRJkEf40YnefNDpGX1V0jDzq/TSBN2RT79FTIk8CLX
         0e+++ZFmCjV27mGf+3nUAm0rC66/uHLwwmO2W7Dv0dcBx/eziKbWMXCVR+ynvmoJ9MsT
         X0wyFEULrxDAME0JbhB9AxUGUh9AMGt+JPaIZwpFW/tl+acwVQA6o3TEw9/THFYthf9Z
         TgCw==
X-Gm-Message-State: AOJu0YztfR79arfvbt7XiISyVFk9DVbe9+Ch8MqCRYgrxQRRZe8iSoPA
	taRMfX0rfmWPLbiWQIjSBYHzQRI3VvBW7GGGrSfjqFRn873MpMiCE9jnn5JoT4hJRY8BQykvtbw
	nWVWC2OsqD4y2A+yrKuNe2SbIv/9EqAlmFXZ/ot8IqDWQ0Dhw5+YQFK4cjJ8=
X-Google-Smtp-Source: AGHT+IGZGwc+X7c2r1zbw0xoyOmOg79jiER79MdBbnDnxsgtazdUzDIWtsn8kXn4Ep1dUhe2FX5sX7AxD+IC4PkAKom/NtjHTYY1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240c:b0:433:27e9:8690 with SMTP id
 e9e14a558f8ab-43327e98e50mr32191815ab.21.1762087635642; Sun, 02 Nov 2025
 04:47:15 -0800 (PST)
Date: Sun, 02 Nov 2025 04:47:15 -0800
In-Reply-To: <677e6cd2.050a0220.3b3668.02e7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690752d3.050a0220.29fc44.001d.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
 fs/minix/minix.h |  2 ++
 fs/minix/namei.c | 26 ++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d54273c3c9ff..ce62cb61186d 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -168,4 +168,6 @@ static inline int minix_test_bit(int nr, const void *vaddr)
 
 #endif
 
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #endif /* FS_MINIX_H */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..a8d5a7e22b7b 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,15 +161,25 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
-
-	if (minix_empty_dir(inode)) {
-		err = minix_unlink(dir, dentry);
-		if (!err) {
-			inode_dec_link_count(dir);
-			inode_dec_link_count(inode);
-		}
+	int err = -EFSCORRUPTED;
+
+	if (dir->i_nlink <= 2) {
+		printk(KERN_CRIT "minix-fs error: directory inode has "
+		       "corrupted nlink");
+		goto out;
 	}
+
+	err = -ENOTEMPTY;
+	if (!minix_empty_dir(inode))
+		goto out;
+
+	err = minix_unlink(dir, dentry);
+	if (!err) {
+		inode_dec_link_count(dir);
+		inode_dec_link_count(inode);
+ 	}
+
+out:
 	return err;
 }
 
-- 
2.51.1.dirty

