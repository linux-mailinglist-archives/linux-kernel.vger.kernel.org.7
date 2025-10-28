Return-Path: <linux-kernel+bounces-873747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B56C149BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAAD34F5345
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2E0330D25;
	Tue, 28 Oct 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Qt+70qnz"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44D32D0F5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654205; cv=none; b=krWo9heGhvZyjp7uz8H+0ZTD5ktU2fXo+F9t7AmxBsPodw0pqejjqa+JZ6y2MxOOdY6Cvp2Vj46QNmkTXFcxfC7iQBELYbC/2O0UnGI1a2MJtT49NnpVnRQo7H3Hs7DyGA3rP/k1nn/yt0whDwU0RLWhT+D04xw/mC8YbvT0oGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654205; c=relaxed/simple;
	bh=AdBHzUMueDisWoT4DiQZoRD6FQQAdaL8JrSk6LazooU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1bMZQT0OoyFaumstN7jF49tbPxagAQhBPnRBqkuixU8nWE3xSQOXHLytcYl5CevXEvBTIn9z/8jFcRZk2FqctACy/VJzLAtItx/jMB2T8seJ4Y1Kh86Gsejpe5XFHHZKhFHnbXhTKBu+qGono5lAB6bP8K+inMYrmPgkMPh08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Qt+70qnz; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 17cc7e56-b3f9-11f0-b0b9-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 17cc7e56-b3f9-11f0-b0b9-00505699b430;
	Tue, 28 Oct 2025 13:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=6hGTw/im2BS7bu9qrR+TzihP9cldUdB2xJLe6OVfK1w=;
	b=Qt+70qnzIbi+vAWxXvUmZgk6AIfwztgT09mG/25KuJ4BlW41wOdAOAsgDPbedxwkGavK4yUDzUH1Q
	 xlCB1y/TbjqCV0M5ZUa6BJkAnYUppbtVGcZt+aJzOTRAYP5qujl1kzEA5mxzC+pM+tC8TMnYggHD6g
	 pPOzcH1bGsvlEJZ8bhFh+9PpgnoIuTQugJPWSqLHJeTbf7oatnY/iliPFtm8Otci1WwNAoT/5/pA71
	 zqvLU1qEHHRm0XZQjOM78VCMwWE6vjmNua3kAaIhAqq2/XcWIK5AOClqamTz1tspGfn2LJLKpt1BN5
	 9wQfVsIokHt6DeAz9dHbc/+Fqdgvs9Q==
X-KPN-MID: 33|p+RV6W9QzUQHX9Ar2UCHdRItZsgflKwRX4+wxlZPKivM5xakmPdp8vdQMLHvWvr
 PdTvI/YE04gcbwfY1aDdb3otk56Jqw+h4XZYbFH541gE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|r0IRAVaLQQnFj/6NHjVgNozaylTQSPecBpP7soA74NAdZH9CDh6nNtd0CMxyrId
 XyBkrkFuHj1HVvTjG83J4Eg==
Received: from daedalus.home (unknown [178.231.9.54])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id bbd9284a-b3f8-11f0-bff1-00505699772e;
	Tue, 28 Oct 2025 13:22:13 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Dave Kleikamp <shaggy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>,
	NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	jkoolstra@xs4all.nl,
	syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com
Subject: [PATCH] nlink overflow in jfs_rename
Date: Tue, 28 Oct 2025 13:22:12 +0100
Message-ID: <20251028122212.290745-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If nlink is maximal for a directory (-1) and inside that directory you
perform a rename for some child directory (not moving from the parent),
then the nlink of the first directory is first incremented and later
decremented. Normally this is fine, but when nlink = -1 this causes a
wrap around to 0, and then drop_nlink issues a warning.

After applying the patch syzbot no longer issues any warnings. I also
ran some basic fs tests to look for any regressions.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=9131ddfd7870623b719f
---
 fs/jfs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 65a218eba8fa..7879c049632b 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1228,7 +1228,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				jfs_err("jfs_rename: dtInsert returned -EIO");
 			goto out_tx;
 		}
-		if (S_ISDIR(old_ip->i_mode))
+		if (S_ISDIR(old_ip->i_mode) && old_dir != new_dir)
 			inc_nlink(new_dir);
 	}
 	/*
@@ -1244,7 +1244,9 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out_tx;
 	}
 	if (S_ISDIR(old_ip->i_mode)) {
-		drop_nlink(old_dir);
+		if (new_ip || old_dir != new_dir)
+			drop_nlink(old_dir);
+
 		if (old_dir != new_dir) {
 			/*
 			 * Change inode number of parent for moved directory
-- 
2.51.0


