Return-Path: <linux-kernel+bounces-720687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6CAFBF3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E69E4A5707
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D211494D9;
	Tue,  8 Jul 2025 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksBYJykc"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0112CD8B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934925; cv=none; b=HQ7UlLUTvJRPcqJXvc7YE3GgYjxPNwVsN3nYofw079wDvvLdOQ9ScHN873tNOZdDFhzwEHW8ilDc49sXbk6oWptM7MUbflB77zbU9wzejF6tfa88ItqpaODOuJCAfNIbX1uIS+oMgncqZu+hCOrKUf3C2lnRADBC49Cmv2BK6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934925; c=relaxed/simple;
	bh=wQYFt5K7RXr92fANj8A5bbXj6ZGgg/VTbMPoUP1YZYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeGCewDKIl/DyO7pti6sT4gAiBDTLowD6vhnQUPzF3fZKH7jp3kUK9zBwLKPmDWZbdBQ6J10Ajrj7zUv1r7awAtJNDKSRJGvw9Lz5bjvI3jURTMydrW58I3S8KCKPNKchPh4kYqMZwaLg5/6/d1qJsuWRGG4GL+NS8xWk1+QO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksBYJykc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313154270bbso3870713a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751934923; x=1752539723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wf3o4V2I80SyK6m01qE6WqU7O8JhAfMNmh4JIjwVcuk=;
        b=ksBYJykcWqGzf6Qf9ZnZE58H1OaS/BQkHjsmFV2AT7vR74EDwAZ2lWp9OaGkFpdQN+
         oooU88S3ksmUh7ztXsWvLzo80Y2TV9PQKhxzIL2vm24clvAe6JUGzoiy6xa5/vU9CGIp
         4dJ/wx0doc1ZZc41p8ZQ4J5cF3Q4ZpLWOC9ziMVbLJkHiBRRj+cFpeVeRhkg2QXEBN/G
         CWnVCqxa5KIRpyriGlLY9jloaTvicd9KPKJnzH/yUNxiSoJm4oq/q9onANMwmrpTNmxA
         Yzqj4CLLypH0fI6Ec/DMRCdC13S1gX7JtZ3d74Hy3IqmH4EhLZluqsSYsnJVVjotwll0
         iezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751934923; x=1752539723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wf3o4V2I80SyK6m01qE6WqU7O8JhAfMNmh4JIjwVcuk=;
        b=qjd9fEYMqkgJrnSCFEUdl3oGkS49RbodelenQeRR38W12THmlTaELPP9XiApKozIH6
         lVer4uKT0g0omuNkamAzCufEL98LvjXbm21EyrzrEk/kq6He3wr43QfMwPnx7nRPwzeC
         zDDTAEw2dPESpbvSrufSij14dQhGukO1Ni7CXh+HL6xBJLdP4sUGLPq8XB8v/4uJC6qH
         sAIdUu7ToRG17L777grmkSv0EOLRf9JhhsyhZqTa0tGjNIhoTqGYja0zSAOoc31m/JQI
         53UqBsO1qrDzh3h7LB+PJeQLP+x5E57lPx6InmC0mOp0QiQkvDLQfScyXGs2WWcR1ys6
         zQnA==
X-Forwarded-Encrypted: i=1; AJvYcCUNmpVVfQnCS/lPX4J8I7LHnAYg6d7jTXK6vkM5r6t/9aC27HyAj6zIwDAIUK93LZFrCxuu2yMOFfbqBXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdxLwxnC3a/devfjLvuFHsogWxZF0YKZBdQL4cZaBsCUWUBMv
	qMoOWXzAcXZ1VzpfVooJJ/gMWmfjtrl0opEmgzvO14PQIx8UGcK1v1ld
