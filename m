Return-Path: <linux-kernel+bounces-813115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F0B540DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E3A58223B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3123D7C8;
	Fri, 12 Sep 2025 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="aUtgyfIT"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038F231832
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647600; cv=none; b=GVU5csdbeso9tKeS/PbrAyVGupUesNB5o+FoVAi0/TUQ4SChxTLKSmqqrakCqqIyT7Hh4/WPfSBsu5y9htrjcBht/xTxhyax9ymX9K9DAMTxCAzfsnwuE2T4cHsik04EfdfLYbzyBXzIhPfaaCQO6A7RcH9IRE2sBzwPQMQP/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647600; c=relaxed/simple;
	bh=rAIq+qL7shyhs1VR5VdVAx2rWh0zk7WRI811Gra4Eus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsDXXwaa0tKFT0Q8D2q2pF4WXLuKSVaxzBd2BCoWnwD2zWvREzTUE3EbJHzrz2SfoIEVyx/Cx1eQxM0f5rFV+Ft6j50NvFCzCbQhUpyeTU5VYKK9Yqp2leeThJuYr3ZkujIquuwCwJC49KrbwW4ole/m/G4Bd6aMS1DI2IZOpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=aUtgyfIT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70ddadde494so12174456d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1757647597; x=1758252397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSNhh7a2tL/8zdA8BOWdTt5FEB0UH1z8YvTHNygF404=;
        b=aUtgyfIT2Kc6R0xjzap0iTXrWq8Et+pCHIYmk8yrbeL2EfG1AgN6+WIkp8FE+bydxU
         1Emg3uH4hhCJfeA2SMPJKAvp8pbRgxpD7N20L+Lqnm9Mgt11/jiN8wYOMz1ulUZ2zg6N
         IqTEYKeVOmOFMMA8IOg6KRAr2F98NEKmH9bNRZPUrpDIAxClVrz2UhKYfOcJ9GNXRnPc
         1fgg84DvDLh5DFabAoBj6V0KcyJfTDkz/Qeqm6J/KNwkzAo/Ul2L6YQoqlOGIyHR8U73
         dRvWosFCB6PzVFNhWr4qXoX4c9q1AxpxP4ocMo52DP1kUpblIKNojN9Kmi9vh+barqkI
         3LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757647597; x=1758252397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSNhh7a2tL/8zdA8BOWdTt5FEB0UH1z8YvTHNygF404=;
        b=BkvbFq0mXFzJJKzHml7de9l5v3iVidgT3xVl09ObRwNNhc+OIvo4PRFt3e0xkC1VGn
         PG2Tb8N5ctT3V1ZreyzLdI6O582qVRfZEVrodil0GgRdtILzdDzlwBX4vDdB9QugR0v6
         1LfyUPFkc81xmMT/RW9jU87nYVHbhMcX6w1Ihb2aJjVBhR9u1uVdeuieMLBHZBdL0zTs
         XtKFG2GT4PNeijPDUAZiuxmrPmd7SB0EbCHGQDGUjyayixm/nw7Vc1XuLRavR5KcvgtM
         OeIDxr/RvOYIhZ6FczIC8U022ypfLIdcQSbwetKXlYyxKrle4dVHMX2VD8uCVevenMpT
         n1jg==
X-Forwarded-Encrypted: i=1; AJvYcCX3t4A0VW3mxpObZi77cQ9G5JtD4eds0KsVPwkzf55rRKxbg2LeMGaCR+7spb04nwPLkg4NvpnRQYwi94M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWOUj97rYLqBJvfNti7lzi2iFgCDu6rA+B2EVKbPfm+hcy8DJH
	a9kSUrisBj/6QLQtnIJQuXueo5aRCelBdn3DonkPyYpQQ7xos87pXl0iFdd7DcmXHdg=
X-Gm-Gg: ASbGncsx/5Gs2ybdsy4KRL+NVsMN0lCdrMLv0J6H1yyawLBxDnKJf9vHfNVMJxP3EKZ
	RUNQ+4hkjmPoZIefCHkd3sYU/aVCzllHrlmzix0mO7BCYZTGHOWuS1pOR/y5ROKdssW1+6vHBoo
	3dWyIBjp5pLX0JQUSn/yV/mmrEv3tJr7UV/MwESuqXqZ7ggVGrA/VhASRIrfakFBjGMjvjvsdCA
	f6LFeIwGcF3eb9kcIlSVKcXxjey8jgNUrT0m4zBol1FGgUYVdInR6GV7DaUxtTo+KMu3oLuaOEF
	xHUe4HK8eqg0VLnJF8r/3tiPS/mn0+AfK7WSa0KmSTElvpIiA8S+avLEPCWm8x3X1ngFkClB68N
	LRmMfEqfFBn7WvbI3FiOyuLDsdIoX7pdBjj/Po/n+QJisn+vS
