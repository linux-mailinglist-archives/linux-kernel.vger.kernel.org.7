Return-Path: <linux-kernel+bounces-881818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E217C28FEF
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A28324E4031
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544071E98E3;
	Sun,  2 Nov 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MkSiv9i8"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C3C1D516F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762091565; cv=none; b=tX+QdT6gEQbwo7l+r1tOmFfs/5WgjlRGX/rW1TllP5eHoKDLZYHGYNWf9HEs4B6yD6VhKu2N+OrQmMMCf6hIg5KOt5LCygoQbpyr5np/eMlDnVieAbcieh7ubbblK24yDrabBrJpY7iGmsAh2+iA8Kve52a6RFFx7IHjRR02/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762091565; c=relaxed/simple;
	bh=sGPegJZxKurwIlqvGnkXu+hdbBYFuaJqYOU3arj04C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVnMsFAeQth2NvRT6QPScI6EtOvHWIkww+OuyvE7MMjhFLXRDgvWPakhrd+l/1JsNO4EDRkb7S3OcMqeD5aSRZ65UHUHJEbNiOJ2g9/JqGSg/k6cXMlqufUIZL12OOHfaH5Uexk/A/W7QNNkQnF4yxn4QcH2AEwHHFxkIrEqSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MkSiv9i8; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 64859bc6-b7f3-11f0-9e68-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 64859bc6-b7f3-11f0-9e68-005056994fde;
	Sun, 02 Nov 2025 14:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=iMXDS6EEbmcIv85d3s2aOS2TASXo0WtPp2Dvmh6trto=;
	b=MkSiv9i8419Wnw90DBRW7X5eMqaU89pQo4xfxhOo0ZPSj6WUZeHe1XE5agY7UDOijQVsTgv4EBWxj
	 gYo36w0g9Y1vqwQzZBxMbt09iP5+v1Z2XQ6yPV9Mgw5ai4Je2W6rSCt+9TanGLwPfULlQZqck1IP2x
	 K67JKBQu1j24+0Vr05v4pvlGdpx+hokqyuZzwDks38lyKYtsVrLetHptkr9BoH5vgOsuvTd0remmrU
	 U92iFzbEHlbKCCeVvXm9/fkpsC2KUbHIG2KbR6/aO8x/Bi1yLU9CWf82yL6qan5uqTEr2NCCXF0rOe
	 7Fz2OC4CjEEYhMdD13+vksmPAV4S1Ug==
X-KPN-MID: 33|bvK11xaldxKLuWh3d8moBGPQekR3Ibj2WKm3ZXPjOg6J0j1m2CCNcduneIB4rU0
 U1i71ix+Gbyo/TZrjq+68VR0i0fgtoUSDH/UjDDaScLU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|y8Si2PA0QVjiueZ8/EMPg7gurfdZodplZ5TyvQ6BX5LSPEVzFjH9GqLjzrvX8u/
 3ntHQfPbab5GIITXz1BVCwA==
Received: from daedalus.home (unknown [178.231.20.253])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2eb486e0-b7f3-11f0-8d3e-00505699b758;
	Sun, 02 Nov 2025 14:52:34 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: [PATCH] Fix a drop_nlink warning in minix_rmdir
Date: Sun,  2 Nov 2025 14:52:39 +0100
Message-ID: <20251102135239.2203389-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot found a drop_nlink warning that is triggered by an easy to
detect nlink corruption of a directory. This patch adds a sanity check
to minix_rmdir to prevent the warning and instead return EFSCORRUPTED to
the caller.

The changes were tested using the syzbot reproducer as well as local
testing.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=4e49728ec1cbaf3b91d2
---
 fs/minix/minix.h |  2 ++
 fs/minix/namei.c | 26 ++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d54273c3c9ff..ce62cb61186d 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -168,4 +168,6 @@ static inline int minix_test_bit(int nr, const void *vaddr)
 
 #endif
 
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #endif /* FS_MINIX_H */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..a8d5a7e22b7b 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,15 +161,25 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
-
-	if (minix_empty_dir(inode)) {
-		err = minix_unlink(dir, dentry);
-		if (!err) {
-			inode_dec_link_count(dir);
-			inode_dec_link_count(inode);
-		}
+	int err = -EFSCORRUPTED;
+
+	if (dir->i_nlink <= 2) {
+		printk(KERN_CRIT "minix-fs error: directory inode has "
+		       "corrupted nlink");
+		goto out;
 	}
+
+	err = -ENOTEMPTY;
+	if (!minix_empty_dir(inode))
+		goto out;
+
+	err = minix_unlink(dir, dentry);
+	if (!err) {
+		inode_dec_link_count(dir);
+		inode_dec_link_count(inode);
+ 	}
+
+out:
 	return err;
 }
 
-- 
2.51.1.dirty


