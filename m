Return-Path: <linux-kernel+bounces-882856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F40DC2BA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380A63B630C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4A3009C4;
	Mon,  3 Nov 2025 12:27:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5F2C11E3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172850; cv=none; b=F867Z8wSwB2CvXfq8lSdt0Lju/vDCNTroGHbuY22q3nVz0ClNr5RJrUXFI2nGk4lPyKjHXgLW5/HGoClpnA5y/CM0gylIDMi88qw5vKHtwsXI3oyBPZxnnzTFKDEwfFfgMtm8l1D4x+YSis5z9+7PxiJZZfeL8ph8FElRvTWdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172850; c=relaxed/simple;
	bh=+15zIbNViZ4XL+cMnxpcCxrp4LCfdB61mQOv4JI043I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jqx9+VEPDf8MFqnxsFzkTaUBIwZoGlmA3SZFSHjJnfHWVh+LMf5AKmsEFgajEzU7ifzggF8luc0wRMGE8NYpl1RlB7Z9doWP3XA66XVTvBJxCW9NkDGZ6qtSUWEVe/VbDhoDE0sVB1bUAxNv1UybleUIG57jcWsIZuWQTxrRKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945a94ceab8so423007639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172847; x=1762777647;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcFzHSRmL/0D+githRCOBVLKtkFMDqSyAYU/V3luQWE=;
        b=wzmrUG1gy98D3w2Vhxoe62nATMjigWWaPTEa4Ru7M95Sp1Vbv/uhWpzw+dfCgdqFdt
         /GzhPlaJeUQ3UMybDcGQPpzNpkemCHj+dE9B9yvdLhrhEDLsEefzc/gaRKWQbf7DvgId
         +OdGt4xqB0Xk3ZP+4gqYdNooee7pUaGlQGpoudbzzRBgZbUOBBev+sIgF6eMzc7e2BMc
         CEwjRT6r/ET79nmt1txA5vWULltgvR4dTm1Vm0ts9rA5h+a1SGeOCTLi5J9hF0nEzSSp
         o1Joh6ce9yfZpwh+aFoCZx7D6/nv66BxxYPEPFKW6mDs6L0RTZvqRQ8V2E81VY7Eko7f
         UVmg==
X-Gm-Message-State: AOJu0YxIwRU8HEN+aUxWgjcY4OMyj0IHmAveARPx96FC1dAmI5+hfCSH
	l7xqrmDeUu9kyz/YTRS/mb9MFpNJPhjWkCfW4MZnuCN1USg0/2x8chM2x9XMNX9fha8u/D51GEn
	NvdoFl/uej4AyS0UMEkFVOd166jgYG+430YLkLK8fE69O/jbGl13sodrYL3s=
X-Google-Smtp-Source: AGHT+IE6eSgNgM/UJhRkcOyp8JNkIz6mRq4+Cph0Gi4skeHWTPNsp1YtHaqJke9PxIvAf+MDyLRJkAB5mnUVpuJcbMKuBbaliSYR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4807:b0:433:2711:c5cc with SMTP id
 e9e14a558f8ab-4332711ca14mr67921125ab.32.1762172847022; Mon, 03 Nov 2025
 04:27:27 -0800 (PST)
Date: Mon, 03 Nov 2025 04:27:27 -0800
In-Reply-To: <68f9bea1.a70a0220.3bf6c6.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69089faf.050a0220.29fc44.003f.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject:=20
Author: jkoolstra@xs4all.nl

#syz test

---

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..ee1760305380 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct i=
node *dir,
 	int res;
=20
 	inode =3D hfs_new_inode(dir, &dentry->d_name, mode);
-	if (!inode)
-		return -ENOMEM;
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
=20
 	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap=
, struct inode *dir,
 	int res;
=20
 	inode =3D hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
=20
 	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..beec6fe7e801 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -186,16 +186,23 @@ struct inode *hfs_new_inode(struct inode *dir, const =
struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err =3D -ENOMEM;
=20
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err =3D -ENOSPC;
=20
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, na=
me);
 	next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		pr_err("hfs: next file ID exceeds 32-bit limit =E2=80=94 possible "
+		       "superblock corruption");
+		goto out_discard;
+	}
 	inode->i_ino =3D (u32)next_id;
 	inode->i_mode =3D mode;
 	inode->i_uid =3D current_fsuid();
@@ -209,7 +216,11 @@ struct inode *hfs_new_inode(struct inode *dir, const s=
truct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size =3D 2;
 		folder_count =3D atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count > U32_MAX) {
+			pr_err("hfs: folder count exceeds 32-bit limit =E2=80=94 possible "
+			       "superblock corruption");
+			goto out_discard;
+		}
 		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op =3D &hfs_dir_inode_operations;
@@ -219,7 +230,11 @@ struct inode *hfs_new_inode(struct inode *dir, const s=
truct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks =3D HFS_SB(sb)->clumpablks;
 		file_count =3D atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			pr_err("hfs: file count exceeds 32-bit limit =E2=80=94 possible "
+			       "superblock corruption");
+			goto out_discard;
+		}
 		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op =3D &hfs_file_inode_operations;
@@ -243,6 +258,11 @@ struct inode *hfs_new_inode(struct inode *dir, const s=
truct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
=20
 	return inode;
+
+	out_discard:
+		iput(inode);=09
+	out_err:
+		return ERR_PTR(err);=20
 }
=20
 void hfs_delete_inode(struct inode *inode)
@@ -251,7 +271,6 @@ void hfs_delete_inode(struct inode *inode)
=20
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
@@ -260,7 +279,6 @@ void hfs_delete_inode(struct inode *inode)
 		return;
 	}
=20
-	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..1c3fb631cc8e 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -273,15 +273,12 @@ void hfs_mdb_commit(struct super_block *sb)
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod =3D hfs_mtime();
 		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)->free_ablocks);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
 		mdb->drNxtCNID =3D
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)->root_dirs);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 		mdb->drFilCnt =3D
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		mdb->drDirCnt =3D
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
=20
--=20
2.51.1.dirty