X-Google-Smtp-Source: AGHT+IEWyzgQ0IDczfge1XGdSvFHh3UAnUiLD0HvExlChnMHU39R0qopbPI43xxuobXRtkeZ5hxQqg==
X-Received: by 2002:ad4:5fc5:0:b0:764:c753:c57a with SMTP id 6a1803df08f44-767c215c27dmr20966116d6.34.1757647596998;
        Thu, 11 Sep 2025 20:26:36 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763c19e7faesm20195776d6.72.2025.09.11.20.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 20:26:36 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cpgs@samsung.com,
	Ethan Ferguson <ethan.ferguson@zetier.com>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Thu, 11 Sep 2025 23:26:19 -0400
Message-Id: <20250912032619.9846-2-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912032619.9846-1-ethan.ferguson@zetier.com>
References: <20250912032619.9846-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls

Co-developed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
---
 fs/exfat/dir.c       | 158 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  52 ++++++++++++++
 fs/exfat/namei.c     |   2 +-
 5 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ee060e26f51d..55d826f6475d 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1244,3 +1244,161 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 
 	return count;
 }
+
+static int exfat_get_volume_label_dentry(struct super_block *sb,
+		struct exfat_entry_set_cache *es)
+{
+	int i;
+	int dentry = 0;
+	unsigned int type;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_hint_femp hint_femp;
+	struct exfat_inode_info *ei = EXFAT_I(sb->s_root->d_inode);
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+	struct buffer_head *bh;
+
+	hint_femp.eidx = EXFAT_HINT_NONE;
+	exfat_chain_set(&clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+
+	while (clu.dir != EXFAT_EOF_CLUSTER) {
+		for (i = 0; i < sbi->dentries_per_clu; i++, dentry++) {
+			ep = exfat_get_dentry(sb, &clu, i, &bh);
+			if (!ep)
+				return -EIO;
+
+			type = exfat_get_entry_type(ep);
+			if (hint_femp.eidx == EXFAT_HINT_NONE) {
+				if (type == TYPE_DELETED || type == TYPE_UNUSED) {
+					hint_femp.cur = clu;
+					hint_femp.eidx = dentry;
+					hint_femp.count = 1;
+				}
+			}
+
+			if (type == TYPE_UNUSED) {
+				brelse(bh);
+				goto not_found;
+			}
+
+			if (type != TYPE_VOLUME) {
+				brelse(bh);
+				continue;
+			}
+
+			memset(es, 0, sizeof(*es));
+			es->sb = sb;
+			es->bh = es->__bh;
+			es->bh[0] = bh;
+			es->num_bh = 1;
+			es->start_off = EXFAT_DEN_TO_B(i) % sb->s_blocksize;
+
+			return 0;
+		}
+
+		if (exfat_get_next_cluster(sb, &(clu.dir)))
+			return -EIO;
+	}
+
+not_found:
+	if (hint_femp.eidx == EXFAT_HINT_NONE) {
+		hint_femp.cur.dir = EXFAT_EOF_CLUSTER;
+		hint_femp.eidx = dentry;
+		hint_femp.count = 0;
+	}
+
+	ei->hint_femp = hint_femp;
+
+	return -ENOENT;
+}
+
+int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_name *label_out)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_entry_set_cache es;
+	struct exfat_dentry *ep;
+
+	mutex_lock(&sbi->s_lock);
+
+	memset(label_out, 0, sizeof(*label_out));
+	ret = exfat_get_volume_label_dentry(sb, &es);
+	if (ret < 0) {
+		/*
+		 * ENOENT signifies that a volume label dentry doesn't exist
+		 * We will treat this as an empty volume label and not fail.
+		 */
+		if (ret == -ENOENT)
+			ret = 0;
+
+		goto unlock;
+	}
+
+	ep = exfat_get_dentry_cached(&es, 0);
+	label_out->name_len = ep->dentry.volume_label.char_count;
+	if (label_out->name_len > EXFAT_VOLUME_LABEL_LEN) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	for (i = 0; i < label_out->name_len; i++)
+		label_out->name[i] = le16_to_cpu(ep->dentry.volume_label.volume_label[i]);
+
+unlock:
+	mutex_unlock(&sbi->s_lock);
+	return ret;
+}
+
+int exfat_write_volume_label(struct super_block *sb,
+			     struct exfat_uni_name *label)
+{
+	int ret, i;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct inode *root_inode = sb->s_root->d_inode;
+	struct exfat_entry_set_cache es;
+	struct exfat_chain clu;
+	struct exfat_dentry *ep;
+
+	if (label->name_len > EXFAT_VOLUME_LABEL_LEN)
+		return -EINVAL;
+
+	mutex_lock(&sbi->s_lock);
+
+	ret = exfat_get_volume_label_dentry(sb, &es);
+	if (ret == -ENOENT) {
+		if (label->name_len == 0) {
+			/* No volume label dentry, no need to clear */
+			ret = 0;
+			goto unlock;
+		}
+
+		ret = exfat_find_empty_entry(root_inode, &clu, 1, &es);
+	}
+
+	if (ret < 0)
+		goto unlock;
+
+	ep = exfat_get_dentry_cached(&es, 0);
+
+	if (label->name_len == 0 && ep->dentry.volume_label.char_count == 0) {
+		/* volume label had been cleared */
+		exfat_put_dentry_set(&es, 0);
+		goto unlock;
+	}
+
+	memset(ep, 0, sizeof(*ep));
+	ep->type = EXFAT_VOLUME;
+
+	for (i = 0; i < label->name_len; i++)
+		ep->dentry.volume_label.volume_label[i] =
+			cpu_to_le16(label->name[i]);
+
+	ep->dentry.volume_label.char_count = label->name_len;
+	es.modified = true;
+
+	ret = exfat_put_dentry_set(&es, IS_DIRSYNC(root_inode));
+
+unlock:
+	mutex_unlock(&sbi->s_lock);
+	return ret;
+}
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f8ead4d47ef0..329697c89d09 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -477,6 +477,9 @@ int exfat_force_shutdown(struct super_block *sb, u32 flags);
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
 extern const struct dentry_operations exfat_utf8_dentry_ops;
