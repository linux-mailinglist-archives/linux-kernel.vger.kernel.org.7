Return-Path: <linux-kernel+bounces-890543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F844C404AF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7F0F34D1B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B7325737;
	Fri,  7 Nov 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQGvsYob"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739B328B71
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525322; cv=none; b=ibN3yU5zCn2CG5uGgzvYBd2NBqOgel27j09HjtTiRHVfcbnm2S6v+oPIQYcCQkMXz9kA59yX3qBWI0AyMcuwKNklThPJB0mJqFPY0KYzLIMooOawuM00ZdKUI5HH+3ks1EYLxvEVsPJE/RkdGyKqdY53xM96xu4S1EVpv0ofWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525322; c=relaxed/simple;
	bh=w5deGl8WYR6YTvsLCjYxxzByC+EMu+/vV37yNkMgPrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0LuxE19K2jeuu1lsmDEj6K/FXqU2wl54iwBfjgtYeCOEObNeh8KEFTyn0F4NnN/SSQd80FyPiVaMYLTsr73iGTZdaNF1uhAoCHmomnvFkrXlsfOXZ0Eh/BqqOWuy9DLXQ/KiQ/XGut5CjtWMyED//uqTtfjl2CnBOD31L/Vi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQGvsYob; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b713c7096f9so117880466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525319; x=1763130119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsGuYQL0z7dUj/c8Asijzw9vVRg0vOPVA9pvPp5Cvak=;
        b=MQGvsYobF1Qfq4VNcrVJjK4fpntGJ/UHnsJ12xcPQYDZXH2vv5eTwPEbTFBJnR8rM5
         W5P45SGCdrHx3z0E4XcXLta8tCMHEgxSmU71CVpitaUXGv/y9Bo1+bs/m4w2GFoQPXB5
         crXI/GTe8mtCb9dyYy1sDcpzc0a+fIW7IJevUDkTIRX9ylHsN1ng5FKoV9NNRFXBha7X
         aUHFzGtL4rQo1FRlbSsbykRWW5q/CM0f86CRHt93Xn2fWWUq5yKZU/YUBwbcGvXiwPCr
         jXPGUHzQna8DzfCt1NF+qpdhSheWddB/OqMAaiMSvp1X1JrS89fI87iccFw682bFAOi5
         VIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525319; x=1763130119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsGuYQL0z7dUj/c8Asijzw9vVRg0vOPVA9pvPp5Cvak=;
        b=K2KxqVsKnmMovowdEvf6We9UHQ9DbahoWecHEabd7L5LtC+qasO6LINByF/dUs/AAS
         OfwKfRl1ySH2/gfuxrVMmNfsEYR1q7rPIqSy8uUe5ehCeJgAI6okVDr9a6bUF5cY8T/o
         QoF5Ludws3i4yq369B5EEEkAG0D3ElnttR7ZJSkyc86U5O5uLi0kstHrqlUWtBrrr0NX
         CnnsJPiuByIp+evcWMMGBEFO1aWBz9pvCeUQi4gTlaldAcc1A78v/etE/MqqRQOAWv+T
         d2fOrJU/oDdVUt/uf6w/0gIw34R61r7toUkh6Ra4tULCpItyUJ/0z6D6ifEXDfxlErO7
         EF/A==
X-Forwarded-Encrypted: i=1; AJvYcCUckxAWiMVE0kh278JtdsL0+Z3lONW5WPE8KtZ8VmEDCMG+q2o2lUO6C7qINenI8rhA3esYiXbPC34z3AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHn76Z4akEVV9p5hcFBhq2oGZLScynHU2+7QV0zYGdTVLYAb0E
	bVAJXliYFrIImkHgQeGUe6cDpI4sejHJBcXwn9Y/Aq7UnQFeTz6gNyn8
X-Gm-Gg: ASbGncs2KbiTgMfk3eaZAXyBfVb0mS96zteWC76nSU4Q2eZLHEMqVvU2nL/tZoS+237
	CR1Ct8YwWoeW617YaYi/79TfST0jonqdpdT09b8zVVOpAxzv57o0aQppxhBlyJzBKkuCPQiLDPb
	n6AncqxMXq2781aEvxJgvGvZ4YPLBBsRu7j+DT8kq+Rbyl68uc4XF58iGItqiRbPlmbJsa5Lmdq
	R8TGGYhQ3vDBHX3F9y/F5lsATP2ktjIJ4otLaLf1VLvEabD3fHBI5PZ306CCB5w9P3XbYbRAzbJ
	2ENO2f9VHMMT1DYaDbFvBd1+gaSrt0Q9bkf+hNnIXZTGU1ICrLJivsC4aqppKGyYYtwLm9KElgw
	oK3T+52ssXUopi+Qqwi0wmAVxW/O9PtZiGpLHAgIVSM632pDucQ6K+QrsS0pG35TN8VD4TBzhDS
	GWHY54hh0TYLtQHO+DcMZT02ySYq7ZCkZA6E2c/C2W3cqJBu4e
X-Google-Smtp-Source: AGHT+IHXwwL5d1Y7URBkz1tG0Tm0jTDbkcT/kc1DkCsc+QLH3dXm1w472zQlkM45EEjA0X6bID47/Q==
X-Received: by 2002:a17:907:3d16:b0:b6d:73f8:3168 with SMTP id a640c23a62f3a-b72c08dc7demr306432466b.3.1762525318659;
        Fri, 07 Nov 2025 06:21:58 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:21:58 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of MAY_EXEC
