Return-Path: <linux-kernel+bounces-761793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322BB1FE83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D86173557
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706B26A08C;
	Mon, 11 Aug 2025 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xcqhyHqk"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211425D535
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889972; cv=none; b=k1RjUkseIRSNZqSladsYYH8cLiF3hYt1EHmSLf9W24VAzUOQeAXlNxAgeBAvHxFfVwgH8dcFkZe4ik1wMG5Yvipn6td181ByTVXrk9vX8aXbsc8HCD2NdGb0H858U9TMrTniUtpIwgdzw2ybDpUENn73zwpdAWkP5L52Q6gElNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889972; c=relaxed/simple;
	bh=NNDGtBLpnRoQigFULzNfJgs80+9RGRJEtrbVf7zpZ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKQbuKrIh3JvLPHQP+82Fz/2eAa4voxs5tFet3Qt4/f1VMfykvpKY82tcBJ165cdtz5P8l9+APFroIrugpAnoZa8KCxy65p3vGhBofJT+dsUl8OngxskyNOlojc9uOWbNbHgogmHATX8hBoKi2gPUuDUiLYFd4vL49x1cFVHHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xcqhyHqk; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754889956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TIdC7jAQgd8cJ46AKFrFCkfnkGDYD5aUIIx17ql8cuI=;
	b=xcqhyHqkI91jlA+iYThKGWRbFwm5w0+OJ4nBb1Up2XQS6zeBBxyk28S7/B+2h8Xya5Yxk2
	H/sJMs5y7EkV8S08sCakQAIGFgGbIx3QZqGd0HVLyXJChVTfOUz9cm+NDfdP2CevsJl6mX
	TaI5krVFH5xpqDBUAf+osIaPoT/34Y8=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] fs: fix incorrect lflags value in the move_mount syscall
Date: Mon, 11 Aug 2025 13:24:26 +0800
Message-ID: <20250811052426.129188-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The lflags value used to look up from_path was overwritten by the one used
to look up to_path.

In other words, from_path was looked up with the wrong lflags value. Fix it.

Fixes: f9fde814de37 ("fs: support getname_maybe_null() in move_mount()")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 fs/namespace.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..43665cb6df28 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4551,20 +4551,13 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & MOVE_MOUNT_SET_GROUP)	mflags |= MNT_TREE_PROPAGATION;
 	if (flags & MOVE_MOUNT_BENEATH)		mflags |= MNT_TREE_BENEATH;
 
-	lflags = 0;
-	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
-	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
-	uflags = 0;
-	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
-	from_name = getname_maybe_null(from_pathname, uflags);
-	if (IS_ERR(from_name))
-		return PTR_ERR(from_name);
-
 	lflags = 0;
 	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+
 	uflags = 0;
 	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
+
 	to_name = getname_maybe_null(to_pathname, uflags);
 	if (IS_ERR(to_name))
 		return PTR_ERR(to_name);
@@ -4582,6 +4575,17 @@ SYSCALL_DEFINE5(move_mount,
 			return ret;
 	}
 
+	lflags = 0;
+	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
+	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+
+	uflags = 0;
+	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
+
+	from_name = getname_maybe_null(from_pathname, uflags);
+	if (IS_ERR(from_name))
+		return PTR_ERR(from_name);
+
 	if (!from_name && from_dfd >= 0) {
 		CLASS(fd_raw, f_from)(from_dfd);
 		if (fd_empty(f_from))
-- 
2.50.1


