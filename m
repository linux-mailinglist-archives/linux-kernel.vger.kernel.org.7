Return-Path: <linux-kernel+bounces-849026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6EBCF08C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21B33AB2EB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0FE221FAC;
	Sat, 11 Oct 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="decIIU/7"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500291A7AE3
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164722; cv=none; b=Ar0DWzzoQZkjhpwvVorabv9z2UHkFb/HFOQ5H/VNowWyJwWQJscIiPolfE8banX7xeh+/AHk0oVAQ7VAtvL60SiP3gFRcMZCqQb7Aq+PVZtzt+wxncdLIksn/5oxKFXgdiHz/hqS+Ew4Il+/EzS8gu2Gx0f74yk7J1PLlmyPgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164722; c=relaxed/simple;
	bh=LjdMP4wX5K2PJoIkDNssZ0x5qpw4jYUvKfOFzldt+78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leRkfqeqxE509+rNiTrvOJGFUWY72RiHxafVPS+vLAyJ1675GFT8gInXuSp0xH+WlewpREQQ+GYMxTqd9eWxhqK119i561QyyCllxLAK1i0L1NdPj6+3h+nzjF0UAjde5/R/NgJTDqI9ABD906nEgeRmpjXmNvU+znDZCTH92ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=decIIU/7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33833a0a58cso479784a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760164720; x=1760769520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4KsdyrgfWB/FqT6OOcbFSO1XBvuLxrHfzAVePQ1iTY=;
        b=decIIU/7mEcJBYlwWbXUi7CyqhPn2bqONs86NcMs4yZ8v40vy95Pp8EXXBdCbhim6R
         1/A6YfAiKaeguMLCJ7wukvmh9c9iRqNGQAJebMu040WCSw9PT2nIgvreKlAKZKFcTEWt
         3jUYy61zKCuwsdmlU87zZvoCvhr2TkusC0Z4/3tyBNvlWBp0fhKWX6XmRp/cdwwbHWyG
         10S3I5tjmefWq2MVe3GUrne03Le4U15ukBXEGpQudijXHLCXWuGMUPHXhLeba918dmyn
         GAhS8mjS/UxYHO8up2PL15Un7f0nYSNjUuAE8eoBm3fi5ubyxZn7hgHGwN0TVfZco/S+
         6P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760164720; x=1760769520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4KsdyrgfWB/FqT6OOcbFSO1XBvuLxrHfzAVePQ1iTY=;
        b=v5QQTpPA+HLalQzpABIQtGSllfGQT5wSPRp9wuDOGHyw6JRBSWqaBdPIuwlZrnQMy3
         xUrNRb277T0PKya15rxr/xQM/qQC+tN5+WtjaV077zvSitIi4b39y7jiryGXebxdj8IF
         8opKiesIJF+fkmpByBXJYDVZfimF4OKJaRHJ3WZ0jXMXTj4ghqb06BAFmW7DbBpyUG6t
         y590xBeSNmHIozeOj0OOosfg0Uh7VEq/O9m8yUrCjk1vVpU8nw7BmHbLYRB2LW1CdSOY
         pRwCvae3UhrMrMQyf6hLSoSvCSkGCbQ0vp6oWiNDdS3RDm/CYkl0n8nYVS3NsAwBYTeA
         zblw==
X-Forwarded-Encrypted: i=1; AJvYcCVoyFtd682zDKcrP5QFnagtYpQMyJk0JR6gEMBOsBL9NWC+xiUHSk4PGCC37mlNRExOZk5gtwHBkqUZWwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTG4S1FR+izChDlBMejy7rMrkezZKb/MBhmt+xNnK9/eHkhUA
	PXgepPOHDBsYmq13vmV8rvSYRDpZx2QTefKnBtT4d6W2foZegWU7s+VX
