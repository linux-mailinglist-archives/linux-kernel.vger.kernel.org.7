Return-Path: <linux-kernel+bounces-852738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B54BD9C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 798BA4FBE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C7D30C62B;
	Tue, 14 Oct 2025 13:36:57 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6322F5327
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449016; cv=none; b=u4xGKb14jsV9MQKxkQzHXrpkoUwkoLBK9NwH4JKD6ffkjR6Fen4THXnORi7jFoWbz5mp1TgarWutvdLbVlFtoFw07QAMMIZoMAuFk14F0SI5ACtZuJ60OjmeorxGHJS+3w2q4v7WblzhaEFctTozgiagymcT47prQbydqiRVrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449016; c=relaxed/simple;
	bh=QiuwfUEpb2dFmwd+rLmrSS/dWI43N0QDjuz+qZTapsU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YhHadq+Si2jwNyH+4VkpV8U1XZeIP14ST3LF5tDu5tRB/1m5plpADndnWmDJ+hNZf7KoOMPmOCaEMV1xXfAPFCIceXkJXblH3J8h8gANtVG6NamD69lYGD0CrzqiLUmaWcEHBP9cdKUtBCbA0s51IWnbT48SVgaNh0IFEhgNCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42b2a51fad2so138380665ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449014; x=1761053814;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tuiv9pSz3kH2rH9Bie/Qsl+XlaA5X277WLFawAOPOsI=;
        b=UtdLpFvKTSCuofHCk4p35izUWlZ/c+aqx8svR2PhkSYeR/2ATsgPl9B8z+ojXn0LtA
         IMYAnDvrZUm1tBj8Ze6b51uVt3XS0vqWw6QbVpf4jhY2aB3A0zI/QFUrRiBhcAhvbOGV
         /J3NdCt7iONYw9bfa9waUZSkoE0Kbumg+7lfgx+OmO4jiB/WyWGzYxwovyEZDKXtok4c
         Sea4SS6/CeyLbQklYUJRwVf/B6Qgka6B08jmoBYRi89y6l0IG911IyJB6o3ThZDrMbw/
         aHdZ0FVBK49YSU/6F7mMTDnHfaY+vCvgovBpEhytl9FD42pnGvmwgtBZ0Epq/yiK+aIV
         MovA==
X-Gm-Message-State: AOJu0Yw6DdebZ+HV1Awa4JwpSATuECHOzc1/wXgq/DR23ZxYHRpQTxjw
	oyk7Cw4cap/g1LVFby/E7RODDyYlSSphq5+BLig2I7Odwy/P9MTjG8hmqwnrApGrQWAZlIZXDQF
	XXZ+bcL+eRBNMNaL1LbrgQ1Kkg6zc0v2NmTUETCgZUf1jRGRcrZqEsZkuJIw=
X-Google-Smtp-Source: AGHT+IGyKIGzoTSVENMOvZD+M+usJT26ZQoJ8UiojwXQYTRXfsKsVRHMMi5YYQUsqjRABSdLAyCPLYpTo2VY8yuW0OKNObHO+PKa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3708:b0:42f:8bdd:6e9c with SMTP id
 e9e14a558f8ab-42f8bdd7091mr255969865ab.14.1760449013927; Tue, 14 Oct 2025
 06:36:53 -0700 (PDT)
Date: Tue, 14 Oct 2025 06:36:53 -0700
In-Reply-To: <677e6cd2.050a0220.3b3668.02e7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee51f5.050a0220.ac43.0108.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
 fs/minix/inode.c | 14 ++++++++++++++
 fs/minix/namei.c | 22 ++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f007e389d5d2..e27907fc9bf2 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -517,6 +517,13 @@ static struct inode *V1_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks == 1) {
+		printk("MINIX-fs: directory inode (%lu) has single i_nlink\n",
+		       inode->i_ino);
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
@@ -555,6 +562,13 @@ static struct inode *V2_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks == 1) {
+		printk("MINIX-fs: directory inode (%lu) has single i_nlink\n",
+		       inode->i_ino);
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..8297ee6651a1 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,15 +161,21 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
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
+	int err = -EIO;
+
+	if (dir->i_nlink <= 2)
+		goto out;
+
+	err = -ENOTEMPTY;
+	if (!minix_empty_dir(inode))
+		goto out;
+
+	err = minix_unlink(dir, dentry);
+	if (!err) {
+		inode_dec_link_count(dir);
+		inode_dec_link_count(inode);
 	}
+out:
 	return err;
 }
 
-- 
2.51.0

