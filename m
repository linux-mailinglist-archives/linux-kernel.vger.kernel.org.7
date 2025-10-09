Return-Path: <linux-kernel+bounces-846400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C468BC7E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCA244FA4C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418A82E1EF4;
	Thu,  9 Oct 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf6GuUdU"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF42D9EDD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996800; cv=none; b=qnW7iqMpVh1rOb3o/lQK5L39NU9t8jV1BskQ1PPi52CWLvBDcjBw2yetrtssaoLEFdR8EUJjgzAb6tEWBQxSnFWCv+UjEVMQh3yTus5guWijEsOGCmcFaeb8QRorMSgdiJ7JacgnKCZC9wz8EWEMMol7FtZY6zRbpRiD8hNYO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996800; c=relaxed/simple;
	bh=QVMfbOgdcHUC8MA0FXNAvsLx1wDWQy6WIvHpfH+dzno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfI1phqYLVki4t79cTSAkD1JLfk4qJms3agOZmbDcoAJr9iezbdZ4kqsVH8TOiFaBNN02FNmpQ+BrOzMnENrVhUnI/2rVw7XjL25JbQ/szE/Kqnwtns2GrXfiFSmGalG/Z1jCuLIWWp3h3aTGAwiEMb3Ae3D3DFCCRTXX3trmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf6GuUdU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4539dddd99so127360766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996795; x=1760601595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIPlImYUmrVBYfxz+HlFQqCPCvc3ID3O+4ctjIKepMc=;
        b=Uf6GuUdU5qGcyXY/QE0xsvc54ppyyNy+WjunZiiid9wZoBoElQZtYJhTqfkdGsZ/Dw
         UOPCKCzEjlofEbYCIUeVQ7UGhPL5ZOTIKVqK8IEywi9Qw2A6b7E2zU76IaRm/F+2jYz9
         ISQRvZARuGcwOvQOCvRAxj8EBFu52MKxUw9K2fkR9Bvm0Ryt/dc7WWgqEiGemOvCbCQV
         Vpr9uf6Rx78KsW953fmxOg95jKHx3sEvASdCnIFwVw0HesGxeTSCrQrESsvm1FyGJDu1
         8xSEeEEUTtfg6bKph0Kq3YSkzGdNGmpXa/Gxp89Mf6xlMss0vBudN7iH1xiGByi+FtcT
         gpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996795; x=1760601595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIPlImYUmrVBYfxz+HlFQqCPCvc3ID3O+4ctjIKepMc=;
        b=S3InsFPoZaLbVR6TNrxZQcvfZpweT/iEsvvQJmb6pVNVIFDYkSpPlEZju1X9g/YheK
         T4EX1MxVXaeWxyowAVn7TZ+HMVtdh5NDdJKYRuOonj8/alIqzKGoJKhppP/5o9drJV34
         fXp+AW7Iz8WM3P1MtCJ/p5SKXawuYLjHvvMrt9qzqHmP6xAdndxCpVkzGgCQ9FIkUE07
         n9M+lx97RoDi16n0p+cdvISmk3Kxq+H2B/ds08r0IR9NtLYd2U0NFDOFkuYGI37hjwHu
         nsIlVDEY8g/hLGLmdQVE6AqQzhHrK47Bxs5z6ffWi5C3ARYbZ7ppgL6qU2dGhAPWbTzJ
         k7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvCU03A3PLf+BTodtHxl7lwGUPqg3OjkFEwq1BuPcDTNAm9puuoj9XcxBNIdbAVlmemWsGNMKuXvsv3iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJFniGi1gxrlVYIiKZS7oTYlLNEtQReOTGcIRvKU4nsa+u2bkT
	Izalk9DGBdBuvXWIye+0kt8pXoqfqmIw4jEegbp/KGPrJTOuL3KRAPhWAx4UtA==
X-Gm-Gg: ASbGncs2xEmAVn56TShGcX4sK+Or63/85iq4ni4DWUOE0Fld4u9HwW2L4iYKeL5l+Y5
	fFoUEsSdJbbM02JoFgPmDO9eKpqHcA5uyg1QlVkHcB56jJwjMo5vYvCL2mmxCzT2q/sauAvY9ry
	fMzRE+pa+BUBhggiJcuzs700i473VpcfwzaAmPCWNILwh9D5p0sxwdXvVK22RuaocwxhUL/z1GV
	cQK/G7M/feA3cOqzEY7E7l0TKt5QQqnPt//9cG/xOD+sTgH6jTDPynKP2q23xkUvbrF7siw1un5
	qemkPPaGCGYlnsMXSmetCYKp9UnZ6g/aOd7DJ9WAB4u3cOMZboQrdSnSaPmJR5j26NRUtLaQwk7
	MEicdu8p3F8+VkyS0Xe+wl8bFOZfQ0gw4vuQgNrpl5iQRmJjm8QQbaF9Ipnrz4Y3nLeezakFclK
	yMfJenc9GdVG6q3YEmm6BqiA==
X-Google-Smtp-Source: AGHT+IFNrrAwL3X54wIwGninQDRe5HCAzI3hX5RakrOFeGNwzcDRNVEDhJxmZSvdgNTCtAirMAoMEA==
X-Received: by 2002:a17:907:5c8:b0:b40:b6a9:f70f with SMTP id a640c23a62f3a-b50a9c5b352mr706189766b.4.1759996794568;
        Thu, 09 Oct 2025 00:59:54 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:54 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 09/14] f2fs: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:23 +0200
Message-ID: <20251009075929.1203950-10-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

 fs/f2fs/data.c  | 2 +-
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/namei.c | 4 ++--
 fs/f2fs/super.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ef38e62cda8f..c5319864e4ff 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4222,7 +4222,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	if (map.m_flags & F2FS_MAP_NEW)
 		iomap->flags |= IOMAP_F_NEW;
-	if ((inode->i_state & I_DIRTY_DATASYNC) ||
+	if ((inode_state_read_once(inode) & I_DIRTY_DATASYNC) ||
 	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..f1cda1900658 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -569,7 +569,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		if (is_meta_ino(sbi, ino)) {
 			f2fs_err(sbi, "inaccessible inode: %lu, run fsck to repair", ino);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..af40282a6948 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_i_links_write(inode, false);
 
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_set(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	} else {
 		if (file)
@@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto put_out_dir;
 
 		spin_lock(&whiteout->i_lock);
-		whiteout->i_state &= ~I_LINKABLE;
+		inode_state_clear(whiteout, I_LINKABLE);
 		spin_unlock(&whiteout->i_lock);
 
 		iput(whiteout);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fd8e7b0b2166..8806a1f221cf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1798,7 +1798,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
+	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
 			__iget(inode);
-- 
2.34.1