X-Gm-Gg: ASbGncvYwGHl7isE9EQPAbwRspUCsxiQ2XmpItw2vI2OhXENk7UM0nNgQpJczh6s0Yg
	v+kf8u+Dc2PAL2/rBEpRqT1iBOeJ1tvMNoRj1HqhFQV5MmM4vZGQQZkwoyAl2KshVgmJnn5XO8q
	FMLGPN/P9f9lV9fF6rf3rKW9gutE1RFU+1gTlcVJ3pgV6xWmqsR8VrU/H3Pk+NX/ZmmOz5xuSb/
	71xIWFuIKZNotXkSkxMPVwLcLzmtaE+8wsmrErI2FqmkW5LAQ150/cUdcIqEWm/JMWGWkpJwCmo
	FrcLtjkpL1Y6j/r1LvCR6/3ge2MrNM8oum33QQvcT0LxCrO0iNwHlk9jWiI87/NJB7HBy8llxF/
	gn8tX88821+azBDlgBs792x5UEONNifOkans+9lJ5VpPf4tRP
X-Google-Smtp-Source: AGHT+IF1JQXObCuG7xFhogMbxfyVhO5SQR9FmzcjivYXOk8ZFuH6BJG6HLBb/IJlGVfYnt4qekicwg==
X-Received: by 2002:a17:903:1a6f:b0:257:3283:b859 with SMTP id d9443c01a7336-29027321d06mr119587995ad.9.1760164720383;
        Fri, 10 Oct 2025 23:38:40 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:ffd0:8dcb:f5b3:8234:d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea083sm76040465ad.24.2025.10.10.23.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 23:38:39 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: lkp@intel.com
Cc: adilger.kernel@dilger.ca,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	skhan@linuxfoundation.org,
	tytso@mit.edu,
	vnranganath.20@gmail.com
Subject: [PATCH v2] fs: ext4: fix uninitialized symbols
Date: Sat, 11 Oct 2025 12:08:29 +0530
Message-ID: <20251011063830.47485-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202510110207.yBvUMr5Z-lkp@intel.com>
References: <202510110207.yBvUMr5Z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue detected by the smatch tool.

fs/ext4/inode.c:3583 ext4_map_blocks_atomic_write_slow() error: uninitialized symbol 'next_pblk'.
fs/ext4/namei.c:1776 ext4_lookup() error: uninitialized symbol 'de'.
fs/ext4/namei.c:1829 ext4_get_parent() error: uninitialized symbol 'de'.
fs/ext4/namei.c:3162 ext4_rmdir() error: uninitialized symbol 'de'.
fs/ext4/namei.c:3242 __ext4_unlink() error: uninitialized symbol 'de'.
fs/ext4/namei.c:3697 ext4_find_delete_entry() error: uninitialized symbol 'de'.

These changes enhance code clarity, address static analysis tool errors.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---

v2:
corrected the kernel test robot noticed build errors.

 fs/ext4/inode.c |  2 +-
 fs/ext4/namei.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..f20db3f4ef68 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3544,7 +3544,7 @@ static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
 	ext4_lblk_t m_lblk = map->m_lblk;
 	unsigned int m_len = map->m_len;
 	unsigned int mapped_len = 0, m_flags = 0;
-	ext4_fsblk_t next_pblk;
+	ext4_fsblk_t next_pblk = 0;
 	bool check_next_pblk = false;
 	int ret = 0;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e3..045616033515 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1762,7 +1762,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 	struct buffer_head *bh;
 
 	if (dentry->d_name.len > EXT4_NAME_LEN)
@@ -1818,7 +1818,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 struct dentry *ext4_get_parent(struct dentry *child)
 {
 	__u32 ino;
-	struct ext4_dir_entry_2 * de;
+	struct ext4_dir_entry_2 * de = NULL;
 	struct buffer_head *bh;
 
 	bh = ext4_find_entry(d_inode(child), &dotdot_name, &de, NULL);
@@ -3133,7 +3133,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	int retval;
 	struct inode *inode;
 	struct buffer_head *bh;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 	handle_t *handle = NULL;
 
 	retval = ext4_emergency_state(dir->i_sb);
@@ -3224,7 +3224,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 {
 	int retval = -ENOENT;
 	struct buffer_head *bh;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 	handle_t *handle;
 	int skip_remove_dentry = 0;
 
@@ -3688,7 +3688,7 @@ static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
 {
 	int retval = -ENOENT;
 	struct buffer_head *bh;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 
 	bh = ext4_find_entry(dir, d_name, &de, NULL);
 	if (IS_ERR(bh))
-- 
2.43.0


