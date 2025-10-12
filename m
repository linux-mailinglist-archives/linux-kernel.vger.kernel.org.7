Return-Path: <linux-kernel+bounces-849634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7DBBD08D5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE62188C882
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E79FA48;
	Sun, 12 Oct 2025 17:45:13 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BE2EE5FD
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291113; cv=none; b=hZ69PsjU16Bjtda89KTg16dpgeMUFzVLL3qDYYiHNK3mm/+EonZ4iEnN7MxaHxmkCvuKG3W4jax/kPLPp/OsarIR+MBVMwA1gka4tDRITje9hZZeSEnzqLA/hjGmrCyosBjqojoxsR7CNdnm2qpqYDjev3U+uaY/c47nXC7I+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291113; c=relaxed/simple;
	bh=fhpmpu0rzQtlJ6DEWWvFJkqqCUFNQVA1MbWte65UyHQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HqZADuIaIKiIlyyZaHhDbueJo0qYsz+zMG+x+3aiaF2ODaOvb0zBEXxNFDj97PJQyXYcAbor6JQDSWQHA1eRTINI2DeKmbAJmZcugr5ygdE0nNpjwCw6wzvbZxvlDzp1N77YW5dcQxJZoNETkI4K9auZnXT5UwuxOT4kEdIZF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-910ede1e3bcso2089325839f.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291111; x=1760895911;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ryvtkxM2KLyzjB3K6jv1GgYu3DToqBQ0DVBk3GV1Q=;
        b=buwtdzUzlPPtwvauDBB7Eh4NuG7+tZEzH90T9XOWFCgBZUW0Cpj9NouJr6RBNLfuBz
         wC4NG3Gf3kwvfPnPDlj6TUDsksYWIDiwsKMQa2Tlr3Ip4UJi3pa71eRcB9ypDnLTE43V
         l1Ji4/Eb062+xsDTKrAF7VsrX0NhCgN+55Zs8b/SrAwGNjAZLuO8IJwJPjjjq6FxTV2D
         eUA92UjguCPakf/6UprkGVaxImUplOvGltfkmS3GJry15k/bZ863iNOJY0zAulxacOx6
         fW43aVTqukvkkKlh0W6ITy0bGa3fi1jgeFmvod/FeBUU+I/5luCCNyfOg4DAcejBKe5n
         ZPXA==
X-Gm-Message-State: AOJu0YxCBpehMxVAokRjJNmAz+raDKe0JDhq29gmSKKqiOeS8KmS1JIw
	5FjRE+SfZr5yV54dteKdclQc8CUt9jdJCwjY9mDLrsxG8wGPyBI9rCV9Bi+a+EdjCDXDDHpiUKF
	zcyUsRn+Xu0hbCggWjS73gaeQRUugTaXUOyXAHsWYnzhBXuoCq+gYzz0kGQk=
X-Google-Smtp-Source: AGHT+IEnSR5+oNxRYXp3Ydf7aiAJ82NnNHUESjIRgWl9cCI5kC11xnRFtmqkgd+QYB14ORkjynJMaz+bjLcCDhFv2h610RVUHx5w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f93:b0:927:be17:389d with SMTP id
 ca18e2360f4ac-93bd1838538mr2502222839f.4.1760291110750; Sun, 12 Oct 2025
 10:45:10 -0700 (PDT)
Date: Sun, 12 Oct 2025 10:45:10 -0700
In-Reply-To: <681d87ef.050a0220.a19a9.0125.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebe926.050a0220.91a22.01dd.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
 fs/jfs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 65a218eba8fa..7879c049632b 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1228,7 +1228,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				jfs_err("jfs_rename: dtInsert returned -EIO");
 			goto out_tx;
 		}
-		if (S_ISDIR(old_ip->i_mode))
+		if (S_ISDIR(old_ip->i_mode) && old_dir != new_dir)
 			inc_nlink(new_dir);
 	}
 	/*
@@ -1244,7 +1244,9 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out_tx;
 	}
 	if (S_ISDIR(old_ip->i_mode)) {
-		drop_nlink(old_dir);
+		if (new_ip || old_dir != new_dir)
+			drop_nlink(old_dir);
+
 		if (old_dir != new_dir) {
 			/*
 			 * Change inode number of parent for moved directory
-- 
2.51.0

