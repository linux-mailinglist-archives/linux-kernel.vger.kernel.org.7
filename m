Return-Path: <linux-kernel+bounces-889222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED13C3D00B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2A7421EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44B354AC7;
	Thu,  6 Nov 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksfDpozy"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BF350D57
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452081; cv=none; b=Z69oWEMWBil8vGWXzjLyItp6LaDuSXVrFvRUJHsCIpvmYv5GxpGAHiOyFV4MGzuY5N0Lg03epM+1/uAkFYG05R+u+8wF0uH+Mf/ESvuMfeD86NNeQWLTz15UGJhuB32/zxINAvhyW7v8Y0ohzOocNI2CJ4CPUnY6L0eynkT9PP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452081; c=relaxed/simple;
	bh=5LtjXMmzmSXGmRg7hUCR8hen8AGyJaa9v1b6R+l+ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK5Dk/d2s8hlu6k4NTmykDhBiHW08S3rcqWHsb8DqbPcuPi/CHlGsfc9KGLz+zGQWg8Q17b9iXR++YSCLODEf2PZIhIQQX9gbun/n5AzNg8eCu0JvGfjmUOe58fP0EUg+1i/G7lZcD8Xbl8AQj/uHcXqFsVc5XR18gKu9tvJuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksfDpozy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b70bee93dc4so169856666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452078; x=1763056878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=ksfDpozy9aJfz/EUpiJfskYRq+dCuyo+MdyvKVLgQWYOKA3U/oP4V37TUcatiRcn0Y
         ozrykxYtA1iluwVsgqI2yDU4CiweuryNlQhk987UGvLDaVaqNt6iIHZU0dIL0t+ZYk2n
         9yWOyPgDDF8G20G/lRqwUOKML+RFuCPR2Tusw//LqaCCbupghIZbs9qdA4oBD1LKU31y
         eZDwOxRUp4Z1OQmjTIPQJU8g82bnK5yL28E7ZGT2C88GJFvZFniSzVtFfp8tpZ5ZhRDc
         78x5j6U0Hg/ekgDutVkCy6gs9MfJmepJKmjqPzXmNiywMX6OuadjvA4H8WH+WWThV1Kx
         lfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452078; x=1763056878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=kFxwsWFBh7iEHuqnacOiHT8hUv77XQTat0J/RGC5HliAwaZJLU8Wqb34wVvGuKahF6
         XLJ/rd+QwugFFKTz2jXn94MhbdxmCWxakzxiPcPa02hviaJeAZvnK8lfdJYaMUCXt4oy
         KlZ4PUAekm/svaxpGO9ab7Ab5RvghqB9pVfO8UVTqeejRbDH6OTfQk53K6sZP3JrpO2C
         bBEwXbmq2JC0mZIMlvEfXTxsU/Pxl/NE/AcvL5oIV5rGuYcsTtKh2JjBIVQF5dtno+vs
         R9ggp3FzoTkBCuHKwesQhrtjS65DbTeOEmcxzkW3ONTtFOi38FuRiLdvHHNDfc8yYkVG
         o0UA==
X-Forwarded-Encrypted: i=1; AJvYcCWpUEZ1tOPKrBmwiCM/s48UEAvTjXT15gF6EA/EgsbL5nay5kxvU5qP+PBw/xWBXYObiYCz6NdR859uWpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQnIcXDI8LFBmoJDPv6nczoVe8HSM56doHLlPXWNwoh+yGkuk
	0h3e7p0+JntU/80W4iM9b8Xz7cJK+MeH+wlXeu7hIGVoJHzCWcj+Cwbn
X-Gm-Gg: ASbGncuzisqsMDOdQJBl6aBAci8Np9Bf8rMa6xK2LiOurgZyhlhxU8KnzNJCRHXHF1k
	lVeluXAbcUeixB9BEdujbSLcBg0aihbtKamoNDxE7FAr+SSRNx8SDqR0iso2s1ufSmDGbPzR4/a
	YLyfXC8FlK7RufA4o1nbStJfFsH32an70ezxt/CKAF4jZvsLdY76w1I0tAnh5tdARI+cc9/HqYH
	rCUSYDoPvJqCOTzjnJzuMALeG+KzkMtIa4DnvSsInGZWtvJ061F1RcjqVAbVHmN7HOR/L4/1ZzD
	8nMfKMKeBWGux3Zw1A8iy/En/tlI1WJpDGwpfMzP5ITGNa8kfNb6mh1jmGMY0XM6uGgN+UAZhDi
	BoVyIbSlXICdgmhVMpOZrBYHCXa0egwzj8Xeh0TyJgV4IQVvWuUGwGN1hh4j+fVh7xfJa/n2l5b
	zlWLiJHCAmXBBN+IRe3I1ALDJwieNLgOA9q5L/Orf3H6y/226o
X-Google-Smtp-Source: AGHT+IEH7VQOvOdhRi3okWflF+KjH86D1HQeDcRUW3puSes+/n0te4BbALgaZq5PqIhcusM+kRCOPA==
X-Received: by 2002:a17:907:3f91:b0:b70:b1e6:3c78 with SMTP id a640c23a62f3a-b72c0d67c80mr3453866b.34.1762452077678;
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
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
Subject: [PATCH v2 3/4] btrfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:01 +0100
Message-ID: <20251106180103.923856-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42da39c1e5b5..42df687a0126 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5852,6 +5852,8 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode_enable_fast_may_exec(&inode->vfs_inode);
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
 }
@@ -6803,8 +6805,11 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	}
 
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!ret)
+	if (!ret) {
+		if (S_ISDIR(inode->i_mode))
+			inode_enable_fast_may_exec(inode);
 		d_instantiate_new(dentry, inode);
+	}
 
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -9163,6 +9168,11 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
+/*
+ * NOTE: in case you are adding MAY_EXEC check for directories:
+ * inode_enable_fast_may_exec() is issued when inodes get instantiated, meaning
+ * calls to this place can be elided.
+ */
 static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
-- 
2.48.1