Date: Fri,  7 Nov 2025 15:21:47 +0100
Message-ID: <20251107142149.989998-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic inode_permission() routine does work which is known to be of
no significance for lookup. There are checks for MAY_WRITE, while the
requested permission is MAY_EXEC. Additionally devcgroup_inode_permission()
is called to check for devices, but it is an invariant the inode is a
directory.

Absent a ->permission func, execution lands in generic_permission()
which checks upfront if the requested permission is granted for
everyone.

We can elide the branches which are guaranteed to be false and cut
straight to the check if everyone happens to be allowed MAY_EXEC on the
inode (which holds true most of the time).

Moreover, filesystems which provide their own ->permission routine can
take advantage of the optimization by setting the IOP_FASTPERM_MAY_EXEC
flag on their inodes, which they can legitimately do if their MAY_EXEC
handling matches generic_permission().

As a simple benchmark, as part of compilation gcc issues access(2) on
numerous long paths, for example /usr/lib/gcc/x86_64-linux-gnu/12/crtendS.o

Issuing access(2) on it in a loop on ext4 on Sapphire Rapids (ops/s):
before: 3797556
after:  3987789 (+5%)

Note: this depends on the not-yet-landed ext4 patch to mark inodes with
cache_no_acl()

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c         | 43 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h | 13 +++++++------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a9f9d0453425..6b2a5a5478e7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -540,6 +540,9 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
  * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
  *
  * Separate out file-system wide checks from inode-specific permission checks.
+ *
+ * Note: lookup_inode_permission_may_exec() does not call here. If you add
+ * MAY_EXEC checks, adjust it.
  */
 static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 {
@@ -602,6 +605,42 @@ int inode_permission(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(inode_permission);
 
+/**
+ * lookup_inode_permission_may_exec - Check traversal right for given inode
+ *
+ * This is a special case routine for may_lookup() making assumptions specific
+ * to path traversal. Use inode_permission() if you are doing something else.
+ *
+ * Work is shaved off compared to inode_permission() as follows:
+ * - we know for a fact there is no MAY_WRITE to worry about
+ * - it is an invariant the inode is a directory
+ *
+ * Since majority of real-world traversal happens on inodes which grant it for
+ * everyone, we check it upfront and only resort to more expensive work if it
+ * fails.
+ *
+ * Filesystems which have their own ->permission hook and consequently miss out
+ * on IOP_FASTPERM can still get the optimization if they set IOP_FASTPERM_MAY_EXEC
+ * on their directory inodes.
+ */
+static __always_inline int lookup_inode_permission_may_exec(struct mnt_idmap *idmap,
+	struct inode *inode, int mask)
+{
+	/* Lookup already checked this to return -ENOTDIR */
+	VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode), inode);
+	VFS_BUG_ON((mask & ~MAY_NOT_BLOCK) != 0);
+
+	mask |= MAY_EXEC;
+
+	if (unlikely(!(inode->i_opflags & (IOP_FASTPERM | IOP_FASTPERM_MAY_EXEC))))
+		return inode_permission(idmap, inode, mask);
+
+	if (unlikely(((inode->i_mode & 0111) != 0111) || !no_acl_inode(inode)))
+		return inode_permission(idmap, inode, mask);
+
+	return security_inode_permission(inode, mask);
+}
+
 /**
  * path_get - get a reference to a path
  * @path: path to get the reference to
@@ -1855,7 +1894,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 	int err, mask;
 
 	mask = nd->flags & LOOKUP_RCU ? MAY_NOT_BLOCK : 0;
-	err = inode_permission(idmap, nd->inode, mask | MAY_EXEC);
+	err = lookup_inode_permission_may_exec(idmap, nd->inode, mask);
 	if (likely(!err))
 		return 0;
 
@@ -1870,7 +1909,7 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 	if (err != -ECHILD)	// hard error
 		return err;
 
-	return inode_permission(idmap, nd->inode, MAY_EXEC);
+	return lookup_inode_permission_may_exec(idmap, nd->inode, 0);
 }
 
 static int reserve_stack(struct nameidata *nd, struct path *link)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03e450dd5211..7d5de647ac7b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -647,13 +647,14 @@ is_uncached_acl(struct posix_acl *acl)
 	return (long)acl & 1;
 }
 
-#define IOP_FASTPERM	0x0001
-#define IOP_LOOKUP	0x0002
-#define IOP_NOFOLLOW	0x0004
-#define IOP_XATTR	0x0008
+#define IOP_FASTPERM		0x0001
+#define IOP_LOOKUP		0x0002
+#define IOP_NOFOLLOW		0x0004
+#define IOP_XATTR		0x0008
 #define IOP_DEFAULT_READLINK	0x0010
-#define IOP_MGTIME	0x0020
-#define IOP_CACHED_LINK	0x0040
+#define IOP_MGTIME		0x0020
+#define IOP_CACHED_LINK		0x0040
+#define IOP_FASTPERM_MAY_EXEC	0x0080
 
 /*
  * Inode state bits.  Protected by inode->i_lock
-- 
2.48.1


