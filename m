Return-Path: <linux-kernel+bounces-818954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D6B598BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3E218812F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB0353355;
	Tue, 16 Sep 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHs4mrtt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A6350D62
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031198; cv=none; b=g9CDP4b91QA1NP/wwozHFbIYVEEFgAuExSQr7nylQ5t/4IhWUjui4RsQfL4gE2dieV3Ajpwwkg+oNKHz9Q/uNDYrOTbGbu8sj5tckNS/FQ1Mv+dop2ZaSg9cUuWbeGCFlR2lU7Dv/UrdzlaXIv6JCdRSwxIGD2ZGP/QiDJzAY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031198; c=relaxed/simple;
	bh=zZiNEsc0ou9dLfivP9Aqc6NzCGoV3keb+6tsUnteUdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwTeUjk/PX6OGVob6YnArsBgCwD1p0bX8dbm56xMo/vJiEcivMhxQbEXL9Nr8erc29njDEZQ1mLb2Jjt0AiXx+aD80Iup+qmHJePOjx4/ma6HxFXA9OyChb+I8UjGxo/x1xaYPgVkALOhjJ6lJbXmZ+vdM8eAnOghfN+cKqBE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHs4mrtt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so16788425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031193; x=1758635993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH7uZiHjx4atLUKz523xg3qFPyZEu5cyZb0AVULMuO0=;
        b=RHs4mrttSYB9GRGRbp9KqwYnMiUEDNugTDAhLFQoZojDS0ZgoU0Va7b9gY3Cc6pZ5b
         O3vJ1KheImXyWj+71MZD2sM8nrtiHieuI7KAcKS+ocl/x1fgN72+vwL1gpGT3q7S0xUj
         kihoI5B07V5J9Jv920/X4pxFRd3zyvaFMV1k2nejn9ujA6hCbYP3rzyKP+UScJ3SsA08
         62/eowIVfhzLFP90sKACmqejcwZKcgViHQKCLqXMu9ZQkEjN9VvDOySElFYfZqqBuwXT
         +Cw2ILPMdQe4+tCLLSzTQ+VIZxbC+TvQxRp9meBAcR3quDq8MTBlcazdBJuOZcJoPJ/i
         lkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031193; x=1758635993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BH7uZiHjx4atLUKz523xg3qFPyZEu5cyZb0AVULMuO0=;
        b=SZvWZIKNQbsFbwmmD/Z/ml2kCe2K0/T3Ugk0Bfx3Q0iitJIqzCQkPG3gcx45EcChk6
         zlhIk48V2eMcep3ibphr+Q7VgF8GLOnWzq3zpOkKLCaKVE8kzSl29yulW8uSq0Qsn8bo
         I/RssCYom/VG3l75J4vPA5Jnj4P+FP44ZMr3hSG0dHoYRkDdRWsvwopMHiJOWaVxHW5M
         7vRbVB5Obusr3/Je4xuAvNGu8cj5R1Sne9gJ3IGBJ8J0dcP2EKwsVgiXtHb2Qcf7ZZc3
         Jc6CX5Ix/nBMd2BYNgE6UP+w/E/FzoZ0ArCaGr4CbUjFC46W2utCQEfYyMeZ5Np9YF9M
         FVtw==
X-Forwarded-Encrypted: i=1; AJvYcCWDa0WvO8d4f+ih54XADHVDf6Cv/srxhtYvH+oScT85tk7QOaPwCIpWHn0eKKZivG8Y6qUZLQybtJvUtdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwVTIkqaRNcZRRBWxWX5v2SWODqcI1AG/XRFdmWyGh8DLjfxZ
	Q3DME6wvlFUEATR16VpZ4g6ujzwQKSWb5L0PlwaLSkGnYWa6jdCUNXos
X-Gm-Gg: ASbGncvNzHtXR+6650DWp1MQHcZFXol5qNABAAEDgcD/wls4BbhWA0HrhpzweeN9yrf
	iIs8zEcGS99MgAthzJGxekug5f3+HlXhADPTwz36/zEkd3XYtr9aDO/pCdAz88kJQg2GHfrg9CR
	oQTM3Tg5XItoJ6RAhx2WzClqkyiUmTgAKQcGfYCTecTMmhFod9YXV1C5/8xQny95ATcFpNQt1Tq
	pbqARfFvinWhmxyne3b34DPWhJ7i8nMQPJ23//BN0huDBfJ6nF1Qc4yb7knUA7G31/1n6N0/Lem
	JFtg2y6UHVpqPVSKBVN0gmXzmsBNr4W8qrveMFwMGr5/ButNVElfbpqAUDt6FbHbUXCJDa/O3ZY
	35ej+Toxp06/eDbXGW0uOPpQble2AQhk4g9fxVv54Uh5EuVUUzLx7D+vUj/F4UuRKwWZmh/E1
X-Google-Smtp-Source: AGHT+IHChUM15w8rTVndIAcblUfNQKZjE5Ckd1Ezw+ggkuImQMYHH2MYJMg1j8qo3nE46VliCumLGA==
X-Received: by 2002:a05:600c:584d:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-45f211d55aamr122328095e9.14.1758031192933;
        Tue, 16 Sep 2025 06:59:52 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:52 -0700 (PDT)
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
Subject: [PATCH v4 08/12] ext4: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:56 +0200
Message-ID: <20250916135900.2170346-9-mjguzik@gmail.com>
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

cheat sheet:
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

 fs/ext4/inode.c  | 10 +++++-----
 fs/ext4/orphan.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ed54c4d0f2f9..f5b652613f2e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    (inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
@@ -3473,7 +3473,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	/* Any metadata buffers to write? */
 	if (!list_empty(&inode->i_mapping->i_private_list))
 		return true;
-	return inode->i_state & I_DIRTY_DATASYNC;
+	return inode_state_read_once(inode) & I_DIRTY_DATASYNC;
 }
 
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode_state_read_once(inode) & (I_NEW | I_FREEING)))
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
@@ -5239,7 +5239,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		ret = check_igot_inode(inode, flags, function, line);
 		if (ret) {
 			iput(inode);
@@ -5570,7 +5570,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 	if (inode_is_dirtytime_only(inode)) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 7c7f792ad6ab..10eeb025380f 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_once(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +236,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_once(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
-- 
2.43.0


