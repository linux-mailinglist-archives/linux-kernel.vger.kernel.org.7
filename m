Return-Path: <linux-kernel+bounces-720795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD6AFC076
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DB116B024
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848242116E0;
	Tue,  8 Jul 2025 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRSglXtf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA7201269
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940413; cv=none; b=HzABOfI5EEh5aFZkp3NpSS7uhNwcgVsQHHSjDKgnumj3zrbvpFZlckVMlxDvHjZRfRlluJ88Q/NmRgl9hBcXoim9u1WRCOoXvz3DPLYgrIJazby4JJRpU4gNI+ReM2Pi+d0w6YxZ/K3ec/DKiKa9FUTnPkBbmPVt418mvT8kvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940413; c=relaxed/simple;
	bh=L5DxJjCF4AvHC97m/wvuitUzww2TvZmZwAfZxXkujFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h15l3HAf53bb+o4Yt/YMDw6zYFq5GUk1Z41DoTCp3GVL6V9G6UyyN1uSJPpn4XO4xnLhMclMFjWQjJ6VYJisqSleBcjpNwjzbkLeiKDYqhXVYnDRxaXfa3ZiazHhoqg/cwUBGM8TlKlky6Ha1aVzpD5Kc08RY246Qoo+1T7ukdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRSglXtf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234f17910d8so34011275ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 19:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751940412; x=1752545212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ILMkgNty9sxK9LcMlRaTbTzCGYHTSnyr/AOuJ+jorA=;
        b=RRSglXtfVZ2aDLcN1Fu6eM2kRZ9ukL4cTYOkuyMZAoFQeiHdH/9H8TNpqOmwu3uvul
         h9zskSxHvpil6iwmquOhU4wSwq6qyx+VS1l25e27s/kDM5450oT2nZs5o7n/re7b0RQg
         x/PGOBlKb2cFOx9/dv89uNLE8peYImfQCboUKvGN0xu6T3gfQi6VJs2tfieqDQ7H2AXo
         2KHry6+2eHg5aLbv+ic4gfxept1mkGLRPt67it92KA5dV7KY35tlOPP1e/CkA9UM98wO
         ubE7BCyUXk1AzbamVwObhnjqj8zv/I4SaZ3M371Zi3FXowxbZHDinIKhKB0xmOkHO0GV
         I9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751940412; x=1752545212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ILMkgNty9sxK9LcMlRaTbTzCGYHTSnyr/AOuJ+jorA=;
        b=Bc+5Hcvg9AXqdvoY7tfXulvttx2qPL/xEYA9Ga4wItRnCCu/TZ4V3q9Y9GLIIMUfpr
         DM5w0TBu7+EGVZ2z0ZFalfGkr861tLoOvFksur2DZ/K0Lw5jFJDFnUN5579U57tI9IxR
         R8+XmEz4MNfEpr9lbDDtmgISJY2/uXJgYyJRCZ9j5Tt9bzI5ANl6QLm449d58b7Yir8x
         reWYHPqUcaaN/yfkFCY/Jwc4v4tXGNFb+UfKsHnqVtTBNeVY5irFPXL7AXTFVV1nvSX2
         Brrwq4PlZ0YstnsVrmJJMQWLW7cCC6DxVGFA+n8vc+5dFoSqm+4OH3pX6ito2eFzL/fu
         yMbA==
X-Forwarded-Encrypted: i=1; AJvYcCV6oUcaEopHTWXdSYlNSrl/13NnM68e4g9funZjeDm+bEBr+hIrItJHE03DATRJI5DOXZIVnc3c/UCb4i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX260BIOi/+0MEp4QjGBnfR1x1bPTInjSy63b76Cd13qY+QTlF
	CjH0DTo56QmUEr0WJiiLbfH+Mx0goY14AmpcpQKxEiWDgXjOf0yJL3Ia
X-Gm-Gg: ASbGncv95wmQWMdoWKmgLsHh2l6KgsfRfJx+jW/sJpu1r0rJlZgFTN+fg5hZhYgPvxp
	XkBOe54KoKKvg+wFrdmkxE9NaOF7tZ00VGpbHdjs9ebbyJR9pbHoBLS7tfGtjXXHNCprF2SwDTY
	08JsJkgo7zei5o3DqHz5p8RZTduSmR5rNO2APBgdqI2dfLkcd6MB0L1Jq2jCavTfQUt5rdG87Nc
	FdVufRVL1IWJ5U4b2oi9MYt0Kz34ID9HUWj/rBnjQOuhDarbJyFIBIe93aXAXjqrcBBvuzpSVBR
	qDC5TD1MI+Jo+81+E+VwRE3RVtQ8PGet3yQzHaryCR4YwqKtZ+aRsGgVAxXgJfo6fivZw4B4wb0
	vIsJijcaEHohGHHy6/7z538wM5HonK1EGwXI/SI8DEGBq/RrIGA==
X-Google-Smtp-Source: AGHT+IFFeBIcfFyPDZPTCystE3GoMnqn3rykNXxu9sxmsJll+yUfFFESSK8pmNNRaJbOTpCSYfHQHA==
X-Received: by 2002:a17:903:17c6:b0:235:2799:61d with SMTP id d9443c01a7336-23dd0afa580mr22319425ad.33.1751940411628;
        Mon, 07 Jul 2025 19:06:51 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:7176:525f:68ef:22b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bdcf4sm102329245ad.246.2025.07.07.19.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 19:06:51 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
Subject: [PATCH v4] ocfs2: avoid potential ABBA deadlock by reordering tl_inode lock
Date: Mon,  7 Jul 2025 22:06:40 -0400
Message-ID: <20250708020640.387741-1-ipravdin.official@gmail.com>
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
v3 -> v4: Rearranged gb_inode cleanup.

 fs/ocfs2/move_extents.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 369c7d27befd..cbe2f8ed8897 100644
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
@@ -703,15 +703,14 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
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
 	brelse(gb_bh);
 	iput(gb_inode);
+out_unlock_tl_inode:
+	inode_unlock(tl_inode);
 
 out:
 	if (context->meta_ac) {
-- 
2.45.2


