Return-Path: <linux-kernel+bounces-776065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33760B2C817
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78C5188972E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73627E1D0;
	Tue, 19 Aug 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ne3iDwGn"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CA1527B4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616022; cv=none; b=eWCE67febNqaDd+QsySalveqBZqSPxaJR/d4HFyduhnOtIeTvgmT4UqkIk5Q+i+P7Oz4en7e/6LuCGGP/AS+sIl68UgGWMKive5e9Q+qfZ0Z6g3USvdsIMhz5je2VR2EFZtiUahaRJEuphbSFU8+zFNnZbykiSKTxHzEkIIeTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616022; c=relaxed/simple;
	bh=qoKfHaP7o4YE9LRB5KssjSaeCDZnsCjTQjhIsqOlZCI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=eV1oXYiqsZqFs3TjxbLtrY/3D2G2fVTSDDAdceg1uWWzirb/27hhbi+096WhCNY2/5WBKZGB04OInezolUHi8wuPEHnjGJ5J3hxrGHzDIPtpmZyBaUTwgXE84RT3H3G/rZjI+rQnPelXlbw7vDXRTrq2mnicACaMlAXfZvqFwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ne3iDwGn; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1755616004;
	bh=3IKcOwlRc8jewh+RiWPLuZJ2hVlatyR4DrV7+HzGJMI=;
	h=From:To:Cc:Subject:Date;
	b=ne3iDwGnB5+OwuheF4J3DRkw22qJIzD6Su2+PCP8JjCpQGIuDoH00Zs1cnAEalyV0
	 k2EdukGySU4CLWH6/UNivQo71kI3nGHgtcngPXV2poID6GPH8uMgeLH+1u2QvOofZE
	 ENoWJMinJ+SWIYJKTlxPd33rK2uz6CAOOwTGeZ4c=
