Return-Path: <linux-kernel+bounces-772302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D100B29105
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 02:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3B97B24ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 00:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC71487ED;
	Sun, 17 Aug 2025 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="a9/N9X3A"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDB83CC7
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755390668; cv=none; b=dUFrviedn9DsMEh8EEB7Zr4m5ImtuLsJbznfMoZrohGZuJwXtRXOfSOFUNekYRSJ0QcpoW91FB5jWR3fwDzsiJ836UVbgWB3bXC/3lRiPYoRRDiczGVbmTGZhAPKoq8Wo/nOk5ErRjgCKb4rrr3Pbk9hnuovJar/zvZqj7gLEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755390668; c=relaxed/simple;
	bh=Vu2m/Gloo/Gq5O5egK9ONMehCPuYhaGAnYaEh8ktB6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EN94osF/L06Nk1Od7jwYPifIkiDbBh2DaZOA5Jx21mflSlqsh6Olu3SK3EvJoSZaQpH7440gPgIAXEd1ou/+anNKCZAX+H3fmZ7yOUJUe/JVBWU7B7J9UOOa7zJght+IyvV8G/Xo3TupPcIvneBsXNbkOkLsAEERIv6mL36e3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=a9/N9X3A; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e8704e9687so337184485a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755390666; x=1755995466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy1/zvuC4+goM8wozcoBMWOiVW+TcsBSAjjXJc9QiE8=;
        b=a9/N9X3AVjmpmPcB5+zVdW1pDp9I1xFbMzgcmr/2M6bAofIUJXjptfodY8b/bv24X/
         w4UZnANmipo628brzQX1OOKk6qTJLrY1S3YXj+4sjiCLb4w3ERXLyP90kyH9SHKotjoT
         A6QVYh9k4WwbC/0Z3jvtyjavwPsGET1Favio0DyFtZwnhYwFA5BnQd++uLD4Nid1vMsi
         eW3fxBxk7YJ5B/OYdpjI/UKYsqn+JyNliZMXXzvdARferkqcSxFldBO3lE4irAIEF/4p
         +anO6PRlDiDbIOVDY7nXpYDbCEXEoHGPNVz+NoAYwBYvGEg/09L4l4Hy3T8mUlPLeZmv
         uhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755390666; x=1755995466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy1/zvuC4+goM8wozcoBMWOiVW+TcsBSAjjXJc9QiE8=;
        b=d1m107Dojl4IYXKNxiwdFk77CeU0kt6CyiUMV+k+T280I5e6y/YLThWRIYa8xrpmWK
         FpdBHKYHBLpPxYZouOBMCzs2iEn8oY1cbKYuA5DiAd8/JtLPePivluIK2gXC0t66InIr
         sVJRFs/R8/laX1ZwSrMn2g7PUFFB8YkLuBIiD5mzsm9Wwun8qt/ba7DaB84r410HTZ3n
         7NGDG6xuuIwt3eeBIWnyrtIQFhwwpIlIcvqyMD/w+A0a2B0CV8B8v2GYF4ofRATUgTTx
         MyVXxn85bd3YNMKtSb0JkEHjhOd7Ps70waTJ4oAoNGN6ZF0Hmdiagf2SKyCwMlILw0UD
         Gc8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/p8WQbM4qSq7xXRN3ZMRbRbeUErPL2AEp37w5s1mI6W27PDun9x2TixcRnDF7H9wSwp7SMIUC+i2fh0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnO94GvRw43wLMmXc1u1HSbXSm20kEqf7Et5m4h+4nsjJHx5H
	DW/el/0jDEIGgQYpkjANndLiPiIvERNlrHF+7JAibFGqAq/yx0tBzB2NKbn+1i5h1go=
