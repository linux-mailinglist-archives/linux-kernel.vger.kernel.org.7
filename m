Return-Path: <linux-kernel+bounces-862696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B945BF5EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3B550104C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5E32E15E;
	Tue, 21 Oct 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c3RAl8th"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BE32D425
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044384; cv=none; b=TMPGhO2njoGc7IIHy0LIbIaWUzCWYIEaHK2cqJi7efyjY86rIuEx5D3p9uy9YRTCyxvJnmxs7zF9cKKu2yaNbgvMeg1gbgblQUxX2YyZxVdH5W6Yw6RzlSS3dcwi1b0qWP5+i54Tz8d2izGrigIU6/PxqL7vKzkNe9DQTmCFgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044384; c=relaxed/simple;
	bh=6ltMIJOMRUnLqgkD+4BfTH80suRtsHd4Crs9+gCuy8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7qbrPbJs8wTBWKsdL9zJoyZ0t6X8Km8Vp+WgNeM6R6AD6vmfCdP8p+AOWLgYJe96vCvzlIXBqodsLlT4wZqy9bAfqS0Y7UqlbGM2Q+Mdt9sxzPAy9VdG7YPdgDz4VbBZcLND01SHGhmF4K4QfQADD7Eh0glDwgsQf9NmNa+JPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c3RAl8th; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=p0DA4pa48eyEbYiRWGDSuEKqCbnb228fv9F0XYlpl/o=;
	b=c3RAl8th+kW+FpwaciR5if0MoXyaCirYght7JKovA7Tel97DCAC/JPwtzajnvz8jLza93+C2w
	Z9IvQV++/TaxRv6obU7r5TNVONNy78bN3lBaVdgIceMnWMHRNMPm5JQFDrU4MTi6p+lHp63Lu6k
	lItn9MUpfLaOD987I1W3QsQ=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4crTn76SR9z12LDD;
	Tue, 21 Oct 2025 18:58:51 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AD0B140155;
	Tue, 21 Oct 2025 18:59:33 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 18:59:33 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<hongzhen@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC v7 2/7] erofs: support user-defined fingerprint name
Date: Tue, 21 Oct 2025 10:48:10 +0000
Message-ID: <20251021104815.70662-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251021104815.70662-1-lihongbo22@huawei.com>
References: <20251021104815.70662-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

When creating the EROFS image, users can specify the fingerprint name.
This is to prepare for the upcoming inode page cache share.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
[hongbo: forward port, minor fixes and cleanup]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/Kconfig    | 10 ++++++++++
 fs/erofs/erofs_fs.h |  6 ++++--
 fs/erofs/internal.h |  6 ++++++
 fs/erofs/super.c    |  3 ++-
 fs/erofs/xattr.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/xattr.h    |  6 ++++++
 6 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index d81f3318417d..ef30cb452244 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -194,3 +194,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_INODE_SHARE
+	bool "EROFS inode page cache share support"
+	depends on EROFS_FS && EROFS_FS_XATTR
+	default n
+	help
+	  This permits EROFS to share page cache for files with same
+	  fingerprints.
+
+	  If unsure, say N.
\ No newline at end of file
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3d5738f80072..f6ea8c35db45 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -35,8 +35,9 @@
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
 #define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
+#define EROFS_FEATURE_INCOMPAT_ISHARE_KEY	0x00000200
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
+	((EROFS_FEATURE_INCOMPAT_ISHARE_KEY << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -86,7 +87,8 @@ struct erofs_super_block {
 	__u8 reserved[3];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
-	__le64 reserved2;
+	__le32 ishare_key_start;	/* start of ishare key */
+	__le32 reserved2;
 	__le64 metabox_nid;     /* (METABOX on) nid of the metabox inode */
 	__le64 reserved3;	/* [align to extslot 1] */
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index eac067446140..245b9e3897bc 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -167,6 +167,11 @@ struct erofs_sb_info {
 	struct erofs_domain *domain;
 	char *fsid;
 	char *domain_id;
+
+	/* inode page cache share support */
+	u32 ishare_key_start;
+	int ishare_key_idx;
+	char *ishare_key;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -232,6 +237,7 @@ EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
+EROFS_FEATURE_FUNCS(ishare_key, incompat, INCOMPAT_ISHARE_KEY)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 EROFS_FEATURE_FUNCS(shared_ea_in_metabox, compat, COMPAT_SHARED_EA_IN_METABOX)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f9d8f978bf81..283449024996 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -339,7 +339,7 @@ static int erofs_read_superblock(struct super_block *sb)
 			return -EFSCORRUPTED;	/* self-loop detection */
 	}
 	sbi->inos = le64_to_cpu(dsb->inos);
-
+	sbi->ishare_key_start = le32_to_cpu(dsb->ishare_key_start);
 	sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
 	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
 	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
@@ -738,6 +738,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	erofs_xattr_set_ishare_key(sb);
 	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..6610c007ee4c 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -564,3 +564,50 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
 	return acl;
 }
 #endif
+
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+void erofs_xattr_set_ishare_key(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	struct xattr_handler const *handler;
+	erofs_off_t pos;
+	char *key;
+	int len, i;
+	void *ptr;
+
+	if (!erofs_sb_has_fragments(sbi) || !erofs_sb_has_ishare_key(sbi) ||
+	    !sbi->packed_inode)
+		return;
+
+	buf.mapping = sbi->packed_inode->i_mapping;
+	pos = sbi->ishare_key_start << 2;
+	(void)erofs_init_metabuf(&buf, sb, false);
+	ptr = erofs_read_metadata(sb, &buf, &pos, &len);
+
+	if (IS_ERR(ptr))
+		goto out;
+
+	for (i = 0; ARRAY_SIZE(erofs_xattr_handlers) - 1; i++) {
+		handler = erofs_xattr_handlers[i];
+		if (!handler)
+			break;
+		if (!memcmp(handler->prefix, ptr, strlen(handler->prefix)))
+			break;
+	}
+
+	if (!handler)
+		goto out;
+
+	len -= strlen(handler->prefix);
+	key = kzalloc(len + 1, GFP_KERNEL);
+	if (!key)
+		goto out;
+
+	memcpy(key, ptr + strlen(handler->prefix), len);
+	sbi->ishare_key = key;
+	sbi->ishare_key_idx = handler->flags;
+out:
+	erofs_put_metabuf(&buf);
+}
+#endif
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 6317caa8413e..99c4674cfd51 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -67,4 +67,10 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu);
 #define erofs_get_acl	(NULL)
 #endif
 
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+void erofs_xattr_set_ishare_key(struct super_block *sb);
+#else
+static inline void erofs_xattr_set_ishare_key(struct super_block *sb) {}
+#endif
+
 #endif
-- 
2.22.0