+int exfat_find_empty_entry(struct inode *inode,
+		struct exfat_chain *p_dir, int num_entries,
+			   struct exfat_entry_set_cache *es);
 
 /* cache.c */
 int exfat_cache_init(void);
@@ -517,6 +520,10 @@ int exfat_get_empty_dentry_set(struct exfat_entry_set_cache *es,
 		unsigned int num_entries);
 int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int sync);
 int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
+int exfat_read_volume_label(struct super_block *sb,
+			    struct exfat_uni_name *label_out);
+int exfat_write_volume_label(struct super_block *sb,
+			     struct exfat_uni_name *label);
 
 /* inode.c */
 extern const struct inode_operations exfat_file_inode_operations;
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 971a1ccd0e89..4082fa7b8c14 100644
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
+		} __packed volume_label; /* volume label directory entry */
 		struct {
 			__u8 flags;
 			__u8 vendor_guid[16];
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 538d2b6ac2ec..f246cf439588 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -486,6 +486,54 @@ static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
 	return exfat_force_shutdown(sb, flags);
 }
 
+static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long arg)
+{
+	int ret;
+	char label[FSLABEL_MAX] = {0};
+	struct exfat_uni_name uniname;
+
+	ret = exfat_read_volume_label(sb, &uniname);
+	if (ret < 0)
+		return ret;
+
+	ret = exfat_utf16_to_nls(sb, &uniname, label, uniname.name_len);
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user((char __user *)arg, label, ret + 1))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int exfat_ioctl_set_volume_label(struct super_block *sb,
+					unsigned long arg)
+{
+	int ret = 0, lossy;
+	char label[FSLABEL_MAX];
+	struct exfat_uni_name uniname;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(label, (char __user *)arg, FSLABEL_MAX))
+		return -EFAULT;
+
+	memset(&uniname, 0, sizeof(uniname));
+	if (label[0]) {
+		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
+					 &uniname, &lossy);
+		if (ret < 0)
+			return ret;
+		else if (lossy & NLS_NAME_LOSSY)
+			return -EINVAL;
+	}
+
+	uniname.name_len = ret;
+
+	return exfat_write_volume_label(sb, &uniname);
+}
+
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -500,6 +548,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index f5f1c4e8a29f..eaa781d6263c 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -300,7 +300,7 @@ static int exfat_check_max_dentries(struct inode *inode)
  *   the directory entry index in p_dir is returned on succeeds
  *   -error code is returned on failure
  */
-static int exfat_find_empty_entry(struct inode *inode,
+int exfat_find_empty_entry(struct inode *inode,
 		struct exfat_chain *p_dir, int num_entries,
 		struct exfat_entry_set_cache *es)
 {
-- 
2.34.1