X-Gm-Gg: ASbGnctQPSEaZ/fir4y1B7uCdZfXEgMcIpyf23/5m3HVVm+U9fNoXVCNiTc5UH+E3dh
	hOtSBFqMyWhY+qPi1OqW9NchFZRVtxa4KCu3Rq92Oqlf/uO4cbD8PfBZzlp+a3VlZINIX3Ed+Rz
	zQGciDeBkFIxa3nw3IpGFmPtbTYP1FYvf2pm27Sc+51Jof/aLQwjCmxPray554q7A9GP9LjcMSs
	5hd1x9epgdDtfLLjtPQIYl6t+SIOWxqUULEUYF8/wme13Ii2uCZ+NbLzq31Xn/SBlHiJStTHDmU
	mJlsUGY8CIJogc610ZtsaQ1JCEx+hRJFUixhSEo4fjLbAYOSLvfjzk3tHMG5U0R9f/seu3HCM6T
	xzwuaU3tYSw95QGiDnTxav5Sc102FC9M77VxGVw==
X-Google-Smtp-Source: AGHT+IFUEEG3aNG7TFNiJw1J5Pdf2J2ZLkFUnQ4Xcc0NaWWwKnAm7udVxn1hKUYfQsRw9aJcImUFNA==
X-Received: by 2002:a05:620a:4043:b0:7e6:2f6a:5bae with SMTP id af79cd13be357-7e87e137b50mr1128487285a.62.1755390665845;
        Sat, 16 Aug 2025 17:31:05 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c42e5sm342402885a.65.2025.08.16.17.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 17:31:05 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Sat, 16 Aug 2025 20:30:46 -0400
Message-Id: <20250817003046.313497-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250817003046.313497-1-ethan.ferguson@zetier.com>
References: <20250817003046.313497-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>

---
 fs/exfat/exfat_fs.h  |  2 +
 fs/exfat/exfat_raw.h |  6 +++
 fs/exfat/file.c      | 56 +++++++++++++++++++++++++
 fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..a764e6362172 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -267,6 +267,7 @@ struct exfat_sb_info {
 	struct buffer_head **vol_amap; /* allocation bitmap */
 
 	unsigned short *vol_utbl; /* upcase table */
+	unsigned short volume_label[EXFAT_VOLUME_LABEL_LEN]; /* volume name */
 
 	unsigned int clu_srch_ptr; /* cluster search pointer */
 	unsigned int used_clusters; /* number of used clusters */
@@ -431,6 +432,7 @@ static inline loff_t exfat_ondisk_size(const struct inode *inode)
 /* super.c */
 int exfat_set_volume_dirty(struct super_block *sb);
 int exfat_clear_volume_dirty(struct super_block *sb);
+int exfat_write_volume_label(struct super_block *sb);
 
 /* fatent.c */
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 971a1ccd0e89..af04cef81c0c 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -80,6 +80,7 @@
 #define BOOTSEC_OLDBPB_LEN		53
 
 #define EXFAT_FILE_NAME_LEN		15
+#define EXFAT_VOLUME_LABEL_LEN		11
 
 #define EXFAT_MIN_SECT_SIZE_BITS		9
 #define EXFAT_MAX_SECT_SIZE_BITS		12
@@ -159,6 +160,11 @@ struct exfat_dentry {
 			__le32 start_clu;
 			__le64 size;
 		} __packed upcase; /* up-case table directory entry */
+		struct {
+			__u8 char_count;
+			__le16 volume_label[EXFAT_VOLUME_LABEL_LEN];
+			__u8 reserved[8];
+		} __packed volume_label;
 		struct {
 			__u8 flags;
 			__u8 vendor_guid[16];
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 538d2b6ac2ec..c57d266aae3d 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -486,6 +487,57 @@ static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
 	return exfat_force_shutdown(sb, flags);
 }
 
+static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long arg)
+{
+	int ret;
+	char utf8[FSLABEL_MAX] = {0};
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	size_t len = UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_LEN);
+
+	mutex_lock(&sbi->s_lock);
+	ret = utf16s_to_utf8s(sbi->volume_label, len,
+				UTF16_HOST_ENDIAN, utf8, FSLABEL_MAX);
+	mutex_unlock(&sbi->s_lock);
+
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int exfat_ioctl_set_volume_label(struct super_block *sb, unsigned long arg)
+{
+	int ret = 0;
+	char utf8[FSLABEL_MAX];
+	size_t len;
+	unsigned short utf16[EXFAT_VOLUME_LABEL_LEN] = {0};
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX))
+		return -EFAULT;
+
+	len = strnlen(utf8, FSLABEL_MAX);
+	if (len > EXFAT_VOLUME_LABEL_LEN)
+		exfat_info(sb, "Volume label length too long, truncating");
+
+	mutex_lock(&sbi->s_lock);
+	ret = utf8s_to_utf16s(utf8, len, UTF16_HOST_ENDIAN, utf16, EXFAT_VOLUME_LABEL_LEN);
+	mutex_unlock(&sbi->s_lock);
+
+	if (ret < 0)
+		return ret;
+
+	memcpy(sbi->volume_label, utf16, sizeof(sbi->volume_label));
+
+	return exfat_write_volume_label(sb);
+}
+
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -500,6 +552,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return exfat_ioctl_shutdown(inode->i_sb, arg);
 	case FITRIM:
 		return exfat_ioctl_fitrim(inode, arg);
