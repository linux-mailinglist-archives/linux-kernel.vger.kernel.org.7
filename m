Return-Path: <linux-kernel+bounces-818955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D4B598D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544267B8D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18752EA17F;
	Tue, 16 Sep 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C21u3d19"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D7353348
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031202; cv=none; b=s0tObz6QAvuEZVYcI+6ShOIuQOR7ZCFN3wc9tfl5nIEw8HVXdLaWD+6GTyLFcP9UDdjGRIrmFLjw5kz2xPAN48zBCCN2lKsOT69Jko2bjQqVEUt2VJVy/cPpgHDNuN5aDdfbKGITop7WKWb/e58qeUOJsmTwSO2AxYvJryQYSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031202; c=relaxed/simple;
	bh=c+jscvVcjHEiu8psO35s6FUxxWLk6N1H5PVjaYHBuTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPRA8VdHUZkeDzLG0hqSO+ymkfUhvmWUKDKmhiZ4OQPk/495ziTX4UEZcipea2bYoYz9qvdJ3oaLO8sqVJJa8ACCKqWoL60SlefPMb83gcGJ6Akqxv2AN5yRsceusWZhw/56zJus4sZNuoxdOTlPNBKelWg5HtHAYM3Kl5f5Gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C21u3d19; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45de56a042dso36881105e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031197; x=1758635997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vENfTvsqrFJ9tJyBfgLNz2mb8wc8do/WZvddYLx/2MM=;
        b=C21u3d19x1DjsYLGY77AgVuGFJpc7Ig4fo4Ohm8jKWcl7iOvflvcwoJ48taJ4+fHLm
         tIdGWj1Za+IZGy/XPSuZty/tFmcdO9gKYqRvPzDG4iT2AAFWgiYbCa6zQVL1QjjdchTX
         /dAhqFk775dJjUo5Dobt1zHOXXoUVZkJ6hLgIjZTBWg4ztB+8AewMjOpnzltJlilhwHl
         0gfsMylQ001Vy1z2qGg6/HapEPCjePhuPj9OUpeXne4xp/jB1hdJ5OPPtc1GkVR/1UT0
         tvLara7/TZ0N5t5aa12RyY3LEr0f/nlndfwk7+cSe1jJmoGd4KvUQAVdffshf5o07KGd
         CYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031197; x=1758635997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vENfTvsqrFJ9tJyBfgLNz2mb8wc8do/WZvddYLx/2MM=;
        b=NG38S7WRwU3oKCNx16Mwr1oLtkTBVASGc0K1bpA8juD9FPCOjtEXIcKvelwxtjguFj
         KJZcgiakzFXOrmcEnFHPXwvcEvInnxu2dI9R3WCBjbf2ew/B+HGWT/6nVr6/VmWT4+hW
         bJWZ8xKatgR5H1YhlALuQN3Sw/rQ8KDYijqy3Nm+9v2dME+M0OazjlgmTJ6etJM9LZbL
         eT4I3dlSYVwpFAWFirFQ71hKSz/9xQ+H6Cyh6qvktF5xP/vkc+qsaIntyLPd8vwv62b1
         J0/GEqHfI4GZs3B6v6QqAEhwxhtJkPQbRRGDLmACyhfymk9ACp5OK/dQr08ZfUCUd6up
         v/rA==
X-Forwarded-Encrypted: i=1; AJvYcCVkmrRUt9zIyR98hv15V1qMsWhw/9VOXtFnD4QD3c/9qM8EYQdBS7Xl0YyKRqOYexcXVjCJ7sfRFpRdn4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4ha4Ywxv4T/YD4ctG2KFtMuVwJ92URsky+aFweLlsUXdPbdO
	KKPbYWzMlBpckwnHwq9FMsjjYAaT/xVjx4HEYIr/KsRbIJXQI2O9X6Vy
X-Gm-Gg: ASbGncsUU1vjNaXY0QKSlv6mJCv6cWocPAbbkowx7UiGmInXKnyrXVqJH00yjBjhafl
	e7FHthGphOKUTKTYdLWehkjx9E7Elg+rWeQPBBPN//3RXd82GnTrr2gZHs03VWdCkoVhiILVFKK
	jsMvCegJG90MAqklEaDHrq/tE/UfRocEBsFAVXGP4roNvm52hMwPoFKv2GmE85CKfk5KNUMbG/W
	YphG0NUEtvTz4RVZYVryzKfTYDQ3t+rBcF/kMZPlfjdyExmbXf6lj99gvSbm69fzMLhEwTERQhm
	Xanp3x43+8DIvq/7oFy6kNihMm1Z5hp2l+nZCSnUy3UmMW1wIjexq2kUKVu4Yt+VRZ00d5xbBz0
	LsRU8IZm7VVQVF5j6oepe36lUGZA5fHgh0SARC2oJr2k49BhpivDP7lAMsCtJ5kiWFPXXjhOq
X-Google-Smtp-Source: AGHT+IGywKOeZnJ30E7Ud2DvguwBt7x+jM+ZimZarnO2UYCjYh4k81VYRu4VVnkSvPh9Eqb3iEJtqg==
X-Received: by 2002:a05:600c:5254:b0:45f:284b:1d89 with SMTP id 5b1f17b1804b1-45f2a4f8bafmr97604315e9.25.1758031196860;
        Tue, 16 Sep 2025 06:59:56 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:56 -0700 (PDT)
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
Subject: [PATCH v4 09/12] f2fs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:57 +0200
Message-ID: <20250916135900.2170346-10-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
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
 fs/f2fs/data.c  | 2 +-
 fs/f2fs/inode.c | 2 +-
 fs/f2fs/namei.c | 4 ++--
 fs/f2fs/super.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7961e0ddfca3..9cc22322ce7f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4241,7 +4241,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
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
index b882771e4699..7d977b80bae5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -844,7 +844,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_i_links_write(inode, false);
 
 		spin_lock(&inode->i_lock);
-		inode->i_state |= I_LINKABLE;
+		inode_state_add(inode, I_LINKABLE);
 		spin_unlock(&inode->i_lock);
 	} else {
 		if (file)
@@ -1057,7 +1057,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto put_out_dir;
 
 		spin_lock(&whiteout->i_lock);
-		whiteout->i_state &= ~I_LINKABLE;
+		inode_state_del(whiteout, I_LINKABLE);
 		spin_unlock(&whiteout->i_lock);
 
 		iput(whiteout);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2045642cfe3b..d8db9a4084fa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1747,7 +1747,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *    - f2fs_gc -> iput -> evict
 	 *       - inode_wait_for_writeback(inode)
 	 */
-	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
+	if ((!inode_unhashed(inode) && inode_state_read(inode) & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
 			__iget(inode);
-- 
2.43.0