Received: from zm.. ([2408:8340:a29:3fc0:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 261F41C; Tue, 19 Aug 2025 23:00:38 +0800
X-QQ-mid: xmsmtpt1755615638t6gu88qhx
Message-ID: <tencent_8DDA7086C9B39312179B5CE9430B891C1605@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuZrP3TWI/GiGbrSZe3QXEEtV+gbKvbCa1ZfHz0khThiF/mL3MUt
	 9+ceyY9LsWbZo0jk9hzcxD+3p4wmQ/zVfVmL2GSmvHl4LTcNidEw8tXU3qG9jtwM0l9OWLCGNnJT
	 57XIsyP6BmSAKKmdk6RN4D8rXzfbng317W62eSJEDf6c93pHOCAchBetAHk43LumOc0FVjWGmZVP
	 ec3IJrTF10D2BPZrOUS4Na5SZq9tscfON1aNlWTFnDoyrQN4h9ceM7K3rvWX8Z0hFYRzSROXa5IR
	 liXFJWPDkuAFK0zzaC1jWHIIVsfQKYUTRD89TNL5Sfnw+4H5WAfCXv2qqBD4NL2Ybqb8hf3H/SLM
	 NrUokmlDIDTDRz2HVomB0Ion00vBOoViV4jky/gIHo1A2Ykm6WOe7Gh6DwUkjl7FmaU3WfEC2Z3h
	 6nYOASF+uyeHzV/9QrWOldtSOkd/npdt4gGewPf1z/gOiQSnoecuHN6Ok7WY5lZZhC7JmUd7IU4M
	 hU+Q711TQ7HcnMTfoJjxaeJbWt70/ZZq56eytaYnrxlBsMTSMeyCkveqJim82R+Bpjk33GTJz2XQ
	 yyuLhHmgGEM4tkoak79CBO8nhSd8MmH7pjDpc2sCivBamsNHfrVKnA+Pnuydl0KF7Ly9uCAaBeIC
	 yoRdUZ/7FF3N3jQG1GdntjPbYczr9Jb1ewQPmJkUlH8mBIgeHCO+WX8rVbnO/Rr2cVIF/kEedKXO
	 N/K1YfiadcWrLZEraDTrHC1HBQXETBsBxjYMiuQKchHsaKdEh/17bogiIk8uwWDynN5ttppKJDl1
	 4j4UcoUsTONUyUFyg55/x4vrWKXCtSSl8cGwFu8Dcod14FEq2oPC4ozR20FD7kPZQBEQAsjEIbW/
	 nBrVy2yRq086rMggxaEkMuz1f3Arr6Sr7etoJc5nn3rhT03wLbbYrVs+cXvdwE3kwO6TZ6WWh86R
	 fyM6KyApuOlzq9YjrCwYI1q0Hf++fwfhKQe1q4zroSgnicVUpumoYrzWsYKhJmXKMpKxSBg5CWmM
	 OCYhX4kEFrIvpJtbh2HqDy6pUXwXL5wHdCg7S9PD1pZ3PlPdNKjX5wonlm/atY8qLHesMibA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: zhoumin <teczm@foxmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org,
	zhoumin <teczm@foxmail.com>
Subject: [PATCH] vfat: fix uninitialized i_pos error
Date: Tue, 19 Aug 2025 23:00:35 +0800
X-OQ-MSGID: <20250819150035.1639236-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i_pos field remains uninitialized when fat_fs_error_ratelimit() reports
error, e.g.,

	[ 1642.703550] FAT-fs (loop0): error, fat_get_cluster: invalid
	cluster chain (i_pos 0)

Since i_pos is assigned in fat_attach after fat_fill_inode, the error
message lacks useful debug info.

Path:
vfat_lookup
	fat_build_inode
		fat_fill_inode
			fat_calc_dir_size
          			fat_get_cluster /* report error */
      	fat_attach  /* i_pos assigned here */

Reproduction steps:
dd if=/dev/zero of=/tmp/fatfile bs=1M count=1024 && \
mkfs.vfat -I /tmp/fatfile && \
fsck.vfat -bv /tmp/fatfile && \
mount -t vfat /tmp/fatfile /mnt/vfat && \
mkdir /mnt/vfat/dir1 && \
for i in `seq 1 500`;do touch /mnt/vfat/dir1/fatregfiletest.${i};done && \
dd if=/dev/zero of=/dev/loop0 bs=1 count=1 seek=$((16384+0x1C)) && \
sync && echo 3 > /proc/sys/vm/drop_caches && \
ls /mnt/vfat/dir1/

Signed-off-by: zhoumin <teczm@foxmail.com>
---
 fs/fat/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 3852bb66358c..c71f08b20617 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -405,7 +405,6 @@ void fat_attach(struct inode *inode, loff_t i_pos)
 					  + fat_hash(i_pos);
 
 		spin_lock(&sbi->inode_hash_lock);
-		MSDOS_I(inode)->i_pos = i_pos;
 		hlist_add_head(&MSDOS_I(inode)->i_fat_hash, head);
 		spin_unlock(&sbi->inode_hash_lock);
 	}
@@ -429,7 +428,6 @@ void fat_detach(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	spin_lock(&sbi->inode_hash_lock);
-	MSDOS_I(inode)->i_pos = 0;
 	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
 	spin_unlock(&sbi->inode_hash_lock);
 
@@ -513,7 +511,6 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 	struct timespec64 mtime;
 	int error;
 
-	MSDOS_I(inode)->i_pos = 0;
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	inode_inc_iversion(inode);
@@ -604,6 +601,7 @@ struct inode *fat_build_inode(struct super_block *sb,
 		goto out;
 	}
 	inode->i_ino = iunique(sb, MSDOS_ROOT_INO);
+	MSDOS_I(inode)->i_pos = i_pos;
 	inode_set_iversion(inode, 1);
 	err = fat_fill_inode(inode, de);
 	if (err) {
-- 
2.43.0