+	case FS_IOC_GETFSLABEL:
+		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
+	case FS_IOC_SETFSLABEL:
+		return exfat_ioctl_set_volume_label(inode->i_sb, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8926e63f5bb7..96cd4bb7cb19 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -18,6 +18,7 @@
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/magic.h>
+#include "../nls/nls_ucs2_utils.h"
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -573,6 +574,98 @@ static int exfat_verify_boot_region(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_get_volume_label_ptrs(struct super_block *sb,
+				       struct buffer_head **out_bh,
+				       struct exfat_dentry **out_dentry)
+{
+	int i;
+	unsigned int type;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+
+	clu.dir = sbi->root_dir;
+	clu.flags = ALLOC_FAT_CHAIN;
+
+	while (clu.dir != EXFAT_EOF_CLUSTER) {
+		for (i = 0; i < sbi->dentries_per_clu; i++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh);
+
+			if (!ep)
+				return -EIO;
+
+			type = exfat_get_entry_type(ep);
+			if (type == TYPE_UNUSED) {
+				brelse(bh);
+				return -EIO;
+			}
+
+			if (type == TYPE_VOLUME) {
+				*out_bh = bh;
+				*out_dentry = ep;
+				return 0;
+			}
+
+			brelse(bh);
+		}
+
+		if (exfat_get_next_cluster(sb, &(clu.dir)))
+			return -EIO;
+	}
+
+	return -EIO;
+}
+
+static int exfat_read_volume_label(struct super_block *sb)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	struct exfat_dentry *ep;
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
+	if (ret < 0)
+		goto cleanup;
+
+	for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
+		sbi->volume_label[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
+
+cleanup:
+	if (bh)
+		brelse(bh);
+
+	return ret;
+}
+
+int exfat_write_volume_label(struct super_block *sb)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct buffer_head *bh;
+	struct exfat_dentry *ep;
+
+	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep);
+	if (ret < 0)
+		goto cleanup;
+
+	mutex_lock(&sbi->s_lock);
+	for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
+		ep->dentry.volume_label.volume_label[i] = cpu_to_le16(sbi->volume_label[i]);
+
+	ep->dentry.volume_label.char_count =
+		UniStrnlen(sbi->volume_label, EXFAT_VOLUME_LABEL_LEN);
+	mutex_unlock(&sbi->s_lock);
+
+cleanup:
+	if (bh) {
+		exfat_update_bh(bh, true);
+		brelse(bh);
+	}
+
+	return ret;
+}
+
 /* mount the file system volume */
 static int __exfat_fill_super(struct super_block *sb,
 		struct exfat_chain *root_clu)
@@ -616,6 +709,12 @@ static int __exfat_fill_super(struct super_block *sb,
 		goto free_bh;
 	}
 
+	ret = exfat_read_volume_label(sb);
+	if (ret) {
+		exfat_err(sb, "failed to read volume label");
+		goto free_bh;
+	}
+
 	ret = exfat_count_used_clusters(sb, &sbi->used_clusters);
 	if (ret) {
 		exfat_err(sb, "failed to scan clusters");
-- 
2.50.1