X-Gm-Gg: ASbGnctNPJmhSbfyugHc3bN4Ejrwoxiq+xoUkIUGZ6AS/b4YoqV849oifly+NmydzDN
	PvAZRympx5PzLwAz4hWDjqhTsRdPM7g3E2UQIsRznr6Ep/awHse3RXr9MvMnNAYVSDz0ncEE/Qu
	Aym4ngyb+e+3vCU3TdHv6aI5CFkth4ckAdkEXqAjcmzPOl8AfCSgDycWWjBoiQMK2xB6vPgWHf/
	/yUUZcI2aC0vsuxvsyTbAgS0CBlvdE7xerPFfO1Qx5NxaE6UpCIgdMNR8b57/8Pc2dxDYelWdjf
	OhBudJqHdbzPMwRlrlh+GylcigU0awrZGBgwidpcLepdaEouDAOzXkO06NDp3MRJ0Ww4/MIO67T
	aQv6O9pq09KTBTx40sFDTbKX0GrR/h+Yv4QLJJHo=
X-Google-Smtp-Source: AGHT+IH7TGLslieM/fqIp/Wft6U3ZL8rXycUBYC1okgKhh5EJ8jEKkIQXVGhccdpvcMVjtgDYb8ShQ==
X-Received: by 2002:a17:90b:5488:b0:311:fde5:c4b6 with SMTP id 98e67ed59e1d1-31aac432a9amr19372939a91.6.1751934923319;
        Mon, 07 Jul 2025 17:35:23 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:268b:48b1:88cf:6e90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21e8b48fsm518749a91.33.2025.07.07.17.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:35:22 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
Subject: [PATCH v3] ocfs2: avoid potential ABBA deadlock by reordering tl_inode lock
Date: Mon,  7 Jul 2025 20:35:19 -0400
Message-ID: <20250708003519.379597-1-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ocfs2_move_extent(), tl_inode is currently locked after the global
bitmap inode. However, in ocfs2_flush_truncate_log(), the lock order
is reversed: tl_inode is locked first, followed by the global bitmap
inode.

This creates a classic ABBA deadlock scenario if two threads attempt
these operations concurrently and acquire the locks in different orders.

To prevent this, move the tl_inode locking earlier in
ocfs2_move_extent(), so that it always precedes the global bitmap
inode lock.

No functional changes beyond lock ordering.

Reported-by: syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67d5645c.050a0220.1dc86f.0004.GAE@google.com/
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
v1 -> v2: Fixed unlocking order in ocfs2_move_extent.
v2 -> v3: Added missing out_unlock_tl_inode and renamed out_unlock_gb_mutex to
		  out_unlock_gb_inode and out_unlock_gb_inode to out_unlock.

 fs/ocfs2/move_extents.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 369c7d27befd..9d1fa8ecd97e 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -617,6 +617,8 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 	 */
 	credits += OCFS2_INODE_UPDATE_CREDITS + 1;
 
+	inode_lock(tl_inode);
+
 	/*
 	 * ocfs2_move_extent() didn't reserve any clusters in lock_allocators()
 	 * logic, while we still need to lock the global_bitmap.
@@ -626,7 +628,7 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 	if (!gb_inode) {
 		mlog(ML_ERROR, "unable to get global_bitmap inode\n");
 		ret = -EIO;
-		goto out;
+		goto out_unlock_tl_inode;
 	}
 
 	inode_lock(gb_inode);
@@ -634,16 +636,14 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 	ret = ocfs2_inode_lock(gb_inode, &gb_bh, 1);
 	if (ret) {
 		mlog_errno(ret);
-		goto out_unlock_gb_mutex;
+		goto out_unlock_gb_inode;
 	}
 
-	inode_lock(tl_inode);
-
 	handle = ocfs2_start_trans(osb, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		mlog_errno(ret);
-		goto out_unlock_tl_inode;
+		goto out_unlock;
 	}
 
 	new_phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, *new_phys_cpos);
@@ -703,13 +703,12 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 out_commit:
 	ocfs2_commit_trans(osb, handle);
 	brelse(gd_bh);
-
-out_unlock_tl_inode:
-	inode_unlock(tl_inode);
-
+out_unlock:
 	ocfs2_inode_unlock(gb_inode, 1);
-out_unlock_gb_mutex:
+out_unlock_gb_inode:
 	inode_unlock(gb_inode);
+out_unlock_tl_inode:
+	inode_unlock(tl_inode);
 	brelse(gb_bh);
 	iput(gb_inode);
 
-- 
2.45.2


